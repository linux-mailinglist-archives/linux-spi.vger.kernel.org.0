Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056B6A9D19
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCCRVE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCCRU7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1AA4391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-0006XL-Jz; Fri, 03 Mar 2023 18:20:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001bkA-08; Fri, 03 Mar 2023 18:20:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-001tj3-NM; Fri, 03 Mar 2023 18:20:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 19/87] spi: davinci: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:33 +0100
Message-Id: <20230303172041.2103336-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Qgv82uBfeGvii1PwmBy8aWWKTtE61twqezpOLMTbWEI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitRPMgTOsB1zd5aPEI5JUPjbpun2bJWTcQ0m eMf9gy/C46JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrUQAKCRDB/BR4rcrs CaXWB/9MK6WcDFAY78/Q2NVx27Ipz0MpEMk1cLY2oXn65ERtGWQHyXYaEkkzDppGv1ztehumj6g xSktF9e5LJrF36qEBEfs8nz6Axd997zOFw4DzHPd1B10ldzzji17LODYGfd5rkZXD/GM8DAHOGY ox0NmPb12mKSQgUTYXpkJjVVhtIj0ZHinU2dHGfGL42X8cmaUj9TYa05kXvDgivkY/6qVFLseGe BaRgXT+k86fKxwpELlEPnfQhBTvj6mMVLq+hHJklsHS2IbmxSt450kcEopgeBPtTRsu9U7yySmL w3HYo0QvwBZ5EoazNXQOQbfuXv4tVhjWq0aFac//tnay9cp8
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
 drivers/spi/spi-davinci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d112c2cac042..add1e198a439 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -1018,7 +1018,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
  * It will also call spi_bitbang_stop to destroy the work queue which was
  * created by spi_bitbang_start.
  */
-static int davinci_spi_remove(struct platform_device *pdev)
+static void davinci_spi_remove(struct platform_device *pdev)
 {
 	struct davinci_spi *dspi;
 	struct spi_master *master;
@@ -1036,7 +1036,6 @@ static int davinci_spi_remove(struct platform_device *pdev)
 	}
 
 	spi_master_put(master);
-	return 0;
 }
 
 static struct platform_driver davinci_spi_driver = {
@@ -1045,7 +1044,7 @@ static struct platform_driver davinci_spi_driver = {
 		.of_match_table = of_match_ptr(davinci_spi_of_match),
 	},
 	.probe = davinci_spi_probe,
-	.remove = davinci_spi_remove,
+	.remove_new = davinci_spi_remove,
 };
 module_platform_driver(davinci_spi_driver);
 
-- 
2.39.1

