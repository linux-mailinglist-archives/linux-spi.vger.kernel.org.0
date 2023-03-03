Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8BC6A9D50
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjCCRV3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjCCRVN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323044FA90
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-00071m-D4; Fri, 03 Mar 2023 18:21:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-001bns-BD; Fri, 03 Mar 2023 18:21:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-001tm9-JU; Fri, 03 Mar 2023 18:21:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 67/87] spi: sifive: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:21 +0100
Message-Id: <20230303172041.2103336-68-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Tl7WkauIutM+b3al3H9SYheO/VLRXWleqG0ok9ZALEM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwP6Nec85xqvkHvbxOkc/4mdy7srvBaTQekZ w0Q1BH74N+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsDwAKCRDB/BR4rcrs CdjyCACLr+zFqnQpOA6JiQxM9YjKlvQVr0zzLOTl4aT/8OfjOzJgE99fhZXdxWktwMpl1qs4pLY 9eg8Ti2aLX+ZnB4ZXgHnvbSGiA9qMkRaCHVvLkU/nVeGIYe1GFEB+qcopMOl0oFbnNR3cnK05k6 LQ5Nnd/QHNLI7loh6Lb+67uo+48wzGYmvtn17jFVZbfPH53MECPjlf8cBFz0sNMR6ojTsyD43cu VK0y9iqxmu0D+PMKC9Q3YjRFRBu30VDEcSzg2zR69vLayDbyWaZPlyDAZ7+81BbEWlrkN3Hmtf0 9sA9nQk8NVTOz1bSvED4ILUiOnao/fJw0mQmr6RmaK84cZ4s
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
 drivers/spi/spi-sifive.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index e29e85cee88a..055de44e0d22 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -415,7 +415,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sifive_spi_remove(struct platform_device *pdev)
+static void sifive_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct sifive_spi *spi = spi_master_get_devdata(master);
@@ -423,8 +423,6 @@ static int sifive_spi_remove(struct platform_device *pdev)
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
 	clk_disable_unprepare(spi->clk);
-
-	return 0;
 }
 
 static int sifive_spi_suspend(struct device *dev)
@@ -473,7 +471,7 @@ MODULE_DEVICE_TABLE(of, sifive_spi_of_match);
 
 static struct platform_driver sifive_spi_driver = {
 	.probe = sifive_spi_probe,
-	.remove = sifive_spi_remove,
+	.remove_new = sifive_spi_remove,
 	.driver = {
 		.name = SIFIVE_SPI_DRIVER_NAME,
 		.pm = &sifive_spi_pm_ops,
-- 
2.39.1

