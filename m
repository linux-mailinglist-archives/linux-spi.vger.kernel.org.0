Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A96A9D44
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjCCRVZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCCRVL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F54DE31
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-00070x-Ub; Fri, 03 Mar 2023 18:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-001bnd-Ny; Fri, 03 Mar 2023 18:21:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-001tlw-Vd; Fri, 03 Mar 2023 18:21:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 64/87] spi: sh-msiof: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:18 +0100
Message-Id: <20230303172041.2103336-65-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2js/YpPbWT8ivnay+m0tgeU1uGaXIZ8mdL3b54JqH6Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwEZCkTSUw1KIPl4N5mHE7f7poCLBj3NfIMI xu6/d09znCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsBAAKCRDB/BR4rcrs CSqOB/9dxGg9QLYqqfxQosP2/wgG2WCcCP8+l//2DKVWB3GtE8b0J2wMYn4S5WYk1wkVj0wXsbP KiEqxEWGMm1CjK42KxArQ9iG8k8utLd22kNC+iE0PJRrJoK+eXx+D22j9oVHWRU5yq5kpoFdnmN CrTBk1Sv/ch9/M4KsDU1YLsNP3BG2KiOAQ5/hAzb0n7HxcjVu3q0rMXxWYTfae+CVCUJr5p+ac2 hfdbQJVAYBvmXCN1/b9gKXIQ+v80qeOugJ6TUD0nS/2CQBxKxM+SXX35SLU1ZgcpZzq29uzdP1g QYOUj+HASzFB5VberqFfEIDh50PsBGY2eSiXq6zAVj2UyeuQ
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
 drivers/spi/spi-sh-msiof.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 9bca3d076f05..d828a3b370b8 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1375,13 +1375,12 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sh_msiof_spi_remove(struct platform_device *pdev)
+static void sh_msiof_spi_remove(struct platform_device *pdev)
 {
 	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
 
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static const struct platform_device_id spi_driver_ids[] = {
@@ -1414,7 +1413,7 @@ static SIMPLE_DEV_PM_OPS(sh_msiof_spi_pm_ops, sh_msiof_spi_suspend,
 
 static struct platform_driver sh_msiof_spi_drv = {
 	.probe		= sh_msiof_spi_probe,
-	.remove		= sh_msiof_spi_remove,
+	.remove_new	= sh_msiof_spi_remove,
 	.id_table	= spi_driver_ids,
 	.driver		= {
 		.name		= "spi_sh_msiof",
-- 
2.39.1

