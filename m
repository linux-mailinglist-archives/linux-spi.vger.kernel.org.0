Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EDC6A9D5B
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCCRVg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjCCRVQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C321498B3
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95g-00078f-Ir; Fri, 03 Mar 2023 18:21:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95f-001bos-Ss; Fri, 03 Mar 2023 18:21:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95e-001tml-MB; Fri, 03 Mar 2023 18:21:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 77/87] spi: synquacer: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:31 +0100
Message-Id: <20230303172041.2103336-78-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=E0G2X9dV+atZQMnBljstN/VPgCB/dcA2sW7aOmGj5ZY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiw7fCU37dLw4TlNUcPIJQbD3PgXUn7WhErUO 93ERdkdQYmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsOwAKCRDB/BR4rcrs Cc4uB/9B9SY9MN0fWBOsiG5jxXnWDCNg+z7IH6r5ItdEMRPYkH6N9MmTRRINZLld1fvMH6i91OD BpUpV3tbUZO3Ata4rhJVN9kcwA/tXsQ0Q8BR/ygW5cb+ze7jS8c5YYPTZ43+0RYKu7f9dOsiNfG 7zz0tF3eSvPyIrt9Pw64kU9IRZHOAesz3nhw2kqcW+CQS5caKS5PtXUKqCa+oD51e7qjDWqc24p 6Ve/2MzxdZMAZYHD3uFYhIMFDbCfJLsmaRPJ0QnPYo8GLTnRJi32UL+U7Q37tfqf+wqm+tmU+bJ HEr+hOGabzHM6etXStx99tJoldy3o1sJPnDykmPTF2WYetRg
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
 drivers/spi/spi-synquacer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index dc188f9202c9..3a92f722a6c5 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -735,7 +735,7 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int synquacer_spi_remove(struct platform_device *pdev)
+static void synquacer_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct synquacer_spi *sspi = spi_master_get_devdata(master);
@@ -743,8 +743,6 @@ static int synquacer_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(sspi->dev);
 
 	clk_disable_unprepare(sspi->clk);
-
-	return 0;
 }
 
 static int __maybe_unused synquacer_spi_suspend(struct device *dev)
@@ -820,7 +818,7 @@ static struct platform_driver synquacer_spi_driver = {
 		.acpi_match_table = ACPI_PTR(synquacer_hsspi_acpi_ids),
 	},
 	.probe = synquacer_spi_probe,
-	.remove = synquacer_spi_remove,
+	.remove_new = synquacer_spi_remove,
 };
 module_platform_driver(synquacer_spi_driver);
 
-- 
2.39.1

