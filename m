Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0389A7668F1
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjG1JfK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbjG1JfJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 05:35:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9997910EC
        for <linux-spi@vger.kernel.org>; Fri, 28 Jul 2023 02:35:07 -0700 (PDT)
Received: from dggpemm100004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC2TB0yd8zNmfF;
        Fri, 28 Jul 2023 17:31:42 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:35:05 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 17:35:05 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 03/21] spi: spi-axi-spi-engine: switch to use modern name
Date:   Fri, 28 Jul 2023 17:32:03 +0800
Message-ID: <20230728093221.3312026-4-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728093221.3312026-1-yangyingliang@huawei.com>
References: <20230728093221.3312026-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-axi-spi-engine.c | 58 ++++++++++++++++----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 89661f3b0d44..c5b568543149 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -356,8 +356,8 @@ static bool spi_engine_read_rx_fifo(struct spi_engine *spi_engine)
 
 static irqreturn_t spi_engine_irq(int irq, void *devid)
 {
-	struct spi_master *master = devid;
-	struct spi_engine *spi_engine = spi_master_get_devdata(master);
+	struct spi_controller *host = devid;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	unsigned int disable_int = 0;
 	unsigned int pending;
 
@@ -396,7 +396,7 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 			msg->status = 0;
 			msg->actual_length = msg->frame_length;
 			spi_engine->msg = NULL;
-			spi_finalize_current_message(master);
+			spi_finalize_current_message(host);
 			disable_int |= SPI_ENGINE_INT_SYNC;
 		}
 	}
@@ -412,11 +412,11 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static int spi_engine_transfer_one_message(struct spi_master *master,
+static int spi_engine_transfer_one_message(struct spi_controller *host,
 	struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
-	struct spi_engine *spi_engine = spi_master_get_devdata(master);
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	unsigned int int_enable = 0;
 	unsigned long flags;
 	size_t size;
@@ -464,7 +464,7 @@ static int spi_engine_transfer_one_message(struct spi_master *master,
 static int spi_engine_probe(struct platform_device *pdev)
 {
 	struct spi_engine *spi_engine;
-	struct spi_master *master;
+	struct spi_controller *host;
 	unsigned int version;
 	int irq;
 	int ret;
@@ -477,29 +477,29 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (!spi_engine)
 		return -ENOMEM;
 
-	master = spi_alloc_master(&pdev->dev, 0);
-	if (!master)
+	host = spi_alloc_host(&pdev->dev, 0);
+	if (!host)
 		return -ENOMEM;
 
-	spi_master_set_devdata(master, spi_engine);
+	spi_controller_set_devdata(host, spi_engine);
 
 	spin_lock_init(&spi_engine->lock);
 
 	spi_engine->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk)) {
 		ret = PTR_ERR(spi_engine->clk);
-		goto err_put_master;
+		goto err_put_host;
 	}
 
 	spi_engine->ref_clk = devm_clk_get(&pdev->dev, "spi_clk");
 	if (IS_ERR(spi_engine->ref_clk)) {
 		ret = PTR_ERR(spi_engine->ref_clk);
-		goto err_put_master;
+		goto err_put_host;
 	}
 
 	ret = clk_prepare_enable(spi_engine->clk);
 	if (ret)
-		goto err_put_master;
+		goto err_put_host;
 
 	ret = clk_prepare_enable(spi_engine->ref_clk);
 	if (ret)
@@ -525,46 +525,46 @@ static int spi_engine_probe(struct platform_device *pdev)
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
 
-	ret = request_irq(irq, spi_engine_irq, 0, pdev->name, master);
+	ret = request_irq(irq, spi_engine_irq, 0, pdev->name, host);
 	if (ret)
 		goto err_ref_clk_disable;
 
-	master->dev.of_node = pdev->dev.of_node;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
-	master->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
-	master->transfer_one_message = spi_engine_transfer_one_message;
-	master->num_chipselect = 8;
+	host->dev.of_node = pdev->dev.of_node;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
+	host->bits_per_word_mask = SPI_BPW_MASK(8);
+	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
+	host->transfer_one_message = spi_engine_transfer_one_message;
+	host->num_chipselect = 8;
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto err_free_irq;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, host);
 
 	return 0;
 err_free_irq:
-	free_irq(irq, master);
+	free_irq(irq, host);
 err_ref_clk_disable:
 	clk_disable_unprepare(spi_engine->ref_clk);
 err_clk_disable:
 	clk_disable_unprepare(spi_engine->clk);
-err_put_master:
-	spi_master_put(master);
+err_put_host:
+	spi_controller_put(host);
 	return ret;
 }
 
 static void spi_engine_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
-	struct spi_engine *spi_engine = spi_master_get_devdata(master);
+	struct spi_controller *host = spi_controller_get(platform_get_drvdata(pdev));
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	int irq = platform_get_irq(pdev, 0);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(host);
 
-	free_irq(irq, master);
+	free_irq(irq, host);
 
-	spi_master_put(master);
+	spi_controller_put(host);
 
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
-- 
2.25.1

