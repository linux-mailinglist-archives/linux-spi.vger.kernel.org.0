Return-Path: <linux-spi+bounces-69-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE17FB5B3
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CE21C210C9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7848E46440;
	Tue, 28 Nov 2023 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04921D0
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:28 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SfcRM749VzLpf2;
	Tue, 28 Nov 2023 17:22:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:26 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:25 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 18/26] spi: uniphier: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:23 +0800
Message-ID: <20231128093031.3707034-19-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-uniphier.c | 194 ++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 97 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index f5344527af0b..4a18cf896194 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -26,7 +26,7 @@ struct uniphier_spi_priv {
 	void __iomem *base;
 	dma_addr_t base_dma_addr;
 	struct clk *clk;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct completion xfer_done;
 
 	int error;
@@ -127,7 +127,7 @@ static inline void uniphier_spi_irq_disable(struct uniphier_spi_priv *priv,
 
 static void uniphier_spi_set_mode(struct spi_device *spi)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 	u32 val1, val2;
 
 	/*
@@ -180,7 +180,7 @@ static void uniphier_spi_set_mode(struct spi_device *spi)
 
 static void uniphier_spi_set_transfer_size(struct spi_device *spi, int size)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 	u32 val;
 
 	val = readl(priv->base + SSI_TXWDS);
@@ -198,7 +198,7 @@ static void uniphier_spi_set_transfer_size(struct spi_device *spi, int size)
 static void uniphier_spi_set_baudrate(struct spi_device *spi,
 				      unsigned int speed)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 	u32 val, ckdiv;
 
 	/*
@@ -217,7 +217,7 @@ static void uniphier_spi_set_baudrate(struct spi_device *spi,
 static void uniphier_spi_setup_transfer(struct spi_device *spi,
 				       struct spi_transfer *t)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 	u32 val;
 
 	priv->error = 0;
@@ -333,7 +333,7 @@ static void uniphier_spi_fill_tx_fifo(struct uniphier_spi_priv *priv)
 
 static void uniphier_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(spi->controller);
 	u32 val;
 
 	val = readl(priv->base + SSI_FPS);
@@ -346,16 +346,16 @@ static void uniphier_spi_set_cs(struct spi_device *spi, bool enable)
 	writel(val, priv->base + SSI_FPS);
 }
 
-static bool uniphier_spi_can_dma(struct spi_master *master,
+static bool uniphier_spi_can_dma(struct spi_controller *host,
 				 struct spi_device *spi,
 				 struct spi_transfer *t)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 	unsigned int bpw = bytes_per_word(priv->bits_per_word);
 
-	if ((!master->dma_tx && !master->dma_rx)
-	    || (!master->dma_tx && t->tx_buf)
-	    || (!master->dma_rx && t->rx_buf))
+	if ((!host->dma_tx && !host->dma_rx)
+	    || (!host->dma_tx && t->tx_buf)
+	    || (!host->dma_rx && t->rx_buf))
 		return false;
 
 	return DIV_ROUND_UP(t->len, bpw) > SSI_FIFO_DEPTH;
@@ -363,33 +363,33 @@ static bool uniphier_spi_can_dma(struct spi_master *master,
 
 static void uniphier_spi_dma_rxcb(void *data)
 {
-	struct spi_master *master = data;
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct spi_controller *host = data;
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 	int state = atomic_fetch_andnot(SSI_DMA_RX_BUSY, &priv->dma_busy);
 
 	uniphier_spi_irq_disable(priv, SSI_IE_RXRE);
 
 	if (!(state & SSI_DMA_TX_BUSY))
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(host);
 }
 
 static void uniphier_spi_dma_txcb(void *data)
 {
-	struct spi_master *master = data;
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct spi_controller *host = data;
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 	int state = atomic_fetch_andnot(SSI_DMA_TX_BUSY, &priv->dma_busy);
 
 	uniphier_spi_irq_disable(priv, SSI_IE_TXRE);
 
 	if (!(state & SSI_DMA_RX_BUSY))
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(host);
 }
 
-static int uniphier_spi_transfer_one_dma(struct spi_master *master,
+static int uniphier_spi_transfer_one_dma(struct spi_controller *host,
 					 struct spi_device *spi,
 					 struct spi_transfer *t)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 	struct dma_async_tx_descriptor *rxdesc = NULL, *txdesc = NULL;
 	int buswidth;
 
@@ -412,23 +412,23 @@ static int uniphier_spi_transfer_one_dma(struct spi_master *master,
 			.src_maxburst = SSI_FIFO_BURST_NUM,
 		};
 
-		dmaengine_slave_config(master->dma_rx, &rxconf);
+		dmaengine_slave_config(host->dma_rx, &rxconf);
 
 		rxdesc = dmaengine_prep_slave_sg(
-			master->dma_rx,
+			host->dma_rx,
 			t->rx_sg.sgl, t->rx_sg.nents,
 			DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!rxdesc)
 			goto out_err_prep;
 
 		rxdesc->callback = uniphier_spi_dma_rxcb;
-		rxdesc->callback_param = master;
+		rxdesc->callback_param = host;
 
 		uniphier_spi_irq_enable(priv, SSI_IE_RXRE);
 		atomic_or(SSI_DMA_RX_BUSY, &priv->dma_busy);
 
 		dmaengine_submit(rxdesc);
-		dma_async_issue_pending(master->dma_rx);
+		dma_async_issue_pending(host->dma_rx);
 	}
 
 	if (priv->tx_buf) {
@@ -439,23 +439,23 @@ static int uniphier_spi_transfer_one_dma(struct spi_master *master,
 			.dst_maxburst = SSI_FIFO_BURST_NUM,
 		};
 
-		dmaengine_slave_config(master->dma_tx, &txconf);
+		dmaengine_slave_config(host->dma_tx, &txconf);
 
 		txdesc = dmaengine_prep_slave_sg(
-			master->dma_tx,
+			host->dma_tx,
 			t->tx_sg.sgl, t->tx_sg.nents,
 			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!txdesc)
 			goto out_err_prep;
 
 		txdesc->callback = uniphier_spi_dma_txcb;
-		txdesc->callback_param = master;
+		txdesc->callback_param = host;
 
 		uniphier_spi_irq_enable(priv, SSI_IE_TXRE);
 		atomic_or(SSI_DMA_TX_BUSY, &priv->dma_busy);
 
 		dmaengine_submit(txdesc);
-		dma_async_issue_pending(master->dma_tx);
+		dma_async_issue_pending(host->dma_tx);
 	}
 
 	/* signal that we need to wait for completion */
@@ -463,17 +463,17 @@ static int uniphier_spi_transfer_one_dma(struct spi_master *master,
 
 out_err_prep:
 	if (rxdesc)
-		dmaengine_terminate_sync(master->dma_rx);
+		dmaengine_terminate_sync(host->dma_rx);
 
 	return -EINVAL;
 }
 
-static int uniphier_spi_transfer_one_irq(struct spi_master *master,
+static int uniphier_spi_transfer_one_irq(struct spi_controller *host,
 					 struct spi_device *spi,
 					 struct spi_transfer *t)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
-	struct device *dev = master->dev.parent;
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
+	struct device *dev = host->dev.parent;
 	unsigned long time_left;
 
 	reinit_completion(&priv->xfer_done);
@@ -495,11 +495,11 @@ static int uniphier_spi_transfer_one_irq(struct spi_master *master,
 	return priv->error;
 }
 
-static int uniphier_spi_transfer_one_poll(struct spi_master *master,
+static int uniphier_spi_transfer_one_poll(struct spi_controller *host,
 					  struct spi_device *spi,
 					  struct spi_transfer *t)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 	int loop = SSI_POLL_TIMEOUT_US * 10;
 
 	while (priv->tx_bytes) {
@@ -520,14 +520,14 @@ static int uniphier_spi_transfer_one_poll(struct spi_master *master,
 	return 0;
 
 irq_transfer:
-	return uniphier_spi_transfer_one_irq(master, spi, t);
+	return uniphier_spi_transfer_one_irq(host, spi, t);
 }
 
-static int uniphier_spi_transfer_one(struct spi_master *master,
+static int uniphier_spi_transfer_one(struct spi_controller *host,
 				     struct spi_device *spi,
 				     struct spi_transfer *t)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 	unsigned long threshold;
 	bool use_dma;
 
@@ -537,9 +537,9 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 
 	uniphier_spi_setup_transfer(spi, t);
 
-	use_dma = master->can_dma ? master->can_dma(master, spi, t) : false;
+	use_dma = host->can_dma ? host->can_dma(host, spi, t) : false;
 	if (use_dma)
-		return uniphier_spi_transfer_one_dma(master, spi, t);
+		return uniphier_spi_transfer_one_dma(host, spi, t);
 
 	/*
 	 * If the transfer operation will take longer than
@@ -548,33 +548,33 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 	threshold = DIV_ROUND_UP(SSI_POLL_TIMEOUT_US * priv->speed_hz,
 					USEC_PER_SEC * BITS_PER_BYTE);
 	if (t->len > threshold)
-		return uniphier_spi_transfer_one_irq(master, spi, t);
+		return uniphier_spi_transfer_one_irq(host, spi, t);
 	else
-		return uniphier_spi_transfer_one_poll(master, spi, t);
+		return uniphier_spi_transfer_one_poll(host, spi, t);
 }
 
-static int uniphier_spi_prepare_transfer_hardware(struct spi_master *master)
+static int uniphier_spi_prepare_transfer_hardware(struct spi_controller *host)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 
 	writel(SSI_CTL_EN, priv->base + SSI_CTL);
 
 	return 0;
 }
 
-static int uniphier_spi_unprepare_transfer_hardware(struct spi_master *master)
+static int uniphier_spi_unprepare_transfer_hardware(struct spi_controller *host)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 
 	writel(0, priv->base + SSI_CTL);
 
 	return 0;
 }
 
-static void uniphier_spi_handle_err(struct spi_master *master,
+static void uniphier_spi_handle_err(struct spi_controller *host,
 				    struct spi_message *msg)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 	u32 val;
 
 	/* stop running spi transfer */
@@ -587,12 +587,12 @@ static void uniphier_spi_handle_err(struct spi_master *master,
 	uniphier_spi_irq_disable(priv, SSI_IE_ALL_MASK);
 
 	if (atomic_read(&priv->dma_busy) & SSI_DMA_TX_BUSY) {
-		dmaengine_terminate_async(master->dma_tx);
+		dmaengine_terminate_async(host->dma_tx);
 		atomic_andnot(SSI_DMA_TX_BUSY, &priv->dma_busy);
 	}
 
 	if (atomic_read(&priv->dma_busy) & SSI_DMA_RX_BUSY) {
-		dmaengine_terminate_async(master->dma_rx);
+		dmaengine_terminate_async(host->dma_rx);
 		atomic_andnot(SSI_DMA_RX_BUSY, &priv->dma_busy);
 	}
 }
@@ -641,7 +641,7 @@ static irqreturn_t uniphier_spi_handler(int irq, void *dev_id)
 static int uniphier_spi_probe(struct platform_device *pdev)
 {
 	struct uniphier_spi_priv *priv;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct resource *res;
 	struct dma_slave_caps caps;
 	u32 dma_tx_burst = 0, dma_rx_burst = 0;
@@ -649,20 +649,20 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*priv));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	priv = spi_master_get_devdata(master);
-	priv->master = master;
+	priv = spi_controller_get_devdata(host);
+	priv->host = host;
 	priv->is_save_param = false;
 
 	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
-		goto out_master_put;
+		goto out_host_put;
 	}
 	priv->base_dma_addr = res->start;
 
@@ -670,12 +670,12 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(priv->clk);
-		goto out_master_put;
+		goto out_host_put;
 	}
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
-		goto out_master_put;
+		goto out_host_put;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -694,35 +694,35 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	clk_rate = clk_get_rate(priv->clk);
 
-	master->max_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MIN_CLK_DIVIDER);
-	master->min_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MAX_CLK_DIVIDER);
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = pdev->id;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
+	host->max_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MIN_CLK_DIVIDER);
+	host->min_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MAX_CLK_DIVIDER);
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bus_num = pdev->id;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 
-	master->set_cs = uniphier_spi_set_cs;
-	master->transfer_one = uniphier_spi_transfer_one;
-	master->prepare_transfer_hardware
+	host->set_cs = uniphier_spi_set_cs;
+	host->transfer_one = uniphier_spi_transfer_one;
+	host->prepare_transfer_hardware
 				= uniphier_spi_prepare_transfer_hardware;
