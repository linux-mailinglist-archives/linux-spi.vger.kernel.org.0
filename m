Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247D26A9D24
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjCCRVK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjCCRVD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CE647412
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-0006jM-T6; Fri, 03 Mar 2023 18:20:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-001blB-FR; Fri, 03 Mar 2023 18:20:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001tjx-Fg; Fri, 03 Mar 2023 18:20:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 33/87] spi: lantiq-ssc: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:47 +0100
Message-Id: <20230303172041.2103336-34-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tPRupWNCOhkJMNvWgyjIqRGon80u4y/NxLD0/Cu25H0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuKxz7XvUO35afuFXm08crM5tkto4f/VtOLa LEapz+UEIWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrigAKCRDB/BR4rcrs CZTIB/99xBGcmhZNK1bOSiOXCVH+4papQ+UqTaLkVu3PilDtSYzroBTrJ1GepIW0mXO4XKx1Sok 4cLIGP0nGB3GvlBLubUBWevzUngv6Alv6FCZUgvu37URBz0NtivZPnB3baf+AtqVij3BB8Rcncz G9/OXu0nkLMEbbs/uOKW22kwqpYS0yXBsZEkY8ln9kRNZQzLahOU3wSdGvCbeFQiXAWeWVUhYr9 KVXHLt6UeHRgHsUAwAzG3CaH3cCmZo9sIXxnfOnLCgkIvnwPkf7534Uwi5iqsY8d/R4deualw3c 0zlOaZeLg1oPLbuP+X8qEaUAR86WlJTgL2BgKOVseoEVgvjr
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
 drivers/spi/spi-lantiq-ssc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index aae26f62ea87..76cf2a66f874 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -1017,7 +1017,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int lantiq_ssc_remove(struct platform_device *pdev)
+static void lantiq_ssc_remove(struct platform_device *pdev)
 {
 	struct lantiq_ssc_spi *spi = platform_get_drvdata(pdev);
 
@@ -1030,13 +1030,11 @@ static int lantiq_ssc_remove(struct platform_device *pdev)
 	destroy_workqueue(spi->wq);
 	clk_disable_unprepare(spi->spi_clk);
 	clk_put(spi->fpi_clk);
-
-	return 0;
 }
 
 static struct platform_driver lantiq_ssc_driver = {
 	.probe = lantiq_ssc_probe,
-	.remove = lantiq_ssc_remove,
+	.remove_new = lantiq_ssc_remove,
 	.driver = {
 		.name = "spi-lantiq-ssc",
 		.of_match_table = lantiq_ssc_match,
-- 
2.39.1

