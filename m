Return-Path: <linux-spi+bounces-5647-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121239C0A30
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3544E1C220BB
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8AB212EFB;
	Thu,  7 Nov 2024 15:35:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907A212D0C
	for <linux-spi@vger.kernel.org>; Thu,  7 Nov 2024 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993735; cv=none; b=UjvFfKPLPF+l1rwcow+rccaqMe4KKVnx1tSYMBjpmb+Meq4M7rxW+xDzDnIgyL2JtNQm74CopU+EZ5A6OwD9tFPMVry3o/3aQS2WEu+Jh6JNGE8RK2YS8BHS0pioBMDS3k81WOqq1IsA179GLuoTAfwXoPNqmKwHw+x8/muvEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993735; c=relaxed/simple;
	bh=UwJuonefhCSNk8TslM5o7v8lxMqBjlG5gdXrIvC7l2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxDCwf6eniP5lRtnxYqRddqVi2Wcie6frNOFBGmRzMLwFDuQfRYiSCGIwLW8XJfFgduS3WMhN79kuxtdyS8LxL5A18EZWRTTCct+VUSbXTTATwv92UfF9iLS9vPNCNfeEtnZJYhF2gw9KE+5zFiQyBDcWDdmE80xolQDCIDM1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1t94Xf-0005DD-T8; Thu, 07 Nov 2024 16:35:27 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 07 Nov 2024 16:35:21 +0100
Subject: [PATCH 2/2] spi: imx: support word delay
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-imx-spi-word-delay-v1-2-2a969214d796@pengutronix.de>
References: <20241107-imx-spi-word-delay-v1-0-2a969214d796@pengutronix.de>
In-Reply-To: <20241107-imx-spi-word-delay-v1-0-2a969214d796@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Implement support for the word delay feature of i.MX51 (and onwards) via
the ECSPI interface.

Convert the requested delay to SPI cycles and account for an extra
inter-word delay inserted by the controller in addition to the requested
number of cycles, which was observed when testing this patch.

Disable dynamic burst when word delay is set. As the configurable delay
period in the controller is inserted after bursts, the burst length must
equal the word length.

Account for word delay in the transfer time estimation for
polling_limit_us.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/spi/spi-imx.c | 93 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 83 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 65a8303b80b1191cd2c19d61f88836e7fd3c7ae9..c50c256e6e695659c23d5292949a98bda0a2cd1a 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -13,7 +13,9 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -302,6 +304,18 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 #define MX51_ECSPI_STAT		0x18
 #define MX51_ECSPI_STAT_RR		(1 <<  3)
 
+#define MX51_ECSPI_PERIOD	0x1c
+#define MX51_ECSPI_PERIOD_MASK		0x7fff
+/*
+ * As measured on the i.MX6, the SPI host controller inserts a 4 SPI-Clock
+ * (SCLK) delay after each burst if the PERIOD reg is 0x0. This value will be
+ * called MX51_ECSPI_PERIOD_MIN_DELAY_SCK.
+ *
+ * If the PERIOD register is != 0, the controller inserts a delay of
+ * MX51_ECSPI_PERIOD_MIN_DELAY_SCK + register value + 1 SCLK after each burst.
+ */
+#define MX51_ECSPI_PERIOD_MIN_DELAY_SCK 4
+
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
@@ -653,6 +667,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 				       struct spi_device *spi, struct spi_transfer *t)
 {
 	u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
+	u64 word_delay_sck;
 	u32 clk;
 
 	/* Clear BL field and set the right value */
@@ -684,6 +699,49 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 
+	/* calculate word delay in SPI Clock (SCLK) cycles */
+	if (t->word_delay.value == 0) {
+		word_delay_sck = 0;
+	} else if (t->word_delay.unit == SPI_DELAY_UNIT_SCK) {
+		word_delay_sck = t->word_delay.value;
+
+		if (word_delay_sck <= MX51_ECSPI_PERIOD_MIN_DELAY_SCK)
+			word_delay_sck = 0;
+		else if (word_delay_sck <= MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1)
+			word_delay_sck = 1;
+		else
+			word_delay_sck -= MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1;
+	} else {
+		int word_delay_ns;
+
+		word_delay_ns = spi_delay_to_ns(&t->word_delay, t);
+		if (word_delay_ns < 0)
+			return word_delay_ns;
+
+		if (word_delay_ns <= mul_u64_u32_div(NSEC_PER_SEC,
+						     MX51_ECSPI_PERIOD_MIN_DELAY_SCK,
+						     spi_imx->spi_bus_clk)) {
+			word_delay_sck = 0;
+		} else if (word_delay_ns <= mul_u64_u32_div(NSEC_PER_SEC,
+							    MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1,
+							    spi_imx->spi_bus_clk)) {
+			word_delay_sck = 1;
+		} else {
+			word_delay_ns -= mul_u64_u32_div(NSEC_PER_SEC,
+							 MX51_ECSPI_PERIOD_MIN_DELAY_SCK + 1,
+							 spi_imx->spi_bus_clk);
+
+			word_delay_sck = DIV_U64_ROUND_UP((u64)word_delay_ns * spi_imx->spi_bus_clk,
+							  NSEC_PER_SEC);
+		}
+	}
+
+	if (!FIELD_FIT(MX51_ECSPI_PERIOD_MASK, word_delay_sck))
+		return -EINVAL;
+
+	writel(FIELD_PREP(MX51_ECSPI_PERIOD_MASK, word_delay_sck),
+	       spi_imx->base + MX51_ECSPI_PERIOD);
+
 	return 0;
 }
 
