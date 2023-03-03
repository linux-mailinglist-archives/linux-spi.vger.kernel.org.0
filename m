Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235F26A9D3F
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjCCRVX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjCCRVL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A0E4D62C
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-0006yw-Mb; Fri, 03 Mar 2023 18:21:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-001bnE-QV; Fri, 03 Mar 2023 18:21:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-001tlc-QN; Fri, 03 Mar 2023 18:21:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 59/87] spi: rockchip: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:13 +0100
Message-Id: <20230303172041.2103336-60-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OmQ12uht8IWlDyauzXhSL2XViaI0ICmiBz/+eTBWyf4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivwwXz9uomS2WWf/vdPN4WnOrhcDT0sutXWv xQEsEcj8FWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr8AAKCRDB/BR4rcrs CchTB/9Cy3Sbh53UV3ob62jodXiRh/CIKWsQH9D12P9G+M+z5/BfO5xRodY6wK1kS2klGV6tbVG l9d1DMjddgR8KSpou08TP3nI/LOrdO5xNr/jO7jEscJ1smQT4PBTw3386tOg2F+t8Xl3Q3yiHlL ueO/4tjj7D0FYYpTn5qXoBT1L2NBmPvU7k0KHetB1715NmZCPoK7amCPDmBHoEpH3mIx5B7E8Fg IeMQDqHNZKZ8+JVegL/YYkXbUYr+qbh4VpYkchuck8ikPngQwnVCtH61xnwqj8ll/5G3lQXMmMu qpDC+qYlMtVAkmrf6AWfKnn5G9zawZtJOvHV3JnbrD+BEEOn
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
 drivers/spi/spi-rockchip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 79242dc5272d..8888a5ff7b2f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -947,7 +947,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rockchip_spi_remove(struct platform_device *pdev)
+static void rockchip_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = spi_controller_get(platform_get_drvdata(pdev));
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
@@ -967,8 +967,6 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 		dma_release_channel(ctlr->dma_rx);
 
 	spi_controller_put(ctlr);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1076,7 +1074,7 @@ static struct platform_driver rockchip_spi_driver = {
 		.of_match_table = of_match_ptr(rockchip_spi_dt_match),
 	},
 	.probe = rockchip_spi_probe,
-	.remove = rockchip_spi_remove,
+	.remove_new = rockchip_spi_remove,
 };
 
 module_platform_driver(rockchip_spi_driver);
-- 
2.39.1

