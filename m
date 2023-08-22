Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815878377A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjHVBix (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjHVBiq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973A13E
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:43 -0700 (PDT)
Received: from dggpemm100013.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVBkL6BqczLp9v;
        Tue, 22 Aug 2023 09:35:38 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100013.china.huawei.com (7.185.36.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:42 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:41 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 13/24] spi: tegra20-slink: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:00 +0800
Message-ID: <20230822013511.4161475-14-yangyingliang@huawei.com>
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
 drivers/spi/spi-tegra20-slink.c | 98 ++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 4d6db6182c5e..990187b66f22 100644
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
@@ -1101,10 +1101,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
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
 
@@ -1122,17 +1122,17 @@ static int tegra_slink_probe(struct platform_device *pdev)
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
 
@@ -1144,21 +1144,21 @@ static void tegra_slink_remove(struct platform_device *pdev)
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
@@ -1170,14 +1170,14 @@ static int tegra_slink_resume(struct device *dev)
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
@@ -1188,8 +1188,8 @@ static int __maybe_unused tegra_slink_runtime_suspend(struct device *dev)
 
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

