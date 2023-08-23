Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D0785992
	for <lists+linux-spi@lfdr.de>; Wed, 23 Aug 2023 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjHWNkO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Aug 2023 09:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjHWNkN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Aug 2023 09:40:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89EC184
        for <linux-spi@vger.kernel.org>; Wed, 23 Aug 2023 06:40:11 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RW6gX3YYgztS8b;
        Wed, 23 Aug 2023 21:36:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 21:40:07 +0800
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
        <venture@google.com>, <yuenn@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH -next v2 16/25] spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
Date:   Wed, 23 Aug 2023 21:39:29 +0800
Message-ID: <20230823133938.1359106-17-lizetao1@huawei.com>
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
and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
replaced by devm_clk_get_enabled() when driver enables (and possibly
prepares) the clocks for the whole lifetime of the device. Moreover, it is
no longer necessary to unprepare and disable the clocks explicitly.
Moreover, the lable "out_clk" no longer makes sense, rename it to "out_pm".

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: None

 drivers/spi/spi-meson-spifc.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 06626f406f68..d70a18885b49 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -312,19 +312,13 @@ static int meson_spifc_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
-	spifc->clk = devm_clk_get(spifc->dev, NULL);
+	spifc->clk = devm_clk_get_enabled(spifc->dev, NULL);
 	if (IS_ERR(spifc->clk)) {
 		dev_err(spifc->dev, "missing clock\n");
 		ret = PTR_ERR(spifc->clk);
 		goto out_err;
 	}
 
-	ret = clk_prepare_enable(spifc->clk);
-	if (ret) {
-		dev_err(spifc->dev, "can't prepare clock\n");
-		goto out_err;
-	}
-
 	rate = clk_get_rate(spifc->clk);
 
 	master->num_chipselect = 1;
@@ -343,12 +337,11 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(spifc->dev, master);
 	if (ret) {
 		dev_err(spifc->dev, "failed to register spi master\n");
-		goto out_clk;
+		goto out_pm;
 	}
 
 	return 0;
-out_clk:
-	clk_disable_unprepare(spifc->clk);
+out_pm:
 	pm_runtime_disable(spifc->dev);
 out_err:
 	spi_master_put(master);
@@ -357,11 +350,7 @@ static int meson_spifc_probe(struct platform_device *pdev)
 
 static void meson_spifc_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct meson_spifc *spifc = spi_master_get_devdata(master);
-
 	pm_runtime_get_sync(&pdev->dev);
-	clk_disable_unprepare(spifc->clk);
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.34.1

