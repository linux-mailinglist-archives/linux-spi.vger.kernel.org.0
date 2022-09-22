Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438BF5E5D66
	for <lists+linux-spi@lfdr.de>; Thu, 22 Sep 2022 10:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiIVIYq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Sep 2022 04:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiIVIYc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Sep 2022 04:24:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3401F9F1
        for <linux-spi@vger.kernel.org>; Thu, 22 Sep 2022 01:24:18 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MY7WD6ScZz14R5F;
        Thu, 22 Sep 2022 16:20:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:24:11 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 16:24:10 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next v2 2/6] spi: ath79: Switch to use __devm_spi_alloc_controller()
Date:   Thu, 22 Sep 2022 16:30:59 +0800
Message-ID: <20220922083103.666157-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922083103.666157-1-yangyingliang@huawei.com>
References: <20220922083103.666157-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With using __devm_spi_alloc_controller(), spi_controller_put() is called in
devres_release_all() whenever the device is unbound, so the spi_master_put()
in error path can be removed. Also replace spi_master_get_devdata() with
spi_controller_get_devdata().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-ath79.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 607e7a49fb89..3b9dbe4b8f16 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -168,47 +168,43 @@ static const struct spi_controller_mem_ops ath79_mem_ops = {
 
 static int ath79_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *ctlr;
 	struct ath79_spi *sp;
 	unsigned long rate;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*sp));
-	if (master == NULL) {
-		dev_err(&pdev->dev, "failed to allocate spi master\n");
+	ctlr = __devm_spi_alloc_controller(&pdev->dev, sizeof(*sp), false);
+	if (!ctlr) {
+		dev_err(&pdev->dev, "failed to allocate spi controller\n");
 		return -ENOMEM;
 	}
 
-	sp = spi_master_get_devdata(master);
-	master->dev.of_node = pdev->dev.of_node;
+	sp = spi_controller_get_devdata(ctlr);
+	ctlr->dev.of_node = pdev->dev.of_node;
 	platform_set_drvdata(pdev, sp);
 
-	master->use_gpio_descriptors = true;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->flags = SPI_MASTER_GPIO_SS;
-	master->num_chipselect = 3;
-	master->mem_ops = &ath79_mem_ops;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
+	ctlr->flags = SPI_MASTER_GPIO_SS;
+	ctlr->num_chipselect = 3;
+	ctlr->mem_ops = &ath79_mem_ops;
 
-	sp->bitbang.master = master;
+	sp->bitbang.master = ctlr;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
 	sp->bitbang.txrx_word[SPI_MODE_0] = ath79_spi_txrx_mode0;
 	sp->bitbang.flags = SPI_CS_HIGH;
 
 	sp->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(sp->base)) {
-		ret = PTR_ERR(sp->base);
-		goto err_put_master;
-	}
+	if (IS_ERR(sp->base))
+		return PTR_ERR(sp->base);
 
 	sp->clk = devm_clk_get(&pdev->dev, "ahb");
-	if (IS_ERR(sp->clk)) {
-		ret = PTR_ERR(sp->clk);
-		goto err_put_master;
-	}
+	if (IS_ERR(sp->clk))
+		return PTR_ERR(sp->clk);
 
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
-		goto err_put_master;
+		return ret;
 
 	rate = DIV_ROUND_UP(clk_get_rate(sp->clk), MHZ);
 	if (!rate) {
@@ -231,8 +227,6 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	ath79_spi_disable(sp);
 err_clk_disable:
 	clk_disable_unprepare(sp->clk);
-err_put_master:
-	spi_master_put(sp->bitbang.master);
 
 	return ret;
 }
-- 
2.25.1

