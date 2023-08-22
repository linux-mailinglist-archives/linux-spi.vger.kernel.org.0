Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD04783775
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjHVBis (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjHVBiq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCB212C
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:43 -0700 (PDT)
Received: from dggpemm100014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVBjm0SydzNn8v;
        Tue, 22 Aug 2023 09:35:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100014.china.huawei.com (7.185.36.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:41 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 12/24] spi: tegra20-sflash: switch to use modern name
Date:   Tue, 22 Aug 2023 09:34:59 +0800
Message-ID: <20230822013511.4161475-13-yangyingliang@huawei.com>
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
 drivers/spi/spi-tegra20-sflash.c | 76 ++++++++++++++++----------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 0c5507473f97..9f6b9f89be5b 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -102,7 +102,7 @@
 
 struct tegra_sflash_data {
 	struct device				*dev;
-	struct spi_master			*master;
+	struct spi_controller			*host;
 	spinlock_t				lock;
 
 	struct clk				*clk;
@@ -251,7 +251,7 @@ static int tegra_sflash_start_transfer_one(struct spi_device *spi,
 		struct spi_transfer *t, bool is_first_of_msg,
 		bool is_single_xfer)
 {
-	struct tegra_sflash_data *tsd = spi_master_get_devdata(spi->master);
+	struct tegra_sflash_data *tsd = spi_controller_get_devdata(spi->controller);
 	u32 speed;
 	u32 command;
 
@@ -303,12 +303,12 @@ static int tegra_sflash_start_transfer_one(struct spi_device *spi,
 	return tegra_sflash_start_cpu_based_transfer(tsd, t);
 }
 
-static int tegra_sflash_transfer_one_message(struct spi_master *master,
+static int tegra_sflash_transfer_one_message(struct spi_controller *host,
 			struct spi_message *msg)
 {
 	bool is_first_msg = true;
 	int single_xfer;
-	struct tegra_sflash_data *tsd = spi_master_get_devdata(master);
+	struct tegra_sflash_data *tsd = spi_controller_get_devdata(host);
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	int ret;
@@ -351,7 +351,7 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 exit:
 	tegra_sflash_writel(tsd, tsd->def_command_reg, SPI_COMMAND);
 	msg->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 	return ret;
 }
 
@@ -416,7 +416,7 @@ MODULE_DEVICE_TABLE(of, tegra_sflash_of_match);
 
 static int tegra_sflash_probe(struct platform_device *pdev)
 {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct tegra_sflash_data	*tsd;
 	int ret;
 	const struct of_device_id *match;
@@ -427,37 +427,37 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*tsd));
-	if (!master) {
-		dev_err(&pdev->dev, "master allocation failed\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(*tsd));
+	if (!host) {
+		dev_err(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
 	}
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA;
-	master->transfer_one_message = tegra_sflash_transfer_one_message;
-	master->auto_runtime_pm = true;
-	master->num_chipselect = MAX_CHIP_SELECT;
-
-	platform_set_drvdata(pdev, master);
-	tsd = spi_master_get_devdata(master);
-	tsd->master = master;
+	host->mode_bits = SPI_CPOL | SPI_CPHA;
+	host->transfer_one_message = tegra_sflash_transfer_one_message;
+	host->auto_runtime_pm = true;
+	host->num_chipselect = MAX_CHIP_SELECT;
+
+	platform_set_drvdata(pdev, host);
+	tsd = spi_controller_get_devdata(host);
+	tsd->host = host;
 	tsd->dev = &pdev->dev;
 	spin_lock_init(&tsd->lock);
 
 	if (of_property_read_u32(tsd->dev->of_node, "spi-max-frequency",
-				 &master->max_speed_hz))
-		master->max_speed_hz = 25000000; /* 25MHz */
+				 &host->max_speed_hz))
+		host->max_speed_hz = 25000000; /* 25MHz */
 
 	tsd->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tsd->base)) {
 		ret = PTR_ERR(tsd->base);
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto exit_free_master;
+		goto exit_free_host;
 	tsd->irq = ret;
 
 	ret = request_irq(tsd->irq, tegra_sflash_isr, 0,
@@ -465,7 +465,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
 					tsd->irq);
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	tsd->clk = devm_clk_get(&pdev->dev, NULL);
@@ -505,10 +505,10 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	tegra_sflash_writel(tsd, tsd->def_command_reg, SPI_COMMAND);
 	pm_runtime_put(&pdev->dev);
 
-	master->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_master(&pdev->dev, master);
+	host->dev.of_node = pdev->dev.of_node;
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
+		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_pm_disable;
 	}
 	return ret;
@@ -519,15 +519,15 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		tegra_sflash_runtime_suspend(&pdev->dev);
 exit_free_irq:
 	free_irq(tsd->irq, tsd);
-exit_free_master:
-	spi_master_put(master);
+exit_free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void tegra_sflash_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct tegra_sflash_data	*tsd = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct tegra_sflash_data	*tsd = spi_controller_get_devdata(host);
 
 	free_irq(tsd->irq, tsd);
 
@@ -539,15 +539,15 @@ static void tegra_sflash_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int tegra_sflash_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 
-	return spi_master_suspend(master);
+	return spi_controller_suspend(host);
 }
 
 static int tegra_sflash_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_sflash_data *tsd = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_sflash_data *tsd = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -558,14 +558,14 @@ static int tegra_sflash_resume(struct device *dev)
 	tegra_sflash_writel(tsd, tsd->command_reg, SPI_COMMAND);
 	pm_runtime_put(dev);
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 #endif
 
 static int tegra_sflash_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_sflash_data *tsd = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_sflash_data *tsd = spi_controller_get_devdata(host);
 
 	/* Flush all write which are in PPSB queue by reading back */
 	tegra_sflash_readl(tsd, SPI_COMMAND);
@@ -576,8 +576,8 @@ static int tegra_sflash_runtime_suspend(struct device *dev)
 
 static int tegra_sflash_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_sflash_data *tsd = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_sflash_data *tsd = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(tsd->clk);
-- 
2.25.1

