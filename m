Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF36A9D77
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjCCRVw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCCRV2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E2C47412
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-0006vJ-76; Fri, 03 Mar 2023 18:21:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-001bms-UT; Fri, 03 Mar 2023 18:21:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-001tlQ-5J; Fri, 03 Mar 2023 18:21:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 56/87] spi: qcom-qspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:10 +0100
Message-Id: <20230303172041.2103336-57-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Tx6CXfHNJmGBVRj2EM5iiah+Com8NfpAZ+iA7lFJ+OA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivkcb28Ws1RIDp9MjLLK0kcZcBcweCkUoh1p K24RaH0vUmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr5AAKCRDB/BR4rcrs CZSJB/9s7RuVt3jOP/bUujMaMlj88iAiFGahR5OHQq72pTyq0BrMOVRESLZtoT1vMlp3Z/v8ENI jgl2dJUWJdwgBs64VSPYQedV42SFNOKKVpDeMP6c2P3H5l04a4aj0JkSvZH1Qa/wrj6217YfO// RXtehrDRqbB1oKM+xrZ9oOYIbf5JUFjWR0Y2akcql6DPdfvCGjVMW3UDAcCPzZPKbkL3kNy5KAJ XIcgLRVMW4/If6dWWW8AtUBt4YerBbaOk3DFA/zlqQkAinl5BGcBh1vtAmW2JVFkUV4Mj10un+m eLyzIN6q/xFDN17O4TBz8uu5RoTGxyhNTdw0Az2X4O7IuHEU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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
 drivers/spi/spi-qcom-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index c334dfec4117..15c4e21cd562 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -552,7 +552,7 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_qspi_remove(struct platform_device *pdev)
+static void qcom_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 
@@ -560,8 +560,6 @@ static int qcom_qspi_remove(struct platform_device *pdev)
 	spi_unregister_master(master);
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
@@ -655,7 +653,7 @@ static struct platform_driver qcom_qspi_driver = {
 		.of_match_table = qcom_qspi_dt_match,
 	},
 	.probe = qcom_qspi_probe,
-	.remove = qcom_qspi_remove,
+	.remove_new = qcom_qspi_remove,
 };
 module_platform_driver(qcom_qspi_driver);
 
-- 
2.39.1

