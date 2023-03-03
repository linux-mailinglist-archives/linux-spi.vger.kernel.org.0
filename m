Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024796A9D1B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjCCRVF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjCCRVA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA447410
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-0006Pu-5Q; Fri, 03 Mar 2023 18:20:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001bjH-ME; Fri, 03 Mar 2023 18:20:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-001tiP-MO; Fri, 03 Mar 2023 18:20:52 +0100
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
Subject: [PATCH 09/87] spi: bcm2835: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:23 +0100
Message-Id: <20230303172041.2103336-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IwMtpVogMLCOnqG7xyZOf1yVAVJAMlhznRPZfWS20qU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAistaibZ8u12RA+5ZlvyXrNsVYAw21v6yE1O2 jwrIwgu80SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrLQAKCRDB/BR4rcrs CZDcB/0R7//E1eL+cLL7rtUtyygZCxAKAITisyDBy+vtPSEyvOBfwK7oDv/H8mZHFgmWqG0vLQk dZ5N9Fzwj5hBR8yulTkZM9wd3sDX07lgXwpqQqqnslEMiAwLo59iNO6cJqqlfsbWoBe9jjqZVti Wu9SQzQ/Ame/Ei+EkUU9eHnDiOrZcNJhF4kUIpw5hhu206hAZ6kfBZg4SnmyEM5iyUndm7fffPX ROBctkqI5ZPBuvxhwCvZvGkgJU+pK4njWoJPMNhk+pZqG8iUHC06ZBQLG6LJVNjpiJ8fK8ygXkt j0kLPcAJZgdxg6+5EO3xqc1DTvvd0PPuUzHwtIl06MN6NVms
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
 drivers/spi/spi-bcm2835.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 747e03228c48..be6050b513a9 100644
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
@@ -1414,17 +1414,11 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
 
 	clk_disable_unprepare(bs->clk);
-
-	return 0;
 }
 
 static void bcm2835_spi_shutdown(struct platform_device *pdev)
 {
-	int ret;
-
-	ret = bcm2835_spi_remove(pdev);
-	if (ret)
-		dev_err(&pdev->dev, "failed to shutdown\n");
+	rbcm2835_spi_remove(pdev);
 }
 
 static const struct of_device_id bcm2835_spi_match[] = {
@@ -1439,7 +1433,7 @@ static struct platform_driver bcm2835_spi_driver = {
 		.of_match_table	= bcm2835_spi_match,
 	},
 	.probe		= bcm2835_spi_probe,
-	.remove		= bcm2835_spi_remove,
+	.remove_new	= bcm2835_spi_remove,
 	.shutdown	= bcm2835_spi_shutdown,
 };
 module_platform_driver(bcm2835_spi_driver);
-- 
2.39.1

