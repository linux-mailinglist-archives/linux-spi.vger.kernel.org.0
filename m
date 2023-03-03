Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58216A9D4A
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjCCRV2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjCCRVM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F54ECD0
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-0006fI-Pv; Fri, 03 Mar 2023 18:20:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001bko-D8; Fri, 03 Mar 2023 18:20:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001tjh-ML; Fri, 03 Mar 2023 18:20:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 29/87] spi: geni-qcom: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:43 +0100
Message-Id: <20230303172041.2103336-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=A2X7hN/80wQC7iYHSvRuoRASSzqEeUFH0zUM6Xe526w=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaQwaVdb3jrsxdC3pbJP67APxx4X6Uc5MacemFlayjw49 vj7NL3KTkZjFgZGLgZZMUWWuiItsQkSa/7blSzhhhnEygQyhYGLUwAmstCA/X9M/sszCh2bbSNL +zzVt01MzuVyXHmnc2PnWeZKyz29BlM1in4XfJj6WuVKn+ySdW7s3d8Lv65Yype2NuJJSKbsNqd NqjX8fHwqK86lnZXIfxP3rPL/na7qiCvH0rxCk9ma1l5/ndwWIrH3YvjnhYpxNceu9FWoW1cylr fw8xu+0JLW/zdjd8E7yWWG4Z3td3tPRpfsbFHLjTi7t/DD1Gi+fWL/GxM9TyXvr8qQ/OEr8u1Cd fDBXxO/bzxessuhe6qnTOgH5as3ym2zGR6Haidauj53ZikKv+S08mhH/dbkxdZmzTHXq4JVGSWW za3gXMWvcKA6aYXYo4lZId+evjsc3Tid2637bsqCygf6AA==
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
 drivers/spi/spi-geni-qcom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index babb039bcb43..f80635532b4d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1114,7 +1114,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spi_geni_remove(struct platform_device *pdev)
+static void spi_geni_remove(struct platform_device *pdev)
 {
 	struct spi_master *spi = platform_get_drvdata(pdev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
@@ -1126,7 +1126,6 @@ static int spi_geni_remove(struct platform_device *pdev)
 
 	free_irq(mas->irq, spi);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
@@ -1208,7 +1207,7 @@ MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
 
 static struct platform_driver spi_geni_driver = {
 	.probe  = spi_geni_probe,
-	.remove = spi_geni_remove,
+	.remove_new = spi_geni_remove,
 	.driver = {
 		.name = "geni_spi",
 		.pm = &spi_geni_pm_ops,
-- 
2.39.1