-	master->unprepare_transfer_hardware
+	host->unprepare_transfer_hardware
 				= uniphier_spi_unprepare_transfer_hardware;
-	master->handle_err = uniphier_spi_handle_err;
-	master->can_dma = uniphier_spi_can_dma;
+	host->handle_err = uniphier_spi_handle_err;
+	host->can_dma = uniphier_spi_can_dma;
 
-	master->num_chipselect = 1;
-	master->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+	host->num_chipselect = 1;
+	host->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 
-	master->dma_tx = dma_request_chan(&pdev->dev, "tx");
-	if (IS_ERR_OR_NULL(master->dma_tx)) {
-		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER) {
+	host->dma_tx = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR_OR_NULL(host->dma_tx)) {
+		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto out_disable_clk;
 		}
-		master->dma_tx = NULL;
+		host->dma_tx = NULL;
 		dma_tx_burst = INT_MAX;
 	} else {
-		ret = dma_get_slave_caps(master->dma_tx, &caps);
+		ret = dma_get_slave_caps(host->dma_tx, &caps);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get TX DMA capacities: %d\n",
 				ret);
@@ -731,16 +731,16 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 		dma_tx_burst = caps.max_burst;
 	}
 
-	master->dma_rx = dma_request_chan(&pdev->dev, "rx");
-	if (IS_ERR_OR_NULL(master->dma_rx)) {
-		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER) {
+	host->dma_rx = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR_OR_NULL(host->dma_rx)) {
+		if (PTR_ERR(host->dma_rx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto out_release_dma;
 		}
-		master->dma_rx = NULL;
+		host->dma_rx = NULL;
 		dma_rx_burst = INT_MAX;
 	} else {
-		ret = dma_get_slave_caps(master->dma_rx, &caps);
+		ret = dma_get_slave_caps(host->dma_rx, &caps);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get RX DMA capacities: %d\n",
 				ret);
@@ -749,41 +749,41 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 		dma_rx_burst = caps.max_burst;
 	}
 
