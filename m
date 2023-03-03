Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768156A9D25
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjCCRVK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjCCRVD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DCC46173
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-0006bz-Ab; Fri, 03 Mar 2023 18:20:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001bka-T0; Fri, 03 Mar 2023 18:20:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001tjX-6x; Fri, 03 Mar 2023 18:20:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 27/87] spi: fsl-qspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:41 +0100
Message-Id: <20230303172041.2103336-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OG7KVl7jCwglTWEq5HL0TJfrcL8BZmrhw8RGNA1CvI0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitzuadlcNOKvf/T7FbEWEzrqkfIZg7ZZO9dS Ypw3LILqxWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrcwAKCRDB/BR4rcrs CSviCACgBE2atzbCSv1FqgP/kfc454d4Q1F6VvGakY3yTispAc5yaXAwRNFwOdLDTlLA3ZfLj9D RQ9Lwn8wK8rRzuhLzYbddaKgLGuyvU9agpi+loRmgvqIA/YmPFO2dJwtuKZ6f5lUHY4sln0Eskg NWvKfTRZBA3sqakiZaVO076gbFJ017gNVk/TnQCtfJXii2kg00QIquygrLCBBcCtq4QHjgffSpP QXX2cBRqhwVRQWx4IdL9FsWPOowQFuoqdrE3kv676g1MVXhfFa8iv8eXhKfW2ebzC3i/1zTZ3Ag zBprCRIO3GeHqVDR8a4/vBcRpe8kFfqZ9HMq5wdiXdeYplyo
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
 drivers/spi/spi-fsl-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 85cc71ba624a..bacc54836959 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -948,7 +948,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int fsl_qspi_remove(struct platform_device *pdev)
+static void fsl_qspi_remove(struct platform_device *pdev)
 {
 	struct fsl_qspi *q = platform_get_drvdata(pdev);
 
@@ -959,8 +959,6 @@ static int fsl_qspi_remove(struct platform_device *pdev)
 	fsl_qspi_clk_disable_unprep(q);
 
 	mutex_destroy(&q->lock);
-
-	return 0;
 }
 
 static int fsl_qspi_suspend(struct device *dev)
@@ -1000,7 +998,7 @@ static struct platform_driver fsl_qspi_driver = {
 		.pm =   &fsl_qspi_pm_ops,
 	},
 	.probe          = fsl_qspi_probe,
-	.remove		= fsl_qspi_remove,
+	.remove_new	= fsl_qspi_remove,
 };
 module_platform_driver(fsl_qspi_driver);
 
-- 
2.39.1

