Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431276A9D39
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjCCRVT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjCCRVJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A14391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-0006tp-LR; Fri, 03 Mar 2023 18:21:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-001bmn-Jd; Fri, 03 Mar 2023 18:21:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001tlJ-Pv; Fri, 03 Mar 2023 18:21:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 54/87] spi: ppc4xx: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:08 +0100
Message-Id: <20230303172041.2103336-55-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tC2otOylt51PYMHjIuRFgHI9ye83HjbKhT0Og66FB4I=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivcYOoi30HPYjfIfti2fTkcG88B37Xg2QdXY KUG7lNuOZiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIr3AAKCRDB/BR4rcrs CSZmB/9mS2tiYS8Z/MrC7P2xPdLwsIZHZF4fOwHc91B4VX6HWW3Sv9XO2ZF5iA+mmEdsChN0q9p FTkXAzeRZj3WqVnDxQ5LBbIZ3ePIpk71NiVYQlDZcaMdK0T2o21KzxHgPTjlqGrUos79lkFVVkX 3U5o03m81dFZ0ihBL+RM5ZEOiZ3duT6LoCZoxk0lPGfrC/4/Jc/Xc7xbu/ESxGkDW5PBSNzypoG DgnBFubVjBHkBxcEso6LctbJ/kEyIgT0ycOBaa12OfUwk0f+9AWOXMFY9MpHjVPTWE39XNMmAR5 mb5H7AsF80phdxCz3Je6HJYFeVbFWZIUyrDsmJpFS6KnF6OZ
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
 drivers/spi/spi-ppc4xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index d65f047b6c82..d725e915025d 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -464,7 +464,7 @@ static int spi_ppc4xx_of_probe(struct platform_device *op)
 	return ret;
 }
 
-static int spi_ppc4xx_of_remove(struct platform_device *op)
+static void spi_ppc4xx_of_remove(struct platform_device *op)
 {
 	struct spi_master *master = platform_get_drvdata(op);
 	struct ppc4xx_spi *hw = spi_master_get_devdata(master);
@@ -474,7 +474,6 @@ static int spi_ppc4xx_of_remove(struct platform_device *op)
 	free_irq(hw->irqnum, hw);
 	iounmap(hw->regs);
 	spi_master_put(master);
-	return 0;
 }
 
 static const struct of_device_id spi_ppc4xx_of_match[] = {
@@ -486,7 +485,7 @@ MODULE_DEVICE_TABLE(of, spi_ppc4xx_of_match);
 
 static struct platform_driver spi_ppc4xx_of_driver = {
 	.probe = spi_ppc4xx_of_probe,
-	.remove = spi_ppc4xx_of_remove,
+	.remove_new = spi_ppc4xx_of_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = spi_ppc4xx_of_match,
-- 
2.39.1

