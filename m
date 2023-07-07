Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3161E74AB9D
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jul 2023 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGGHLa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Jul 2023 03:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjGGHLa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Jul 2023 03:11:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C0D1BF0
        for <linux-spi@vger.kernel.org>; Fri,  7 Jul 2023 00:11:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qHfch-0000sW-Ux; Fri, 07 Jul 2023 09:11:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qHfcg-00CgDx-SI; Fri, 07 Jul 2023 09:11:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qHfcg-002wew-7F; Fri, 07 Jul 2023 09:11:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] spi: rzv2m-csi: Convert to platform remove callback returning void
Date:   Fri,  7 Jul 2023 09:11:19 +0200
Message-Id: <20230707071119.3394198-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UEu07T9duR5n0Ql4mzxZvQzd0Ej4JAA2xG6nbevH5Aw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkp7qWT3aWAYgZu4oBQp8QiaHRzjraiBti4rmJ2 siT5b6IifGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKe6lgAKCRCPgPtYfRL+ Tg7CCACQAcoTmDXrEx9X7XjdoD6uZjG7SD53RR1Rka7oDt4R1eJyicQI9GzDVgcbsvwxxFFxB62 yhhhSWJOmkmkYyX0Q19nSC3m4uayOSNW2GPdr/cRDLnwSyeMibkNNzurV28ensM2Jykj4K0g4zy XnP3wtWoXleMwe0KqkcHfwE7Q9citPTN5WtVAazLBVPGx1649/FeantQRkr0eWgkWyu8UMwfYiD wFcRZgEsmSTXo/F1hz4JdmF9181TJ5sDUV1CClAfsUeBWXOhdqinsdoYyeKnvltRQvGJxdfWAzb Rx/LfdI12tTRKDhtekTSJ/G85F5qmRHNbNmEDgwMvK8xx+As
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-rzv2m-csi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index 14ad65da930d..c0d9a776770f 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -635,15 +635,13 @@ static int rzv2m_csi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rzv2m_csi_remove(struct platform_device *pdev)
+static void rzv2m_csi_remove(struct platform_device *pdev)
 {
 	struct rzv2m_csi_priv *csi = platform_get_drvdata(pdev);
 
 	spi_unregister_controller(csi->controller);
 	rzv2m_csi_sw_reset(csi, 1);
 	clk_disable_unprepare(csi->csiclk);
-
-	return 0;
 }
 
 static const struct of_device_id rzv2m_csi_match[] = {
@@ -654,7 +652,7 @@ MODULE_DEVICE_TABLE(of, rzv2m_csi_match);
 
 static struct platform_driver rzv2m_csi_drv = {
 	.probe = rzv2m_csi_probe,
-	.remove = rzv2m_csi_remove,
+	.remove_new = rzv2m_csi_remove,
 	.driver = {
 		.name = "rzv2m_csi",
 		.of_match_table = rzv2m_csi_match,

base-commit: 5133c9e51de41bfa902153888e11add3342ede18
-- 
2.39.2

