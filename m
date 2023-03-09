Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9D6B2089
	for <lists+linux-spi@lfdr.de>; Thu,  9 Mar 2023 10:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCIJsB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Mar 2023 04:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCIJrn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 04:47:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B11BCB98
        for <linux-spi@vger.kernel.org>; Thu,  9 Mar 2023 01:47:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCrc-0007fx-K7; Thu, 09 Mar 2023 10:47:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCrb-002uv8-3P; Thu, 09 Mar 2023 10:47:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paCra-003VnH-C3; Thu, 09 Mar 2023 10:47:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] spi: mt65xx: Properly handle failures in .remove()
Date:   Thu,  9 Mar 2023 10:47:02 +0100
Message-Id: <20230309094704.2568531-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
References: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yh/+04G2mPy0dKpao1v1bYKj6AZtMwDC3Z1eft87mk8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCasNEPvAeZV5KK/fHmPsGkPJLZO1RWfvtok0y vsIcxFeGvKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAmrDQAKCRDB/BR4rcrs Cdu4CACSHiTTHFcll04uCZUeJeS6AR0504iswcnVvtXCR0dvRFXwtXIAj5DvGLMrkygpvLzy8Fz D4SbbRNC4So/Ceks6J9QWMLbZ/IKNoxLop7z7vEEYHIsHzLcwsbj37ayJy11VQhRQB37LhGwfu5 0r02zYlvSfCIqn/AFLhxgS69bCZ3IueW2KOj7pAxeatoSKbsOpo3HfXw2Lb9n8gLNM8RDC77c5H VBLIk9vUpn4LB4uvVkM+esu6R9MjHz2AXoagZuSWSbkWyoNjqFFRpWENSLur8yKpsurqFHBPdqb R5Ayfg7SUenHGDpwcIcube0sXIbKW32Ym15STa+1XDXKVqBM
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

Returning an error code in a platform driver's remove function is wrong
most of the time and there is an effort to make the callback return
void. To prepare this rework the function not to exit early.

There wasn't a real problem because if pm runtime resume failed the only
step missing was pm_runtime_disable() which isn't an issue.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-mt65xx.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 9eab6c20dbc5..b1cf7bbb2c08 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1275,15 +1275,20 @@ static int mtk_spi_remove(struct platform_device *pdev)
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
-
-	mtk_spi_reset(mdata);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	/*
+	 * If pm runtime resume failed, clks are disabled and unprepared. So
+	 * don't access the hardware and skip clk unpreparing.
+	 */
+	if (ret >= 0) {
+		mtk_spi_reset(mdata);
 
-	if (mdata->dev_comp->no_need_unprepare) {
-		clk_unprepare(mdata->spi_clk);
-		clk_unprepare(mdata->spi_hclk);
+		if (mdata->dev_comp->no_need_unprepare) {
+			clk_unprepare(mdata->spi_clk);
+			clk_unprepare(mdata->spi_hclk);
+		}
+	} else {
+		dev_warn(&pdev->dev, "Failed to resume hardware (%pe)\n", ERR_PTR(ret));
 	}
 
 	pm_runtime_put_noidle(&pdev->dev);
-- 
2.39.1

