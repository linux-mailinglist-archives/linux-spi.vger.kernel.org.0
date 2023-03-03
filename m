Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5E6A9D62
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCCRVk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjCCRVS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332424DBC1
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95i-0007Bx-4s; Fri, 03 Mar 2023 18:21:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-001bpE-QS; Fri, 03 Mar 2023 18:21:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-001tnB-Tv; Fri, 03 Mar 2023 18:21:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 83/87] spi: uniphier: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:37 +0100
Message-Id: <20230303172041.2103336-84-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WCJcpXLjYNcutqOQiSyWeJfVx4NI9iM787/Q1khNnjY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAixSCO4nDQe9R7uWiDtH9Ty06s5hRAo3fjkkk Thjg/AzEMaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsUgAKCRDB/BR4rcrs CSrTB/wJ4VDTDnsleRQc4gRJBOZi4wLNWq2Fs2psyrdtMm493VhdBYatAwl/YztiJgNVvNt20UA pprb9Sky4VM8R+U52jr3YRQrKNz7SXs0KOVbW/Nihw4foeXjqGDtGsxUAXev+WY3X+rP/JSlP65 NA4I5uo3KStT6NPOe16QZ3a9aDLpF6InzTiXI2DURSlyaLRTv6UntSKCQw4HvE+3IRp96jCZA/I Y7OKTUnXUGm1Nhz3md7WnJbPi5eUdR2uDFllwWyhAdR0PQE4rNwnLAR8jrxC0V5CeA19uJcJQoP +U7AiLDNMtPHiXTgphuVRpptDbmbdu+p3Gg1H98e8J//76a4
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
 drivers/spi/spi-uniphier.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index cc0da4822231..f5344527af0b 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -775,7 +775,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int uniphier_spi_remove(struct platform_device *pdev)
+static void uniphier_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
@@ -786,8 +786,6 @@ static int uniphier_spi_remove(struct platform_device *pdev)
 		dma_release_channel(master->dma_rx);
 
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static const struct of_device_id uniphier_spi_match[] = {
@@ -798,7 +796,7 @@ MODULE_DEVICE_TABLE(of, uniphier_spi_match);
 
 static struct platform_driver uniphier_spi_driver = {
 	.probe = uniphier_spi_probe,
-	.remove = uniphier_spi_remove,
+	.remove_new = uniphier_spi_remove,
 	.driver = {
 		.name = "uniphier-spi",
 		.of_match_table = uniphier_spi_match,
-- 
2.39.1

