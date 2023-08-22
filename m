Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C4378377C
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjHVBiz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjHVBir (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4D180
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:44 -0700 (PDT)
Received: from dggpemm100012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVBmB3Mn1zrSPK;
        Tue, 22 Aug 2023 09:37:14 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:42 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 14/24] spi: tegra210-quad: switch to use modern name
Date:   Tue, 22 Aug 2023 09:35:01 +0800
Message-ID: <20230822013511.4161475-15-yangyingliang@huawei.com>
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
 drivers/spi/spi-tegra210-quad.c | 80 ++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index e9ad9b0b598b..afbd64a217eb 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -175,7 +175,7 @@ struct tegra_qspi_client_data {
 
 struct tegra_qspi {
 	struct device				*dev;
-	struct spi_master			*master;
+	struct spi_controller			*host;
 	/* lock to protect data accessed by irq */
 	spinlock_t				lock;
 
@@ -809,7 +809,7 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_transfer *t,
 					 bool is_first_of_msg)
 {
-	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
 	struct tegra_qspi_client_data *cdata = spi->controller_data;
 	u32 command1, command2, speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
@@ -870,7 +870,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 					 struct spi_transfer *t, u32 command1)
 {
-	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
 	unsigned int total_fifo_words;
 	u8 bus_width = 0;
 	int ret;
@@ -925,7 +925,7 @@ static int tegra_qspi_start_transfer_one(struct spi_device *spi,
 static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_device *spi)
 {
 	struct tegra_qspi_client_data *cdata;
-	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
 
 	cdata = devm_kzalloc(tqspi->dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
@@ -941,7 +941,7 @@ static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_devic
 
 static int tegra_qspi_setup(struct spi_device *spi)
 {
-	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
 	struct tegra_qspi_client_data *cdata = spi->controller_data;
 	unsigned long flags;
 	u32 val;
@@ -1005,7 +1005,7 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 
 static void tegra_qspi_transfer_end(struct spi_device *spi)
 {
-	struct tegra_qspi *tqspi = spi_master_get_devdata(spi->master);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
 	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
 
 	if (cs_val)
@@ -1316,10 +1316,10 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 	return true;
 }
 
-static int tegra_qspi_transfer_one_message(struct spi_master *master,
+static int tegra_qspi_transfer_one_message(struct spi_controller *host,
 					   struct spi_message *msg)
 {
-	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
 	int ret;
 
 	if (tegra_qspi_validate_cmb_seq(tqspi, msg))
@@ -1327,7 +1327,7 @@ static int tegra_qspi_transfer_one_message(struct spi_master *master,
 	else
 		ret = tegra_qspi_non_combined_seq_xfer(tqspi, msg);
 
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(host);
 
 	return ret;
 }
@@ -1533,38 +1533,38 @@ MODULE_DEVICE_TABLE(acpi, tegra_qspi_acpi_match);
 
 static int tegra_qspi_probe(struct platform_device *pdev)
 {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	struct tegra_qspi	*tqspi;
 	struct resource		*r;
 	int ret, qspi_irq;
 	int bus_num;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(*tqspi));
-	if (!master)
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*tqspi));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
-	tqspi = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, host);
+	tqspi = spi_controller_get_devdata(host);
 
-	master->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_CS_HIGH |
-			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
-	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
-	master->setup = tegra_qspi_setup;
-	master->transfer_one_message = tegra_qspi_transfer_one_message;
-	master->num_chipselect = 1;
-	master->auto_runtime_pm = true;
+	host->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_CS_HIGH |
+			  SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
+	host->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
+	host->setup = tegra_qspi_setup;
+	host->transfer_one_message = tegra_qspi_transfer_one_message;
+	host->num_chipselect = 1;
+	host->auto_runtime_pm = true;
 
 	bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
 	if (bus_num >= 0)
-		master->bus_num = bus_num;
+		host->bus_num = bus_num;
 
-	tqspi->master = master;
+	tqspi->host = host;
 	tqspi->dev = &pdev->dev;
 	spin_lock_init(&tqspi->lock);
 
 	tqspi->soc_data = device_get_match_data(&pdev->dev);
-	master->num_chipselect = tqspi->soc_data->cs_count;
+	host->num_chipselect = tqspi->soc_data->cs_count;
 	tqspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(tqspi->base))
 		return PTR_ERR(tqspi->base);
@@ -1625,10 +1625,10 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 		goto exit_pm_disable;
 	}
 
-	master->dev.of_node = pdev->dev.of_node;
-	ret = spi_register_master(master);
+	host->dev.of_node = pdev->dev.of_node;
+	ret = spi_register_controller(host);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register master: %d\n", ret);
+		dev_err(&pdev->dev, "failed to register host: %d\n", ret);
 		goto exit_free_irq;
 	}
 
@@ -1644,10 +1644,10 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
 static void tegra_qspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 	free_irq(tqspi->irq, tqspi);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
@@ -1655,15 +1655,15 @@ static void tegra_qspi_remove(struct platform_device *pdev)
 
 static int __maybe_unused tegra_qspi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 
-	return spi_master_suspend(master);
+	return spi_controller_suspend(host);
 }
 
 static int __maybe_unused tegra_qspi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -1676,13 +1676,13 @@ static int __maybe_unused tegra_qspi_resume(struct device *dev)
 	tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMAND2);
 	pm_runtime_put(dev);
 
-	return spi_master_resume(master);
+	return spi_controller_resume(host);
 }
 
 static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
 
 	/* Runtime pm disabled with ACPI */
 	if (has_acpi_companion(tqspi->dev))
@@ -1697,8 +1697,8 @@ static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev)
 
 static int __maybe_unused tegra_qspi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
 	int ret;
 
 	/* Runtime pm disabled with ACPI */
-- 
2.25.1

