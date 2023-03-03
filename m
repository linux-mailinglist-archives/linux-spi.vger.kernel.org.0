Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE166A9D5C
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjCCRVg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjCCRVR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD347412
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-0006o0-Jz; Fri, 03 Mar 2023 18:21:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-001bly-JU; Fri, 03 Mar 2023 18:21:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-001tkg-UV; Fri, 03 Mar 2023 18:20:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 44/87] spi: mxs: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:58 +0100
Message-Id: <20230303172041.2103336-45-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5OPK9fmthHTWqfIh12hEoolqfY6MlpVwy7kXcL/POCU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiu11quOf7eXJTfR/iOUu809q+N8kgnEUu/bV 7c9UFIOtD2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrtQAKCRDB/BR4rcrs CR6aCACbtMJQRrXu9ya5MCMowHiH6qzE1JGXX8bF1QW913zDr3QG45KsbBIZeObRBJXcetPyL4k xsyH08KolXxEj3/ZezqUGg1oSkjjq4xztdcl9sy72WWI7w3lWWZ1EeQdLofwoYK78QeMgHgbmY0 Sx74yuOhiMST1Dv6HKuo5vRbkj/Tr7lJIc12P4OpwWMp9ecOCfbWWA8rMCR7F43KKmUXfH6IfX7 3lmSRVsmy3/ynJ7pX+vRqQ3siUxtX4jSdfK+JH4OSMNlDtlPusWWWQ0lJzXLnc1QTDQSxwSI3Qp GYgZOk5S6hOgK4CfP7rDUfzGMbIjj3T8+hdBp2x9nkHlBZyv
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
 drivers/spi/spi-mxs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 55178579f3c6..10fb31a5e409 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -638,7 +638,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxs_spi_remove(struct platform_device *pdev)
+static void mxs_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master;
 	struct mxs_spi *spi;
@@ -653,13 +653,11 @@ static int mxs_spi_remove(struct platform_device *pdev)
 		mxs_spi_runtime_suspend(&pdev->dev);
 
 	dma_release_channel(ssp->dmach);
-
-	return 0;
 }
 
 static struct platform_driver mxs_spi_driver = {
 	.probe	= mxs_spi_probe,
-	.remove	= mxs_spi_remove,
+	.remove_new = mxs_spi_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.of_match_table = mxs_spi_dt_ids,
-- 
2.39.1

