Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BB78376F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 03:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjHVBio (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Aug 2023 21:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjHVBin (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Aug 2023 21:38:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D7186
        for <linux-spi@vger.kernel.org>; Mon, 21 Aug 2023 18:38:41 -0700 (PDT)
Received: from dggpemm100019.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVBjY00L2ztS9P;
        Tue, 22 Aug 2023 09:34:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100019.china.huawei.com (7.185.36.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 22 Aug 2023 09:38:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 09:38:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 06/24] spi: sun4i: switch to use modern name
Date:   Tue, 22 Aug 2023 09:34:53 +0800
Message-ID: <20230822013511.4161475-7-yangyingliang@huawei.com>
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
 drivers/spi/spi-sun4i.c | 70 ++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index b8947265d329..8f1d960ffa29 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -75,7 +75,7 @@
 #define SUN4I_FIFO_STA_TF_CNT_BITS		16
 
 struct sun4i_spi {
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	void __iomem		*base_addr;
 	struct clk		*hclk;
 	struct clk		*mclk;
@@ -161,7 +161,7 @@ static inline void sun4i_spi_fill_fifo(struct sun4i_spi *sspi, int len)
 
 static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct sun4i_spi *sspi = spi_master_get_devdata(spi->master);
+	struct sun4i_spi *sspi = spi_controller_get_devdata(spi->controller);
 	u32 reg;
 
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
@@ -201,11 +201,11 @@ static size_t sun4i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN4I_MAX_XFER_SIZE - 1;
 }
 
-static int sun4i_spi_transfer_one(struct spi_master *master,
+static int sun4i_spi_transfer_one(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *tfr)
 {
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
 	unsigned int mclk_rate, div, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
@@ -331,7 +331,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 					      msecs_to_jiffies(tx_time));
 	end = jiffies;
 	if (!timeout) {
-		dev_warn(&master->dev,
+		dev_warn(&host->dev,
 			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
 			 jiffies_to_msecs(end - start), tx_time);
@@ -386,8 +386,8 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 
 static int sun4i_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
 	int ret;
 
 	ret = clk_prepare_enable(sspi->hclk);
@@ -415,8 +415,8 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 
 static int sun4i_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct sun4i_spi *sspi = spi_master_get_devdata(master);
+	struct spi_controller *host = dev_get_drvdata(dev);
+	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
 
 	clk_disable_unprepare(sspi->mclk);
 	clk_disable_unprepare(sspi->hclk);
@@ -426,62 +426,62 @@ static int sun4i_spi_runtime_suspend(struct device *dev)
 
 static int sun4i_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct sun4i_spi *sspi;
 	int ret = 0, irq;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sun4i_spi));
-	if (!master) {
+	host = spi_alloc_host(&pdev->dev, sizeof(struct sun4i_spi));
+	if (!host) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
 		return -ENOMEM;
 	}
 
-	platform_set_drvdata(pdev, master);
-	sspi = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, host);
+	sspi = spi_controller_get_devdata(host);
 
 	sspi->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sspi->base_addr)) {
 		ret = PTR_ERR(sspi->base_addr);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENXIO;
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
 			       0, "sun4i-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
-	sspi->master = master;
-	master->max_speed_hz = 100 * 1000 * 1000;
-	master->min_speed_hz = 3 * 1000;
-	master->set_cs = sun4i_spi_set_cs;
-	master->transfer_one = sun4i_spi_transfer_one;
-	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->max_transfer_size = sun4i_spi_max_transfer_size;
+	sspi->host = host;
+	host->max_speed_hz = 100 * 1000 * 1000;
+	host->min_speed_hz = 3 * 1000;
+	host->set_cs = sun4i_spi_set_cs;
+	host->transfer_one = sun4i_spi_transfer_one;
+	host->num_chipselect = 4;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->dev.of_node = pdev->dev.of_node;
+	host->auto_runtime_pm = true;
+	host->max_transfer_size = sun4i_spi_max_transfer_size;
 
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
 		dev_err(&pdev->dev, "Unable to acquire AHB clock\n");
 		ret = PTR_ERR(sspi->hclk);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	sspi->mclk = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(sspi->mclk)) {
 		dev_err(&pdev->dev, "Unable to acquire module clock\n");
 		ret = PTR_ERR(sspi->mclk);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	init_completion(&sspi->done);
@@ -493,16 +493,16 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	ret = sun4i_spi_runtime_resume(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't resume the device\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot register SPI master\n");
+		dev_err(&pdev->dev, "cannot register SPI host\n");
 		goto err_pm_disable;
 	}
 
@@ -511,8 +511,8 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	sun4i_spi_runtime_suspend(&pdev->dev);
-err_free_master:
-	spi_master_put(master);
+err_free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
-- 
2.25.1

