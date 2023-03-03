Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5916A9D1C
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjCCRVF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjCCRVB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE17D47438
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-0006Y4-4v; Fri, 03 Mar 2023 18:20:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001bkE-5s; Fri, 03 Mar 2023 18:20:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001tjF-Am; Fri, 03 Mar 2023 18:20:55 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 22/87] spi: dw-mmio: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:36 +0100
Message-Id: <20230303172041.2103336-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=u7yioAjzjn0qL61N6s+g0jRCkgp/b3DGJas8MlRKTNo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitetPQdvqgeP+pMw1Z+2omcSK9TlFex+UWDQ SFLo0UgJBaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrXgAKCRDB/BR4rcrs CRQmB/4ySFYloQihGvd3/sKezUvbGSnFr5icQFYjHdePFk07CH0NzmO8DNwcaS6GA907j+NWa+S I6qC1lMmPND5hnpy80wUe6CIff4YKwmdTP6GdkUd7h7xHWthgoF6n7cEIMWsU/5NDoMFzFvV4Nh LMvgh/mrgCzBlNkooNQL1IkEJMXu3YJtvZZKgzrMtV3iGoUIsxYPPh55s65RNiUNdRP60vLGiui MtE1D2gIFq4/XRpNDWPRdI8bQdR5Dm4gT4t63/Q3mWoiV7eQchM+XMllrtP3Jlhv0GojU53Bmwq 55Q/XJBm8bRZxDRv9sxUmFuD8ZyQ7LGJYbBGLzOX7FWX+Fxk
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
 drivers/spi/spi-dw-mmio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 26c40ea6dd12..6ae124c30969 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -328,7 +328,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dw_spi_mmio_remove(struct platform_device *pdev)
+static void dw_spi_mmio_remove(struct platform_device *pdev)
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
@@ -337,8 +337,6 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
 	reset_control_assert(dwsmmio->rstc);
-
-	return 0;
 }
 
 static const struct of_device_id dw_spi_mmio_of_match[] = {
@@ -366,7 +364,7 @@ MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
 
 static struct platform_driver dw_spi_mmio_driver = {
 	.probe		= dw_spi_mmio_probe,
-	.remove		= dw_spi_mmio_remove,
+	.remove_new	= dw_spi_mmio_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = dw_spi_mmio_of_match,
-- 
2.39.1

