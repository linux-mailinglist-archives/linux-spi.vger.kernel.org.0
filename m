Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B06A9D57
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjCCRVd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjCCRVP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5754C4ECDB
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-00075o-4d; Fri, 03 Mar 2023 18:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-001bob-8C; Fri, 03 Mar 2023 18:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-001tmg-Go; Fri, 03 Mar 2023 18:21:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Li-hao Kuo <lhjeff911@gmail.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 76/87] spi: sunplus-sp7021: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:30 +0100
Message-Id: <20230303172041.2103336-77-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BC8y6HiHTBuf/4tooOQVWB0tHvZfgo9E3XZjZvI4uHY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiw3b+ngxLpEsKB+gJjnwpcbAArD4QX2ftHen dXvuE4Y3HGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsNwAKCRDB/BR4rcrs CcUbB/9LR10MAXWd/ZlMyQpRp63cOY+D1MgoIvs8OFL/4uqCwW71SRxohTWFp/8s9fKi9lpI0xN +nLSDGzTKw4R5PxiZRzdyg/UnUhV4sL0Xc0T9vI8uyytkgRMrXLzyG0A4LKqUFBUtOAVK9SPltB Zy3yi6thHdcRRj8nQjV2Vf//zcUoEtYmuk4hQzQ+UMeysMy9ZT4SrixbCf9HxHvSGR6iS6FK4bh 6yaksWCjXek+FsQOIG0eM2XxuEYAi1JT3yalvfj4sERbSjgtktfnZnO7kibvQIgrxXWlQhJsR0m tnZsLqpQYmWssWkORob4/veGO/cvb7NonL384Wm0AEnbTDHm
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
 drivers/spi/spi-sunplus-sp7021.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index f1fa88777575..eb8f835a4771 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -504,14 +504,13 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sp7021_spi_controller_remove(struct platform_device *pdev)
+static void sp7021_spi_controller_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
 
 	spi_unregister_controller(ctlr);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-	return 0;
 }
 
 static int __maybe_unused sp7021_spi_controller_suspend(struct device *dev)
@@ -564,7 +563,7 @@ MODULE_DEVICE_TABLE(of, sp7021_spi_controller_ids);
 
 static struct platform_driver sp7021_spi_controller_driver = {
 	.probe = sp7021_spi_controller_probe,
-	.remove = sp7021_spi_controller_remove,
+	.remove_new = sp7021_spi_controller_remove,
 	.driver = {
 		.name = "sunplus,sp7021-spi-controller",
 		.of_match_table = sp7021_spi_controller_ids,
-- 
2.39.1

