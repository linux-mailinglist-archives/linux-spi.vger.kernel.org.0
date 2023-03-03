Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0156A9D0E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCCRVA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCCRU6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E443937
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-0006Tn-S7; Fri, 03 Mar 2023 18:20:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001bjl-1i; Fri, 03 Mar 2023 18:20:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001tio-Tn; Fri, 03 Mar 2023 18:20:53 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 15/87] spi: cadence-quadspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:29 +0100
Message-Id: <20230303172041.2103336-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TR8WisYWFs3XU5g3YNSGElNFC45fcZhaaPWGy9JEijo=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaQwaTszyB8P8Wmdp6StN/WTgUnW95S1e80d5b/bff0rJ TV30ifvTkZjFgZGLgZZMUWWuiItsQkSa/7blSzhhhnEygQ2hYtTACZSf4CDodfMW/yNS8iJC7aM +5fJVQd3NsiqPzmhdbhqudOvj/MXLmsXnf7/lF9/lvCvGRzSTmGx8Z7qE9aWGB/3XjX/4g4uRgX TwnsRyk0CeiqledLTnnNFL559chJT6n2xM5oOK8WYZfLO+spoCUewmuY8XHAqzqZWRflDi/12I4 5gtgsJJzp4Eq1jTF78n8P3b4O5SoHIJ5OWgKxjh7+KzvWcktfBkCm5+9CT7FWHOy3ffzC9XDz38 RUpBnMrHfuLIZtZfpRsXRy4KbtedMoJadmKlSeynbecenpH06y0r+vHPnum1Su7lq1dVNseeTpu 7zHfByfvLlhTdmTaDtWZJ88/uCCU5BAjxbzuyn+1CfWXAQ==
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
 drivers/spi/spi-cadence-quadspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 64b6a460d739..c58c36fc2b36 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1784,7 +1784,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cqspi_remove(struct platform_device *pdev)
+static void cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
@@ -1798,8 +1798,6 @@ static int cqspi_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1891,7 +1889,7 @@ MODULE_DEVICE_TABLE(of, cqspi_dt_ids);
 
 static struct platform_driver cqspi_platform_driver = {
 	.probe = cqspi_probe,
-	.remove = cqspi_remove,
+	.remove_new = cqspi_remove,
 	.driver = {
 		.name = CQSPI_NAME,
 		.pm = CQSPI_DEV_PM_OPS,
-- 
2.39.1

