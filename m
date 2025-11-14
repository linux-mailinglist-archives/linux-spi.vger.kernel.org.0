Return-Path: <linux-spi+bounces-11199-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CAEC5CA26
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 11:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC235D052
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973C31326D;
	Fri, 14 Nov 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1qy2VHM2"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15FE3101A2;
	Fri, 14 Nov 2025 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116481; cv=none; b=C7cbkz6AxtZQ3jS5OWLFctSyzbSOeQbeZu0BaPz04MTsjGvv6EIMzM8NCyLE9RTHRx2SEWsuXhgP6LmXQd5CaLpUdCmXTp6WXqSTFiUhb2DxQ4+BfReXhuXC2UgjLoKdIAE6q4/e9Za/ZoE6/4hoKdJDAkBiZrDbWfVM8WlWE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116481; c=relaxed/simple;
	bh=mqoSvGL2fT0qlyXV0+50AleARwpzNExwCfzojEnfzpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcWNNWwRw7R24nZcuB77lfNT6ibF+DBTrNTZMwKapwvhCqLhBYv/08KtRHiJzhSs7OO5FnGByjvcQRsckjkseuTLwVHOdvqFay+jNqUbx3yJBIGrx8hp4AE2Bro/wZjQPzcqlBGed+Zf6cqbCojnAbnQ+E9fTkIIkILpAPsGz8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1qy2VHM2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763116480; x=1794652480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqoSvGL2fT0qlyXV0+50AleARwpzNExwCfzojEnfzpY=;
  b=1qy2VHM2/wOLTT1GP7IYwI8rPc3RcvE55moPCFB2rDpJAgowDHO7VHEQ
   n/eq+0d3VC6vCw2KxBbe2TwKFWg92QS+4sOr9WTGNPiJF3dMuNc2tnkHe
   r32I7FNuMqqH9KwPxZ23ItqZMmvhLklJ14UtkYh7Zh1b+1MAhcUlp/4w0
   ohlugFhXQNr13gA8/H1HLHHbxkRwVA+35Vz+hlXAxrPqIO0xEBZFcq7Ds
   jGGsZkaoktHHBdtDZ5y2M8KVtBZnKtuRQaMpgkXl1N5pdWkar7M9Mp78m
   ICN6USh6xlfmugnSfnSelSla/SS6FXYJZxk0MY2tkNmy2739xYwgZ8nth
   g==;
X-CSE-ConnectionGUID: wYFga1SYSXSOScvbmgh0dQ==
X-CSE-MsgGUID: 9COJ3nMJQVizE1Y6+p1hHw==
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; 
   d="scan'208";a="49141510"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 03:34:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 14 Nov 2025 03:34:28 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 14 Nov 2025 03:34:26 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, "Cyril
 Jean" <cyril.jean@microchip.com>, Prajna Rajendra Kumar
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v4 3/3] spi: add support for microchip "soft" spi controller
Date: Fri, 14 Nov 2025 10:45:45 +0000
Message-ID: <20251114104545.284765-4-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114104545.284765-1-prajna.rajendrakumar@microchip.com>
References: <20251114104545.284765-1-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce driver support for the Microchip FPGA CoreSPI IP.

This driver supports only Motorola SPI mode and frame size of 8-bits.
TI/NSC modes and wider frame sizes are not currently supported.

Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/Kconfig                  |   9 +
 drivers/spi/Makefile                 |   1 +
 drivers/spi/spi-microchip-core-spi.c | 442 +++++++++++++++++++++++++++
 3 files changed, 452 insertions(+)
 create mode 100644 drivers/spi/spi-microchip-core-spi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d53798036076..96806806d48b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -715,6 +715,15 @@ config SPI_MICROCHIP_CORE_QSPI
 	  PolarFire SoC.
 	  If built as a module, it will be called spi-microchip-core-qspi.
 
+config SPI_MICROCHIP_CORE_SPI
+	tristate "Microchip FPGA CoreSPI controller"
+	depends on SPI_MASTER
+	help
+	  This enables the SPI driver for Microchip FPGA CoreSPI controller.
+	  Say Y or M here if you want to use the "soft" controllers on
+	  PolarFire SoC.
+	  If built as a module, it will be called spi-microchip-core-spi.
+
 config SPI_MT65XX
 	tristate "MediaTek SPI controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 1f7c06a3091d..863b628ff1ec 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
 obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
 obj-$(CONFIG_SPI_MICROCHIP_CORE_QSPI)	+= spi-microchip-core-qspi.o
