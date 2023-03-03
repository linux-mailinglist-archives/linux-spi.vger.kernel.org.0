Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BD56A9D3A
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCCRVT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjCCRVK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D024743D
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-0006w8-2e; Fri, 03 Mar 2023 18:21:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-001bn1-4o; Fri, 03 Mar 2023 18:21:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001tlF-Jk; Fri, 03 Mar 2023 18:21:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 53/87] spi: pic32: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:07 +0100
Message-Id: <20230303172041.2103336-54-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iawdZ8l5378XXZ2QCMwyt7xRXDh4jbNyBKRHxAx4rxQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivY6ZK3URSN7ZOl2fSu03q/bgZrpCqfEppXk X/TlWMD8LuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr2AAKCRDB/BR4rcrs CeIBB/9be+OrYgJSfJwvqspSbuzaQR1q72iY0aczPTh/1o8fxFXOyN6TgqqG2f5Io10+j6QKKMb 2hK8onDOAIpW0AdYmSlIFguoFri/FJ3aBxN3j0vpfNglKE5UqSsHB5w17hU0EERwg5eGH9IjtLX vk8S7u81ZnD+yZIsHQIyIU52IKvHeiXs/z0feJEaYM1Wosykg3x8jJxAVgHzURZGOGrxlyqu9v7 mTz7e3HIoYr16h5h3vXHql+zY8ognDcLqsUN6M3nfqvJTGadWXNWqmgCqpB70JFMzxq2wQPPTa+ hBYXAxrkF0sgRWcT2UEcdzRZafhbO4oTap/TaJtCtl07hqef
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
 drivers/spi/spi-pic32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 7e5c09a7d489..5a64ad0c94fe 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -844,7 +844,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pic32_spi_remove(struct platform_device *pdev)
+static void pic32_spi_remove(struct platform_device *pdev)
 {
 	struct pic32_spi *pic32s;
 
@@ -852,8 +852,6 @@ static int pic32_spi_remove(struct platform_device *pdev)
 	pic32_spi_disable(pic32s);
 	clk_disable_unprepare(pic32s->clk);
 	pic32_spi_dma_unprep(pic32s);
-
-	return 0;
 }
 
 static const struct of_device_id pic32_spi_of_match[] = {
@@ -868,7 +866,7 @@ static struct platform_driver pic32_spi_driver = {
 		.of_match_table = of_match_ptr(pic32_spi_of_match),
 	},
 	.probe = pic32_spi_probe,
-	.remove = pic32_spi_remove,
+	.remove_new = pic32_spi_remove,
 };
 
 module_platform_driver(pic32_spi_driver);
-- 
2.39.1

