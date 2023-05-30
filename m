Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED165715825
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjE3IQ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjE3IQ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 04:16:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FDFA0
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 01:16:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXF-0008MP-By; Tue, 30 May 2023 10:16:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXE-003pUv-MN; Tue, 30 May 2023 10:16:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXD-009PLn-JI; Tue, 30 May 2023 10:16:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/3] spi: mt65xx: Properly handle failures in .remove()
Date:   Tue, 30 May 2023 10:16:46 +0200
Message-Id: <20230530081648.2199419-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
References: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HeehL14pDk9cEx04aGTWKlwLKl717iunpcSw/+seL1U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdbDswY5j4sTDtudQWCDRAEvAbQJO6XPfc5UaE Io3N3SICICJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWw7AAKCRCPgPtYfRL+ TiZdB/4qbqDn949mm9Z6UcMZ5URKLHmLfdgTSpsrMQYRdqh5z+2fv5PeoU+2/qjFFX0vFVpTDZ2 JJxoLprnB071k/LkxnJSEzfk0X7hmrxOXyO1CNEhjL5pQqgm/j8ZGgXCuZtvJG/IUjPdez9SWR+ u1a3d3AZ8Pw3e6TbPbz2f+d0GdO86hMAbRHJ80UVW7IeRbs1AcmvZiuC6Xp5SC2OX2rrInpM3wS 29OgCPy7HsWIpCy5LbUbx6u5KYUsaMiTGQ+jHXjYFzPrR2X0C2lt9iTPpCXkikAEUC9U8nweBmO PhbfYbwWB3sKC8iLIqIBVX3u5W4qvcqCfTS2/0/eT3aRmnF1
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

Returning an error code in a platform driver's remove function is wrong
most of the time and there is an effort to make the callback return
void. To prepare this rework the function not to exit early.

There wasn't a real problem because if pm runtime resume failed the only
step missing was pm_runtime_disable() which isn't an issue.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-mt65xx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 21c321f43766..9333a0e8204d 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1275,15 +1275,21 @@ static int mtk_spi_remove(struct platform_device *pdev)
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "Failed to resume hardware (%pe)\n", ERR_PTR(ret));
+	} else {
+		/*
+		 * If pm runtime resume failed, clks are disabled and
+		 * unprepared. So don't access the hardware and skip clk
+		 * unpreparing.
+		 */
+		mtk_spi_reset(mdata);
 
-	mtk_spi_reset(mdata);
-
-	if (mdata->dev_comp->no_need_unprepare) {
-		clk_unprepare(mdata->spi_clk);
-		clk_unprepare(mdata->spi_hclk);
+		if (mdata->dev_comp->no_need_unprepare) {
+			clk_unprepare(mdata->spi_clk);
+			clk_unprepare(mdata->spi_hclk);
+		}
 	}
 
 	pm_runtime_put_noidle(&pdev->dev);
-- 
2.39.2

