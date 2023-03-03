Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666E66A9D54
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjCCRVb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCCRVN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801EB4FA94
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-00074K-IL; Fri, 03 Mar 2023 18:21:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-001boH-KG; Fri, 03 Mar 2023 18:21:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-001tmH-W9; Fri, 03 Mar 2023 18:21:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 69/87] spi: sn-f-ospi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:23 +0100
Message-Id: <20230303172041.2103336-70-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2OAOspEyMBAN3IQdbiwsNq3UAfMsGFyCHXl9F2Hg1b8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwXM7GHQ2667qY6doOAE3pj7/KrH9+aTph/g WrmdlB6/QaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsFwAKCRDB/BR4rcrs CRijB/9YamlSQwgeFnWW8qEYBp2Vahgi8KQZuHsRDeB7+pmBiGmcgIqzsumCEJWchjI92YQQj/I JBC+H5CSfz34UiAEyUMsZXh9Dn2vSgL86m6ucPgZwCm4AvksXAWY5/4XufejumfS18E7ky0qR3E hI2aVSfKaeXqujbVw7ngVLED7/yQc+SODdHgHrogACJ6++Xm2qXKycrcTRKykhfUejkMkXi9Zi9 3W8jEIzps+lo6zzz8AXzz33kIbHlJ9a7cgLbAzV3Yhl9DBo6uLejMhAGucZjPeXPQYbcyBkum3D 0w3H9ageE0tsFdfXl/40N+p8fHbZ3KuzeTA7XNom+Dhdg02f
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
 drivers/spi/spi-sn-f-ospi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 333b22dfd8db..644ae34f623b 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -670,15 +670,13 @@ static int f_ospi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int f_ospi_remove(struct platform_device *pdev)
+static void f_ospi_remove(struct platform_device *pdev)
 {
 	struct f_ospi *ospi = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(ospi->clk);
 
 	mutex_destroy(&ospi->mlock);
-
-	return 0;
 }
 
 static const struct of_device_id f_ospi_dt_ids[] = {
@@ -693,7 +691,7 @@ static struct platform_driver f_ospi_driver = {
 		.of_match_table = f_ospi_dt_ids,
 	},
 	.probe = f_ospi_probe,
-	.remove = f_ospi_remove,
+	.remove_new = f_ospi_remove,
 };
 module_platform_driver(f_ospi_driver);
 
-- 
2.39.1

