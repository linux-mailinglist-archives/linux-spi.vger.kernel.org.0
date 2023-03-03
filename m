Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD19A6A9D55
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCCRVc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCCRVP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650D4391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-0006P1-CX; Fri, 03 Mar 2023 18:20:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-001bin-FD; Fri, 03 Mar 2023 18:20:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95P-001ti5-PX; Fri, 03 Mar 2023 18:20:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 04/87] spi: at91-usart: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:18 +0100
Message-Id: <20230303172041.2103336-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SGTH7dP1xdrOjceXNC+FsmDr8gaZPzgN2ggj7NJLIyg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAisac5mxvotOLoUtJia2rcQeOrDI9GGAI5NoY UDlaMgbpXKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrGgAKCRDB/BR4rcrs CQDPCACACaDXYziUUldTQvFnJHv2N/lK3otYlI4b7uVeH2GqgV/m0PHCvdlJQhZ9WKesTK/AuG4 MnZrvMy0J5htNRY5CPDcvUQYJBUYzehhX+KARQuGbcd18BP+jEf2to5hVumB3/2b9uRmlH/pyrV vlswhRCeTfAMSq8+3WzvB543/Vb7VneX9+MigJlRQj6LsVOfJt05vQeNJg/uy08gGoWOrOBbruU VaXoMrPwOMIxwpQk1jU7nE5kRNnyEu+/l1tHV/7E/JzvWCe1KQlGnH/y03Kc4KVUgC1IK6so2UF /n9aL9IttItCRb9BH1BYS7ulY1fldb8VHBACB0DptV+6zS01
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
 drivers/spi/spi-at91-usart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index fab9d223e24a..4fb3653b5941 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -647,15 +647,13 @@ __maybe_unused static int at91_usart_spi_resume(struct device *dev)
 	return spi_controller_resume(ctrl);
 }
 
-static int at91_usart_spi_remove(struct platform_device *pdev)
+static void at91_usart_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 
 	at91_usart_spi_release_dma(ctlr);
 	clk_disable_unprepare(aus->clk);
-
-	return 0;
 }
 
 static const struct dev_pm_ops at91_usart_spi_pm_ops = {
@@ -670,7 +668,7 @@ static struct platform_driver at91_usart_spi_driver = {
 		.pm = &at91_usart_spi_pm_ops,
 	},
 	.probe = at91_usart_spi_probe,
-	.remove = at91_usart_spi_remove,
+	.remove_new = at91_usart_spi_remove,
 };
 
 module_platform_driver(at91_usart_spi_driver);
-- 
2.39.1

