Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413CF6A9D37
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjCCRVS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCCRVI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763846173
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-0006rm-9R; Fri, 03 Mar 2023 18:21:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-001bma-3C; Fri, 03 Mar 2023 18:21:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001tlB-Cx; Fri, 03 Mar 2023 18:21:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 52/87] spi: pic32-sqi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:06 +0100
Message-Id: <20230303172041.2103336-53-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kt6lObHRr7O11H1ahCC6k0545Cxjn+UpDk72ocJ5aTA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivUBCdfL22h7H4XId1sT0gJwRd8f8oAfAlXZ Cka0hR5OHuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr1AAKCRDB/BR4rcrs Cc+iB/9eeSIH0jQzLatR3qPbkKwblTlnTwPFbF0nxDJKzeACgf/sIPaN3g6V8h93RB0zRkG4ntu Yfb6dPju9jBXpuYVyf5PyVjYoZlyK3vBQHpFMgS0qxR2s/rPywSwRJd21ouvGtUWDLmTdZMCi0R pyBsFRCydiKO0EnMmfRHeHNEngt6zKazMkMExVJr399I1EWBUose2w6FY61ZyKgWqq+6Ayy+SAD i1uqbZR1SeMxNF7cfcpxNj77WsddPa/hClfPH9lUo1EPQKayksY1e+UsU+nqRjfNDab5tcrrpBy rxnIr+iPTh6e8fOixrJ+u7Z0CQakgP4s5U1HmLqPXSwNwHfk
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
 drivers/spi/spi-pic32-sqi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 86ad17597f5f..4c8493f34fca 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -678,7 +678,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pic32_sqi_remove(struct platform_device *pdev)
+static void pic32_sqi_remove(struct platform_device *pdev)
 {
 	struct pic32_sqi *sqi = platform_get_drvdata(pdev);
 
@@ -689,8 +689,6 @@ static int pic32_sqi_remove(struct platform_device *pdev)
 	/* disable clk */
 	clk_disable_unprepare(sqi->base_clk);
 	clk_disable_unprepare(sqi->sys_clk);
-
-	return 0;
 }
 
 static const struct of_device_id pic32_sqi_of_ids[] = {
@@ -705,7 +703,7 @@ static struct platform_driver pic32_sqi_driver = {
 		.of_match_table = of_match_ptr(pic32_sqi_of_ids),
 	},
 	.probe = pic32_sqi_probe,
-	.remove = pic32_sqi_remove,
+	.remove_new = pic32_sqi_remove,
 };
 
 module_platform_driver(pic32_sqi_driver);
-- 
2.39.1

