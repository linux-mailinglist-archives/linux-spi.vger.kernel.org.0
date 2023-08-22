Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B07841B4
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbjHVNNH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjHVNNG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF51BE
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:04 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVV8R3ZmjzTmN3;
        Tue, 22 Aug 2023 21:10:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:13:01 +0800
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
Subject: [PATCH -next 12/25] spi: dw-mmio: Use helper function devm_clk_get_*()
Date:   Tue, 22 Aug 2023 21:12:24 +0800
Message-ID: <20230822131237.1022815-13-lizetao1@huawei.com>
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
no longer necessary to unprepare and disable the clocks explicitly. Also,
devm_clk_get_optional() and clk_prepare_enable() can now be replaced by
devm_clk_get_optional_enabled(). Moreover, the lable "out_clk" no longer
makes sense, rename it to "out_reset".

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/spi/spi-dw-mmio.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 805264c9c65c..6d9f64ecbfd6 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -340,28 +340,22 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (dws->irq < 0)
 		return dws->irq; /* -ENXIO */
 
-	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
+	dwsmmio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dwsmmio->clk))
 		return PTR_ERR(dwsmmio->clk);
-	ret = clk_prepare_enable(dwsmmio->clk);
-	if (ret)
-		return ret;
 
 	/* Optional clock needed to access the registers */
-	dwsmmio->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
+	dwsmmio->pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(dwsmmio->pclk)) {
 		ret = PTR_ERR(dwsmmio->pclk);
-		goto out_clk;
+		goto out_reset;
 	}
-	ret = clk_prepare_enable(dwsmmio->pclk);
-	if (ret)
-		goto out_clk;
 
 	/* find an optional reset controller */
 	dwsmmio->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(dwsmmio->rstc)) {
 		ret = PTR_ERR(dwsmmio->rstc);
-		goto out_clk;
+		goto out_reset;
 	}
 	reset_control_deassert(dwsmmio->rstc);
 
@@ -397,9 +391,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 out:
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(dwsmmio->pclk);
-out_clk:
-	clk_disable_unprepare(dwsmmio->clk);
+out_reset:
 	reset_control_assert(dwsmmio->rstc);
 
 	return ret;
@@ -411,8 +403,6 @@ static void dw_spi_mmio_remove(struct platform_device *pdev)
 
 	dw_spi_remove_host(&dwsmmio->dws);
 	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(dwsmmio->pclk);
-	clk_disable_unprepare(dwsmmio->clk);
 	reset_control_assert(dwsmmio->rstc);
 }
 
-- 
2.34.1

