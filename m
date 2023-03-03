Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA956A9D38
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjCCRVS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjCCRVJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3234C6C3
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-0006s9-Cm; Fri, 03 Mar 2023 18:21:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-001bme-6k; Fri, 03 Mar 2023 18:21:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001tl8-7U; Fri, 03 Mar 2023 18:21:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 51/87] spi: orion: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:05 +0100
Message-Id: <20230303172041.2103336-52-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zy3UPni8T2BVS1LUElt8lUytcrWtvbpeM8NJ9+w2M7c=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivQjExPpFgkJAxam3gGMgeo0t0es/IXswZZ5 Y6nWQRJSHeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr0AAKCRDB/BR4rcrs CVtRCACTbc6t1f7/y8DayP7hdP2SqXStSvDTZJwwP/NEuLJmtORs95p+6O8lrZG6pxezMxbCUiX wZZoiNU7L+qPlrFDeKCI4ni1+hm0Pev94KUpdXX3Ooup2cLV7HJUkMOHbsQECEWuBSIn3nzSPlT 1t4s/Q1nelMZLX1Bax0bMWri3YSwAOv61ON1IiUmvCoEuHRmeZNuhNRdEIf7rYnwpgPybFwQPSq 9T5Z2p/MSi9qxu/lkO56k/xZi2wjdr9yRHh3ewP7gYBNLitPlJn6Ea20JivjVJpD84e37ovejTh FUDk564VSXAgami6msY7Gx++6T49ddO+JreHBHbl/VDQrcAu
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
 drivers/spi/spi-orion.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 565cd4c48d7b..e79d1fe0bca4 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -805,7 +805,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 }
 
 
-static int orion_spi_remove(struct platform_device *pdev)
+static void orion_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct orion_spi *spi = spi_master_get_devdata(master);
@@ -816,8 +816,6 @@ static int orion_spi_remove(struct platform_device *pdev)
 
 	spi_unregister_master(master);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
@@ -857,7 +855,7 @@ static struct platform_driver orion_spi_driver = {
 		.of_match_table = of_match_ptr(orion_spi_of_match_table),
 	},
 	.probe		= orion_spi_probe,
-	.remove		= orion_spi_remove,
+	.remove_new	= orion_spi_remove,
 };
 
 module_platform_driver(orion_spi_driver);
-- 
2.39.1

