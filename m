Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150D3784F45
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjHWDdj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjHWDdi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096DEE50
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:36 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVsDP4NMWzLp6M;
        Wed, 23 Aug 2023 11:30:29 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:34 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 04/21] spi: meson-spifc: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:46 +0800
Message-ID: <20230823033003.3407403-5-yangyingliang@huawei.com>
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

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-meson-spifc.c | 66 +++++++++++++++++------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 06626f406f68..de56d38edf40 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -67,13 +67,13 @@
 
 /**
  * struct meson_spifc
- * @master:	the SPI master
+ * @host:	the SPI host
  * @regmap:	regmap for device registers
  * @clk:	input clock of the built-in baud rate generator
  * @dev:	the device structure
  */
 struct meson_spifc {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct regmap *regmap;
 	struct clk *clk;
 	struct device *dev;
@@ -237,16 +237,16 @@ static int meson_spifc_txrx(struct meson_spifc *spifc,
 
 /**
  * meson_spifc_transfer_one() - perform a single transfer
- * @master:	the SPI master
+ * @host:	the SPI host
  * @spi:	the SPI device
  * @xfer:	the current SPI transfer
  * Return:	0 on success, a negative value on error
  */
-static int meson_spifc_transfer_one(struct spi_master *master,
+static int meson_spifc_transfer_one(struct spi_controller *host,
 				    struct spi_device *spi,
 				    struct spi_transfer *xfer)
 {
-	struct meson_spifc *spifc = spi_master_get_devdata(master);
+	struct meson_spifc *spifc = spi_controller_get_devdata(host);
 	int len, done = 0, ret = 0;
 
 	meson_spifc_setup_speed(spifc, xfer->speed_hz);
@@ -256,7 +256,7 @@ static int meson_spifc_transfer_one(struct spi_master *master,
 	while (done < xfer->len && !ret) {
 		len = min_t(int, xfer->len - done, SPIFC_BUFFER_SIZE);
 		ret = meson_spifc_txrx(spifc, xfer, done, len,
-				       spi_transfer_is_last(master, xfer),
+				       spi_transfer_is_last(host, xfer),
 				       done + len >= xfer->len);
 		done += len;
 	}
@@ -284,19 +284,19 @@ static void meson_spifc_hw_init(struct meson_spifc *spifc)
 
 static int meson_spifc_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct meson_spifc *spifc;
 	void __iomem *base;
 	unsigned int rate;
 	int ret = 0;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct meson_spifc));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(struct meson_spifc));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	spifc = spi_master_get_devdata(master);
+	spifc = spi_controller_get_devdata(host);
 	spifc->dev = &pdev->dev;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -327,22 +327,22 @@ static int meson_spifc_probe(struct platform_device *pdev)
 
 	rate = clk_get_rate(spifc->clk);
 
-	master->num_chipselect = 1;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->auto_runtime_pm = true;
-	master->transfer_one = meson_spifc_transfer_one;
-	master->min_speed_hz = rate >> 6;
-	master->max_speed_hz = rate >> 1;
+	host->num_chipselect = 1;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->auto_runtime_pm = true;
+	host->transfer_one = meson_spifc_transfer_one;
+	host->min_speed_hz = rate >> 6;
+	host->max_speed_hz = rate >> 1;
 
 	meson_spifc_hw_init(spifc);
 
 	pm_runtime_set_active(spifc->dev);
 	pm_runtime_enable(spifc->dev);
 
-	ret = devm_spi_register_master(spifc->dev, master);
+	ret = devm_spi_register_controller(spifc->dev, host);
 	if (ret) {
-		dev_err(spifc->dev, "failed to register spi master\n");
+		dev_err(spifc->dev, "failed to register spi host\n");
 		goto out_clk;
 	}
 
@@ -351,14 +351,14 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(spifc->clk);
 	pm_runtime_disable(spifc->dev);
 out_err:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return ret;
 }
 
 static void meson_spifc_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct meson_spifc *spifc = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct meson_spifc *spifc = spi_controller_get_devdata(host);
 
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spifc->clk);
@@ -368,11 +368,11 @@ static void meson_spifc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int meson_spifc_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct meson_spifc *spifc = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct meson_spifc *spifc = spi_controller_get_devdata(host);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -384,8 +384,8 @@ static int meson_spifc_suspend(struct device *dev)
 
 static int meson_spifc_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct meson_spifc *spifc = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct meson_spifc *spifc = spi_controller_get_devdata(host);
 	int ret;
 
 	if (!pm_runtime_suspended(dev)) {
@@ -396,7 +396,7 @@ static int meson_spifc_resume(struct device *dev)
 
 	meson_spifc_hw_init(spifc);
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret)
 		clk_disable_unprepare(spifc->clk);
 
@@ -407,8 +407,8 @@ static int meson_spifc_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int meson_spifc_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct meson_spifc *spifc = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct meson_spifc *spifc = spi_controller_get_devdata(host);
 
 	clk_disable_unprepare(spifc->clk);
 
@@ -417,8 +417,8 @@ static int meson_spifc_runtime_suspend(struct device *dev)
 
 static int meson_spifc_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct meson_spifc *spifc = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct meson_spifc *spifc = spi_controller_get_devdata(host);
 
 	return clk_prepare_enable(spifc->clk);
 }
-- 
2.25.1

