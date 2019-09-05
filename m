Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9BA97CF
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 03:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfIEBIC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Sep 2019 21:08:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45485 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIEBIA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Sep 2019 21:08:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id l16so645246wrv.12;
        Wed, 04 Sep 2019 18:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFoCl/MgsswnRC2M32JRDOgiorNoXCIOHWB0wFwXcBw=;
        b=nWsPfS8UX32nRnYXA5xu0T2O5T1e247CYj8glANsnsQmqHLVx88L9Cw04jormiF33q
         K6nwDbDRYtLCcugJ8q6tB1OXeK8mE7x3h8PisgGGN+qJvjjNMDt4CSzxPbLMAcB9ZJKy
         gXuBmvOLTv2X/zM+xRJCCsAdFO1eAiCF3Ds10JkIQI02cf5nLQd629DPWStT5+X8WZtF
         TtkRJ3aO83pxuCyZx10TLuc9/BKNGDWHi8wvBIQBo4fjzvrlWfckpiIlOYy+lN85FoeC
         sZPtzQxkTgZzRd6KQu6gsPjvIH2M+8eut4jWgNbV9rsX6IwfR9Pj0YXIrwpFb6e9AV1c
         IFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFoCl/MgsswnRC2M32JRDOgiorNoXCIOHWB0wFwXcBw=;
        b=slBXLbKsEve8MIf8i9Zz6daFQNZlGVxK+hldSjUyn/hJe08l7a12N3hI6TtFHMknGd
         FPsdVPng+8cOrTuUqTBZPAnYlfuf0BehkuKosNuIfLO1flrXTsX+zwp7b0AaZpy5obi2
         nUYAORnUzI2xx4azyiSvw4arJtWeKJodrPBHHkXANwovRjIlbZrE8beIytWVaIE4GElI
         5hqNEFXKprFxUbSeHrCmrZ3wSPWxknjOErkZtUjk717GUft30HLXaHhe4d6J8y+nPaMg
         R/Xya9qalnF1srVwXs/IeQuA8mwWZHlQIi71fuP1KWlwNaf5m17Z+D6YVuJPQRoavu0F
         TdvA==
X-Gm-Message-State: APjAAAVKsM7qhi+bjz/QEoY7DjcAmP5j3aGostU6UqzEz6OtMlI2fE4+
        xJiYk3zzLwD18g+4Vb4Jo4Q=
X-Google-Smtp-Source: APXvYqziU/rF+Q/zqYcUeQnDCKd214hsky/oFcFRoibMbEwVjL6VJ/erYhQ5kSACCKWaaEnG1kV1tg==
X-Received: by 2002:adf:e750:: with SMTP id c16mr332254wrn.199.1567645678030;
        Wed, 04 Sep 2019 18:07:58 -0700 (PDT)
Received: from localhost.localdomain ([86.126.25.232])
        by smtp.gmail.com with ESMTPSA id b15sm670125wmb.28.2019.09.04.18.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 18:07:57 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org, h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 2/4] spi: Add a PTP system timestamp to the transfer structure
Date:   Thu,  5 Sep 2019 04:01:12 +0300
Message-Id: <20190905010114.26718-3-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190905010114.26718-1-olteanv@gmail.com>
References: <20190905010114.26718-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI is one of the interfaces used to access devices which have a POSIX
clock driver (real time clocks, 1588 timers etc). The fact that the SPI
bus is slow is not what the main problem is, but rather the fact that
drivers don't take a constant amount of time in transferring data over
SPI. When there is a high delay in the readout of time, there will be
uncertainty in the value that has been read out of the peripheral.
When that delay is constant, the uncertainty can at least be
approximated with a certain accuracy which is fine more often than not.

Timing jitter occurs all over in the kernel code, and is mainly caused
by having to let go of the CPU for various reasons such as preemption,
servicing interrupts, going to sleep, etc. Another major reason is CPU
dynamic frequency scaling.

It turns out that the problem of retrieving time from a SPI peripheral
with high accuracy can be solved by the use of "PTP system
timestamping" - a mechanism to correlate the time when the device has
snapshotted its internal time counter with the Linux system time at that
same moment. This is sufficient for having a precise time measurement -
it is not necessary for the whole SPI transfer to be transmitted "as
fast as possible", or "as low-jitter as possible". The system has to be
low-jitter for a very short amount of time to be effective.

