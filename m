Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC06A9D07
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCCRU6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjCCRU4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E994391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-0006Ow-U8; Fri, 03 Mar 2023 18:20:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-001bif-1z; Fri, 03 Mar 2023 18:20:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95P-001thw-7p; Fri, 03 Mar 2023 18:20:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 01/87] spi: ar934x: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:15 +0100
Message-Id: <20230303172041.2103336-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zGTvuvwAvgVY3METLBmYBauim/GskFk1C7CSseH4oo8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAisP5POw3l3dkQLi1+7Tu2XnOjq/m/iYv8545 NLT9NXHfL6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrDwAKCRDB/BR4rcrs CZxBB/0TmXXdncuFJVWQgrsywJN0q8d1Az3Rw55h+TchWMQgzsaAZDDjqwbyLMmvXA5sb0UZVlp rkQriuFJ9WShxd2I/eU9EkgFGacqPHywYIl1TMnzprXTkghbMJPPmVKXi5ANGtNSsrb88kU+mpb 4pkN7yb62UtvohUmIX16XJ8ATzTLJN+TotaznMVkbT3loqUAnYmZeLAlp/2YoO4GBZJR8KMo3Gv /VnA+zEjS86yIC13r8WzyPScqzwR0FgBGpMljEyBNO8fh2KOLsC8ILod+Yg36qnsQ+iRTGh+CE2 SCkV6N2S/Jifytorem9DeHoxJ51e0MFiffzJ2oQkaj1RfHwB
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
 drivers/spi/spi-ar934x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index 4a6ecaa0a9c9..c71c8348eeaa 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -220,7 +220,7 @@ static int ar934x_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ar934x_spi_remove(struct platform_device *pdev)
+static void ar934x_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct ar934x_spi *sp;
@@ -230,8 +230,6 @@ static int ar934x_spi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(ctlr);
 	clk_disable_unprepare(sp->clk);
-
-	return 0;
 }
 
 static struct platform_driver ar934x_spi_driver = {
@@ -240,7 +238,7 @@ static struct platform_driver ar934x_spi_driver = {
 		.of_match_table = ar934x_spi_match,
 	},
 	.probe = ar934x_spi_probe,
-	.remove = ar934x_spi_remove,
+	.remove_new = ar934x_spi_remove,
 };
 
 module_platform_driver(ar934x_spi_driver);
-- 
2.39.1

