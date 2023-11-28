Return-Path: <linux-spi+bounces-54-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795377FB5A4
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 10:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCE5282615
	for <lists+linux-spi@lfdr.de>; Tue, 28 Nov 2023 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3148CC3;
	Tue, 28 Nov 2023 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBCD109
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 01:26:22 -0800 (PST)
Received: from dggpemm100017.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SfcQf54hfzMnTs;
	Tue, 28 Nov 2023 17:21:30 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100017.china.huawei.com (7.185.36.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 17:26:20 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 17:26:20 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-spi@vger.kernel.org>
CC: <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
	<yangyingliang@huawei.com>
Subject: [PATCH -next 03/26] spi: st-ssc4: switch to use modern name
Date: Tue, 28 Nov 2023 17:30:08 +0800
Message-ID: <20231128093031.3707034-4-yangyingliang@huawei.com>
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
 drivers/spi/spi-st-ssc4.c | 70 +++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 7fcff9c539e2..e064025e2fd6 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -6,7 +6,7 @@
  *          Patrice Chotard <patrice.chotard@st.com>
  *          Lee Jones <lee.jones@linaro.org>
  *
- *  SPI master mode controller driver, used in STMicroelectronics devices.
+ *  SPI host mode controller driver, used in STMicroelectronics devices.
  */
 
 #include <linux/clk.h>
@@ -115,10 +115,10 @@ static void ssc_read_rx_fifo(struct spi_st *spi_st)
 	spi_st->words_remaining -= count;
 }
 
-static int spi_st_transfer_one(struct spi_master *master,
+static int spi_st_transfer_one(struct spi_controller *host,
 			       struct spi_device *spi, struct spi_transfer *t)
 {
-	struct spi_st *spi_st = spi_master_get_devdata(master);
+	struct spi_st *spi_st = spi_controller_get_devdata(host);
 	uint32_t ctl = 0;
 
 	/* Setup transfer */
@@ -165,7 +165,7 @@ static int spi_st_transfer_one(struct spi_master *master,
 	if (ctl)
 		writel_relaxed(ctl, spi_st->base + SSC_CTL);
 
-	spi_finalize_current_transfer(spi->master);
+	spi_finalize_current_transfer(spi->controller);
 
 	return t->len;
 }
@@ -174,7 +174,7 @@ static int spi_st_transfer_one(struct spi_master *master,
 #define MODEBITS  (SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_LOOP | SPI_CS_HIGH)
 static int spi_st_setup(struct spi_device *spi)
 {
-	struct spi_st *spi_st = spi_master_get_devdata(spi->master);
+	struct spi_st *spi_st = spi_controller_get_devdata(spi->controller);
 	u32 spi_st_clk, sscbrg, var;
 	u32 hz = spi->max_speed_hz;
 
@@ -274,35 +274,35 @@ static irqreturn_t spi_st_irq(int irq, void *dev_id)
 static int spi_st_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct spi_st *spi_st;
 	int irq, ret = 0;
 	u32 var;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi_st));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*spi_st));
+	if (!host)
 		return -ENOMEM;
 
-	master->dev.of_node		= np;
-	master->mode_bits		= MODEBITS;
-	master->setup			= spi_st_setup;
-	master->transfer_one		= spi_st_transfer_one;
-	master->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
-	master->auto_runtime_pm		= true;
-	master->bus_num			= pdev->id;
-	master->use_gpio_descriptors	= true;
-	spi_st				= spi_master_get_devdata(master);
+	host->dev.of_node		= np;
+	host->mode_bits			= MODEBITS;
+	host->setup			= spi_st_setup;
+	host->transfer_one		= spi_st_transfer_one;
+	host->bits_per_word_mask	= SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	host->auto_runtime_pm		= true;
+	host->bus_num			= pdev->id;
+	host->use_gpio_descriptors	= true;
+	spi_st				= spi_controller_get_devdata(host);
 
 	spi_st->clk = devm_clk_get(&pdev->dev, "ssc");
 	if (IS_ERR(spi_st->clk)) {
 		dev_err(&pdev->dev, "Unable to request clock\n");
 		ret = PTR_ERR(spi_st->clk);
-		goto put_master;
+		goto put_host;
 	}
 
 	ret = clk_prepare_enable(spi_st->clk);
 	if (ret)
-		goto put_master;
+		goto put_host;
 
 	init_completion(&spi_st->done);
 
@@ -324,7 +324,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	var &= ~SSC_CTL_SR;
 	writel_relaxed(var, spi_st->base + SSC_CTL);
 
-	/* Set SSC into slave mode before reconfiguring PIO pins */
+	/* Set SSC into target mode before reconfiguring PIO pins */
 	var = readl_relaxed(spi_st->base + SSC_CTL);
 	var &= ~SSC_CTL_MS;
 	writel_relaxed(var, spi_st->base + SSC_CTL);
@@ -347,11 +347,11 @@ static int spi_st_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register master\n");
+		dev_err(&pdev->dev, "Failed to register host\n");
 		goto rpm_disable;
 	}
 
@@ -361,15 +361,15 @@ static int spi_st_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 clk_disable:
 	clk_disable_unprepare(spi_st->clk);
-put_master:
-	spi_master_put(master);
+put_host:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void spi_st_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct spi_st *spi_st = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
 	pm_runtime_disable(&pdev->dev);
 
@@ -381,8 +381,8 @@ static void spi_st_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int spi_st_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct spi_st *spi_st = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
 	writel_relaxed(0, spi_st->base + SSC_IEN);
 	pinctrl_pm_select_sleep_state(dev);
@@ -394,8 +394,8 @@ static int spi_st_runtime_suspend(struct device *dev)
 
 static int spi_st_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct spi_st *spi_st = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct spi_st *spi_st = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(spi_st->clk);
@@ -408,10 +408,10 @@ static int spi_st_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int spi_st_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
@@ -420,10 +420,10 @@ static int spi_st_suspend(struct device *dev)
 
 static int spi_st_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(host);
 	if (ret)
 		return ret;
 
-- 
2.25.1


