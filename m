Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957B16A9D71
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjCCRVs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCCRVZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E266C5550C
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-00077C-B6; Fri, 03 Mar 2023 18:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-001bok-M2; Fri, 03 Mar 2023 18:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-001tmq-TT; Fri, 03 Mar 2023 18:21:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 78/87] spi: tegra114: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:32 +0100
Message-Id: <20230303172041.2103336-79-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ZbrWp4kl8VJm4r6RChgFbUVt91nTQo4cZsMSRna2sFY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiw/BDgnp0dbH2M3Mn1GZVRNOolnRiciWg8CB Ke5EfgrpmiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsPwAKCRDB/BR4rcrs Cd7KB/4r/FabBgr9qQquxHbG0PPOqKJHrJzmPh7AmvgbVhJyjYr/WO+IhPXdXvM+myxtiXecijv L80ZiF+2Ug0kWn3Q95JZ92H/6DMBOm8bO696vDaXHuDIBqYNTTrbspV/SleWMXx3x64DhKfGO+0 xGh11RiG6wBt7oLqIH4RTzQYFvfMRaOPFT14jH3JXQNUlT9ZEB2MgRlnHPGmJGOP2ophJ1M+P6H ANUOoKjTf1urHkFjgEOgPhidK51x8uK0FeXX68FDHQOIv5FEWtPQiU8GLqzysJZd6yA3uC8lcKt DOkiGkwVjYyum8NUxNYDoJmRv4N95UvAZbjZcNM/rKdIG7QE
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
 drivers/spi/spi-tegra114.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d9be80e3e1bc..b6bee922a92c 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1440,7 +1440,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_spi_remove(struct platform_device *pdev)
+static void tegra_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_spi_data	*tspi = spi_master_get_devdata(master);
@@ -1456,8 +1456,6 @@ static int tegra_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_spi_runtime_suspend(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1526,7 +1524,7 @@ static struct platform_driver tegra_spi_driver = {
 		.of_match_table	= tegra_spi_of_match,
 	},
 	.probe =	tegra_spi_probe,
-	.remove =	tegra_spi_remove,
+	.remove_new =	tegra_spi_remove,
 };
 module_platform_driver(tegra_spi_driver);
 
-- 
2.39.1

