Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1556B3D753B
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 14:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhG0Mmj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 08:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbhG0Mmf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Jul 2021 08:42:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B25EC061765
        for <linux-spi@vger.kernel.org>; Tue, 27 Jul 2021 05:42:34 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8MPk-0006WH-Dx; Tue, 27 Jul 2021 14:42:28 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m8MPj-0001Sf-Dn; Tue, 27 Jul 2021 14:42:27 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-spi@vger.kernel.org
Subject: [PATCH] spi: imx: Implement support for CS_WORD
Date:   Tue, 27 Jul 2021 14:42:26 +0200
Message-Id: <20210727124226.5571-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This only works when the native chipselect is in use. On a board with a
Ti ADS7950 8 channel ADC. This patch reduces the time to read out all
channels once from 280 us to 20 us.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e5ba99d87eb3..ff6051fe25f6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1209,6 +1209,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	 * dynamic_burst in that case.
 	 */
 	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode &&
+	    !(spi->mode & SPI_CS_WORD) &&
 	    (spi_imx->bits_per_word == 8 ||
 	    spi_imx->bits_per_word == 16 ||
 	    spi_imx->bits_per_word == 32)) {
@@ -1640,6 +1641,15 @@ static int spi_imx_probe(struct platform_device *pdev)
 	    is_imx53_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP | SPI_READY;
 
+	if (is_imx51_ecspi(spi_imx) &&
+	    device_property_read_u32(&pdev->dev, "cs-gpios", NULL))
+		/*
+		 * When using HW-CS implementing SPI_CS_WORD can be done by just
+		 * setting the burst length to the word size. This is
+		 * considerably faster than manually controlling the CS.
+		 */
+		spi_imx->bitbang.master->mode_bits |= SPI_CS_WORD;
+
 	spi_imx->spi_drctl = spi_drctl;
 
 	init_completion(&spi_imx->xfer_done);
-- 
2.30.2

