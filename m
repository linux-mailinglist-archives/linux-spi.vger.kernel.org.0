Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB26A9D23
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjCCRVJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjCCRVC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C45E47410
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-0006hL-Ol; Fri, 03 Mar 2023 18:20:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001bky-RM; Fri, 03 Mar 2023 18:20:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001tjq-1o; Fri, 03 Mar 2023 18:20:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 31/87] spi: img-spfi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:45 +0100
Message-Id: <20230303172041.2103336-32-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SxJm9ul9Dlv7OcCIMuhj4g7Bi6zyIfrM+CmeaZ8tkng=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuC+nxqkqN6xLknJ+Uz57W43S+gb45dHxf0N Yh5o3+6MYGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrggAKCRDB/BR4rcrs CXTeB/4j+AeXKViPXRgkb2CdefjK/B7ZkiUSVyaf8wXUpo7l2APRDlF6ySng9u9JP12Nbn9bIyu bwDOsAairkt2179KUg4Yw9BEVY1Ocayrk+8CGDcFQAwEYREmZTvI+J9/npOEE4xX1stIMu68zGI mlriLIGIxGjbtYjH9nQpdSRPichKjD7X6IIysYEHjilCjNAVjMU0qmqX6v+I2dBWx+5HndqHOwE RljxnRdwcnixkAV0c7GNxu0jTGsfFbrBLklkVKC6hkUHj/WEWrLBTfSybeXPO7iyJdbQMLLyE9p RjMh7QLx6cHX9NstUi5lzfCbRadk7Sf8fnvribWimKvE2Fii
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
 drivers/spi/spi-img-spfi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 257046f843ff..c64e4fd3fdf0 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -665,7 +665,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int img_spfi_remove(struct platform_device *pdev)
+static void img_spfi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct img_spfi *spfi = spi_master_get_devdata(master);
@@ -680,8 +680,6 @@ static int img_spfi_remove(struct platform_device *pdev)
 		clk_disable_unprepare(spfi->spfi_clk);
 		clk_disable_unprepare(spfi->sys_clk);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -758,7 +756,7 @@ static struct platform_driver img_spfi_driver = {
 		.of_match_table = of_match_ptr(img_spfi_of_match),
 	},
 	.probe = img_spfi_probe,
-	.remove = img_spfi_remove,
+	.remove_new = img_spfi_remove,
 };
 module_platform_driver(img_spfi_driver);
 
-- 
2.39.1