+obj-$(CONFIG_SPI_MICROCHIP_CORE_SPI)	+= spi-microchip-core-spi.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
new file mode 100644
index 000000000000..b8738190cdcb
--- /dev/null
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: (GPL-2.0)
+//
+// Microchip CoreSPI controller driver
+//
+// Copyright (c) 2025 Microchip Technology Inc. and its subsidiaries
+//
+// Author: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#define MCHP_CORESPI_MAX_CS				(8)
+#define MCHP_CORESPI_DEFAULT_FIFO_DEPTH			(4)
+#define MCHP_CORESPI_DEFAULT_MOTOROLA_MODE		(3)
+
+#define MCHP_CORESPI_CONTROL_ENABLE			BIT(0)
+#define MCHP_CORESPI_CONTROL_MASTER			BIT(1)
+#define MCHP_CORESPI_CONTROL_TX_DATA_INT		BIT(3)
+#define MCHP_CORESPI_CONTROL_RX_OVER_INT		BIT(4)
+#define MCHP_CORESPI_CONTROL_TX_UNDER_INT		BIT(5)
+#define MCHP_CORESPI_CONTROL_FRAMEURUN			BIT(6)
+#define MCHP_CORESPI_CONTROL_OENOFF			BIT(7)
+
+#define MCHP_CORESPI_STATUS_ACTIVE			BIT(7)
+#define MCHP_CORESPI_STATUS_SSEL			BIT(6)
+#define MCHP_CORESPI_STATUS_TXFIFO_UNDERFLOW		BIT(5)
+#define MCHP_CORESPI_STATUS_RXFIFO_FULL			BIT(4)
+#define MCHP_CORESPI_STATUS_TXFIFO_FULL			BIT(3)
+#define MCHP_CORESPI_STATUS_RXFIFO_EMPTY		BIT(2)
+#define MCHP_CORESPI_STATUS_DONE			BIT(1)
+#define MCHP_CORESPI_STATUS_FIRSTFRAME			BIT(0)
+
+#define MCHP_CORESPI_INT_TXDONE				BIT(0)
+#define MCHP_CORESPI_INT_RX_CHANNEL_OVERFLOW		BIT(2)
+#define MCHP_CORESPI_INT_TX_CHANNEL_UNDERRUN		BIT(3)
+#define MCHP_CORESPI_INT_CMDINT				BIT(4)
+#define MCHP_CORESPI_INT_SSEND				BIT(5)
+#define MCHP_CORESPI_INT_DATA_RX			BIT(6)
+#define MCHP_CORESPI_INT_TXRFM				BIT(7)
+
+#define MCHP_CORESPI_CONTROL2_INTEN_TXRFMT		BIT(7)
+#define MCHP_CORESPI_CONTROL2_INTEN_DATA_RX		BIT(6)
+#define MCHP_CORESPI_CONTROL2_INTEN_SSEND		BIT(5)
+#define MCHP_CORESPI_CONTROL2_INTEN_CMD			BIT(4)
+
+#define INT_ENABLE_MASK (MCHP_CORESPI_CONTROL_TX_DATA_INT | MCHP_CORESPI_CONTROL_RX_OVER_INT | \
+			 MCHP_CORESPI_CONTROL_TX_UNDER_INT)
+
+#define MCHP_CORESPI_REG_CONTROL			(0x00)
+#define MCHP_CORESPI_REG_INTCLEAR			(0x04)
+#define MCHP_CORESPI_REG_RXDATA				(0x08)
+#define MCHP_CORESPI_REG_TXDATA				(0x0c)
+#define MCHP_CORESPI_REG_INTMASK			(0X10)
+#define MCHP_CORESPI_REG_INTRAW				(0X14)
+#define MCHP_CORESPI_REG_CONTROL2			(0x18)
+#define MCHP_CORESPI_REG_COMMAND			(0x1c)
+#define MCHP_CORESPI_REG_STAT				(0x20)
+#define MCHP_CORESPI_REG_SSEL				(0x24)
+#define MCHP_CORESPI_REG_TXDATA_LAST			(0X28)
+#define MCHP_CORESPI_REG_CLK_DIV			(0x2c)
+
+struct mchp_corespi {
+	void __iomem *regs;
+	struct clk *clk;
+	const u8 *tx_buf;
+	u8 *rx_buf;
+	u32 clk_gen;
+	int irq;
+	int tx_len;
+	int rx_len;
+	u32 fifo_depth;
+};
+
+static inline void mchp_corespi_disable(struct mchp_corespi *spi)
+{
+	u8 control = readb(spi->regs + MCHP_CORESPI_REG_CONTROL);
+
+	control &= ~MCHP_CORESPI_CONTROL_ENABLE;
+
+	writeb(control, spi->regs + MCHP_CORESPI_REG_CONTROL);
+}
+
+static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi, u32 fifo_max)
+{
+	for (int i = 0; i < fifo_max; i++) {
+		u32 data;
+
+		while (readb(spi->regs + MCHP_CORESPI_REG_STAT) &
+		       MCHP_CORESPI_STATUS_RXFIFO_EMPTY)
+			;
+
+		data = readb(spi->regs + MCHP_CORESPI_REG_RXDATA);
+
+		spi->rx_len--;
+		if (!spi->rx_buf)
+			continue;
+
+		*spi->rx_buf = data;
+
+		spi->rx_buf++;
+	}
+}
+
+static void mchp_corespi_enable_ints(struct mchp_corespi *spi)
+{
+	u8 control = readb(spi->regs + MCHP_CORESPI_REG_CONTROL);
+
+	control |= INT_ENABLE_MASK;
+	writeb(control, spi->regs + MCHP_CORESPI_REG_CONTROL);
+}
+
+static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
+{
+	u8 control = readb(spi->regs + MCHP_CORESPI_REG_CONTROL);
+
+	control &= ~INT_ENABLE_MASK;
+	writeb(control, spi->regs + MCHP_CORESPI_REG_CONTROL);
+}
+
+static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, u32 fifo_max)
+{
+	int i = 0;
+
+	while ((i < fifo_max) &&
+	       !(readb(spi->regs + MCHP_CORESPI_REG_STAT) &
+		 MCHP_CORESPI_STATUS_TXFIFO_FULL)) {
+		u32 word;
+
+		word = spi->tx_buf ? *spi->tx_buf : 0xaa;
+		writeb(word, spi->regs + MCHP_CORESPI_REG_TXDATA);
+
+		if (spi->tx_buf)
+			spi->tx_buf++;
+
+		i++;
+	}
+
+	spi->tx_len -= i;
+}
+
+static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
+{
+	struct mchp_corespi *corespi = spi_controller_get_devdata(spi->controller);
+	u32 reg;
+
+	reg = readb(corespi->regs + MCHP_CORESPI_REG_SSEL);
+	reg &= ~BIT(spi_get_chipselect(spi, 0));
+	reg |= !disable << spi_get_chipselect(spi, 0);
+
+	writeb(reg, corespi->regs + MCHP_CORESPI_REG_SSEL);
+}
+
+static int mchp_corespi_setup(struct spi_device *spi)
+{
+	u32 dev_mode = spi->mode & (SPI_CPOL | SPI_CPHA);
+
+	if (spi_get_csgpiod(spi, 0))
+		return 0;
+
+	if (spi->mode & (SPI_CS_HIGH)) {
+		dev_err(&spi->dev, "unable to support active-high CS in Motorola mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (dev_mode & ~spi->controller->mode_bits) {
+		dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *spi)
+{
+	u8 control = readb(spi->regs + MCHP_CORESPI_REG_CONTROL);
+
+	/* Master mode changes require core to be disabled.*/
+	control = (control & ~MCHP_CORESPI_CONTROL_ENABLE) | MCHP_CORESPI_CONTROL_MASTER;
+
+	writeb(control, spi->regs + MCHP_CORESPI_REG_CONTROL);
+
+	mchp_corespi_enable_ints(spi);
+
+	control = readb(spi->regs + MCHP_CORESPI_REG_CONTROL);
+	control |= MCHP_CORESPI_CONTROL_ENABLE;
+
+	writeb(control, spi->regs + MCHP_CORESPI_REG_CONTROL);
+}
+
+static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
+{
+	struct spi_controller *host = dev_id;
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
+	u8 intfield = readb(spi->regs + MCHP_CORESPI_REG_INTMASK) & 0xff;
+	bool finalise = false;
+
+	/* Interrupt line may be shared and not for us at all */
+	if (intfield == 0)
+		return IRQ_NONE;
+
+	if (intfield & MCHP_CORESPI_INT_TXDONE)
+		writeb(MCHP_CORESPI_INT_TXDONE, spi->regs + MCHP_CORESPI_REG_INTCLEAR);
+
+	if (intfield & MCHP_CORESPI_INT_RX_CHANNEL_OVERFLOW) {
+		writeb(MCHP_CORESPI_INT_RX_CHANNEL_OVERFLOW,
+		       spi->regs + MCHP_CORESPI_REG_INTCLEAR);
+		finalise = true;
+		dev_err(&host->dev,
+			"RX OVERFLOW: rxlen: %d, txlen: %d\n",
+			spi->rx_len, spi->tx_len);
+	}
+
+	if (intfield & MCHP_CORESPI_INT_TX_CHANNEL_UNDERRUN) {
+		writeb(MCHP_CORESPI_INT_TX_CHANNEL_UNDERRUN,
+		       spi->regs + MCHP_CORESPI_REG_INTCLEAR);
+		finalise = true;
+		dev_err(&host->dev,
+			"TX UNDERFLOW: rxlen: %d, txlen: %d\n",
+			spi->rx_len, spi->tx_len);
+	}
+
+	if (finalise)
+		spi_finalize_current_transfer(host);
+
+	return IRQ_HANDLED;
+}
+
+static int mchp_corespi_set_clk_div(struct mchp_corespi *spi,
+				    unsigned long target_hz)
+{
+	unsigned long pclk_hz, spi_hz;
+	u32 clk_div;
+
+	/* Get peripheral clock rate */
+	pclk_hz = clk_get_rate(spi->clk);
+	if (!pclk_hz)
+		return -EINVAL;
+
+	/*
+	 * Calculate clock rate generated by SPI master
+	 * Formula: SPICLK = PCLK / (2 * (CLK_DIV + 1))
+	 */
+	clk_div = DIV_ROUND_UP(pclk_hz, 2 * target_hz) - 1;
+
+	if (clk_div > 0xFF)
+		return -EINVAL;
+
+	spi_hz = pclk_hz / (2 * (clk_div + 1));
+
+	if (spi_hz > target_hz)
+		return -EINVAL;
+
+	writeb(clk_div, spi->regs + MCHP_CORESPI_REG_CLK_DIV);
+
+	return 0;
+}
+
+static int mchp_corespi_transfer_one(struct spi_controller *host,
+				     struct spi_device *spi_dev,
+				     struct spi_transfer *xfer)
+{
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
+	int ret;
+
+	ret = mchp_corespi_set_clk_div(spi, (unsigned long)xfer->speed_hz);
+	if (ret) {
+		dev_err(&host->dev, "failed to set clock divider for target %u Hz\n",
+			xfer->speed_hz);
+		return ret;
+	}
+
+	spi->tx_buf = xfer->tx_buf;
+	spi->rx_buf = xfer->rx_buf;
+	spi->tx_len = xfer->len;
+	spi->rx_len = xfer->len;
+
+	while (spi->tx_len) {
+		int fifo_max = min_t(int, spi->tx_len, spi->fifo_depth);
+
+		mchp_corespi_write_fifo(spi, fifo_max);
+		mchp_corespi_read_fifo(spi, fifo_max);
+	}
+
+	spi_finalize_current_transfer(host);
+	return 1;
+}
+
+static int mchp_corespi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *host;
+	struct mchp_corespi *spi;
+	struct resource *res;
+	const char *protocol;
+	u32 num_cs, mode, frame_size;
+	bool assert_ssel;
+	int ret = 0;
+
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
+	if (!host)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "unable to allocate host for SPI controller\n");
+
+	platform_set_drvdata(pdev, host);
+
+	if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
+		num_cs = MCHP_CORESPI_MAX_CS;
+
+	/*
+	 * Protocol: CFG_MODE
+	 * CoreSPI can be configured for Motorola, TI or NSC.
+	 * The current driver supports only Motorola mode.
+	 */
+	ret = of_property_read_string(pdev->dev.of_node, "microchip,protocol-configuration",
+				      &protocol);
+	if (strcmp(protocol, "motorola") != 0)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "CoreSPI: protocol '%s' not supported by this driver\n",
+				      protocol);
+
+	/*
+	 * Motorola mode (0-3): CFG_MOT_MODE
+	 * Mode is fixed in the IP configurator.
+	 */
+	ret = of_property_read_u32(pdev->dev.of_node, "microchip,motorola-mode", &mode);
+	if (ret)
+		mode = MCHP_CORESPI_DEFAULT_MOTOROLA_MODE;
+	else if (mode > 3)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "invalid 'microchip,motorola-mode' value %u\n", mode);
+
+	/*
+	 * Frame size: CFG_FRAME_SIZE
+	 * The hardware allows frame sizes <= APB data width.
+	 * However, this driver currently only supports 8-bit frames.
+	 */
+	ret = of_property_read_u32(pdev->dev.of_node, "microchip,frame-size", &frame_size);
+	if (!ret && frame_size != 8)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "CoreSPI: frame size %u not supported by this driver\n",
+				     frame_size);
+
+	/*
+	 * SSEL: CFG_MOT_SSEL
+	 * CoreSPI deasserts SSEL when the TX FIFO empties.
+	 * To prevent CS deassertion when TX FIFO drains, the ssel-active property
+	 * keeps CS asserted for the full SPI transfer.
+	 */
+	assert_ssel = of_property_read_bool(pdev->dev.of_node, "microchip,ssel-active");
+	if (!assert_ssel)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "hardware must enable 'microchip,ssel-active' to keep CS asserted for the SPI transfer\n");
+
+	spi = spi_controller_get_devdata(host);
+
+	host->num_chipselect = num_cs;
+	host->mode_bits = mode;
+	host->setup = mchp_corespi_setup;
+	host->use_gpio_descriptors = true;
+	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	host->transfer_one = mchp_corespi_transfer_one;
+	host->set_cs = mchp_corespi_set_cs;
+	host->dev.of_node = pdev->dev.of_node;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "fifo-depth", &spi->fifo_depth);
+	if (ret)
+		spi->fifo_depth = MCHP_CORESPI_DEFAULT_FIFO_DEPTH;
+
+	spi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(spi->regs))
+		return PTR_ERR(spi->regs);
+
+	spi->irq = platform_get_irq(pdev, 0);
+	if (spi->irq < 0)
+		return spi->irq;
+
+	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
+			       IRQF_SHARED, dev_name(&pdev->dev), host);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not request irq\n");
+
+	spi->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(spi->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(spi->clk),
+				     "could not get clk\n");
+
+	mchp_corespi_init(host, spi);
+
+	ret = devm_spi_register_controller(&pdev->dev, host);
+	if (ret) {
+		mchp_corespi_disable(spi);
+		return dev_err_probe(&pdev->dev, ret,
+				     "unable to register host for CoreSPI controller\n");
+	}
+
+	return 0;
+}
+
+static void mchp_corespi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *host = platform_get_drvdata(pdev);
+	struct mchp_corespi *spi = spi_controller_get_devdata(host);
+
+	mchp_corespi_disable_ints(spi);
+	mchp_corespi_disable(spi);
+}
+
+#define MICROCHIP_SPI_PM_OPS (NULL)
+
+/*
+ * Platform driver data structure
+ */
+
+#if defined(CONFIG_OF)
+static const struct of_device_id mchp_corespi_dt_ids[] = {
+	{ .compatible = "microchip,corespi-rtl-v5" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mchp_corespi_dt_ids);
+#endif
+
+static struct platform_driver mchp_corespi_driver = {
+	.probe = mchp_corespi_probe,
+	.driver = {
+		.name = "microchip-corespi",
+		.pm = MICROCHIP_SPI_PM_OPS,
+		.of_match_table = of_match_ptr(mchp_corespi_dt_ids),
+	},
+	.remove = mchp_corespi_remove,
+};
+module_platform_driver(mchp_corespi_driver);
+MODULE_DESCRIPTION("Microchip CoreSPI controller driver");
+MODULE_AUTHOR("Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1


