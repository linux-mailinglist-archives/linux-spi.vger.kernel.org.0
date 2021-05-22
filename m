Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AFD38D745
	for <lists+linux-spi@lfdr.de>; Sat, 22 May 2021 21:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhEVTlP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 May 2021 15:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhEVTlN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 May 2021 15:41:13 -0400
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 May 2021 12:39:40 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C742C06174A
        for <linux-spi@vger.kernel.org>; Sat, 22 May 2021 12:39:40 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4F8A0300002D0;
        Sat, 22 May 2021 21:30:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 400BD3B925B; Sat, 22 May 2021 21:30:01 +0200 (CEST)
Message-Id: <68febff3649a08d5bd0b5cd913d0f9128a634585.1621703200.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 22 May 2021 21:29:42 +0200
Subject: [PATCH for-5.14] spi: bcm2835: Allow arbitrary number of slaves
To:     Mark Brown <broonie@kernel.org>
Cc:     Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Phil Elwell <phil@raspberrypi.com>,
        "Nicolas Saenz Julienne" <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org
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
To apply cleanly, the following for-5.13 patch needs to be applied first...

https://lore.kernel.org/linux-spi/75854affc1923309fde05e47494263bde73e5592.1621703210.git.lukas@wunner.de

... and for-5.13 needs to be backmerged into for-5.14.  Thanks!

 drivers/spi/spi-bcm2835.c | 191 ++++++++++++++++++++++----------------
 1 file changed, 109 insertions(+), 82 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index fe40626e45aa..9d1ec66c5157 100644
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
+			return ret;
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
 
@@ -1284,8 +1311,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	struct bcm2835_spi *bs;
 	int err;
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, ALIGN(sizeof(*bs),
-						  dma_get_cache_alignment()));
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*bs));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1296,6 +1322,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->num_chipselect = 3;
 	ctlr->setup = bcm2835_spi_setup;
+	ctlr->cleanup = bcm2835_spi_cleanup;
 	ctlr->transfer_one = bcm2835_spi_transfer_one;
 	ctlr->handle_err = bcm2835_spi_handle_err;
 	ctlr->prepare_message = bcm2835_spi_prepare_message;
-- 
2.31.1

