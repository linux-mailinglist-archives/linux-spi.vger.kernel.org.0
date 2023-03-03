Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851AE6A9D7B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjCCRWR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCCRVo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111F4D62F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-0006zL-5A; Fri, 03 Mar 2023 18:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-001bnH-TU; Fri, 03 Mar 2023 18:21:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001tlN-Vr; Fri, 03 Mar 2023 18:21:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 55/87] spi: pxa2xx: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:09 +0100
Message-Id: <20230303172041.2103336-56-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cfAQbVsukiD70ufHL0JB6MzHRyk5ItfVack94AX7bTk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivg4TDFtLosRPByFAO/KazfGn0zLVxPpaHB7 bg36KK9VoyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr4AAKCRDB/BR4rcrs CeXsB/0VxEWZ9Pr2d+qnSUKYlUR5LKANES5SkJGd0NKt2Ebag7Gcdgk7wq2oHUXTPtMcwaBhdnq +3vNVkslPZnW1qCFCxlJNfkhkWjp5mIGykcFP6zx+V9cJ2/sIbm9oYOEfAnXptzqb5vCvy0m+4V R4ZeK0zqNPYHTX3OtHzZspjNQKbLci1dgo0nP2SLqSp2WnSUnAHz9R7/hEdrg45KJbFKjkEwAMV 7YI5zacCo5vmPZz5vGpDhe+wI2mFzyv8NF+1+BXJEXgml8dshC57HOjg4nQd2gww4VRWAwAwmcV eEyLgYICHIjgUkBupg4jjzfyy6+yrwFbkna7yY/KHymZqz55
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
 drivers/spi/spi-pxa2xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 32cc82a89ec1..a75ba2993f3c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1659,7 +1659,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	return status;
 }
 
-static int pxa2xx_spi_remove(struct platform_device *pdev)
+static void pxa2xx_spi_remove(struct platform_device *pdev)
 {
 	struct driver_data *drv_data = platform_get_drvdata(pdev);
 	struct ssp_device *ssp = drv_data->ssp;
@@ -1684,8 +1684,6 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 
 	/* Release SSP */
 	pxa_ssp_free(ssp);
-
-	return 0;
 }
 
 static int pxa2xx_spi_suspend(struct device *dev)
@@ -1770,7 +1768,7 @@ static struct platform_driver driver = {
 		.of_match_table = of_match_ptr(pxa2xx_spi_of_match),
 	},
 	.probe = pxa2xx_spi_probe,
-	.remove = pxa2xx_spi_remove,
+	.remove_new = pxa2xx_spi_remove,
 };
 
 static int __init pxa2xx_spi_init(void)
-- 
2.39.1

