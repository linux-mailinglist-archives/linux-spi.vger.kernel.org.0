Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B10560294
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiF2OZi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiF2OZf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 10:25:35 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1721267
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
         subject:cc:to:from:from;
        bh=ryKvX550lfS19tT2nihS0hrb5BOqWyVxHeYwsjvaxko=;
        b=Eb/9wwAfOvq1XOTWDFJu9p8o/ID9HDa74wPLoA/8vF98zcNl4dSKVYGAcleBhK/xkXuWqUC8e0FQN
         8zQPv/EjG6yuQ5ZeDbzAvLywnF7oor7Ii9tYLRNSmUTZD7tOz0UeueOMUn36/uIZNGFT4KUKLoOOjt
         rtsj11ieIrYxBhXBxnnCIxfNLDhAs0QV2KCI/d85R/JeOXixtWpwua7lh7lCSty+Mr/HcfprFLJkzl
         Hi9nAgVMXwzKNn3m70dzzCPU/sd8KZzSelkpVtDk/8olqxbAXaO5XJDOHPSwo4BFoyBhCVsFPUOoBR
         sIjYUR9AOxlKGsYfyTEtArWA6qimC7A==
X-MSG-ID: 5376637b-f7b7-11ec-9051-0050569d2c73
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Jander <david@protonic.nl>
Subject: [PATCH 2/3] spi: spi.c: Fix comment style
Date:   Wed, 29 Jun 2022 16:25:18 +0200
Message-Id: <20220629142519.3985486-3-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629142519.3985486-1-david@protonic.nl>
References: <20220629142519.3985486-1-david@protonic.nl>
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

Capitalize first word in comment where appropriate and add
parentheses to function names.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/spi/spi.c       | 94 ++++++++++++++++++++---------------------
 include/linux/spi/spi.h | 82 +++++++++++++++++------------------
 2 files changed, 88 insertions(+), 88 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b910f7a6c238..09d4959bc09c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1354,7 +1354,7 @@ int spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer)
 		/* Nothing to do here */
 		break;
 	case SPI_DELAY_UNIT_SCK:
