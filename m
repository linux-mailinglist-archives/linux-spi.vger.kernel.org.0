Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DE52152FC
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgGFHSL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 03:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgGFHSK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 03:18:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249AC061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 00:18:10 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsLO9-0004BC-J8; Mon, 06 Jul 2020 09:18:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/9] spi: spi-sun6i: sun6i_spi_fill_fifo(): remove not needed length argument
Date:   Mon,  6 Jul 2020 09:17:59 +0200
Message-Id: <20200706071801.558394-8-mkl@pengutronix.de>
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

The function sun6i_spi_fill_fifo() is called with a length argument of
"sspi->fifo_depth" and "SUN6I_FIFO_DEPTH".

The driver reads the number of free bytes in the FIFO from the hardware and
uses the length argument to limit this value. This is not needed as the number
of free bytes in the FIFO is always less or equal the depth of the FIFO.

This patch removes the length argument and check.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index aa0daca0cbbf..da56e9bc2cc3 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -155,15 +155,16 @@ static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi)
 	}
 }
 
-static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi, int len)
+static inline void sun6i_spi_fill_fifo(struct sun6i_spi *sspi)
 {
 	u32 cnt;
+	int len;
 	u8 byte;
 
 	/* See how much data we can fit */
 	cnt = sspi->fifo_depth - sun6i_spi_get_tx_fifo_count(sspi);
 
-	len = min3(len, (int)cnt, sspi->len);
+	len = min((int)cnt, sspi->len);
 
 	while (len--) {
 		byte = sspi->tx_buf ? *sspi->tx_buf++ : 0;
@@ -311,7 +312,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG, tx_len);
 
 	/* Fill the TX FIFO */
-	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
+	sun6i_spi_fill_fifo(sspi);
 
 	/* Enable the interrupts */
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
@@ -365,7 +366,7 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 
 	/* Transmit FIFO 3/4 empty */
 	if (status & SUN6I_INT_CTL_TF_ERQ) {
-		sun6i_spi_fill_fifo(sspi, SUN6I_FIFO_DEPTH);
+		sun6i_spi_fill_fifo(sspi);
 
 		if (!sspi->len)
 			/* nothing left to transmit */
-- 
2.27.0

