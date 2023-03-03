Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA86A9D2D
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjCCRVN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCCRVE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A847412
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95X-0006hU-5M; Fri, 03 Mar 2023 18:20:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001bkz-Tm; Fri, 03 Mar 2023 18:20:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95V-001tjt-8z; Fri, 03 Mar 2023 18:20:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kamal Dasu <kdasu.kdev@gmail.com>, Mark Brown <broonie@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 32/87] spi: iproc-qspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:46 +0100
Message-Id: <20230303172041.2103336-33-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ZtW21SET9WsT59Aprw5i2BQREGTbWN96YwW71PZaF08=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiuGxM/Q0c5wC5Jf5X7tRvDMyuKpBzufX12SW RU1pE0g6HuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrhgAKCRDB/BR4rcrs CbL0B/4hpD7C9CO3lDlqSS/P8qHwH/TTV0WyASEF7QN94aUK90aPcFA7O/j/nInvxxuhVO8FaN6 kWSSt7N27Kjzm/CLYsDSIQOsVIs8a43xb/e2BmWIUhCaYE/qftgrX+atWgu4elGMP6s9kCQ2OqD l8Ho0Df8OzB+w5EVOpe+OVs0XAEOtOOHjh+ianDjx05O2iVfw3dG/53bXPc89oRU3qYHPubCjuE Iljo8gld/71tP5ohH04eKuL9cjqRBbpYjPtEDvdDEtL9naqJJsK0ljiS99bSG4LAg9juC3BjGwJ 0rk2ySl5tMSGAbPC+uFnGT+otSolANHiDgvw04FrPGPw5Pom
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
 drivers/spi/spi-iproc-qspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-iproc-qspi.c b/drivers/spi/spi-iproc-qspi.c
index 91cf8eb7213c..5980a0dbbccb 100644
--- a/drivers/spi/spi-iproc-qspi.c
+++ b/drivers/spi/spi-iproc-qspi.c
@@ -127,11 +127,9 @@ static int bcm_iproc_probe(struct platform_device *pdev)
 	return bcm_qspi_probe(pdev, soc_intc);
 }
 
-static int bcm_iproc_remove(struct platform_device *pdev)
+static void bcm_iproc_remove(struct platform_device *pdev)
 {
 	bcm_qspi_remove(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id bcm_iproc_of_match[] = {
@@ -143,7 +141,7 @@ MODULE_DEVICE_TABLE(of, bcm_iproc_of_match);
 
 static struct platform_driver bcm_iproc_driver = {
 	.probe			= bcm_iproc_probe,
-	.remove			= bcm_iproc_remove,
+	.remove_new		= bcm_iproc_remove,
 	.driver = {
 		.name		= "bcm_iproc",
 		.pm		= &bcm_qspi_pm_ops,
-- 
2.39.1

