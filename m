Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E86A9D70
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCCRVs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjCCRVZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3689255514
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-000787-HD; Fri, 03 Mar 2023 18:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-001bop-Qi; Fri, 03 Mar 2023 18:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-001tmw-3c; Fri, 03 Mar 2023 18:21:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 79/87] spi: tegra20-sflash: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:33 +0100
Message-Id: <20230303172041.2103336-80-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0yHwtY1f2DEh02cYlnTMnLJgqt1UL9ENFOM4udCRK8w=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAixCpAnkujA/9YRVxhg1FkrU6OzM9lq8Z6whK wu1f4nXnD6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsQgAKCRDB/BR4rcrs Cda9CACUUY3zGSi9U5ADSAv/xKGfeHhiu7Qm2ZpWcwC+Sq0Gb2BlhMWU6qDsxJDRtkX+mWHi2/0 4OblTfMpdGWLPNIWQTWyy5hIBHJajqiM1gREcGsimwqaR0AwqVL3LksKVppbt5fdUxnk0FGx9cw 0WLlJGxA4LYWveLj2UbXdfeof8rh/v8pbxq13ZUqihJiJ9fE/Wp2Oo34//JX1uuB41h6uyQ7SGe dtKllfMKhLlgh3MSnPdssON+dNnsebcBlzYvQTXDt33yAUJxukYnAOgX9oICe+2kr8lu09a62NN ai4HsmdCWOKaIPMCtbSzc8277ajeVP1vzYCNOYjoktuIClnC
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
 drivers/spi/spi-tegra20-sflash.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 220ee08c4a06..ed82530ea64b 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -520,7 +520,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_sflash_remove(struct platform_device *pdev)
+static void tegra_sflash_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_master_get_devdata(master);
@@ -530,8 +530,6 @@ static int tegra_sflash_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -598,7 +596,7 @@ static struct platform_driver tegra_sflash_driver = {
 		.of_match_table	= tegra_sflash_of_match,
 	},
 	.probe =	tegra_sflash_probe,
-	.remove =	tegra_sflash_remove,
+	.remove_new =	tegra_sflash_remove,
 };
 module_platform_driver(tegra_sflash_driver);
 
-- 
2.39.1

