Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C757A3155
	for <lists+linux-spi@lfdr.de>; Sat, 16 Sep 2023 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjIPQNO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 Sep 2023 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbjIPQMp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 Sep 2023 12:12:45 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145CACC6
        for <linux-spi@vger.kernel.org>; Sat, 16 Sep 2023 09:12:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhXuQ-0001Pa-Ix; Sat, 16 Sep 2023 18:12:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhXuQ-006ngg-2j; Sat, 16 Sep 2023 18:12:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qhXuP-0028Lo-Pu; Sat, 16 Sep 2023 18:12:37 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] spi: Drop warning from spi_stop_queue()
Date:   Sat, 16 Sep 2023 18:12:35 +0200
Message-Id: <20230916161235.1050176-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=812; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FxP0mdi2NzNYzO8HgyLC6cn0Nj2TIBXtUgnDY+xKTpg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlBdPyxIqZSM4Vp3fh0ndFJKru3HOR33pRxbSlO gMbsavNSMeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQXT8gAKCRCPgPtYfRL+ TpehB/4mhAwTcipXvD4wSEN1VsdxgyDUoNQKf6b+CtTMUU30eXfqas5iX4wiB3AVJEK2ECoCmOn as6xdGjaFbmbXaAxxEs5eU9gxYSyoZiffQ+1zHWUJD/J2Asf3IjR86aZHnz+BXemiGmP8Bg64A5 8zqJzKsM8lg4Ws4+FzhHH935i1CXeFKsiF6oO32p67WfrM3ZyBvlOZ+GG4cbZbqkBpCpa2Ks8DO VLoDslU/C3jnbf5K4dcEO4QmSSgKB1FQOR2HeGcVsL3Tb2pllidkz4M9duWls0abxIsHmojlOe/ w8vMq0+M7XgV+4Eq3Z0m+mYL6meXERrbyxQd5hgj5XkmEmgi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Both callers of spi_stop_queue() (i.e. spi_destroy_queue() and
spi_controller_suspend()) already emit an error message if
spi_stop_queue() fails. Another warning in this case isn't helpful, so
drop it.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8d6304cb061e..ac518be34917 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2093,10 +2093,6 @@ static int spi_stop_queue(struct spi_controller *ctlr)
 
 	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
-	if (ret) {
-		dev_warn(&ctlr->dev, "could not stop message queue\n");
-		return ret;
-	}
 	return ret;
 }
 

base-commit: dfa449a58323de195773cf928d99db4130702bf7
-- 
2.40.1

