Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B35D6596BE
	for <lists+linux-spi@lfdr.de>; Fri, 30 Dec 2022 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiL3JbU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Dec 2022 04:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiL3JbS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Dec 2022 04:31:18 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AA91128
        for <linux-spi@vger.kernel.org>; Fri, 30 Dec 2022 01:31:16 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nk0K41f03zJpWW;
        Fri, 30 Dec 2022 17:27:20 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 30 Dec
 2022 17:31:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 1/3] spi: ath79: switch to use modern name
Date:   Fri, 30 Dec 2022 17:28:04 +0800
Message-ID: <20221230092806.1687340-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221230092806.1687340-1-yangyingliang@huawei.com>
References: <20221230092806.1687340-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Change legacy name master/slave to modern name host/target or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ath79.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 607e7a49fb89..795e88dbef1b 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -58,7 +58,7 @@ static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned int reg, u32 val)
 
 static inline struct ath79_spi *ath79_spidev_to_sp(struct spi_device *spi)
 {
-	return spi_master_get_devdata(spi->master);
+	return spi_controller_get_devdata(spi->controller);
 }
 
 static inline void ath79_spi_delay(struct ath79_spi *sp, unsigned int nsecs)
@@ -120,7 +120,7 @@ static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned int nsecs,
 		else
 			out = ioc & ~AR71XX_SPI_IOC_DO;
 
-		/* setup MSB (to slave) on trailing edge */
+		/* setup MSB (to target) on trailing edge */
 		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, out);
 		ath79_spi_delay(sp, nsecs);
 		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, out | AR71XX_SPI_IOC_CLK);
@@ -168,28 +168,28 @@ static const struct spi_controller_mem_ops ath79_mem_ops = {
 
 static int ath79_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct ath79_spi *sp;
 	unsigned long rate;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*sp));
-	if (master == NULL) {
-		dev_err(&pdev->dev, "failed to allocate spi master\n");
+	host = spi_alloc_host(&pdev->dev, sizeof(*sp));
+	if (host == NULL) {
+		dev_err(&pdev->dev, "failed to allocate spi host\n");
 		return -ENOMEM;
 	}
 
-	sp = spi_master_get_devdata(master);
-	master->dev.of_node = pdev->dev.of_node;
+	sp = spi_controller_get_devdata(host);
+	host->dev.of_node = pdev->dev.of_node;
 	platform_set_drvdata(pdev, sp);
 
-	master->use_gpio_descriptors = true;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->flags = SPI_MASTER_GPIO_SS;
-	master->num_chipselect = 3;
-	master->mem_ops = &ath79_mem_ops;
+	host->use_gpio_descriptors = true;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
+	host->flags = SPI_MASTER_GPIO_SS;
+	host->num_chipselect = 3;
+	host->mem_ops = &ath79_mem_ops;
 
-	sp->bitbang.master = master;
+	sp->bitbang.master = host;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
 	sp->bitbang.txrx_word[SPI_MODE_0] = ath79_spi_txrx_mode0;
 	sp->bitbang.flags = SPI_CS_HIGH;
@@ -197,18 +197,18 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	sp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sp->base)) {
 		ret = PTR_ERR(sp->base);
-		goto err_put_master;
+		goto err_put_host;
 	}
 
 	sp->clk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sp->clk)) {
 		ret = PTR_ERR(sp->clk);
-		goto err_put_master;
+		goto err_put_host;
 	}
 
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
-		goto err_put_master;
+		goto err_put_host;
 
 	rate = DIV_ROUND_UP(clk_get_rate(sp->clk), MHZ);
 	if (!rate) {
@@ -231,8 +231,8 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	ath79_spi_disable(sp);
 err_clk_disable:
 	clk_disable_unprepare(sp->clk);
-err_put_master:
-	spi_master_put(sp->bitbang.master);
+err_put_host:
+	spi_controller_put(host);
 
 	return ret;
 }
@@ -244,7 +244,7 @@ static int ath79_spi_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&sp->bitbang);
 	ath79_spi_disable(sp);
 	clk_disable_unprepare(sp->clk);
-	spi_master_put(sp->bitbang.master);
+	spi_controller_put(sp->bitbang.master);
 
 	return 0;
 }
-- 
2.25.1

