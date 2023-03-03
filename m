Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE286A9D08
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjCCRU6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjCCRU5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FE0457FE
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-0006PZ-OD; Fri, 03 Mar 2023 18:20:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001bj5-4o; Fri, 03 Mar 2023 18:20:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-001tiH-Aa; Fri, 03 Mar 2023 18:20:52 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 07/87] spi: au1550: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:21 +0100
Message-Id: <20230303172041.2103336-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M9WTVgHyXJxi29UUSOJbLcj9bE7oloZpTz5/WtjZTA8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAislOp95d2o8AuCVtHcoG9gPjo7JswA8WMKeY gCm3+sl2fKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrJQAKCRDB/BR4rcrs CQsZB/4ym6xF+ARaZDqlPirJDMA/X4V/iB/SEPvSrDaMVoO9pJOsMQuf8denYl9fRNSaj1zmc+6 +kHiUL8jO+a30Co9DGWJJRM6qykbGN4gEnc1IsGqPPfoti1JGQATUR9j5Oh00iNESOSu92SzeRj 1bpOOcEKAUnxGK5ARYHBmDtAqQGnVXmPO2XmZ68jrjZHgOAmN5nH8PSl+iPR8AJMA+HqSh6sUs4 3zG/X2X59OThMQRU8PM+x6T3c8hH71YDIwy2GlN8bmZOhqoTSjKhqzPC7gChH97fpNtWDgLLOqg rh40rkbkzQlthjleM0dNRS0AbnCe5j54CbeTwA3FF7sa+6Kk
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
 drivers/spi/spi-au1550.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index e008761298da..8151bed8a117 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -923,7 +923,7 @@ static int au1550_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int au1550_spi_remove(struct platform_device *pdev)
+static void au1550_spi_remove(struct platform_device *pdev)
 {
 	struct au1550_spi *hw = platform_get_drvdata(pdev);
 
@@ -942,7 +942,6 @@ static int au1550_spi_remove(struct platform_device *pdev)
 	}
 
 	spi_master_put(hw->master);
-	return 0;
 }
 
 /* work with hotplug and coldplug */
@@ -950,7 +949,7 @@ MODULE_ALIAS("platform:au1550-spi");
 
 static struct platform_driver au1550_spi_drv = {
 	.probe = au1550_spi_probe,
-	.remove = au1550_spi_remove,
+	.remove_new = au1550_spi_remove,
 	.driver = {
 		.name = "au1550-spi",
 	},
-- 
2.39.1

