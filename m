Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E28E6A9D2E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjCCRVO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjCCRVF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510F46173
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-0006jk-PT; Fri, 03 Mar 2023 18:20:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-001blH-KZ; Fri, 03 Mar 2023 18:20:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001tk5-UR; Fri, 03 Mar 2023 18:20:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 35/87] spi: meson-spifc: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:49 +0100
Message-Id: <20230303172041.2103336-36-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=V5nExC369g9w2BPhMLN/ksgUEQ4NdUM7PLbWh6nlt/U=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuTxhgFrMMlWot5x24gJMir9kRj+snNI1jGR Z+3CRX7itaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrkwAKCRDB/BR4rcrs CZl0CACI68St2Bf6RIQ770thnASVOLSkjCSsiGDyaF+/7W/w6EbUczZMf3H2nkSuc8ZGECJaO25 fub+Tq8nvXK4i0fJyAkyJ+CfOfvMxSeFKwHw12QQN2O2yxWm95foQXpMlmSFOD87rb8IENFIMcM aQQoVWrlBs5Ot8I+jfZhZBc+jUkY8IcpHzYcOKAvKkA7s3wKXbPsrLIZsLSzra9CMtvfPmMkrJg JNf/mdx+GeL9mx1VUeLScIs2DRDOiLPuLvCbzlV5Iq4QMuoh/ajurf+r2+s0glY3Kxq4TZugzX+ GpFDcSgWwD4LSL7iqc9IEdpIhao0l0FDhXGHF5Z0y/CazkRN
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
 drivers/spi/spi-meson-spifc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index c8ed7815c4ba..06626f406f68 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -355,7 +355,7 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_spifc_remove(struct platform_device *pdev)
+static void meson_spifc_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct meson_spifc *spifc = spi_master_get_devdata(master);
@@ -363,8 +363,6 @@ static int meson_spifc_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spifc->clk);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -442,7 +440,7 @@ MODULE_DEVICE_TABLE(of, meson_spifc_dt_match);
 
 static struct platform_driver meson_spifc_driver = {
 	.probe	= meson_spifc_probe,
-	.remove	= meson_spifc_remove,
+	.remove_new = meson_spifc_remove,
 	.driver	= {
 		.name		= "meson-spifc",
 		.of_match_table	= of_match_ptr(meson_spifc_dt_match),
-- 
2.39.1

