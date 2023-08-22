Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07027841BE
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbjHVNNS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjHVNNR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D690CC6
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:15 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVV765Z8SzNnNM;
        Tue, 22 Aug 2023 21:09:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:13:11 +0800
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
Subject: [PATCH -next 22/25] spi: pic32-sqi: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:34 +0800
Message-ID: <20230822131237.1022815-23-lizetao1@huawei.com>
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

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/spi/spi-pic32-sqi.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 5cbebcf26a2a..d894b99e4104 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -593,33 +593,20 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	}
 
 	/* clocks */
-	sqi->sys_clk = devm_clk_get(&pdev->dev, "reg_ck");
+	sqi->sys_clk = devm_clk_get_enabled(&pdev->dev, "reg_ck");
 	if (IS_ERR(sqi->sys_clk)) {
 		ret = PTR_ERR(sqi->sys_clk);
 		dev_err(&pdev->dev, "no sys_clk ?\n");
 		goto err_free_master;
 	}
 
-	sqi->base_clk = devm_clk_get(&pdev->dev, "spi_ck");
+	sqi->base_clk = devm_clk_get_enabled(&pdev->dev, "spi_ck");
 	if (IS_ERR(sqi->base_clk)) {
 		ret = PTR_ERR(sqi->base_clk);
 		dev_err(&pdev->dev, "no base clk ?\n");
 		goto err_free_master;
 	}
 
-	ret = clk_prepare_enable(sqi->sys_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "sys clk enable failed\n");
-		goto err_free_master;
-	}
-
-	ret = clk_prepare_enable(sqi->base_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "base clk enable failed\n");
-		clk_disable_unprepare(sqi->sys_clk);
-		goto err_free_master;
-	}
-
 	init_completion(&sqi->xfer_done);
 
 	/* initialize hardware */
@@ -629,7 +616,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	ret = ring_desc_ring_alloc(sqi);
 	if (ret) {
 		dev_err(&pdev->dev, "ring alloc failed\n");
-		goto err_disable_clk;
+		goto err_free_master;
 	}
 
 	/* install irq handlers */
@@ -669,10 +656,6 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 err_free_ring:
 	ring_desc_ring_free(sqi);
 
-err_disable_clk:
-	clk_disable_unprepare(sqi->base_clk);
-	clk_disable_unprepare(sqi->sys_clk);
-
 err_free_master:
 	spi_master_put(master);
 	return ret;
@@ -685,10 +668,6 @@ static void pic32_sqi_remove(struct platform_device *pdev)
 	/* release resources */
 	free_irq(sqi->irq, sqi);
 	ring_desc_ring_free(sqi);
-
-	/* disable clk */
-	clk_disable_unprepare(sqi->base_clk);
-	clk_disable_unprepare(sqi->sys_clk);
 }
 
 static const struct of_device_id pic32_sqi_of_ids[] = {
-- 
2.34.1

