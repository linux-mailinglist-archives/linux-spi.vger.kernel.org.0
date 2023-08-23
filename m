Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF3784F52
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 05:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjHWDdp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjHWDdn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 23:33:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DEEE51
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 20:33:40 -0700 (PDT)
Received: from dggpemm500018.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVsGL1Whsz1L9bp;
        Wed, 23 Aug 2023 11:32:10 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 23 Aug 2023 11:33:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:33:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next v2 17/21] spi: npcm-pspi: switch to use modern name
Date:   Wed, 23 Aug 2023 11:29:59 +0800
Message-ID: <20230823033003.3407403-18-yangyingliang@huawei.com>
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-npcm-pspi.c | 68 ++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 64585c2a25c5..a7feb20b06ee 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -20,7 +20,7 @@
 struct npcm_pspi {
 	struct completion xfer_done;
 	struct reset_control *reset;
-	struct spi_master *master;
+	struct spi_controller *host;
 	unsigned int tx_bytes;
 	unsigned int rx_bytes;
 	void __iomem *base;
@@ -101,7 +101,7 @@ static inline void npcm_pspi_disable(struct npcm_pspi *priv)
 
 static void npcm_pspi_set_mode(struct spi_device *spi)
 {
-	struct npcm_pspi *priv = spi_master_get_devdata(spi->master);
+	struct npcm_pspi *priv = spi_controller_get_devdata(spi->controller);
 	u16 regtemp;
 	u16 mode_val;
 
@@ -159,7 +159,7 @@ static void npcm_pspi_set_baudrate(struct npcm_pspi *priv, unsigned int speed)
 static void npcm_pspi_setup_transfer(struct spi_device *spi,
 				     struct spi_transfer *t)
 {
-	struct npcm_pspi *priv = spi_master_get_devdata(spi->master);
+	struct npcm_pspi *priv = spi_controller_get_devdata(spi->controller);
 
 	priv->tx_buf = t->tx_buf;
 	priv->rx_buf = t->rx_buf;
@@ -245,11 +245,11 @@ static void npcm_pspi_recv(struct npcm_pspi *priv)
 	}
 }
 
-static int npcm_pspi_transfer_one(struct spi_master *master,
+static int npcm_pspi_transfer_one(struct spi_controller *host,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
 {
-	struct npcm_pspi *priv = spi_master_get_devdata(master);
+	struct npcm_pspi *priv = spi_controller_get_devdata(host);
 	int status;
 
 	npcm_pspi_setup_transfer(spi, t);
@@ -266,18 +266,18 @@ static int npcm_pspi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
-static int npcm_pspi_prepare_transfer_hardware(struct spi_master *master)
+static int npcm_pspi_prepare_transfer_hardware(struct spi_controller *host)
 {
-	struct npcm_pspi *priv = spi_master_get_devdata(master);
+	struct npcm_pspi *priv = spi_controller_get_devdata(host);
 
 	npcm_pspi_irq_enable(priv, NPCM_PSPI_CTL1_EIR | NPCM_PSPI_CTL1_EIW);
 
 	return 0;
 }
 
-static int npcm_pspi_unprepare_transfer_hardware(struct spi_master *master)
+static int npcm_pspi_unprepare_transfer_hardware(struct spi_controller *host)
 {
-	struct npcm_pspi *priv = spi_master_get_devdata(master);
+	struct npcm_pspi *priv = spi_controller_get_devdata(host);
 
 	npcm_pspi_irq_disable(priv, NPCM_PSPI_CTL1_EIR | NPCM_PSPI_CTL1_EIW);
 
@@ -340,37 +340,37 @@ static irqreturn_t npcm_pspi_handler(int irq, void *dev_id)
 static int npcm_pspi_probe(struct platform_device *pdev)
 {
 	struct npcm_pspi *priv;
-	struct spi_master *master;
+	struct spi_controller *host;
 	unsigned long clk_hz;
 	int irq;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*priv));
+	if (!host)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
-	priv = spi_master_get_devdata(master);
-	priv->master = master;
+	priv = spi_controller_get_devdata(host);
+	priv->host = host;
 	priv->is_save_param = false;
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
-		goto out_master_put;
+		goto out_host_put;
 	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(priv->clk);
-		goto out_master_put;
+		goto out_host_put;
 	}
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
-		goto out_master_put;
+		goto out_host_put;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -398,42 +398,42 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 
 	clk_hz = clk_get_rate(priv->clk);
 
-	master->max_speed_hz = DIV_ROUND_UP(clk_hz, NPCM_PSPI_MIN_CLK_DIVIDER);
-	master->min_speed_hz = DIV_ROUND_UP(clk_hz, NPCM_PSPI_MAX_CLK_DIVIDER);
-	master->mode_bits = SPI_CPHA | SPI_CPOL;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = -1;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
-	master->transfer_one = npcm_pspi_transfer_one;
-	master->prepare_transfer_hardware =
+	host->max_speed_hz = DIV_ROUND_UP(clk_hz, NPCM_PSPI_MIN_CLK_DIVIDER);
+	host->min_speed_hz = DIV_ROUND_UP(clk_hz, NPCM_PSPI_MAX_CLK_DIVIDER);
+	host->mode_bits = SPI_CPHA | SPI_CPOL;
+	host->dev.of_node = pdev->dev.of_node;
+	host->bus_num = -1;
+	host->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	host->transfer_one = npcm_pspi_transfer_one;
+	host->prepare_transfer_hardware =
 		npcm_pspi_prepare_transfer_hardware;
-	master->unprepare_transfer_hardware =
+	host->unprepare_transfer_hardware =
 		npcm_pspi_unprepare_transfer_hardware;
-	master->use_gpio_descriptors = true;
+	host->use_gpio_descriptors = true;
 
 	/* set to default clock rate */
 	npcm_pspi_set_baudrate(priv, NPCM_PSPI_DEFAULT_CLK);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret)
 		goto out_disable_clk;
 
-	pr_info("NPCM Peripheral SPI %d probed\n", master->bus_num);
+	pr_info("NPCM Peripheral SPI %d probed\n", host->bus_num);
 
 	return 0;
 
 out_disable_clk:
 	clk_disable_unprepare(priv->clk);
 
-out_master_put:
-	spi_master_put(master);
+out_host_put:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void npcm_pspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct npcm_pspi *priv = spi_master_get_devdata(master);
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct npcm_pspi *priv = spi_controller_get_devdata(host);
 
 	npcm_pspi_reset_hw(priv);
 	clk_disable_unprepare(priv->clk);
-- 
2.25.1

