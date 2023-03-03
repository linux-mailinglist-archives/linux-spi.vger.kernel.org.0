Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80446A9D75
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjCCRVv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 12:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCCRV1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 12:21:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3D5551E
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 09:21:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95a-0006oS-5S; Fri, 03 Mar 2023 18:21:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-001bmA-Vw; Fri, 03 Mar 2023 18:21:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pY95Y-001tkj-3i; Fri, 03 Mar 2023 18:21:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 45/87] spi: npcm-fiu: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 18:19:59 +0100
Message-Id: <20230303172041.2103336-46-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iYf4/+pZQ85wQgzIBSPxY+nvo82E2hPm8r7TI+SLMq4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAiu69mOQSWOjd8Q2SD7YDWapcUO/5xhwRCk8r ninGpNE9+iJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAIrugAKCRDB/BR4rcrs CfBYB/9S2zgGAe66UUwbkD8SgXVlFFJ+PaLCH0+gD9EEhPrnCSZ4OlDfxA5iGIv7CHljn/nXdVv P9OFfhI6UTA+TEkCCE+4tLgvmDcz05hUo05SiStc6HE5cuWJ9g2ZXdIHmHJU8wImbskKJ58DoXw EdTQXMF0amkvp0ofKfyhUFY2LwT/ufqiARcp4B/5/qkgB7FwMYUD21j4Dw/oBbeh6CMYn+Paj50 6QU/3UPsXDlMKpWTRyeLbh111rgkx/sAJkaXSFYlQCF6bzX1pm9SWE0zB34hvye76t0GndbJp3f ylgGyf1SD5g4ae8xukBpuBSweObbYvoZun5TyfLh9XGmwLlF
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
 drivers/spi/spi-npcm-fiu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 559d3a5b4062..8d7698d167ef 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -762,12 +762,11 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int npcm_fiu_remove(struct platform_device *pdev)
+static void npcm_fiu_remove(struct platform_device *pdev)
 {
 	struct npcm_fiu_spi *fiu = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(fiu->clk);
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, npcm_fiu_dt_ids);
@@ -779,7 +778,7 @@ static struct platform_driver npcm_fiu_driver = {
 		.of_match_table = npcm_fiu_dt_ids,
 	},
 	.probe      = npcm_fiu_probe,
-	.remove	    = npcm_fiu_remove,
+	.remove_new	    = npcm_fiu_remove,
 };
 module_platform_driver(npcm_fiu_driver);
 
-- 
2.39.1

