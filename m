Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3157118D4
	for <lists+linux-spi@lfdr.de>; Thu, 25 May 2023 23:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjEYVK5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 May 2023 17:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEYVK4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 May 2023 17:10:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C6E198
        for <linux-spi@vger.kernel.org>; Thu, 25 May 2023 14:10:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2IEY-0001PJ-A6; Thu, 25 May 2023 23:10:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2IEX-002oIX-Hs; Thu, 25 May 2023 23:10:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2IEW-007xiT-II; Thu, 25 May 2023 23:10:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] spi: Switch i2c drivers back to use .probe()
Date:   Thu, 25 May 2023 23:10:47 +0200
Message-Id: <20230525211047.735789-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BY+L1LqNx1bzYl/1uBJbb3bjfZT8f6QO+X1x0noj/4c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkb87P67bfKop0viop3P0PNiCLjkpa0heazdWQj 5WRWm+coKaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG/OzwAKCRCPgPtYfRL+ ToJFB/42S3hcZGSQlzeorAi4Ui9SxvibglygdzgKMVSZSyQ6vgxvTnbYAJLZgj1kPAAqUDSVkbg gtzeir/VUCSqPHR+Uh9fJHawBIrxndkEGd36NjwD1uOiMy8LW94TR/78DwKH7vlWo+F0qoq/8aW 181ymEhPRtgYD33R049vWhXyjt7utgJmBm2TWn5m3URA8QKJb8VK7Og0j3dtm6n3Tz4GNzKptrl MG6xbmpQV4E6erVJQH/2m4LAvz0OU/fbnKdWavVfbw2o43ywWQSQ6DDdcQu5Lxl5480Dyc1lkIu CdaOYPEp3+FV5jTXg+UqPB6U0SDudBiultYCGvmiqhd+e1O8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
convert back to (the new) .probe() to be able to eventually drop
.probe_new() from struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-sc18is602.c | 2 +-
 drivers/spi/spi-xcomm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 70012333020b..d52ed67243f7 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -337,7 +337,7 @@ static struct i2c_driver sc18is602_driver = {
 		.name = "sc18is602",
 		.of_match_table = of_match_ptr(sc18is602_of_match),
 	},
-	.probe_new = sc18is602_probe,
+	.probe = sc18is602_probe,
 	.id_table = sc18is602_id,
 };
 
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 5d23411f2a3e..ae6218bcd02a 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -241,7 +241,7 @@ static struct i2c_driver spi_xcomm_driver = {
 		.name	= "spi-xcomm",
 	},
 	.id_table	= spi_xcomm_ids,
-	.probe_new	= spi_xcomm_probe,
+	.probe		= spi_xcomm_probe,
 };
 module_i2c_driver(spi_xcomm_driver);
 

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

