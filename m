Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32F6A9D20
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjCCRVI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCCRVB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E947412
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-0006bq-Qi; Fri, 03 Mar 2023 18:20:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001bkZ-S7; Fri, 03 Mar 2023 18:20:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001tjT-1Z; Fri, 03 Mar 2023 18:20:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 26/87] spi: fsl-lpspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:40 +0100
Message-Id: <20230303172041.2103336-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wC7ikng/GClphiubIDcXxHns/PSHF9AfuaU+zgrgOVM=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaQwaee7N8zuzXA9wCHmKGSuuc1T5Qe7e/WzZXnH5nnlG XRd38rfyWjMwsDIxSArpshSV6QlNkFizX+7kiXcMINYmUCmMHBxCsBEwi+w/7Pwuvv6vFF/qLns Bp65BclLsraWafs+/2we/lnP79AFj/xJnFXByVn96VZ5ZVENq5RlY6ce81vE5tivvv2+Y/6n7fW bf6/ekWdlXbrgy0y7HebRpqIl+ubHot8bPXJZLbDBK/d04PupbdGmIg9Uz2swz1B9IJRu8iLjFq eH9F/By58Z5sXdiJu129f0pCW3X/bCrO+WNvY7Zpl8ckl0XHqnt2BOhdiaEO11Mr5mepM31/9d1 HE4d/k7209ljNWli+oWTMwNiL/L2W0WLi1Qdvn9hSfbm5a/PWzWcU3l6Jv+U2XCyfUqr1btyuAK 4znKoypYxFrndWfq1tmfF5yflygv99iB7f08x7n9aZOqAA==
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
 drivers/spi/spi-fsl-lpspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 34488de55587..b9e8b7b241a4 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -937,7 +937,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int fsl_lpspi_remove(struct platform_device *pdev)
+static void fsl_lpspi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *controller = platform_get_drvdata(pdev);
 	struct fsl_lpspi_data *fsl_lpspi =
@@ -946,7 +946,6 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 	fsl_lpspi_dma_exit(controller);
 
 	pm_runtime_disable(fsl_lpspi->dev);
-	return 0;
 }
 
 static int __maybe_unused fsl_lpspi_suspend(struct device *dev)
@@ -983,7 +982,7 @@ static struct platform_driver fsl_lpspi_driver = {
 		.pm = &fsl_lpspi_pm_ops,
 	},
 	.probe = fsl_lpspi_probe,
-	.remove = fsl_lpspi_remove,
+	.remove_new = fsl_lpspi_remove,
 };
 module_platform_driver(fsl_lpspi_driver);
 
-- 
2.39.1

