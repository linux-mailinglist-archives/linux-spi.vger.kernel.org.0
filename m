Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E7552AD5
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jun 2022 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbiFUGMs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jun 2022 02:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345602AbiFUGMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jun 2022 02:12:45 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE919F86
        for <linux-spi@vger.kernel.org>; Mon, 20 Jun 2022 23:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=gLZK2265Pd0i7MErC6G690atwVBOD3ajBYmbAdqlGCc=;
        b=l52um17zX+2C2Lp0aoJHbk6k2cgWvGImdEH11J1jPNdjJ05AQbJ7TKNLC3UHUwkyE1jIEwKmbVdFc
         DF1N67VFcAl1ni6Ltx9vT0kSQoQTttK/kO+31w/u7m3FlikzrdljQm0rcHkv3kaqkxIdmE/H0orFOl
         kl2/vTOVKvLPwcA4PKJD2cyClpiZK61rr1iOAcMLlTXFnx5xR3ugpTTiyeXrMR4nyfBPLDI2TxVxeo
         BLq5gUTpHIZEL6Sf3XNGgjjJ/7/2x2Uwk46Q3KLEc5oYPswWjdxfP1G2bZa2hnfyj8xxZ068FTEcSf
         Adf748949Qcon5FgJrA5AIvPA7zR9Zg==
X-MSG-ID: 25f52207-f129-11ec-8a45-0050569d11ae
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [PATCH v3 02/11] spi: Don't use the message queue if possible in spi_sync
Date:   Tue, 21 Jun 2022 08:12:25 +0200
Message-Id: <20220621061234.3626638-3-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220621061234.3626638-1-david@protonic.nl>
References: <20220621061234.3626638-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The interaction with the controller message queue and its corresponding
auxiliary flags and variables requires the use of the queue_lock which is
costly. Since spi_sync will transfer the complete message anyway, and not
return until it is finished, there is no need to put the message into the
queue if the queue is empty. This can save a lot of overhead.

As an example of how significant this is, when using the MCP2518FD SPI CAN
controller on a i.MX8MM SoC, the time during which the interrupt line
stays active (during 3 relatively short spi_sync messages), is reduced
from 98us to 72us by this patch.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c       | 246 ++++++++++++++++++++++++----------------
 include/linux/spi/spi.h |  11 +-
 2 files changed, 159 insertions(+), 98 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index eb6360153fa1..2d057d03c4f7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1549,6 +1549,80 @@ static void spi_idle_runtime_pm(struct spi_controller *ctlr)
 	}
 }
 
