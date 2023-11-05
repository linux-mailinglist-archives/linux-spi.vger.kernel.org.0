Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23E47E1574
	for <lists+linux-spi@lfdr.de>; Sun,  5 Nov 2023 18:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjKER05 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 5 Nov 2023 12:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKER04 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 5 Nov 2023 12:26:56 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D7FCC
        for <linux-spi@vger.kernel.org>; Sun,  5 Nov 2023 09:26:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzgtg-0007lh-DC; Sun, 05 Nov 2023 18:26:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzgtf-006q9E-N8; Sun, 05 Nov 2023 18:26:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qzgtf-00DE7g-Bg; Sun, 05 Nov 2023 18:26:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH] spi: spi-ti-qspi: Convert to platform remove callback returning void
Date:   Sun,  5 Nov 2023 18:26:50 +0100
Message-ID: <20231105172649.3738556-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2833; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RfSLjq6v+zcRFVJ1M0dnkcVyE/SNatHmpAUAqvuvrPg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlR9BZGDFZJ/o8SvBDYxeB05V5n6pwAzrRb1Ttc 4cqexfpTTuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUfQWQAKCRCPgPtYfRL+ TjhlB/oDYuA2nrZBRNQSvn9jzcuXTTgw2fkZg3Nd+M2UCGn9y7d7DB8fvBBviWpwITZxiprfDCm t+RqxueMj17iYU8889lDqYMiLYPSCSHaytrsBgw+emJhTW7PVNAt/cX/kuY9FTNGCfB9czIfnJv DILI7r+pka0tZPgHF+t9noJCPxpvrLoac9wQEizwSFmNSbMhz9/H7Vf8ImOGIT/gjqoMLmYe900 sBcz8WBHDFbcz/NpUl65ZBhXQRBfU3jD+Uatad+HWsE9oV7ZWg2rs9+iwWX7T1OBoheUgr5m6zr e+CV8crlIBa0xbC+dOB1gNHRMpI92+66q/bx5s3s/tNW+4d6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Add an error message to the error path that returned an error before to
replace the core's error message with more information. Apart from the
different wording of the error message, this patch doesn't introduce a
semantic difference.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I'm unsure if calling spi_master_suspend() in .remove() is right, all
other drivers only call it in their suspend callback. Also note that
after spi_master_suspend() failed ti_qspi_dma_cleanup() isn't called
which is probably another problem resulting in resource leaks or even
possible use-after-free bugs. The fix for both is maybe to just drop
calling spi_master_suspend()?!

This call was introduced in commit 3ac066e2227c ("spi: spi-ti-qspi:
Suspend the queue before removing the device"). The commit description
suggests a bug fix that sounds like something the spi core should do
right without each individual driver caring.

Best regards
Uwe

 drivers/spi/spi-ti-qspi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 4c81516b67db..fdc092a05284 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -907,21 +907,22 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_qspi_remove(struct platform_device *pdev)
+static void ti_qspi_remove(struct platform_device *pdev)
 {
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
 	int rc;
 
 	rc = spi_master_suspend(qspi->master);
-	if (rc)
-		return rc;
+	if (rc) {
+		dev_alert(&pdev->dev, "spi_master_suspend() failed (%pe)\n",
+			  ERR_PTR(rc));
+		return;
+	}
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);
-
-	return 0;
 }
 
 static const struct dev_pm_ops ti_qspi_pm_ops = {
@@ -930,7 +931,7 @@ static const struct dev_pm_ops ti_qspi_pm_ops = {
 
 static struct platform_driver ti_qspi_driver = {
 	.probe	= ti_qspi_probe,
-	.remove = ti_qspi_remove,
+	.remove_new = ti_qspi_remove,
 	.driver = {
 		.name	= "ti-qspi",
 		.pm =   &ti_qspi_pm_ops,

base-commit: e27090b1413ff236ca1aec26d6b022149115de2c
-- 
2.42.0

