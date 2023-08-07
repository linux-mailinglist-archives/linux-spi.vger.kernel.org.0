Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7254577272D
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjHGOK0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjHGOKW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6190C10CF
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:20 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKJ8g4k6gzfbp6;
        Mon,  7 Aug 2023 22:09:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:16 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:16 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 17/21] spi: davinci: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:13 +0800
Message-ID: <20230807140717.3484180-18-yangyingliang@huawei.com>
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-davinci.c | 76 +++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 9a9f3bc0e2d5..c457b550d3ad 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -201,7 +201,7 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	u8 chip_sel = spi_get_chipselect(spi, 0);
 	u16 spidat1 = CS_DEFAULT;
 
-	dspi = spi_master_get_devdata(spi->master);
+	dspi = spi_controller_get_devdata(spi->controller);
 
 	/* program delay transfers if tx_delay is non zero */
 	if (spicfg && spicfg->wdelay)
@@ -271,7 +271,7 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	u32 hz = 0, spifmt = 0;
 	int prescale;
 
-	dspi = spi_master_get_devdata(spi->master);
+	dspi = spi_controller_get_devdata(spi->controller);
 	spicfg = spi->controller_data;
 	if (!spicfg)
 		spicfg = &davinci_spi_default_cfg;
@@ -379,7 +379,7 @@ static int davinci_spi_of_setup(struct spi_device *spi)
 {
 	struct davinci_spi_config *spicfg = spi->controller_data;
 	struct device_node *np = spi->dev.of_node;
-	struct davinci_spi *dspi = spi_master_get_devdata(spi->master);
+	struct davinci_spi *dspi = spi_controller_get_devdata(spi->controller);
 	u32 prop;
 
 	if (spicfg == NULL && np) {
@@ -411,7 +411,7 @@ static int davinci_spi_setup(struct spi_device *spi)
 	struct device_node *np = spi->dev.of_node;
 	bool internal_cs = true;
 
-	dspi = spi_master_get_devdata(spi->master);
+	dspi = spi_controller_get_devdata(spi->controller);
 
 	if (!(spi->mode & SPI_NO_CS)) {
 		if (np && spi_get_csgpiod(spi, 0))
@@ -441,7 +441,7 @@ static void davinci_spi_cleanup(struct spi_device *spi)
 		kfree(spicfg);
 }
 
-static bool davinci_spi_can_dma(struct spi_master *master,
+static bool davinci_spi_can_dma(struct spi_controller *host,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
 {
@@ -571,7 +571,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	struct davinci_spi_config *spicfg;
 	struct davinci_spi_platform_data *pdata;
 
-	dspi = spi_master_get_devdata(spi->master);
+	dspi = spi_controller_get_devdata(spi->controller);
 	pdata = &dspi->pdata;
 	spicfg = (struct davinci_spi_config *)spi->controller_data;
 	if (!spicfg)
@@ -592,7 +592,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 	reinit_completion(&dspi->done);
 
-	if (!davinci_spi_can_dma(spi->master, spi, t)) {
+	if (!davinci_spi_can_dma(spi->controller, spi, t)) {
 		if (spicfg->io_type != SPI_IO_TYPE_POLL)
 			set_io_bits(dspi->base + SPIINT, SPIINT_MASKINT);
 		/* start the transfer */
@@ -673,7 +673,7 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	clear_io_bits(dspi->base + SPIINT, SPIINT_MASKALL);
-	if (davinci_spi_can_dma(spi->master, spi, t))
+	if (davinci_spi_can_dma(spi->controller, spi, t))
 		clear_io_bits(dspi->base + SPIINT, SPIINT_DMA_REQ_EN);
 
 	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
@@ -855,22 +855,22 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
  */
 static int davinci_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
 	struct resource *r;
 	int ret = 0;
 	u32 spipc0;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct davinci_spi));
-	if (master == NULL) {
+	host = spi_alloc_host(&pdev->dev, sizeof(struct davinci_spi));
+	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	dspi = spi_master_get_devdata(master);
+	dspi = spi_controller_get_devdata(host);
 
 	if (dev_get_platdata(&pdev->dev)) {
 		pdata = dev_get_platdata(&pdev->dev);
@@ -879,7 +879,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		/* update dspi pdata with that from the DT */
 		ret = spi_davinci_get_pdata(pdev, dspi);
 		if (ret < 0)
-			goto free_master;
+			goto free_host;
 	}
 
 	/* pdata in dspi is now updated and point pdata to that */
@@ -891,13 +891,13 @@ static int davinci_spi_probe(struct platform_device *pdev)
 					    GFP_KERNEL);
 	if (dspi->bytes_per_word == NULL) {
 		ret = -ENOMEM;
-		goto free_master;
+		goto free_host;
 	}
 
 	dspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(dspi->base)) {
 		ret = PTR_ERR(dspi->base);
-		goto free_master;
+		goto free_host;
 	}
 	dspi->pbase = r->start;
 
@@ -905,34 +905,34 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto free_master;
+		goto free_host;
 	dspi->irq = ret;
 
 	ret = devm_request_threaded_irq(&pdev->dev, dspi->irq, davinci_spi_irq,
 				dummy_thread_fn, 0, dev_name(&pdev->dev), dspi);
 	if (ret)
-		goto free_master;
+		goto free_host;
 
-	dspi->bitbang.master = master;
+	dspi->bitbang.master = host;
 
 	dspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dspi->clk)) {
 		ret = -ENODEV;
-		goto free_master;
+		goto free_host;
 	}
 	ret = clk_prepare_enable(dspi->clk);
 	if (ret)
-		goto free_master;
-
-	master->use_gpio_descriptors = true;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = pdev->id;
-	master->num_chipselect = pdata->num_chipselect;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
-	master->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_GPIO_SS;
-	master->setup = davinci_spi_setup;
-	master->cleanup = davinci_spi_cleanup;
-	master->can_dma = davinci_spi_can_dma;
+		goto free_host;
+
+	host->use_gpio_descriptors = true;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bus_num = pdev->id;
+	host->num_chipselect = pdata->num_chipselect;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
+	host->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_GPIO_SS;
+	host->setup = davinci_spi_setup;
+	host->cleanup = davinci_spi_cleanup;
+	host->can_dma = davinci_spi_can_dma;
 
 	dspi->bitbang.chipselect = davinci_spi_chipselect;
 	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
@@ -973,7 +973,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	iowrite32(CS_DEFAULT, dspi->base + SPIDEF);
 
-	/* master mode default */
+	/* host mode default */
 	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_CLKMOD_MASK);
 	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_MASTER_MASK);
 	set_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
@@ -993,8 +993,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	}
 free_clk:
 	clk_disable_unprepare(dspi->clk);
-free_master:
-	spi_master_put(master);
+free_host:
+	spi_controller_put(host);
 err:
 	return ret;
 }
@@ -1011,10 +1011,10 @@ static int davinci_spi_probe(struct platform_device *pdev)
 static void davinci_spi_remove(struct platform_device *pdev)
 {
 	struct davinci_spi *dspi;
-	struct spi_master *master;
+	struct spi_controller *host;
 
-	master = platform_get_drvdata(pdev);
-	dspi = spi_master_get_devdata(master);
+	host = platform_get_drvdata(pdev);
+	dspi = spi_controller_get_devdata(host);
 
 	spi_bitbang_stop(&dspi->bitbang);
 
@@ -1025,7 +1025,7 @@ static void davinci_spi_remove(struct platform_device *pdev)
 		dma_release_channel(dspi->dma_tx);
 	}
 
-	spi_master_put(master);
+	spi_controller_put(host);
 }
 
 static struct platform_driver davinci_spi_driver = {
-- 
2.25.1

