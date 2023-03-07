Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465676AF74E
	for <lists+linux-spi@lfdr.de>; Tue,  7 Mar 2023 22:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCGVOq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Mar 2023 16:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCGVOn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Mar 2023 16:14:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7C97FCA
        for <linux-spi@vger.kernel.org>; Tue,  7 Mar 2023 13:14:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedk-0002H1-LM; Tue, 07 Mar 2023 22:14:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedj-002ZBb-Gn; Tue, 07 Mar 2023 22:14:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZedi-0037Bc-Qx; Tue, 07 Mar 2023 22:14:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] spi: sprd: Don't skip cleanup in remove's error path
Date:   Tue,  7 Mar 2023 22:14:25 +0100
Message-Id: <20230307211426.2331483-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307211426.2331483-1-u.kleine-koenig@pengutronix.de>
References: <20230307211426.2331483-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XEYAs5miJYaL3PL0ukKjVbFyEFLZ4zlx4dsmrXQGDEA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkB6kqihPLeAxx+reEYxHTiWP2bmDHUWxeZaQY5 hV1XpRglOWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAepKgAKCRDB/BR4rcrs CZIoB/9vrk8WoE60soVGhHnvaJW4xPW1o72OnB9YvhqYP+qHZINgbo97pbeK+Y6Fyza9mdiVs6Y cBNJAkWal6lBILU7/oI5gSYaoEkvxu65HZYv8inU3plUSuCPTIfXe3fZDbOHo7TPpswQ5jaQMBk zqVYEbULasSKslZecq4FrhlSqh5iHEGxlUZ6ejlOHqVFoP0CK/yqPzHbEhim0XfOby1I/QauO2C sFPapzAXvG+aFtWO3lf8QUwSiZLq2BfclltEKhH0IKksuwOqO3/SEM/8AgvT5V6LPO/nCQoquBq UqCAv1O2Jo8t+mRsqASfB/a2T2NWWjx3qnrmVfjTEPddj8W9
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

If pm_runtime_resume_and_get() failed before this change, two error
messages were printed. One directly in sprd_spi_remove() and another
by the device core as the return value is non-zero.

The better handling of a failure to resume the device is to do the
software related cleanup anyhow and only skip hardware accesses.
This leaves the device in an unknown state, but there is nothing that can
be done about that.

Even in the error case, return zero to suppress the device core's error
message.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-sprd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 65b8075da4eb..45b69b83a7e4 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -1008,17 +1008,17 @@ static int sprd_spi_remove(struct platform_device *pdev)
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(ss->dev);
-	if (ret < 0) {
+	ret = pm_runtime_get_sync(ss->dev);
+	if (ret < 0)
 		dev_err(ss->dev, "failed to resume SPI controller\n");
-		return ret;
-	}
 
 	spi_controller_suspend(sctlr);
 
-	if (ss->dma.enable)
-		sprd_spi_dma_release(ss);
-	clk_disable_unprepare(ss->clk);
+	if (ret >= 0) {
+		if (ss->dma.enable)
+			sprd_spi_dma_release(ss);
+		clk_disable_unprepare(ss->clk);
+	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.39.1

