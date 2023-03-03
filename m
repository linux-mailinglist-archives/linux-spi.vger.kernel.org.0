Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15C46A9D34
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCCRVR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCCRVG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F533498B3
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-0006pB-Sg; Fri, 03 Mar 2023 18:21:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001bmO-Io; Fri, 03 Mar 2023 18:21:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-001tky-Rq; Fri, 03 Mar 2023 18:21:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 49/87] spi: omap-uwire: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:03 +0100
Message-Id: <20230303172041.2103336-50-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7mXdQlIjTyhOln6o3gHRFWbfrhv+Ta6Kbs5lck0Esug=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivJVrGdmDFv+0yA38KP1bqRg3keZuYFLBSr2 XtY13mwkDWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIryQAKCRDB/BR4rcrs CcH1B/wIILG+SiPX1+W/ZthW7evzduFkSDLchLHZIRBi4bITFPV/Jz89DAA8+ajAKb8ifZdzBj8 aEfJpEn7IkLQNJUVt/iRDJOuneRW9JPmg9299ir69sXx8XWEOSYa2AjIBXSdq3bdzPv3WmMHgo4 MWthRwi+3qW06bauoZeRGc0zv81V4PCXi0wX4qlhAwLK+RZU+7ifYf8/nEjVuLx6WBs9aeiGPki kwgRU5tVwNeZ05867YiQ67mXohEc9z1XuzyacuQXWUM6wv2XMSDDeNaAooENCJIFZ90xDQMNeCo bZ0dq7g82LTb/hvjLHkj5DbnaWuRhsk42DHbIKVurYYwqHO6
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
 drivers/spi/spi-omap-uwire.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 20c87163d612..6da77de19e2b 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -505,7 +505,7 @@ static int uwire_probe(struct platform_device *pdev)
 	return status;
 }
 
-static int uwire_remove(struct platform_device *pdev)
+static void uwire_remove(struct platform_device *pdev)
 {
 	struct uwire_spi	*uwire = platform_get_drvdata(pdev);
 
@@ -513,7 +513,6 @@ static int uwire_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&uwire->bitbang);
 	uwire_off(uwire);
-	return 0;
 }
 
 /* work with hotplug and coldplug */
@@ -524,7 +523,7 @@ static struct platform_driver uwire_driver = {
 		.name		= "omap_uwire",
 	},
 	.probe = uwire_probe,
-	.remove = uwire_remove,
+	.remove_new = uwire_remove,
 	// suspend ... unuse ck
 	// resume ... use ck
 };
-- 
2.39.1

