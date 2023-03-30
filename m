Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9356D1086
	for <lists+linux-spi@lfdr.de>; Thu, 30 Mar 2023 23:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjC3VKn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Mar 2023 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjC3VKh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 17:10:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28BBDBE6
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 14:10:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzXR-0002y0-Ok; Thu, 30 Mar 2023 23:10:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzXP-007qWF-SS; Thu, 30 Mar 2023 23:10:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzXP-009HsL-4z; Thu, 30 Mar 2023 23:10:27 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH v2] spi: bcm2835: Convert to platform remove callback returning void
Date:   Thu, 30 Mar 2023 23:10:22 +0200
Message-Id: <20230330211022.2460233-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2653; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ZhAUudA9WfOELx7uGLFyVnLeSfqR9L8Bm4dCEnyz+js=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkJfq6fWmY+RhZsE+chVzdYYhqoa/7AZHg6EQ3U oW35u2NxdmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZCX6ugAKCRCPgPtYfRL+ Tl+hB/wP1sRLFJQ97VWmZN09A+JF4hIBhStkPhljbKs0n3OKGcPceW/rhoS3rWb+pluMx2q7WOM dqI0L+hPxqvV+J6z/lkLOrbzBXqCCXEqcYeeNE/MWKCdpH47hTnH58r7d+BjP23NpFOzAJ8pfxx Szz93IqRDeVZ7yaJpDqiOnJ67esFTwbYUyQc5ZlyIdElZV0kFyNOPfPzRR112LZhGp+F5sey38h UrdcL7AK2lJfDo/0H9TECyPrhOMqY9dOlFFnm15uzV1tlZBaNG/IV0DNhuBhjpb7XiCDnAQqwnq UD904LtISaYKQG9nosoOem78JNMXaCKk3ghYUq3qficpQ/mQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Convert this driver from always returning zero in the remove callback to
the void returning variant.

Now that bcm2835_spi_remove returns no error code any more,
bcm2835_spi_shutdown() does the same thing as bcm2835_spi_remove(). So
drop the shutdown function and use bcm2835_spi_remove() as .shutdown
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

(implicit) v1 of this patch was sent in the big conversion series for
(nearly) all spi drivers at https://lore.kernel.org/linux-spi/20230303172041.2103336-1-u.kleine-koenig@pengutronix.de

Unfortunately the patch sent there broke compilation. So here is a v2
that is compile tested without uncommitted changes in the tree.

Best regards
Uwe

 drivers/spi/spi-bcm2835.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 747e03228c48..215b4a02166d 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1398,7 +1398,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int bcm2835_spi_remove(struct platform_device *pdev)
+static void bcm2835_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
@@ -1414,17 +1414,6 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
 	clk_disable_unprepare(bs->clk);
-
-	return 0;
-}
-
-static void bcm2835_spi_shutdown(struct platform_device *pdev)
-{
-	int ret;
-
-	ret = bcm2835_spi_remove(pdev);
-	if (ret)
-		dev_err(&pdev->dev, "failed to shutdown\n");
 }
 
 static const struct of_device_id bcm2835_spi_match[] = {
@@ -1439,8 +1428,8 @@ static struct platform_driver bcm2835_spi_driver = {
 		.of_match_table	= bcm2835_spi_match,
 	},
 	.probe		= bcm2835_spi_probe,
-	.remove		= bcm2835_spi_remove,
-	.shutdown	= bcm2835_spi_shutdown,
+	.remove_new	= bcm2835_spi_remove,
+	.shutdown	= bcm2835_spi_remove,
 };
 module_platform_driver(bcm2835_spi_driver);
 
-- 
2.39.2

