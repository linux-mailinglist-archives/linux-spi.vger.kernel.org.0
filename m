Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40484784F51
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjHWDdp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjHWDdm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6FEE4E
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:40 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVsGK5sFxz1L9bV;
        Wed, 23 Aug 2023 11:32:09 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 16/21] spi: mxs: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:58 +0800
Message-ID: <20230823033003.3407403-17-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823033003.3407403-1-yangyingliang@huawei.com>
References: <20230823033003.3407403-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
 drivers/spi/spi-mxs.c | 70 +++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index cd0e7ae07162..1bf080339b5a 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
-// Freescale MXS SPI master driver
+// Freescale MXS SPI host driver
 //
 // Copyright 2012 DENX Software Engineering, GmbH.
 // Copyright 2012 Freescale Semiconductor, Inc.
@@ -63,7 +63,7 @@ struct mxs_spi {
 static int mxs_spi_setup_transfer(struct spi_device *dev,
 				  const struct spi_transfer *t)
 {
-	struct mxs_spi *spi = spi_master_get_devdata(dev->master);
+	struct mxs_spi *spi = spi_controller_get_devdata(dev->controller);
 	struct mxs_ssp *ssp = &spi->ssp;
 	const unsigned int hz = min(dev->max_speed_hz, t->speed_hz);
 
@@ -357,10 +357,10 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi,
 	return -ETIMEDOUT;
 }
 
-static int mxs_spi_transfer_one(struct spi_master *master,
+static int mxs_spi_transfer_one(struct spi_controller *host,
 				struct spi_message *m)
 {
-	struct mxs_spi *spi = spi_master_get_devdata(master);
+	struct mxs_spi *spi = spi_controller_get_devdata(host);
 	struct mxs_ssp *ssp = &spi->ssp;
 	struct spi_transfer *t;
 	unsigned int flag;
@@ -432,15 +432,15 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 	}
 
 	m->status = status;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return status;
 }
 
 static int mxs_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mxs_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mxs_spi *spi = spi_controller_get_devdata(host);
 	struct mxs_ssp *ssp = &spi->ssp;
 	int ret;
 
@@ -460,8 +460,8 @@ static int mxs_spi_runtime_suspend(struct device *dev)
 
 static int mxs_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mxs_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mxs_spi *spi = spi_controller_get_devdata(host);
 	struct mxs_ssp *ssp = &spi->ssp;
 	int ret;
 
@@ -478,10 +478,10 @@ static int mxs_spi_runtime_resume(struct device *dev)
 
 static int __maybe_unused mxs_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -493,7 +493,7 @@ static int __maybe_unused mxs_spi_suspend(struct device *dev)
 
 static int __maybe_unused mxs_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
 	if (!pm_runtime_suspended(dev))
@@ -503,7 +503,7 @@ static int __maybe_unused mxs_spi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret < 0 && !pm_runtime_suspended(dev))
 		mxs_spi_runtime_suspend(dev);
 
@@ -528,7 +528,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id =
 			of_match_device(mxs_spi_dt_ids, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct mxs_spi *spi;
 	struct mxs_ssp *ssp;
 	struct clk *clk;
@@ -561,21 +561,21 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (ret)
 		clk_freq = clk_freq_default;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*spi));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	master->transfer_one_message = mxs_spi_transfer_one;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->mode_bits = SPI_CPOL | SPI_CPHA;
-	master->num_chipselect = 3;
-	master->dev.of_node = np;
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->auto_runtime_pm = true;
+	host->transfer_one_message = mxs_spi_transfer_one;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->mode_bits = SPI_CPOL | SPI_CPHA;
+	host->num_chipselect = 3;
+	host->dev.of_node = np;
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->auto_runtime_pm = true;
 
-	spi = spi_master_get_devdata(master);
+	spi = spi_controller_get_devdata(host);
 	ssp = &spi->ssp;
 	ssp->dev = &pdev->dev;
 	ssp->clk = clk;
@@ -587,13 +587,13 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq_err, mxs_ssp_irq_handler, 0,
 			       dev_name(&pdev->dev), ssp);
 	if (ret)
-		goto out_master_free;
+		goto out_host_free;
 
 	ssp->dmach = dma_request_chan(&pdev->dev, "rx-tx");
 	if (IS_ERR(ssp->dmach)) {
 		dev_err(ssp->dev, "Failed to request DMA\n");
 		ret = PTR_ERR(ssp->dmach);
-		goto out_master_free;
+		goto out_host_free;
 	}
 
 	pm_runtime_enable(ssp->dev);
@@ -617,9 +617,9 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_pm_runtime_put;
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "Cannot register SPI master, %d\n", ret);
+		dev_err(&pdev->dev, "Cannot register SPI host, %d\n", ret);
 		goto out_pm_runtime_put;
 	}
 
@@ -633,19 +633,19 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(ssp->dev);
 out_dma_release:
 	dma_release_channel(ssp->dmach);
-out_master_free:
-	spi_master_put(master);
+out_host_free:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void mxs_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct mxs_spi *spi;
 	struct mxs_ssp *ssp;
 
-	master = platform_get_drvdata(pdev);
-	spi = spi_master_get_devdata(master);
+	host = platform_get_drvdata(pdev);
+	spi = spi_controller_get_devdata(host);
 	ssp = &spi->ssp;
 
 	pm_runtime_disable(&pdev->dev);
@@ -668,6 +668,6 @@ static struct platform_driver mxs_spi_driver = {
 module_platform_driver(mxs_spi_driver);
 
 MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
-MODULE_DESCRIPTION("MXS SPI master driver");
+MODULE_DESCRIPTION("MXS SPI host driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:mxs-spi");
-- 
2.25.1

