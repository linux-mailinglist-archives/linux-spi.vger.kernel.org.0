Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC84D8699
	for <lists+linux-spi@lfdr.de>; Mon, 14 Mar 2022 15:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiCNOSZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Mar 2022 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiCNOSY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Mar 2022 10:18:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B6019C35
        for <linux-spi@vger.kernel.org>; Mon, 14 Mar 2022 07:17:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVO-00055c-Di; Mon, 14 Mar 2022 15:17:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVO-000f3h-KM; Mon, 14 Mar 2022 15:17:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVM-0097bR-25; Mon, 14 Mar 2022 15:17:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v8 15/16] spi: davinci: Simplify using devm_clk_get_enabled()
Date:   Mon, 14 Mar 2022 15:16:42 +0100
Message-Id: <20220314141643.22184-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=uwe@kleine-koenig.org; h=from:subject; bh=uXL2iClBr1/xsK4NdutfQp3FIymaPJh9Nybp2LKWUQU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiL04bUNoNywMLrnMk7dCMHbS3a4oBLVxh/NHNEhO1 U30gwtWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYi9OGwAKCRDB/BR4rcrsCYOJB/ 9oEzouRi1Ckh5iTABz7MlU9mi34InkSRPvTZ65mynG/0tFBTCS9WlHelrx9cZ/0HcH7xXtZUlqxSzj lvEiVnU+AzHYd4usMiGtBRmF+GdRaVewPPGTyJl8PUT8L79En9n7jZWDRJAMTEa/mS9JKg1CMRa+Xd tPS97z8aASx1obsqhcJ6J1PR3Gy+MM1990ATNrw8NgdrtztGlXC9HYuWQ8/GLZ5EmS8UKSbESM9K2J vQdQa+pFAo0B53vKF9dynciF0kZNjpadcvgRxg5IhVutBe/A1ly2s5xu2oCGt/GCPPVGxqIWNdU2p8 7lCldEvfQzyconxB6XlnwUiCO4Co5s
X-Developer-Key: i=uwe@kleine-koenig.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

devm_clk_get_enabled() returns the clk already (prepared and) enabled
and the automatically called cleanup cares for disabling (and
unpreparing). So simplify .probe() and .remove() accordingly.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-davinci.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d112c2cac042..5448510c285f 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -925,14 +925,11 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	dspi->bitbang.master = master;
 
-	dspi->clk = devm_clk_get(&pdev->dev, NULL);
+	dspi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(dspi->clk)) {
 		ret = -ENODEV;
 		goto free_master;
 	}
-	ret = clk_prepare_enable(dspi->clk);
-	if (ret)
-		goto free_master;
 
 	master->use_gpio_descriptors = true;
 	master->dev.of_node = pdev->dev.of_node;
@@ -957,7 +954,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	ret = davinci_spi_request_dma(dspi);
 	if (ret == -EPROBE_DEFER) {
-		goto free_clk;
+		goto free_master;
 	} else if (ret) {
 		dev_info(&pdev->dev, "DMA is not supported (%d)\n", ret);
 		dspi->dma_rx = NULL;
@@ -1001,8 +998,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
 	}
-free_clk:
-	clk_disable_unprepare(dspi->clk);
 free_master:
 	spi_master_put(master);
 err:
@@ -1028,8 +1023,6 @@ static int davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
-	clk_disable_unprepare(dspi->clk);
-
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
-- 
2.35.1

