Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D676A9D63
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCCRVm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCCRVU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8364FA90
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95i-0007EF-KC; Fri, 03 Mar 2023 18:21:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95h-001bpM-5B; Fri, 03 Mar 2023 18:21:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-001tnN-G0; Fri, 03 Mar 2023 18:21:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 86/87] spi: zynq-qspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:40 +0100
Message-Id: <20230303172041.2103336-87-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6KxIrLLIN+exUhsDNYaSHiJgnuFJTXjdKzGoSUWhooI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAixd8jAOSKYod2yr/bKL2CBnPCZyfmw3rhFM3 sTNngGC6daJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsXQAKCRDB/BR4rcrs Cev1B/9Z0L28LMfYw8AlHCnQ/7Rx1oSP0b0osC99N+FzxQWVSwRb9Cg7uA3BtYxEJ62iUZacLbq 5Z2EzwicglevXrRG3jysgLGsq91CHLV4xHdpkimhZoR2gjOBYYp7/gOjvAjOxQQ/Ktawh/ORIO4 KjYrMZ4pWbo4DLS0ze5n+WDJadKJKuyJiZ/ExpHBc4BvjyZY89nFsgmHdIHTLvTlpimOCohkFpL b05r0KdSD2A3AbZmLzzHjQCgKoy2KAZ4NXQ+ybomSNoA/J624+RB36jk/DJVx/dmAE6VgJgbY8m 9QHVNCN7LHAb1p9W4kay0h9en34Dw2XexAJhgm7gvE8DppVW
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
 drivers/spi/spi-zynq-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 78f31b61a2aa..8558c0fe3775 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -741,7 +741,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
  *
  * Return:	0 on success and error value on failure
  */
-static int zynq_qspi_remove(struct platform_device *pdev)
+static void zynq_qspi_remove(struct platform_device *pdev)
 {
 	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
 
@@ -749,8 +749,6 @@ static int zynq_qspi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-
-	return 0;
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {
@@ -765,7 +763,7 @@ MODULE_DEVICE_TABLE(of, zynq_qspi_of_match);
  */
 static struct platform_driver zynq_qspi_driver = {
 	.probe = zynq_qspi_probe,
-	.remove = zynq_qspi_remove,
+	.remove_new = zynq_qspi_remove,
 	.driver = {
 		.name = "zynq-qspi",
 		.of_match_table = zynq_qspi_of_match,
-- 
2.39.1

