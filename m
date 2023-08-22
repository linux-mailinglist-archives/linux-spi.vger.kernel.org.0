Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F27841B3
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjHVNNF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjHVNNF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A735CCD4
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:03 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVV9J6DNpz1L9Qn;
        Tue, 22 Aug 2023 21:11:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:12:59 +0800
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
Subject: [PATCH -next 11/25] spi: dw-bt1: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:23 +0800
Message-ID: <20230822131237.1022815-12-lizetao1@huawei.com>
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
 drivers/spi/spi-dw-bt1.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index 5e1c01822967..5391bcac305c 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -269,43 +269,32 @@ static int dw_spi_bt1_probe(struct platform_device *pdev)
 
 	dws->paddr = mem->start;
 
-	dwsbt1->clk = devm_clk_get(&pdev->dev, NULL);
+	dwsbt1->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dwsbt1->clk))
 		return PTR_ERR(dwsbt1->clk);
 
-	ret = clk_prepare_enable(dwsbt1->clk);
-	if (ret)
-		return ret;
-
 	dws->bus_num = pdev->id;
 	dws->reg_io_width = 4;
 	dws->max_freq = clk_get_rate(dwsbt1->clk);
-	if (!dws->max_freq) {
-		ret = -EINVAL;
-		goto err_disable_clk;
-	}
+	if (!dws->max_freq)
+		return -EINVAL;
 
 	init_func = device_get_match_data(&pdev->dev);
 	ret = init_func(pdev, dwsbt1);
 	if (ret)
-		goto err_disable_clk;
+		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 
 	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret) {
 		pm_runtime_disable(&pdev->dev);
-		goto err_disable_clk;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, dwsbt1);
 
 	return 0;
-
-err_disable_clk:
-	clk_disable_unprepare(dwsbt1->clk);
-
-	return ret;
 }
 
 static void dw_spi_bt1_remove(struct platform_device *pdev)
@@ -315,8 +304,6 @@ static void dw_spi_bt1_remove(struct platform_device *pdev)
 	dw_spi_remove_host(&dwsbt1->dws);
 
 	pm_runtime_disable(&pdev->dev);
-
-	clk_disable_unprepare(dwsbt1->clk);
 }
 
 static const struct of_device_id dw_spi_bt1_of_match[] = {
-- 
2.34.1

