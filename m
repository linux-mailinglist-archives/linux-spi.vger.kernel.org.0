Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4E6A9D72
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjCCRVt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCCRVZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193C4ECDB
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95h-00079k-6B; Fri, 03 Mar 2023 18:21:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-001bp0-8g; Fri, 03 Mar 2023 18:21:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-001tn3-HA; Fri, 03 Mar 2023 18:21:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 81/87] spi: tegra210-quad: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:35 +0100
Message-Id: <20230303172041.2103336-82-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=i8CVbkIbpfthZgmIdP2HelMOokdVHNzXjjv7NJXvnPQ=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaQw6Xjx+T2tr1xW9XlTX5SGf7dtcnKoqM8J34efJNsKA nhZjNI7GY1ZGBi5GGTFFFnqirTEJkis+W9XsoQbZhArE8gUBi5OAZgIvxQHwySLtAWCVlkiLVWL fjjvtjkWNmOBinD3nL6Lsb1Zqdw9+2x124SennFTi/RbnJQVxnpxduO1Wzcrdr/ofcllKHDyekl JtYiz3ZGHSwXsXKZFGjYfkvVY5jB9Rf6b7UFxLfsmak7381V5ejvtbZKT8oq/S1y66990n09UTZ /m7RIslPTz3MQU7UVF+/yS1NcJCTjVHDz1sG7DjbVWDgzB1pF19s52KaUax1TUNkq83CYrKnyjc k6a+8J3f32nz5U2VzXca7N9ufz1a5cCZU8c28y2IGkBd8Sh6LydpgabMnbXn+AvcD/13j70//6Y 9hMXArc+dWfqEWVjv2TnbeJ+P9ONNVnpq/Tu9sWduvcB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/spi/spi-tegra210-quad.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 0b9bc3b7f53a..fd0d532364e2 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1630,7 +1630,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_qspi_remove(struct platform_device *pdev)
+static void tegra_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
@@ -1639,8 +1639,6 @@ static int tegra_qspi_remove(struct platform_device *pdev)
 	free_irq(tqspi->irq, tqspi);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
-
-	return 0;
 }
 
 static int __maybe_unused tegra_qspi_suspend(struct device *dev)
@@ -1714,7 +1712,7 @@ static struct platform_driver tegra_qspi_driver = {
 		.acpi_match_table = ACPI_PTR(tegra_qspi_acpi_match),
 	},
 	.probe =	tegra_qspi_probe,
-	.remove =	tegra_qspi_remove,
+	.remove_new =	tegra_qspi_remove,
 };
 module_platform_driver(tegra_qspi_driver);
 
-- 
2.39.1

