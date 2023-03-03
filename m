Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D426A9D2F
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjCCRVO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjCCRVF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CE4391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-0006jK-SB; Fri, 03 Mar 2023 18:20:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-001blA-Ey; Fri, 03 Mar 2023 18:20:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001tk1-Nq; Fri, 03 Mar 2023 18:20:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 34/87] spi: meson-spicc: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:48 +0100
Message-Id: <20230303172041.2103336-35-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wIKxT+p09a0fMoGZJNJn4gwEKy4eROv6P/ZQUF4MM+k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuOf9Ck8KGreXQk8ppcZGL96mgVOkKETYFH2 8xtL7oh4z6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrjgAKCRDB/BR4rcrs CWQSB/9bLoPdSsOw65mZJnhNRlSUBlLizDd9TirYEdQHZfdFcOVvkknt9iZgPuk/FYZjWFuI6ms buMjzYfy0p+hYrUr51QImPSpCKWC6PYboFaZ/x4TVWAVKNrd3S/rxkOiZb22E7gjEn3uMXnopPu M8a56KZABV97BXO2hjYLtE1DHJytSPEqK5lRN3coI5A848+uSZBmw/0NkYk9ZjP+orcm66ArLW9 RRNN/vU6rH7z+ek080wVoJkLBln5u1eFo6sH4qUAsbdBljEuT4cMU63VLi35k4a3bYPe2aXacNp 2/lSrSXiuJ6m9PB5n4L4wkobMS4nAlJt/0UIz5czGmGXXzS+
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
 drivers/spi/spi-meson-spicc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index d47f2623a60f..b9f812837cd6 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -910,7 +910,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_spicc_remove(struct platform_device *pdev)
+static void meson_spicc_remove(struct platform_device *pdev)
 {
 	struct meson_spicc_device *spicc = platform_get_drvdata(pdev);
 
@@ -921,8 +921,6 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spicc->pclk);
 
 	spi_master_put(spicc->master);
-
-	return 0;
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
@@ -967,7 +965,7 @@ MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
 
 static struct platform_driver meson_spicc_driver = {
 	.probe   = meson_spicc_probe,
-	.remove  = meson_spicc_remove,
+	.remove_new = meson_spicc_remove,
 	.driver  = {
 		.name = "meson-spicc",
 		.of_match_table = of_match_ptr(meson_spicc_of_match),
-- 
2.39.1

