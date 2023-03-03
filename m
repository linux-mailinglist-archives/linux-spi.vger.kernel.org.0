Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588A6A9D48
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjCCRV1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCCRVM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8754D60C
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-00070a-Lr; Fri, 03 Mar 2023 18:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-001bnS-Dp; Fri, 03 Mar 2023 18:21:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95b-001tlr-NS; Fri, 03 Mar 2023 18:21:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 63/87] spi: sh-hspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:17 +0100
Message-Id: <20230303172041.2103336-64-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=z8dNBplpaWkGXysJlx4mBquIkfylyak/PPsKy+Lwb9k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwALb+UJX0ATs3Fka22Dfw5T6QVvqhVekUn5 e2FMmiKWEqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsAAAKCRDB/BR4rcrs CexuB/0eB2YiECFNw/vy5D7866KU4y+sf9PKtIvet/78E5UNaAXipAjf4W9W1hIo0QlhKRlf8Vf 1UOo8HKufy5ElfgslWW9GApclSpwTtvmAAZibDhxVf3tdF29camXHI9mbNKDjLLlBkfNNdcsOZR qFB8jq+rUGPvzygOyJrl5i5FScytIO8evMLXVT/3DazWMYoKClimKDx9W2NJIEW843nLNpS7bKO oUYMBp9Tmw0chJflNR9o11krJ604l6Dfljh8JloKLm6LUY8a+Bo+nEUaTIl3eRqS7p4HElHSqoG C++VbclYGn0gsI06eTJS0QzPs+e360a7TZg/UfuUuZTkGkFK
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
 drivers/spi/spi-sh-hspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index a62034e2a7cb..d6ffeae66ed3 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -276,15 +276,13 @@ static int hspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hspi_remove(struct platform_device *pdev)
+static void hspi_remove(struct platform_device *pdev)
 {
 	struct hspi_priv *hspi = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
 
 	clk_put(hspi->clk);
-
-	return 0;
 }
 
 static const struct of_device_id hspi_of_match[] = {
@@ -295,7 +293,7 @@ MODULE_DEVICE_TABLE(of, hspi_of_match);
 
 static struct platform_driver hspi_driver = {
 	.probe = hspi_probe,
-	.remove = hspi_remove,
+	.remove_new = hspi_remove,
 	.driver = {
 		.name = "sh-hspi",
 		.of_match_table = hspi_of_match,
-- 
2.39.1

