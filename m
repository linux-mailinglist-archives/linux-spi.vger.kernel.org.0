Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046956A9D22
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCCRVJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjCCRVB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51674391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-0006eZ-5r; Fri, 03 Mar 2023 18:20:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001bkk-9M; Fri, 03 Mar 2023 18:20:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001tjc-FZ; Fri, 03 Mar 2023 18:20:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 28/87] spi: fsl-spi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:42 +0100
Message-Id: <20230303172041.2103336-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2364; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hmg5lldFXNC6gC/mhQPTWRJjVxrUUUWHibI0hK4cTZY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAit3ftOpPkrS42lmZ4wrLP8iYfsJV2VtzxRx9 Cf20SyoS0GJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrdwAKCRDB/BR4rcrs CbQyB/982UNcsBCJiVUExsW+Vh+lIpG4nBEasT3AvTy+Fbpj8pkN9S0gaBAkJRah0KmI7NpA/Ai /k7ymY1/9y8stcZ0YYb+4b//sTh7TR30oJyOLm/NTkmu67AXLbjxaApft4ucUee2zseWcLpAmHF DLqNwkKmL+nd6G5lFauTKlyc+fe09I4vcHL/qsI+lK/uB0cUie83hfbGc5516a3/w4xtWHRTEdf 2SBt95MXPl3ad/mO2Q2hVTNCrnu/BnyvUB0b+WcEUcZ0jN+54KpU7gLCjjWGylXWoDHh/7elOWW qymONnZRarL3Pvg31SFNAdrau0rGzbsfW4ktJvZdWUSL7Q+V
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
 drivers/spi/spi-fsl-spi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 93152144fd2e..725d043488a1 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -716,13 +716,12 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	return ret;
 }
 
-static int of_fsl_spi_remove(struct platform_device *ofdev)
+static void of_fsl_spi_remove(struct platform_device *ofdev)
 {
 	struct spi_master *master = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
 
 	fsl_spi_cpm_free(mpc8xxx_spi);
-	return 0;
 }
 
 static struct platform_driver of_fsl_spi_driver = {
@@ -731,7 +730,7 @@ static struct platform_driver of_fsl_spi_driver = {
 		.of_match_table = of_fsl_spi_match,
 	},
 	.probe		= of_fsl_spi_probe,
-	.remove		= of_fsl_spi_remove,
+	.remove_new	= of_fsl_spi_remove,
 };
 
 #ifdef CONFIG_MPC832x_RDB
@@ -763,20 +762,18 @@ static int plat_mpc8xxx_spi_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(master);
 }
 
-static int plat_mpc8xxx_spi_remove(struct platform_device *pdev)
+static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
 
 	fsl_spi_cpm_free(mpc8xxx_spi);
-
-	return 0;
 }
 
 MODULE_ALIAS("platform:mpc8xxx_spi");
 static struct platform_driver mpc8xxx_spi_driver = {
 	.probe = plat_mpc8xxx_spi_probe,
-	.remove = plat_mpc8xxx_spi_remove,
+	.remove_new = plat_mpc8xxx_spi_remove,
 	.driver = {
 		.name = "mpc8xxx_spi",
 	},
-- 
2.39.1

