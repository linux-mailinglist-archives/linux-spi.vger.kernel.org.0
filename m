Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764D6D1079
	for <lists+linux-spi@lfdr.de>; Thu, 30 Mar 2023 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjC3VEG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Mar 2023 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjC3VEE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 17:04:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EA3E396
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 14:04:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQw-00028k-Oi; Thu, 30 Mar 2023 23:03:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQu-007qTM-Fc; Thu, 30 Mar 2023 23:03:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phzQt-009HrC-R7; Thu, 30 Mar 2023 23:03:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] spi: qup.c: Convert to platform remove callback returning void
Date:   Thu, 30 Mar 2023 23:03:41 +0200
Message-Id: <20230330210341.2459548-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330210341.2459548-1-u.kleine-koenig@pengutronix.de>
References: <20230330210341.2459548-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4ORL/RE427evmh2kg1ELKEpHyPJUuSu3AoBaMjDdcSc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkJfkq5c26xYNivbAWrdqVOkoPNDWiLyAo9vwpq lLCxtItF9CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZCX5KgAKCRCPgPtYfRL+ Tr6ICACnpC2pTlrIoNeVVpYgETvvSiYyw2MJXkan4yp5ru2NiWK4JVyeRYCp3KOEX0FNCoDWP9D f5w1JWRh+QSJlGnfNjOIkz3y0tRWrA8LGmGdLrxP4jGaoXQ+82yJbDOqtCpAgs5KjsZGXBvqf3C F+p/WqQaxqp9zYAQg4/tIRbdb2qU96qQqk+jkTZUiPIqs0Gzn7OEdjIZZYAw93J8MbRwmyuqsD6 nv44IoRt6kOyHYt5QCnQ+2g+5sX1Frx+jXiVt5CB5MtrI9/KmshVFbuKJfpYomkGMQUcJOQ+6ae uWrxNpPd5d9Il6Qe1g5ORl0fE6Xidb+OR1tNIkI5CEwCMOTf
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

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-qup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 205e54f157b4..0b97c8a9372f 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1271,7 +1271,7 @@ static int spi_qup_resume(struct device *device)
 }
 #endif /* CONFIG_PM_SLEEP */
 
-static int spi_qup_remove(struct platform_device *pdev)
+static void spi_qup_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = dev_get_drvdata(&pdev->dev);
 	struct spi_qup *controller = spi_master_get_devdata(master);
@@ -1296,8 +1296,6 @@ static int spi_qup_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id spi_qup_dt_match[] = {
@@ -1322,7 +1320,7 @@ static struct platform_driver spi_qup_driver = {
 		.of_match_table = spi_qup_dt_match,
 	},
 	.probe = spi_qup_probe,
-	.remove = spi_qup_remove,
+	.remove_new = spi_qup_remove,
 };
 module_platform_driver(spi_qup_driver);
 
-- 
2.39.2

