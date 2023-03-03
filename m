Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741106A9D33
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCCRVQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCCRVF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32074743D
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-0006pf-1B; Fri, 03 Mar 2023 18:21:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001bmT-OP; Fri, 03 Mar 2023 18:21:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001tl3-1m; Fri, 03 Mar 2023 18:21:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 50/87] spi: omap2-mcspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:04 +0100
Message-Id: <20230303172041.2103336-51-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8yDMBKowUDVEcc54Gu/rkxGcSRFrN+F4zio8ALMP16M=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivNcMUmqddMY5cgFBCovSgMjfZrJUVnyvzBY itu3sd08SqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrzQAKCRDB/BR4rcrs Cf3yB/0byV8irS+LJm4X5HGA6mcmsht+nPd6jsdqaI/vEzpFOG9Qtjtb1TTlt5AK7YGj7cNNZNw sbczbOUBek+X+VvkEOThKg2sQi6pTNlV/0piG0zjiIc2U8ES5iiy56lXV/raVynWFqrq1ZCVb9X pUnzCb0FO52bGggYBaGod0VUYg9KfcWSiD1ZOM/OSwJkKoOCrSaGpXuJgBDTv/FFq5UOrG+386A gzPl2Fw+Zw+2oSr46pJuJO6cP8NfBxKpC1Y1j186d3Lv/fWRDIg44RYHFo/1BPt4BEjbMWgJiKz sZJPCngYS6AfoQCQis1Iqfl7uWJAp9F46vIpM9vROerPVaQe
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
 drivers/spi/spi-omap2-mcspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 6ba9b0d7710b..ce3cdd540420 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1546,7 +1546,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	return status;
 }
 
-static int omap2_mcspi_remove(struct platform_device *pdev)
+static void omap2_mcspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
@@ -1556,8 +1556,6 @@ static int omap2_mcspi_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(mcspi->dev);
 	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 /* work with hotplug and coldplug */
@@ -1610,7 +1608,7 @@ static struct platform_driver omap2_mcspi_driver = {
 		.of_match_table = omap_mcspi_of_match,
 	},
 	.probe =	omap2_mcspi_probe,
-	.remove =	omap2_mcspi_remove,
+	.remove_new =	omap2_mcspi_remove,
 };
 
 module_platform_driver(omap2_mcspi_driver);
-- 
2.39.1

