Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBE6A9D16
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjCCRVD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjCCRU7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFDE4392E
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-0006Vt-ES; Fri, 03 Mar 2023 18:20:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001bk3-Qs; Fri, 03 Mar 2023 18:20:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-001tj6-U1; Fri, 03 Mar 2023 18:20:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 20/87] spi: dln2: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:34 +0100
Message-Id: <20230303172041.2103336-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=o4dbhtYbf6EvlKOld+Vr41XaPZ3K2kF/xDi+oYZovAs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitWIPPHrl8S2U7TND74sZA5PGMzmi+NmKz9d xjNzLxzfk6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrVgAKCRDB/BR4rcrs CY39CACIG/dVGTNTjI33OG2Gu9pTHQgghOfCfUXn/HEsYnrtk4qi2uRsZZiexZzCPB0tU9Yt5QJ vATFufYCVgNvB7woEWc41LEFLk9VZHfRb0as3dQ+ugW1f875xPkRopLX0ZUTMxx/9NvBtXMSmvn zGtmqNozPxUovk3MJrWDIX99rBf+JKHs4R77xKDhWZV1Y7aGtLL2NjZO4SlGaI5r0iuXitg9kuO qPok8AQx0R6W8AgkT+w8/gZIJ+6hXufVI79vArQ062Grlw2BAoXYrBhAkjDrJF5mF3PH0IkO+ik MwLGBUiJlyUSEe5jdDDQkw9O+t+ECgRsdXl2w4LHA4b+5X8f
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
 drivers/spi/spi-dln2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 0a1fb2bc9e54..821bfc6b0dd6 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -781,7 +781,7 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dln2_spi_remove(struct platform_device *pdev)
+static void dln2_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct dln2_spi *dln2 = spi_master_get_devdata(master);
@@ -790,8 +790,6 @@ static int dln2_spi_remove(struct platform_device *pdev)
 
 	if (dln2_spi_enable(dln2, false) < 0)
 		dev_err(&pdev->dev, "Failed to disable SPI module\n");
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -873,7 +871,7 @@ static struct platform_driver spi_dln2_driver = {
 		.pm	= &dln2_spi_pm,
 	},
 	.probe		= dln2_spi_probe,
-	.remove		= dln2_spi_remove,
+	.remove_new	= dln2_spi_remove,
 };
 module_platform_driver(spi_dln2_driver);
 
-- 
2.39.1

