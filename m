Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603D37841B5
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbjHVNNI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjHVNNI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FC6BE
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:06 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVV6l6x4PztS7V;
        Tue, 22 Aug 2023 21:09:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:13:02 +0800
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
Subject: [PATCH -next 13/25] spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:25 +0800
Message-ID: <20230822131237.1022815-14-lizetao1@huawei.com>
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
 drivers/spi/spi-fsl-dspi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8318249f8a1f..c9eae046f66c 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1372,19 +1372,16 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
-	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
+	dspi->clk = devm_clk_get_enabled(&pdev->dev, "dspi");
 	if (IS_ERR(dspi->clk)) {
 		ret = PTR_ERR(dspi->clk);
 		dev_err(&pdev->dev, "unable to get clock\n");
 		goto out_ctlr_put;
 	}
-	ret = clk_prepare_enable(dspi->clk);
-	if (ret)
-		goto out_ctlr_put;
 
 	ret = dspi_init(dspi);
 	if (ret)
-		goto out_clk_put;
+		goto out_ctlr_put;
 
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
@@ -1400,7 +1397,7 @@ static int dspi_probe(struct platform_device *pdev)
 				   IRQF_SHARED, pdev->name, dspi);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to attach DSPI interrupt\n");
-		goto out_clk_put;
+		goto out_ctlr_put;
 	}
 
 poll_mode:
@@ -1432,8 +1429,6 @@ static int dspi_probe(struct platform_device *pdev)
 out_free_irq:
 	if (dspi->irq)
 		free_irq(dspi->irq, dspi);
-out_clk_put:
-	clk_disable_unprepare(dspi->clk);
 out_ctlr_put:
 	spi_controller_put(ctlr);
 
@@ -1458,7 +1453,6 @@ static void dspi_remove(struct platform_device *pdev)
 	dspi_release_dma(dspi);
 	if (dspi->irq)
 		free_irq(dspi->irq, dspi);
-	clk_disable_unprepare(dspi->clk);
 }
 
 static void dspi_shutdown(struct platform_device *pdev)
-- 
2.34.1

