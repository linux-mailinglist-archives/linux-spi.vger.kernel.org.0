Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C6E6A9D0A
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjCCRU7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCCRU5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E334C4392E
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-0006Ox-U8; Fri, 03 Mar 2023 18:20:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-001bii-4W; Fri, 03 Mar 2023 18:20:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95P-001thz-Ey; Fri, 03 Mar 2023 18:20:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 02/87] spi: armada-3700: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:16 +0100
Message-Id: <20230303172041.2103336-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=F8KBtnscIvPxZNIoEeh1ijfeX88IfrcWkrcur9iyGwM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAisSiZpOXkhstileYltVBMFNx3J8qA1lT9IbJ cIQ5epjHrWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrEgAKCRDB/BR4rcrs CTivB/9XkREUzuO3qMUpDTelbK54ZWPGWQZ7VT8KsTq+okC9O3qHKwn7r5y9XIjDacitQxFhly7 JrgzPQ02Ww94aibUy8DxOCinBHLhw0Wpe0AImpUZxwdjslyjtT8iLbShupELEHmlqI1Fe0KMMgc iKt/x+Jz8G7TX6GvzDk9uT59RSHfQfIeITyqrJP6cltnjn816odcF39dfclPBdhduFljzcPIgnH fjB/6YA7HSPh6IbzIYGuIUzyyJ0CBsghudiySJp/PzN06oGjKSm6YpDm/K3d9Tr8KiGPB8VR6NL qWeeTrCC1aSNqs4sXPTRbE7RKLBu19OUAlOBdxFAVZ+PnMQs
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
 drivers/spi/spi-armada-3700.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 4d554b948d71..6a7e605f73bf 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -908,14 +908,12 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int a3700_spi_remove(struct platform_device *pdev)
+static void a3700_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct a3700_spi *spi = spi_controller_get_devdata(host);
 
 	clk_unprepare(spi->clk);
-
-	return 0;
 }
 
 static struct platform_driver a3700_spi_driver = {
@@ -924,7 +922,7 @@ static struct platform_driver a3700_spi_driver = {
 		.of_match_table = of_match_ptr(a3700_spi_dt_ids),
 	},
 	.probe		= a3700_spi_probe,
-	.remove		= a3700_spi_remove,
+	.remove_new	= a3700_spi_remove,
 };
 
 module_platform_driver(a3700_spi_driver);
-- 
2.39.1

