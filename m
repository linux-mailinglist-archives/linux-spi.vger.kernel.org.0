Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22527841BC
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbjHVNNQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjHVNNP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB86CC6
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:13 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVV9T65q9zrSW6;
        Tue, 22 Aug 2023 21:11:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:13:09 +0800
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
Subject: [PATCH -next 20/25] spi: npcm-fiu: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:32 +0800
Message-ID: <20230822131237.1022815-21-lizetao1@huawei.com>
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
 drivers/spi/spi-npcm-fiu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 0ca21ff0e9cc..1a5277ff349f 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -699,7 +699,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	struct spi_controller *ctrl;
 	struct npcm_fiu_spi *fiu;
 	void __iomem *regbase;
-	int id, ret;
+	int id;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*fiu));
 	if (!ctrl)
@@ -737,7 +737,7 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 
 	fiu->res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						    "memory");
-	fiu->clk = devm_clk_get(dev, NULL);
+	fiu->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(fiu->clk))
 		return PTR_ERR(fiu->clk);
 
@@ -745,7 +745,6 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 					       "nuvoton,spix-mode");
 
 	platform_set_drvdata(pdev, fiu);
-	clk_prepare_enable(fiu->clk);
 
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD
 		| SPI_TX_DUAL | SPI_TX_QUAD;
@@ -755,18 +754,11 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	ctrl->num_chipselect = fiu->info->max_cs;
 	ctrl->dev.of_node = dev->of_node;
 
-	ret = devm_spi_register_controller(dev, ctrl);
-	if (ret)
-		clk_disable_unprepare(fiu->clk);
-
-	return ret;
+	return devm_spi_register_controller(dev, ctrl);
 }
 
 static void npcm_fiu_remove(struct platform_device *pdev)
 {
-	struct npcm_fiu_spi *fiu = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(fiu->clk);
 }
 
 MODULE_DEVICE_TABLE(of, npcm_fiu_dt_ids);
-- 
2.34.1

