Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41734B42
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfFDO7S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 10:59:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbfFDO7S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jun 2019 10:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VG8RIZB/fVykztjLz6hZS/YeeCSlNB8/crzajnS9OUc=; b=xhlq3WZ3TB9y
        X76xvfBOIh6kgmk+XkPMeUwDHVfqCi9ueVQWkjuy0oaA714qZTnV9nT71b+2uOczfiUqVVhChNz4e
        zxlIsi89QeQlugUKLLQMY24LW8H0n+cb4FlW3Xl09IFhW9PqMJP6YeN4mtNVibeekE52h/EhBA0dQ
        abP3U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAu6-0006Fo-2y; Tue, 04 Jun 2019 14:59:10 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A51B7440046; Tue,  4 Jun 2019 15:59:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     andy.shevchenko@gmail.com, ard.biesheuvel@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        geert@linux-m68k.org, Jassi Brar <jaswinder.singh@linaro.org>,
        jaswinder.singh@linaro.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        masami.hiramatsu@linaro.org, okamoto.satoru@socionext.com,
        osaki.yoshitoyo@socionext.com, robh+dt@kernel.org,
        tpiepho@impinj.com
Subject: Applied "spi: Add spi driver for Socionext SynQuacer platform" to the spi tree
In-Reply-To: <20190604051257.14264-4-masahisa.kojima@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190604145909.A51B7440046@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:59:09 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Add spi driver for Socionext SynQuacer platform

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b0823ee35cf9bc6b9a5403c12f12bd3e0b490045 Mon Sep 17 00:00:00 2001
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 4 Jun 2019 14:12:57 +0900
Subject: [PATCH] spi: Add spi driver for Socionext SynQuacer platform

This patch adds support for controller found on synquacer platforms.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig         |  10 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-synquacer.c | 822 ++++++++++++++++++++++++++++++++++++
 3 files changed, 833 insertions(+)
 create mode 100644 drivers/spi/spi-synquacer.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3ee152feee2b..5c903e5c2fd4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -732,6 +732,16 @@ config SPI_SUN6I
 	help
 	  This enables using the SPI controller on the Allwinner A31 SoCs.
 
+config SPI_SYNQUACER
+	tristate "Socionext's SynQuacer HighSpeed SPI controller"
+	depends on ARCH_SYNQUACER || COMPILE_TEST
+	help
+	  SPI driver for Socionext's High speed SPI controller which provides
+	  various operating modes for interfacing to serial peripheral devices
+	  that use the de-facto standard SPI protocol.
+
+	  It also supports the new dual-bit and quad-bit SPI protocol.
+
 config SPI_MXIC
         tristate "Macronix MX25F0A SPI controller"
         depends on SPI_MASTER
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index f2f78d03dc28..63dcab552bcb 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_SPI_STM32_QSPI) 		+= spi-stm32-qspi.o
 obj-$(CONFIG_SPI_ST_SSC4)		+= spi-st-ssc4.o
 obj-$(CONFIG_SPI_SUN4I)			+= spi-sun4i.o
 obj-$(CONFIG_SPI_SUN6I)			+= spi-sun6i.o
