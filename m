Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61146A9D6C
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjCCRVp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjCCRVY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658E55052
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-0006k5-3C; Fri, 03 Mar 2023 18:21:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-001blL-Rk; Fri, 03 Mar 2023 18:20:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-001tkA-7P; Fri, 03 Mar 2023 18:20:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 36/87] spi: microchip-core-qspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:50 +0100
Message-Id: <20230303172041.2103336-37-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TY+4UnhTgaVXz3hOuActUGQoANtfkS0l1nNGk0gJEE4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuWWzzNvhL2p7GMZaF5CaagYkEwpwxU5ZAJv ONODTm9de+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrlgAKCRDB/BR4rcrs CYIQB/9ZrF0OG1yobv/duGrJtJqEaqcvRH6h2W6ISjaBxqT2z6MdZq+mywmfKTesM+LpCb0tg8C NgbOUjgsUMuvMj9G5jIwjG3SOYoEcseSydEU3St9QlwTgH1eAnZRw7/d4lB1miyVtQzZpo81Quj n6trGlwoFy293KtBqzGRQTKbLZT/4uAHPXixtIHuBetEk2jvbqrOIeGISl32FvF9jj+m5xkaaeN EXaU0posOFawGEOb8za3eywN7qCndw1z6AbiKMm5MO6lWgwhDM4SsryyhL2gCvQFNG1SV2ILgVA VGG/9NnzSjxI53hd7edsfGcU9UJxilGsU2aj2OgVxbYTNZ/2
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
 drivers/spi/spi-microchip-core-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 19a6a46829f6..4f76ddf97b10 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -566,7 +566,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mchp_coreqspi_remove(struct platform_device *pdev)
+static void mchp_coreqspi_remove(struct platform_device *pdev)
 {
 	struct mchp_coreqspi *qspi = platform_get_drvdata(pdev);
 	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
@@ -575,8 +575,6 @@ static int mchp_coreqspi_remove(struct platform_device *pdev)
 	control &= ~CONTROL_ENABLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
 	clk_disable_unprepare(qspi->clk);
-
-	return 0;
 }
 
 static const struct of_device_id mchp_coreqspi_of_match[] = {
@@ -591,7 +589,7 @@ static struct platform_driver mchp_coreqspi_driver = {
 		.name = "microchip,coreqspi",
 		.of_match_table = mchp_coreqspi_of_match,
 	},
-	.remove = mchp_coreqspi_remove,
+	.remove_new = mchp_coreqspi_remove,
 };
 module_platform_driver(mchp_coreqspi_driver);
 
-- 
2.39.1

