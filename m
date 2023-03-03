Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A866A9D18
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjCCRVD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjCCRU7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C416746173
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-0006Pn-5V; Fri, 03 Mar 2023 18:20:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001bjE-IT; Fri, 03 Mar 2023 18:20:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-001tiT-SM; Fri, 03 Mar 2023 18:20:52 +0100
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
Subject: [PATCH 10/87] spi: bcm2835aux: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:24 +0100
Message-Id: <20230303172041.2103336-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HxAnckGiKCzLyuvEabwpYpwqx3PhdazBpsbqGFgNiq8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiswmCk4qX4t3FwuHOS1qSI8PclnobVBljdiM JknUjs9fCuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrMAAKCRDB/BR4rcrs CUSkB/98/B9X+QfXjlY0qOtyGGgOPExlSNt0EVtwMnImk3a6h9h0EMflCO2Y5nqTcm4lET7EYVY /9b8hlvUsPXYZSla09FZU9NXVmvo7AA0YJwONp+ecSp22u9oQB63YLbrjoMFSAQae5wdjB1c/PA X76wUZv+o4+uF5h9h/M1feDkU4nDz13Mih2jM0zObxijcxDBVlphllZr0eMJvnTDHdGIubvxkKG olcFSX/gTdRDIjAu8D6xNCzDKekQYsUbcluspKu2ZToVcKSUdO1hoOWSVpjBmizcW4A/8KWSDug GtkYjVchlBH0q0+qwrm6BXkm1eIgUw1pz/FeHK0ZvEfBh+jh
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
 drivers/spi/spi-bcm2835aux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index e28521922330..7f2546fd900a 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -567,7 +567,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int bcm2835aux_spi_remove(struct platform_device *pdev)
+static void bcm2835aux_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
@@ -580,8 +580,6 @@ static int bcm2835aux_spi_remove(struct platform_device *pdev)
 
 	/* disable the HW block by releasing the clock */
 	clk_disable_unprepare(bs->clk);
-
-	return 0;
 }
 
 static const struct of_device_id bcm2835aux_spi_match[] = {
@@ -596,7 +594,7 @@ static struct platform_driver bcm2835aux_spi_driver = {
 		.of_match_table	= bcm2835aux_spi_match,
 	},
 	.probe		= bcm2835aux_spi_probe,
-	.remove		= bcm2835aux_spi_remove,
+	.remove_new	= bcm2835aux_spi_remove,
 };
 module_platform_driver(bcm2835aux_spi_driver);
 
-- 
2.39.1

