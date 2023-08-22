Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D89D7841B9
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjHVNNM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjHVNNL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:13:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B92DBE
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:13:10 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVV7b3XwRzLpDZ;
        Tue, 22 Aug 2023 21:10:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:13:06 +0800
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
Subject: [PATCH -next 17/25] spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
Date:   Tue, 22 Aug 2023 21:12:29 +0800
Message-ID: <20230822131237.1022815-18-lizetao1@huawei.com>
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
 drivers/spi/spi-microchip-core-qspi.c | 29 +++++++--------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 4f76ddf97b10..396dfc0fa278 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -518,30 +518,23 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(qspi->regs),
 				     "failed to map registers\n");
 
-	qspi->clk = devm_clk_get(&pdev->dev, NULL);
+	qspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(qspi->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(qspi->clk),
 				     "could not get clock\n");
 
-	ret = clk_prepare_enable(qspi->clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to enable clock\n");
-
 	init_completion(&qspi->data_completion);
 	mutex_init(&qspi->op_lock);
 
 	qspi->irq = platform_get_irq(pdev, 0);
-	if (qspi->irq < 0) {
-		ret = qspi->irq;
-		goto out;
-	}
+	if (qspi->irq < 0)
+		return qspi->irq;
 
 	ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
 			       IRQF_SHARED, pdev->name, qspi);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
@@ -552,18 +545,11 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->dev.of_node = np;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret,
-			      "spi_register_controller failed\n");
-		goto out;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "spi_register_controller failed\n");
 
 	return 0;
-
-out:
-	clk_disable_unprepare(qspi->clk);
-
-	return ret;
 }
 
 static void mchp_coreqspi_remove(struct platform_device *pdev)
@@ -574,7 +560,6 @@ static void mchp_coreqspi_remove(struct platform_device *pdev)
 	mchp_coreqspi_disable_ints(qspi);
 	control &= ~CONTROL_ENABLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
-	clk_disable_unprepare(qspi->clk);
 }
 
 static const struct of_device_id mchp_coreqspi_of_match[] = {
-- 
2.34.1

