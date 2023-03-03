Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9336A9D0F
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjCCRVB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjCCRU6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0204391F
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95T-0006TT-NM; Fri, 03 Mar 2023 18:20:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-001bjh-VK; Fri, 03 Mar 2023 18:20:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-001tis-48; Fri, 03 Mar 2023 18:20:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 16/87] spi: cadence: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:30 +0100
Message-Id: <20230303172041.2103336-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lR7OfpjuDS7mGvl0HIqntcIllQ83+CE82PtB9P6xCJw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAitHiWBnp+h824X/8iuCE9bGUncUzdLdMQHaW 0zbryTl3x6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrRwAKCRDB/BR4rcrs CcH0CACQQw/qvWZAtX83dIQefSRXvaYT8SHGWal7mvGcRMwB6mVge6V+n1qSlXhzcgP/Uk2QfBR yCECvnfoEGx1Uk+RO1RkkFNqnzIfK+dFdywmdQHVL1jsSt8sh/6/d0XVzNSMI7BgEhZIGWexYGq 4AsJLERkBVYMCNHHQ5/kjNYUYF31UUpFryDUZsD0nKQCAmCwZ77omIkKgcvAsq+ueQc1b+Ljs+t kfQdDqULQAarDlAIVLMvkECIK8AxzFeLfzi6ZHuJHi+k+8nRhGD+Mm4rkYsZUzdSVf3YiVrhkGu yOmD1zNA/fTexMdvXqHK+yho80L6LfrOv8jNbgjkGugRoFF7
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
 drivers/spi/spi-cadence.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 6a7f7df1e776..1ad86e5d2b2f 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -625,7 +625,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
  *
  * Return:	0 on success and error value on error
  */
-static int cdns_spi_remove(struct platform_device *pdev)
+static void cdns_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
@@ -638,8 +638,6 @@ static int cdns_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	spi_unregister_master(master);
-
-	return 0;
 }
 
 /**
@@ -739,7 +737,7 @@ MODULE_DEVICE_TABLE(of, cdns_spi_of_match);
 /* cdns_spi_driver - This structure defines the SPI subsystem platform driver */
 static struct platform_driver cdns_spi_driver = {
 	.probe	= cdns_spi_probe,
-	.remove	= cdns_spi_remove,
+	.remove_new = cdns_spi_remove,
 	.driver = {
 		.name = CDNS_SPI_NAME,
 		.of_match_table = cdns_spi_of_match,
-- 
2.39.1

