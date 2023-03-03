Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167636A9D09
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCCRU7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCCRU5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:20:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E1A457C3
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:20:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95S-0006Pg-7O; Fri, 03 Mar 2023 18:20:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95R-001bjA-Gk; Fri, 03 Mar 2023 18:20:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Q-001tiK-GP; Fri, 03 Mar 2023 18:20:52 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 08/87] spi: axi-spi-engine: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:22 +0100
Message-Id: <20230303172041.2103336-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oZbnymJ/6nceM3CjEirGLANrMdtFRic5hTpBsx/yk24=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaQwaWvaMbEoeJ55tWlRuvQBs/BO5cvBznzvNilydmdUP nzjcTi+k9GYhYGRi0FWTJGlrkhLbILEmv92JUu4YQaxMoFMYeDiFICJKEax/5VQ+Fo4JderTvTY E21GTx71hIis+W/LzDuaZposv6woe23rzU2q1/dbXUrIF4vfkuhy5ez20LIagYkaMye9XNTaZLV wx8cqix7vnr17mCNfq07fHr3eIfjPwfS8DXN3Xu7a99I1797eHDnDf3IWmy9mH+54L5tYYXFvqS R30UyDkNjnHgpW53mMQtUuxddHfuBewMTc4/vOvNo+aON004+vLSx2vJlzri0v2pVnZskUEfudX bbsHN7Gj+938zUGLPjxTpgvP8jLXKJuW+ipXZ9NYpUmJOXdfaFc4Hp+D8/zRx8uuabEqUyY4/pS 8quQz7N/Sg53xXoUGq371mWqHFt2sMfL+jUH4+dZ54L1AQ==
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
 drivers/spi/spi-axi-spi-engine.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 80c3e38f5c1b..c5a3a3189164 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -554,7 +554,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spi_engine_remove(struct platform_device *pdev)
+static void spi_engine_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct spi_engine *spi_engine = spi_master_get_devdata(master);
@@ -572,8 +572,6 @@ static int spi_engine_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(spi_engine->ref_clk);
 	clk_disable_unprepare(spi_engine->clk);
-
-	return 0;
 }
 
 static const struct of_device_id spi_engine_match_table[] = {
@@ -584,7 +582,7 @@ MODULE_DEVICE_TABLE(of, spi_engine_match_table);
 
 static struct platform_driver spi_engine_driver = {
 	.probe = spi_engine_probe,
-	.remove = spi_engine_remove,
+	.remove_new = spi_engine_remove,
 	.driver = {
 		.name = "spi-engine",
 		.of_match_table = spi_engine_match_table,
-- 
2.39.1

