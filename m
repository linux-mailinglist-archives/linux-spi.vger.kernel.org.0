Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831246A9D29
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjCCRVL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjCCRVD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC14391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-0006l2-FM; Fri, 03 Mar 2023 18:21:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-001blU-8p; Fri, 03 Mar 2023 18:20:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-001tkI-MW; Fri, 03 Mar 2023 18:20:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 38/87] spi: mpc512x-psc: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:52 +0100
Message-Id: <20230303172041.2103336-39-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CM32ybsWUiRdSZv3IwCqJC/iklKREoEKB33cRr5ugrM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiueRAiy6t3rrBSUQo8ojWIJ/i/EnmFLCzzL7 ++GynEXnuiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrngAKCRDB/BR4rcrs CccpCACRMZqa+ixfQEYGTd8Iphc8hg0o4tRyDicIjiQBgmNeRPPCKQdiCVEC9xRcF8MeiusYaeB +UVOrvs1hH+fn8fKdrf5vTruLBTCUtfDy31MGZVdRf9de5JeyMr0LjhWuIAjJNZnycTPlacbf67 KrDh65NaWsPgOJjsgTZjgN/1xrJnvOJHS5ZJmn1O+4QoOliSEjwsCf1uir/tiDmhrTxKcHbmSXT IUdQmyvUZEOMw+9fw5wXny8zf1RYnkGqymlYqTco8e+nLUaFccS8qjwAVCtsFoKGZwFALmmHSIQ skJjhq5wkFDVCarWaGSxN+1iXyXhti1Ml/+oEMjCAGwqBDbU
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

Fold mpc512x_psc_spi_do_remove() into its only caller and then trivially
convert this driver from always returning zero in the remove callback to
the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-mpc512x-psc.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 03630359ce70..f5bea6df0690 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -561,17 +561,6 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	return ret;
 }
 
-static int mpc512x_psc_spi_do_remove(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
-
-	clk_disable_unprepare(mps->clk_mclk);
-	clk_disable_unprepare(mps->clk_ipg);
-
-	return 0;
-}
-
 static int mpc512x_psc_spi_of_probe(struct platform_device *op)
 {
 	const u32 *regaddr_p;
@@ -588,9 +577,14 @@ static int mpc512x_psc_spi_of_probe(struct platform_device *op)
 				irq_of_parse_and_map(op->dev.of_node, 0));
 }
 
-static int mpc512x_psc_spi_of_remove(struct platform_device *op)
+static void mpc512x_psc_spi_of_remove(struct platform_device *op)
 {
-	return mpc512x_psc_spi_do_remove(&op->dev);
+	struct device *dev = &op->dev;
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mpc512x_psc_spi *mps = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(mps->clk_mclk);
+	clk_disable_unprepare(mps->clk_ipg);
 }
 
 static const struct of_device_id mpc512x_psc_spi_of_match[] = {
@@ -603,7 +597,7 @@ MODULE_DEVICE_TABLE(of, mpc512x_psc_spi_of_match);
 
 static struct platform_driver mpc512x_psc_spi_of_driver = {
 	.probe = mpc512x_psc_spi_of_probe,
-	.remove = mpc512x_psc_spi_of_remove,
+	.remove_new = mpc512x_psc_spi_of_remove,
 	.driver = {
 		.name = "mpc512x-psc-spi",
 		.of_match_table = mpc512x_psc_spi_of_match,
-- 
2.39.1

