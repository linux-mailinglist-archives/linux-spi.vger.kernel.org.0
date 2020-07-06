Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF84215991
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 16:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgGFOex (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgGFOew (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 10:34:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE22C061755
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 07:34:52 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsSCl-0005DP-Sp; Mon, 06 Jul 2020 16:34:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 05/10] spi: spi-sun6i: sun6i_spi_get_tx_fifo_count: Convert manual shift+mask to FIELD_GET()
Date:   Mon,  6 Jul 2020 16:34:38 +0200
Message-Id: <20200706143443.9855-6-mkl@pengutronix.de>
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

This patch converts the manual shift+mask in sun6i_spi_get_tx_fifo_count() to
make use of FIELD_GET()

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 882492774986..40365761f25d 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -7,6 +7,7 @@
  * Maxime Ripard <maxime.ripard@free-electrons.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -60,8 +61,7 @@
 #define SUN6I_FIFO_STA_REG		0x1c
 #define SUN6I_FIFO_STA_RF_CNT_MASK		0x7f
 #define SUN6I_FIFO_STA_RF_CNT_BITS		0
-#define SUN6I_FIFO_STA_TF_CNT_MASK		0x7f
-#define SUN6I_FIFO_STA_TF_CNT_BITS		16
+#define SUN6I_FIFO_STA_TF_CNT_MASK		GENMASK(23, 16)
 
 #define SUN6I_CLK_CTL_REG		0x24
 #define SUN6I_CLK_CTL_CDR2_MASK			0xff
@@ -110,9 +110,7 @@ static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
 {
 	u32 reg = sun6i_spi_read(sspi, SUN6I_FIFO_STA_REG);
 
-	reg >>= SUN6I_FIFO_STA_TF_CNT_BITS;
-
-	return reg & SUN6I_FIFO_STA_TF_CNT_MASK;
+	return FIELD_GET(SUN6I_FIFO_STA_TF_CNT_MASK, reg);
 }
 
 static inline void sun6i_spi_enable_interrupt(struct sun6i_spi *sspi, u32 mask)
-- 
2.27.0

