Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB74FC451
	for <lists+linux-spi@lfdr.de>; Mon, 11 Apr 2022 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiDKSsb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Apr 2022 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345246AbiDKSs3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Apr 2022 14:48:29 -0400
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4818038AB
        for <linux-spi@vger.kernel.org>; Mon, 11 Apr 2022 11:46:14 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id A9CE24409C6;
        Mon, 11 Apr 2022 21:45:40 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1649702741;
        bh=a4PADMrOZphilip+jA6MTxHROEeyp5oVgUJ7MCvUAS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaZsMfHeMXLbihLO1EmoNfCKIUUUZDB/zm/eP8P184sWg2yb26dw1V6nMk6Ss1s9l
         A920WuOfub+DeIX7vldOhogbQ7dDMNaTdg9CnZzdzjerzgmp+/IVzBJ55aS2o3yOEH
         /9YLhvJH/D6oEh7wi4Ddcl0P1UsR4Eoz4g9V2OjTCsGLLNCJeQTFvVhzPNiRl+ZSOF
         q/KJrNPSpJwPpdgl+eAlbIR4wK3K3mEcpK8/nqjiylleolZoA5QxgQN/xjdnLwTupz
         NJEIo+UMFN4HmmdU2k5PkP6oBxlIdXYpsvTGRugqeTL3SQSzOeT/Y8Q/XhOINPxIU9
         DVWn2509nIoeg==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Mark Brown <broonie@kernel.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>, linux-spi@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] spi: spi-imx: add support for SPI_RX_CPHA_FLIP
Date:   Mon, 11 Apr 2022 21:45:29 +0300
Message-Id: <e11b4446afe9a46a282dd923d22c27d03fae15f8.1649702729.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <a715ca92713ca02071f33dcca9960a66a03c949a.1649702729.git.baruch@tkos.co.il>
References: <a715ca92713ca02071f33dcca9960a66a03c949a.1649702729.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Baruch Siach <baruch.siach@siklu.com>

When SPI_RX_CPHA_FLIP is set, flip CPHA on Rx only transfers. This is
useful to access devices that use inverted CPHA for MISO vs MOSI
signals.

Only support the mx51/mx53 variants for now.

Tested on i.MX6ULL based system.

Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
 drivers/spi/spi-imx.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b2dd0a4d2446..4e1bfe2f043a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -108,6 +108,7 @@ struct spi_imx_data {
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
 	unsigned int dynamic_burst;
+	bool rx_only;
 
 	/* Slave mode */
 	bool slave_mode;
@@ -554,11 +555,6 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	else
 		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
 
-	if (spi->mode & SPI_CPHA)
-		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
-	else
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
-
 	if (spi->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
 		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
@@ -606,6 +602,24 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	return 0;
 }
 
+static void mx51_configure_cpha(struct spi_imx_data *spi_imx,
+				struct spi_device *spi)
+{
+	bool cpha = (spi->mode & SPI_CPHA);
+	bool flip_cpha = (spi->mode & SPI_RX_CPHA_FLIP) && spi_imx->rx_only;
+	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
+
+	/* Flip cpha logical value iff flip_cpha */
+	cpha ^= flip_cpha;
+
+	if (cpha)
+		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
+
+	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
+}
+
 static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 				       struct spi_device *spi)
 {
@@ -627,6 +641,8 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
 	spi_imx->spi_bus_clk = clk;
 
+	mx51_configure_cpha(spi_imx, spi);
+
 	/*
 	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
 	 * before i.mx6ul.
@@ -1251,6 +1267,9 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma = false;
 
+	spi_imx->rx_only = ((t->tx_buf == NULL)
+			|| (t->tx_buf == spi->controller->dummy_tx));
+
 	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
 		spi_imx->rx = mx53_ecspi_rx_slave;
 		spi_imx->tx = mx53_ecspi_tx_slave;
@@ -1655,6 +1674,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	    is_imx53_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
 
+	if (is_imx51_ecspi(spi_imx) || is_imx53_ecspi(spi_imx))
+		spi_imx->bitbang.master->mode_bits |= SPI_RX_CPHA_FLIP;
+
 	if (is_imx51_ecspi(spi_imx) &&
 	    device_property_read_u32(&pdev->dev, "cs-gpios", NULL))
 		/*
-- 
2.35.1

