Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB56A9D1E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCCRVG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjCCRVB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F624743A
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-0006YC-4p; Fri, 03 Mar 2023 18:20:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-001bkG-7S; Fri, 03 Mar 2023 18:20:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001tjA-49; Fri, 03 Mar 2023 18:20:55 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 21/87] spi: dw-bt1: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:35 +0100
Message-Id: <20230303172041.2103336-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=f8XDAdS8N+Ob/WMdOU1gTk09nlxqgYFvHk5Y154sA1I=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitaHFfKWnyxrTOrAGs5s+qvatmzxeIa9n1ef Qo2HocG8cKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrWgAKCRDB/BR4rcrs CchEB/oD2OM8YxsvqTW43mVuTeUrh8cc02Z+zbyQgBCNymrvJSnWNY7ESzI4JSnwE7MCe4fgS5Q rsFycJ4j7Z1GPB2XYrlWqVwGGqIKaIHUywBsD8uBmF0UFgv2XN2/xscAVuBZtoj7/RNN3ShEk6v FIUNV/rEr/CK0t7lwJggRoS1L+Lnk72Mpb26UVurSwtgLMgK352v2XLw/UBVcZkn1/Dw3E4c4T+ QtfmZQ3mhlw0ew9ijh93aLK8SBejPH6+SlNpzKoA8gF2AF5hcjSLt3h+jKn4r9NhhZ6VCbFUjRR sE/JpfiSPeLhZKYarXdGlX/EmNlv4MpFSoHRAHTB7mONyj9k
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
 drivers/spi/spi-dw-bt1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index 3fb89dee595e..5e1c01822967 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -308,7 +308,7 @@ static int dw_spi_bt1_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dw_spi_bt1_remove(struct platform_device *pdev)
+static void dw_spi_bt1_remove(struct platform_device *pdev)
 {
 	struct dw_spi_bt1 *dwsbt1 = platform_get_drvdata(pdev);
 
@@ -317,8 +317,6 @@ static int dw_spi_bt1_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(dwsbt1->clk);
-
-	return 0;
 }
 
 static const struct of_device_id dw_spi_bt1_of_match[] = {
@@ -330,7 +328,7 @@ MODULE_DEVICE_TABLE(of, dw_spi_bt1_of_match);
 
 static struct platform_driver dw_spi_bt1_driver = {
 	.probe	= dw_spi_bt1_probe,
-	.remove	= dw_spi_bt1_remove,
+	.remove_new = dw_spi_bt1_remove,
 	.driver	= {
 		.name		= "bt1-sys-ssi",
 		.of_match_table	= dw_spi_bt1_of_match,
-- 
2.39.1

