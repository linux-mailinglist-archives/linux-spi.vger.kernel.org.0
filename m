Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717D36A9D3D
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCCRVV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCCRVL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875264D62F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-0006yR-QV; Fri, 03 Mar 2023 18:21:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-001bn9-M5; Fri, 03 Mar 2023 18:21:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-001tlY-Jf; Fri, 03 Mar 2023 18:21:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 58/87] spi: rockchip-sfc: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:12 +0100
Message-Id: <20230303172041.2103336-59-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bX62lV2TXhh+Chr6nrCmzfML6Z1r56z5yaVi5PzLxgA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivrj5tHxRTJlYZlxWo0q/BM24wM1jynBx/c5 uaQAIHVd/OJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr6wAKCRDB/BR4rcrs CZu3CACfuE1Q77oNhvmLE3bTfyqTKU1HGoOxSnsSfbLWeiTFpbR/XRDXh1thy8s0qRpJmxVySx/ N39A8idBKYGWHpgfkyIwXeTx4owGnrUL85wJTzzObScztrImSWymvOHuJHinVigWiXbXN0XFxmT UNa6A5Hs1oPk5pk5/XN8QGCagstBYSPCeP9pZ5nObujWvuAywQBSSPcIUbkNSGe91uH1f73VLeM Sdq7rwk1zLrioymoaIw1clRQnrgxnp2cL0/oFw+MvwQ/KGyujDWCfdgasdeD/TWgAtW+XND2sww Jt92SNe+wj4ovzmxSdVYpD6g2qMBLBWnZEkfpNcoHaf9xUUe
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
 drivers/spi/spi-rockchip-sfc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index bd87d3c92dd3..80e1ee110d31 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -656,7 +656,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rockchip_sfc_remove(struct platform_device *pdev)
+static void rockchip_sfc_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct rockchip_sfc *sfc = platform_get_drvdata(pdev);
@@ -665,8 +665,6 @@ static int rockchip_sfc_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(sfc->clk);
 	clk_disable_unprepare(sfc->hclk);
-
-	return 0;
 }
 
 static const struct of_device_id rockchip_sfc_dt_ids[] = {
@@ -681,7 +679,7 @@ static struct platform_driver rockchip_sfc_driver = {
 		.of_match_table = rockchip_sfc_dt_ids,
 	},
 	.probe	= rockchip_sfc_probe,
-	.remove	= rockchip_sfc_remove,
+	.remove_new = rockchip_sfc_remove,
 };
 module_platform_driver(rockchip_sfc_driver);
 
-- 
2.39.1

