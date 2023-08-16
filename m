Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9893577DD87
	for <lists+linux-spi@lfdr.de>; Wed, 16 Aug 2023 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243424AbjHPJng (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Aug 2023 05:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbjHPJn0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E50E26A4
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:24 -0700 (PDT)
Received: from dggpemm100010.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQjmS60pQzFqbx;
        Wed, 16 Aug 2023 17:40:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:22 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:21 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 03/24] spi: pic32-sqi: switch to use modern name
Date:   Wed, 16 Aug 2023 17:39:52 +0800
Message-ID: <20230816094013.1275068-4-yangyingliang@huawei.com>
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
 drivers/spi/spi-pic32-sqi.c | 86 ++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 5cbebcf26a2a..883354d0ff52 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -139,7 +139,7 @@ struct pic32_sqi {
 	void __iomem		*regs;
 	struct clk		*sys_clk;
 	struct clk		*base_clk; /* drives spi clock */
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	int			irq;
 	struct completion	xfer_done;
 	struct ring_desc	*ring;
@@ -316,9 +316,9 @@ static int pic32_sqi_one_transfer(struct pic32_sqi *sqi,
 	return 0;
 }
 
-static int pic32_sqi_prepare_hardware(struct spi_master *master)
+static int pic32_sqi_prepare_hardware(struct spi_controller *host)
 {
-	struct pic32_sqi *sqi = spi_master_get_devdata(master);
+	struct pic32_sqi *sqi = spi_controller_get_devdata(host);
 
 	/* enable spi interface */
 	pic32_setbits(sqi->regs + PESQI_CONF_REG, PESQI_EN);
@@ -328,7 +328,7 @@ static int pic32_sqi_prepare_hardware(struct spi_master *master)
 	return 0;
 }
 
-static bool pic32_sqi_can_dma(struct spi_master *master,
+static bool pic32_sqi_can_dma(struct spi_controller *host,
 			      struct spi_device *spi,
 			      struct spi_transfer *x)
 {
@@ -336,7 +336,7 @@ static bool pic32_sqi_can_dma(struct spi_master *master,
 	return true;
 }
 
-static int pic32_sqi_one_message(struct spi_master *master,
+static int pic32_sqi_one_message(struct spi_controller *host,
 				 struct spi_message *msg)
 {
 	struct spi_device *spi = msg->spi;
@@ -347,7 +347,7 @@ static int pic32_sqi_one_message(struct spi_master *master,
 	unsigned long timeout;
 	u32 val;
 
-	sqi = spi_master_get_devdata(master);
+	sqi = spi_controller_get_devdata(host);
 
 	reinit_completion(&sqi->xfer_done);
 	msg->actual_length = 0;
@@ -412,7 +412,7 @@ static int pic32_sqi_one_message(struct spi_master *master,
 	/* wait for xfer completion */
 	timeout = wait_for_completion_timeout(&sqi->xfer_done, 5 * HZ);
 	if (timeout == 0) {
-		dev_err(&sqi->master->dev, "wait timedout/interrupted\n");
+		dev_err(&sqi->host->dev, "wait timedout/interrupted\n");
 		ret = -ETIMEDOUT;
 		msg->status = ret;
 	} else {
@@ -434,14 +434,14 @@ static int pic32_sqi_one_message(struct spi_master *master,
 		/* release ring descr */
 		ring_desc_put(sqi, rdesc);
 	}
-	spi_finalize_current_message(spi->master);
+	spi_finalize_current_message(spi->controller);
 
 	return ret;
 }
 
-static int pic32_sqi_unprepare_hardware(struct spi_master *master)
+static int pic32_sqi_unprepare_hardware(struct spi_controller *host)
 {
-	struct pic32_sqi *sqi = spi_master_get_devdata(master);
+	struct pic32_sqi *sqi = spi_controller_get_devdata(host);
 
 	/* disable clk */
 	pic32_clrbits(sqi->regs + PESQI_CLK_CTRL_REG, PESQI_CLK_EN);
@@ -458,18 +458,18 @@ static int ring_desc_ring_alloc(struct pic32_sqi *sqi)
 	int i;
 
 	/* allocate coherent DMAable memory for hardware buffer descriptors. */
-	sqi->bd = dma_alloc_coherent(&sqi->master->dev,
+	sqi->bd = dma_alloc_coherent(&sqi->host->dev,
 				     sizeof(*bd) * PESQI_BD_COUNT,
 				     &sqi->bd_dma, GFP_KERNEL);
 	if (!sqi->bd) {
-		dev_err(&sqi->master->dev, "failed allocating dma buffer\n");
+		dev_err(&sqi->host->dev, "failed allocating dma buffer\n");
 		return -ENOMEM;
 	}
 
 	/* allocate software ring descriptors */
 	sqi->ring = kcalloc(PESQI_BD_COUNT, sizeof(*rdesc), GFP_KERNEL);
 	if (!sqi->ring) {
-		dma_free_coherent(&sqi->master->dev,
+		dma_free_coherent(&sqi->host->dev,
 				  sizeof(*bd) * PESQI_BD_COUNT,
 				  sqi->bd, sqi->bd_dma);
 		return -ENOMEM;
@@ -498,7 +498,7 @@ static int ring_desc_ring_alloc(struct pic32_sqi *sqi)
 
 static void ring_desc_ring_free(struct pic32_sqi *sqi)
 {
-	dma_free_coherent(&sqi->master->dev,
+	dma_free_coherent(&sqi->host->dev,
 			  sizeof(struct buf_desc) * PESQI_BD_COUNT,
 			  sqi->bd, sqi->bd_dma);
 	kfree(sqi->ring);
@@ -568,28 +568,28 @@ static void pic32_sqi_hw_init(struct pic32_sqi *sqi)
 
 static int pic32_sqi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct pic32_sqi *sqi;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*sqi));
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, sizeof(*sqi));
+	if (!host)
 		return -ENOMEM;
 
-	sqi = spi_master_get_devdata(master);
-	sqi->master = master;
+	sqi = spi_controller_get_devdata(host);
+	sqi->host = host;
 
 	sqi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sqi->regs)) {
 		ret = PTR_ERR(sqi->regs);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	/* irq */
 	sqi->irq = platform_get_irq(pdev, 0);
 	if (sqi->irq < 0) {
 		ret = sqi->irq;
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	/* clocks */
@@ -597,27 +597,27 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	if (IS_ERR(sqi->sys_clk)) {
 		ret = PTR_ERR(sqi->sys_clk);
 		dev_err(&pdev->dev, "no sys_clk ?\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	sqi->base_clk = devm_clk_get(&pdev->dev, "spi_ck");
 	if (IS_ERR(sqi->base_clk)) {
 		ret = PTR_ERR(sqi->base_clk);
 		dev_err(&pdev->dev, "no base clk ?\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	ret = clk_prepare_enable(sqi->sys_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "sys clk enable failed\n");
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	ret = clk_prepare_enable(sqi->base_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "base clk enable failed\n");
 		clk_disable_unprepare(sqi->sys_clk);
-		goto err_free_master;
+		goto err_free_host;
 	}
 
 	init_completion(&sqi->xfer_done);
@@ -640,24 +640,24 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 		goto err_free_ring;
 	}
 
-	/* register master */
-	master->num_chipselect	= 2;
-	master->max_speed_hz	= clk_get_rate(sqi->base_clk);
-	master->dma_alignment	= 32;
-	master->max_dma_len	= PESQI_BD_BUF_LEN_MAX;
-	master->dev.of_node	= pdev->dev.of_node;
-	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_TX_DUAL |
+	/* register host */
+	host->num_chipselect	= 2;
+	host->max_speed_hz	= clk_get_rate(sqi->base_clk);
+	host->dma_alignment	= 32;
+	host->max_dma_len	= PESQI_BD_BUF_LEN_MAX;
+	host->dev.of_node	= pdev->dev.of_node;
+	host->mode_bits		= SPI_MODE_3 | SPI_MODE_0 | SPI_TX_DUAL |
 				  SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
-	master->flags		= SPI_CONTROLLER_HALF_DUPLEX;
-	master->can_dma		= pic32_sqi_can_dma;
-	master->bits_per_word_mask	= SPI_BPW_RANGE_MASK(8, 32);
-	master->transfer_one_message	= pic32_sqi_one_message;
-	master->prepare_transfer_hardware	= pic32_sqi_prepare_hardware;
-	master->unprepare_transfer_hardware	= pic32_sqi_unprepare_hardware;
-
-	ret = devm_spi_register_master(&pdev->dev, master);
+	host->flags		= SPI_CONTROLLER_HALF_DUPLEX;
+	host->can_dma		= pic32_sqi_can_dma;
+	host->bits_per_word_mask	= SPI_BPW_RANGE_MASK(8, 32);
+	host->transfer_one_message	= pic32_sqi_one_message;
+	host->prepare_transfer_hardware	= pic32_sqi_prepare_hardware;
+	host->unprepare_transfer_hardware	= pic32_sqi_unprepare_hardware;
+
+	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
-		dev_err(&master->dev, "failed registering spi master\n");
+		dev_err(&host->dev, "failed registering spi host\n");
 		free_irq(sqi->irq, sqi);
 		goto err_free_ring;
 	}
@@ -673,8 +673,8 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(sqi->base_clk);
 	clk_disable_unprepare(sqi->sys_clk);
 
-err_free_master:
-	spi_master_put(master);
+err_free_host:
+	spi_controller_put(host);
 	return ret;
 }
 
-- 
2.25.1

