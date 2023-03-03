Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D06A9D1A
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjCCRVE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjCCRVA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102164616A
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-0006Pw-5J; Fri, 03 Mar 2023 18:20:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001bjI-Mf; Fri, 03 Mar 2023 18:20:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001tiX-2O; Fri, 03 Mar 2023 18:20:53 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 11/87] spi: bcm63xx-hsspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:25 +0100
Message-Id: <20230303172041.2103336-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cIYL4YkxlRDO+P3PHca9xkpZ06FkySRtZc1b+XklO4k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAis0kmvv7vFLuqtgI0CtGzOw46olyY4yjEyW9 wiEnal/HxyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrNAAKCRDB/BR4rcrs CSXKCACcxAB7MRzzcvm37+EpPG1FKU8oDgF2gNnA9PaLKr69uc2aQ8vfQlqAclI1jVzv2lj3sFx 0qRQjgU/pn0DFhldjQ1f0O3awGAwwrL10pe3gmJX+EmnKkKkKBzDlyT7xgmTt/4sCj5DnVOfuzq zBZw+3GLrmqn4MEQ8nOfqqZPEWTgSC4QR0d/BKCIG7wLtqL45N27wm0ZTUBtZZ42gcmz98p4Tl+ /h4ojGXHkaMHi5JUVqW0WtGCdAy0NBq67WP5OqbpbI6av6J7V1UlT4Qlp/r7uI8+qm5rMnDWWp+ 8sfAlE2Mq6ey90bnCpNoW9eR3oKnh5cAOFBqDg/iPs+IJOjy
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
 drivers/spi/spi-bcm63xx-hsspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index cd0a6478f5e7..f2708caa2f33 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -878,7 +878,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 }
 
 
-static int bcm63xx_hsspi_remove(struct platform_device *pdev)
+static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
@@ -888,8 +888,6 @@ static int bcm63xx_hsspi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(bs->pll_clk);
 	clk_disable_unprepare(bs->clk);
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -946,7 +944,7 @@ static struct platform_driver bcm63xx_hsspi_driver = {
 		.of_match_table = bcm63xx_hsspi_of_match,
 	},
 	.probe		= bcm63xx_hsspi_probe,
-	.remove		= bcm63xx_hsspi_remove,
+	.remove_new	= bcm63xx_hsspi_remove,
 };
 
 module_platform_driver(bcm63xx_hsspi_driver);
-- 
2.39.1

