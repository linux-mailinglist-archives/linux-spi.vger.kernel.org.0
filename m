Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8024A772724
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjHGOKV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjHGOKT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5D10D4
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:16 -0700 (PDT)
Received: from dggpemm100011.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKJ8b026Szfbnw;
        Mon,  7 Aug 2023 22:09:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 05/21] spi: bcm2835: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:01 +0800
Message-ID: <20230807140717.3484180-6-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807140717.3484180-1-yangyingliang@huawei.com>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-bcm2835.c | 112 +++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index c16abc2a9e9b..1116e7d20034 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -105,7 +105,7 @@ MODULE_PARM_DESC(polling_limit_us,
  *      These are counted as well in @count_transfer_polling and
  *      @count_transfer_irq
  * @count_transfer_dma: count how often dma mode is used
- * @slv: SPI slave currently selected
+ * @target: SPI target currently selected
  *	(used by bcm2835_spi_dma_tx_done() to write @clear_rx_cs)
  * @tx_dma_active: whether a TX DMA descriptor is in progress
  * @rx_dma_active: whether a RX DMA descriptor is in progress
@@ -135,7 +135,7 @@ struct bcm2835_spi {
 	u64 count_transfer_irq_after_polling;
 	u64 count_transfer_dma;
 
-	struct bcm2835_spidev *slv;
+	struct bcm2835_spidev *target;
 	unsigned int tx_dma_active;
 	unsigned int rx_dma_active;
 	struct dma_async_tx_descriptor *fill_tx_desc;
@@ -143,14 +143,14 @@ struct bcm2835_spi {
 };
 
 /**
- * struct bcm2835_spidev - BCM2835 SPI slave
+ * struct bcm2835_spidev - BCM2835 SPI target
  * @prepare_cs: precalculated CS register value for ->prepare_message()
- *	(uses slave-specific clock polarity and phase settings)
+ *	(uses target-specific clock polarity and phase settings)
  * @clear_rx_desc: preallocated RX DMA descriptor used for TX-only transfers
  *	(cyclically clears RX FIFO by writing @clear_rx_cs to CS register)
  * @clear_rx_addr: bus address of @clear_rx_cs
  * @clear_rx_cs: precalculated CS register value to clear RX FIFO
- *	(uses slave-specific clock polarity and phase settings)
+ *	(uses target-specific clock polarity and phase settings)
  */
 struct bcm2835_spidev {
 	u32 prepare_cs;
@@ -434,7 +434,7 @@ static int bcm2835_spi_transfer_one_irq(struct spi_controller *ctlr,
 
 /**
  * bcm2835_spi_transfer_prologue() - transfer first few bytes without DMA
- * @ctlr: SPI master controller
+ * @ctlr: SPI host controller
  * @tfr: SPI transfer
  * @bs: BCM2835 SPI controller
  * @cs: CS register
@@ -596,7 +596,7 @@ static void bcm2835_spi_undo_prologue(struct bcm2835_spi *bs)
 
 /**
  * bcm2835_spi_dma_rx_done() - callback for DMA RX channel
- * @data: SPI master controller
+ * @data: SPI host controller
  *
  * Used for bidirectional and RX-only transfers.
  */
@@ -624,7 +624,7 @@ static void bcm2835_spi_dma_rx_done(void *data)
 
 /**
  * bcm2835_spi_dma_tx_done() - callback for DMA TX channel
- * @data: SPI master controller
+ * @data: SPI host controller
  *
  * Used for TX-only transfers.
  */
@@ -635,7 +635,7 @@ static void bcm2835_spi_dma_tx_done(void *data)
 
 	/* busy-wait for TX FIFO to empty */
 	while (!(bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_DONE))
-		bcm2835_wr(bs, BCM2835_SPI_CS, bs->slv->clear_rx_cs);
+		bcm2835_wr(bs, BCM2835_SPI_CS, bs->target->clear_rx_cs);
 
 	bs->tx_dma_active = false;
 	smp_wmb();
@@ -655,10 +655,10 @@ static void bcm2835_spi_dma_tx_done(void *data)
 
 /**
  * bcm2835_spi_prepare_sg() - prepare and submit DMA descriptor for sglist
- * @ctlr: SPI master controller
+ * @ctlr: SPI host controller
  * @tfr: SPI transfer
  * @bs: BCM2835 SPI controller
- * @slv: BCM2835 SPI slave
+ * @target: BCM2835 SPI target
  * @is_tx: whether to submit DMA descriptor for TX or RX sglist
  *
  * Prepare and submit a DMA descriptor for the TX or RX sglist of @tfr.
@@ -667,7 +667,7 @@ static void bcm2835_spi_dma_tx_done(void *data)
 static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 				  struct spi_transfer *tfr,
 				  struct bcm2835_spi *bs,
-				  struct bcm2835_spidev *slv,
+				  struct bcm2835_spidev *target,
 				  bool is_tx)
 {
 	struct dma_chan *chan;
@@ -707,7 +707,7 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 	} else if (!tfr->rx_buf) {
 		desc->callback = bcm2835_spi_dma_tx_done;
 		desc->callback_param = ctlr;
-		bs->slv = slv;
+		bs->target = target;
 	}
 
 	/* submit it to DMA-engine */
@@ -718,9 +718,9 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
 
 /**
  * bcm2835_spi_transfer_one_dma() - perform SPI transfer using DMA engine
- * @ctlr: SPI master controller
+ * @ctlr: SPI host controller
  * @tfr: SPI transfer
- * @slv: BCM2835 SPI slave
+ * @target: BCM2835 SPI target
  * @cs: CS register
  *
  * For *bidirectional* transfers (both tx_buf and rx_buf are non-%NULL), set up
@@ -732,7 +732,7 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
  * clear the RX FIFO by setting the CLEAR_RX bit in the CS register.
  *
  * The CS register value is precalculated in bcm2835_spi_setup().  Normally
- * this is called only once, on slave registration.  A DMA descriptor to write
+ * this is called only once, on target registration.  A DMA descriptor to write
  * this value is preallocated in bcm2835_dma_init().  All that's left to do
  * when performing a TX-only transfer is to submit this descriptor to the RX
  * DMA channel.  Latency is thereby minimized.  The descriptor does not
@@ -765,7 +765,7 @@ static int bcm2835_spi_prepare_sg(struct spi_controller *ctlr,
  */
 static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 					struct spi_transfer *tfr,
-					struct bcm2835_spidev *slv,
+					struct bcm2835_spidev *target,
 					u32 cs)
 {
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
@@ -783,7 +783,7 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 
 	/* setup tx-DMA */
 	if (bs->tx_buf) {
-		ret = bcm2835_spi_prepare_sg(ctlr, tfr, bs, slv, true);
+		ret = bcm2835_spi_prepare_sg(ctlr, tfr, bs, target, true);
 	} else {
 		cookie = dmaengine_submit(bs->fill_tx_desc);
 		ret = dma_submit_error(cookie);
@@ -809,9 +809,9 @@ static int bcm2835_spi_transfer_one_dma(struct spi_controller *ctlr,
 	 * this saves 10us or more.
 	 */
 	if (bs->rx_buf) {
-		ret = bcm2835_spi_prepare_sg(ctlr, tfr, bs, slv, false);
+		ret = bcm2835_spi_prepare_sg(ctlr, tfr, bs, target, false);
 	} else {
-		cookie = dmaengine_submit(slv->clear_rx_desc);
+		cookie = dmaengine_submit(target->clear_rx_desc);
 		ret = dma_submit_error(cookie);
 	}
 	if (ret) {
@@ -1050,10 +1050,10 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 				    struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
-	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
+	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	unsigned long spi_hz, cdiv;
 	unsigned long hz_per_byte, byte_limit;
-	u32 cs = slv->prepare_cs;
+	u32 cs = target->prepare_cs;
 
 	/* set clock */
 	spi_hz = tfr->speed_hz;
@@ -1101,7 +1101,7 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 	 * this 1 idle clock cycle pattern but runs the spi clock without gaps
 	 */
 	if (ctlr->can_dma && bcm2835_spi_can_dma(ctlr, spi, tfr))
-		return bcm2835_spi_transfer_one_dma(ctlr, tfr, slv, cs);
+		return bcm2835_spi_transfer_one_dma(ctlr, tfr, target, cs);
 
 	/* run in interrupt-mode */
 	return bcm2835_spi_transfer_one_irq(ctlr, spi, tfr, cs, true);
@@ -1112,7 +1112,7 @@ static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 {
 	struct spi_device *spi = msg->spi;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
-	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
+	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	int ret;
 
 	if (ctlr->can_dma) {
@@ -1131,7 +1131,7 @@ static int bcm2835_spi_prepare_message(struct spi_controller *ctlr,
 	 * Set up clock polarity before spi_transfer_one_message() asserts
 	 * chip select to avoid a gratuitous clock signal edge.
 	 */
-	bcm2835_wr(bs, BCM2835_SPI_CS, slv->prepare_cs);
+	bcm2835_wr(bs, BCM2835_SPI_CS, target->prepare_cs);
 
 	return 0;
 }
@@ -1163,51 +1163,51 @@ static int chip_match_name(struct gpio_chip *chip, void *data)
 
 static void bcm2835_spi_cleanup(struct spi_device *spi)
 {
-	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
+	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	struct spi_controller *ctlr = spi->controller;
 
-	if (slv->clear_rx_desc)
-		dmaengine_desc_free(slv->clear_rx_desc);
+	if (target->clear_rx_desc)
+		dmaengine_desc_free(target->clear_rx_desc);
 
-	if (slv->clear_rx_addr)
+	if (target->clear_rx_addr)
 		dma_unmap_single(ctlr->dma_rx->device->dev,
-				 slv->clear_rx_addr,
+				 target->clear_rx_addr,
 				 sizeof(u32),
 				 DMA_TO_DEVICE);
 
-	kfree(slv);
+	kfree(target);
 }
 
 static int bcm2835_spi_setup_dma(struct spi_controller *ctlr,
 				 struct spi_device *spi,
 				 struct bcm2835_spi *bs,
-				 struct bcm2835_spidev *slv)
+				 struct bcm2835_spidev *target)
 {
 	int ret;
 
 	if (!ctlr->dma_rx)
 		return 0;
 
-	slv->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
-					    &slv->clear_rx_cs,
-					    sizeof(u32),
-					    DMA_TO_DEVICE);
-	if (dma_mapping_error(ctlr->dma_rx->device->dev, slv->clear_rx_addr)) {
+	target->clear_rx_addr = dma_map_single(ctlr->dma_rx->device->dev,
+					       &target->clear_rx_cs,
+					       sizeof(u32),
+					       DMA_TO_DEVICE);
+	if (dma_mapping_error(ctlr->dma_rx->device->dev, target->clear_rx_addr)) {
 		dev_err(&spi->dev, "cannot map clear_rx_cs\n");
-		slv->clear_rx_addr = 0;
+		target->clear_rx_addr = 0;
 		return -ENOMEM;
 	}
 
-	slv->clear_rx_desc = dmaengine_prep_dma_cyclic(ctlr->dma_rx,
-						       slv->clear_rx_addr,
-						       sizeof(u32), 0,
-						       DMA_MEM_TO_DEV, 0);
-	if (!slv->clear_rx_desc) {
+	target->clear_rx_desc = dmaengine_prep_dma_cyclic(ctlr->dma_rx,
+						          target->clear_rx_addr,
+						          sizeof(u32), 0,
+						          DMA_MEM_TO_DEV, 0);
+	if (!target->clear_rx_desc) {
 		dev_err(&spi->dev, "cannot prepare clear_rx_desc\n");
 		return -ENOMEM;
 	}
 
-	ret = dmaengine_desc_set_reuse(slv->clear_rx_desc);
+	ret = dmaengine_desc_set_reuse(target->clear_rx_desc);
 	if (ret) {
 		dev_err(&spi->dev, "cannot reuse clear_rx_desc\n");
 		return ret;
@@ -1220,26 +1220,26 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
-	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
+	struct bcm2835_spidev *target = spi_get_ctldata(spi);
 	struct gpio_chip *chip;
 	int ret;
 	u32 cs;
 
-	if (!slv) {
-		slv = kzalloc(ALIGN(sizeof(*slv), dma_get_cache_alignment()),
+	if (!target) {
+		target = kzalloc(ALIGN(sizeof(*target), dma_get_cache_alignment()),
 			      GFP_KERNEL);
-		if (!slv)
+		if (!target)
 			return -ENOMEM;
 
-		spi_set_ctldata(spi, slv);
+		spi_set_ctldata(spi, target);
 
-		ret = bcm2835_spi_setup_dma(ctlr, spi, bs, slv);
+		ret = bcm2835_spi_setup_dma(ctlr, spi, bs, target);
 		if (ret)
 			goto err_cleanup;
 	}
 
 	/*
-	 * Precalculate SPI slave's CS register value for ->prepare_message():
+	 * Precalculate SPI target's CS register value for ->prepare_message():
 	 * The driver always uses software-controlled GPIO chip select, hence
 	 * set the hardware-controlled native chip select to an invalid value
 	 * to prevent it from interfering.
@@ -1249,18 +1249,18 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 		cs |= BCM2835_SPI_CS_CPOL;
 	if (spi->mode & SPI_CPHA)
 		cs |= BCM2835_SPI_CS_CPHA;
-	slv->prepare_cs = cs;
+	target->prepare_cs = cs;
 
 	/*
-	 * Precalculate SPI slave's CS register value to clear RX FIFO
+	 * Precalculate SPI target's CS register value to clear RX FIFO
 	 * in case of a TX-only DMA transfer.
 	 */
 	if (ctlr->dma_rx) {
-		slv->clear_rx_cs = cs | BCM2835_SPI_CS_TA |
+		target->clear_rx_cs = cs | BCM2835_SPI_CS_TA |
 					BCM2835_SPI_CS_DMAEN |
 					BCM2835_SPI_CS_CLEAR_RX;
 		dma_sync_single_for_device(ctlr->dma_rx->device->dev,
-					   slv->clear_rx_addr,
+					   target->clear_rx_addr,
 					   sizeof(u32),
 					   DMA_TO_DEVICE);
 	}
@@ -1328,7 +1328,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	struct bcm2835_spi *bs;
 	int err;
 
-	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*bs));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

