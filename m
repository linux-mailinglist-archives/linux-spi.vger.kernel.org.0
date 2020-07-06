Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C562152FD
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgGFHSL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 03:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgGFHSL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 03:18:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E469C061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 00:18:11 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsLO9-0004BC-Uf; Mon, 06 Jul 2020 09:18:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/9] spi: spi-sun6i: sun6i_spi_transfer_one(): collate write to Interrupt Control Register
Date:   Mon,  6 Jul 2020 09:18:00 +0200
Message-Id: <20200706071801.558394-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706071801.558394-1-mkl@pengutronix.de>
References: <20200706071801.558394-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In sun6i_spi_transfer_one() the Interrupt Control Register is written three
times. This patch collates the three writes into one.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index da56e9bc2cc3..21b4436a72de 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -124,14 +124,6 @@ static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
 	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
 }
 
-static inline void sun6i_spi_enable_interrupt(struct sun6i_spi *sspi, u32 mask)
-{
-	u32 reg = sun6i_spi_read(sspi, SUN6I_INT_CTL_REG);
-
-	reg |= mask;
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
-}
-
 static inline void sun6i_spi_disable_interrupt(struct sun6i_spi *sspi, u32 mask)
 {
 	u32 reg = sun6i_spi_read(sspi, SUN6I_INT_CTL_REG);
@@ -315,11 +307,12 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_fill_fifo(sspi);
 
 	/* Enable the interrupts */
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
-	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
-					 SUN6I_INT_CTL_RF_RDY);
+	reg = SUN6I_INT_CTL_TC | SUN6I_INT_CTL_RF_RDY;
+
 	if (tx_len > sspi->fifo_depth)
-		sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
+		reg |= SUN6I_INT_CTL_TF_ERQ;
+
+	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
 
 	/* Start the transfer */
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-- 
2.27.0

