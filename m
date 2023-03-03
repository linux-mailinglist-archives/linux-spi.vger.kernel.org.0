Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292396A9D2A
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjCCRVM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjCCRVE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE24743D
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-0006mJ-S9; Fri, 03 Mar 2023 18:21:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-001blc-K8; Fri, 03 Mar 2023 18:20:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95W-001tkM-UX; Fri, 03 Mar 2023 18:20:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 39/87] spi: mpc52xx-psc: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:53 +0100
Message-Id: <20230303172041.2103336-40-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vbDmrCobXARpzkUXnku1nm8yvmM0ylr4+tKHEkgp5yA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuiNj1+giZuo6pUG6qaAyi/nlCrmuD3ugEGW 7CTZFjWK3WJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrogAKCRDB/BR4rcrs CRX9B/9J6CQ4Jg8uWkkCGf+YQUZdmfQlt0JXRA3mZMjtkrrFbIWL93XSTm1toDda6ceSKrHATiD qLzlW6CeaE6O/L15u4mJLbzskSKm9idRRLJY5oruYoQtjBJ50y41TM5jxvJ7XZxRdtTTWeDF0Qq dIT1BkJ1w/U5kRVLTr5BXw5UI/T7S+qvj1FjItq8RV/U9rdl6COqSfw20XVedTyj4H6o2KLjFVG bc1VhCahhYk6N6Z3OnX1sv39CxCuTrLgyh7Gyuikb8K7NpA1V2e8Dv71X6WG7CWHHoSq99yiYyx qc1LR9xBZMtuizSiyvZzaxpFBgprEmCF8XvtHgpV9xhC19UO
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
 drivers/spi/spi-mpc52xx-psc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 609311231e64..4a2b1b56cc92 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -418,7 +418,7 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *op)
 				irq_of_parse_and_map(op->dev.of_node, 0), id);
 }
 
-static int mpc52xx_psc_spi_of_remove(struct platform_device *op)
+static void mpc52xx_psc_spi_of_remove(struct platform_device *op)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(op));
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(master);
@@ -428,8 +428,6 @@ static int mpc52xx_psc_spi_of_remove(struct platform_device *op)
 	if (mps->psc)
 		iounmap(mps->psc);
 	spi_master_put(master);
-
-	return 0;
 }
 
 static const struct of_device_id mpc52xx_psc_spi_of_match[] = {
@@ -442,7 +440,7 @@ MODULE_DEVICE_TABLE(of, mpc52xx_psc_spi_of_match);
 
 static struct platform_driver mpc52xx_psc_spi_of_driver = {
 	.probe = mpc52xx_psc_spi_of_probe,
-	.remove = mpc52xx_psc_spi_of_remove,
+	.remove_new = mpc52xx_psc_spi_of_remove,
 	.driver = {
 		.name = "mpc52xx-psc-spi",
 		.of_match_table = mpc52xx_psc_spi_of_match,
-- 
2.39.1