-	master->max_dma_len = min(dma_tx_burst, dma_rx_burst);
+	host->max_dma_len = min(dma_tx_burst, dma_rx_burst);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret)
 		goto out_release_dma;
 
 	return 0;
 
 out_release_dma:
-	if (!IS_ERR_OR_NULL(master->dma_rx)) {
-		dma_release_channel(master->dma_rx);
-		master->dma_rx = NULL;
+	if (!IS_ERR_OR_NULL(host->dma_rx)) {
+		dma_release_channel(host->dma_rx);
+		host->dma_rx = NULL;
 	}
-	if (!IS_ERR_OR_NULL(master->dma_tx)) {
-		dma_release_channel(master->dma_tx);
-		master->dma_tx = NULL;
+	if (!IS_ERR_OR_NULL(host->dma_tx)) {
+		dma_release_channel(host->dma_tx);
+		host->dma_tx = NULL;
 	}
 
 out_disable_clk:
 	clk_disable_unprepare(priv->clk);
 
-out_master_put:
-	spi_master_put(master);
+out_host_put:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void uniphier_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
 
-	if (master->dma_tx)
-		dma_release_channel(master->dma_tx);
-	if (master->dma_rx)
-		dma_release_channel(master->dma_rx);
+	if (host->dma_tx)
+		dma_release_channel(host->dma_tx);
+	if (host->dma_rx)
+		dma_release_channel(host->dma_rx);
 
 	clk_disable_unprepare(priv->clk);
 }
-- 
2.25.1


