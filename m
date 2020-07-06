Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60744215993
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 16:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgGFOey (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgGFOex (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 10:34:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA9C061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 07:34:53 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsSCm-0005DP-Mt; Mon, 06 Jul 2020 16:34:48 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 07/10] spi: spi-sun6i: sun6i_spi_drain_fifo(): remove not needed length argument
Date:   Mon,  6 Jul 2020 16:34:40 +0200
Message-Id: <20200706143443.9855-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706143443.9855-1-mkl@pengutronix.de>
References: <20200706143443.9855-1-mkl@pengutronix.de>
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

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 44cd07331627..5849b65c3b1c 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -135,16 +135,13 @@ static inline void sun6i_spi_disable_interrupt(struct sun6i_spi *sspi, u32 mask)
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
@@ -348,14 +345,14 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
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

