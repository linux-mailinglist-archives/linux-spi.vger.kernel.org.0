Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4077272C
	for <lists+linux-spi@lfdr.de>; Mon,  7 Aug 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjHGOK0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Aug 2023 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjHGOKW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 10:10:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544D10D9
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 07:10:20 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKJ6132q1ztRZN;
        Mon,  7 Aug 2023 22:06:49 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
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
Subject: [PATCH -next v2 16/21] spi: coldfire-qspi: switch to use modern name
Date:   Mon, 7 Aug 2023 22:07:12 +0800
Message-ID: <20230807140717.3484180-17-yangyingliang@huawei.com>
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
 drivers/spi/spi-coldfire-qspi.c | 66 ++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 31174e7ca7a6..f0b630fe16c3 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -286,7 +286,7 @@ static void mcfqspi_transfer_msg16(struct mcfqspi *mcfqspi, unsigned count,
 
 static void mcfqspi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(spi->master);
+	struct mcfqspi *mcfqspi = spi_controller_get_devdata(spi->controller);
 	bool cs_high = spi->mode & SPI_CS_HIGH;
 
 	if (enable)
@@ -295,11 +295,11 @@ static void mcfqspi_set_cs(struct spi_device *spi, bool enable)
 		mcfqspi_cs_deselect(mcfqspi, spi_get_chipselect(spi, 0), cs_high);
 }
 
-static int mcfqspi_transfer_one(struct spi_master *master,
+static int mcfqspi_transfer_one(struct spi_controller *host,
 				struct spi_device *spi,
 				struct spi_transfer *t)
 {
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
+	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 	u16 qmr = MCFQSPI_QMR_MSTR;
 
 	qmr |= t->bits_per_word << 10;
@@ -323,7 +323,7 @@ static int mcfqspi_transfer_one(struct spi_master *master,
 
 static int mcfqspi_setup(struct spi_device *spi)
 {
-	mcfqspi_cs_deselect(spi_master_get_devdata(spi->master),
+	mcfqspi_cs_deselect(spi_controller_get_devdata(spi->controller),
 			    spi_get_chipselect(spi, 0), spi->mode & SPI_CS_HIGH);
 
 	dev_dbg(&spi->dev,
@@ -337,7 +337,7 @@ static int mcfqspi_setup(struct spi_device *spi)
 
 static int mcfqspi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct mcfqspi *mcfqspi;
 	struct mcfqspi_platform_data *pdata;
 	int status;
@@ -353,13 +353,13 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*mcfqspi));
-	if (master == NULL) {
-		dev_dbg(&pdev->dev, "spi_alloc_master failed\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(*mcfqspi));
+	if (host == NULL) {
+		dev_dbg(&pdev->dev, "spi_alloc_host failed\n");
 		return -ENOMEM;
 	}
 
-	mcfqspi = spi_master_get_devdata(master);
+	mcfqspi = spi_controller_get_devdata(host);
 
 	mcfqspi->iobase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mcfqspi->iobase)) {
@@ -388,8 +388,8 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		goto fail0;
 	}
 
-	master->bus_num = pdata->bus_num;
-	master->num_chipselect = pdata->num_chipselect;
+	host->bus_num = pdata->bus_num;
+	host->num_chipselect = pdata->num_chipselect;
 
 	mcfqspi->cs_control = pdata->cs_control;
 	status = mcfqspi_cs_setup(mcfqspi);
@@ -400,19 +400,19 @@ static int mcfqspi_probe(struct platform_device *pdev)
 
 	init_waitqueue_head(&mcfqspi->waitq);
 
-	master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
-	master->setup = mcfqspi_setup;
-	master->set_cs = mcfqspi_set_cs;
-	master->transfer_one = mcfqspi_transfer_one;
-	master->auto_runtime_pm = true;
+	host->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 16);
+	host->setup = mcfqspi_setup;
+	host->set_cs = mcfqspi_set_cs;
+	host->transfer_one = mcfqspi_transfer_one;
+	host->auto_runtime_pm = true;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 	pm_runtime_enable(&pdev->dev);
 
-	status = devm_spi_register_master(&pdev->dev, master);
+	status = devm_spi_register_controller(&pdev->dev, host);
 	if (status) {
-		dev_dbg(&pdev->dev, "spi_register_master failed\n");
+		dev_dbg(&pdev->dev, "devm_spi_register_controller failed\n");
 		goto fail1;
 	}
 
@@ -424,7 +424,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	mcfqspi_cs_teardown(mcfqspi);
 fail0:
-	spi_master_put(master);
+	spi_controller_put(host);
 
 	dev_dbg(&pdev->dev, "Coldfire QSPI probe failed\n");
 
@@ -433,8 +433,8 @@ static int mcfqspi_probe(struct platform_device *pdev)
 
 static void mcfqspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 
 	pm_runtime_disable(&pdev->dev);
 	/* disable the hardware (set the baud rate to 0) */
@@ -447,11 +447,11 @@ static void mcfqspi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int mcfqspi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -462,20 +462,20 @@ static int mcfqspi_suspend(struct device *dev)
 
 static int mcfqspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 
 	clk_enable(mcfqspi->clk);
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 #endif
 
 #ifdef CONFIG_PM
 static int mcfqspi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 
 	clk_disable(mcfqspi->clk);
 
@@ -484,8 +484,8 @@ static int mcfqspi_runtime_suspend(struct device *dev)
 
 static int mcfqspi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 
 	clk_enable(mcfqspi->clk);
 
-- 
2.25.1

