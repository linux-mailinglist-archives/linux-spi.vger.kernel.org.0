Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4907841C1
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjHVNNV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjHVNNU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B85BE
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:18 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVV706V9xztSDs;
        Tue, 22 Aug 2023 21:09:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:13:15 +0800
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
Subject: [PATCH -next 25/25] spi: rockchip: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:37 +0800
Message-ID: <20230822131237.1022815-26-lizetao1@huawei.com>
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
 drivers/spi/spi-rockchip.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a37943847e81..cdbb86049d59 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -782,42 +782,30 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_put_ctlr;
 	}
 
-	rs->apb_pclk = devm_clk_get(&pdev->dev, "apb_pclk");
+	rs->apb_pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
 	if (IS_ERR(rs->apb_pclk)) {
 		dev_err(&pdev->dev, "Failed to get apb_pclk\n");
 		ret = PTR_ERR(rs->apb_pclk);
 		goto err_put_ctlr;
 	}
 
-	rs->spiclk = devm_clk_get(&pdev->dev, "spiclk");
+	rs->spiclk = devm_clk_get_enabled(&pdev->dev, "spiclk");
 	if (IS_ERR(rs->spiclk)) {
 		dev_err(&pdev->dev, "Failed to get spi_pclk\n");
 		ret = PTR_ERR(rs->spiclk);
 		goto err_put_ctlr;
 	}
 
-	ret = clk_prepare_enable(rs->apb_pclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to enable apb_pclk\n");
-		goto err_put_ctlr;
-	}
-
-	ret = clk_prepare_enable(rs->spiclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to enable spi_clk\n");
-		goto err_disable_apbclk;
-	}
-
 	spi_enable_chip(rs, false);
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_disable_spiclk;
+		goto err_put_ctlr;
 
 	ret = devm_request_threaded_irq(&pdev->dev, ret, rockchip_spi_isr, NULL,
 			IRQF_ONESHOT, dev_name(&pdev->dev), ctlr);
 	if (ret)
-		goto err_disable_spiclk;
+		goto err_put_ctlr;
 
 	rs->dev = &pdev->dev;
 	rs->freq = clk_get_rate(rs->spiclk);
@@ -843,7 +831,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (!rs->fifo_len) {
 		dev_err(&pdev->dev, "Failed to get fifo length\n");
 		ret = -EINVAL;
-		goto err_disable_spiclk;
+		goto err_put_ctlr;
 	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ROCKCHIP_AUTOSUSPEND_TIMEOUT);
@@ -937,10 +925,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		dma_release_channel(ctlr->dma_tx);
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
-err_disable_spiclk:
-	clk_disable_unprepare(rs->spiclk);
-err_disable_apbclk:
-	clk_disable_unprepare(rs->apb_pclk);
 err_put_ctlr:
 	spi_controller_put(ctlr);
 
@@ -950,13 +934,9 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 static void rockchip_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = spi_controller_get(platform_get_drvdata(pdev));
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	pm_runtime_get_sync(&pdev->dev);
 
-	clk_disable_unprepare(rs->spiclk);
-	clk_disable_unprepare(rs->apb_pclk);
-
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.34.1

