Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A86A9D6D
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjCCRVp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjCCRVZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E90F55079
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-0006l0-G4; Fri, 03 Mar 2023 18:21:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-001blT-8T; Fri, 03 Mar 2023 18:20:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-001tkD-G8; Fri, 03 Mar 2023 18:20:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 37/87] spi: microchip-core: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:51 +0100
Message-Id: <20230303172041.2103336-38-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2q5THNKlK4gsquv2lzy7ofOnkVJIgOoYwNhePyYNVus=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuayFi3bYDqqf9iXAc1czAWs59j6npeXLTFz RlGLZ5ws1CJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrmgAKCRDB/BR4rcrs CSK+B/9Wtf/e7biFxUeF+iCjsLA5hkPiJXTXRuRmrpfFBbNugB6pMsNUDLkp3d1Sg835DWSD5L9 Mlw05kpKgDD0Rg3AE9aR7+47N0DM0Xwj+cyb47fUI6YO32iJ4V+436Zvaoh0NrBRd+o5K3Psb8G O9lseeQbr8uNPwQw8kDyFpZXn1xgchISi7VKdwBx1YxoPdZnPHP8y/WIRZSKUQf5Vu6/mK6ycDi M5NmqTu8S6vW3tztURb7lw2DX41tY5kxsVNwyaf5jL841rlkIRr/y4NhCkVjHKjt4KGGelwNTQt CGjsNJGbdD1fJe2DPrJ50HMxewndgT1IdKBbpedyXu+Pyh2G
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
 drivers/spi/spi-microchip-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index aeaa1da88f39..e6cf6ff08061 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -566,7 +566,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mchp_corespi_remove(struct platform_device *pdev)
+static void mchp_corespi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master  = platform_get_drvdata(pdev);
 	struct mchp_corespi *spi = spi_master_get_devdata(master);
@@ -574,8 +574,6 @@ static int mchp_corespi_remove(struct platform_device *pdev)
 	mchp_corespi_disable_ints(spi);
 	clk_disable_unprepare(spi->clk);
 	mchp_corespi_disable(spi);
-
-	return 0;
 }
 
 #define MICROCHIP_SPI_PM_OPS (NULL)
@@ -599,7 +597,7 @@ static struct platform_driver mchp_corespi_driver = {
 		.pm = MICROCHIP_SPI_PM_OPS,
 		.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
 	},
-	.remove = mchp_corespi_remove,
+	.remove_new = mchp_corespi_remove,
 };
 module_platform_driver(mchp_corespi_driver);
 MODULE_DESCRIPTION("Microchip coreSPI SPI controller driver");
-- 
2.39.1

