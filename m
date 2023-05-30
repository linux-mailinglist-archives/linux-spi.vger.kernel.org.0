Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB46715826
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 10:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjE3IQ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 04:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjE3IQ4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 04:16:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E305A1
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 01:16:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXF-0008MO-AW; Tue, 30 May 2023 10:16:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXE-003pUu-LD; Tue, 30 May 2023 10:16:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3uXD-009PLq-Pi; Tue, 30 May 2023 10:16:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/3] spi: mt65xx: Convert to platform remove callback returning void
Date:   Tue, 30 May 2023 10:16:47 +0200
Message-Id: <20230530081648.2199419-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
References: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RMZEMdZ0GqYLZEELtvtNLR429tgOZGoJUI2pqpA2CY4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdbDuWdq8rXYgK7WodWwgE3y3t+cF8MaToAmwD 2WTnHYzJ5KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWw7gAKCRCPgPtYfRL+ Tj2/B/9etgpKKQOLXjPFtJ6cKloOTN73b/RnWt0UCOtUBYlD2E5ynsgoDH3hgzE9bFivNFJ/5ne 8XjzQPJwkz1dlwbL59bevn+pzXd5aRvJX6MFG/wFV1quSojxk8noVGKZNG5sq2O6SDyUaVCLMOd IEVaZw+D4/tvnPjnH/9HYRu6Vf+vE1FqN57RvrxgKXOswVQ8Or/gEqbvAGyfmf1JOEUZV7QioeQ CCqa73xZsQN18K5UgSX6awi5YVM9LxC9CzI6DrppUT36aZtQvIW6I1yz2HTcmUurrSLOosoKlRn Pf5QU5mLJO68G6t4tQRWmZexCkpGhDGeAoaln/I2t5sMKXXx
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

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-mt65xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 9333a0e8204d..f532cee3461e 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1269,7 +1269,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_spi_remove(struct platform_device *pdev)
+static void mtk_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
@@ -1294,8 +1294,6 @@ static int mtk_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1415,7 +1413,7 @@ static struct platform_driver mtk_spi_driver = {
 		.of_match_table = mtk_spi_of_match,
 	},
 	.probe = mtk_spi_probe,
-	.remove = mtk_spi_remove,
+	.remove_new = mtk_spi_remove,
 };
 
 module_platform_driver(mtk_spi_driver);
-- 
2.39.2

