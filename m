Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F16A9D68
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCCRVn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjCCRVU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED6515E7
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95i-0007Ed-KS; Fri, 03 Mar 2023 18:21:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95h-001bpP-6v; Fri, 03 Mar 2023 18:21:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-001tnI-9Y; Fri, 03 Mar 2023 18:21:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Max Filippov <jcmvbkbc@gmail.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 85/87] spi: xtensa-xtfpga: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:39 +0100
Message-Id: <20230303172041.2103336-86-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zddy/8H1Q+53nes0ZYo/vlUEp77xSSG4Eoaio2TywRQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAixZKLMpsnqaWhb1HLuRtf2bPnCYCczNppZHL npmL/3EaFGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsWQAKCRDB/BR4rcrs CVVmCACa/eT7gD2Msi+jN138Zo6eMlbmWARG3V0nBkMnyetMVg8A1dLWiqCA6kmHeZmsPvuIMj9 WEJ0yid/++IvNUoAerxsijF+4Zmmayp6xftqxtiz8XMn2CIReKi2acUFkFF6JYhlcSkrSVh1N6w G4OfieUMk2gh6fZ2iq2+Bdi0x6ODl80DKjCWRRpOjY7VJ80t5bh5nJVyinyTZkpF4RGha2rRR79 VRZnPlks1x+fNAl4RZim4878/wqXhL5t54I1qeB4hmsd51k7B0zYgRqliYrh2TCvq6PnpvpPIN0 jixz3ww70P4iR8vVApNQVni9fGFckTbH4wzcvSO7byIx60Ad
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
 drivers/spi/spi-xtensa-xtfpga.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 2fa7608f94cd..24dc845b940e 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -117,15 +117,13 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int xtfpga_spi_remove(struct platform_device *pdev)
+static void xtfpga_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct xtfpga_spi *xspi = spi_master_get_devdata(master);
 
 	spi_bitbang_stop(&xspi->bitbang);
 	spi_master_put(master);
-
-	return 0;
 }
 
 MODULE_ALIAS("platform:" XTFPGA_SPI_NAME);
@@ -140,7 +138,7 @@ MODULE_DEVICE_TABLE(of, xtfpga_spi_of_match);
 
 static struct platform_driver xtfpga_spi_driver = {
 	.probe = xtfpga_spi_probe,
-	.remove = xtfpga_spi_remove,
+	.remove_new = xtfpga_spi_remove,
 	.driver = {
 		.name = XTFPGA_SPI_NAME,
 		.of_match_table = of_match_ptr(xtfpga_spi_of_match),
-- 
2.39.1

