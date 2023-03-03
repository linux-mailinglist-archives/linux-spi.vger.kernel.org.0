Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EC86A9D0B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCCRVA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjCCRU5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900BB4614F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-0006QB-NZ; Fri, 03 Mar 2023 18:20:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001bjQ-W9; Fri, 03 Mar 2023 18:20:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001tib-A0; Fri, 03 Mar 2023 18:20:53 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 12/87] spi: bcm63xx: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:26 +0100
Message-Id: <20230303172041.2103336-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=d52b3LSW7HCKrESofrSR0j6eZDk0yiEsbFZkIOL5pco=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaQwaVsIbbrJeDZMet4f1VZXHsZ9+t+Ua68dvbX105P6M j3GibGynYzGLAyMXAyyYoosdUVaYhMk1vy3K1nCDTOIlQlkCgMXpwBMRP8fB0NH5R3d72wJDBFX Vl7ikEmvVnAI+ZBqGLVLL1hP8uJUkUkTbjmaad7Y0LnPt/DX7eueC2N+Cx/8vldZqTuM31HXss1 rioDhhM61DE6C0znLeEKaHpS52ba8/VP4T8x44ZMzXoskGU/uFhHxU3EyWeSuWc541tFb5G6Zcj HjgXX8b0w9NOMdFNeHLzKYoD9jgarrv09Ff95rsp0/qiX1WP7jRNuyrrvu5S9i9LcvWGh/MZB7m q5mncdOZ0em7z/tuGb9fHVvpZhXkdjjns9mi8wOO+3i3WciZtuscnrKtZn8RoLqnxyP6NneW3VN PaSo87SlIFffYlkfy1SfL036P8RZ3uq/ybi3I+fPVzN/AA==
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
 drivers/spi/spi-bcm63xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 3686d78c44a6..0a78351bfd24 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -615,7 +615,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm63xx_spi_remove(struct platform_device *pdev)
+static void bcm63xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm63xx_spi *bs = spi_master_get_devdata(master);
@@ -625,8 +625,6 @@ static int bcm63xx_spi_remove(struct platform_device *pdev)
 
 	/* HW shutdown */
 	clk_disable_unprepare(bs->clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -670,7 +668,7 @@ static struct platform_driver bcm63xx_spi_driver = {
 	},
 	.id_table	= bcm63xx_spi_dev_match,
 	.probe		= bcm63xx_spi_probe,
-	.remove		= bcm63xx_spi_remove,
+	.remove_new	= bcm63xx_spi_remove,
 };
 
 module_platform_driver(bcm63xx_spi_driver);
-- 
2.39.1

