Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63E2152FB
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgGFHSK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 03:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgGFHSK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 03:18:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52663C061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 00:18:10 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsLO9-0004BC-6R; Mon, 06 Jul 2020 09:18:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/9] spi: spi-sun6i: sun6i_spi_drain_fifo(): remove not needed length argument
Date:   Mon,  6 Jul 2020 09:17:58 +0200
Message-Id: <20200706071801.558394-7-mkl@pengutronix.de>
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

The function sun6i_spi_drain_fifo() is called with a length argument of
"sspi->fifo_depth" and "SUN6I_FIFO_DEPTH".

The driver reads the number of available bytes to read from the FIFO from the
hardware and uses the length argument to limit this value. This is not needed
as the FIFO can contain only the fifo depth number of bytes.

This patch removes the length argument and check.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index f70d14229483..aa0daca0cbbf 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -140,16 +140,13 @@ static inline void sun6i_spi_disable_interrupt(struct sun6i_spi *sspi, u32 mask)
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
 }
 
-static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
+static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi)
 {
-	u32 cnt;
+	u32 len;
 	u8 byte;
 
 	/* See how much data is available */
-	cnt = sun6i_spi_get_rx_fifo_count(sspi);
-
-	if (len > cnt)
-		len = cnt;
+	len = sun6i_spi_get_rx_fifo_count(sspi);
 
 	while (len--) {
 		byte = readb(sspi->base_addr + SUN6I_RXDATA_REG);
@@ -353,14 +350,14 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	/* Transfer complete */
 	if (status & SUN6I_INT_CTL_TC) {
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
-		sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
+		sun6i_spi_drain_fifo(sspi);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
 
 	/* Receive FIFO 3/4 full */
 	if (status & SUN6I_INT_CTL_RF_RDY) {
-		sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
+		sun6i_spi_drain_fifo(sspi);
 		/* Only clear the interrupt _after_ draining the FIFO */
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_RF_RDY);
 		return IRQ_HANDLED;
-- 
2.27.0

