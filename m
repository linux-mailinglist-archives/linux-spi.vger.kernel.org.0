Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0306A9D14
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCCRVC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjCCRU6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AE9457FE
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-0006Tx-RA; Fri, 03 Mar 2023 18:20:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001bjm-2c; Fri, 03 Mar 2023 18:20:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-001tiv-AN; Fri, 03 Mar 2023 18:20:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 17/87] spi: cavium-octeon: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:31 +0100
Message-Id: <20230303172041.2103336-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WH4xobIbZg7Pc/Vcft7cCE88VD9qyGgTofFN6HhsKB0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitK1mC8wIKGO6iTqc3kAqd9E5wrFuJyD6ps8 hqe+8TyOAmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrSgAKCRDB/BR4rcrs CZ5kB/9afMKjAB7gAN6ytshLqMhCbZiipAOAElusrp9lLjWNV8Rh2TDb6Io29UD4hAHPccJ0SXX UycL04wXFZ7bM8sGhDViogFj22AMSfJxudCf+k3syE+ifB6n+42bUkgR4OtaakjLF4weqNLSWvP 0pDcC3TfWRhOZ491vu5Z9a12tYF20tQgSJ1fI5JyiR399SHxfPPB+vtUSjjHf8apINe12OqxhM5 Q/5KlPub5CF5hEWxG1q+LM9pK2Ry5wqo9VZ+mc5QkoxRFJDMLss5TgY5tJn72vZL/LlETbYanlo N5rOJvNDgDbuMK4i4qA+EkPfXhRRxAws1+ugNzgoh/2GZfgb
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
 drivers/spi/spi-cavium-octeon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
index 1a2de6ce9064..58060be33106 100644
--- a/drivers/spi/spi-cavium-octeon.c
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -69,15 +69,13 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int octeon_spi_remove(struct platform_device *pdev)
+static void octeon_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct octeon_spi *p = spi_master_get_devdata(master);
 
 	/* Clear the CSENA* and put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
-
-	return 0;
 }
 
 static const struct of_device_id octeon_spi_match[] = {
@@ -92,7 +90,7 @@ static struct platform_driver octeon_spi_driver = {
 		.of_match_table = octeon_spi_match,
 	},
 	.probe		= octeon_spi_probe,
-	.remove		= octeon_spi_remove,
+	.remove_new	= octeon_spi_remove,
 };
 
 module_platform_driver(octeon_spi_driver);
-- 
2.39.1

