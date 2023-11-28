Return-Path: <linux-spi+bounces-63-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4B7FB5AF
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473A8B21863
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BD246549;
	Tue, 28 Nov 2023 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB1DD4E
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:25 -0800 (PST)
Received: from dggpemm100002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SfcWj1TJMzvRCk;
	Tue, 28 Nov 2023 17:25:53 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:23 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:23 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 11/26] spi: tegra114: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:16 +0800
Message-ID: <20231128093031.3707034-12-yangyingliang@huawei.com>
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
 drivers/spi/spi-tegra114.c | 118 ++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 460f232dad50..bc7cc4088eea 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -164,7 +164,7 @@ struct tegra_spi_client_data {
 
 struct tegra_spi_data {
 	struct device				*dev;
-	struct spi_master			*master;
+	struct spi_controller			*host;
 	spinlock_t				lock;
 
 	struct clk				*clk;
@@ -718,7 +718,7 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 
 static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 {
-	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(spi->controller);
 	struct spi_delay *setup = &spi->cs_setup;
 	struct spi_delay *hold = &spi->cs_hold;
 	struct spi_delay *inactive = &spi->cs_inactive;
@@ -772,7 +772,7 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 					bool is_first_of_msg,
 					bool is_single_xfer)
 {
-	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(spi->controller);
 	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
@@ -865,7 +865,7 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 static int tegra_spi_start_transfer_one(struct spi_device *spi,
 		struct spi_transfer *t, u32 command1)
 {
-	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(spi->controller);
 	unsigned total_fifo_words;
 	int ret;
 
@@ -912,10 +912,10 @@ static struct tegra_spi_client_data
 	*tegra_spi_parse_cdata_dt(struct spi_device *spi)
 {
 	struct tegra_spi_client_data *cdata;
-	struct device_node *slave_np;
+	struct device_node *target_np;
 
-	slave_np = spi->dev.of_node;
-	if (!slave_np) {
+	target_np = spi->dev.of_node;
+	if (!target_np) {
 		dev_dbg(&spi->dev, "device node not found\n");
 		return NULL;
 	}
@@ -924,9 +924,9 @@ static struct tegra_spi_client_data
 	if (!cdata)
 		return NULL;
 
-	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
+	of_property_read_u32(target_np, "nvidia,tx-clk-tap-delay",
 			     &cdata->tx_clk_tap_delay);
-	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
+	of_property_read_u32(target_np, "nvidia,rx-clk-tap-delay",
 			     &cdata->rx_clk_tap_delay);
 	return cdata;
 }
@@ -942,7 +942,7 @@ static void tegra_spi_cleanup(struct spi_device *spi)
 
 static int tegra_spi_setup(struct spi_device *spi)
 {
-	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(spi->controller);
 	struct tegra_spi_client_data *cdata = spi->controller_data;
 	u32 val;
 	unsigned long flags;
@@ -993,7 +993,7 @@ static int tegra_spi_setup(struct spi_device *spi)
 
 static void tegra_spi_transfer_end(struct spi_device *spi)
 {
-	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(spi->controller);
 	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 
 	/* GPIO based chip select control */
@@ -1025,11 +1025,11 @@ static void tegra_spi_dump_regs(struct tegra_spi_data *tspi)
 		tegra_spi_readl(tspi, SPI_FIFO_STATUS));
 }
 
-static int tegra_spi_transfer_one_message(struct spi_master *master,
+static int tegra_spi_transfer_one_message(struct spi_controller *host,
 			struct spi_message *msg)
 {
 	bool is_first_msg = true;
-	struct tegra_spi_data *tspi = spi_master_get_devdata(master);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(host);
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	int ret;
@@ -1078,7 +1078,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			reset_control_assert(tspi->rst);
 			udelay(2);
 			reset_control_deassert(tspi->rst);
-			tspi->last_used_cs = master->num_chipselect + 1;
+			tspi->last_used_cs = host->num_chipselect + 1;
 			goto complete_xfer;
 		}
 
@@ -1112,7 +1112,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	ret = 0;
 exit:
 	msg->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 	return ret;
 }
 
@@ -1293,40 +1293,40 @@ MODULE_DEVICE_TABLE(of, tegra_spi_of_match);
 
 static int tegra_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct tegra_spi_data	*tspi;
 	struct resource		*r;
 	int ret, spi_irq;
 	int bus_num;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*tspi));
-	if (!master) {
-		dev_err(&pdev->dev, "master allocation failed\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(*tspi));
+	if (!host) {
+		dev_err(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(pdev, master);
-	tspi = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, host);
+	tspi = spi_controller_get_devdata(host);
 
 	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
-				 &master->max_speed_hz))
-		master->max_speed_hz = 25000000; /* 25MHz */
+				 &host->max_speed_hz))
+		host->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
-	master->use_gpio_descriptors = true;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-	master->setup = tegra_spi_setup;
-	master->cleanup = tegra_spi_cleanup;
-	master->transfer_one_message = tegra_spi_transfer_one_message;
-	master->set_cs_timing = tegra_spi_set_hw_cs_timing;
-	master->num_chipselect = MAX_CHIP_SELECT;
-	master->auto_runtime_pm = true;
+	host->use_gpio_descriptors = true;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			  SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	host->setup = tegra_spi_setup;
+	host->cleanup = tegra_spi_cleanup;
+	host->transfer_one_message = tegra_spi_transfer_one_message;
+	host->set_cs_timing = tegra_spi_set_hw_cs_timing;
+	host->num_chipselect = MAX_CHIP_SELECT;
+	host->auto_runtime_pm = true;
 	bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
 	if (bus_num >= 0)
-		master->bus_num = bus_num;
+		host->bus_num = bus_num;
 
-	tspi->master = master;
+	tspi->host = host;
 	tspi->dev = &pdev->dev;
 	spin_lock_init(&tspi->lock);
 
@@ -1334,20 +1334,20 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	if (!tspi->soc_data) {
 		dev_err(&pdev->dev, "unsupported tegra\n");
 		ret = -ENODEV;
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 
 	tspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(tspi->base)) {
 		ret = PTR_ERR(tspi->base);
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 	tspi->phys = r->start;
 
 	spi_irq = platform_get_irq(pdev, 0);
 	if (spi_irq < 0) {
 		ret = spi_irq;
-		goto exit_free_master;
+		goto exit_free_host;
 	}
 	tspi->irq = spi_irq;
 
@@ -1355,14 +1355,14 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(tspi->clk)) {
 		dev_err(&pdev->dev, "can not get clock\n");
 		ret = PTR_ERR(tspi->clk);
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
 
 	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
@@ -1370,7 +1370,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	ret = tegra_spi_init_dma_param(tspi, true);
 	if (ret < 0)
-		goto exit_free_master;
+		goto exit_free_host;
 	ret = tegra_spi_init_dma_param(tspi, false);
 	if (ret < 0)
 		goto exit_rx_dma_free;
@@ -1401,7 +1401,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
 	tspi->def_command2_reg = tegra_spi_readl(tspi, SPI_COMMAND2);
-	tspi->last_used_cs = master->num_chipselect + 1;
+	tspi->last_used_cs = host->num_chipselect + 1;
 	pm_runtime_put(&pdev->dev);
 	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
 				   tegra_spi_isr_thread, IRQF_ONESHOT,
@@ -1412,10 +1412,10 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		goto exit_pm_disable;
 	}
 
-	master->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_master(&pdev->dev, master);
+	host->dev.of_node = pdev->dev.of_node;
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
+		dev_err(&pdev->dev, "can not register to host err %d\n", ret);
 		goto exit_free_irq;
 	}
 	return ret;
@@ -1429,15 +1429,15 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_spi_deinit_dma_param(tspi, true);
-exit_free_master:
-	spi_master_put(master);
+exit_free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void tegra_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct tegra_spi_data	*tspi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct tegra_spi_data	*tspi = spi_controller_get_devdata(host);
 
 	free_irq(tspi->irq, tspi);
 
@@ -1455,15 +1455,15 @@ static void tegra_spi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int tegra_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 
-	return spi_master_suspend(master);
+	return spi_controller_suspend(host);
 }
 
 static int tegra_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_spi_data *tspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -1473,17 +1473,17 @@ static int tegra_spi_resume(struct device *dev)
 	}
 	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
 	tegra_spi_writel(tspi, tspi->def_command2_reg, SPI_COMMAND2);
-	tspi->last_used_cs = master->num_chipselect + 1;
+	tspi->last_used_cs = host->num_chipselect + 1;
 	pm_runtime_put(dev);
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 #endif
 
 static int tegra_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_spi_data *tspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(host);
 
 	/* Flush all write which are in PPSB queue by reading back */
 	tegra_spi_readl(tspi, SPI_COMMAND1);
@@ -1494,8 +1494,8 @@ static int tegra_spi_runtime_suspend(struct device *dev)
 
 static int tegra_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_spi_data *tspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_spi_data *tspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(tspi->clk);
-- 
2.25.1


