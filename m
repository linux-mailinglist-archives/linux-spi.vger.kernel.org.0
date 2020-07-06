Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3212152FE
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgGFHSL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 03:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgGFHSL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 03:18:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64251C061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 00:18:11 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsLOA-0004BC-BD; Mon, 06 Jul 2020 09:18:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 9/9] spi: spi-sun6i: sun6i_spi_transfer_one(): enable RF_RDY interrupt only if needed
Date:   Mon,  6 Jul 2020 09:18:01 +0200
Message-Id: <20200706071801.558394-10-mkl@pengutronix.de>
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

In sun6i_spi_transfer_one() the RX FIFO Ready (SUN6I_INT_CTL_RF_RDY) is
unconditionally enabled.

A RX interrupt is only needed, if more data than fits into the FIFO is going to
be received during this transfer. As the RX-FIFO is drained during transfer
complete interrupt, enable the RX FIFO Ready interrupt only if the data doesn't
fit into the FIFO.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 21b4436a72de..9379ce477bc3 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -195,7 +195,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	unsigned int mclk_rate, div, div_cdr1, div_cdr2, timeout;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
-	unsigned int tx_len = 0;
+	unsigned int tx_len = 0, rx_len = 0;
 	int ret = 0;
 	u32 reg;
 
@@ -250,10 +250,12 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
 	 */
-	if (sspi->rx_buf)
+	if (sspi->rx_buf) {
 		reg &= ~SUN6I_TFR_CTL_DHB;
-	else
+		rx_len = tfr->len;
+	} else {
 		reg |= SUN6I_TFR_CTL_DHB;
+	}
 
 	/* We want to control the chip select manually */
 	reg |= SUN6I_TFR_CTL_CS_MANUAL;
@@ -307,8 +309,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_fill_fifo(sspi);
 
 	/* Enable the interrupts */
-	reg = SUN6I_INT_CTL_TC | SUN6I_INT_CTL_RF_RDY;
+	reg = SUN6I_INT_CTL_TC;
 
+	if (rx_len > sspi->fifo_depth)
+		reg |= SUN6I_INT_CTL_RF_RDY;
 	if (tx_len > sspi->fifo_depth)
 		reg |= SUN6I_INT_CTL_TF_ERQ;
 
-- 
2.27.0

