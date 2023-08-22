Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C901E783773
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjHVBir (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjHVBip (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D2A101
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:41 -0700 (PDT)
Received: from dggpemm100020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVBm83wfBz1L9YK;
        Tue, 22 Aug 2023 09:37:12 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100020.china.huawei.com (7.185.36.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:40 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 07/24] spi: sun6i: switch to use modern name
Date:   Tue, 22 Aug 2023 09:34:54 +0800
Message-ID: <20230822013511.4161475-8-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822013511.4161475-1-yangyingliang@huawei.com>
References: <20230822013511.4161475-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 drivers/spi/spi-sun6i.c | 146 ++++++++++++++++++++--------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 3f5b1556ece0..755c6eea3352 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -97,7 +97,7 @@ struct sun6i_spi_cfg {
 };
 
 struct sun6i_spi {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	void __iomem		*base_addr;
 	dma_addr_t		dma_addr_rx;
 	dma_addr_t		dma_addr_tx;
@@ -180,7 +180,7 @@ static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi)
 
 static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
@@ -204,7 +204,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 				 struct spi_transfer *tfr)
 {
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
-	struct spi_master *master = sspi->master;
+	struct spi_controller *host = sspi->host;
 
 	rxdesc = NULL;
 	if (tfr->rx_buf) {
@@ -215,9 +215,9 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 			.src_maxburst = 8,
 		};
 
-		dmaengine_slave_config(master->dma_rx, &rxconf);
+		dmaengine_slave_config(host->dma_rx, &rxconf);
 
-		rxdesc = dmaengine_prep_slave_sg(master->dma_rx,
+		rxdesc = dmaengine_prep_slave_sg(host->dma_rx,
 						 tfr->rx_sg.sgl,
 						 tfr->rx_sg.nents,
 						 DMA_DEV_TO_MEM,
@@ -235,38 +235,38 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 			.dst_maxburst = 8,
 		};
 
-		dmaengine_slave_config(master->dma_tx, &txconf);
+		dmaengine_slave_config(host->dma_tx, &txconf);
 
-		txdesc = dmaengine_prep_slave_sg(master->dma_tx,
+		txdesc = dmaengine_prep_slave_sg(host->dma_tx,
 						 tfr->tx_sg.sgl,
 						 tfr->tx_sg.nents,
 						 DMA_MEM_TO_DEV,
 						 DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
-				dmaengine_terminate_sync(master->dma_rx);
+				dmaengine_terminate_sync(host->dma_rx);
 			return -EINVAL;
 		}
 	}
 
 	if (tfr->rx_buf) {
 		dmaengine_submit(rxdesc);
-		dma_async_issue_pending(master->dma_rx);
+		dma_async_issue_pending(host->dma_rx);
 	}
 
 	if (tfr->tx_buf) {
 		dmaengine_submit(txdesc);
-		dma_async_issue_pending(master->dma_tx);
+		dma_async_issue_pending(host->dma_tx);
 	}
 
 	return 0;
 }
 
-static int sun6i_spi_transfer_one(struct spi_master *master,
+static int sun6i_spi_transfer_one(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
 	unsigned int div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
@@ -282,7 +282,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
-	use_dma = master->can_dma ? master->can_dma(master, spi, tfr) : false;
+	use_dma = host->can_dma ? host->can_dma(host, spi, tfr) : false;
 
 	/* Clear pending interrupts */
 	sun6i_spi_write(sspi, SUN6I_INT_STA_REG, ~0);
@@ -452,7 +452,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	} else {
 		ret = sun6i_spi_prepare_dma(sspi, tfr);
 		if (ret) {
-			dev_warn(&master->dev,
+			dev_warn(&host->dev,
 				 "%s: prepare DMA failed, ret=%d",
 				 dev_name(&spi->dev), ret);
 			return ret;
@@ -475,13 +475,13 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
 
-	tx_time = spi_controller_xfer_timeout(master, tfr);
+	tx_time = spi_controller_xfer_timeout(host, tfr);
 	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
 					      msecs_to_jiffies(tx_time));
 	end = jiffies;
 	if (!timeout) {
-		dev_warn(&master->dev,
+		dev_warn(&host->dev,
 			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
 			 jiffies_to_msecs(end - start), tx_time);
@@ -491,8 +491,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
 
 	if (ret && use_dma) {
-		dmaengine_terminate_sync(master->dma_rx);
-		dmaengine_terminate_sync(master->dma_tx);
+		dmaengine_terminate_sync(host->dma_rx);
+		dmaengine_terminate_sync(host->dma_tx);
 	}
 
 	return ret;
@@ -538,8 +538,8 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 
 static int sun6i_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(sspi->hclk);
@@ -575,8 +575,8 @@ static int sun6i_spi_runtime_resume(struct device *dev)
 
 static int sun6i_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
 
 	reset_control_assert(sspi->rstc);
 	clk_disable_unprepare(sspi->mclk);
@@ -585,11 +585,11 @@ static int sun6i_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static bool sun6i_spi_can_dma(struct spi_master *master,
+static bool sun6i_spi_can_dma(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *xfer)
 {
-	struct sun6i_spi *sspi = spi_master_get_devdata(master);
+	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
 
 	/*
 	 * If the number of spi words to transfer is less or equal than
@@ -601,67 +601,67 @@ static bool sun6i_spi_can_dma(struct spi_master *master,
 
 static int sun6i_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct sun6i_spi *sspi;
 	struct resource *mem;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun6i_spi));
-	if (!master) {
-		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(struct sun6i_spi));
+	if (!host) {
+		dev_err(&pdev->dev, "Unable to allocate SPI Host\n");
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(pdev, master);
-	sspi = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, host);
+	sspi = spi_controller_get_devdata(host);
 
 	sspi->base_addr = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(sspi->base_addr)) {
 		ret = PTR_ERR(sspi->base_addr);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENXIO;
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_spi_handler,
 			       0, "sun6i-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
-	sspi->master = master;
+	sspi->host = host;
 	sspi->cfg = of_device_get_match_data(&pdev->dev);
 
-	master->max_speed_hz = 100 * 1000 * 1000;
-	master->min_speed_hz = 3 * 1000;
-	master->use_gpio_descriptors = true;
-	master->set_cs = sun6i_spi_set_cs;
-	master->transfer_one = sun6i_spi_transfer_one;
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    sspi->cfg->mode_bits;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun6i_spi_max_transfer_size;
+	host->max_speed_hz = 100 * 1000 * 1000;
+	host->min_speed_hz = 3 * 1000;
+	host->use_gpio_descriptors = true;
+	host->set_cs = sun6i_spi_set_cs;
+	host->transfer_one = sun6i_spi_transfer_one;
+	host->num_chipselect = 4;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			  sspi->cfg->mode_bits;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->dev.of_node = pdev->dev.of_node;
+	host->auto_runtime_pm = true;
+	host->max_transfer_size = sun6i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
 		dev_err(&pdev->dev, "Unable to acquire AHB clock\n");
 		ret = PTR_ERR(sspi->hclk);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	sspi->mclk = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(sspi->mclk)) {
 		dev_err(&pdev->dev, "Unable to acquire module clock\n");
 		ret = PTR_ERR(sspi->mclk);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	init_completion(&sspi->done);
@@ -670,34 +670,34 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(sspi->rstc)) {
 		dev_err(&pdev->dev, "Couldn't get reset controller\n");
 		ret = PTR_ERR(sspi->rstc);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
-	master->dma_tx = dma_request_chan(&pdev->dev, "tx");
-	if (IS_ERR(master->dma_tx)) {
+	host->dma_tx = dma_request_chan(&pdev->dev, "tx");
+	if (IS_ERR(host->dma_tx)) {
 		/* Check tx to see if we need defer probing driver */
-		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER) {
+		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_free_master;
+			goto err_free_host;
 		}
 		dev_warn(&pdev->dev, "Failed to request TX DMA channel\n");
-		master->dma_tx = NULL;
+		host->dma_tx = NULL;
 	}
 
-	master->dma_rx = dma_request_chan(&pdev->dev, "rx");
-	if (IS_ERR(master->dma_rx)) {
-		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER) {
+	host->dma_rx = dma_request_chan(&pdev->dev, "rx");
+	if (IS_ERR(host->dma_rx)) {
+		if (PTR_ERR(host->dma_rx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			goto err_free_dma_tx;
 		}
 		dev_warn(&pdev->dev, "Failed to request RX DMA channel\n");
-		master->dma_rx = NULL;
+		host->dma_rx = NULL;
 	}
 
-	if (master->dma_tx && master->dma_rx) {
+	if (host->dma_tx && host->dma_rx) {
 		sspi->dma_addr_tx = mem->start + SUN6I_TXDATA_REG;
 		sspi->dma_addr_rx = mem->start + SUN6I_RXDATA_REG;
-		master->can_dma = sun6i_spi_can_dma;
+		host->can_dma = sun6i_spi_can_dma;
 	}
 
 	/*
@@ -715,9 +715,9 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot register SPI master\n");
+		dev_err(&pdev->dev, "cannot register SPI host\n");
 		goto err_pm_disable;
 	}
 
@@ -727,26 +727,26 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	sun6i_spi_runtime_suspend(&pdev->dev);
 err_free_dma_rx:
-	if (master->dma_rx)
-		dma_release_channel(master->dma_rx);
+	if (host->dma_rx)
+		dma_release_channel(host->dma_rx);
 err_free_dma_tx:
-	if (master->dma_tx)
-		dma_release_channel(master->dma_tx);
-err_free_master:
-	spi_master_put(master);
+	if (host->dma_tx)
+		dma_release_channel(host->dma_tx);
+err_free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void sun6i_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_controller *host = platform_get_drvdata(pdev);
 
 	pm_runtime_force_suspend(&pdev->dev);
 
-	if (master->dma_tx)
-		dma_release_channel(master->dma_tx);
-	if (master->dma_rx)
-		dma_release_channel(master->dma_rx);
+	if (host->dma_tx)
+		dma_release_channel(host->dma_tx);
+	if (host->dma_rx)
+		dma_release_channel(host->dma_rx);
 }
 
 static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
-- 
2.25.1

