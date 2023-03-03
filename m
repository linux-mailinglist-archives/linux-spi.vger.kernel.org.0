Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF826A9D1D
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjCCRVG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCCRVB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49AB4392E
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-0006YA-9U; Fri, 03 Mar 2023 18:20:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001bkF-63; Fri, 03 Mar 2023 18:20:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001tjI-HY; Fri, 03 Mar 2023 18:20:55 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 23/87] spi: ep93xx: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:37 +0100
Message-Id: <20230303172041.2103336-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=gGENnXa5K3SeofjaHQbQSrqdZm1uOjLI2C8msiWktNo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitiQbweGwzQqMjRWEAaWOj1g8PyWy4zqejRE AqjxoWtqyiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrYgAKCRDB/BR4rcrs CYt3CACfDQd2DoCChZezNmy+pSqDrqPdqEoHOACPty3dvuxn/0S0xRoLW5MfmS78Zl6IrzP1ffp 5afBlz88ye5GuvtMQpJWpJj943JmRv0hIYcuwM0ZDPMEGBFuB0LvAZQKkQLlL4rR6SWWzd5ktI+ o7OvOfj3gloCmn/K0pHvv8iftOMxHk4dB+D/c9PRSVWSOjjWF1Xdik08qZ67eA8R5l0wBmqMce6 vlGXBg9HYCJM9uVhW/Vy3pHHAtaWsIbY89XWTdPK+LAyd6+BfbjGWBZyyZNL28hlZ3wA/DCP3Bx yGbuiHjFK8b5f2AKHRBBm1nGmzJrBsTxBzUeQ9Z9/HjW0z9s
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
 drivers/spi/spi-ep93xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 5896a7b2fade..1615fd22f9a2 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -745,14 +745,12 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int ep93xx_spi_remove(struct platform_device *pdev)
+static void ep93xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 
 	ep93xx_spi_release_dma(espi);
-
-	return 0;
 }
 
 static struct platform_driver ep93xx_spi_driver = {
@@ -760,7 +758,7 @@ static struct platform_driver ep93xx_spi_driver = {
 		.name	= "ep93xx-spi",
 	},
 	.probe		= ep93xx_spi_probe,
-	.remove		= ep93xx_spi_remove,
+	.remove_new	= ep93xx_spi_remove,
 };
 module_platform_driver(ep93xx_spi_driver);
 
-- 
2.39.1

