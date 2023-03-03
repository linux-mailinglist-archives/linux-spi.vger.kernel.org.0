Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D996A9D3C
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCCRVV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjCCRVK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2E498B3
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-0006oZ-3W; Fri, 03 Mar 2023 18:21:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Z-001bmF-2j; Fri, 03 Mar 2023 18:21:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-001tkq-GO; Fri, 03 Mar 2023 18:21:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Yogesh Gaur <yogeshgaur.83@gmail.com>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 47/87] spi: nxp-fspi: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:20:01 +0100
Message-Id: <20230303172041.2103336-48-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NpV3p/EIIg9B+9ncrHvdgT00bitwoVQbC+z1NJ8HbYg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAivB9Slb2dFzN7GstOv6NmQZ6iw8Ntlkcu0Z2 HtF6j7LxwuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrwQAKCRDB/BR4rcrs CXR8B/9/BqC3Qzm1/RYEYNqk2rbP4DzsN+GQTSb4FKjw8eoVoYmwBD9GzOCUhOD0QvyX2b92eKK ivN3/SKfciPvFnYNm1kq3z7xgt/BMpbn2g2EgVrM49gfahbi4C33nkeM8HYCBSFGYSKm7DQh83G pbivnwaBts/NOw1FWRT4HrWQPx6GisuNvxojDzaQFfd2qXKP73QMaBkBcR4E1b2y62C3RautGnp zJDNohrx2n3ns0SeHOWCvr9B1oO7f1loqrWTG+8OI1ap/gyDNLYRNTeKmkNNfZC1m+EVwt98OEd YuK8RnabQ2hg4Tq+HLwmiwqeRkUcdb5888KBfPzkAHwlYZ5D
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
 drivers/spi/spi-nxp-fspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1c1991a26c15..71be1ec3fbde 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1195,7 +1195,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int nxp_fspi_remove(struct platform_device *pdev)
+static void nxp_fspi_remove(struct platform_device *pdev)
 {
 	struct nxp_fspi *f = platform_get_drvdata(pdev);
 
@@ -1208,8 +1208,6 @@ static int nxp_fspi_remove(struct platform_device *pdev)
 
 	if (f->ahb_addr)
 		iounmap(f->ahb_addr);
-
-	return 0;
 }
 
 static int nxp_fspi_suspend(struct device *dev)
@@ -1257,7 +1255,7 @@ static struct platform_driver nxp_fspi_driver = {
 		.pm =   &nxp_fspi_pm_ops,
 	},
 	.probe          = nxp_fspi_probe,
-	.remove		= nxp_fspi_remove,
+	.remove_new	= nxp_fspi_remove,
 };
 module_platform_driver(nxp_fspi_driver);
 
-- 
2.39.1

