Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E836A9D13
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCCRVB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjCCRU6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB74616A
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95U-0006Uy-7O; Fri, 03 Mar 2023 18:20:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-001bjx-HC; Fri, 03 Mar 2023 18:20:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-001tiz-Gu; Fri, 03 Mar 2023 18:20:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 18/87] spi: coldfire-qspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:32 +0100
Message-Id: <20230303172041.2103336-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iMVUpsYO0UWfu5eoNoh+k0vZnRxkfMP25Slkk4CHu5k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitO8TYUMvabs5oJ2sWjPoHi8zoGeb4HEQelM TLXEgMa5PyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrTgAKCRDB/BR4rcrs CWRvCACdrE/VqBk7gxoghdMSuaJTrR+srFV0+3WKq3izQ+2TCNEwdmMN26E/98myVD5DPPeZq7U vVqSp2j7xG7hhhHB6JhgjOLACdBci0U6VVBgwqvx8eNhimsG766/GTt+wKf4gy0HyONtfGfyMmp 26l/SFMEt3UQgSOe7oVWqUX8iaHjSbHhiukvMkavQ5j/FSMrK2bhmf4exQ+CCnh7VGEEAbK0YrB QpQ1iJ8nCdvLwJP7yYyOrgKobji9wZG/NnN5KPZghpOxXQljS0nM5yndqXiSYcNlZtXqIoeky2p 7KRJxKmNYRu029wQsYXT51Puc3HjPDwWVKScHPpmVejurXXD
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
 drivers/spi/spi-coldfire-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 263ce9047327..d98e74c6e4b2 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -434,7 +434,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	return status;
 }
 
-static int mcfqspi_remove(struct platform_device *pdev)
+static void mcfqspi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct mcfqspi *mcfqspi = spi_master_get_devdata(master);
@@ -445,8 +445,6 @@ static int mcfqspi_remove(struct platform_device *pdev)
 
 	mcfqspi_cs_teardown(mcfqspi);
 	clk_disable_unprepare(mcfqspi->clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -509,7 +507,7 @@ static struct platform_driver mcfqspi_driver = {
 	.driver.owner	= THIS_MODULE,
 	.driver.pm	= &mcfqspi_pm,
 	.probe		= mcfqspi_probe,
-	.remove		= mcfqspi_remove,
+	.remove_new	= mcfqspi_remove,
 };
 module_platform_driver(mcfqspi_driver);
 
-- 
2.39.1

