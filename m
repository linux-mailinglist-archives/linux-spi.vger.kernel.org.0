Return-Path: <linux-spi+bounces-73-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C23B7FB5B8
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FEF2826D7
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0940748CCB;
	Tue, 28 Nov 2023 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77020109
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:28 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SfcRN2mcYzLqCF;
	Tue, 28 Nov 2023 17:22:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:24 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:24 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 13/26] spi: tegra20-slink: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:18 +0800
Message-ID: <20231128093031.3707034-14-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128093031.3707034-1-yangyingliang@huawei.com>
References: <20231128093031.3707034-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-tegra20-slink.c | 98 ++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index f5cd365c913a..ed1393d159ae 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -152,7 +152,7 @@ struct tegra_slink_chip_data {
 
 struct tegra_slink_data {
 	struct device				*dev;
-	struct spi_master			*master;
+	struct spi_controller			*host;
 	const struct tegra_slink_chip_data	*chip_data;
 	spinlock_t				lock;
 
@@ -671,7 +671,7 @@ static void tegra_slink_deinit_dma_param(struct tegra_slink_data *tspi,
 static int tegra_slink_start_transfer_one(struct spi_device *spi,
 		struct spi_transfer *t)
 {
-	struct tegra_slink_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_slink_data *tspi = spi_controller_get_devdata(spi->controller);
 	u32 speed;
 	u8 bits_per_word;
 	unsigned total_fifo_words;
@@ -737,7 +737,7 @@ static int tegra_slink_setup(struct spi_device *spi)
 			SLINK_CS_POLARITY3,
 	};
 
-	struct tegra_slink_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_slink_data *tspi = spi_controller_get_devdata(spi->controller);
 	u32 val;
 	unsigned long flags;
 	int ret;
@@ -768,10 +768,10 @@ static int tegra_slink_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int tegra_slink_prepare_message(struct spi_master *master,
+static int tegra_slink_prepare_message(struct spi_controller *host,
 				       struct spi_message *msg)
 {
-	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
+	struct tegra_slink_data *tspi = spi_controller_get_devdata(host);
 	struct spi_device *spi = msg->spi;
 
 	tegra_slink_clear_status(tspi);
@@ -794,11 +794,11 @@ static int tegra_slink_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static int tegra_slink_transfer_one(struct spi_master *master,
+static int tegra_slink_transfer_one(struct spi_controller *host,
 				    struct spi_device *spi,
 				    struct spi_transfer *xfer)
 {
-	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
+	struct tegra_slink_data *tspi = spi_controller_get_devdata(host);
 	int ret;
 
 	reinit_completion(&tspi->xfer_completion);
@@ -825,10 +825,10 @@ static int tegra_slink_transfer_one(struct spi_master *master,
 	return 0;
 }
 
-static int tegra_slink_unprepare_message(struct spi_master *master,
+static int tegra_slink_unprepare_message(struct spi_controller *host,
 					 struct spi_message *msg)
 {
-	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
+	struct tegra_slink_data *tspi = spi_controller_get_devdata(host);
 
 	tegra_slink_writel(tspi, tspi->def_command_reg, SLINK_COMMAND);
 	tegra_slink_writel(tspi, tspi->def_command2_reg, SLINK_COMMAND2);
@@ -999,7 +999,7 @@ MODULE_DEVICE_TABLE(of, tegra_slink_of_match);
 
 static int tegra_slink_probe(struct platform_device *pdev)
 {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct tegra_slink_data	*tspi;
 	struct resource		*r;
 	int ret, spi_irq;
@@ -1007,36 +1007,36 @@ static int tegra_slink_probe(struct platform_device *pdev)
 
 	cdata = of_device_get_match_data(&pdev->dev);
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*tspi));
-	if (!master) {
-		dev_err(&pdev->dev, "master allocation failed\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(*tspi));
+	if (!host) {
+		dev_err(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
 	}
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->setup = tegra_slink_setup;
-	master->prepare_message = tegra_slink_prepare_message;
-	master->transfer_one = tegra_slink_transfer_one;
-	master->unprepare_message = tegra_slink_unprepare_message;
-	master->auto_runtime_pm = true;
-	master->num_chipselect = MAX_CHIP_SELECT;
-
-	platform_set_drvdata(pdev, master);
-	tspi = spi_master_get_devdata(master);
-	tspi->master = master;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	host->setup = tegra_slink_setup;
+	host->prepare_message = tegra_slink_prepare_message;
+	host->transfer_one = tegra_slink_transfer_one;
+	host->unprepare_message = tegra_slink_unprepare_message;
+	host->auto_runtime_pm = true;
+	host->num_chipselect = MAX_CHIP_SELECT;
+
+	platform_set_drvdata(pdev, host);
+	tspi = spi_controller_get_devdata(host);
+	tspi->host = host;
 	tspi->dev = &pdev->dev;
 	tspi->chip_data = cdata;
 	spin_lock_init(&tspi->lock);
 
 	if (of_property_read_u32(tspi->dev->of_node, "spi-max-frequency",
-				 &master->max_speed_hz))
-		master->max_speed_hz = 25000000; /* 25MHz */
+				 &host->max_speed_hz))
+		host->max_speed_hz = 25000000; /* 25MHz */
 
 	tspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(tspi->base)) {
 		ret = PTR_ERR(tspi->base);
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 	tspi->phys = r->start;
 
@@ -1045,26 +1045,26 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	if (IS_ERR(tspi->clk)) {
 		ret = PTR_ERR(tspi->clk);
 		dev_err(&pdev->dev, "Can not get clock %d\n", ret);
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(tspi->rst)) {
 		dev_err(&pdev->dev, "can not get reset\n");
 		ret = PTR_ERR(tspi->rst);
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (ret)
-		goto exit_free_master;
+		goto exit_free_host;
 
 	tspi->max_buf_size = SLINK_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
 	ret = tegra_slink_init_dma_param(tspi, true);
 	if (ret < 0)
-		goto exit_free_master;
+		goto exit_free_host;
 	ret = tegra_slink_init_dma_param(tspi, false);
 	if (ret < 0)
 		goto exit_rx_dma_free;
@@ -1103,10 +1103,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	tegra_slink_writel(tspi, tspi->def_command_reg, SLINK_COMMAND);
 	tegra_slink_writel(tspi, tspi->def_command2_reg, SLINK_COMMAND2);
 
-	master->dev.of_node = pdev->dev.of_node;
-	ret = spi_register_master(master);
+	host->dev.of_node = pdev->dev.of_node;
+	ret = spi_register_controller(host);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
+		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_free_irq;
 	}
 
@@ -1124,17 +1124,17 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	tegra_slink_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_slink_deinit_dma_param(tspi, true);
-exit_free_master:
-	spi_master_put(master);
+exit_free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void tegra_slink_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
-	struct tegra_slink_data	*tspi = spi_master_get_devdata(master);
+	struct spi_controller *host = spi_controller_get(platform_get_drvdata(pdev));
+	struct tegra_slink_data	*tspi = spi_controller_get_devdata(host);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 
 	free_irq(tspi->irq, tspi);
 
@@ -1146,21 +1146,21 @@ static void tegra_slink_remove(struct platform_device *pdev)
 	if (tspi->rx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, true);
 
-	spi_master_put(master);
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int tegra_slink_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 
-	return spi_master_suspend(master);
+	return spi_controller_suspend(host);
 }
 
 static int tegra_slink_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_slink_data *tspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -1172,14 +1172,14 @@ static int tegra_slink_resume(struct device *dev)
 	tegra_slink_writel(tspi, tspi->command2_reg, SLINK_COMMAND2);
 	pm_runtime_put(dev);
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 #endif
 
 static int __maybe_unused tegra_slink_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_slink_data *tspi = spi_controller_get_devdata(host);
 
 	/* Flush all write which are in PPSB queue by reading back */
 	tegra_slink_readl(tspi, SLINK_MAS_DATA);
@@ -1190,8 +1190,8 @@ static int __maybe_unused tegra_slink_runtime_suspend(struct device *dev)
 
 static int __maybe_unused tegra_slink_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_slink_data *tspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(tspi->clk);
-- 
2.25.1


