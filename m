Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DB86A9D59
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjCCRVf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCCRVQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC16515DE
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-000751-Tm; Fri, 03 Mar 2023 18:21:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-001boU-VZ; Fri, 03 Mar 2023 18:21:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-001tmT-Kb; Fri, 03 Mar 2023 18:21:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 72/87] spi: stm32-qspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:26 +0100
Message-Id: <20230303172041.2103336-73-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hw0v7/VEboyjh4ufaxKxn8YhNW4zVT4Q1r6kSgkyUo8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwihaoJipsCTCC2VlZLiQcIlqSvMoBNZjkVT 5Ld2Z22ewKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsIgAKCRDB/BR4rcrs Ce8IB/0ZtukNATZIF/3Yb5ThyqyiBIACWDZEACUFBOO4wLwVejanAY5BQrjsxHj7b9sMg8PWT47 aLxdki5SV3HWRKIBLkDOFvXbOiDTompRmJajZjXPn1iCEBZq09ZUycDF/07kV2eQx7x8cllmFVo Eyr4kB49MKRGIVngivrjPYC8ypRxmne0+BBGezVKXADvOmaVC4ujCvWj8L0GazIXKjv9lkMQdGm HCyx09ijNA9MvPMxB2cR0IueP2eu+/42AoItVfuxgbloHN4Tkz1PptNEUkUb1yA+qH/Ld3Lxh+t OCw4H2U1y+KRn5JWocJ+e896kIo+bJS+uRijTV5GgYC/X6ZG
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
 drivers/spi/spi-stm32-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 9131660c1afb..29125af0afdb 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -888,7 +888,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_qspi_remove(struct platform_device *pdev)
+static void stm32_qspi_remove(struct platform_device *pdev)
 {
 	struct stm32_qspi *qspi = platform_get_drvdata(pdev);
 
@@ -903,8 +903,6 @@ static int stm32_qspi_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(qspi->dev);
 	pm_runtime_dont_use_autosuspend(qspi->dev);
 	clk_disable_unprepare(qspi->clk);
-
-	return 0;
 }
 
 static int __maybe_unused stm32_qspi_runtime_suspend(struct device *dev)
@@ -968,7 +966,7 @@ MODULE_DEVICE_TABLE(of, stm32_qspi_match);
 
 static struct platform_driver stm32_qspi_driver = {
 	.probe	= stm32_qspi_probe,
-	.remove	= stm32_qspi_remove,
+	.remove_new = stm32_qspi_remove,
 	.driver	= {
 		.name = "stm32-qspi",
 		.of_match_table = stm32_qspi_match,
-- 
2.39.1

