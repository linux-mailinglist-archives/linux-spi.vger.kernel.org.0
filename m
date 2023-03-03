Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1206A9D31
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjCCRVP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjCCRVF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9148E2C
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-0006oP-1V; Fri, 03 Mar 2023 18:21:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-001bm3-TL; Fri, 03 Mar 2023 18:21:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-001tkc-Ns; Fri, 03 Mar 2023 18:20:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 43/87] spi: mxic: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:57 +0100
Message-Id: <20230303172041.2103336-44-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BrYpHOANXgmrf9KvumHfTiP45DbB6R9VmqxglJLOJ3g=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuxoGQl0f8CjwIBVTzTp/UnMO8fQU4eTHx2X 1roLzwbOJSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrsQAKCRDB/BR4rcrs CRF9B/9uOV+FThMMkGWElvHb3Ml+gXrNy9DHicg8ulEDZLIyhpoRtPO3UCJZ+B6fYprx9mEAkwR 4kqjtb5+nliof1VgbjA9GOOaSY9cuxPoPFIiznQ42F3dKWDdL+O17Lq9RmnkeBpe8la1h7IxSs8 ljm+5alnaqWE88WrO49G2+Zd13fqgqO9ECeKcQ6IhkAzFaXh7Z06JkJlqZvH5WQ/Kb1Ui0YTO8A VJegdiAG8cx0GxlkaNUetRzr8cH4aH7o0GN8pWj1mFIZG0mM8xgL/D4RYOjbX1jUzkNpONh1jlm PiUiSdEc5cM/Q5jJLSiVTvxRfe+kp9v4x01aUz2pEnLX21xl
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
 drivers/spi/spi-mxic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index a3dba17390eb..10727ea53043 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -818,7 +818,7 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxic_spi_remove(struct platform_device *pdev)
+static void mxic_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct mxic_spi *mxic = spi_master_get_devdata(master);
@@ -826,8 +826,6 @@ static int mxic_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	mxic_spi_mem_ecc_remove(mxic);
 	spi_unregister_master(master);
-
-	return 0;
 }
 
 static const struct of_device_id mxic_spi_of_ids[] = {
@@ -838,7 +836,7 @@ MODULE_DEVICE_TABLE(of, mxic_spi_of_ids);
 
 static struct platform_driver mxic_spi_driver = {
 	.probe = mxic_spi_probe,
-	.remove = mxic_spi_remove,
+	.remove_new = mxic_spi_remove,
 	.driver = {
 		.name = "mxic-spi",
 		.of_match_table = mxic_spi_of_ids,
-- 
2.39.1

