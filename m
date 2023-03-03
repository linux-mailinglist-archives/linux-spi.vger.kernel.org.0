Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73B46A9D3E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjCCRVW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjCCRVL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9351D4DBC1
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-0006S3-SE; Fri, 03 Mar 2023 18:20:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-001bjW-Bd; Fri, 03 Mar 2023 18:20:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001tie-Ga; Fri, 03 Mar 2023 18:20:53 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Zhang <william.zhang@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 13/87] spi: bcmbca-hsspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:27 +0100
Message-Id: <20230303172041.2103336-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dkFLbpKu3gdfD/IQ0PyTwhiBt9srbLQF17HVBoJMQoA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAis8wnpaw7eSOBRHP85D5wFXY/XM5gtpMXElV DZ582MvTraJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrPAAKCRDB/BR4rcrs CeUtB/4ijuu7UDvtgyLrpDkL11JXbUMp0gkDj0DF38kb7Qq6KwJeRPbu9J1RdYt5OlNBbBS6C/P PqBiJpByMvvB6IQq7G64d7/QGDqeVn3O9cEShBTT1zJQtU7JkLzo+rZRIsgaK1rBLbyt4JCkkaA 0aj1aW+kOVYI7agdo7G3CxY5CkWP/Bz1cfy9XHwjQ6zwlepLT3KHWP2t0AKBcsu3guil+3oiM9w o3Y1EM2CHUu/oIdDmSxQG3sX1uA9evP6ccPmN7m7la6at8AAcFvZMf8cqWw9YpS4z6TGMhvRyR/ RWHpInfJt7NN7HNEDUNvoEVQ2vUVYUBfnj7nOJPclNjhnT/t
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
 drivers/spi/spi-bcmbca-hsspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 3f9e6131ad86..c7a44832bc9c 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -576,7 +576,7 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcmbca_hsspi_remove(struct platform_device *pdev)
+static void bcmbca_hsspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
@@ -586,8 +586,6 @@ static int bcmbca_hsspi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(bs->pll_clk);
 	clk_disable_unprepare(bs->clk);
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -644,7 +642,7 @@ static struct platform_driver bcmbca_hsspi_driver = {
 		   .of_match_table = bcmbca_hsspi_of_match,
 		   },
 	.probe = bcmbca_hsspi_probe,
-	.remove = bcmbca_hsspi_remove,
+	.remove_new = bcmbca_hsspi_remove,
 };
 
 module_platform_driver(bcmbca_hsspi_driver);
-- 
2.39.1

