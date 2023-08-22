Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152347841B7
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjHVNNK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjHVNNJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9614BE
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:07 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVV7Y2RhDzLpDk;
        Tue, 22 Aug 2023 21:10:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:13:04 +0800
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
Subject: [PATCH -next 15/25] spi: meson-spicc: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:27 +0800
Message-ID: <20230822131237.1022815-16-lizetao1@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/spi/spi-meson-spicc.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 43d134f4b42b..1f2d26254e03 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -820,7 +820,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		goto out_master;
 	}
 
-	spicc->core = devm_clk_get(&pdev->dev, "core");
+	spicc->core = devm_clk_get_enabled(&pdev->dev, "core");
 	if (IS_ERR(spicc->core)) {
 		dev_err(&pdev->dev, "core clock request failed\n");
 		ret = PTR_ERR(spicc->core);
@@ -828,7 +828,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	}
 
 	if (spicc->data->has_pclk) {
-		spicc->pclk = devm_clk_get(&pdev->dev, "pclk");
+		spicc->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 		if (IS_ERR(spicc->pclk)) {
 			dev_err(&pdev->dev, "pclk clock request failed\n");
 			ret = PTR_ERR(spicc->pclk);
@@ -836,22 +836,10 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = clk_prepare_enable(spicc->core);
-	if (ret) {
-		dev_err(&pdev->dev, "core clock enable failed\n");
-		goto out_master;
-	}
-
-	ret = clk_prepare_enable(spicc->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "pclk clock enable failed\n");
-		goto out_core_clk;
-	}
-
 	spicc->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (IS_ERR(spicc->pinctrl)) {
 		ret = PTR_ERR(spicc->pinctrl);
-		goto out_clk;
+		goto out_master;
 	}
 
 	device_reset_optional(&pdev->dev);
@@ -878,31 +866,25 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	ret = meson_spicc_pow2_clk_init(spicc);
 	if (ret) {
 		dev_err(&pdev->dev, "pow2 clock registration failed\n");
-		goto out_clk;
+		goto out_master;
 	}
 
 	if (spicc->data->has_enhance_clk_div) {
 		ret = meson_spicc_enh_clk_init(spicc);
 		if (ret) {
 			dev_err(&pdev->dev, "clock registration failed\n");
-			goto out_clk;
+			goto out_master;
 		}
 	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed\n");
-		goto out_clk;
+		goto out_master;
 	}
 
 	return 0;
 
-out_clk:
-	clk_disable_unprepare(spicc->pclk);
-
-out_core_clk:
-	clk_disable_unprepare(spicc->core);
-
 out_master:
 	spi_master_put(master);
 
@@ -916,9 +898,6 @@ static void meson_spicc_remove(struct platform_device *pdev)
 	/* Disable SPI */
 	writel(0, spicc->base + SPICC_CONREG);
 
-	clk_disable_unprepare(spicc->core);
-	clk_disable_unprepare(spicc->pclk);
-
 	spi_master_put(spicc->master);
 }
 
-- 
2.34.1

