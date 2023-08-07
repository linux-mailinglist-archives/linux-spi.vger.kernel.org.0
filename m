Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ED5772487
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 14:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjHGMoc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 08:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjHGMoW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 08:44:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E71724
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 05:44:14 -0700 (PDT)
Received: from dggpemm100005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKGFM3GlXzfbnZ;
        Mon,  7 Aug 2023 20:43:03 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:44:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 20:44:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 15/20] spi: img-spfi: switch to use modern name
Date:   Mon, 7 Aug 2023 20:41:00 +0800
Message-ID: <20230807124105.3429709-16-yangyingliang@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-img-spfi.c | 118 ++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index d775f87770e3..d8360f94d3b7 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -86,7 +86,7 @@
 
 struct img_spfi {
 	struct device *dev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	spinlock_t lock;
 
 	void __iomem *regs;
@@ -221,11 +221,11 @@ static unsigned int spfi_pio_read8(struct img_spfi *spfi, u8 *buf,
 	return count;
 }
 
-static int img_spfi_start_pio(struct spi_master *master,
+static int img_spfi_start_pio(struct spi_controller *host,
 			       struct spi_device *spi,
 			       struct spi_transfer *xfer)
 {
-	struct img_spfi *spfi = spi_master_get_devdata(spi->master);
+	struct img_spfi *spfi = spi_controller_get_devdata(spi->controller);
 	unsigned int tx_bytes = 0, rx_bytes = 0;
 	const void *tx_buf = xfer->tx_buf;
 	void *rx_buf = xfer->rx_buf;
@@ -285,7 +285,7 @@ static void img_spfi_dma_rx_cb(void *data)
 	spin_lock_irqsave(&spfi->lock, flags);
 	spfi->rx_dma_busy = false;
 	if (!spfi->tx_dma_busy)
-		spi_finalize_current_transfer(spfi->master);
+		spi_finalize_current_transfer(spfi->host);
 	spin_unlock_irqrestore(&spfi->lock, flags);
 }
 
@@ -299,15 +299,15 @@ static void img_spfi_dma_tx_cb(void *data)
 	spin_lock_irqsave(&spfi->lock, flags);
 	spfi->tx_dma_busy = false;
 	if (!spfi->rx_dma_busy)
-		spi_finalize_current_transfer(spfi->master);
+		spi_finalize_current_transfer(spfi->host);
 	spin_unlock_irqrestore(&spfi->lock, flags);
 }
 
-static int img_spfi_start_dma(struct spi_master *master,
+static int img_spfi_start_dma(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *xfer)
 {
-	struct img_spfi *spfi = spi_master_get_devdata(spi->master);
+	struct img_spfi *spfi = spi_controller_get_devdata(spi->controller);
 	struct dma_async_tx_descriptor *rxdesc = NULL, *txdesc = NULL;
 	struct dma_slave_config rxconf, txconf;
 
@@ -384,10 +384,10 @@ static int img_spfi_start_dma(struct spi_master *master,
 	return -EIO;
 }
 
-static void img_spfi_handle_err(struct spi_master *master,
+static void img_spfi_handle_err(struct spi_controller *host,
 				struct spi_message *msg)
 {
-	struct img_spfi *spfi = spi_master_get_devdata(master);
+	struct img_spfi *spfi = spi_controller_get_devdata(host);
 	unsigned long flags;
 
 	/*
@@ -405,9 +405,9 @@ static void img_spfi_handle_err(struct spi_master *master,
 	spin_unlock_irqrestore(&spfi->lock, flags);
 }
 
-static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
+static int img_spfi_prepare(struct spi_controller *host, struct spi_message *msg)
 {
-	struct img_spfi *spfi = spi_master_get_devdata(master);
+	struct img_spfi *spfi = spi_controller_get_devdata(host);
 	u32 val;
 
 	val = spfi_readl(spfi, SPFI_PORT_STATE);
@@ -427,20 +427,20 @@ static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 	return 0;
 }
 
-static int img_spfi_unprepare(struct spi_master *master,
+static int img_spfi_unprepare(struct spi_controller *host,
 			      struct spi_message *msg)
 {
-	struct img_spfi *spfi = spi_master_get_devdata(master);
+	struct img_spfi *spfi = spi_controller_get_devdata(host);
 
 	spfi_reset(spfi);
 
 	return 0;
 }
 
-static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
+static void img_spfi_config(struct spi_controller *host, struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
-	struct img_spfi *spfi = spi_master_get_devdata(spi->master);
+	struct img_spfi *spfi = spi_controller_get_devdata(spi->controller);
 	u32 val, div;
 
 	/*
@@ -476,11 +476,11 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 	spfi_writel(spfi, val, SPFI_CONTROL);
 }
 
-static int img_spfi_transfer_one(struct spi_master *master,
+static int img_spfi_transfer_one(struct spi_controller *host,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
 {
-	struct img_spfi *spfi = spi_master_get_devdata(spi->master);
+	struct img_spfi *spfi = spi_controller_get_devdata(spi->controller);
 	int ret;
 
 	if (xfer->len > SPFI_TRANSACTION_TSIZE_MASK) {
@@ -490,16 +490,16 @@ static int img_spfi_transfer_one(struct spi_master *master,
 		return -EINVAL;
 	}
 
-	img_spfi_config(master, spi, xfer);
-	if (master->can_dma && master->can_dma(master, spi, xfer))
-		ret = img_spfi_start_dma(master, spi, xfer);
+	img_spfi_config(host, spi, xfer);
+	if (host->can_dma && host->can_dma(host, spi, xfer))
+		ret = img_spfi_start_dma(host, spi, xfer);
 	else
-		ret = img_spfi_start_pio(master, spi, xfer);
+		ret = img_spfi_start_pio(host, spi, xfer);
 
 	return ret;
 }
 
-static bool img_spfi_can_dma(struct spi_master *master, struct spi_device *spi,
+static bool img_spfi_can_dma(struct spi_controller *host, struct spi_device *spi,
 			     struct spi_transfer *xfer)
 {
 	if (xfer->len > SPFI_32BIT_FIFO_SIZE)
@@ -524,20 +524,20 @@ static irqreturn_t img_spfi_irq(int irq, void *dev_id)
 
 static int img_spfi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct img_spfi *spfi;
 	struct resource *res;
 	int ret;
 	u32 max_speed_hz;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spfi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*spfi));
+	if (!host)
 		return -ENOMEM;
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	spfi = spi_master_get_devdata(master);
+	spfi = spi_controller_get_devdata(host);
 	spfi->dev = &pdev->dev;
-	spfi->master = master;
+	spfi->host = host;
 	spin_lock_init(&spfi->lock);
 
 	spfi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -582,15 +582,15 @@ static int img_spfi_probe(struct platform_device *pdev)
 	 */
 	spfi_writel(spfi, SPFI_INTERRUPT_IACCESS, SPFI_INTERRUPT_ENABLE);
 
-	master->auto_runtime_pm = true;
-	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL;
+	host->auto_runtime_pm = true;
+	host->bus_num = pdev->id;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL;
 	if (of_property_read_bool(spfi->dev->of_node, "img,supports-quad-mode"))
-		master->mode_bits |= SPI_TX_QUAD | SPI_RX_QUAD;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(8);
-	master->max_speed_hz = clk_get_rate(spfi->spfi_clk) / 4;
-	master->min_speed_hz = clk_get_rate(spfi->spfi_clk) / 512;
+		host->mode_bits |= SPI_TX_QUAD | SPI_RX_QUAD;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(8);
+	host->max_speed_hz = clk_get_rate(spfi->spfi_clk) / 4;
+	host->min_speed_hz = clk_get_rate(spfi->spfi_clk) / 512;
 
 	/*
 	 * Maximum speed supported by spfi is limited to the lower value
@@ -601,15 +601,15 @@ static int img_spfi_probe(struct platform_device *pdev)
 	 */
 	if (!of_property_read_u32(spfi->dev->of_node, "spfi-max-frequency",
 				  &max_speed_hz)) {
-		if (master->max_speed_hz > max_speed_hz)
-			master->max_speed_hz = max_speed_hz;
+		if (host->max_speed_hz > max_speed_hz)
+			host->max_speed_hz = max_speed_hz;
 	}
 
-	master->transfer_one = img_spfi_transfer_one;
-	master->prepare_message = img_spfi_prepare;
-	master->unprepare_message = img_spfi_unprepare;
-	master->handle_err = img_spfi_handle_err;
-	master->use_gpio_descriptors = true;
+	host->transfer_one = img_spfi_transfer_one;
+	host->prepare_message = img_spfi_prepare;
+	host->unprepare_message = img_spfi_unprepare;
+	host->handle_err = img_spfi_handle_err;
+	host->use_gpio_descriptors = true;
 
 	spfi->tx_ch = dma_request_chan(spfi->dev, "tx");
 	if (IS_ERR(spfi->tx_ch)) {
@@ -636,15 +636,15 @@ static int img_spfi_probe(struct platform_device *pdev)
 		spfi->rx_ch = NULL;
 		dev_warn(spfi->dev, "Failed to get DMA channels, falling back to PIO mode\n");
 	} else {
-		master->dma_tx = spfi->tx_ch;
-		master->dma_rx = spfi->rx_ch;
-		master->can_dma = img_spfi_can_dma;
+		host->dma_tx = spfi->tx_ch;
+		host->dma_rx = spfi->rx_ch;
+		host->can_dma = img_spfi_can_dma;
 	}
 
 	pm_runtime_set_active(spfi->dev);
 	pm_runtime_enable(spfi->dev);
 
-	ret = devm_spi_register_master(spfi->dev, master);
+	ret = devm_spi_register_controller(spfi->dev, host);
 	if (ret)
 		goto disable_pm;
 
@@ -660,15 +660,15 @@ static int img_spfi_probe(struct platform_device *pdev)
 disable_pclk:
 	clk_disable_unprepare(spfi->sys_clk);
 put_spi:
-	spi_master_put(master);
+	spi_controller_put(host);
 
 	return ret;
 }
 
 static void img_spfi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct img_spfi *spfi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct img_spfi *spfi = spi_controller_get_devdata(host);
 
 	if (spfi->tx_ch)
 		dma_release_channel(spfi->tx_ch);
@@ -685,8 +685,8 @@ static void img_spfi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int img_spfi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct img_spfi *spfi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct img_spfi *spfi = spi_controller_get_devdata(host);
 
 	clk_disable_unprepare(spfi->spfi_clk);
 	clk_disable_unprepare(spfi->sys_clk);
@@ -696,8 +696,8 @@ static int img_spfi_runtime_suspend(struct device *dev)
 
 static int img_spfi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct img_spfi *spfi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct img_spfi *spfi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(spfi->sys_clk);
@@ -716,15 +716,15 @@ static int img_spfi_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int img_spfi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 
-	return spi_master_suspend(master);
+	return spi_controller_suspend(host);
 }
 
 static int img_spfi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct img_spfi *spfi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct img_spfi *spfi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -733,7 +733,7 @@ static int img_spfi_resume(struct device *dev)
 	spfi_reset(spfi);
 	pm_runtime_put(dev);
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.25.1

