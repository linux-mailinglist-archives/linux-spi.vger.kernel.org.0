Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873A836B49E
	for <lists+linux-spi@lfdr.de>; Mon, 26 Apr 2021 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhDZOSV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbhDZOSU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Apr 2021 10:18:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E32C06175F
        for <linux-spi@vger.kernel.org>; Mon, 26 Apr 2021 07:17:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb23L-0002L7-5b; Mon, 26 Apr 2021 16:17:35 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lb23K-0005np-RB; Mon, 26 Apr 2021 16:17:34 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: [PATCH v6 6/6] spi: davinci: Simplify using devm_clk_get_enabled()
Date:   Mon, 26 Apr 2021 16:17:30 +0200
Message-Id: <20210426141730.2826832-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210426141730.2826832-1-u.kleine-koenig@pengutronix.de>
References: <20210426141730.2826832-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

devm_clk_get_enabled() returns the clk already (prepared and) enabled
and the automatically called cleanup cares for disabling (and
unpreparing). So simplify .probe() and .remove() accordingly.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-davinci.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7453a1dbbc06..63ee918ecdb0 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -936,14 +936,11 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
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
@@ -968,7 +965,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	ret = davinci_spi_request_dma(dspi);
 	if (ret == -EPROBE_DEFER) {
-		goto free_clk;
+		goto free_master;
 	} else if (ret) {
 		dev_info(&pdev->dev, "DMA is not supported (%d)\n", ret);
 		dspi->dma_rx = NULL;
@@ -1012,8 +1009,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
 	}
-free_clk:
-	clk_disable_unprepare(dspi->clk);
 free_master:
 	spi_master_put(master);
 err:
@@ -1039,8 +1034,6 @@ static int davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
-	clk_disable_unprepare(dspi->clk);
-
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
-- 
2.30.2

