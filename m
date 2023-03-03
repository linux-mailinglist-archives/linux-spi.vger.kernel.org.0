Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF566A9D2C
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjCCRVM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjCCRVE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0947410
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-0006n0-Ti; Fri, 03 Mar 2023 18:21:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-001blg-QV; Fri, 03 Mar 2023 18:20:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-001tkQ-46; Fri, 03 Mar 2023 18:20:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 40/87] spi: mpc52xx: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:54 +0100
Message-Id: <20230303172041.2103336-41-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=D+ZjbD9Sk5/Kt5HJcU5/T4TMs5D4pelyPRUs4knQdJo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiumKff9PRZqa3zl2uU+D66aSxqGcTqNSI4+d qvdNtXIp/iJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrpgAKCRDB/BR4rcrs CUBVB/kB7z1bWsMT+hmYbm56Y6iSswBBkNkKIvbmoYfYjV1TrWaRO08QyhC8miXxQp5ggXrbcJO s7CkK/yh7NEJUwugSdmnV734HB+BCsabf6xozokULLH6LrDo4Lpxm4S2tG6EgnfOAA2GIC5PxIP U+HrRMHzwA/KXYbQixob6KOz99YUg+K+kRHoxqDMHNJ0cfDAMrSsl253iKi28VskaqHaHiL2D76 u6aBg/i9tnP3I6nbiqROQXD+3Q/kYAgOu11Gq/UJpXLpL1ffihC5k6zOqwe95LCRevOsseKPNhh iqmpXkM/B+4Qefxv3f1p9e7lf64m5G6ILxlCvDzA35UftcBC
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
 drivers/spi/spi-mpc52xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 7b64e64c65cf..b652fb196622 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -513,7 +513,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	return rc;
 }
 
-static int mpc52xx_spi_remove(struct platform_device *op)
+static void mpc52xx_spi_remove(struct platform_device *op)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(op));
 	struct mpc52xx_spi *ms = spi_master_get_devdata(master);
@@ -529,8 +529,6 @@ static int mpc52xx_spi_remove(struct platform_device *op)
 	spi_unregister_master(master);
 	iounmap(ms->regs);
 	spi_master_put(master);
-
-	return 0;
 }
 
 static const struct of_device_id mpc52xx_spi_match[] = {
@@ -545,6 +543,6 @@ static struct platform_driver mpc52xx_spi_of_driver = {
 		.of_match_table = mpc52xx_spi_match,
 	},
 	.probe = mpc52xx_spi_probe,
-	.remove = mpc52xx_spi_remove,
+	.remove_new = mpc52xx_spi_remove,
 };
 module_platform_driver(mpc52xx_spi_of_driver);
-- 
2.39.1