@@ -1264,11 +1322,13 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 
 	/*
 	 * Initialize the functions for transfer. To transfer non byte-aligned
-	 * words, we have to use multiple word-size bursts, we can't use
-	 * dynamic_burst in that case.
+	 * words, we have to use multiple word-size bursts. To insert word
+	 * delay, the burst size has to equal the word size. We can't use
+	 * dynamic_burst in these cases.
 	 */
 	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->target_mode &&
 	    !(spi->mode & SPI_CS_WORD) &&
+	    !(t->word_delay.value) &&
 	    (spi_imx->bits_per_word == 8 ||
 	    spi_imx->bits_per_word == 16 ||
 	    spi_imx->bits_per_word == 32)) {
@@ -1611,12 +1671,30 @@ static int spi_imx_pio_transfer_target(struct spi_device *spi,
 	return ret;
 }
 
+static unsigned int spi_imx_transfer_estimate_time_us(struct spi_transfer *transfer)
+{
+	u64 result;
+
+	result = DIV_U64_ROUND_CLOSEST((u64)USEC_PER_SEC * transfer->len * BITS_PER_BYTE,
+				       transfer->effective_speed_hz);
+	if (transfer->word_delay.value) {
+		unsigned int word_delay_us;
+		unsigned int words;
+
+		words = DIV_ROUND_UP(transfer->len * BITS_PER_BYTE, transfer->bits_per_word);
+		word_delay_us = DIV_ROUND_CLOSEST(spi_delay_to_ns(&transfer->word_delay, transfer),
+						  NSEC_PER_USEC);
+		result += words * word_delay_us;
+	}
+
+	return min(result, U32_MAX);
+}
+
 static int spi_imx_transfer_one(struct spi_controller *controller,
 				struct spi_device *spi,
 				struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
-	unsigned long hz_per_byte, byte_limit;
 
 	spi_imx_setupxfer(spi, transfer);
 	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
@@ -1635,15 +1713,10 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	 */
 	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
-	/*
-	 * Calculate the estimated time in us the transfer runs. Find
-	 * the number of Hz per byte per polling limit.
-	 */
-	hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) / polling_limit_us : 0;
-	byte_limit = hz_per_byte ? transfer->effective_speed_hz / hz_per_byte : 1;
 
 	/* run in polling mode for short transfers */
-	if (transfer->len < byte_limit)
+	if (transfer->len == 1 || (polling_limit_us &&
+				   spi_imx_transfer_estimate_time_us(transfer) < polling_limit_us))
 		return spi_imx_poll_transfer(spi, transfer);
 
 	return spi_imx_pio_transfer(spi, transfer);

-- 
2.39.5


