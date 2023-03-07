Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9239F6AF74F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 22:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCGVOr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 16:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCGVOn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 16:14:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B34497FEC
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 13:14:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedk-0002H3-SL; Tue, 07 Mar 2023 22:14:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedk-002ZBh-6D; Tue, 07 Mar 2023 22:14:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedj-0037Bf-4y; Tue, 07 Mar 2023 22:14:31 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] spi: sprd: Convert to platform remove callback returning void
Date:   Tue,  7 Mar 2023 22:14:26 +0100
Message-Id: <20230307211426.2331483-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307211426.2331483-1-u.kleine-koenig@pengutronix.de>
References: <20230307211426.2331483-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YPFkC8LbJTZ62SB1NzUdiepQYlXhcdM1O1GBIgnlyvI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkB6ktAM0RHU/YY1KZWX7SqkHtzNKkAbnAK4DFX sXA0BiMzGWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAepLQAKCRDB/BR4rcrs CVcTB/4rzCb4dMtLnwrgIY0CxHfdhk+TJm6o9IBrXHiX+FHTQecxzleAK0Lw7cjJ+xf8J41ex/L i4aP5qUnLT7jf9gM1Unnjmu5bwMKSdrv6XSB/4dc8NmeaSaTXkhaXuBQtJA7C6+tWHes0S4f4WR 1Fkfq1EsR4csXOdp3jXjBN3iDJ83ryI/XgZRafliJ8rhfNTkiFi4wH4QaLeTOzPpXQjBQl1iSVp 0E7lKjhUvDunzjjTZEbYkHy91aktXWsIX6DpT53TL3XXq+UnM9Xz+jDLD67wPLRQ/ro+dEfh6I9 zbtisarNUDip9JqgNHXb0lLwJwmR1CclYhjWNLMQVgTmMDdo
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
 drivers/spi/spi-sprd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 45b69b83a7e4..702acaeebab2 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -1002,7 +1002,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sprd_spi_remove(struct platform_device *pdev)
+static void sprd_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *sctlr = platform_get_drvdata(pdev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
@@ -1021,8 +1021,6 @@ static int sprd_spi_remove(struct platform_device *pdev)
 	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)
@@ -1076,7 +1074,7 @@ static struct platform_driver sprd_spi_driver = {
 		.pm = &sprd_spi_pm_ops,
 	},
 	.probe = sprd_spi_probe,
-	.remove  = sprd_spi_remove,
+	.remove_new = sprd_spi_remove,
 };
 
 module_platform_driver(sprd_spi_driver);
-- 
2.39.1

