Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8D393800
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 23:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhE0VeL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 17:34:11 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:45917 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhE0VeL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 17:34:11 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 5379F10189B6A;
        Thu, 27 May 2021 23:32:36 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 2B7166011CC8;
        Thu, 27 May 2021 23:32:36 +0200 (CEST)
X-Mailbox-Line: From a847c01f09400801e74e0630bf5a0197591554da Mon Sep 17 00:00:00 2001
Message-Id: <a847c01f09400801e74e0630bf5a0197591554da.1622150204.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 27 May 2021 23:32:00 +0200
Subject: [PATCH v2 for-5.14] spi: bcm2835: Allow arbitrary number of slaves
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Phil Elwell <phil@raspberrypi.com>,
        "Nicolas Saenz Julienne" <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commit 571e31fa60b3 ("spi: bcm2835: Cache CS register value for
->prepare_message()"), the number of slaves has been limited by a
compile-time constant.  This was necessitated by statically-sized
arrays in the driver private data which contain per-slave register
values.

As suggested by Mark, move those register values to a per-slave
controller_state which is allocated on ->setup and freed on ->cleanup.
The limitation on the number of slaves is thus lifted.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc: Phil Elwell <phil@raspberrypi.com>
---
v1 -> v2:
 Call ->cleanup() in error path of ->setup() because the SPI core
 no longer does that implicitly since commit c7299fea6769.

Link to v1:
 https://lore.kernel.org/linux-spi/68febff3649a08d5bd0b5cd913d0f9128a634585.1621703200.git.lukas@wunner.de/

 drivers/spi/spi-bcm2835.c | 204 ++++++++++++++++++++++----------------
 1 file changed, 119 insertions(+), 85 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index fe40626e45aa..5f8771fe1a31 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -68,7 +68,6 @@
 #define BCM2835_SPI_FIFO_SIZE		64
 #define BCM2835_SPI_FIFO_SIZE_3_4	48
 #define BCM2835_SPI_DMA_MIN_LENGTH	96
-#define BCM2835_SPI_NUM_CS		24  /* raise as necessary */
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
@@ -96,8 +95,6 @@ MODULE_PARM_DESC(polling_limit_us,
  * @rx_prologue: bytes received without DMA if first RX sglist entry's
  *	length is not a multiple of 4 (to overcome hardware limitation)
  * @tx_spillover: whether @tx_prologue spills over to second TX sglist entry
- * @prepare_cs: precalculated CS register value for ->prepare_message()
- *	(uses slave-specific clock polarity and phase settings)
  * @debugfs_dir: the debugfs directory - neede to remove debugfs when
  *      unloading the module
  * @count_transfer_polling: count of how often polling mode is used
@@ -107,7 +104,7 @@ MODULE_PARM_DESC(polling_limit_us,
  *      These are counted as well in @count_transfer_polling and
  *      @count_transfer_irq
  * @count_transfer_dma: count how often dma mode is used
- * @chip_select: SPI slave currently selected
+ * @slv: SPI slave currently selected
  *	(used by bcm2835_spi_dma_tx_done() to write @clear_rx_cs)
  * @tx_dma_active: whether a TX DMA descriptor is in progress
  * @rx_dma_active: whether a RX DMA descriptor is in progress
@@ -115,11 +112,6 @@ MODULE_PARM_DESC(polling_limit_us,
  * @fill_tx_desc: preallocated TX DMA descriptor used for RX-only transfers
  *	(cyclically copies from zero page to TX FIFO)
  * @fill_tx_addr: bus address of zero page
- * @clear_rx_desc: preallocated RX DMA descriptor used for TX-only transfers
- *	(cyclically clears RX FIFO by writing @clear_rx_cs to CS register)
- * @clear_rx_addr: bus address of @clear_rx_cs
- * @clear_rx_cs: precalculated CS register value to clear RX FIFO
- *	(uses slave-specific clock polarity and phase settings)
  */
 struct bcm2835_spi {
 	void __iomem *regs;
@@ -134,7 +126,6 @@ struct bcm2835_spi {
 	int tx_prologue;
 	int rx_prologue;
 	unsigned int tx_spillover;
-	u32 prepare_cs[BCM2835_SPI_NUM_CS];
 
 	struct dentry *debugfs_dir;
 	u64 count_transfer_polling;
@@ -142,14 +133,28 @@ struct bcm2835_spi {
 	u64 count_transfer_irq_after_polling;
 	u64 count_transfer_dma;
 
-	u8 chip_select;
+	struct bcm2835_spidev *slv;
 	unsigned int tx_dma_active;
 	unsigned int rx_dma_active;
 	struct dma_async_tx_descriptor *fill_tx_desc;
 	dma_addr_t fill_tx_addr;
-	struct dma_async_tx_descriptor *clear_rx_desc[BCM2835_SPI_NUM_CS];
+};
+
+/**
+ * struct bcm2835_spidev - BCM2835 SPI slave
+ * @prepare_cs: precalculated CS register value for ->prepare_message()
+ *	(uses slave-specific clock polarity and phase settings)
+ * @clear_rx_desc: preallocated RX DMA descriptor used for TX-only transfers
+ *	(cyclically clears RX FIFO by writing @clear_rx_cs to CS register)
+ * @clear_rx_addr: bus address of @clear_rx_cs
+ * @clear_rx_cs: precalculated CS register value to clear RX FIFO
+ *	(uses slave-specific clock polarity and phase settings)
+ */
+struct bcm2835_spidev {
+	u32 prepare_cs;
+	struct dma_async_tx_descriptor *clear_rx_desc;
 	dma_addr_t clear_rx_addr;
-	u32 clear_rx_cs[BCM2835_SPI_NUM_CS] ____cacheline_aligned;
+	u32 clear_rx_cs ____cacheline_aligned;
 };
 
 #if defined(CONFIG_DEBUG_FS)
@@ -624,8 +629,7 @@ static void bcm2835_spi_dma_tx_done(void *data)
 
 	/* busy-wait for TX FIFO to empty */
 	while (!(bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_DONE))
-		bcm2835_wr(bs, BCM2835_SPI_CS,
-			   bs->clear_rx_cs[bs->chip_select]);
+		bcm2835_wr(bs, BCM2835_SPI_CS, bs->slv->clear_rx_cs);
 
 	bs->tx_dma_active = false;
 	smp_wmb();
@@ -646,18 +650,18 @@ static void bcm2835_spi_dma_tx_done(void *data)
 /**
  * bcm2835_spi_prepare_sg() - prepare and submit DMA descriptor for sglist
  * @ctlr: SPI master controller
- * @spi: SPI slave
  * @tfr: SPI transfer
  * @bs: BCM2835 SPI controller
+ * @slv: BCM2835 SPI slave
  * @is_tx: whether to submit DMA descriptor for TX or RX sglist
  *
  * Prepare and submit a DMA descriptor for the TX or RX sglist of @tfr.
  * Return 0 on success or a negative error number.
  */
 static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
-				  struct spi_device *spi,
 				  struct spi_transfer *tfr,
 				  struct bcm2835_spi *bs,
+				  struct bcm2835_spidev *slv,
 				  bool is_tx)
 {
 	struct dma_chan *chan;
@@ -697,7 +701,7 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 	} else if (!tfr->rx_buf) {
 		desc->callback = bcm2835_spi_dma_tx_done;
 		desc->callback_param = ctlr;
-		bs->chip_select = spi->chip_select;
+		bs->slv = slv;
 	}
 
 	/* submit it to DMA-engine */
@@ -709,8 +713,8 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 /**
  * bcm2835_spi_transfer_one_dma() - perform SPI transfer using DMA engine
  * @ctlr: SPI master controller
- * @spi: SPI slave
  * @tfr: SPI transfer
+ * @slv: BCM2835 SPI slave
  * @cs: CS register
  *
  * For *bidirectional* transfers (both tx_buf and rx_buf are non-%NULL), set up
@@ -754,8 +758,8 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
  * performed at the end of an RX-only transfer.
  */
 static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
-					struct spi_device *spi,
 					struct spi_transfer *tfr,
+					struct bcm2835_spidev *slv,
 					u32 cs)
 {
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
@@ -773,7 +777,7 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 
 	/* setup tx-DMA */
 	if (bs->tx_buf) {
-		ret = bcm2835_spi_prepare_sg(ctlr, spi, tfr, bs, true);
+		ret = bcm2835_spi_prepare_sg(ctlr, tfr, bs, slv, true);
 	} else {
 		cookie = dmaengine_submit(bs->fill_tx_desc);
 		ret = dma_submit_error(cookie);
@@ -799,9 +803,9 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 	 * this saves 10us or more.
 	 */
 	if (bs->rx_buf) {
-		ret = bcm2835_spi_prepare_sg(ctlr, spi, tfr, bs, false);
+		ret = bcm2835_spi_prepare_sg(ctlr, tfr, bs, slv, false);
 	} else {
-		cookie = dmaengine_submit(bs->clear_rx_desc[spi->chip_select]);
+		cookie = dmaengine_submit(slv->clear_rx_desc);
 		ret = dma_submit_error(cookie);
 	}
 	if (ret) {
@@ -850,8 +854,6 @@ static bool bcm2835_spi_can_dma(struct spi_controller *ctlr,
 static void bcm2835_dma_release(struct spi_controller *ctlr,
 				struct bcm2835_spi *bs)
 {
-	int i;
-
 	if (ctlr->dma_tx) {
 		dmaengine_terminate_sync(ctlr->dma_tx);
 
@@ -870,17 +872,6 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 
 	if (ctlr->dma_rx) {
 		dmaengine_terminate_sync(ctlr->dma_rx);
-
-		for (i = 0; i < BCM2835_SPI_NUM_CS; i++)
-			if (bs->clear_rx_desc[i])
-				dmaengine_desc_free(bs->clear_rx_desc[i]);
-
-		if (bs->clear_rx_addr)
-			dma_unmap_single(ctlr->dma_rx->device->dev,
-					 bs->clear_rx_addr,
-					 sizeof(bs->clear_rx_cs),
-					 DMA_TO_DEVICE);
-
 		dma_release_channel(ctlr->dma_rx);
 		ctlr->dma_rx = NULL;
 	}
@@ -892,7 +883,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	struct dma_slave_config slave_config;
 	const __be32 *addr;
 	dma_addr_t dma_reg_base;
-	int ret, i;
+	int ret;
 
 	/* base address in dma-space */
 	addr = of_get_address(ctlr->dev.of_node, 0, NULL, NULL);
@@ -972,35 +963,6 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	if (ret)
 		goto err_config;
 
-	bs->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
-					   bs->clear_rx_cs,
-					   sizeof(bs->clear_rx_cs),
-					   DMA_TO_DEVICE);
-	if (dma_mapping_error(ctlr->dma_rx->device->dev, bs->clear_rx_addr)) {
-		dev_err(dev, "cannot map clear_rx_cs - not using DMA mode\n");
-		bs->clear_rx_addr = 0;
-		ret = -ENOMEM;
-		goto err_release;
-	}
-
-	for (i = 0; i < BCM2835_SPI_NUM_CS; i++) {
-		bs->clear_rx_desc[i] = dmaengine_prep_dma_cyclic(ctlr->dma_rx,
-					   bs->clear_rx_addr + i * sizeof(u32),
-					   sizeof(u32), 0,
-					   DMA_MEM_TO_DEV, 0);
-		if (!bs->clear_rx_desc[i]) {
-			dev_err(dev, "cannot prepare clear_rx_desc - not using DMA mode\n");
-			ret = -ENOMEM;
-			goto err_release;
-		}
-
-		ret = dmaengine_desc_set_reuse(bs->clear_rx_desc[i]);
-		if (ret) {
-			dev_err(dev, "cannot reuse clear_rx_desc - not using DMA mode\n");
-			goto err_release;
-		}
-	}
-
 	/* all went well, so set can_dma */
 	ctlr->can_dma = bcm2835_spi_can_dma;
 
@@ -1082,9 +1044,10 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 				    struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
+	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
 	unsigned long spi_hz, clk_hz, cdiv;
 	unsigned long hz_per_byte, byte_limit;
-	u32 cs = bs->prepare_cs[spi->chip_select];
+	u32 cs = slv->prepare_cs;
 
 	/* set clock */
 	spi_hz = tfr->speed_hz;
@@ -1133,7 +1096,7 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 	 * this 1 idle clock cycle pattern but runs the spi clock without gaps
 	 */
 	if (ctlr->can_dma && bcm2835_spi_can_dma(ctlr, spi, tfr))
-		return bcm2835_spi_transfer_one_dma(ctlr, spi, tfr, cs);
+		return bcm2835_spi_transfer_one_dma(ctlr, tfr, slv, cs);
 
 	/* run in interrupt-mode */
 	return bcm2835_spi_transfer_one_irq(ctlr, spi, tfr, cs, true);
@@ -1144,6 +1107,7 @@ static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 {
 	struct spi_device *spi = msg->spi;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
+	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
 	int ret;
 
 	if (ctlr->can_dma) {
@@ -1162,7 +1126,7 @@ static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 	 * Set up clock polarity before spi_transfer_one_message() asserts
 	 * chip select to avoid a gratuitous clock signal edge.
 	 */
-	bcm2835_wr(bs, BCM2835_SPI_CS, bs->prepare_cs[spi->chip_select]);
+	bcm2835_wr(bs, BCM2835_SPI_CS, slv->prepare_cs);
 
 	return 0;
 }
@@ -1188,17 +1152,81 @@ static int chip_match_name(struct gpio_chip *chip, void *data)
 	return !strcmp(chip->label, data);
 }
 
+static void bcm2835_spi_cleanup(struct spi_device *spi)
+{
+	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
+	struct spi_controller *ctlr = spi->controller;
+
+	if (slv->clear_rx_desc)
+		dmaengine_desc_free(slv->clear_rx_desc);
+
+	if (slv->clear_rx_addr)
+		dma_unmap_single(ctlr->dma_rx->device->dev,
+				 slv->clear_rx_addr,
+				 sizeof(u32),
+				 DMA_TO_DEVICE);
+
+	kfree(slv);
+}
+
+static int bcm2835_spi_setup_dma(struct spi_controller *ctlr,
+				 struct spi_device *spi,
+				 struct bcm2835_spi *bs,
+				 struct bcm2835_spidev *slv)
+{
+	int ret;
+
+	if (!ctlr->dma_rx)
+		return 0;
+
+	slv->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
+					    &slv->clear_rx_cs,
+					    sizeof(u32),
+					    DMA_TO_DEVICE);
+	if (dma_mapping_error(ctlr->dma_rx->device->dev, slv->clear_rx_addr)) {
+		dev_err(&spi->dev, "cannot map clear_rx_cs\n");
+		slv->clear_rx_addr = 0;
+		return -ENOMEM;
+	}
+
+	slv->clear_rx_desc = dmaengine_prep_dma_cyclic(ctlr->dma_rx,
+						       slv->clear_rx_addr,
+						       sizeof(u32), 0,
+						       DMA_MEM_TO_DEV, 0);
+	if (!slv->clear_rx_desc) {
+		dev_err(&spi->dev, "cannot prepare clear_rx_desc\n");
+		return -ENOMEM;
+	}
+
+	ret = dmaengine_desc_set_reuse(slv->clear_rx_desc);
+	if (ret) {
+		dev_err(&spi->dev, "cannot reuse clear_rx_desc\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int bcm2835_spi_setup(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
+	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
 	struct gpio_chip *chip;
+	int ret;
 	u32 cs;
 
-	if (spi->chip_select >= BCM2835_SPI_NUM_CS) {
-		dev_err(&spi->dev, "only %d chip-selects supported\n",
-			BCM2835_SPI_NUM_CS - 1);
-		return -EINVAL;
+	if (!slv) {
+		slv = kzalloc(ALIGN(sizeof(*slv), dma_get_cache_alignment()),
+			      GFP_KERNEL);
+		if (!slv)
+			return -ENOMEM;
+
+		spi_set_ctldata(spi, slv);
+
+		ret = bcm2835_spi_setup_dma(ctlr, spi, bs, slv);
+		if (ret)
+			goto err_cleanup;
 	}
 
 	/*
@@ -1212,20 +1240,19 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		cs |= BCM2835_SPI_CS_CPOL;
 	if (spi->mode & SPI_CPHA)
 		cs |= BCM2835_SPI_CS_CPHA;
-	bs->prepare_cs[spi->chip_select] = cs;
+	slv->prepare_cs = cs;
 
 	/*
 	 * Precalculate SPI slave's CS register value to clear RX FIFO
 	 * in case of a TX-only DMA transfer.
 	 */
 	if (ctlr->dma_rx) {
-		bs->clear_rx_cs[spi->chip_select] = cs |
-						    BCM2835_SPI_CS_TA |
-						    BCM2835_SPI_CS_DMAEN |
-						    BCM2835_SPI_CS_CLEAR_RX;
+		slv->clear_rx_cs = cs | BCM2835_SPI_CS_TA |
+					BCM2835_SPI_CS_DMAEN |
+					BCM2835_SPI_CS_CLEAR_RX;
 		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
-					   bs->clear_rx_addr,
-					   sizeof(bs->clear_rx_cs),
+					   slv->clear_rx_addr,
+					   sizeof(u32),
 					   DMA_TO_DEVICE);
 	}
 
@@ -1247,7 +1274,8 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		 */
 		dev_err(&spi->dev,
 			"setup: only two native chip-selects are supported\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_cleanup;
 	}
 
 	/*
@@ -1268,14 +1296,20 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 						  DRV_NAME,
 						  GPIO_LOOKUP_FLAGS_DEFAULT,
 						  GPIOD_OUT_LOW);
-	if (IS_ERR(spi->cs_gpiod))
-		return PTR_ERR(spi->cs_gpiod);
+	if (IS_ERR(spi->cs_gpiod)) {
+		ret = PTR_ERR(spi->cs_gpiod);
+		goto err_cleanup;
+	}
 
 	/* and set up the "mode" and level */
 	dev_info(&spi->dev, "setting up native-CS%i to use GPIO\n",
 		 spi->chip_select);
 
 	return 0;
+
+err_cleanup:
+	bcm2835_spi_cleanup(spi);
+	return ret;
 }
 
 static int bcm2835_spi_probe(struct platform_device *pdev)
@@ -1284,8 +1318,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	struct bcm2835_spi *bs;
 	int err;
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
-						  dma_get_cache_alignment()));
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*bs));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1296,6 +1329,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->num_chipselect = 3;
 	ctlr->setup = bcm2835_spi_setup;
+	ctlr->cleanup = bcm2835_spi_cleanup;
 	ctlr->transfer_one = bcm2835_spi_transfer_one;
 	ctlr->handle_err = bcm2835_spi_handle_err;
 	ctlr->prepare_message = bcm2835_spi_prepare_message;
-- 
2.31.1

