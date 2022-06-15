Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10DA54C8E2
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbiFOMrx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348511AbiFOMrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 08:47:48 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C4E003
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 05:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=sTyj/g7vMjUKwofVqknJ3ZBfE1RGq7JZW5LoUBnzr1g=;
        b=hmNbLc02/gJa8WmP5S3ebsbBO1TwKpgRHQk4/ZgqbCQuFca18zEhRDuJsD4YJfnRu0EGI4oasQWHN
         +D5rctkl2msDYsjdDdyIoGQMNS9T5xryDsm721UdAVOeM/+z/Hq95TUbTyBTg/mmA7AZv5eFT/KIyx
         z//BoDGh5BYcuo1K5/k7DRzeceO7tkhsbDtAIM+WAdVkOgoYN5WSwKX2pSPaSF37BumHawn8OXkmWT
         i2TJ7n6bwXWr+kdx6OdyAq4OEUtMx8LXl1NnTLhz38Zai+7iETSBL4NB2wZdVTA7cqT25hSUSEsf0Z
         WEczSuntLWBGhdty+vCkPMmSCdxikIA==
X-MSG-ID: 53bf1ed8-eca9-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>, David Jander <david@protonic.nl>
Subject: [RFC] [PATCH v2 10/11] spi: Ensure the io_mutex is held until spi_finalize_current_message()
Date:   Wed, 15 Jun 2022 14:46:33 +0200
Message-Id: <20220615124634.3302867-11-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220615124634.3302867-1-david@protonic.nl>
References: <20220615124634.3302867-1-david@protonic.nl>
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

This patch introduces a completion that is completed in
spi_finalize_current_message() and waited for in
__spi_pump_transfer_message(). This way all manipulation of ctlr->cur_msg
is done with the io_mutex held and strictly ordered:
__spi_pump_transfer_message() will not return until
spi_finalize_current_message() is done using ctlr->cur_msg, and its
calling context is only touching ctlr->cur_msg after returning.
Due to this, we can safely drop the spin-locks around ctlr->cur_msg.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c       | 32 ++++++++++++++------------------
 include/linux/spi/spi.h |  6 ++----
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3df84f43918c..db08cb868652 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1613,11 +1613,14 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 		}
 	}
 
+	reinit_completion(&ctlr->cur_msg_completion);
 	ret = ctlr->transfer_one_message(ctlr, msg);
 	if (ret) {
 		dev_err(&ctlr->dev,
 			"failed to transfer one message from queue\n");
 		return ret;
+	} else {
+		wait_for_completion(&ctlr->cur_msg_completion);
 	}
 
 	return 0;
@@ -1704,6 +1707,12 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
+
+	if (!ret)
+		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
+	ctlr->cur_msg = NULL;
+	ctlr->fallback = false;
+
 	mutex_unlock(&ctlr->io_mutex);
 
 	/* Prod the scheduler in case transfer_one() was busy waiting */
@@ -1897,12 +1906,9 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 {
 	struct spi_transfer *xfer;
 	struct spi_message *mesg;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&ctlr->queue_lock, flags);
 	mesg = ctlr->cur_msg;
-	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
 	if (!ctlr->ptp_sts_supported && !ctlr->transfer_one) {
 		list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
@@ -1936,20 +1942,7 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 
 	mesg->prepared = false;
 
-	if (!mesg->sync) {
-		/*
-		 * This message was sent via the async message queue. Handle
-		 * the queue and kick the worker thread to do the
-		 * idling/shutdown or send the next message if needed.
-		 */
-		spin_lock_irqsave(&ctlr->queue_lock, flags);
-		WARN(ctlr->cur_msg != mesg,
-			"Finalizing queued message that is not the current head of queue!");
-		ctlr->cur_msg = NULL;
-		ctlr->fallback = false;
-		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
-		spin_unlock_irqrestore(&ctlr->queue_lock, flags);
-	}
+	complete(&ctlr->cur_msg_completion);
 
 	trace_spi_message_done(mesg);
 
@@ -3036,6 +3029,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 	}
 	ctlr->bus_lock_flag = 0;
 	init_completion(&ctlr->xfer_completion);
+	init_completion(&ctlr->cur_msg_completion);
 	if (!ctlr->max_dma_len)
 		ctlr->max_dma_len = INT_MAX;
 
@@ -3962,6 +3956,9 @@ static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct s
 	if (ret)
 		goto out;
 
+	ctlr->cur_msg = NULL;
+	ctlr->fallback = false;
+
 	if (!was_busy) {
 		kfree(ctlr->dummy_rx);
 		ctlr->dummy_rx = NULL;
@@ -4013,7 +4010,6 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	 * will catch those cases.
 	 */
 	if (READ_ONCE(ctlr->queue_empty)) {
-		message->sync = true;
 		message->actual_length = 0;
 		message->status = -EINPROGRESS;
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c58f46be762f..c56e0d240a58 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -384,6 +384,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @queue_lock: spinlock to syncronise access to message queue
  * @queue: message queue
  * @cur_msg: the currently in-flight message
+ * @cur_msg_completion: a completion for the current in-flight message
  * @cur_msg_mapped: message has been mapped for DMA
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
  *           selected
@@ -615,6 +616,7 @@ struct spi_controller {
 	spinlock_t			queue_lock;
 	struct list_head		queue;
 	struct spi_message		*cur_msg;
+	struct completion               cur_msg_completion;
 	bool				busy;
 	bool				running;
 	bool				rt;
@@ -989,7 +991,6 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @resources: for resource management when the spi message is processed
  * @prepared: spi_prepare_message was called for the this message
- * @sync: this message took the direct sync path skipping the async queue
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1042,9 +1043,6 @@ struct spi_message {
 
 	/* spi_prepare_message was called for this message */
 	bool			prepared;
-
-	/* this message is skipping the async queue */
-	bool			sync;
 };
 
 static inline void spi_message_init_no_memset(struct spi_message *m)
-- 
2.32.0

