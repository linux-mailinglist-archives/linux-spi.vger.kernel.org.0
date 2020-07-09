Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C17219A2A
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 09:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgGIHla (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIHl2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jul 2020 03:41:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DC7C08C5DC
        for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2020 00:41:28 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jtRBM-0000FM-IF; Thu, 09 Jul 2020 09:41:24 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Martin Sperl <kernel@martin.sperl.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] spi: bcm2835aux: support effective_speed_hz
Date:   Thu,  9 Jul 2020 09:41:20 +0200
Message-Id: <20200709074120.110069-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709074120.110069-1-mkl@pengutronix.de>
References: <20200709074120.110069-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Setting spi_transfer->effective_speed_hz in transfer_one so that
it can get used in cs_change_delay configured with delay as a muliple
of SPI clock cycles.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-bcm2835aux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index c331efd6e86b..2f717812c766 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -345,7 +345,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 				       struct spi_transfer *tfr)
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
-	unsigned long spi_hz, clk_hz, speed, spi_used_hz;
+	unsigned long spi_hz, clk_hz, speed;
 	unsigned long hz_per_byte, byte_limit;
 
 	/* calculate the registers to handle
@@ -374,7 +374,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	/* set the new speed */
 	bs->cntl[0] |= speed << BCM2835_AUX_SPI_CNTL0_SPEED_SHIFT;
 
-	spi_used_hz = clk_hz / (2 * (speed + 1));
+	tfr->effective_speed_hz = clk_hz / (2 * (speed + 1));
 
 	/* set transmit buffers and length */
 	bs->tx_buf = tfr->tx_buf;
@@ -391,7 +391,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	 * 30 µs per 300,000 Hz of bus clock.
 	 */
 	hz_per_byte = polling_limit_us ? (9 * 1000000) / polling_limit_us : 0;
-	byte_limit = hz_per_byte ? spi_used_hz / hz_per_byte : 1;
+	byte_limit = hz_per_byte ? tfr->effective_speed_hz / hz_per_byte : 1;
 
 	/* run in polling mode for short transfers */
 	if (tfr->len < byte_limit)
-- 
2.27.0

