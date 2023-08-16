Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E1177DD93
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbjHPJnj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbjHPJn2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F391985
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:26 -0700 (PDT)
Received: from dggpemm100002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjnW0sxbzVk8Z;
        Wed, 16 Aug 2023 17:41:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:24 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 09/24] spi: qup: switch to use modern name
Date:   Wed, 16 Aug 2023 17:39:58 +0800
Message-ID: <20230816094013.1275068-10-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-qup.c | 166 +++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index fd16acb1f578..4b6f6b25219b 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -385,20 +385,20 @@ static void spi_qup_write(struct spi_qup *controller)
 	} while (remainder);
 }
 
-static int spi_qup_prep_sg(struct spi_master *master, struct scatterlist *sgl,
+static int spi_qup_prep_sg(struct spi_controller *host, struct scatterlist *sgl,
 			   unsigned int nents, enum dma_transfer_direction dir,
 			   dma_async_tx_callback callback)
 {
-	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct spi_qup *qup = spi_controller_get_devdata(host);
 	unsigned long flags = DMA_PREP_INTERRUPT | DMA_PREP_FENCE;
 	struct dma_async_tx_descriptor *desc;
 	struct dma_chan *chan;
 	dma_cookie_t cookie;
 
 	if (dir == DMA_MEM_TO_DEV)
-		chan = master->dma_tx;
+		chan = host->dma_tx;
 	else
-		chan = master->dma_rx;
+		chan = host->dma_rx;
 
 	desc = dmaengine_prep_slave_sg(chan, sgl, nents, dir, flags);
 	if (IS_ERR_OR_NULL(desc))
@@ -412,13 +412,13 @@ static int spi_qup_prep_sg(struct spi_master *master, struct scatterlist *sgl,
 	return dma_submit_error(cookie);
 }
 
-static void spi_qup_dma_terminate(struct spi_master *master,
+static void spi_qup_dma_terminate(struct spi_controller *host,
 				  struct spi_transfer *xfer)
 {
 	if (xfer->tx_buf)
-		dmaengine_terminate_all(master->dma_tx);
+		dmaengine_terminate_all(host->dma_tx);
 	if (xfer->rx_buf)
-		dmaengine_terminate_all(master->dma_rx);
+		dmaengine_terminate_all(host->dma_rx);
 }
 
 static u32 spi_qup_sgl_get_nents_len(struct scatterlist *sgl, u32 max,
@@ -445,8 +445,8 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
 	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
-	struct spi_master *master = spi->master;
-	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct spi_controller *host = spi->controller;
+	struct spi_qup *qup = spi_controller_get_devdata(host);
 	struct scatterlist *tx_sgl, *rx_sgl;
 	int ret;
 
@@ -481,20 +481,20 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			return ret;
 		}
 		if (rx_sgl) {
-			ret = spi_qup_prep_sg(master, rx_sgl, rx_nents,
+			ret = spi_qup_prep_sg(host, rx_sgl, rx_nents,
 					      DMA_DEV_TO_MEM, rx_done);
 			if (ret)
 				return ret;
-			dma_async_issue_pending(master->dma_rx);
+			dma_async_issue_pending(host->dma_rx);
 		}
 
 		if (tx_sgl) {
-			ret = spi_qup_prep_sg(master, tx_sgl, tx_nents,
+			ret = spi_qup_prep_sg(host, tx_sgl, tx_nents,
 					      DMA_MEM_TO_DEV, tx_done);
 			if (ret)
 				return ret;
 
-			dma_async_issue_pending(master->dma_tx);
+			dma_async_issue_pending(host->dma_tx);
 		}
 
 		if (!wait_for_completion_timeout(&qup->done, timeout))
@@ -513,8 +513,8 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
-	struct spi_master *master = spi->master;
-	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct spi_controller *host = spi->controller;
+	struct spi_qup *qup = spi_controller_get_devdata(host);
 	int ret, n_words, iterations, offset = 0;
 
 	n_words = qup->n_words;
@@ -658,7 +658,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 /* set clock freq ... bits per word, determine mode */
 static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct spi_qup *controller = spi_master_get_devdata(spi->master);
+	struct spi_qup *controller = spi_controller_get_devdata(spi->controller);
 	int ret;
 
 	if (spi->mode & SPI_LOOP && xfer->len > controller->in_fifo_sz) {
@@ -679,9 +679,9 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (controller->n_words <= (controller->in_fifo_sz / sizeof(u32)))
 		controller->mode = QUP_IO_M_MODE_FIFO;
-	else if (spi->master->can_dma &&
-		 spi->master->can_dma(spi->master, spi, xfer) &&
-		 spi->master->cur_msg_mapped)
+	else if (spi->controller->can_dma &&
+		 spi->controller->can_dma(spi->controller, spi, xfer) &&
+		 spi->controller->cur_msg_mapped)
 		controller->mode = QUP_IO_M_MODE_BAM;
 	else
 		controller->mode = QUP_IO_M_MODE_BLOCK;
@@ -692,7 +692,7 @@ static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 /* prep qup for another spi transaction of specific type */
 static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 {
-	struct spi_qup *controller = spi_master_get_devdata(spi->master);
+	struct spi_qup *controller = spi_controller_get_devdata(spi->controller);
 	u32 config, iomode, control;
 	unsigned long flags;
 
@@ -840,11 +840,11 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 	return 0;
 }
 
-static int spi_qup_transfer_one(struct spi_master *master,
+static int spi_qup_transfer_one(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *xfer)
 {
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	unsigned long timeout, flags;
 	int ret;
 
@@ -878,21 +878,21 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	spin_unlock_irqrestore(&controller->lock, flags);
 
 	if (ret && spi_qup_is_dma_xfer(controller->mode))
-		spi_qup_dma_terminate(master, xfer);
+		spi_qup_dma_terminate(host, xfer);
 
 	return ret;
 }
 
-static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
+static bool spi_qup_can_dma(struct spi_controller *host, struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
-	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct spi_qup *qup = spi_controller_get_devdata(host);
 	size_t dma_align = dma_get_cache_alignment();
 	int n_words;
 
 	if (xfer->rx_buf) {
 		if (!IS_ALIGNED((size_t)xfer->rx_buf, dma_align) ||
-		    IS_ERR_OR_NULL(master->dma_rx))
+		    IS_ERR_OR_NULL(host->dma_rx))
 			return false;
 		if (qup->qup_v1 && (xfer->len % qup->in_blk_sz))
 			return false;
@@ -900,7 +900,7 @@ static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
 
 	if (xfer->tx_buf) {
 		if (!IS_ALIGNED((size_t)xfer->tx_buf, dma_align) ||
-		    IS_ERR_OR_NULL(master->dma_tx))
+		    IS_ERR_OR_NULL(host->dma_tx))
 			return false;
 		if (qup->qup_v1 && (xfer->len % qup->out_blk_sz))
 			return false;
@@ -913,30 +913,30 @@ static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
 	return true;
 }
 
-static void spi_qup_release_dma(struct spi_master *master)
+static void spi_qup_release_dma(struct spi_controller *host)
 {
-	if (!IS_ERR_OR_NULL(master->dma_rx))
-		dma_release_channel(master->dma_rx);
-	if (!IS_ERR_OR_NULL(master->dma_tx))
-		dma_release_channel(master->dma_tx);
+	if (!IS_ERR_OR_NULL(host->dma_rx))
+		dma_release_channel(host->dma_rx);
+	if (!IS_ERR_OR_NULL(host->dma_tx))
+		dma_release_channel(host->dma_tx);
 }
 
-static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
+static int spi_qup_init_dma(struct spi_controller *host, resource_size_t base)
 {
-	struct spi_qup *spi = spi_master_get_devdata(master);
+	struct spi_qup *spi = spi_controller_get_devdata(host);
 	struct dma_slave_config *rx_conf = &spi->rx_conf,
 				*tx_conf = &spi->tx_conf;
 	struct device *dev = spi->dev;
 	int ret;
 
 	/* allocate dma resources, if available */
-	master->dma_rx = dma_request_chan(dev, "rx");
-	if (IS_ERR(master->dma_rx))
-		return PTR_ERR(master->dma_rx);
+	host->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(host->dma_rx))
+		return PTR_ERR(host->dma_rx);
 
-	master->dma_tx = dma_request_chan(dev, "tx");
-	if (IS_ERR(master->dma_tx)) {
-		ret = PTR_ERR(master->dma_tx);
+	host->dma_tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(host->dma_tx)) {
+		ret = PTR_ERR(host->dma_tx);
 		goto err_tx;
 	}
 
@@ -951,13 +951,13 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 	tx_conf->dst_addr = base + QUP_OUTPUT_FIFO;
 	tx_conf->dst_maxburst = spi->out_blk_sz;
 
-	ret = dmaengine_slave_config(master->dma_rx, rx_conf);
+	ret = dmaengine_slave_config(host->dma_rx, rx_conf);
 	if (ret) {
 		dev_err(dev, "failed to configure RX channel\n");
 		goto err;
 	}
 
-	ret = dmaengine_slave_config(master->dma_tx, tx_conf);
+	ret = dmaengine_slave_config(host->dma_tx, tx_conf);
 	if (ret) {
 		dev_err(dev, "failed to configure TX channel\n");
 		goto err;
@@ -966,9 +966,9 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 	return 0;
 
 err:
-	dma_release_channel(master->dma_tx);
+	dma_release_channel(host->dma_tx);
 err_tx:
-	dma_release_channel(master->dma_rx);
+	dma_release_channel(host->dma_rx);
 	return ret;
 }
 
@@ -978,7 +978,7 @@ static void spi_qup_set_cs(struct spi_device *spi, bool val)
 	u32 spi_ioc;
 	u32 spi_ioc_orig;
 
-	controller = spi_master_get_devdata(spi->master);
+	controller = spi_controller_get_devdata(spi->controller);
 	spi_ioc = readl_relaxed(controller->base + SPI_IO_CONTROL);
 	spi_ioc_orig = spi_ioc;
 	if (!val)
@@ -992,7 +992,7 @@ static void spi_qup_set_cs(struct spi_device *spi, bool val)
 
 static int spi_qup_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct clk *iclk, *cclk;
 	struct spi_qup *controller;
 	struct resource *res;
@@ -1027,34 +1027,34 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	master = spi_alloc_master(dev, sizeof(struct spi_qup));
-	if (!master) {
-		dev_err(dev, "cannot allocate master\n");
+	host = spi_alloc_host(dev, sizeof(struct spi_qup));
+	if (!host) {
+		dev_err(dev, "cannot allocate host\n");
 		return -ENOMEM;
 	}
 
 	/* use num-cs unless not present or out of range */
 	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs) ||
 	    num_cs > SPI_NUM_CHIPSELECTS)
-		master->num_chipselect = SPI_NUM_CHIPSELECTS;
+		host->num_chipselect = SPI_NUM_CHIPSELECTS;
 	else
-		master->num_chipselect = num_cs;
+		host->num_chipselect = num_cs;
 
-	master->use_gpio_descriptors = true;
-	master->max_native_cs = SPI_NUM_CHIPSELECTS;
-	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-	master->max_speed_hz = max_freq;
-	master->transfer_one = spi_qup_transfer_one;
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->dma_alignment = dma_get_cache_alignment();
-	master->max_dma_len = SPI_MAX_XFER;
+	host->use_gpio_descriptors = true;
+	host->max_native_cs = SPI_NUM_CHIPSELECTS;
+	host->bus_num = pdev->id;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	host->max_speed_hz = max_freq;
+	host->transfer_one = spi_qup_transfer_one;
+	host->dev.of_node = pdev->dev.of_node;
+	host->auto_runtime_pm = true;
+	host->dma_alignment = dma_get_cache_alignment();
+	host->max_dma_len = SPI_MAX_XFER;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	controller = spi_master_get_devdata(master);
+	controller = spi_controller_get_devdata(host);
 
 	controller->dev = dev;
 	controller->base = base;
@@ -1062,16 +1062,16 @@ static int spi_qup_probe(struct platform_device *pdev)
 	controller->cclk = cclk;
 	controller->irq = irq;
 
-	ret = spi_qup_init_dma(master, res->start);
+	ret = spi_qup_init_dma(host, res->start);
 	if (ret == -EPROBE_DEFER)
 		goto error;
 	else if (!ret)
-		master->can_dma = spi_qup_can_dma;
+		host->can_dma = spi_qup_can_dma;
 
 	controller->qup_v1 = (uintptr_t)of_device_get_match_data(dev);
 
 	if (!controller->qup_v1)
-		master->set_cs = spi_qup_set_cs;
+		host->set_cs = spi_qup_set_cs;
 
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
@@ -1149,7 +1149,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	ret = devm_spi_register_master(dev, master);
+	ret = devm_spi_register_controller(dev, host);
 	if (ret)
 		goto disable_pm;
 
@@ -1161,17 +1161,17 @@ static int spi_qup_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cclk);
 	clk_disable_unprepare(iclk);
 error_dma:
-	spi_qup_release_dma(master);
+	spi_qup_release_dma(host);
 error:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return ret;
 }
 
 #ifdef CONFIG_PM
 static int spi_qup_pm_suspend_runtime(struct device *device)
 {
-	struct spi_master *master = dev_get_drvdata(device);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(device);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	u32 config;
 
 	/* Enable clocks auto gaiting */
@@ -1187,8 +1187,8 @@ static int spi_qup_pm_suspend_runtime(struct device *device)
 
 static int spi_qup_pm_resume_runtime(struct device *device)
 {
-	struct spi_master *master = dev_get_drvdata(device);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(device);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	u32 config;
 	int ret;
 
@@ -1213,8 +1213,8 @@ static int spi_qup_pm_resume_runtime(struct device *device)
 #ifdef CONFIG_PM_SLEEP
 static int spi_qup_suspend(struct device *device)
 {
-	struct spi_master *master = dev_get_drvdata(device);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(device);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
 	if (pm_runtime_suspended(device)) {
@@ -1222,7 +1222,7 @@ static int spi_qup_suspend(struct device *device)
 		if (ret)
 			return ret;
 	}
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -1237,8 +1237,8 @@ static int spi_qup_suspend(struct device *device)
 
 static int spi_qup_resume(struct device *device)
 {
-	struct spi_master *master = dev_get_drvdata(device);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(device);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(controller->iclk);
@@ -1255,7 +1255,7 @@ static int spi_qup_resume(struct device *device)
 	if (ret)
 		goto disable_clk;
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret)
 		goto disable_clk;
 
@@ -1270,8 +1270,8 @@ static int spi_qup_resume(struct device *device)
 
 static void spi_qup_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = dev_get_drvdata(&pdev->dev);
-	struct spi_qup *controller = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(&pdev->dev);
+	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = pm_runtime_get_sync(&pdev->dev);
@@ -1289,7 +1289,7 @@ static void spi_qup_remove(struct platform_device *pdev)
 			 ERR_PTR(ret));
 	}
 
-	spi_qup_release_dma(master);
+	spi_qup_release_dma(host);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1

