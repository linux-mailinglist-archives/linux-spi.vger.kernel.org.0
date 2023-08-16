Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393B077DD89
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbjHPJnf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243427AbjHPJnZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0C2E74
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:23 -0700 (PDT)
Received: from dggpemm100008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjln65pjzNmpP;
        Wed, 16 Aug 2023 17:39:49 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:21 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:20 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 01/24] spi: orion: switch to use modern name
Date:   Wed, 16 Aug 2023 17:39:50 +0800
Message-ID: <20230816094013.1275068-2-yangyingliang@huawei.com>
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
 drivers/spi/spi-orion.c | 90 ++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index faf2764b91a8..1f10f5c8e34d 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -90,7 +90,7 @@ struct orion_child_options {
 };
 
 struct orion_spi {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	void __iomem		*base;
 	struct clk              *clk;
 	struct clk              *axi_clk;
@@ -141,7 +141,7 @@ static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
 	struct orion_spi *orion_spi;
 	const struct orion_spi_dev *devdata;
 
-	orion_spi = spi_master_get_devdata(spi->master);
+	orion_spi = spi_controller_get_devdata(spi->controller);
 	devdata = orion_spi->devdata;
 
 	tclk_hz = clk_get_rate(orion_spi->clk);
@@ -235,7 +235,7 @@ orion_spi_mode_set(struct spi_device *spi)
 	u32 reg;
 	struct orion_spi *orion_spi;
 
-	orion_spi = spi_master_get_devdata(spi->master);
+	orion_spi = spi_controller_get_devdata(spi->controller);
 
 	reg = readl(spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
 	reg &= ~ORION_SPI_MODE_MASK;
@@ -257,7 +257,7 @@ orion_spi_50mhz_ac_timing_erratum(struct spi_device *spi, unsigned int speed)
 	u32 reg;
 	struct orion_spi *orion_spi;
 
-	orion_spi = spi_master_get_devdata(spi->master);
+	orion_spi = spi_controller_get_devdata(spi->controller);
 
 	/*
 	 * Erratum description: (Erratum NO. FE-9144572) The device
@@ -297,7 +297,7 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 	unsigned int bits_per_word = spi->bits_per_word;
 	int	rc;
 
-	orion_spi = spi_master_get_devdata(spi->master);
+	orion_spi = spi_controller_get_devdata(spi->controller);
 
 	if ((t != NULL) && t->speed_hz)
 		speed = t->speed_hz;
@@ -330,7 +330,7 @@ static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 	void __iomem *ctrl_reg;
 	u32 val;
 
-	orion_spi = spi_master_get_devdata(spi->master);
+	orion_spi = spi_controller_get_devdata(spi->controller);
 	ctrl_reg = spi_reg(orion_spi, ORION_SPI_IF_CTRL_REG);
 
 	val = readl(ctrl_reg);
@@ -388,7 +388,7 @@ orion_spi_write_read_8bit(struct spi_device *spi,
 
 	cs_single_byte = spi->mode & SPI_CS_WORD;
 
-	orion_spi = spi_master_get_devdata(spi->master);
+	orion_spi = spi_controller_get_devdata(spi->controller);
 
 	if (cs_single_byte)
 		orion_spi_set_cs(spi, 0);
@@ -439,7 +439,7 @@ orion_spi_write_read_16bit(struct spi_device *spi,
 		return -1;
 	}
 
-	orion_spi = spi_master_get_devdata(spi->master);
+	orion_spi = spi_controller_get_devdata(spi->controller);
 	tx_reg = spi_reg(orion_spi, ORION_SPI_DATA_OUT_REG);
 	rx_reg = spi_reg(orion_spi, ORION_SPI_DATA_IN_REG);
 	int_reg = spi_reg(orion_spi, ORION_SPI_INT_CAUSE_REG);
@@ -475,7 +475,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	word_len = spi->bits_per_word;
 	count = xfer->len;
 
-	orion_spi = spi_master_get_devdata(spi->master);
+	orion_spi = spi_controller_get_devdata(spi->controller);
 
 	/*
 	 * Use SPI direct write mode if base address is available
@@ -528,7 +528,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	return xfer->len - count;
 }
 
-static int orion_spi_transfer_one(struct spi_master *master,
+static int orion_spi_transfer_one(struct spi_controller *host,
 					struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -548,7 +548,7 @@ static int orion_spi_setup(struct spi_device *spi)
 {
 	int ret;
 #ifdef CONFIG_PM
-	struct orion_spi *orion_spi = spi_master_get_devdata(spi->master);
+	struct orion_spi *orion_spi = spi_controller_get_devdata(spi->controller);
 	struct device *dev = orion_spi->dev;
 
 	orion_spi_runtime_resume(dev);
@@ -644,44 +644,44 @@ MODULE_DEVICE_TABLE(of, orion_spi_of_match_table);
 static int orion_spi_probe(struct platform_device *pdev)
 {
 	const struct orion_spi_dev *devdata;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct orion_spi *spi;
 	struct resource *r;
 	unsigned long tclk_hz;
 	int status = 0;
 	struct device_node *np;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
-	if (master == NULL) {
-		dev_dbg(&pdev->dev, "master allocation failed\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(*spi));
+	if (host == NULL) {
+		dev_dbg(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
 	}
 
 	if (pdev->id != -1)
-		master->bus_num = pdev->id;
+		host->bus_num = pdev->id;
 	if (pdev->dev.of_node) {
 		u32 cell_index;
 
 		if (!of_property_read_u32(pdev->dev.of_node, "cell-index",
 					  &cell_index))
-			master->bus_num = cell_index;
+			host->bus_num = cell_index;
 	}
 
 	/* we support all 4 SPI modes and LSB first option */
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_CS_WORD;
-	master->set_cs = orion_spi_set_cs;
-	master->transfer_one = orion_spi_transfer_one;
-	master->num_chipselect = ORION_NUM_CHIPSELECTS;
-	master->setup = orion_spi_setup;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
-	master->auto_runtime_pm = true;
-	master->use_gpio_descriptors = true;
-	master->flags = SPI_CONTROLLER_GPIO_SS;
-
-	platform_set_drvdata(pdev, master);
-
-	spi = spi_master_get_devdata(master);
-	spi->master = master;
+	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_CS_WORD;
+	host->set_cs = orion_spi_set_cs;
+	host->transfer_one = orion_spi_transfer_one;
+	host->num_chipselect = ORION_NUM_CHIPSELECTS;
+	host->setup = orion_spi_setup;
+	host->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	host->auto_runtime_pm = true;
+	host->use_gpio_descriptors = true;
+	host->flags = SPI_CONTROLLER_GPIO_SS;
+
+	platform_set_drvdata(pdev, host);
+
+	spi = spi_controller_get_devdata(host);
+	spi->host = host;
 	spi->dev = &pdev->dev;
 
 	devdata = device_get_match_data(&pdev->dev);
@@ -718,14 +718,14 @@ static int orion_spi_probe(struct platform_device *pdev)
 	 */
 	if (of_device_is_compatible(pdev->dev.of_node,
 					"marvell,armada-370-spi"))
-		master->max_speed_hz = min(devdata->max_hz,
+		host->max_speed_hz = min(devdata->max_hz,
 				DIV_ROUND_UP(tclk_hz, devdata->min_divisor));
 	else if (devdata->min_divisor)
-		master->max_speed_hz =
+		host->max_speed_hz =
 			DIV_ROUND_UP(tclk_hz, devdata->min_divisor);
 	else
-		master->max_speed_hz = devdata->max_hz;
-	master->min_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->max_divisor);
+		host->max_speed_hz = devdata->max_hz;
+	host->min_speed_hz = DIV_ROUND_UP(tclk_hz, devdata->max_divisor);
 
 	spi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(spi->base)) {
@@ -784,8 +784,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto out_rel_pm;
 
-	master->dev.of_node = pdev->dev.of_node;
-	status = spi_register_master(master);
+	host->dev.of_node = pdev->dev.of_node;
+	status = spi_register_controller(host);
 	if (status < 0)
 		goto out_rel_pm;
 
@@ -798,21 +798,21 @@ static int orion_spi_probe(struct platform_device *pdev)
 out_rel_clk:
 	clk_disable_unprepare(spi->clk);
 out:
-	spi_master_put(master);
+	spi_controller_put(host);
 	return status;
 }
 
 
 static void orion_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct orion_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct orion_spi *spi = spi_controller_get_devdata(host);
 
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spi->axi_clk);
 	clk_disable_unprepare(spi->clk);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 	pm_runtime_disable(&pdev->dev);
 }
 
@@ -821,8 +821,8 @@ MODULE_ALIAS("platform:" DRIVER_NAME);
 #ifdef CONFIG_PM
 static int orion_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct orion_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct orion_spi *spi = spi_controller_get_devdata(host);
 
 	clk_disable_unprepare(spi->axi_clk);
 	clk_disable_unprepare(spi->clk);
@@ -831,8 +831,8 @@ static int orion_spi_runtime_suspend(struct device *dev)
 
 static int orion_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct orion_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct orion_spi *spi = spi_controller_get_devdata(host);
 
 	if (!IS_ERR(spi->axi_clk))
 		clk_prepare_enable(spi->axi_clk);
-- 
2.25.1

