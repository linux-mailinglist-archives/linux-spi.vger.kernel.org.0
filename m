Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A5F6A9D65
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCCRVj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCCRVS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5504D63A
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95h-0007CA-SG; Fri, 03 Mar 2023 18:21:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-001bpF-Rb; Fri, 03 Mar 2023 18:21:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-001tnF-3s; Fri, 03 Mar 2023 18:21:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 84/87] spi: xilinx: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:38 +0100
Message-Id: <20230303172041.2103336-85-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1coSjyLVCt5hqzIgXmUNdRRTtaEsNmf1x/8dcg0B/7Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAixVdD3ol4CCLpPAXERy7eINNJy/LoDtjkAOs G0TJpGKW2GJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsVQAKCRDB/BR4rcrs CWpDB/wMXwpw7ruvyvKiQP+M13DVGSxsNOZnV5GZfdNyF8HLRCY5tk/WrHu1/E+xVDGPHVU6q5u ckFpO0EvAGI77kKnXh3Ti1PEdCUZFMI3Nvom6OmKEKWNUQbSqoYTZEzdiXLIy8qqjIHtaMQ9qk1 B+/uMA8ukZvbHiJ7c80BiBYetJiCjcC9cFhN9yFEob1yEKCPE3GtpDp01I0/TT60bHjcEoIVxlC hp0L7Aiy8U9l1nCqaQtxHCc1tdSKztutPWLZdXa6xX5RBe7++mFe5fXtbCrz2UUYUQl5VMUJlln txyHn81GwL0hzPTqlzcenGvDTwGacTPv80zHeFcFQbMmul4G
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
 drivers/spi/spi-xilinx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 1411548f4255..d2f9eea5e093 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -504,7 +504,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int xilinx_spi_remove(struct platform_device *pdev)
+static void xilinx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct xilinx_spi *xspi = spi_master_get_devdata(master);
@@ -518,8 +518,6 @@ static int xilinx_spi_remove(struct platform_device *pdev)
 	xspi->write_fn(0, regs_base + XIPIF_V123B_DGIER_OFFSET);
 
 	spi_master_put(xspi->bitbang.master);
-
-	return 0;
 }
 
 /* work with hotplug and coldplug */
@@ -527,7 +525,7 @@ MODULE_ALIAS("platform:" XILINX_SPI_NAME);
 
 static struct platform_driver xilinx_spi_driver = {
 	.probe = xilinx_spi_probe,
-	.remove = xilinx_spi_remove,
+	.remove_new = xilinx_spi_remove,
 	.driver = {
 		.name = XILINX_SPI_NAME,
 		.of_match_table = xilinx_spi_of_match,
-- 
2.39.1

