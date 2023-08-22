Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA90C7841BB
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbjHVNNP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjHVNNO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D48BE
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:12 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVV9S5WmHzrSmC;
        Tue, 22 Aug 2023 21:11:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:13:08 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <broonie@kernel.org>, <chin-ting_kuo@aspeedtech.com>,
        <clg@kaod.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <florian.fainelli@broadcom.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <fancer.lancer@gmail.com>, <olteanv@gmail.com>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <avifishman70@gmail.com>, <tmaimon77@gmail.com>,
        <tali.perry1@gmail.com>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <linus.walleij@linaro.org>,
        <heiko@sntech.de>
CC:     <lizetao1@huawei.com>, <linux-spi@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: [PATCH -next 19/25] spi: mtk-snfi: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:31 +0800
Message-ID: <20230822131237.1022815-20-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822131237.1022815-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
replaced by devm_clk_get_enabled() when driver enables (and possibly
prepares) the clocks for the whole lifetime of the device. Moreover, it is
no longer necessary to unprepare and disable the clocks explicitly.
Also, devm_clk_get_optional() and clk_prepare_enable() can now be
replaced by devm_clk_get_optional_enabled().Moreover, the two functions
mtk_snand_enable_clk() and mtk_snand_disable_clk() no longer are used,
drop them for clean code.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/spi/spi-mtk-snfi.c | 61 ++++++--------------------------------
 1 file changed, 9 insertions(+), 52 deletions(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 4433a8a9299f..8ad5a4764855 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1332,42 +1332,6 @@ static const struct of_device_id mtk_snand_ids[] = {
 
 MODULE_DEVICE_TABLE(of, mtk_snand_ids);
 
-static int mtk_snand_enable_clk(struct mtk_snand *ms)
-{
-	int ret;
-
-	ret = clk_prepare_enable(ms->nfi_clk);
-	if (ret) {
-		dev_err(ms->dev, "unable to enable nfi clk\n");
-		return ret;
-	}
-	ret = clk_prepare_enable(ms->pad_clk);
-	if (ret) {
-		dev_err(ms->dev, "unable to enable pad clk\n");
-		goto err1;
-	}
-	ret = clk_prepare_enable(ms->nfi_hclk);
-	if (ret) {
-		dev_err(ms->dev, "unable to enable nfi hclk\n");
-		goto err2;
-	}
-
-	return 0;
-
-err2:
-	clk_disable_unprepare(ms->pad_clk);
-err1:
-	clk_disable_unprepare(ms->nfi_clk);
-	return ret;
-}
-
-static void mtk_snand_disable_clk(struct mtk_snand *ms)
-{
-	clk_disable_unprepare(ms->nfi_hclk);
-	clk_disable_unprepare(ms->pad_clk);
-	clk_disable_unprepare(ms->nfi_clk);
-}
-
 static int mtk_snand_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1406,49 +1370,45 @@ static int mtk_snand_probe(struct platform_device *pdev)
 
 	ms->dev = &pdev->dev;
 
-	ms->nfi_clk = devm_clk_get(&pdev->dev, "nfi_clk");
+	ms->nfi_clk = devm_clk_get_enabled(&pdev->dev, "nfi_clk");
 	if (IS_ERR(ms->nfi_clk)) {
 		ret = PTR_ERR(ms->nfi_clk);
 		dev_err(&pdev->dev, "unable to get nfi_clk, err = %d\n", ret);
 		goto release_ecc;
 	}
 
-	ms->pad_clk = devm_clk_get(&pdev->dev, "pad_clk");
+	ms->pad_clk = devm_clk_get_enabled(&pdev->dev, "pad_clk");
 	if (IS_ERR(ms->pad_clk)) {
 		ret = PTR_ERR(ms->pad_clk);
 		dev_err(&pdev->dev, "unable to get pad_clk, err = %d\n", ret);
 		goto release_ecc;
 	}
 
-	ms->nfi_hclk = devm_clk_get_optional(&pdev->dev, "nfi_hclk");
+	ms->nfi_hclk = devm_clk_get_optional_enabled(&pdev->dev, "nfi_hclk");
 	if (IS_ERR(ms->nfi_hclk)) {
 		ret = PTR_ERR(ms->nfi_hclk);
 		dev_err(&pdev->dev, "unable to get nfi_hclk, err = %d\n", ret);
 		goto release_ecc;
 	}
 
-	ret = mtk_snand_enable_clk(ms);
-	if (ret)
-		goto release_ecc;
-
 	init_completion(&ms->op_done);
 
 	ms->irq = platform_get_irq(pdev, 0);
 	if (ms->irq < 0) {
 		ret = ms->irq;
-		goto disable_clk;
+		goto release_ecc;
 	}
 	ret = devm_request_irq(ms->dev, ms->irq, mtk_snand_irq, 0x0,
 			       "mtk-snand", ms);
 	if (ret) {
 		dev_err(ms->dev, "failed to request snfi irq\n");
-		goto disable_clk;
+		goto release_ecc;
 	}
 
 	ret = dma_set_mask(ms->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(ms->dev, "failed to set dma mask\n");
-		goto disable_clk;
+		goto release_ecc;
 	}
 
 	// switch to SNFI mode
@@ -1472,7 +1432,7 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	ret = mtk_snand_setup_pagefmt(ms, SZ_2K, SZ_64);
 	if (ret) {
 		dev_err(ms->dev, "failed to set initial page format\n");
-		goto disable_clk;
+		goto release_ecc;
 	}
 
 	// setup ECC engine
@@ -1484,7 +1444,7 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	ret = nand_ecc_register_on_host_hw_engine(&ms->ecc_eng);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ecc engine.\n");
-		goto disable_clk;
+		goto release_ecc;
 	}
 
 	ctlr->num_chipselect = 1;
@@ -1496,12 +1456,10 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed.\n");
-		goto disable_clk;
+		goto release_ecc;
 	}
 
 	return 0;
-disable_clk:
-	mtk_snand_disable_clk(ms);
 release_ecc:
 	mtk_ecc_release(ms->ecc);
 	return ret;
@@ -1513,7 +1471,6 @@ static void mtk_snand_remove(struct platform_device *pdev)
 	struct mtk_snand *ms = spi_controller_get_devdata(ctlr);
 
 	spi_unregister_controller(ctlr);
-	mtk_snand_disable_clk(ms);
 	mtk_ecc_release(ms->ecc);
 	kfree(ms->buf);
 }
-- 
2.34.1

