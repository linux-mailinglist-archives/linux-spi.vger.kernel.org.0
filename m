Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957822152FA
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgGFHSK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 03:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgGFHSJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 03:18:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95B8C061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 00:18:09 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsLO8-0004BC-Pn; Mon, 06 Jul 2020 09:18:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/9] spi: spi-sun6i: sun6i_spi_drain_fifo(): introduce sun6i_spi_get_rx_fifo_count() and make use of it
Date:   Mon,  6 Jul 2020 09:17:57 +0200
Message-Id: <20200706071801.558394-6-mkl@pengutronix.de>
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

This patch introduces the function sun6i_spi_get_rx_fifo_count(), similar to
the existing sun6i_spi_get_tx_fifo_count(), to make the sun6i_spi_drain_fifo()
function a bit easier to read.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 882492774986..f70d14229483 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -106,6 +106,15 @@ static inline void sun6i_spi_write(struct sun6i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }
 
+static inline u32 sun6i_spi_get_rx_fifo_count(struct sun6i_spi *sspi)
+{
+	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
+
+	reg >>= SUN6I_FIFO_STA_RF_CNT_BITS;
+
+	return reg & SUN6I_FIFO_STA_RF_CNT_MASK;
+}
+
 static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
 {
 	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
@@ -133,13 +142,11 @@ static inline void sun6i_spi_disable_interrupt(struct sun6i_spi *sspi, u32 mask)
 
 static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
 {
-	u32 reg, cnt;
+	u32 cnt;
 	u8 byte;
 
 	/* See how much data is available */
-	reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
-	reg &= SUN6I_FIFO_STA_RF_CNT_MASK;
-	cnt = reg >> SUN6I_FIFO_STA_RF_CNT_BITS;
+	cnt = sun6i_spi_get_rx_fifo_count(sspi);
 
 	if (len > cnt)
 		len = cnt;
-- 
2.27.0

