Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EAC457590
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 18:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhKSRk0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 12:40:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:43135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236729AbhKSRk0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 19 Nov 2021 12:40:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214483883"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214483883"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 09:37:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="495948390"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Nov 2021 09:37:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 788A016A; Fri, 19 Nov 2021 19:37:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: Fix multi-line comment style
Date:   Fri, 19 Nov 2021 19:37:18 +0200
Message-Id: <20211119173718.52938-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
References: <20211119173718.52938-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

  /*
   * Fix multi-line comment style as in this short example. Pay attention
   * to the capitalization, period and starting line of the text.
   */

While at it, split the (supposedly short) description of couple of functions
to summary (short description) and (long) description.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 163 ++++++++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 72 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index dfa06103150e..65fabd0a67a5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -311,10 +311,10 @@ static void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
 	spin_unlock_irqrestore(&stats->lock, flags);
 }
 
-/* modalias support makes "modprobe $MODALIAS" new-style hotplug work,
+/*
+ * modalias support makes "modprobe $MODALIAS" new-style hotplug work,
  * and the sysfs version makes coldplug work too.
  */
-
 static const struct spi_device_id *spi_match_id(const struct spi_device_id *id, const char *name)
 {
 	while (id->name[0]) {
@@ -492,7 +492,8 @@ EXPORT_SYMBOL_GPL(__spi_register_driver);
 
 /*-------------------------------------------------------------------------*/
 
-/* SPI devices should normally not be created by SPI device drivers; that
+/*
+ * SPI devices should normally not be created by SPI device drivers; that
  * would make them board-specific.  Similarly with SPI controller drivers.
  * Device registration normally goes into like arch/.../mach.../board-YYY.c
  * with other readonly (flashable) information about mainboard devices.
@@ -508,8 +509,8 @@ static LIST_HEAD(spi_controller_list);
 
 /*
  * Used to protect add/del operation for board_info list and
- * spi_controller list, and their matching process
- * also used to protect object of type struct idr
+ * spi_controller list, and their matching process also used
+ * to protect object of type struct idr.
  */
 static DEFINE_MUTEX(board_lock);
 
@@ -616,7 +617,8 @@ static int __spi_add_device(struct spi_device *spi)
 	else if (ctlr->cs_gpios)
 		spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
 
-	/* Drivers may modify this initial i/o setup, but will
+	/*
+	 * Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
 	 */
@@ -710,7 +712,8 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	struct spi_device	*proxy;
 	int			status;
 
-	/* NOTE:  caller did any chip->bus_num checks necessary.
+	/*
+	 * NOTE:  caller did any chip->bus_num checks necessary.
 	 *
 	 * Also, unless we change the return value convention to use
 	 * error-or-pointer (not NULL-or-pointer), troubleshootability
@@ -878,7 +881,6 @@ static void *spi_res_alloc(struct spi_device *spi, spi_res_release_t release,
 /**
  * spi_res_free - free an spi resource
  * @res: pointer to the custom data of a resource
- *
  */
 static void spi_res_free(void *res)
 {
@@ -973,7 +975,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 					gpiod_set_value_cansleep(spi->cs_gpiod, activate);
 			} else {
 				/*
-				 * invert the enable line, as active low is
+				 * Invert the enable line, as active low is
 				 * default for SPI.
 				 */
 				gpio_set_value_cansleep(spi->cs_gpio, !enable);
@@ -1712,16 +1714,7 @@ static void spi_pump_messages(struct kthread_work *work)
 }
 
 /**
- * spi_take_timestamp_pre - helper for drivers to collect the beginning of the
- *			    TX timestamp for the requested byte from the SPI
- *			    transfer. The frequency with which this function
- *			    must be called (once per word, once for the whole
- *			    transfer, once per batch of words etc) is arbitrary
- *			    as long as the @tx buffer offset is greater than or
- *			    equal to the requested byte at the time of the
- *			    call. The timestamp is only taken once, at the
- *			    first such call. It is assumed that the driver
- *			    advances its @tx buffer pointer monotonically.
+ * spi_take_timestamp_pre - helper to collect the beginning of the TX timestamp
  * @ctlr: Pointer to the spi_controller structure of the driver
  * @xfer: Pointer to the transfer being timestamped
  * @progress: How many words (not bytes) have been transferred so far
@@ -1731,6 +1724,14 @@ static void spi_pump_messages(struct kthread_work *work)
  *	      spi_take_timestamp_post or otherwise system will crash.
  *	      WARNING: for fully predictable results, the CPU frequency must
  *	      also be under control (governor).
+ *
+ * This is a helper for drivers to collect the beginning of the TX timestamp
+ * for the requested byte from the SPI transfer. The frequency with which this
+ * function must be called (once per word, once for the whole transfer, once
+ * per batch of words etc) is arbitrary as long as the @tx buffer offset is
+ * greater than or equal to the requested byte at the time of the call. The
+ * timestamp is only taken once, at the first such call. It is assumed that
+ * the driver advances its @tx buffer pointer monotonically.
  */
 void spi_take_timestamp_pre(struct spi_controller *ctlr,
 			    struct spi_transfer *xfer,
@@ -1758,16 +1759,16 @@ void spi_take_timestamp_pre(struct spi_controller *ctlr,
 EXPORT_SYMBOL_GPL(spi_take_timestamp_pre);
 
 /**
- * spi_take_timestamp_post - helper for drivers to collect the end of the
- *			     TX timestamp for the requested byte from the SPI
- *			     transfer. Can be called with an arbitrary
- *			     frequency: only the first call where @tx exceeds
- *			     or is equal to the requested word will be
- *			     timestamped.
+ * spi_take_timestamp_post - helper to collect the end of the TX timestamp
  * @ctlr: Pointer to the spi_controller structure of the driver
  * @xfer: Pointer to the transfer being timestamped
  * @progress: How many words (not bytes) have been transferred so far
  * @irqs_off: If true, will re-enable IRQs and preemption for the local CPU.
+ *
+ * This is a helper for drivers to collect the end of the TX timestamp for
+ * the requested byte from the SPI transfer. Can be called with an arbitrary
+ * frequency: only the first call where @tx exceeds or is equal to the
+ * requested word will be timestamped.
  */
 void spi_take_timestamp_post(struct spi_controller *ctlr,
 			     struct spi_transfer *xfer,
@@ -1900,10 +1901,12 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
 
 	spi_unmap_msg(ctlr, mesg);
 
-	/* In the prepare_messages callback the spi bus has the opportunity to
-	 * split a transfer to smaller chunks.
-	 * Release splited transfers here since spi_map_msg is done on the
-	 * splited transfers.
+	/*
+	 * In the prepare_messages callback the SPI bus has the opportunity
+	 * to split a transfer to smaller chunks.
+	 *
+	 * Release the split transfers here since spi_map_msg() is done on
+	 * the split transfers.
 	 */
 	spi_res_release(ctlr, mesg);
 
@@ -2945,8 +2948,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (!ctlr->max_dma_len)
 		ctlr->max_dma_len = INT_MAX;
 
-	/* register the device, then userspace will see it.
-	 * registration fails if the bus ID is in use.
+	/*
+	 * Register the device, then userspace will see it.
+	 * Registration fails if the bus ID is in use.
 	 */
 	dev_set_name(&ctlr->dev, "spi%u", ctlr->bus_num);
 
@@ -3094,7 +3098,8 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	device_del(&ctlr->dev);
 
-	/* Release the last reference on the controller if its driver
+	/*
+	 * Release the last reference on the controller if its driver
 	 * has not yet been converted to devm_spi_alloc_master/slave().
 	 */
 	if (!ctlr->devm_allocated)
@@ -3212,16 +3217,18 @@ static struct spi_replaced_transfers *spi_replace_transfers(
 	/* init the replaced_transfers list */
 	INIT_LIST_HEAD(&rxfer->replaced_transfers);
 
-	/* assign the list_entry after which we should reinsert
+	/*
+	 * Assign the list_entry after which we should reinsert
 	 * the @replaced_transfers - it may be spi_message.messages!
 	 */
 	rxfer->replaced_after = xfer_first->transfer_list.prev;
 
 	/* remove the requested number of transfers */
 	for (i = 0; i < remove; i++) {
-		/* if the entry after replaced_after it is msg->transfers
+		/*
+		 * If the entry after replaced_after it is msg->transfers
 		 * then we have been requested to remove more transfers
-		 * than are in the list
+		 * than are in the list.
 		 */
 		if (rxfer->replaced_after->next == &msg->transfers) {
 			dev_err(&msg->spi->dev,
@@ -3237,15 +3244,17 @@ static struct spi_replaced_transfers *spi_replace_transfers(
 			return ERR_PTR(-EINVAL);
 		}
 
-		/* remove the entry after replaced_after from list of
-		 * transfers and add it to list of replaced_transfers
+		/*
+		 * Remove the entry after replaced_after from list of
+		 * transfers and add it to list of replaced_transfers.
 		 */
 		list_move_tail(rxfer->replaced_after->next,
 			       &rxfer->replaced_transfers);
 	}
 
-	/* create copy of the given xfer with identical settings
-	 * based on the first transfer to get removed
+	/*
+	 * Create copy of the given xfer with identical settings
+	 * based on the first transfer to get removed.
 	 */
 	for (i = 0; i < insert; i++) {
 		/* we need to run in reverse order */
@@ -3293,18 +3302,20 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 		return PTR_ERR(srt);
 	xfers = srt->inserted_transfers;
 
-	/* now handle each of those newly inserted spi_transfers
-	 * note that the replacements spi_transfers all are preset
+	/*
+	 * Now handle each of those newly inserted spi_transfers.
+	 * Note that the replacements spi_transfers all are preset
 	 * to the same values as *xferp, so tx_buf, rx_buf and len
 	 * are all identical (as well as most others)
 	 * so we just have to fix up len and the pointers.
 	 *
-	 * this also includes support for the depreciated
-	 * spi_message.is_dma_mapped interface
+	 * This also includes support for the depreciated
+	 * spi_message.is_dma_mapped interface.
 	 */
 
-	/* the first transfer just needs the length modified, so we
-	 * run it outside the loop
+	/*
+	 * The first transfer just needs the length modified, so we
+	 * run it outside the loop.
 	 */
 	xfers[0].len = min_t(size_t, maxsize, xfer[0].len);
 
@@ -3324,8 +3335,9 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 		xfers[i].len = min(maxsize, xfers[i].len - offset);
 	}
 
-	/* we set up xferp to the last entry we have inserted,
-	 * so that we skip those already split transfers
+	/*
+	 * We set up xferp to the last entry we have inserted,
+	 * so that we skip those already split transfers.
 	 */
 	*xferp = &xfers[count - 1];
 
@@ -3357,11 +3369,12 @@ int spi_split_transfers_maxsize(struct spi_controller *ctlr,
 	struct spi_transfer *xfer;
 	int ret;
 
-	/* iterate over the transfer_list,
+	/*
+	 * Iterate over the transfer_list,
 	 * but note that xfer is advanced to the last transfer inserted
 	 * to avoid checking sizes again unnecessarily (also xfer does
-	 * potentiall belong to a different list by the time the
-	 * replacement has happened
+	 * potentially belong to a different list by the time the
+	 * replacement has happened).
 	 */
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (xfer->len > maxsize) {
@@ -3422,8 +3435,8 @@ int spi_setup(struct spi_device *spi)
 	int		status;
 
 	/*
-	 * check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
-	 * are set at the same time
+	 * Check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
+	 * are set at the same time.
 	 */
 	if ((hweight_long(spi->mode &
 		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_NO_TX)) > 1) ||
@@ -3433,20 +3446,21 @@ int spi_setup(struct spi_device *spi)
 		"setup: can not select any two of dual, quad and no-rx/tx at the same time\n");
 		return -EINVAL;
 	}
-	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
-	 */
+	/* If it is SPI_3WIRE mode, DUAL and QUAD should be forbidden */
 	if ((spi->mode & SPI_3WIRE) && (spi->mode &
 		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
 		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
 		return -EINVAL;
-	/* help drivers fail *cleanly* when they need options
-	 * that aren't supported with their current controller
+	/*
+	 * Help drivers fail *cleanly* when they need options
+	 * that aren't supported with their current controller.
 	 * SPI_CS_WORD has a fallback software implementation,
 	 * so it is ignored here.
 	 */
 	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
 				 SPI_NO_TX | SPI_NO_RX);
-	/* nothing prevents from working with active-high CS in case if it
+	/*
+	 * Nothing prevents from working with active-high CS in case if it
 	 * is driven by GPIO.
 	 */
 	if (gpio_is_valid(spi->cs_gpio))
@@ -3568,7 +3582,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	if (list_empty(&message->transfers))
 		return -EINVAL;
 
-	/* If an SPI controller does not support toggling the CS line on each
+	/*
+	 * If an SPI controller does not support toggling the CS line on each
 	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
 	 * for the CS line, we can emulate the CS-per-word hardware function by
 	 * splitting transfers into one-word transfers and ensuring that
@@ -3598,7 +3613,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		}
 	}
 
-	/* Half-duplex links include original MicroWire, and ones with
+	/*
+	 * Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
 	 * either MOSI or MISO is missing.  They can also be caused by
 	 * software limitations.
@@ -3617,7 +3633,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		}
 	}
 
-	/**
+	/*
 	 * Set transfer bits_per_word and max speed as spi device default if
 	 * it is not set for this transfer.
 	 * Set transfer tx_nbits and rx_nbits as single transfer default
@@ -3643,7 +3659,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 		/*
 		 * SPI transfer length should be multiple of SPI word size
-		 * where SPI word size should be power-of-two multiple
+		 * where SPI word size should be power-of-two multiple.
 		 */
 		if (xfer->bits_per_word <= 8)
 			w_size = 1;
@@ -3664,7 +3680,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 			xfer->tx_nbits = SPI_NBITS_SINGLE;
 		if (xfer->rx_buf && !xfer->rx_nbits)
 			xfer->rx_nbits = SPI_NBITS_SINGLE;
-		/* check transfer tx/rx_nbits:
+		/*
+		 * Check transfer tx/rx_nbits:
 		 * 1. check the value matches one of single, dual and quad
 		 * 2. check tx/rx_nbits match the mode in spi_device
 		 */
@@ -3843,7 +3860,8 @@ static int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 
 /*-------------------------------------------------------------------------*/
 
-/* Utility methods for SPI protocol drivers, layered on
+/*
+ * Utility methods for SPI protocol drivers, layered on
  * top of the core.  Some other utility methods are defined as
  * inline functions.
  */
@@ -3871,7 +3889,8 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_sync);
 	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_sync);
 
-	/* If we're not using the legacy transfer method then we will
+	/*
+	 * If we're not using the legacy transfer method then we will
 	 * try to transfer in the calling context so special case.
 	 * This code would be less tricky if we could remove the
 	 * support for driver implemented message queues.
@@ -3889,9 +3908,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	}
 
 	if (status == 0) {
-		/* Push out the messages in the calling context if we
-		 * can.
-		 */
+		/* Push out the messages in the calling context if we can */
 		if (ctlr->transfer == spi_queued_transfer) {
 			SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics,
 						       spi_sync_immediate);
@@ -4052,7 +4069,8 @@ int spi_write_then_read(struct spi_device *spi,
 	struct spi_transfer	x[2];
 	u8			*local_buf;
 
-	/* Use preallocated DMA-safe buffer if we can.  We can't avoid
+	/*
+	 * Use preallocated DMA-safe buffer if we can. We can't avoid
 	 * copying here, (as a pure convenience thing), but we can
 	 * keep heap costs out of the hot path unless someone else is
 	 * using the pre-allocated buffer or the transfer is too large.
@@ -4288,11 +4306,12 @@ static int __init spi_init(void)
 	return status;
 }
 
-/* board_info is normally registered in arch_initcall(),
- * but even essential drivers wait till later
+/*
+ * A board_info is normally registered in arch_initcall(),
+ * but even essential drivers wait till later.
  *
- * REVISIT only boardinfo really needs static linking. the rest (device and
- * driver registration) _could_ be dynamically linked (modular) ... costs
+ * REVISIT only boardinfo really needs static linking. The rest (device and
+ * driver registration) _could_ be dynamically linked (modular) ... Costs
  * include needing to have boardinfo data structures be much more public.
  */
 postcore_initcall(spi_init);
-- 
2.33.0

