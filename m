Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFD16A9D6B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCCRVo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjCCRVY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0794FA94
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95j-0007Jl-J0; Fri, 03 Mar 2023 18:21:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95i-001bpV-4g; Fri, 03 Mar 2023 18:21:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-001tnQ-Mj; Fri, 03 Mar 2023 18:21:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 87/87] spi: zynqmp-gqspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:41 +0100
Message-Id: <20230303172041.2103336-88-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=A2w0qzAbI0ugRYElQv6pogbF7ZRhXQXPw0XIf77eoL0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAixhmoPmaHUDTNIpz2J9m9hSh+YB2hyCjUKiQ 8cvIA04tMqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsYQAKCRDB/BR4rcrs CUnbB/9XE2sxGLV94rF8ift1K5ZVJn3L33rYkMcsEbT6nleaPWVW5B3O6VmDi92RmLKwpnV24VA +Nvnq2qiVpXQTna+IXz0pO4oKH7Y9O44+WcbaQGZp5E4/AFyR1UOvnIizxgjK+71F7veJG1oBDR VCQRiiomPPCXYHQLoBz1udwN3cHdwAJCgJh3J88S3eAKozgZScsiqNJqwIETAs8XuZluVzivIVf 17J6m7sI6O/FxiI8Wb3ZKxP4N79zdVSeS30LhVMh1ht7jCRrANlZ3LBV7wnvIVDVHfUI+5pG3iK h99j2ZKsBzSR2TJS6bJoZTTS9gs8XMx9SW6PCP38+3ZUF/iy
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
 drivers/spi/spi-zynqmp-gqspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 95ff15665d44..270d28a3f8eb 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1364,7 +1364,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
  *
  * Return:	0 Always
  */
-static int zynqmp_qspi_remove(struct platform_device *pdev)
+static void zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
@@ -1373,15 +1373,13 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->pclk);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
-	.remove = zynqmp_qspi_remove,
+	.remove_new = zynqmp_qspi_remove,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.39.1

