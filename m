Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB26A9D1F
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjCCRVH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCCRVB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCF4616A
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-0006YW-AV; Fri, 03 Mar 2023 18:20:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001bkP-CM; Fri, 03 Mar 2023 18:20:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001tjM-N3; Fri, 03 Mar 2023 18:20:55 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 24/87] spi: fsl-dspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:38 +0100
Message-Id: <20230303172041.2103336-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UdbM5NBlOoMM3H1z1Gp+Qt0caUqPfzSKBz4qOy7uAD8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitm79N5SnoFWRqVhSMwJ1weLxRlZuLNRabM9 R6z2R3loASJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrZgAKCRDB/BR4rcrs CRfiB/4wSbjsv1c0ct7VB5qYZduUO0JWQ1xW4V9jdZQ4yXNPvp3Qc8YhqCAt82/ADPJroYS7ZIg pDhmjPDfjbVlLCRTm3bsfyrJiAvCveXWlgLM1uq/dS2y0UUk1YM77ueckZaATYvsMORjnpHxKG/ TmVNvdaHJjYhMkQqtec8SQI3WPxUGdxa4jqcbyeP7PG+wN8rL3PAHyrp8O1GJeHG5MIRLzgpF3Z 9tDDgv+9+GUzDEvRuUBKUD6CVmTwpr7v6/dT5/Rsfa427cxREGbcI7fY47ckQDygV+22nyfDx+E vbtIDVH4M5YJLU4rGhQ/QvWOq+yfy4VHGFEfliOiVouFSt32
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
 drivers/spi/spi-fsl-dspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index e419642eb10e..49df00f52ea4 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1425,7 +1425,7 @@ static int dspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dspi_remove(struct platform_device *pdev)
+static void dspi_remove(struct platform_device *pdev)
 {
 	struct fsl_dspi *dspi = platform_get_drvdata(pdev);
 
@@ -1444,8 +1444,6 @@ static int dspi_remove(struct platform_device *pdev)
 	if (dspi->irq)
 		free_irq(dspi->irq, dspi);
 	clk_disable_unprepare(dspi->clk);
-
-	return 0;
 }
 
 static void dspi_shutdown(struct platform_device *pdev)
@@ -1459,7 +1457,7 @@ static struct platform_driver fsl_dspi_driver = {
 	.driver.owner		= THIS_MODULE,
 	.driver.pm		= &dspi_pm,
 	.probe			= dspi_probe,
-	.remove			= dspi_remove,
+	.remove_new		= dspi_remove,
 	.shutdown		= dspi_shutdown,
 };
 module_platform_driver(fsl_dspi_driver);
-- 
2.39.1

