Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC48477272A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjHGOKY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjHGOKV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB0D9E
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:19 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKJ613lZYzNmqJ;
        Mon,  7 Aug 2023 22:06:49 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:10:17 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:10:16 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 18/21] spi: dln2: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:14 +0800
Message-ID: <20230807140717.3484180-19-yangyingliang@huawei.com>
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
 drivers/spi/spi-dln2.c | 94 +++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 6bd93c47853c..d319dc357fef 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -79,7 +79,7 @@
 
 struct dln2_spi {
 	struct platform_device *pdev;
-	struct spi_master *master;
+	struct spi_controller *host;
 	u8 port;
 
 	/*
@@ -176,7 +176,7 @@ static int dln2_spi_cs_enable(struct dln2_spi *dln2, u8 cs_mask, bool enable)
 
 static int dln2_spi_cs_enable_all(struct dln2_spi *dln2, bool enable)
 {
-	u8 cs_mask = GENMASK(dln2->master->num_chipselect - 1, 0);
+	u8 cs_mask = GENMASK(dln2->host->num_chipselect - 1, 0);
 
 	return dln2_spi_cs_enable(dln2, cs_mask, enable);
 }
@@ -589,11 +589,11 @@ static int dln2_spi_rdwr(struct dln2_spi *dln2, const u8 *tx_data,
 	return 0;
 }
 
-static int dln2_spi_prepare_message(struct spi_master *master,
+static int dln2_spi_prepare_message(struct spi_controller *host,
 				    struct spi_message *message)
 {
 	int ret;
-	struct dln2_spi *dln2 = spi_master_get_devdata(master);
+	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 	struct spi_device *spi = message->spi;
 
 	if (dln2->cs != spi_get_chipselect(spi, 0)) {
@@ -650,11 +650,11 @@ static int dln2_spi_transfer_setup(struct dln2_spi *dln2, u32 speed,
 	return dln2_spi_enable(dln2, true);
 }
 
-static int dln2_spi_transfer_one(struct spi_master *master,
+static int dln2_spi_transfer_one(struct spi_controller *host,
 				 struct spi_device *spi,
 				 struct spi_transfer *xfer)
 {
-	struct dln2_spi *dln2 = spi_master_get_devdata(master);
+	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 	int status;
 	u8 attr = 0;
 
@@ -666,7 +666,7 @@ static int dln2_spi_transfer_one(struct spi_master *master,
 		return status;
 	}
 
-	if (!xfer->cs_change && !spi_transfer_is_last(master, xfer))
+	if (!xfer->cs_change && !spi_transfer_is_last(host, xfer))
 		attr = DLN2_SPI_ATTR_LEAVE_SS_LOW;
 
 	status = dln2_spi_rdwr(dln2, xfer->tx_buf, xfer->rx_buf,
@@ -679,29 +679,29 @@ static int dln2_spi_transfer_one(struct spi_master *master,
 
 static int dln2_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct dln2_spi *dln2;
 	struct dln2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*dln2));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*dln2));
+	if (!host)
 		return -ENOMEM;
 
-	device_set_node(&master->dev, dev_fwnode(dev));
+	device_set_node(&host->dev, dev_fwnode(dev));
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	dln2 = spi_master_get_devdata(master);
+	dln2 = spi_controller_get_devdata(host);
 
 	dln2->buf = devm_kmalloc(&pdev->dev, DLN2_SPI_BUF_SIZE, GFP_KERNEL);
 	if (!dln2->buf) {
 		ret = -ENOMEM;
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
-	dln2->master = master;
+	dln2->host = host;
 	dln2->pdev = pdev;
 	dln2->port = pdata->port;
 	/* cs/mode can never be 0xff, so the first transfer will set them */
@@ -712,47 +712,47 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	ret = dln2_spi_enable(dln2, false);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to disable SPI module\n");
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
-	ret = dln2_spi_get_cs_num(dln2, &master->num_chipselect);
+	ret = dln2_spi_get_cs_num(dln2, &host->num_chipselect);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get number of CS pins\n");
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	ret = dln2_spi_get_speed_range(dln2,
-				       &master->min_speed_hz,
-				       &master->max_speed_hz);
+				       &host->min_speed_hz,
+				       &host->max_speed_hz);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to read bus min/max freqs\n");
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	ret = dln2_spi_get_supported_frame_sizes(dln2,
-						 &master->bits_per_word_mask);
+						 &host->bits_per_word_mask);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to read supported frame sizes\n");
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	ret = dln2_spi_cs_enable_all(dln2, true);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to enable CS pins\n");
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
-	master->bus_num = -1;
-	master->mode_bits = SPI_CPOL | SPI_CPHA;
-	master->prepare_message = dln2_spi_prepare_message;
-	master->transfer_one = dln2_spi_transfer_one;
-	master->auto_runtime_pm = true;
+	host->bus_num = -1;
+	host->mode_bits = SPI_CPOL | SPI_CPHA;
+	host->prepare_message = dln2_spi_prepare_message;
+	host->transfer_one = dln2_spi_transfer_one;
+	host->auto_runtime_pm = true;
 
 	/* enable SPI module, we're good to go */
 	ret = dln2_spi_enable(dln2, true);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to enable SPI module\n");
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
@@ -761,9 +761,9 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register master\n");
+		dev_err(&pdev->dev, "Failed to register host\n");
 		goto exit_register;
 	}
 
@@ -775,16 +775,16 @@ static int dln2_spi_probe(struct platform_device *pdev)
 
 	if (dln2_spi_enable(dln2, false) < 0)
 		dev_err(&pdev->dev, "Failed to disable SPI module\n");
-exit_free_master:
-	spi_master_put(master);
+exit_free_host:
+	spi_controller_put(host);
 
 	return ret;
 }
 
 static void dln2_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct dln2_spi *dln2 = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 
 	pm_runtime_disable(&pdev->dev);
 
@@ -796,10 +796,10 @@ static void dln2_spi_remove(struct platform_device *pdev)
 static int dln2_spi_suspend(struct device *dev)
 {
 	int ret;
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct dln2_spi *dln2 = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret < 0)
 		return ret;
 
@@ -824,8 +824,8 @@ static int dln2_spi_suspend(struct device *dev)
 static int dln2_spi_resume(struct device *dev)
 {
 	int ret;
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct dln2_spi *dln2 = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 
 	if (!pm_runtime_suspended(dev)) {
 		ret = dln2_spi_cs_enable_all(dln2, true);
@@ -837,23 +837,23 @@ static int dln2_spi_resume(struct device *dev)
 			return ret;
 	}
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM
 static int dln2_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct dln2_spi *dln2 = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 
 	return dln2_spi_enable(dln2, false);
 }
 
 static int dln2_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct dln2_spi *dln2 = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 
 	return  dln2_spi_enable(dln2, true);
 }
@@ -875,7 +875,7 @@ static struct platform_driver spi_dln2_driver = {
 };
 module_platform_driver(spi_dln2_driver);
 
-MODULE_DESCRIPTION("Driver for the Diolan DLN2 SPI master interface");
+MODULE_DESCRIPTION("Driver for the Diolan DLN2 SPI host interface");
 MODULE_AUTHOR("Laurentiu Palcu <laurentiu.palcu@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:dln2-spi");
-- 
2.25.1

