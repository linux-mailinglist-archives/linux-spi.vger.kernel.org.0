Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148DF785983
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbjHWNkC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjHWNkB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 09:40:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B1E66
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 06:39:57 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RW6jq3yGBzrSbq;
        Wed, 23 Aug 2023 21:38:23 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 21:39:52 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <lizetao1@huawei.com>
CC:     <andrew@aj.id.au>, <angelogioacchino.delregno@collabora.com>,
        <avifishman70@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <chin-ting_kuo@aspeedtech.com>, <clg@kaod.org>,
        <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <fancer.lancer@gmail.com>, <florian.fainelli@broadcom.com>,
        <heiko@sntech.de>, <jbrunet@baylibre.com>, <joel@jms.id.au>,
        <khilman@baylibre.com>, <linus.walleij@linaro.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <martin.blumenstingl@googlemail.com>,
        <matthias.bgg@gmail.com>, <neil.armstrong@linaro.org>,
        <olteanv@gmail.com>, <openbmc@lists.ozlabs.org>,
        <rjui@broadcom.com>, <sbranden@broadcom.com>,
        <tali.perry1@gmail.com>, <tmaimon77@gmail.com>,
        <venture@google.com>, <yuenn@google.com>
Subject: [PATCH -next v2 02/25] spi: armada-3700: Use helper function devm_clk_get_prepared()
Date:   Wed, 23 Aug 2023 21:39:15 +0800
Message-ID: <20230823133938.1359106-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823133938.1359106-1-lizetao1@huawei.com>
References: <20230822131237.1022815-1-lizetao1@huawei.com>
 <20230823133938.1359106-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
v1 -> v2: Drop the empty remove function a3700_spi_remove().

 drivers/spi/spi-armada-3700.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 0103ac0158c0..3c9ed412932f 100644
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
@@ -888,40 +882,29 @@ static int a3700_spi_probe(struct platform_device *pdev)
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
 	return ret;
 }
 
-static void a3700_spi_remove(struct platform_device *pdev)
-{
-	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct a3700_spi *spi = spi_controller_get_devdata(host);
-
-	clk_unprepare(spi->clk);
-}
-
 static struct platform_driver a3700_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.of_match_table = of_match_ptr(a3700_spi_dt_ids),
 	},
 	.probe		= a3700_spi_probe,
-	.remove_new	= a3700_spi_remove,
 };
 
 module_platform_driver(a3700_spi_driver);
-- 
2.34.1

