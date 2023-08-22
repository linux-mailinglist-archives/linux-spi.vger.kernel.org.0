Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8397841AA
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjHVNM5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjHVNM4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 09:12:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C278CC6
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 06:12:54 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVV6j1lnzzNnMw;
        Tue, 22 Aug 2023 21:09:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 21:12:50 +0800
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
Subject: [PATCH -next 02/25] spi: armada-3700: Use helper function devm_clk_get_prepared()
Date:   Tue, 22 Aug 2023 21:12:14 +0800
Message-ID: <20230822131237.1022815-3-lizetao1@huawei.com>
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
and enabled clocks"), devm_clk_get() and clk_prepare() can now be replaced
by devm_clk_get_prepared() when driver prepares the clocks for the whole
lifetime of the device. Moreover, it is no longer necessary to unprepare
the clocks explicitly.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/spi/spi-armada-3700.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 0103ac0158c0..70113b9dab35 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -865,18 +865,12 @@ static int a3700_spi_probe(struct platform_device *pdev)
 
 	init_completion(&spi->done);
 
-	spi->clk = devm_clk_get(dev, NULL);
+	spi->clk = devm_clk_get_prepared(dev, NULL);
 	if (IS_ERR(spi->clk)) {
 		dev_err(dev, "could not find clk: %ld\n", PTR_ERR(spi->clk));
 		goto error;
 	}
 
-	ret = clk_prepare(spi->clk);
-	if (ret) {
-		dev_err(dev, "could not prepare clk: %d\n", ret);
-		goto error;
-	}
-
 	host->max_speed_hz = min_t(unsigned long, A3700_SPI_MAX_SPEED_HZ,
 					clk_get_rate(spi->clk));
 	host->min_speed_hz = DIV_ROUND_UP(clk_get_rate(spi->clk),
@@ -888,19 +882,17 @@ static int a3700_spi_probe(struct platform_device *pdev)
 			       dev_name(dev), host);
 	if (ret) {
 		dev_err(dev, "could not request IRQ: %d\n", ret);
-		goto error_clk;
+		goto error;
 	}
 
 	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		dev_err(dev, "Failed to register host\n");
-		goto error_clk;
+		goto error;
 	}
 
 	return 0;
 
-error_clk:
-	clk_unprepare(spi->clk);
 error:
 	spi_controller_put(host);
 out:
@@ -909,10 +901,6 @@ static int a3700_spi_probe(struct platform_device *pdev)
 
 static void a3700_spi_remove(struct platform_device *pdev)
 {
-	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct a3700_spi *spi = spi_controller_get_devdata(host);
-
-	clk_unprepare(spi->clk);
 }
 
 static struct platform_driver a3700_spi_driver = {
-- 
2.34.1

