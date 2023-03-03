Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2CC6A9D6E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjCCRVr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjCCRVZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02E64391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-00074D-Gc; Fri, 03 Mar 2023 18:21:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-001boF-IJ; Fri, 03 Mar 2023 18:21:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-001tmL-6W; Fri, 03 Mar 2023 18:21:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 70/87] spi: sprd-adi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:24 +0100
Message-Id: <20230303172041.2103336-71-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4ldR/AHUIY46eqUwLgqKT9Zwt81Hd4ncnUGHNSQTyec=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwaS0SXEXlVtEpvr5Uzg5fJX/GXhUc1+cyu7 GgCt+SDpPOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsGgAKCRDB/BR4rcrs CdZbB/49Hx+fXijNx15nNvTZTsOB+DSescBF4JVeCJ4RaxpsXgPW+FzctpUOW+8bGSdCfmarUqK jHG+ugSojgBjGS8CKGwGWSKIjrj1Gbi0qbqBWrO/MSPNE0KDTFZaEU+6lLrj/h/zUroYa8TZAso T/wYaMiY83p0FL4o7dvI33/pbzxNFhVKq2H/2VBPGkRPKjVKJCK4OrYnxX6BmGBwCu8DoTjHnOv Y8eVk8X6FbonWPJ+CCXS6GsqtfJFyzXaAo3bHklKhXUI1eqtmQcF/M5lMDDjHtWUCzoGfMETv7O KsLdg5ahd7w9q97XzOhWeWSbd/rod6TWW27IuBwcwdkVktKt
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
 drivers/spi/spi-sprd-adi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 1edbf44c05a7..3b158124d79f 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -608,13 +608,12 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sprd_adi_remove(struct platform_device *pdev)
+static void sprd_adi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
 	struct sprd_adi *sadi = spi_controller_get_devdata(ctlr);
 
 	unregister_restart_handler(&sadi->restart_handler);
-	return 0;
 }
 
 static struct sprd_adi_data sc9860_data = {
@@ -660,7 +659,7 @@ static struct platform_driver sprd_adi_driver = {
 		.of_match_table = sprd_adi_of_match,
 	},
 	.probe = sprd_adi_probe,
-	.remove = sprd_adi_remove,
+	.remove_new = sprd_adi_remove,
 };
 module_platform_driver(sprd_adi_driver);
 
-- 
2.39.1