This patch introduces a PTP system timestamping mechanism in struct
spi_transfer. This is to be used by SPI device drivers when they need to
know the exact time at which the underlying device's time was
snapshotted. More often than not, SPI peripherals have a very exact
timing for when their SPI-to-interconnect bridge issues a transaction
for snapshotting and reading the time register, and that will be
dependent on when the SPI-to-interconnect bridge figures out that this
is what it should do, aka as soon as it sees byte N of the SPI transfer.
Since spi_device drivers are the ones who'd know best how the peripheral
behaves in this regard, expose a mechanism in spi_transfer which allows
them to specify which word (or word range) from the transfer should be
timestamped.

Add a default implementation of the PTP system timestamping in the SPI
core. This is not going to be satisfactory performance-wise, but should
at least increase the likelihood that SPI device drivers will use PTP
system timestamping in the future.
There are 3 entry points from the core towards the SPI controller
drivers:

- transfer_one: The driver is passed individual spi_transfers to
  execute. This is the easiest to timestamp.

- transfer_one_message: The core passes the driver an entire spi_message
  (a potential batch of spi_transfers). The core puts the same pre and
  post timestamp to all transfers within a message. This is not ideal,
  but nothing better can be done by default anyway, since the core has
  no insight into how the driver batches the transfers.

- transfer: Like transfer_one_message, but for unqueued drivers (i.e.
  the driver implements its own queue scheduling).

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
Changes in v2:
- Added even more helpful helper functions: spi_take_timestamp_pre and
  spi_take_timestamp_pre, that drivers can simply call without keeping
  any state themselves.
- Updated comments and commit message.

 drivers/spi/spi.c       | 127 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  61 +++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9ce86f761763..bfc1f1e7ae12 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1171,6 +1171,11 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		spi_statistics_add_transfer_stats(statm, xfer, ctlr);
 		spi_statistics_add_transfer_stats(stats, xfer, ctlr);
 
+		if (!ctlr->ptp_sts_supported) {
+			xfer->ptp_sts_word_pre = 0;
+			ptp_read_system_prets(xfer->ptp_sts);
+		}
+
 		if (xfer->tx_buf || xfer->rx_buf) {
 			reinit_completion(&ctlr->xfer_completion);
 
@@ -1197,6 +1202,11 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 					xfer->len);
 		}
 
+		if (!ctlr->ptp_sts_supported) {
+			ptp_read_system_postts(xfer->ptp_sts);
+			xfer->ptp_sts_word_post = xfer->len;
+		}
+
 		trace_spi_transfer_stop(msg, xfer);
 
 		if (msg->status != -EINPROGRESS)
@@ -1265,6 +1275,7 @@ EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
  */
 static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 {
+	struct spi_transfer *xfer;
 	struct spi_message *msg;
 	bool was_busy = false;
 	unsigned long flags;
@@ -1391,6 +1402,13 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
 		goto out;
 	}
 