+obj-$(CONFIG_SPI_SYNQUACER)		+= spi-synquacer.o
 obj-$(CONFIG_SPI_TEGRA114)		+= spi-tegra114.o
 obj-$(CONFIG_SPI_TEGRA20_SFLASH)	+= spi-tegra20-sflash.o
 obj-$(CONFIG_SPI_TEGRA20_SLINK)		+= spi-tegra20-slink.o
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
new file mode 100644
index 000000000000..c8c8d9cdd4b3
--- /dev/null
+++ b/drivers/spi/spi-synquacer.c
@@ -0,0 +1,822 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Synquacer HSSPI controller driver
+//
+// Copyright (c) 2015-2018 Socionext Inc.
+// Copyright (c) 2018-2019 Linaro Ltd.
+//
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+
+/* HSSPI register address definitions */
+#define SYNQUACER_HSSPI_REG_MCTRL	0x00
+#define SYNQUACER_HSSPI_REG_PCC0	0x04
+#define SYNQUACER_HSSPI_REG_PCC(n)	(SYNQUACER_HSSPI_REG_PCC0 + (n) * 4)
+#define SYNQUACER_HSSPI_REG_TXF		0x14
+#define SYNQUACER_HSSPI_REG_TXE		0x18
+#define SYNQUACER_HSSPI_REG_TXC		0x1C
+#define SYNQUACER_HSSPI_REG_RXF		0x20
+#define SYNQUACER_HSSPI_REG_RXE		0x24
+#define SYNQUACER_HSSPI_REG_RXC		0x28
+#define SYNQUACER_HSSPI_REG_FAULTF	0x2C
+#define SYNQUACER_HSSPI_REG_FAULTC	0x30
+#define SYNQUACER_HSSPI_REG_DMCFG	0x34
+#define SYNQUACER_HSSPI_REG_DMSTART	0x38
+#define SYNQUACER_HSSPI_REG_DMBCC	0x3C
+#define SYNQUACER_HSSPI_REG_DMSTATUS	0x40
+#define SYNQUACER_HSSPI_REG_FIFOCFG	0x4C
+#define SYNQUACER_HSSPI_REG_TX_FIFO	0x50
+#define SYNQUACER_HSSPI_REG_RX_FIFO	0x90
+#define SYNQUACER_HSSPI_REG_MID		0xFC
+
+/* HSSPI register bit definitions */
+#define SYNQUACER_HSSPI_MCTRL_MEN			BIT(0)
+#define SYNQUACER_HSSPI_MCTRL_COMMAND_SEQUENCE_EN	BIT(1)
+#define SYNQUACER_HSSPI_MCTRL_CDSS			BIT(3)
+#define SYNQUACER_HSSPI_MCTRL_MES			BIT(4)
+#define SYNQUACER_HSSPI_MCTRL_SYNCON			BIT(5)
+
+#define SYNQUACER_HSSPI_PCC_CPHA		BIT(0)
+#define SYNQUACER_HSSPI_PCC_CPOL		BIT(1)
+#define SYNQUACER_HSSPI_PCC_ACES		BIT(2)
+#define SYNQUACER_HSSPI_PCC_RTM			BIT(3)
+#define SYNQUACER_HSSPI_PCC_SSPOL		BIT(4)
+#define SYNQUACER_HSSPI_PCC_SDIR		BIT(7)
+#define SYNQUACER_HSSPI_PCC_SENDIAN		BIT(8)
+#define SYNQUACER_HSSPI_PCC_SAFESYNC		BIT(16)
+#define SYNQUACER_HSSPI_PCC_SS2CD_SHIFT		5U
+#define SYNQUACER_HSSPI_PCC_CDRS_MASK		0x7f
+#define SYNQUACER_HSSPI_PCC_CDRS_SHIFT		9U
+
+#define SYNQUACER_HSSPI_TXF_FIFO_FULL		BIT(0)
+#define SYNQUACER_HSSPI_TXF_FIFO_EMPTY		BIT(1)
+#define SYNQUACER_HSSPI_TXF_SLAVE_RELEASED	BIT(6)
+
+#define SYNQUACER_HSSPI_TXE_FIFO_FULL		BIT(0)
+#define SYNQUACER_HSSPI_TXE_FIFO_EMPTY		BIT(1)
+#define SYNQUACER_HSSPI_TXE_SLAVE_RELEASED	BIT(6)
+
+#define SYNQUACER_HSSPI_RXF_FIFO_MORE_THAN_THRESHOLD		BIT(5)
+#define SYNQUACER_HSSPI_RXF_SLAVE_RELEASED			BIT(6)
+
+#define SYNQUACER_HSSPI_RXE_FIFO_MORE_THAN_THRESHOLD		BIT(5)
+#define SYNQUACER_HSSPI_RXE_SLAVE_RELEASED			BIT(6)
+
+#define SYNQUACER_HSSPI_DMCFG_SSDC		BIT(1)
+#define SYNQUACER_HSSPI_DMCFG_MSTARTEN		BIT(2)
+
+#define SYNQUACER_HSSPI_DMSTART_START		BIT(0)
+#define SYNQUACER_HSSPI_DMSTOP_STOP		BIT(8)
+#define SYNQUACER_HSSPI_DMPSEL_CS_MASK		0x3
+#define SYNQUACER_HSSPI_DMPSEL_CS_SHIFT		16U
+#define SYNQUACER_HSSPI_DMTRP_BUS_WIDTH_SHIFT	24U
+#define SYNQUACER_HSSPI_DMTRP_DATA_MASK		0x3
+#define SYNQUACER_HSSPI_DMTRP_DATA_SHIFT	26U
+#define SYNQUACER_HSSPI_DMTRP_DATA_TXRX		0
+#define SYNQUACER_HSSPI_DMTRP_DATA_RX		1
+#define SYNQUACER_HSSPI_DMTRP_DATA_TX		2
+
+#define SYNQUACER_HSSPI_DMSTATUS_RX_DATA_MASK	0x1f
+#define SYNQUACER_HSSPI_DMSTATUS_RX_DATA_SHIFT	8U
+#define SYNQUACER_HSSPI_DMSTATUS_TX_DATA_MASK	0x1f
+#define SYNQUACER_HSSPI_DMSTATUS_TX_DATA_SHIFT	16U
+
+#define SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_MASK	0xf
+#define SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_SHIFT	0U
+#define SYNQUACER_HSSPI_FIFOCFG_TX_THRESHOLD_MASK	0xf
+#define SYNQUACER_HSSPI_FIFOCFG_TX_THRESHOLD_SHIFT	4U
+#define SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_MASK		0x3
+#define SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_SHIFT	8U
+#define SYNQUACER_HSSPI_FIFOCFG_RX_FLUSH		BIT(11)
+#define SYNQUACER_HSSPI_FIFOCFG_TX_FLUSH		BIT(12)
+
+#define SYNQUACER_HSSPI_FIFO_DEPTH		16U
+#define SYNQUACER_HSSPI_FIFO_TX_THRESHOLD	4U
+#define SYNQUACER_HSSPI_FIFO_RX_THRESHOLD \
+	(SYNQUACER_HSSPI_FIFO_DEPTH - SYNQUACER_HSSPI_FIFO_TX_THRESHOLD)
+
+#define SYNQUACER_HSSPI_TRANSFER_MODE_TX	BIT(1)
+#define SYNQUACER_HSSPI_TRANSFER_MODE_RX	BIT(2)
+#define SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC	2000U
+#define SYNQUACER_HSSPI_ENABLE_TMOUT_MSEC	1000U
+
+#define SYNQUACER_HSSPI_CLOCK_SRC_IHCLK		0
+#define SYNQUACER_HSSPI_CLOCK_SRC_IPCLK		1
+
+#define SYNQUACER_HSSPI_NUM_CHIP_SELECT		4U
+#define SYNQUACER_HSSPI_IRQ_NAME_MAX		32U
+
+struct synquacer_spi {
+	struct device *dev;
+	struct completion transfer_done;
+	unsigned int cs;
+	unsigned int bpw;
+	unsigned int mode;
+	unsigned int speed;
+	bool aces, rtm;
+	void *rx_buf;
+	const void *tx_buf;
+	struct clk *clk;
+	int clk_src_type;
+	void __iomem *regs;
+	u32 tx_words, rx_words;
+	unsigned int bus_width;
+	unsigned int transfer_mode;
+	char rx_irq_name[SYNQUACER_HSSPI_IRQ_NAME_MAX];
+	char tx_irq_name[SYNQUACER_HSSPI_IRQ_NAME_MAX];
+};
+
+static int read_fifo(struct synquacer_spi *sspi)
+{
+	u32 len = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTATUS);
+
+	len = (len >> SYNQUACER_HSSPI_DMSTATUS_RX_DATA_SHIFT) &
+	       SYNQUACER_HSSPI_DMSTATUS_RX_DATA_MASK;
+	len = min(len, sspi->rx_words);
+
+	switch (sspi->bpw) {
+	case 8: {
+		u8 *buf = sspi->rx_buf;
+
+		readsb(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		sspi->rx_buf = buf + len;
+		break;
+	}
+	case 16: {
+		u16 *buf = sspi->rx_buf;
+
+		readsw(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		sspi->rx_buf = buf + len;
+		break;
+	}
+	case 24:
+		/* fallthrough, should use 32-bits access */
+	case 32: {
+		u32 *buf = sspi->rx_buf;
+
+		readsl(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
+		sspi->rx_buf = buf + len;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	sspi->rx_words -= len;
+	return 0;
+}
+
+static int write_fifo(struct synquacer_spi *sspi)
+{
+	u32 len = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTATUS);
+
+	len = (len >> SYNQUACER_HSSPI_DMSTATUS_TX_DATA_SHIFT) &
+	       SYNQUACER_HSSPI_DMSTATUS_TX_DATA_MASK;
+	len = min(SYNQUACER_HSSPI_FIFO_DEPTH - len,
+		    sspi->tx_words);
+
+	switch (sspi->bpw) {
+	case 8: {
+		const u8 *buf = sspi->tx_buf;
+
+		writesb(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		sspi->tx_buf = buf + len;
+		break;
+	}
+	case 16: {
+		const u16 *buf = sspi->tx_buf;
+
+		writesw(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		sspi->tx_buf = buf + len;
+		break;
+	}
+	case 24:
+		/* fallthrough, should use 32-bits access */
+	case 32: {
+		const u32 *buf = sspi->tx_buf;
+
+		writesl(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
+		sspi->tx_buf = buf + len;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	sspi->tx_words -= len;
+	return 0;
+}
+
+static int synquacer_spi_config(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	unsigned int speed, mode, bpw, cs, bus_width, transfer_mode;
+	u32 rate, val, div;
+
+	/* Full Duplex only on 1-bit wide bus */
+	if (xfer->rx_buf && xfer->tx_buf &&
+	    (xfer->rx_nbits != 1 || xfer->tx_nbits != 1)) {
+		dev_err(sspi->dev,
+			"RX and TX bus widths must be 1-bit for Full-Duplex!\n");
+		return -EINVAL;
+	}
+
+	if (xfer->tx_buf) {
+		bus_width = xfer->tx_nbits;
+		transfer_mode = SYNQUACER_HSSPI_TRANSFER_MODE_TX;
+	} else {
+		bus_width = xfer->rx_nbits;
+		transfer_mode = SYNQUACER_HSSPI_TRANSFER_MODE_RX;
+	}
+
+	mode = spi->mode;
+	cs = spi->chip_select;
+	speed = xfer->speed_hz;
+	bpw = xfer->bits_per_word;
+
+	/* return if nothing to change */
+	if (speed == sspi->speed &&
+		bus_width == sspi->bus_width && bpw == sspi->bpw &&
+		mode == sspi->mode && cs == sspi->cs &&
+		transfer_mode == sspi->transfer_mode) {
+		return 0;
+	}
+
+	sspi->transfer_mode = transfer_mode;
+	rate = master->max_speed_hz;
+
+	div = DIV_ROUND_UP(rate, speed);
+	if (div > 254) {
+		dev_err(sspi->dev, "Requested rate too low (%u)\n",
+			sspi->speed);
+		return -EINVAL;
+	}
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_PCC(cs));
+	val &= ~SYNQUACER_HSSPI_PCC_SAFESYNC;
+	if (bpw == 8 &&	(mode & (SPI_TX_DUAL | SPI_RX_DUAL)) && div < 3)
+		val |= SYNQUACER_HSSPI_PCC_SAFESYNC;
+	if (bpw == 8 &&	(mode & (SPI_TX_QUAD | SPI_RX_QUAD)) && div < 6)
+		val |= SYNQUACER_HSSPI_PCC_SAFESYNC;
+	if (bpw == 16 && (mode & (SPI_TX_QUAD | SPI_RX_QUAD)) && div < 3)
+		val |= SYNQUACER_HSSPI_PCC_SAFESYNC;
+
+	if (mode & SPI_CPHA)
+		val |= SYNQUACER_HSSPI_PCC_CPHA;
+	else
+		val &= ~SYNQUACER_HSSPI_PCC_CPHA;
+
+	if (mode & SPI_CPOL)
+		val |= SYNQUACER_HSSPI_PCC_CPOL;
+	else
+		val &= ~SYNQUACER_HSSPI_PCC_CPOL;
+
+	if (mode & SPI_CS_HIGH)
+		val |= SYNQUACER_HSSPI_PCC_SSPOL;
+	else
+		val &= ~SYNQUACER_HSSPI_PCC_SSPOL;
+
+	if (mode & SPI_LSB_FIRST)
+		val |= SYNQUACER_HSSPI_PCC_SDIR;
+	else
+		val &= ~SYNQUACER_HSSPI_PCC_SDIR;
+
+	if (sspi->aces)
+		val |= SYNQUACER_HSSPI_PCC_ACES;
+	else
+		val &= ~SYNQUACER_HSSPI_PCC_ACES;
+
+	if (sspi->rtm)
+		val |= SYNQUACER_HSSPI_PCC_RTM;
+	else
+		val &= ~SYNQUACER_HSSPI_PCC_RTM;
+
+	val |= (3 << SYNQUACER_HSSPI_PCC_SS2CD_SHIFT);
+	val |= SYNQUACER_HSSPI_PCC_SENDIAN;
+
+	val &= ~(SYNQUACER_HSSPI_PCC_CDRS_MASK <<
+		 SYNQUACER_HSSPI_PCC_CDRS_SHIFT);
+	val |= ((div >> 1) << SYNQUACER_HSSPI_PCC_CDRS_SHIFT);
+
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_PCC(cs));
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
+	val &= ~(SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_MASK <<
+		 SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_SHIFT);
+	val |= ((bpw / 8 - 1) << SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_SHIFT);
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+	val &= ~(SYNQUACER_HSSPI_DMTRP_DATA_MASK <<
+		 SYNQUACER_HSSPI_DMTRP_DATA_SHIFT);
+
+	if (xfer->rx_buf)
+		val |= (SYNQUACER_HSSPI_DMTRP_DATA_RX <<
+			SYNQUACER_HSSPI_DMTRP_DATA_SHIFT);
+	else
+		val |= (SYNQUACER_HSSPI_DMTRP_DATA_TX <<
+			SYNQUACER_HSSPI_DMTRP_DATA_SHIFT);
+
+	val &= ~(3 << SYNQUACER_HSSPI_DMTRP_BUS_WIDTH_SHIFT);
+	val |= ((bus_width >> 1) << SYNQUACER_HSSPI_DMTRP_BUS_WIDTH_SHIFT);
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+
+	sspi->bpw = bpw;
+	sspi->mode = mode;
+	sspi->speed = speed;
+	sspi->cs = spi->chip_select;
+	sspi->bus_width = bus_width;
+
+	return 0;
+}
+
+static int synquacer_spi_transfer_one(struct spi_master *master,
+				      struct spi_device *spi,
+				      struct spi_transfer *xfer)
+{
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	int ret;
+	int status = 0;
+	u32 words;
+	u8 bpw;
+	u32 val;
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+	val &= ~SYNQUACER_HSSPI_DMSTOP_STOP;
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
+	val |= SYNQUACER_HSSPI_FIFOCFG_RX_FLUSH;
+	val |= SYNQUACER_HSSPI_FIFOCFG_TX_FLUSH;
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
+
+	/*
+	 * See if we can transfer 4-bytes as 1 word
+	 * to maximize the FIFO buffer efficiency.
+	 */
+	bpw = xfer->bits_per_word;
+	if (bpw == 8 && !(xfer->len % 4) && !(spi->mode & SPI_LSB_FIRST))
+		xfer->bits_per_word = 32;
+
+	ret = synquacer_spi_config(master, spi, xfer);
+
+	/* restore */
+	xfer->bits_per_word = bpw;
+
+	if (ret)
+		return ret;
+
+	reinit_completion(&sspi->transfer_done);
+
+	sspi->tx_buf = xfer->tx_buf;
+	sspi->rx_buf = xfer->rx_buf;
+
+	switch (sspi->bpw) {
+	case 8:
+		words = xfer->len;
+		break;
+	case 16:
+		words = xfer->len / 2;
+		break;
+	case 24:
+		/* fallthrough, should use 32-bits access */
+	case 32:
+		words = xfer->len / 4;
+		break;
+	default:
+		dev_err(sspi->dev, "unsupported bpw: %d\n", sspi->bpw);
+		return -EINVAL;
+	}
+
+	if (xfer->tx_buf)
+		sspi->tx_words = words;
+	else
+		sspi->tx_words = 0;
+
+	if (xfer->rx_buf)
+		sspi->rx_words = words;
+	else
+		sspi->rx_words = 0;
+
+	if (xfer->tx_buf) {
+		status = write_fifo(sspi);
+		if (status < 0) {
+			dev_err(sspi->dev, "failed write_fifo. status: 0x%x\n",
+				status);
+			return status;
+		}
+	}
+
+	if (xfer->rx_buf) {
+		val = readl(sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
+		val &= ~(SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_MASK <<
+			 SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_SHIFT);
+		val |= ((sspi->rx_words > SYNQUACER_HSSPI_FIFO_DEPTH ?
+			SYNQUACER_HSSPI_FIFO_RX_THRESHOLD : sspi->rx_words) <<
+			SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_SHIFT);
+		writel(val, sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
+	}
+
+	writel(~0, sspi->regs + SYNQUACER_HSSPI_REG_TXC);
+	writel(~0, sspi->regs + SYNQUACER_HSSPI_REG_RXC);
+
+	/* Trigger */
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+	val |= SYNQUACER_HSSPI_DMSTART_START;
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+
+	if (xfer->tx_buf) {
+		val = SYNQUACER_HSSPI_TXE_FIFO_EMPTY;
+		writel(val, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
+		status = wait_for_completion_timeout(&sspi->transfer_done,
+			msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
+		writel(0, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
+	}
+
+	if (xfer->rx_buf) {
+		u32 buf[SYNQUACER_HSSPI_FIFO_DEPTH];
+
+		val = SYNQUACER_HSSPI_RXE_FIFO_MORE_THAN_THRESHOLD |
+		      SYNQUACER_HSSPI_RXE_SLAVE_RELEASED;
+		writel(val, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
+		status = wait_for_completion_timeout(&sspi->transfer_done,
+			msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
+		writel(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
+
+		/* stop RX and clean RXFIFO */
+		val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+		val |= SYNQUACER_HSSPI_DMSTOP_STOP;
+		writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+		sspi->rx_buf = buf;
+		sspi->rx_words = SYNQUACER_HSSPI_FIFO_DEPTH;
+		read_fifo(sspi);
+	}
+
+	if (status < 0) {
+		dev_err(sspi->dev, "failed to transfer. status: 0x%x\n",
+			status);
+		return status;
+	}
+
+	return 0;
+}
+
+static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
+	u32 val;
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+	val &= ~(SYNQUACER_HSSPI_DMPSEL_CS_MASK <<
+		 SYNQUACER_HSSPI_DMPSEL_CS_SHIFT);
+	val |= spi->chip_select << SYNQUACER_HSSPI_DMPSEL_CS_SHIFT;
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
+}
+
+static int synquacer_spi_wait_status_update(struct synquacer_spi *sspi,
+					    bool enable)
+{
+	u32 val;
+	unsigned long timeout = jiffies +
+		msecs_to_jiffies(SYNQUACER_HSSPI_ENABLE_TMOUT_MSEC);
+
+	/* wait MES(Module Enable Status) is updated */
+	do {
+		val = readl(sspi->regs + SYNQUACER_HSSPI_REG_MCTRL) &
+		      SYNQUACER_HSSPI_MCTRL_MES;
+		if (enable && val)
+			return 0;
+		if (!enable && !val)
+			return 0;
+	} while (time_before(jiffies, timeout));
+
+	dev_err(sspi->dev, "timeout occurs in updating Module Enable Status\n");
+	return -EBUSY;
+}
+
+static int synquacer_spi_enable(struct spi_master *master)
+{
+	u32 val;
+	int status;
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+
+	/* Disable module */
+	writel(0, sspi->regs + SYNQUACER_HSSPI_REG_MCTRL);
+	status = synquacer_spi_wait_status_update(sspi, false);
+	if (status < 0)
+		return status;
+
+	writel(0, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
+	writel(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
+	writel(~0, sspi->regs + SYNQUACER_HSSPI_REG_TXC);
+	writel(~0, sspi->regs + SYNQUACER_HSSPI_REG_RXC);
+	writel(~0, sspi->regs + SYNQUACER_HSSPI_REG_FAULTC);
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMCFG);
+	val &= ~SYNQUACER_HSSPI_DMCFG_SSDC;
+	val &= ~SYNQUACER_HSSPI_DMCFG_MSTARTEN;
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_DMCFG);
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_MCTRL);
+	if (sspi->clk_src_type == SYNQUACER_HSSPI_CLOCK_SRC_IPCLK)
+		val |= SYNQUACER_HSSPI_MCTRL_CDSS;
+	else
+		val &= ~SYNQUACER_HSSPI_MCTRL_CDSS;
+
+	val &= ~SYNQUACER_HSSPI_MCTRL_COMMAND_SEQUENCE_EN;
+	val |= SYNQUACER_HSSPI_MCTRL_MEN;
+	val |= SYNQUACER_HSSPI_MCTRL_SYNCON;
+
+	/* Enable module */
+	writel(val, sspi->regs + SYNQUACER_HSSPI_REG_MCTRL);
+	status = synquacer_spi_wait_status_update(sspi, true);
+	if (status < 0)
+		return status;
+
+	return 0;
+}
+
+static irqreturn_t sq_spi_rx_handler(int irq, void *priv)
+{
+	uint32_t val;
+	struct synquacer_spi *sspi = priv;
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_RXF);
+	if ((val & SYNQUACER_HSSPI_RXF_SLAVE_RELEASED) ||
+	    (val & SYNQUACER_HSSPI_RXF_FIFO_MORE_THAN_THRESHOLD)) {
+		read_fifo(sspi);
+
+		if (sspi->rx_words == 0) {
+			writel(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
+			complete(&sspi->transfer_done);
+		}
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t sq_spi_tx_handler(int irq, void *priv)
+{
+	uint32_t val;
+	struct synquacer_spi *sspi = priv;
+
+	val = readl(sspi->regs + SYNQUACER_HSSPI_REG_TXF);
+	if (val & SYNQUACER_HSSPI_TXF_FIFO_EMPTY) {
+		if (sspi->tx_words == 0) {
+			writel(0, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
+			complete(&sspi->transfer_done);
+		} else {
+			write_fifo(sspi);
+		}
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int synquacer_spi_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct spi_master *master;
+	struct synquacer_spi *sspi;
+	int ret;
+	int rx_irq, tx_irq;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
+	if (!master)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, master);
+
+	sspi = spi_master_get_devdata(master);
+	sspi->dev = &pdev->dev;
+
+	init_completion(&sspi->transfer_done);
+
+	sspi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sspi->regs)) {
+		ret = PTR_ERR(sspi->regs);
+		goto put_spi;
+	}
+
+	sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK; /* Default */
+	device_property_read_u32(&pdev->dev, "socionext,ihclk-rate",
+				 &master->max_speed_hz); /* for ACPI */
+
+	if (dev_of_node(&pdev->dev)) {
+		if (device_property_match_string(&pdev->dev,
+					 "clock-names", "iHCLK") >= 0) {
+			sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK;
+			sspi->clk = devm_clk_get(sspi->dev, "iHCLK");
+		} else if (device_property_match_string(&pdev->dev,
+						"clock-names", "iPCLK") >= 0) {
+			sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IPCLK;
+			sspi->clk = devm_clk_get(sspi->dev, "iPCLK");
+		} else {
+			dev_err(&pdev->dev, "specified wrong clock source\n");
+			ret = -EINVAL;
+			goto put_spi;
+		}
+
+		if (IS_ERR(sspi->clk)) {
+			if (!(PTR_ERR(sspi->clk) == -EPROBE_DEFER))
+				dev_err(&pdev->dev, "clock not found\n");
+			ret = PTR_ERR(sspi->clk);
+			goto put_spi;
+		}
+
+		ret = clk_prepare_enable(sspi->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to enable clock (%d)\n",
+				ret);
+			goto put_spi;
+		}
+
+		master->max_speed_hz = clk_get_rate(sspi->clk);
+	}
+
+	if (!master->max_speed_hz) {
+		dev_err(&pdev->dev, "missing clock source\n");
+		return -EINVAL;
+	}
+	master->min_speed_hz = master->max_speed_hz / 254;
+
+	sspi->aces = device_property_read_bool(&pdev->dev,
+					       "socionext,set-aces");
+	sspi->rtm = device_property_read_bool(&pdev->dev, "socionext,use-rtm");
+
+	master->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
+
+	rx_irq = platform_get_irq(pdev, 0);
+	if (rx_irq <= 0) {
+		dev_err(&pdev->dev, "get rx_irq failed (%d)\n", rx_irq);
+		ret = rx_irq;
+		goto put_spi;
+	}
+	snprintf(sspi->rx_irq_name, SYNQUACER_HSSPI_IRQ_NAME_MAX, "%s-rx",
+		 dev_name(&pdev->dev));
+	ret = devm_request_irq(&pdev->dev, rx_irq, sq_spi_rx_handler,
+				0, sspi->rx_irq_name, sspi);
+	if (ret) {
+		dev_err(&pdev->dev, "request rx_irq failed (%d)\n", ret);
+		goto put_spi;
+	}
+
+	tx_irq = platform_get_irq(pdev, 1);
+	if (tx_irq <= 0) {
+		dev_err(&pdev->dev, "get tx_irq failed (%d)\n", tx_irq);
+		ret = tx_irq;
+		goto put_spi;
+	}
+	snprintf(sspi->tx_irq_name, SYNQUACER_HSSPI_IRQ_NAME_MAX, "%s-tx",
+		 dev_name(&pdev->dev));
+	ret = devm_request_irq(&pdev->dev, tx_irq, sq_spi_tx_handler,
+				0, sspi->tx_irq_name, sspi);
+	if (ret) {
+		dev_err(&pdev->dev, "request tx_irq failed (%d)\n", ret);
+		goto put_spi;
+	}
+
+	master->dev.of_node = np;
+	master->dev.fwnode = pdev->dev.fwnode;
+	master->auto_runtime_pm = true;
+	master->bus_num = pdev->id;
+
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
+			    SPI_TX_QUAD | SPI_RX_QUAD;
+	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
+				     SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+
+	master->set_cs = synquacer_spi_set_cs;
+	master->transfer_one = synquacer_spi_transfer_one;
+
+	ret = synquacer_spi_enable(master);
+	if (ret)
+		goto fail_enable;
+
+	pm_runtime_set_active(sspi->dev);
+	pm_runtime_enable(sspi->dev);
+
+	ret = devm_spi_register_master(sspi->dev, master);
+	if (ret)
+		goto disable_pm;
+
+	return 0;
+
+disable_pm:
+	pm_runtime_disable(sspi->dev);
+fail_enable:
+	clk_disable_unprepare(sspi->clk);
+put_spi:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int synquacer_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+
+	pm_runtime_disable(sspi->dev);
+
+	clk_disable_unprepare(sspi->clk);
+
+	return 0;
+}
+
+static int __maybe_unused synquacer_spi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		clk_disable_unprepare(sspi->clk);
+
+	return ret;
+}
+
+static int __maybe_unused synquacer_spi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		/* Ensure reconfigure during next xfer */
+		sspi->speed = 0;
+
+		ret = clk_prepare_enable(sspi->clk);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable clk (%d)\n",
+				ret);
+			return ret;
+		}
+
+		ret = synquacer_spi_enable(master);
+		if (ret) {
+			dev_err(dev, "failed to enable spi (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	ret = spi_master_resume(master);
+	if (ret < 0)
+		clk_disable_unprepare(sspi->clk);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(synquacer_spi_pm_ops, synquacer_spi_suspend,
+			 synquacer_spi_resume);
+
+static const struct of_device_id synquacer_spi_of_match[] = {
+	{.compatible = "socionext,synquacer-spi"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, synquacer_spi_of_match);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id synquacer_hsspi_acpi_ids[] = {
+	{ "SCX0004" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, synquacer_hsspi_acpi_ids);
+#endif
+
+static struct platform_driver synquacer_spi_driver = {
+	.driver = {
+		.name = "synquacer-spi",
+		.pm = &synquacer_spi_pm_ops,
+		.of_match_table = synquacer_spi_of_match,
+		.acpi_match_table = ACPI_PTR(synquacer_hsspi_acpi_ids),
+	},
+	.probe = synquacer_spi_probe,
+	.remove = synquacer_spi_remove,
+};
+module_platform_driver(synquacer_spi_driver);
+
+MODULE_DESCRIPTION("Socionext Synquacer HS-SPI controller driver");
+MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
+MODULE_AUTHOR("Jassi Brar <jaswinder.singh@linaro.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

