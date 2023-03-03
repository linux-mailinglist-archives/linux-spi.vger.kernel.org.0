Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E6B6A9D46
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjCCRV0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCCRVM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D954DE3E
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-00071W-Un; Fri, 03 Mar 2023 18:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95d-001bnn-3Z; Fri, 03 Mar 2023 18:21:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95c-001tm3-D0; Fri, 03 Mar 2023 18:21:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 66/87] spi: sh: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:20 +0100
Message-Id: <20230303172041.2103336-67-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7oroaFd5EHRJUaqjBjhzjnnyD5fH0iV0ap8yQsUg5H0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiwMXNQLqrNzJse4lMsVo5r/0O7YarRF3bcWd xaxREKg5n2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIsDAAKCRDB/BR4rcrs CexQB/9OlWJvcTk+x8Z10C5tvmG1O7cYcXe23R6oKPadSSuebdzaoPCVqYe058vxqNVv0/lpO9W 53OhWr5D9cwamMLo0Uo+S8hHasOWJ++DpGdgSDMwORx8ZmSlEHVUocboufhlbarfRVxXaS5GC2M p41BBygkfWqwAcNOpsWE5zRlszE9i0dlLzXwrVgyz8QysNaebqrF8ZlpUN/OtXKRRHmiChwUnuF /3TAkg6wlQ38KMdsN72EXNA0aK4yUoQDDnok92/f9QORn2hC3h09ODVVZKvZJoHeREtx2T3yypz 9CvYWE9t9pwEGEe8c9AKfR/0iEwH0OMW1JjwG+QgxAVv5NMy
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
 drivers/spi/spi-sh.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 3e72fad99adf..d358a2a9c3f5 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -377,14 +377,12 @@ static irqreturn_t spi_sh_irq(int irq, void *_ss)
 	return IRQ_HANDLED;
 }
 
-static int spi_sh_remove(struct platform_device *pdev)
+static void spi_sh_remove(struct platform_device *pdev)
 {
 	struct spi_sh_data *ss = platform_get_drvdata(pdev);
 
 	spi_unregister_master(ss->master);
 	free_irq(ss->irq, ss);
-
-	return 0;
 }
 
 static int spi_sh_probe(struct platform_device *pdev)
@@ -461,7 +459,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 
 static struct platform_driver spi_sh_driver = {
 	.probe = spi_sh_probe,
-	.remove = spi_sh_remove,
+	.remove_new = spi_sh_remove,
 	.driver = {
 		.name = "sh_spi",
 	},
-- 
2.39.1

