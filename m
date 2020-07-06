Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD9215992
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 16:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgGFOey (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgGFOex (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 10:34:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1DEC061755
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 07:34:53 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsSCm-0005DP-9z; Mon, 06 Jul 2020 16:34:48 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 06/10] spi: spi-sun6i: sun6i_spi_drain_fifo(): introduce sun6i_spi_get_rx_fifo_count() and make use of it
Date:   Mon,  6 Jul 2020 16:34:39 +0200
Message-Id: <20200706143443.9855-7-mkl@pengutronix.de>
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

This patch introduces the function sun6i_spi_get_rx_fifo_count(), similar to
the existing sun6i_spi_get_tx_fifo_count(), to make the sun6i_spi_drain_fifo()
function a bit easier to read.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 40365761f25d..44cd07331627 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -59,8 +59,7 @@
 #define SUN6I_FIFO_CTL_TF_RST			BIT(31)
 
 #define SUN6I_FIFO_STA_REG		0x1c
-#define SUN6I_FIFO_STA_RF_CNT_MASK		0x7f
-#define SUN6I_FIFO_STA_RF_CNT_BITS		0
+#define SUN6I_FIFO_STA_RF_CNT_MASK		GENMASK(7, 0)
 #define SUN6I_FIFO_STA_TF_CNT_MASK		GENMASK(23, 16)
 
 #define SUN6I_CLK_CTL_REG		0x24
@@ -106,6 +105,13 @@ static inline void sun6i_spi_write(struct sun6i_spi *sspi, u32 reg, u32 value)
 	writel(value, sspi->base_addr + reg);
 }
 
+static inline u32 sun6i_spi_get_rx_fifo_count(struct sun6i_spi *sspi)
+{
+	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
+
+	return FIELD_GET(SUN6I_FIFO_STA_RF_CNT_MASK, reg);
+}
+
 static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
 {
 	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
@@ -131,13 +137,11 @@ static inline void sun6i_spi_disable_interrupt(struct sun6i_spi *sspi, u32 mask)
 
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

