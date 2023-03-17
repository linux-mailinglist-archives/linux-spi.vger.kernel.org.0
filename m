Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6ED6BE418
	for <lists+linux-spi@lfdr.de>; Fri, 17 Mar 2023 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjCQIoJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Mar 2023 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjCQIny (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Mar 2023 04:43:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57495ADE6
        for <linux-spi@vger.kernel.org>; Fri, 17 Mar 2023 01:42:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fd-0004u1-7M; Fri, 17 Mar 2023 09:42:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fc-004jZb-JZ; Fri, 17 Mar 2023 09:42:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pd5fb-005ZuO-LR; Fri, 17 Mar 2023 09:42:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 3/3] spi: atmel-quadspi: Convert to platform remove callback returning void
Date:   Fri, 17 Mar 2023 09:42:32 +0100
Message-Id: <20230317084232.142257-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
References: <20230317084232.142257-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PDDARCztnzeeACQTDkoYpF/WOv+1r9Jt3pt2LXsIig0=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaSIqL/X1nzoEVj3sF3lTjtn5t2zH7Qy3il/FTGcFxGmb xP1m127k9GYhYGRi0FWTJGlrkhLbILEmv92JUu4YQaxMoFMYeDiFICJTKxl/2cXEB3T4M1bu7kg SSzpy4zNVuvmRRQt/bTMQDfXllF8xtIPysv9K2LPpHoXSc6zi8h44d30pnN97YvJrUn1v3e08/y ryV30rao1T+SSNlth4UJRFm7FdzM9eYP5d8Q0RjDnTTmglGJef/DS9IzbMzQ+J9Utv7dC1thHrV pboljAnJ39x7foEreZR6sDWJKT91Soc0p8NtOWl5gwv7vnSFMW886Xs9tvF1/S/1RzX7TkWY+p6 q//r60vOyUf8AotfXHh5aYNj/N+9Raum/r1QOdx+Yb5DFOn7ox+7KuyzHZuhkTe5aU750t0LD6w JnL+u4MdPu1cnj+emCYv/1sRmsfZusx/15OKnJfVObk/AQ==
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
 drivers/spi/atmel-quadspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 713a4d6700fd..3d1252566134 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -700,7 +700,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int atmel_qspi_remove(struct platform_device *pdev)
+static void atmel_qspi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctrl = platform_get_drvdata(pdev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
@@ -727,8 +727,6 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused atmel_qspi_suspend(struct device *dev)
@@ -837,7 +835,7 @@ static struct platform_driver atmel_qspi_driver = {
 		.pm	= pm_ptr(&atmel_qspi_pm_ops),
 	},
 	.probe		= atmel_qspi_probe,
-	.remove		= atmel_qspi_remove,
+	.remove_new	= atmel_qspi_remove,
 };
 module_platform_driver(atmel_qspi_driver);
 
-- 
2.39.2