-		/* clock cycles need to be obtained from spi_transfer */
+		/* Clock cycles need to be obtained from spi_transfer */
 		if (!xfer)
 			return -EINVAL;
 		/*
@@ -1403,7 +1403,7 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 	u32 unit = xfer->cs_change_delay.unit;
 	int ret;
 
-	/* return early on "fast" mode - for everything but USECS */
+	/* Return early on "fast" mode - for everything but USECS */
 	if (!delay) {
 		if (unit == SPI_DELAY_UNIT_USECS)
 			_spi_transfer_delay_ns(default_delay_ns);
@@ -1629,7 +1629,7 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 	WRITE_ONCE(ctlr->cur_msg_incomplete, true);
 	WRITE_ONCE(ctlr->cur_msg_need_completion, false);
 	reinit_completion(&ctlr->cur_msg_completion);
-	smp_wmb(); /* make these available to spi_finalize_current_message */
+	smp_wmb(); /* Make these available to spi_finalize_current_message() */
 
 	ret = ctlr->transfer_one_message(ctlr, msg);
 	if (ret) {
@@ -1905,7 +1905,7 @@ struct spi_message *spi_get_next_queued_message(struct spi_controller *ctlr)
 	struct spi_message *next;
 	unsigned long flags;
 
-	/* get a pointer to the next message, if any */
+	/* Get a pointer to the next message, if any */
 	spin_lock_irqsave(&ctlr->queue_lock, flags);
 	next = list_first_entry_or_null(&ctlr->queue, struct spi_message,
 					queue);
@@ -2558,7 +2558,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (ret < 0)
-		/* found SPI in _CRS but it points to another controller */
+		/* Found SPI in _CRS but it points to another controller */
 		return ERR_PTR(-ENODEV);
 
 	if (!lookup.max_speed_hz &&
@@ -3009,7 +3009,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		return status;
 
 	if (ctlr->bus_num >= 0) {
-		/* devices with a fixed bus num must check-in with the num */
+		/* Devices with a fixed bus num must check-in with the num */
 		mutex_lock(&board_lock);
 		id = idr_alloc(&spi_master_idr, ctlr, ctlr->bus_num,
 			ctlr->bus_num + 1, GFP_KERNEL);
@@ -3018,7 +3018,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			return id == -ENOSPC ? -EBUSY : id;
 		ctlr->bus_num = id;
 	} else if (ctlr->dev.of_node) {
-		/* allocate dynamic bus number using Linux idr */
+		/* Allocate dynamic bus number using Linux idr */
 		id = of_alias_get_id(ctlr->dev.of_node, "spi");
 		if (id >= 0) {
 			ctlr->bus_num = id;
@@ -3077,7 +3077,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		goto free_bus_id;
 	}
 
-	/* setting last_cs to -1 means no chip selected */
+	/* Setting last_cs to -1 means no chip selected */
 	ctlr->last_cs = -1;
 
 	status = device_add(&ctlr->dev);
@@ -3101,7 +3101,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			goto free_bus_id;
 		}
 	}
-	/* add statistics */
+	/* Add statistics */
 	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(dev);
 	if (!ctlr->pcpu_statistics) {
 		dev_err(dev, "Error allocating per-cpu statistics\n");
@@ -3204,7 +3204,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 
 	device_del(&ctlr->dev);
 
-	/* free bus id */
+	/* Free bus id */
 	mutex_lock(&board_lock);
 	if (found == ctlr)
 		idr_remove(&spi_master_idr, id);
@@ -3263,14 +3263,14 @@ static void __spi_replace_transfers_release(struct spi_controller *ctlr,
 	struct spi_replaced_transfers *rxfer = res;
 	size_t i;
 
-	/* call extra callback if requested */
+	/* Call extra callback if requested */
 	if (rxfer->release)
 		rxfer->release(ctlr, msg, res);
 
-	/* insert replaced transfers back into the message */
+	/* Insert replaced transfers back into the message */
 	list_splice(&rxfer->replaced_transfers, rxfer->replaced_after);
 
-	/* remove the formerly inserted entries */
+	/* Remove the formerly inserted entries */
 	for (i = 0; i < rxfer->inserted; i++)
 		list_del(&rxfer->inserted_transfers[i].transfer_list);
 }
@@ -3303,7 +3303,7 @@ static struct spi_replaced_transfers *spi_replace_transfers(
 	struct spi_transfer *xfer;
 	size_t i;
 
-	/* allocate the structure using spi_res */
+	/* Allocate the structure using spi_res */
 	rxfer = spi_res_alloc(msg->spi, __spi_replace_transfers_release,
 			      struct_size(rxfer, inserted_transfers, insert)
 			      + extradatasize,
@@ -3311,15 +3311,15 @@ static struct spi_replaced_transfers *spi_replace_transfers(
 	if (!rxfer)
 		return ERR_PTR(-ENOMEM);
 
-	/* the release code to invoke before running the generic release */
+	/* The release code to invoke before running the generic release */
 	rxfer->release = release;
 
-	/* assign extradata */
+	/* Assign extradata */
 	if (extradatasize)
 		rxfer->extradata =
 			&rxfer->inserted_transfers[insert];
 
-	/* init the replaced_transfers list */
+	/* Init the replaced_transfers list */
 	INIT_LIST_HEAD(&rxfer->replaced_transfers);
 
 	/*
@@ -3328,7 +3328,7 @@ static struct spi_replaced_transfers *spi_replace_transfers(
 	 */
 	rxfer->replaced_after = xfer_first->transfer_list.prev;
 
-	/* remove the requested number of transfers */
+	/* Remove the requested number of transfers */
 	for (i = 0; i < remove; i++) {
 		/*
 		 * If the entry after replaced_after it is msg->transfers
@@ -3338,14 +3338,14 @@ static struct spi_replaced_transfers *spi_replace_transfers(
 		if (rxfer->replaced_after->next == &msg->transfers) {
 			dev_err(&msg->spi->dev,
 				"requested to remove more spi_transfers than are available\n");
-			/* insert replaced transfers back into the message */
+			/* Insert replaced transfers back into the message */
 			list_splice(&rxfer->replaced_transfers,
 				    rxfer->replaced_after);
 
-			/* free the spi_replace_transfer structure */
+			/* Free the spi_replace_transfer structure... */
 			spi_res_free(rxfer);
 
-			/* and return with an error */
+			/* ...and return with an error */
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -3362,26 +3362,26 @@ static struct spi_replaced_transfers *spi_replace_transfers(
 	 * based on the first transfer to get removed.
 	 */
 	for (i = 0; i < insert; i++) {
-		/* we need to run in reverse order */
+		/* We need to run in reverse order */
 		xfer = &rxfer->inserted_transfers[insert - 1 - i];
 
-		/* copy all spi_transfer data */
+		/* Copy all spi_transfer data */
 		memcpy(xfer, xfer_first, sizeof(*xfer));
 
-		/* add to list */
+		/* Add to list */
 		list_add(&xfer->transfer_list, rxfer->replaced_after);
 
-		/* clear cs_change and delay for all but the last */
+		/* Clear cs_change and delay for all but the last */
 		if (i) {
 			xfer->cs_change = false;
 			xfer->delay.value = 0;
 		}
 	}
 
-	/* set up inserted */
+	/* Set up inserted... */
 	rxfer->inserted = insert;
 
-	/* and register it with spi_res/spi_message */
+	/* ...and register it with spi_res/spi_message */
 	spi_res_add(msg, rxfer);
 
 	return rxfer;
@@ -3398,10 +3398,10 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	size_t offset;
 	size_t count, i;
 
-	/* calculate how many we have to replace */
+	/* Calculate how many we have to replace */
 	count = DIV_ROUND_UP(xfer->len, maxsize);
 
-	/* create replacement */
+	/* Create replacement */
 	srt = spi_replace_transfers(msg, xfer, 1, count, NULL, 0, gfp);
 	if (IS_ERR(srt))
 		return PTR_ERR(srt);
@@ -3424,9 +3424,9 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	 */
 	xfers[0].len = min_t(size_t, maxsize, xfer[0].len);
 
-	/* all the others need rx_buf/tx_buf also set */
+	/* All the others need rx_buf/tx_buf also set */
 	for (i = 1, offset = maxsize; i < count; offset += maxsize, i++) {
-		/* update rx_buf, tx_buf and dma */
+		/* Update rx_buf, tx_buf and dma */
 		if (xfers[i].rx_buf)
 			xfers[i].rx_buf += offset;
 		if (xfers[i].rx_dma)
@@ -3436,7 +3436,7 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 		if (xfers[i].tx_dma)
 			xfers[i].tx_dma += offset;
 
-		/* update length */
+		/* Update length */
 		xfers[i].len = min(maxsize, xfers[i].len - offset);
 	}
 
@@ -3446,7 +3446,7 @@ static int __spi_split_transfer_maxsize(struct spi_controller *ctlr,
 	 */
 	*xferp = &xfers[count - 1];
 
-	/* increment statistics counters */
+	/* Increment statistics counters */
 	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics,
 				       transfers_split_maxsize);
 	SPI_STATISTICS_INCREMENT_FIELD(msg->spi->pcpu_statistics,
@@ -3708,7 +3708,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 			return ret;
 
 		list_for_each_entry(xfer, &message->transfers, transfer_list) {
-			/* don't change cs_change on the last entry in the list */
+			/* Don't change cs_change on the last entry in the list */
 			if (list_is_last(&xfer->transfer_list, &message->transfers))
 				break;
 			xfer->cs_change = 1;
@@ -3801,7 +3801,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				!(spi->mode & SPI_TX_QUAD))
 				return -EINVAL;
 		}
-		/* check transfer rx_nbits */
+		/* Check transfer rx_nbits */
 		if (xfer->rx_buf) {
 			if (spi->mode & SPI_NO_RX)
 				return -EINVAL;
@@ -4139,7 +4139,7 @@ int spi_bus_lock(struct spi_controller *ctlr)
 	ctlr->bus_lock_flag = 1;
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
-	/* mutex remains locked until spi_bus_unlock is called */
+	/* Mutex remains locked until spi_bus_unlock() is called */
 
 	return 0;
 }
@@ -4168,7 +4168,7 @@ int spi_bus_unlock(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_bus_unlock);
 
-/* portable code must never pass more than 32 bytes */
+/* Portable code must never pass more than 32 bytes */
 #define	SPI_BUFSIZ	max(32, SMP_CACHE_BYTES)
 
 static u8	*buf;
@@ -4234,7 +4234,7 @@ int spi_write_then_read(struct spi_device *spi,
 	x[0].tx_buf = local_buf;
 	x[1].rx_buf = local_buf + n_tx;
 
-	/* do the i/o */
+	/* Do the i/o */
 	status = spi_sync(spi, &message);
 	if (status == 0)
 		memcpy(rxbuf, x[1].rx_buf, n_rx);
@@ -4251,7 +4251,7 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_OF_DYNAMIC)
-/* must call put_device() when done with returned spi_device device */
+/* Must call put_device() when done with returned spi_device device */
 static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 {
 	struct device *dev = bus_find_device_by_of_node(&spi_bus_type, node);
@@ -4259,7 +4259,7 @@ static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 	return dev ? to_spi_device(dev) : NULL;
 }
 
-/* the spi controllers are not using spi_bus, so we find it with another way */
+/* The spi controllers are not using spi_bus, so we find it with another way */
 static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
 	struct device *dev;
@@ -4270,7 +4270,7 @@ static struct spi_controller *of_find_spi_controller_by_node(struct device_node
 	if (!dev)
 		return NULL;
 
-	/* reference got in class_find_device */
+	/* Reference got in class_find_device */
 	return container_of(dev, struct spi_controller, dev);
 }
 
@@ -4285,7 +4285,7 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 	case OF_RECONFIG_CHANGE_ADD:
 		ctlr = of_find_spi_controller_by_node(rd->dn->parent);
 		if (ctlr == NULL)
-			return NOTIFY_OK;	/* not for us */
+			return NOTIFY_OK;	/* Not for us */
 
 		if (of_node_test_and_set_flag(rd->dn, OF_POPULATED)) {
 			put_device(&ctlr->dev);
@@ -4304,19 +4304,19 @@ static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 		break;
 
 	case OF_RECONFIG_CHANGE_REMOVE:
-		/* already depopulated? */
+		/* Already depopulated? */
 		if (!of_node_check_flag(rd->dn, OF_POPULATED))
 			return NOTIFY_OK;
 
-		/* find our device by node */
+		/* Find our device by node */
 		spi = of_find_spi_device_by_node(rd->dn);
 		if (spi == NULL)
-			return NOTIFY_OK;	/* no? not meant for us */
+			return NOTIFY_OK;	/* No? not meant for us */
 
-		/* unregister takes one ref away */
+		/* Unregister takes one ref away */
 		spi_unregister_device(spi);
 
-		/* and put the reference of the find */
+		/* And put the reference of the find */
 		put_device(&spi->dev);
 		break;
 	}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index eb0d316e3c36..e6c73d5ff1a8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -176,13 +176,13 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
 struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
-	struct spi_controller	*master;	/* compatibility layer */
+	struct spi_controller	*master;	/* Compatibility layer */
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
 	bool			rt;
-#define SPI_NO_TX	BIT(31)		/* no transmit wire */
-#define SPI_NO_RX	BIT(30)		/* no receive wire */
+#define SPI_NO_TX	BIT(31)		/* No transmit wire */
+#define SPI_NO_RX	BIT(30)		/* No receive wire */
 	/*
 	 * All bits defined above should be covered by SPI_MODE_KERNEL_MASK.
 	 * The SPI_MODE_KERNEL_MASK has the SPI_MODE_USER_MASK counterpart,
@@ -199,14 +199,14 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
-	struct spi_delay	word_delay; /* inter-word delay */
+	struct gpio_desc	*cs_gpiod;	/* Chip select gpio desc */
+	struct spi_delay	word_delay; /* Inter-word delay */
 	/* CS delays */
 	struct spi_delay	cs_setup;
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
 
-	/* the statistics */
+	/* The statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
 
 	/*
@@ -228,7 +228,7 @@ static inline struct spi_device *to_spi_device(struct device *dev)
 	return dev ? container_of(dev, struct spi_device, dev) : NULL;
 }
 
-/* most drivers won't need to care about device refcounting */
+/* Most drivers won't need to care about device refcounting */
 static inline struct spi_device *spi_dev_get(struct spi_device *spi)
 {
 	return (spi && get_device(&spi->dev)) ? spi : NULL;
@@ -251,7 +251,7 @@ static inline void spi_set_ctldata(struct spi_device *spi, void *state)
 	spi->controller_state = state;
 }
 
-/* device driver data */
+/* Device driver data */
 
 static inline void spi_set_drvdata(struct spi_device *spi, void *data)
 {
@@ -318,7 +318,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 
 extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
 
-/* use a define to avoid include chaining to get THIS_MODULE */
+/* Use a define to avoid include chaining to get THIS_MODULE */
 #define spi_register_driver(driver) \
 	__spi_register_driver(THIS_MODULE, driver)
 
@@ -486,7 +486,7 @@ struct spi_controller {
 
 	struct list_head list;
 
-	/* other than negative (== assign one dynamically), bus_num is fully
+	/* Other than negative (== assign one dynamically), bus_num is fully
 	 * board-specific.  usually that simplifies to being SOC-specific.
 	 * example:  one SOC has three SPI controllers, numbered 0..2,
 	 * and one board's schematics might show it using SPI-2.  software
@@ -499,7 +499,7 @@ struct spi_controller {
 	 */
 	u16			num_chipselect;
 
-	/* some SPI controllers pose alignment requirements on DMAable
+	/* Some SPI controllers pose alignment requirements on DMAable
 	 * buffers; let protocol drivers know about these requirements.
 	 */
 	u16			dma_alignment;
@@ -510,29 +510,29 @@ struct spi_controller {
 	/* spi_device.mode flags override flags for this controller */
 	u32			buswidth_override_bits;
 
-	/* bitmask of supported bits_per_word for transfers */
+	/* Bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
 #define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)
 
-	/* limits on transfer speed */
+	/* Limits on transfer speed */
 	u32			min_speed_hz;
 	u32			max_speed_hz;
 
-	/* other constraints relevant to this driver */
+	/* Other constraints relevant to this driver */
 	u16			flags;
-#define SPI_CONTROLLER_HALF_DUPLEX	BIT(0)	/* can't do full duplex */
-#define SPI_CONTROLLER_NO_RX		BIT(1)	/* can't do buffer read */
-#define SPI_CONTROLLER_NO_TX		BIT(2)	/* can't do buffer write */
-#define SPI_CONTROLLER_MUST_RX		BIT(3)	/* requires rx */
-#define SPI_CONTROLLER_MUST_TX		BIT(4)	/* requires tx */
+#define SPI_CONTROLLER_HALF_DUPLEX	BIT(0)	/* Can't do full duplex */
+#define SPI_CONTROLLER_NO_RX		BIT(1)	/* Can't do buffer read */
+#define SPI_CONTROLLER_NO_TX		BIT(2)	/* Can't do buffer write */
+#define SPI_CONTROLLER_MUST_RX		BIT(3)	/* Requires rx */
+#define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
 
 #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
 
-	/* flag indicating if the allocation of this struct is devres-managed */
+	/* Flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
 
-	/* flag indicating this is an SPI slave controller */
+	/* Flag indicating this is an SPI slave controller */
 	bool			slave;
 
 	/*
@@ -548,11 +548,11 @@ struct spi_controller {
 	/* Used to avoid adding the same CS twice */
 	struct mutex		add_lock;
 
-	/* lock and mutex for SPI bus locking */
+	/* Lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
 	struct mutex		bus_lock_mutex;
 
-	/* flag indicating that the SPI bus is locked for exclusive use */
+	/* Flag indicating that the SPI bus is locked for exclusive use */
 	bool			bus_lock_flag;
 
 	/* Setup mode and clock, etc (spi driver may call many times).
@@ -573,7 +573,7 @@ struct spi_controller {
 	 */
 	int (*set_cs_timing)(struct spi_device *spi);
 
-	/* bidirectional bulk transfers
+	/* Bidirectional bulk transfers
 	 *
 	 * + The transfer() method may not sleep; its main role is
 	 *   just to add the message to the queue.
@@ -595,7 +595,7 @@ struct spi_controller {
 	int			(*transfer)(struct spi_device *spi,
 						struct spi_message *mesg);
 
-	/* called on release() to free memory provided by spi_controller */
+	/* Called on release() to free memory provided by spi_controller */
 	void			(*cleanup)(struct spi_device *spi);
 
 	/*
@@ -666,14 +666,14 @@ struct spi_controller {
 	s8			unused_native_cs;
 	s8			max_native_cs;
 
-	/* statistics */
+	/* Statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
 
 	/* DMA channels for use with core dmaengine helpers */
 	struct dma_chan		*dma_tx;
 	struct dma_chan		*dma_rx;
 
-	/* dummy data for full duplex devices */
+	/* Dummy data for full duplex devices */
 	void			*dummy_rx;
 	void			*dummy_tx;
 
@@ -738,7 +738,7 @@ void spi_take_timestamp_post(struct spi_controller *ctlr,
 			     struct spi_transfer *xfer,
 			     size_t progress, bool irqs_off);
 
-/* the spi driver core manages memory for the spi_controller classdev */
+/* The spi driver core manages memory for the spi_controller classdev */
 extern struct spi_controller *__spi_alloc_controller(struct device *host,
 						unsigned int size, bool slave);
 
@@ -808,7 +808,7 @@ typedef void (*spi_res_release_t)(struct spi_controller *ctlr,
 struct spi_res {
 	struct list_head        entry;
 	spi_res_release_t       release;
-	unsigned long long      data[]; /* guarantee ull alignment */
+	unsigned long long      data[]; /* Guarantee ull alignment */
 };
 
 /*---------------------------------------------------------------------------*/
@@ -941,7 +941,7 @@ struct spi_res {
  * and its transfers, ignore them until its completion callback.
  */
 struct spi_transfer {
-	/* it's ok if tx_buf == rx_buf (right?)
+	/* It's ok if tx_buf == rx_buf (right?)
 	 * for MicroWire, one buffer must be null
 	 * buffers must work with dma_*map_single() calls, unless
 	 *   spi_message.is_dma_mapped reports a pre-existing mapping
@@ -1032,24 +1032,24 @@ struct spi_message {
 	 * tell them about such special cases.
 	 */
 
-	/* completion is reported through a callback */
+	/* Completion is reported through a callback */
 	void			(*complete)(void *context);
 	void			*context;
 	unsigned		frame_length;
 	unsigned		actual_length;
 	int			status;
 
-	/* for optional use by whatever driver currently owns the
+	/* For optional use by whatever driver currently owns the
 	 * spi_message ...  between calls to spi_async and then later
 	 * complete(), that's the spi_controller controller driver.
 	 */
 	struct list_head	queue;
 	void			*state;
 
-	/* list of spi_res reources when the spi message is processed */
+	/* List of spi_res reources when the spi message is processed */
 	struct list_head        resources;
 
-	/* spi_prepare_message was called for this message */
+	/* spi_prepare_message() was called for this message */
 	bool			prepared;
 };
 
@@ -1154,7 +1154,7 @@ spi_max_transfer_size(struct spi_device *spi)
 	if (ctlr->max_transfer_size)
 		tr_max = ctlr->max_transfer_size(spi);
 
-	/* transfer size limit must not be greater than message size limit */
+	/* Transfer size limit must not be greater than message size limit */
 	return min(tr_max, msg_max);
 }
 
@@ -1305,7 +1305,7 @@ spi_read(struct spi_device *spi, void *buf, size_t len)
 	return spi_sync_transfer(spi, &t, 1);
 }
 
-/* this copies txbuf and rxbuf data; for small transfers only! */
+/* This copies txbuf and rxbuf data; for small transfers only! */
 extern int spi_write_then_read(struct spi_device *spi,
 		const void *txbuf, unsigned n_tx,
 		void *rxbuf, unsigned n_rx);
@@ -1328,7 +1328,7 @@ static inline ssize_t spi_w8r8(struct spi_device *spi, u8 cmd)
 
 	status = spi_write_then_read(spi, &cmd, 1, &result, 1);
 
-	/* return negative errno or unsigned value */
+	/* Return negative errno or unsigned value */
 	return (status < 0) ? status : result;
 }
 
@@ -1353,7 +1353,7 @@ static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
 
 	status = spi_write_then_read(spi, &cmd, 1, &result, 2);
 
-	/* return negative errno or unsigned value */
+	/* Return negative errno or unsigned value */
 	return (status < 0) ? status : result;
 }
 
@@ -1433,7 +1433,7 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
  * are active in some dynamic board configuration models.
  */
 struct spi_board_info {
-	/* the device name and module name are coupled, like platform_bus;
+	/* The device name and module name are coupled, like platform_bus;
 	 * "modalias" is normally the driver name.
 	 *
 	 * platform_data goes to spi_device.dev.platform_data,
@@ -1446,7 +1446,7 @@ struct spi_board_info {
 	void		*controller_data;
 	int		irq;
 
-	/* slower signaling on noisy or low voltage boards */
+	/* Slower signaling on noisy or low voltage boards */
 	u32		max_speed_hz;
 
 
@@ -1475,7 +1475,7 @@ struct spi_board_info {
 extern int
 spi_register_board_info(struct spi_board_info const *info, unsigned n);
 #else
-/* board init code may ignore whether SPI is configured or not */
+/* Board init code may ignore whether SPI is configured or not */
 static inline int
 spi_register_board_info(struct spi_board_info const *info, unsigned n)
 	{ return 0; }
-- 
2.32.0