+	if (!ctlr->ptp_sts_supported && !ctlr->transfer_one) {
+		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+			xfer->ptp_sts_word_pre = 0;
+			ptp_read_system_prets(xfer->ptp_sts);
+		}
+	}
+
 	ret = ctlr->transfer_one_message(ctlr, msg);
 	if (ret) {
 		dev_err(&ctlr->dev,
@@ -1418,6 +1436,99 @@ static void spi_pump_messages(struct kthread_work *work)
 	__spi_pump_messages(ctlr, true);
 }
 
+/**
+ * spi_take_timestamp_pre - helper for drivers to collect the beginning of the
+ *			    TX timestamp for the requested byte from the SPI
+ *			    transfer. The frequency with which this function
+ *			    must be called (once per word, once for the whole
+ *			    transfer, once per batch of words etc) is arbitrary
+ *			    as long as the @tx buffer offset is greater than or
+ *			    equal to the requested byte at the time of the
+ *			    call. The timestamp is only taken once, at the
+ *			    first such call. It is assumed that the driver
+ *			    advances its @tx buffer pointer monotonically.
+ * @ctlr: Pointer to the spi_controller structure of the driver
+ * @xfer: Pointer to the transfer being timestamped
+ * @tx: Pointer to the current word within the xfer->tx_buf that the driver is
+ *	preparing to transmit right now.
+ * @irqs_off: If true, will disable IRQs and preemption for the duration of the
+ *	      transfer, for less jitter in time measurement. Only compatible
+ *	      with PIO drivers. If true, must follow up with
+ *	      spi_take_timestamp_post or otherwise system will crash.
+ *	      WARNING: for fully predictable results, the CPU frequency must
+ *	      also be under control (governor).
+ */
+void spi_take_timestamp_pre(struct spi_controller *ctlr,
+			    struct spi_transfer *xfer,
+			    const void *tx, bool irqs_off)
+{
+	u8 bytes_per_word = DIV_ROUND_UP(xfer->bits_per_word, 8);
+
+	if (!xfer->ptp_sts)
+		return;
+
+	if (xfer->timestamped_pre)
+		return;
+
+	if (tx < (xfer->tx_buf + xfer->ptp_sts_word_pre * bytes_per_word))
+		return;
+
+	/* Capture the resolution of the timestamp */
+	xfer->ptp_sts_word_pre = (tx - xfer->tx_buf) / bytes_per_word;
+
+	xfer->timestamped_pre = true;
+
+	if (irqs_off) {
+		local_irq_save(ctlr->irq_flags);
+		preempt_disable();
+	}
+
+	ptp_read_system_prets(xfer->ptp_sts);
+}
+EXPORT_SYMBOL_GPL(spi_take_timestamp_pre);
+
+/**
+ * spi_take_timestamp_post - helper for drivers to collect the end of the
+ *			     TX timestamp for the requested byte from the SPI
+ *			     transfer. Can be called with an arbitrary
+ *			     frequency: only the first call where @tx exceeds
+ *			     or is equal to the requested word will be
+ *			     timestamped.
+ * @ctlr: Pointer to the spi_controller structure of the driver
+ * @xfer: Pointer to the transfer being timestamped
+ * @tx: Pointer to the current word within the xfer->tx_buf that the driver has
+ *	just transmitted.
+ * @irqs_off: If true, will re-enable IRQs and preemption for the local CPU.
+ */
+void spi_take_timestamp_post(struct spi_controller *ctlr,
+			     struct spi_transfer *xfer,
+			     const void *tx, bool irqs_off)
+{
+	u8 bytes_per_word = DIV_ROUND_UP(xfer->bits_per_word, 8);
+
+	if (!xfer->ptp_sts)
+		return;
+
+	if (xfer->timestamped_post)
+		return;
+
+	if (tx < (xfer->tx_buf + xfer->ptp_sts_word_post * bytes_per_word))
+		return;
+
+	ptp_read_system_postts(xfer->ptp_sts);
+
+	if (irqs_off) {
+		local_irq_restore(ctlr->irq_flags);
+		preempt_enable();
+	}
+
+	/* Capture the resolution of the timestamp */
+	xfer->ptp_sts_word_post = (tx - xfer->tx_buf) / bytes_per_word;
+
+	xfer->timestamped_post = true;
+}
+EXPORT_SYMBOL_GPL(spi_take_timestamp_post);
+
 /**
  * spi_set_thread_rt - set the controller to pump at realtime priority
  * @ctlr: controller to boost priority of
@@ -1503,6 +1614,7 @@ EXPORT_SYMBOL_GPL(spi_get_next_queued_message);
  */
 void spi_finalize_current_message(struct spi_controller *ctlr)
 {
+	struct spi_transfer *xfer;
 	struct spi_message *mesg;
 	unsigned long flags;
 	int ret;
@@ -1511,6 +1623,13 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 	mesg = ctlr->cur_msg;
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
+	if (!ctlr->ptp_sts_supported && !ctlr->transfer_one) {
+		list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
+			ptp_read_system_postts(xfer->ptp_sts);
+			xfer->ptp_sts_word_post = xfer->len;
+		}
+	}
+
 	spi_unmap_msg(ctlr, mesg);
 
 	if (ctlr->cur_msg_prepared && ctlr->unprepare_message) {
@@ -3271,6 +3390,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 static int __spi_async(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
+	struct spi_transfer *xfer;
 
 	/*
 	 * Some controllers do not support doing regular SPI transfers. Return
@@ -3286,6 +3406,13 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 
 	trace_spi_message_submit(message);
 
+	if (!ctlr->ptp_sts_supported) {
+		list_for_each_entry(xfer, &message->transfers, transfer_list) {
+			xfer->ptp_sts_word_pre = 0;
+			ptp_read_system_prets(xfer->ptp_sts);
+		}
+	}
+
 	return ctlr->transfer(spi, message);
 }
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af4f265d0f67..27f6b046cf92 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -13,6 +13,7 @@
 #include <linux/completion.h>
 #include <linux/scatterlist.h>
 #include <linux/gpio/consumer.h>
+#include <linux/ptp_clock_kernel.h>
 
 struct dma_chan;
 struct property_entry;
@@ -409,6 +410,12 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @fw_translate_cs: If the boot firmware uses different numbering scheme
  *	what Linux expects, this optional hook can be used to translate
  *	between the two.
+ * @ptp_sts_supported: If the driver sets this to true, it must provide a
+ *	time snapshot in @spi_transfer->ptp_sts as close as possible to the
+ *	moment in time when @spi_transfer->ptp_sts_word_pre and
+ *	@spi_transfer->ptp_sts_word_post were transmitted.
+ *	If the driver does not set this, the SPI core takes the snapshot as
+ *	close to the driver hand-over as possible.
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -604,6 +611,15 @@ struct spi_controller {
 	void			*dummy_tx;
 
 	int (*fw_translate_cs)(struct spi_controller *ctlr, unsigned cs);
+
+	/*
+	 * Driver sets this field to indicate it is able to snapshot SPI
+	 * transfers (needed e.g. for reading the time of POSIX clocks)
+	 */
+	bool			ptp_sts_supported;
+
+	/* Interrupt enable state during PTP system timestamping */
+	unsigned long		irq_flags;
 };
 
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
@@ -644,6 +660,14 @@ extern struct spi_message *spi_get_next_queued_message(struct spi_controller *ct
 extern void spi_finalize_current_message(struct spi_controller *ctlr);
 extern void spi_finalize_current_transfer(struct spi_controller *ctlr);
 
+/* Helper calls for driver to timestamp transfer */
+void spi_take_timestamp_pre(struct spi_controller *ctlr,
+			    struct spi_transfer *xfer,
+			    const void *tx, bool irqs_off);
+void spi_take_timestamp_post(struct spi_controller *ctlr,
+			     struct spi_transfer *xfer,
+			     const void *tx, bool irqs_off);
+
 /* the spi driver core manages memory for the spi_controller classdev */
 extern struct spi_controller *__spi_alloc_controller(struct device *host,
 						unsigned int size, bool slave);
@@ -753,6 +777,35 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
+ * @ptp_sts_word_pre: The word (subject to bits_per_word semantics) offset
+ *	within @tx_buf for which the SPI device is requesting that the time
+ *	snapshot for this transfer begins. Upon completing the SPI transfer,
+ *	this value may have changed compared to what was requested, depending
+ *	on the available snapshotting resolution (DMA transfer,
+ *	@ptp_sts_supported is false, etc).
+ * @ptp_sts_word_post: See @ptp_sts_word_post. The two can be equal (meaning
+ *	that a single byte should be snapshotted).
+ *	If the core takes care of the timestamp (if @ptp_sts_supported is false
+ *	for this controller), it will set @ptp_sts_word_pre to 0, and
+ *	@ptp_sts_word_post to the length of the transfer. This is done
+ *	purposefully (instead of setting to spi_transfer->len - 1) to denote
+ *	that a transfer-level snapshot taken from within the driver may still
+ *	be of higher quality.
+ * @ptp_sts: Pointer to a memory location held by the SPI slave device where a
+ *	PTP system timestamp structure may lie. If drivers use PIO or their
+ *	hardware has some sort of assist for retrieving exact transfer timing,
+ *	they can (and should) assert @ptp_sts_supported and populate this
+ *	structure using the ptp_read_system_*ts helper functions.
+ *	The timestamp must represent the time at which the SPI slave device has
+ *	processed the word, i.e. the "pre" timestamp should be taken before
+ *	transmitting the "pre" word, and the "post" timestamp after receiving
+ *	transmit confirmation from the controller for the "post" word.
+ * @timestamped_pre: Set by the SPI controller driver to denote it has acted
+ *	upon the @ptp_sts request. Not set when the SPI core has taken care of
+ *	the task. SPI device drivers are free to print a warning if this comes
+ *	back unset and they need the better resolution.
+ * @timestamped_post: See above. The reason why both exist is that these
+ *	booleans are also used to keep state in the core SPI logic.
  *
  * SPI transfers always write the same number of bytes as they read.
  * Protocol drivers should always provide @rx_buf and/or @tx_buf.
@@ -842,6 +895,14 @@ struct spi_transfer {
 
 	u32		effective_speed_hz;
 
+	unsigned int	ptp_sts_word_pre;
+	unsigned int	ptp_sts_word_post;
+
+	struct ptp_system_timestamp *ptp_sts;
+
+	bool		timestamped_pre;
+	bool		timestamped_post;
+
 	struct list_head transfer_list;
 };
 
-- 
2.17.1

