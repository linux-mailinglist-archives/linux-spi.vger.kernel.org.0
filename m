Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EDF6A9D5E
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCCRVh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCCRVR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4291C4743D
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-00074T-Go; Fri, 03 Mar 2023 18:21:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-001boK-M9; Fri, 03 Mar 2023 18:21:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-001tmX-RL; Fri, 03 Mar 2023 18:21:05 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 73/87] spi: stm32: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:27 +0100
Message-Id: <20230303172041.2103336-74-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TTzji5qZuKUEjFFALcmPwLVE5by1HIpRjVd3ggKjoqg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwmxvr9esPSJVH5g3dbhmj4salWV2V+ja3L1 clwRFsikZSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsJgAKCRDB/BR4rcrs CbU2B/9tBylijbSzh84LNRPeuDQ2AJ2zYYwjs0PXJC98NEms2VKjmdiihvSxC+Uj7awn8bN4UFK FVaXmElsMZPkZPb/H3inzmoXSKP7qvjXOy1fB9aYtTwn4I7YqN+DXRL+1Rd1AJOs1JyknRdyusk KsRILGf4DbfoReFAxj4MSdbfs+93DN1d7OcDM0aABAwFjO07Auz+PR8SeTjAPYoRf9M+kO664H3 LVD3YOYJIhcBibqM5no5j3LIGcdbGiRSDCAVqzRCeNGTwsoeHt8zmxAZSs3ir0Hw/yYXurTLIYn 3KDPTdth+C6KjUyq9Ba6ejiPLOVcKlfo9FolbUKVic2mc8SG
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
 drivers/spi/spi-stm32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index def09cf0dc14..9ccb52296e57 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1922,7 +1922,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_spi_remove(struct platform_device *pdev)
+static void stm32_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct stm32_spi *spi = spi_master_get_devdata(master);
@@ -1946,8 +1946,6 @@ static int stm32_spi_remove(struct platform_device *pdev)
 
 
 	pinctrl_pm_select_sleep_state(&pdev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused stm32_spi_runtime_suspend(struct device *dev)
@@ -2023,7 +2021,7 @@ static const struct dev_pm_ops stm32_spi_pm_ops = {
 
 static struct platform_driver stm32_spi_driver = {
 	.probe = stm32_spi_probe,
-	.remove = stm32_spi_remove,
+	.remove_new = stm32_spi_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.pm = &stm32_spi_pm_ops,
-- 
2.39.1

