Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526D46A9D4E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCCRV3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCCRVN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3224B46173
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-000744-CO; Fri, 03 Mar 2023 18:21:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-001boA-Ef; Fri, 03 Mar 2023 18:21:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-001tmP-Cv; Fri, 03 Mar 2023 18:21:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 71/87] spi: st-ssc4: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:25 +0100
Message-Id: <20230303172041.2103336-72-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ASXVMuHvpoG3uOSyy2xrFoZNj05mSbabdb6tkczgKjg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiweFEgcfmwOEmVYq7q578JyMBYELyu3fsgK7 gm9aRGg346JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsHgAKCRDB/BR4rcrs CflFB/4zdDxYDh/aQ7/rG06nVddAQJU+AIavlU7XRMr2IgbDbJM56IA++y4KNKjeqGt7NJt6if7 R0LgyR3k7WpAokJ/z24HzDdIjCSJrLcmC5rop9GHw6bMngUCdjbO5+2BT9gjzgC7hv0qck99Jh6 dycKx6fGAeqDssaEgiqscZOHs96TpjWB0kLz+3QURplQZphd7DZJumEVI2eSv0iNCtj91x58LdZ q/UR4tMdNtdIRmuS0feCx3ICZtH/KeOuv2n7cXBVQCgSxeT3n/Bd8/IX6eHVXNZcDAyxgW1dPAO YWeRMJ4P5tDPq4PMD3xbSOuT08RmXMbPsjdJuyilZvvR9ye5
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
 drivers/spi/spi-st-ssc4.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index 843be803696b..9141f19c7f8e 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -366,7 +366,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spi_st_remove(struct platform_device *pdev)
+static void spi_st_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_master_get_devdata(master);
@@ -376,8 +376,6 @@ static int spi_st_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spi_st->clk);
 
 	pinctrl_pm_select_sleep_state(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -451,7 +449,7 @@ static struct platform_driver spi_st_driver = {
 		.of_match_table = of_match_ptr(stm_spi_match),
 	},
 	.probe = spi_st_probe,
-	.remove = spi_st_remove,
+	.remove_new = spi_st_remove,
 };
 module_platform_driver(spi_st_driver);
 
-- 
2.39.1

