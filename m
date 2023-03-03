Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7086A9D06
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjCCRU5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCCRU4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358243937
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-0006P5-8r; Fri, 03 Mar 2023 18:20:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-001biu-Li; Fri, 03 Mar 2023 18:20:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95P-001ti9-V8; Fri, 03 Mar 2023 18:20:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 05/87] spi: ath79: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:19 +0100
Message-Id: <20230303172041.2103336-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XrvfGGtDEIh3ylCBBK+aJfWuAsikUFg8ITaaa06tIYQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAise0Iuiz9Hgoa+p21/E89rb2te73hpy0avem xdMbZE42PCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrHgAKCRDB/BR4rcrs CXNtCACRuxch7TyEL9P50m7umDaQvEimDBgVvZhBEfxCgjT7op23hRObcACHN8Ewspzlpcidm8R O7/sOkr5YowT5bonj9sSRvQzB7Lq514Y7j7SzXcK7X0RIhXGstvdKINEhM78P5MzsaxsynbJsJ4 s+JBmv7auTd2pVts5TDQxE5HQwE4pWjIOfShjM9lJiQosmyNzp/S6M0StvjKZ4ZjyCPGcxkDkI9 ra3FTNY6uJe24i/dGwRfHlLVDI+I2IzaMWpJCASThqdLdTpN6QcNOIUzb80p2uXbKZXqaY3IkKn 8/tuqzeKPcGPAVh/nf5JS6QCxAENwodPGJ+ca7j4Np5sQr5y
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
 drivers/spi/spi-ath79.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 795e88dbef1b..b4d25b3bee19 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -237,7 +237,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ath79_spi_remove(struct platform_device *pdev)
+static void ath79_spi_remove(struct platform_device *pdev)
 {
 	struct ath79_spi *sp = platform_get_drvdata(pdev);
 
@@ -245,8 +245,6 @@ static int ath79_spi_remove(struct platform_device *pdev)
 	ath79_spi_disable(sp);
 	clk_disable_unprepare(sp->clk);
 	spi_controller_put(sp->bitbang.master);
-
-	return 0;
 }
 
 static void ath79_spi_shutdown(struct platform_device *pdev)
@@ -262,7 +260,7 @@ MODULE_DEVICE_TABLE(of, ath79_spi_of_match);
 
 static struct platform_driver ath79_spi_driver = {
 	.probe		= ath79_spi_probe,
-	.remove		= ath79_spi_remove,
+	.remove_new	= ath79_spi_remove,
 	.shutdown	= ath79_spi_shutdown,
 	.driver		= {
 		.name	= DRV_NAME,
-- 
2.39.1