+static int __spi_pump_transfer_message(struct spi_controller *ctlr,
+		struct spi_message *msg, bool was_busy)
+{
+	struct spi_transfer *xfer;
+	int ret;
+
+	if (!was_busy && ctlr->auto_runtime_pm) {
+		ret = pm_runtime_get_sync(ctlr->dev.parent);
+		if (ret < 0) {
+			pm_runtime_put_noidle(ctlr->dev.parent);
+			dev_err(&ctlr->dev, "Failed to power device: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	if (!was_busy)
+		trace_spi_controller_busy(ctlr);
+
+	if (!was_busy && ctlr->prepare_transfer_hardware) {
+		ret = ctlr->prepare_transfer_hardware(ctlr);
+		if (ret) {
+			dev_err(&ctlr->dev,
+				"failed to prepare transfer hardware: %d\n",
+				ret);
+
+			if (ctlr->auto_runtime_pm)
+				pm_runtime_put(ctlr->dev.parent);
+
+			msg->status = ret;
+			spi_finalize_current_message(ctlr);
+
+			return ret;
+		}
+	}
+
+	trace_spi_message_start(msg);
+
+	if (ctlr->prepare_message) {
+		ret = ctlr->prepare_message(ctlr, msg);
+		if (ret) {
+			dev_err(&ctlr->dev, "failed to prepare message: %d\n",
+				ret);
+			msg->status = ret;
+			spi_finalize_current_message(ctlr);
+			return ret;
+		}
+		msg->prepared = true;
+	}
+
+	ret = spi_map_msg(ctlr, msg);
+	if (ret) {
+		msg->status = ret;
+		spi_finalize_current_message(ctlr);
+		return ret;
+	}
+
+	if (!ctlr->ptp_sts_supported && !ctlr->transfer_one) {
+		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+			xfer->ptp_sts_word_pre = 0;
+			ptp_read_system_prets(xfer->ptp_sts);
+		}
+	}
+
+	ret = ctlr->transfer_one_message(ctlr, msg);
+	if (ret) {
+		dev_err(&ctlr->dev,
+			"failed to transfer one message from queue\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * __spi_pump_messages - function which processes spi message queue
  * @ctlr: controller to process queue for
@@ -1564,7 +1638,6 @@ static void spi_idle_runtime_pm(struct spi_controller *ctlr)
  */
 static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 {
-	struct spi_transfer *xfer;
 	struct spi_message *msg;
 	bool was_busy = false;
 	unsigned long flags;
@@ -1599,6 +1672,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 			    !ctlr->unprepare_transfer_hardware) {
 				spi_idle_runtime_pm(ctlr);
 				ctlr->busy = false;
+				ctlr->queue_empty = true;
 				trace_spi_controller_idle(ctlr);
 			} else {
 				kthread_queue_work(ctlr->kworker,
@@ -1625,6 +1699,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 
 		spin_lock_irqsave(&ctlr->queue_lock, flags);
 		ctlr->idling = false;
+		ctlr->queue_empty = true;
 		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 		return;
 	}
@@ -1641,75 +1716,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
 	mutex_lock(&ctlr->io_mutex);
-
-	if (!was_busy && ctlr->auto_runtime_pm) {
-		ret = pm_runtime_resume_and_get(ctlr->dev.parent);
-		if (ret < 0) {
-			dev_err(&ctlr->dev, "Failed to power device: %d\n",
-				ret);
-			mutex_unlock(&ctlr->io_mutex);
-			return;
-		}
-	}
-
-	if (!was_busy)
-		trace_spi_controller_busy(ctlr);
-
-	if (!was_busy && ctlr->prepare_transfer_hardware) {
-		ret = ctlr->prepare_transfer_hardware(ctlr);
-		if (ret) {
-			dev_err(&ctlr->dev,
-				"failed to prepare transfer hardware: %d\n",
-				ret);
-
-			if (ctlr->auto_runtime_pm)
-				pm_runtime_put(ctlr->dev.parent);
-
-			msg->status = ret;
-			spi_finalize_current_message(ctlr);
-
-			mutex_unlock(&ctlr->io_mutex);
-			return;
-		}
-	}
-
-	trace_spi_message_start(msg);
-
-	if (ctlr->prepare_message) {
-		ret = ctlr->prepare_message(ctlr, msg);
-		if (ret) {
-			dev_err(&ctlr->dev, "failed to prepare message: %d\n",
-				ret);
-			msg->status = ret;
-			spi_finalize_current_message(ctlr);
-			goto out;
-		}
-		msg->prepared = true;
-	}
-
-	ret = spi_map_msg(ctlr, msg);
-	if (ret) {
-		msg->status = ret;
-		spi_finalize_current_message(ctlr);
-		goto out;
-	}
-
-	if (!ctlr->ptp_sts_supported && !ctlr->transfer_one) {
-		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-			xfer->ptp_sts_word_pre = 0;
-			ptp_read_system_prets(xfer->ptp_sts);
-		}
-	}
-
-	ret = ctlr->transfer_one_message(ctlr, msg);
-	if (ret) {
-		dev_err(&ctlr->dev,
-			"failed to transfer one message from queue: %d\n",
-			ret);
-		goto out;
-	}
-
-out:
+	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
 	mutex_unlock(&ctlr->io_mutex);
 
 	/* Prod the scheduler in case transfer_one() was busy waiting */
@@ -1839,6 +1846,7 @@ static int spi_init_queue(struct spi_controller *ctlr)
 {
 	ctlr->running = false;
 	ctlr->busy = false;
+	ctlr->queue_empty = true;
 
 	ctlr->kworker = kthread_create_worker(0, dev_name(&ctlr->dev));
 	if (IS_ERR(ctlr->kworker)) {
@@ -1936,11 +1944,20 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 
 	mesg->prepared = false;
 
-	spin_lock_irqsave(&ctlr->queue_lock, flags);
-	ctlr->cur_msg = NULL;
-	ctlr->fallback = false;
-	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
-	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
+	if (!mesg->sync) {
+		/*
+		 * This message was sent via the async message queue. Handle
+		 * the queue and kick the worker thread to do the
+		 * idling/shutdown or send the next message if needed.
+		 */
+		spin_lock_irqsave(&ctlr->queue_lock, flags);
+		WARN(ctlr->cur_msg != mesg,
+			"Finalizing queued message that is not the current head of queue!");
+		ctlr->cur_msg = NULL;
+		ctlr->fallback = false;
+		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
+		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
+	}
 
 	trace_spi_message_done(mesg);
 
@@ -2043,6 +2060,7 @@ static int __spi_queued_transfer(struct spi_device *spi,
 	msg->status = -EINPROGRESS;
 
 	list_add_tail(&msg->queue, &ctlr->queue);
+	ctlr->queue_empty = false;
 	if (!ctlr->busy && need_pump)
 		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 
@@ -3938,6 +3956,39 @@ static int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 
 }
 
+static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct spi_message *msg)
+{
+	bool was_busy;
+	int ret;
+
+	mutex_lock(&ctlr->io_mutex);
+
+	/* If another context is idling the device then wait */
+	while (ctlr->idling)
+		usleep_range(10000, 11000);
+
+	was_busy = READ_ONCE(ctlr->busy);
+
+	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
+	if (ret)
+		goto out;
+
+	if (!was_busy) {
+		kfree(ctlr->dummy_rx);
+		ctlr->dummy_rx = NULL;
+		kfree(ctlr->dummy_tx);
+		ctlr->dummy_tx = NULL;
+		if (ctlr->unprepare_transfer_hardware &&
+		    ctlr->unprepare_transfer_hardware(ctlr))
+			dev_err(&ctlr->dev,
+				"failed to unprepare transfer hardware\n");
+		spi_idle_runtime_pm(ctlr);
+	}
+
+out:
+	mutex_unlock(&ctlr->io_mutex);
+}
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -3956,51 +4007,52 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	DECLARE_COMPLETION_ONSTACK(done);
 	int status;
 	struct spi_controller *ctlr = spi->controller;
-	unsigned long flags;
 
 	status = __spi_validate(spi, message);
 	if (status != 0)
 		return status;
 
-	message->complete = spi_complete;
-	message->context = &done;
 	message->spi = spi;
 
 	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync);
 	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_sync);
 
 	/*
-	 * If we're not using the legacy transfer method then we will
-	 * try to transfer in the calling context so special case.
-	 * This code would be less tricky if we could remove the
-	 * support for driver implemented message queues.
+	 * Checking queue_empty here only guarantees async/sync message
+	 * ordering when coming from the same context. It does not need to
+	 * guard against reentrancy from a different context. The io_mutex
+	 * will catch those cases.
 	 */
-	if (ctlr->transfer == spi_queued_transfer) {
-		spin_lock_irqsave(&ctlr->bus_lock_spinlock, flags);
+	if (READ_ONCE(ctlr->queue_empty)) {
+		message->sync = true;
+		message->actual_length = 0;
+		message->status = -EINPROGRESS;
 
 		trace_spi_message_submit(message);
 
-		status = __spi_queued_transfer(spi, message, false);
+		SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync_immediate);
+		SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_sync_immediate);
 
-		spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
-	} else {
-		status = spi_async_locked(spi, message);
+		__spi_transfer_message_noqueue(ctlr, message);
+
+		return message->status;
 	}
 
+	/*
+	 * There are messages in the async queue that could have originated
+	 * from the same context, so we need to preserve ordering.
+	 * Therefor we send the message to the async queue and wait until they
+	 * are completed.
+	 */
+	message->complete = spi_complete;
+	message->context = &done;
+	status = spi_async_locked(spi, message);
 	if (status == 0) {
-		/* Push out the messages in the calling context if we can */
-		if (ctlr->transfer == spi_queued_transfer) {
-			SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics,
-						       spi_sync_immediate);
-			SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics,
-						       spi_sync_immediate);
-			__spi_pump_messages(ctlr, false);
-		}
-
 		wait_for_completion(&done);
 		status = message->status;
 	}
 	message->context = NULL;
+
 	return status;
 }
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 1a75c26742f2..74261a83b5fa 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -461,6 +461,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @irq_flags: Interrupt enable state during PTP system timestamping
  * @fallback: fallback to pio if dma transfer return failure with
  *	SPI_TRANS_FAIL_NO_START.
+ * @queue_empty: signal green light for opportunistically skipping the queue
+ *	for spi_sync transfers.
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -677,6 +679,9 @@ struct spi_controller {
 
 	/* Interrupt enable state during PTP system timestamping */
 	unsigned long		irq_flags;
+
+	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
+	bool			queue_empty;
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
@@ -986,6 +991,7 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the spi message is processed
  * @prepared: spi_prepare_message was called for the this message
+ * @sync: this message took the direct sync path skipping the async queue
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1037,7 +1043,10 @@ struct spi_message {
 	struct list_head        resources;
 
 	/* spi_prepare_message was called for this message */
-	bool                    prepared;
+	bool			prepared;
+
+	/* this message is skipping the async queue */
+	bool			sync;
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
-- 
2.32.0

