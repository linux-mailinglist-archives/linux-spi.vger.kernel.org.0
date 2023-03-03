Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCE16A9D74
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjCCRVu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjCCRV0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D3555518
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95i-0007FZ-W6; Fri, 03 Mar 2023 18:21:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-001bp2-Aj; Fri, 03 Mar 2023 18:21:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-001tmz-A9; Fri, 03 Mar 2023 18:21:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 80/87] spi: tegra20-slink: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:34 +0100
Message-Id: <20230303172041.2103336-81-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wVFz0CNw+fCVgWChfWLOK2RDEB/isoEpt3kufOo7JQE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAixGrw8czG1d0NhnmQMIBHgv0L4Jg25CKdbI7 yVdW/n6XJKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsRgAKCRDB/BR4rcrs Cb2/B/4gBBoy57raPWPYBNhPL7Po2Hmguq3RDR4wJ25LB/Yior+iRFeri8MeIqebhGUqiVQDxPL Sg392kLUF7K0KMe2hf9CXb6WDzvUeFti9KR+/LcFUqji3eUZ91YLKH4MumUp0CkwrW7h0ym5bNW 7hTL1uf8zngeQNy26KUmH630XNnOY2KOaUD7eHUM1+LB9i9VUll8l1QL+3bF96/ZgKHpM5zENvE hy0DQPtrfqJHZwcJ7DoLfSS9QhZbQxGweNplwVUzJMObRcyT8n7Qlf1G2MPwUNA/BJzG1KlrZGf z9nKC+ev5IoSFJ9X4GGRlq3fDbtO95pjWYDtaggXXA1K8O7m
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
 drivers/spi/spi-tegra20-slink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 148043d0c2b8..ac7933bc03e2 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1134,7 +1134,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_slink_remove(struct platform_device *pdev)
+static void tegra_slink_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct tegra_slink_data	*tspi = spi_master_get_devdata(master);
@@ -1152,7 +1152,6 @@ static int tegra_slink_remove(struct platform_device *pdev)
 		tegra_slink_deinit_dma_param(tspi, true);
 
 	spi_master_put(master);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1220,7 +1219,7 @@ static struct platform_driver tegra_slink_driver = {
 		.of_match_table	= tegra_slink_of_match,
 	},
 	.probe =	tegra_slink_probe,
-	.remove =	tegra_slink_remove,
+	.remove_new =	tegra_slink_remove,
 };
 module_platform_driver(tegra_slink_driver);
 
-- 
2.39.1

