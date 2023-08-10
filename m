Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC117772F2
	for <lists+linux-spi@lfdr.de>; Thu, 10 Aug 2023 10:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjHJIdK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Aug 2023 04:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjHJIdJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E53ED
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:08 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RM0XB1mnYz1L9kG;
        Thu, 10 Aug 2023 16:31:54 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:06 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:05 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 04/21] spi: meson-spifc: switch to use modern name
Date:   Thu, 10 Aug 2023 16:29:47 +0800
Message-ID: <20230810083004.3988597-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810083004.3988597-1-yangyingliang@huawei.com>
References: <20230810083004.3988597-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 drivers/spi/spi-meson-spifc.c | 94 +++++++++++++++++------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 06626f406f68..ec571856be1e 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -31,10 +31,10 @@
 #define REG_USER2		0x24
 #define REG_USER3		0x28
 #define REG_USER4		0x2c
-#define REG_SLAVE		0x30
-#define REG_SLAVE1		0x34
-#define REG_SLAVE2		0x38
-#define REG_SLAVE3		0x3c
+#define REG_TARGET		0x30
+#define REG_TARGET1		0x34
+#define REG_TARGET2		0x38
+#define REG_TARGET3		0x3c
 #define REG_C0			0x40
 #define REG_B8			0x60
 #define REG_MAX			0x7c
@@ -59,21 +59,21 @@
 #define USER1_BN_UC_DIN_SHIFT	8
 #define USER1_BN_UC_DIN_MASK	(0xff << 8)
 #define USER4_CS_ACT		BIT(30)
-#define SLAVE_TRST_DONE		BIT(4)
-#define SLAVE_OP_MODE		BIT(30)
-#define SLAVE_SW_RST		BIT(31)
+#define TARGET_TRST_DONE		BIT(4)
+#define TARGET_OP_MODE		BIT(30)
+#define TARGET_SW_RST		BIT(31)
 
 #define SPIFC_BUFFER_SIZE	64
 
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
@@ -97,8 +97,8 @@ static int meson_spifc_wait_ready(struct meson_spifc *spifc)
 	u32 data;
 
 	do {
-		regmap_read(spifc->regmap, REG_SLAVE, &data);
-		if (data & SLAVE_TRST_DONE)
+		regmap_read(spifc->regmap, REG_TARGET, &data);
+		if (data & TARGET_TRST_DONE)
 			return 0;
 		cond_resched();
 	} while (!time_after(jiffies, deadline));
@@ -223,7 +223,7 @@ static int meson_spifc_txrx(struct meson_spifc *spifc,
 			   keep_cs ? USER4_CS_ACT : 0);
 
 	/* clear transition done bit */
-	regmap_update_bits(spifc->regmap, REG_SLAVE, SLAVE_TRST_DONE, 0);
+	regmap_update_bits(spifc->regmap, REG_TARGET, TARGET_TRST_DONE, 0);
 	/* start transfer */
 	regmap_update_bits(spifc->regmap, REG_CMD, CMD_USER, CMD_USER);
 
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
@@ -274,29 +274,29 @@ static int meson_spifc_transfer_one(struct spi_master *master,
 static void meson_spifc_hw_init(struct meson_spifc *spifc)
 {
 	/* reset device */
-	regmap_update_bits(spifc->regmap, REG_SLAVE, SLAVE_SW_RST,
-			   SLAVE_SW_RST);
+	regmap_update_bits(spifc->regmap, REG_TARGET, TARGET_SW_RST,
+			   TARGET_SW_RST);
 	/* disable compatible mode */
 	regmap_update_bits(spifc->regmap, REG_USER, USER_CMP_MODE, 0);
-	/* set master mode */
-	regmap_update_bits(spifc->regmap, REG_SLAVE, SLAVE_OP_MODE, 0);
+	/* set host mode */
+	regmap_update_bits(spifc->regmap, REG_TARGET, TARGET_OP_MODE, 0);
 }
 
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

