Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9E7841AC
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjHVNM7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjHVNM7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:12:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463BABE
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:12:55 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVV9821pFz1L9G9;
        Tue, 22 Aug 2023 21:11:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:12:51 +0800
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
Subject: [PATCH -next 03/25] spi: aspeed: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:15 +0800
Message-ID: <20230822131237.1022815-4-lizetao1@huawei.com>
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
 drivers/spi/spi-aspeed-smc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 21b0fa646c7d..bbd417c55e7f 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -748,7 +748,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	aspi->ahb_window_size = resource_size(res);
 	aspi->ahb_base_phy = res->start;
 
-	aspi->clk = devm_clk_get(&pdev->dev, NULL);
+	aspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(aspi->clk)) {
 		dev_err(dev, "missing clock\n");
 		return PTR_ERR(aspi->clk);
@@ -760,12 +760,6 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = clk_prepare_enable(aspi->clk);
-	if (ret) {
-		dev_err(dev, "can not enable the clock\n");
-		return ret;
-	}
-
 	/* IRQ is for DMA, which the driver doesn't support yet */
 
 	ctlr->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL | data->mode_bits;
@@ -777,14 +771,9 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = dev->of_node;
 
 	ret = devm_spi_register_controller(dev, ctlr);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		goto disable_clk;
-	}
-	return 0;
 
-disable_clk:
-	clk_disable_unprepare(aspi->clk);
 	return ret;
 }
 
@@ -793,7 +782,6 @@ static void aspeed_spi_remove(struct platform_device *pdev)
 	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
 
 	aspeed_spi_enable(aspi, false);
-	clk_disable_unprepare(aspi->clk);
 }
 
 /*
-- 
2.34.1

