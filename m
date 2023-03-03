Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A756A9D64
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjCCRVl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjCCRVT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC7E4DE31
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-00070f-P8; Fri, 03 Mar 2023 18:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-001bnZ-IR; Fri, 03 Mar 2023 18:21:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-001tlo-Fg; Fri, 03 Mar 2023 18:21:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 62/87] spi: s3c64xx: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:16 +0100
Message-Id: <20230303172041.2103336-63-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tucUXDHezSL3KgDgyX7M+EMeQDm52S5dcccBPtuX9G8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiv8G7s4yrvtMZ2jtX0+0GrsGDwhg5kg2JsD7 EanMm1iNlyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr/AAKCRDB/BR4rcrs CVFXB/9AS05Yfcdqg1mk7NDEhTtmbC1DI7frMVT1vbQHnhFluWOC1/G8GPjPWARX8kz+fC0Dypg Hfg/cBSuI7DZhPEGlkV/hozukhGKYpOZ1eBvkF7bM4uIK8sKMDjKHa02lQlcocWST9GesotY3xC mTsdonIZfnAh8aCZpnjh3lQ0Pj6nxzq1SHFR9J13S/rSbgpJzsvcYwT8VUOlltHHqvMoZa13zBY GGRU7pnEyTEXq/S0DAplMNUcu9HNfTbE/ex00TN8LQJv4+TOEcZK4la9wK6ofsCsXLV992fTSBQ rVpgonO2PlOZ7QyBXi1nydljWwywq3jsPepnbnB1rtMP8pYy
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-s3c64xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 71d324ec9a70..cc69f8ffdbdc 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1286,7 +1286,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int s3c64xx_spi_remove(struct platform_device *pdev)
+static void s3c64xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
@@ -1309,8 +1309,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1531,7 +1529,7 @@ static struct platform_driver s3c64xx_spi_driver = {
 		.of_match_table = of_match_ptr(s3c64xx_spi_dt_match),
 	},
 	.probe = s3c64xx_spi_probe,
-	.remove = s3c64xx_spi_remove,
+	.remove_new = s3c64xx_spi_remove,
 	.id_table = s3c64xx_spi_driver_ids,
 };
 MODULE_ALIAS("platform:s3c64xx-spi");
-- 
2.39.1

