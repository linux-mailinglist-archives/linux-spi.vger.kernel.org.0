Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACDD6B2088
	for <lists+linux-spi@lfdr.de>; Thu,  9 Mar 2023 10:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCIJsA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Mar 2023 04:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCIJro (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 04:47:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9CD3336
        for <linux-spi@vger.kernel.org>; Thu,  9 Mar 2023 01:47:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCrc-0007fz-K6; Thu, 09 Mar 2023 10:47:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCrb-002uvD-FU; Thu, 09 Mar 2023 10:47:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCra-003VnK-Ib; Thu, 09 Mar 2023 10:47:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 2/3] spi: mt65xx: Convert to platform remove callback returning void
Date:   Thu,  9 Mar 2023 10:47:03 +0100
Message-Id: <20230309094704.2568531-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
References: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7aQRHUM0nn1KAYfowSFFpPqyE6Rm7GehZyTUDdqE1Xc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCasRGa1M9enMj+FEqlm29VBuy0k2ifJO+7LBD JQCUASuF3yJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAmrEQAKCRDB/BR4rcrs CWCRB/4neYZ2scIoMfbnFUOUFFF6gQT3ptgdHe/Ft6Nw7PO3EHjj4UPwDPl8qtgwNbZoyDkzDOF jMl3pt7T2BnmN/Ujs+zLh+sfPf21JXCHDPsJJvUJwJx30N/+wm/E0dp99KdxxHqwECInATXoDlx zdc6jDftU0dpLms93A39YGlcfWCnNWPnV6XnDN49naqHTXNn35YOFaYEAgINU2q400b3tlqWewM bvGt1DIo5XFRl3SLsIxhSuVjfcWPLDMdJJ0Yb4h+5zQtebTpr3bpAFYG+e6J3OAeglkm4tjIzhe IAdPGMYtjJJbdRm37bgwghN+/a9YzcYXy6YxMCQ0/y+z/NP9
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
 drivers/spi/spi-mt65xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index b1cf7bbb2c08..f744cb97aa87 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1269,7 +1269,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_spi_remove(struct platform_device *pdev)
+static void mtk_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
@@ -1293,8 +1293,6 @@ static int mtk_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1414,7 +1412,7 @@ static struct platform_driver mtk_spi_driver = {
 		.of_match_table = mtk_spi_of_match,
 	},
 	.probe = mtk_spi_probe,
-	.remove = mtk_spi_remove,
+	.remove_new = mtk_spi_remove,
 };
 
 module_platform_driver(mtk_spi_driver);
-- 
2.39.1

