Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B0772475
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjHGMoO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjHGMoN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457EF10FD
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:10 -0700 (PDT)
Received: from dggpemm100016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKGFH4Tnfz1KCNY;
        Mon,  7 Aug 2023 20:42:59 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100016.china.huawei.com (7.185.36.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:08 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 03/20] spi: ep93xx: switch to use modern name
Date:   Mon, 7 Aug 2023 20:40:48 +0800
Message-ID: <20230807124105.3429709-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230807124105.3429709-1-yangyingliang@huawei.com>
References: <20230807124105.3429709-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ep93xx.c | 174 +++++++++++++++++++--------------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 3693b3d425c7..a1d60e51c053 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -104,15 +104,15 @@ struct ep93xx_spi {
 
 /**
  * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
- * @master: SPI master
+ * @host: SPI host
  * @rate: desired SPI output clock rate
  * @div_cpsr: pointer to return the cpsr (pre-scaler) divider
  * @div_scr: pointer to return the scr divider
  */
-static int ep93xx_spi_calc_divisors(struct spi_master *master,
+static int ep93xx_spi_calc_divisors(struct spi_controller *host,
 				    u32 rate, u8 *div_cpsr, u8 *div_scr)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	unsigned long spi_clk_rate = clk_get_rate(espi->clk);
 	int cpsr, scr;
 
@@ -120,7 +120,7 @@ static int ep93xx_spi_calc_divisors(struct spi_master *master,
 	 * Make sure that max value is between values supported by the
 	 * controller.
 	 */
-	rate = clamp(rate, master->min_speed_hz, master->max_speed_hz);
+	rate = clamp(rate, host->min_speed_hz, host->max_speed_hz);
 
 	/*
 	 * Calculate divisors so that we can get speed according the
@@ -143,18 +143,18 @@ static int ep93xx_spi_calc_divisors(struct spi_master *master,
 	return -EINVAL;
 }
 
-static int ep93xx_spi_chip_setup(struct spi_master *master,
+static int ep93xx_spi_chip_setup(struct spi_controller *host,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	u8 dss = bits_per_word_to_dss(xfer->bits_per_word);
 	u8 div_cpsr = 0;
 	u8 div_scr = 0;
 	u16 cr0;
 	int err;
 
-	err = ep93xx_spi_calc_divisors(master, xfer->speed_hz,
+	err = ep93xx_spi_calc_divisors(host, xfer->speed_hz,
 				       &div_cpsr, &div_scr);
 	if (err)
 		return err;
@@ -166,9 +166,9 @@ static int ep93xx_spi_chip_setup(struct spi_master *master,
 		cr0 |= SSPCR0_SPH;
 	cr0 |= dss;
 
-	dev_dbg(&master->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
+	dev_dbg(&host->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
 		spi->mode, div_cpsr, div_scr, dss);
-	dev_dbg(&master->dev, "setup: cr0 %#x\n", cr0);
+	dev_dbg(&host->dev, "setup: cr0 %#x\n", cr0);
 
 	writel(div_cpsr, espi->mmio + SSPCPSR);
 	writel(cr0, espi->mmio + SSPCR0);
@@ -176,10 +176,10 @@ static int ep93xx_spi_chip_setup(struct spi_master *master,
 	return 0;
 }
 
-static void ep93xx_do_write(struct spi_master *master)
+static void ep93xx_do_write(struct spi_controller *host)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_transfer *xfer = master->cur_msg->state;
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
+	struct spi_transfer *xfer = host->cur_msg->state;
 	u32 val = 0;
 
 	if (xfer->bits_per_word > 8) {
@@ -194,10 +194,10 @@ static void ep93xx_do_write(struct spi_master *master)
 	writel(val, espi->mmio + SSPDR);
 }
 
-static void ep93xx_do_read(struct spi_master *master)
+static void ep93xx_do_read(struct spi_controller *host)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_transfer *xfer = master->cur_msg->state;
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
+	struct spi_transfer *xfer = host->cur_msg->state;
 	u32 val;
 
 	val = readl(espi->mmio + SSPDR);
@@ -214,7 +214,7 @@ static void ep93xx_do_read(struct spi_master *master)
 
 /**
  * ep93xx_spi_read_write() - perform next RX/TX transfer
- * @master: SPI master
+ * @host: SPI host
  *
  * This function transfers next bytes (or half-words) to/from RX/TX FIFOs. If
  * called several times, the whole transfer will be completed. Returns
@@ -223,20 +223,20 @@ static void ep93xx_do_read(struct spi_master *master)
  * When this function is finished, RX FIFO should be empty and TX FIFO should be
  * full.
  */
-static int ep93xx_spi_read_write(struct spi_master *master)
+static int ep93xx_spi_read_write(struct spi_controller *host)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_transfer *xfer = master->cur_msg->state;
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
+	struct spi_transfer *xfer = host->cur_msg->state;
 
 	/* read as long as RX FIFO has frames in it */
 	while ((readl(espi->mmio + SSPSR) & SSPSR_RNE)) {
-		ep93xx_do_read(master);
+		ep93xx_do_read(host);
 		espi->fifo_level--;
 	}
 
 	/* write as long as TX FIFO has room */
 	while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < xfer->len) {
-		ep93xx_do_write(master);
+		ep93xx_do_write(host);
 		espi->fifo_level++;
 	}
 
@@ -261,7 +261,7 @@ ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
 
 /**
  * ep93xx_spi_dma_prepare() - prepares a DMA transfer
- * @master: SPI master
+ * @host: SPI host
  * @dir: DMA transfer direction
  *
  * Function configures the DMA, maps the buffer and prepares the DMA
@@ -269,11 +269,11 @@ ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
  * in case of failure.
  */
 static struct dma_async_tx_descriptor *
-ep93xx_spi_dma_prepare(struct spi_master *master,
+ep93xx_spi_dma_prepare(struct spi_controller *host,
 		       enum dma_data_direction dir)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
-	struct spi_transfer *xfer = master->cur_msg->state;
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
+	struct spi_transfer *xfer = host->cur_msg->state;
 	struct dma_async_tx_descriptor *txd;
 	enum dma_slave_buswidth buswidth;
 	struct dma_slave_config conf;
@@ -348,7 +348,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 	}
 
 	if (WARN_ON(len)) {
-		dev_warn(&master->dev, "len = %zu expected 0!\n", len);
+		dev_warn(&host->dev, "len = %zu expected 0!\n", len);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -367,16 +367,16 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 
 /**
  * ep93xx_spi_dma_finish() - finishes with a DMA transfer
- * @master: SPI master
+ * @host: SPI host
  * @dir: DMA transfer direction
  *
  * Function finishes with the DMA transfer. After this, the DMA buffer is
  * unmapped.
  */
-static void ep93xx_spi_dma_finish(struct spi_master *master,
+static void ep93xx_spi_dma_finish(struct spi_controller *host,
 				  enum dma_data_direction dir)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	struct dma_chan *chan;
 	struct sg_table *sgt;
 
@@ -393,35 +393,35 @@ static void ep93xx_spi_dma_finish(struct spi_master *master,
 
 static void ep93xx_spi_dma_callback(void *callback_param)
 {
-	struct spi_master *master = callback_param;
+	struct spi_controller *host = callback_param;
 
-	ep93xx_spi_dma_finish(master, DMA_TO_DEVICE);
-	ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
+	ep93xx_spi_dma_finish(host, DMA_TO_DEVICE);
+	ep93xx_spi_dma_finish(host, DMA_FROM_DEVICE);
 
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 }
 
-static int ep93xx_spi_dma_transfer(struct spi_master *master)
+static int ep93xx_spi_dma_transfer(struct spi_controller *host)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	struct dma_async_tx_descriptor *rxd, *txd;
 
-	rxd = ep93xx_spi_dma_prepare(master, DMA_FROM_DEVICE);
+	rxd = ep93xx_spi_dma_prepare(host, DMA_FROM_DEVICE);
 	if (IS_ERR(rxd)) {
-		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
+		dev_err(&host->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
 		return PTR_ERR(rxd);
 	}
 
-	txd = ep93xx_spi_dma_prepare(master, DMA_TO_DEVICE);
+	txd = ep93xx_spi_dma_prepare(host, DMA_TO_DEVICE);
 	if (IS_ERR(txd)) {
-		ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
-		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
+		ep93xx_spi_dma_finish(host, DMA_FROM_DEVICE);
+		dev_err(&host->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
 		return PTR_ERR(txd);
 	}
 
 	/* We are ready when RX is done */
 	rxd->callback = ep93xx_spi_dma_callback;
-	rxd->callback_param = master;
+	rxd->callback_param = host;
 
 	/* Now submit both descriptors and start DMA */
 	dmaengine_submit(rxd);
@@ -436,8 +436,8 @@ static int ep93xx_spi_dma_transfer(struct spi_master *master)
 
 static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_id;
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	u32 val;
 
 	/*
@@ -447,15 +447,15 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 	if (readl(espi->mmio + SSPIIR) & SSPIIR_RORIS) {
 		/* clear the overrun interrupt */
 		writel(0, espi->mmio + SSPICR);
-		dev_warn(&master->dev,
+		dev_warn(&host->dev,
 			 "receive overrun, aborting the message\n");
-		master->cur_msg->status = -EIO;
+		host->cur_msg->status = -EIO;
 	} else {
 		/*
 		 * Interrupt is either RX (RIS) or TX (TIS). For both cases we
 		 * simply execute next data transfer.
 		 */
-		if (ep93xx_spi_read_write(master)) {
+		if (ep93xx_spi_read_write(host)) {
 			/*
 			 * In normal case, there still is some processing left
 			 * for current transfer. Let's wait for the next
@@ -474,26 +474,26 @@ static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
 	val &= ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
 	writel(val, espi->mmio + SSPCR1);
 
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(host);
 
 	return IRQ_HANDLED;
 }
 
-static int ep93xx_spi_transfer_one(struct spi_master *master,
+static int ep93xx_spi_transfer_one(struct spi_controller *host,
 				   struct spi_device *spi,
 				   struct spi_transfer *xfer)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	u32 val;
 	int ret;
 
-	ret = ep93xx_spi_chip_setup(master, spi, xfer);
+	ret = ep93xx_spi_chip_setup(host, spi, xfer);
 	if (ret) {
-		dev_err(&master->dev, "failed to setup chip for transfer\n");
+		dev_err(&host->dev, "failed to setup chip for transfer\n");
 		return ret;
 	}
 
-	master->cur_msg->state = xfer;
+	host->cur_msg->state = xfer;
 	espi->rx = 0;
 	espi->tx = 0;
 
@@ -503,10 +503,10 @@ static int ep93xx_spi_transfer_one(struct spi_master *master,
 	 * So in these cases we will be using PIO and don't bother for DMA.
 	 */
 	if (espi->dma_rx && xfer->len > SPI_FIFO_SIZE)
-		return ep93xx_spi_dma_transfer(master);
+		return ep93xx_spi_dma_transfer(host);
 
 	/* Using PIO so prime the TX FIFO and enable interrupts */
-	ep93xx_spi_read_write(master);
+	ep93xx_spi_read_write(host);
 
 	val = readl(espi->mmio + SSPCR1);
 	val |= (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
@@ -516,10 +516,10 @@ static int ep93xx_spi_transfer_one(struct spi_master *master,
 	return 1;
 }
 
-static int ep93xx_spi_prepare_message(struct spi_master *master,
+static int ep93xx_spi_prepare_message(struct spi_controller *host,
 				      struct spi_message *msg)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	unsigned long timeout;
 
 	/*
@@ -528,7 +528,7 @@ static int ep93xx_spi_prepare_message(struct spi_master *master,
 	timeout = jiffies + msecs_to_jiffies(SPI_TIMEOUT);
 	while (readl(espi->mmio + SSPSR) & SSPSR_RNE) {
 		if (time_after(jiffies, timeout)) {
-			dev_warn(&master->dev,
+			dev_warn(&host->dev,
 				 "timeout while flushing RX FIFO\n");
 			return -ETIMEDOUT;
 		}
@@ -544,9 +544,9 @@ static int ep93xx_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static int ep93xx_spi_prepare_hardware(struct spi_master *master)
+static int ep93xx_spi_prepare_hardware(struct spi_controller *host)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	u32 val;
 	int ret;
 
@@ -561,9 +561,9 @@ static int ep93xx_spi_prepare_hardware(struct spi_master *master)
 	return 0;
 }
 
-static int ep93xx_spi_unprepare_hardware(struct spi_master *master)
+static int ep93xx_spi_unprepare_hardware(struct spi_controller *host)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 	u32 val;
 
 	val = readl(espi->mmio + SSPCR1);
@@ -646,7 +646,7 @@ static void ep93xx_spi_release_dma(struct ep93xx_spi *espi)
 
 static int ep93xx_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct ep93xx_spi_info *info;
 	struct ep93xx_spi *espi;
 	struct resource *res;
@@ -663,54 +663,54 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*espi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*espi));
+	if (!host)
 		return -ENOMEM;
 
-	master->use_gpio_descriptors = true;
-	master->prepare_transfer_hardware = ep93xx_spi_prepare_hardware;
-	master->unprepare_transfer_hardware = ep93xx_spi_unprepare_hardware;
-	master->prepare_message = ep93xx_spi_prepare_message;
-	master->transfer_one = ep93xx_spi_transfer_one;
-	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+	host->use_gpio_descriptors = true;
+	host->prepare_transfer_hardware = ep93xx_spi_prepare_hardware;
+	host->unprepare_transfer_hardware = ep93xx_spi_unprepare_hardware;
+	host->prepare_message = ep93xx_spi_prepare_message;
+	host->transfer_one = ep93xx_spi_transfer_one;
+	host->bus_num = pdev->id;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 	/*
 	 * The SPI core will count the number of GPIO descriptors to figure
 	 * out the number of chip selects available on the platform.
 	 */
-	master->num_chipselect = 0;
+	host->num_chipselect = 0;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	espi = spi_master_get_devdata(master);
+	espi = spi_controller_get_devdata(host);
 
 	espi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(espi->clk)) {
 		dev_err(&pdev->dev, "unable to get spi clock\n");
 		error = PTR_ERR(espi->clk);
-		goto fail_release_master;
+		goto fail_release_host;
 	}
 
 	/*
 	 * Calculate maximum and minimum supported clock rates
 	 * for the controller.
 	 */
-	master->max_speed_hz = clk_get_rate(espi->clk) / 2;
-	master->min_speed_hz = clk_get_rate(espi->clk) / (254 * 256);
+	host->max_speed_hz = clk_get_rate(espi->clk) / 2;
+	host->min_speed_hz = clk_get_rate(espi->clk) / (254 * 256);
 
 	espi->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(espi->mmio)) {
 		error = PTR_ERR(espi->mmio);
-		goto fail_release_master;
+		goto fail_release_host;
 	}
 	espi->sspdr_phys = res->start + SSPDR;
 
 	error = devm_request_irq(&pdev->dev, irq, ep93xx_spi_interrupt,
-				0, "ep93xx-spi", master);
+				0, "ep93xx-spi", host);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		goto fail_release_master;
+		goto fail_release_host;
 	}
 
 	if (info->use_dma && ep93xx_spi_setup_dma(espi))
@@ -719,9 +719,9 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	/* make sure that the hardware is disabled */
 	writel(0, espi->mmio + SSPCR1);
 
-	error = devm_spi_register_master(&pdev->dev, master);
+	error = devm_spi_register_controller(&pdev->dev, host);
 	if (error) {
-		dev_err(&pdev->dev, "failed to register SPI master\n");
+		dev_err(&pdev->dev, "failed to register SPI host\n");
 		goto fail_free_dma;
 	}
 
@@ -732,16 +732,16 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 fail_free_dma:
 	ep93xx_spi_release_dma(espi);
-fail_release_master:
-	spi_master_put(master);
+fail_release_host:
+	spi_controller_put(host);
 
 	return error;
 }
 
 static void ep93xx_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct ep93xx_spi *espi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 
 	ep93xx_spi_release_dma(espi);
 }
-- 
2.25.1

