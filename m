Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB656BE419
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 09:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjCQIoL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 04:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjCQIn4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 04:43:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA207B13C
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 01:42:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fc-0004to-Rr; Fri, 17 Mar 2023 09:42:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fc-004jZY-8H; Fri, 17 Mar 2023 09:42:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fb-005ZuL-EQ; Fri, 17 Mar 2023 09:42:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 2/3] spi: atmel-quadspi: Free resources even if runtime resume failed in .remove()
Date:   Fri, 17 Mar 2023 09:42:31 +0100
Message-Id: <20230317084232.142257-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
References: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wcZEDK6jMK5sZr1RQTMLf3OvBQXFaDeXg787/wcigb4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkFCfss1jfdAoMEQrEI0C4lHiBRK1/GFtyNKexE 3fBs7v1hA+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBQn7AAKCRDB/BR4rcrs CQeRB/9pJSiQmrh79W/k7Ts8t5stJ6VTTAZHakpGzwFSCE1/ybXcB6u/CAaTB3DIT69w1w6uU01 8Bi0YvkvSKRRzGLmfGFHf8Q0XMOrjxN7OF/DqdQ5fnau2xsnUinvkiDSAn8tpesWFoQT3vbea83 2XnA4xscr/PRSl6FH2Ycf0HDV4baK1l2CpNqcOKsrQSsc9s3f1vy4y4R4I/u7j4rI6PbxK1IDSB PvkeNxuMkqpw4HlsKFPRyJP+whkwDY7pEjNnZUZXqATBPmOxt95djEPxoRobHxKEClAWWf+Blai 2XXPciX4lHUpqGJjiSRm4Gbq4V4OGpCJ1dTl3NcUDqUjpi31
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

An early error exit in atmel_qspi_remove() doesn't prevent the device
unbind. So this results in an spi controller with an unbound parent
and unmapped register space (because devm_ioremap_resource() is undone).
So using the remaining spi controller probably results in an oops.

Instead unregister the controller unconditionally and only skip hardware
access and clk disable.

Also add a warning about resume failing and return zero unconditionally.
The latter has the only effect to suppress a less helpful error message by
the spi core.

Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/atmel-quadspi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 0c6f80ddea57..713a4d6700fd 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -706,18 +706,28 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
-
 	spi_unregister_controller(ctrl);
-	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret >= 0) {
+		atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
+		clk_disable(aq->qspick);
+		clk_disable(aq->pclk);
+	} else {
+		/*
+		 * atmel_qspi_runtime_{suspend,resume} just disable and enable
+		 * the two clks respectively. So after resume failed these are
+		 * off, and we skip hardware access and disabling these clks again.
+		 */
+		dev_warn(&pdev->dev, "Failed to resume device on remove\n");
+	}
+
+	clk_unprepare(aq->qspick);
+	clk_unprepare(aq->pclk);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	clk_disable_unprepare(aq->qspick);
-	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
 
-- 
2.39.2

