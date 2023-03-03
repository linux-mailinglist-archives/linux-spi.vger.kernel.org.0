Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819016A9D21
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCCRVI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjCCRVB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322404614F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-0006a2-QO; Fri, 03 Mar 2023 18:20:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001bkU-IM; Fri, 03 Mar 2023 18:20:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001tjP-SS; Fri, 03 Mar 2023 18:20:55 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 25/87] spi: fsl-espi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:39 +0100
Message-Id: <20230303172041.2103336-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fRRmTcKO5fDRcWLdl9DEjguSkmENu0zaEHzJcgRgX9A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitrmP39+VbD92KP1siZYtP+ORxiYuIPu8HXZ lQcC5wRoKyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrawAKCRDB/BR4rcrs CcF/B/4kORa4550x65Aec5dCdU66oTrFsDuhvHVE0PbZvVu6Qdjivtk5ZUTQ0XHUzAuTakt1Kgc oW7hhh35o1pxJq356eOE9tEKDSnOiKw0rIA2Y3q1LXfm5c7boEIoBF1U6bI0YidhKIgLI4lpK9q biD6EvkKuaSTP04rvKZ0S8Gm0mub4XIs2f97OTx6pSjE+i+xrwCQUvaGyDCjd8coO10ZAzMnepX eJRgvwVgPBASuo13v18Y1w1GstVLS+16xlZdYcWeoAt9cuFHcWAiHfVEmjTDkJ5Itp2r5XM0lej 97/7Gnr+f1eNch0IWep1Mg6zrRN3Z6JBhA8DNuXC+nAr/BTZ
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
 drivers/spi/spi-fsl-espi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f7066bef7b06..42a3ed79e7dc 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -783,11 +783,9 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 	return fsl_espi_probe(dev, &mem, irq, num_cs);
 }
 
-static int of_fsl_espi_remove(struct platform_device *dev)
+static void of_fsl_espi_remove(struct platform_device *dev)
 {
 	pm_runtime_disable(&dev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -837,7 +835,7 @@ static struct platform_driver fsl_espi_driver = {
 		.pm = &espi_pm,
 	},
 	.probe		= of_fsl_espi_probe,
-	.remove		= of_fsl_espi_remove,
+	.remove_new	= of_fsl_espi_remove,
 };
 module_platform_driver(fsl_espi_driver);
 
-- 
2.39.1

