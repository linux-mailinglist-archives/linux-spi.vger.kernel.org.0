Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593FF471815
	for <lists+linux-spi@lfdr.de>; Sun, 12 Dec 2021 04:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhLLDry (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 11 Dec 2021 22:47:54 -0500
Received: from marcansoft.com ([212.63.210.85]:38744 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232814AbhLLDrx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 11 Dec 2021 22:47:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 94352419BC;
        Sun, 12 Dec 2021 03:47:46 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Date:   Sun, 12 Dec 2021 12:47:26 +0900
Message-Id: <20211212034726.26306-4-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212034726.26306-1-marcan@marcan.st>
References: <20211212034726.26306-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This SPI controller is present in Apple SoCs such as the M1 (t8103) and
M1 Pro/Max (t600x). It is a relatively straightforward design with two
16-entry FIFOs, arbitrary transfer sizes (up to 2**32 - 1) and fully
configurable word size up to 32 bits. It supports one hardware CS line
which can also be driven via the pinctrl/GPIO driver instead, if
desired. TX and RX can be independently enabled.

There are a surprising number of knobs for tweaking details of the
transfer, most of which we do not use right now. Hardware CS control
is available, but we haven't found a way to make it stay low across
multiple logical transfers, so we just use software CS control for now.

There is also a shared DMA offload coprocessor that can be used to handle
larger transfers without requiring an IRQ every 8-16 words, but that
feature depends on a bunch of scaffolding that isn't ready to be
upstreamed yet, so leave it for later.

The hardware shares some register bit definitions with spi-s3c24xx which
suggests it has a shared legacy with Samsung SoCs, but it is too
different to warrant sharing a driver.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/spi/Kconfig     |   8 +
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-apple.c | 566 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 575 insertions(+)
 create mode 100644 drivers/spi/spi-apple.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b2a8821971e1..d4369c73d4ea 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -79,6 +79,14 @@ config SPI_ALTERA_DFL
 	  Altera SPI master controller.  The SPI master is connected
 	  to a SPI slave to Avalon bridge in a Intel MAX BMC.
 
+config SPI_APPLE
+	tristate "Apple SoC SPI Controller platform driver"
+	depends on ARCH_APPLE || COMPILE_TEST
+	help
+	  This enables support for the SPI controller present on
+	  many Apple SoCs, including the t8103 (M1) and t600x
+	  (M1 Pro/Max).
+
 config SPI_AR934X
 	tristate "Qualcomm Atheros AR934X/QCA95XX SPI controller driver"
 	depends on ATH79 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index dd7393a6046f..35624999d6aa 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
 obj-$(CONFIG_SPI_ALTERA_CORE)		+= spi-altera-core.o
 obj-$(CONFIG_SPI_ALTERA_DFL)		+= spi-altera-dfl.o
+obj-$(CONFIG_SPI_APPLE)			+= spi-apple.o
 obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
diff --git a/drivers/spi/spi-apple.c b/drivers/spi/spi-apple.c
new file mode 100644
index 000000000000..67d93048bb58
--- /dev/null
+++ b/drivers/spi/spi-apple.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple SoC SPI device driver
+ *
+ * Copyright The Asahi Linux Contributors
+ *
+ * Based on spi-sifive.c, Copyright 2018 SiFive, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+
+#define APPLE_SPI_DRIVER_NAME           "apple_spi"
+
+#define APPLE_SPI_CTRL			0x000
+#define APPLE_SPI_CTRL_RUN		BIT(0)
+#define APPLE_SPI_CTRL_TX_RESET		BIT(2)
+#define APPLE_SPI_CTRL_RX_RESET		BIT(3)
+
+#define APPLE_SPI_CFG			0x004
+#define APPLE_SPI_CFG_CPHA		BIT(1)
+#define APPLE_SPI_CFG_CPOL		BIT(2)
+#define APPLE_SPI_CFG_MODE		GENMASK(6, 5)
+#define APPLE_SPI_CFG_MODE_POLLED	0
+#define APPLE_SPI_CFG_MODE_IRQ		1
+#define APPLE_SPI_CFG_MODE_DMA		2
+#define APPLE_SPI_CFG_IE_RXCOMPLETE	BIT(7)
+#define APPLE_SPI_CFG_IE_TXRXTHRESH	BIT(8)
+#define APPLE_SPI_CFG_LSB_FIRST		BIT(13)
+#define APPLE_SPI_CFG_WORD_SIZE		GENMASK(16, 15)
+#define APPLE_SPI_CFG_WORD_SIZE_8B	0
+#define APPLE_SPI_CFG_WORD_SIZE_16B	1
+#define APPLE_SPI_CFG_WORD_SIZE_32B	2
+#define APPLE_SPI_CFG_FIFO_THRESH	GENMASK(18, 17)
+#define APPLE_SPI_CFG_FIFO_THRESH_8B	0
+#define APPLE_SPI_CFG_FIFO_THRESH_4B	1
+#define APPLE_SPI_CFG_FIFO_THRESH_1B	2
+#define APPLE_SPI_CFG_IE_TXCOMPLETE	BIT(21)
+
+#define APPLE_SPI_STATUS		0x008
+#define APPLE_SPI_STATUS_RXCOMPLETE	BIT(0)
+#define APPLE_SPI_STATUS_TXRXTHRESH	BIT(1)
+#define APPLE_SPI_STATUS_TXCOMPLETE	BIT(2)
+
+#define APPLE_SPI_PIN			0x00c
+#define APPLE_SPI_PIN_KEEP_MOSI		BIT(0)
+#define APPLE_SPI_PIN_CS		BIT(1)
+
+#define APPLE_SPI_TXDATA		0x010
+#define APPLE_SPI_RXDATA		0x020
+#define APPLE_SPI_CLKDIV		0x030
+#define APPLE_SPI_CLKDIV_MAX		0x7ff
+#define APPLE_SPI_RXCNT			0x034
+#define APPLE_SPI_WORD_DELAY		0x038
+#define APPLE_SPI_TXCNT			0x04c
+
+#define APPLE_SPI_FIFOSTAT		0x10c
+#define APPLE_SPI_FIFOSTAT_TXFULL	BIT(4)
+#define APPLE_SPI_FIFOSTAT_LEVEL_TX	GENMASK(15, 8)
+#define APPLE_SPI_FIFOSTAT_RXEMPTY	BIT(20)
+#define APPLE_SPI_FIFOSTAT_LEVEL_RX	GENMASK(31, 24)
+
+#define APPLE_SPI_IE_XFER		0x130
+#define APPLE_SPI_IF_XFER		0x134
+#define APPLE_SPI_XFER_RXCOMPLETE	BIT(0)
+#define APPLE_SPI_XFER_TXCOMPLETE	BIT(1)
+
+#define APPLE_SPI_IE_FIFO		0x138
+#define APPLE_SPI_IF_FIFO		0x13c
+#define APPLE_SPI_FIFO_RXTHRESH		BIT(4)
+#define APPLE_SPI_FIFO_TXTHRESH		BIT(5)
+#define APPLE_SPI_FIFO_RXFULL		BIT(8)
+#define APPLE_SPI_FIFO_TXEMPTY		BIT(9)
+#define APPLE_SPI_FIFO_RXUNDERRUN	BIT(16)
+#define APPLE_SPI_FIFO_TXOVERFLOW	BIT(17)
+
+#define APPLE_SPI_SHIFTCFG		0x150
+#define APPLE_SPI_SHIFTCFG_CLK_ENABLE	BIT(0)
+#define APPLE_SPI_SHIFTCFG_CS_ENABLE	BIT(1)
+#define APPLE_SPI_SHIFTCFG_AND_CLK_DATA	BIT(8)
+#define APPLE_SPI_SHIFTCFG_CS_AS_DATA	BIT(9)
+#define APPLE_SPI_SHIFTCFG_TX_ENABLE	BIT(10)
+#define APPLE_SPI_SHIFTCFG_RX_ENABLE	BIT(11)
+#define APPLE_SPI_SHIFTCFG_BITS		GENMASK(21, 16)
+#define APPLE_SPI_SHIFTCFG_OVERRIDE_CS	BIT(24)
+
+#define APPLE_SPI_PINCFG		0x154
+#define APPLE_SPI_PINCFG_KEEP_CLK	BIT(0)
+#define APPLE_SPI_PINCFG_KEEP_CS	BIT(1)
+#define APPLE_SPI_PINCFG_KEEP_MOSI	BIT(2)
+#define APPLE_SPI_PINCFG_CLK_IDLE_VAL	BIT(8)
+#define APPLE_SPI_PINCFG_CS_IDLE_VAL	BIT(9)
+#define APPLE_SPI_PINCFG_MOSI_IDLE_VAL	BIT(10)
+
+#define APPLE_SPI_DELAY_PRE		0x160
+#define APPLE_SPI_DELAY_POST		0x168
+#define APPLE_SPI_DELAY_ENABLE		BIT(0)
+#define APPLE_SPI_DELAY_NO_INTERBYTE	BIT(1)
+#define APPLE_SPI_DELAY_SET_SCK		BIT(4)
+#define APPLE_SPI_DELAY_SET_MOSI	BIT(6)
+#define APPLE_SPI_DELAY_SCK_VAL		BIT(8)
+#define APPLE_SPI_DELAY_MOSI_VAL	BIT(12)
+
+#define APPLE_SPI_FIFO_DEPTH		16
+
+/*
+ * The slowest refclock available is 24MHz, the highest divider is 0x7ff,
+ * the largest word size is 32 bits, the FIFO depth is 16, the maximum
+ * intra-word delay is 0xffff refclocks. So the maximum time a transfer
+ * cycle can take is:
+ *
+ * (0x7ff * 32 + 0xffff) * 16 / 24e6 Hz ~= 87ms
+ *
+ * Double it and round it up to 200ms for good measure.
+ */
+#define APPLE_SPI_TIMEOUT_MS		200
+
+struct apple_spi {
+	void __iomem      *regs;        /* MMIO register address */
+	struct clk        *clk;         /* bus clock */
+	struct completion done;         /* wake-up from interrupt */
+};
+
+static inline void reg_write(struct apple_spi *spi, int offset, u32 value)
+{
+	writel_relaxed(value, spi->regs + offset);
+}
+
+static inline u32 reg_read(struct apple_spi *spi, int offset)
+{
+	return readl_relaxed(spi->regs + offset);
+}
+
+static inline void reg_mask(struct apple_spi *spi, int offset, u32 clear, u32 set)
+{
+	u32 val = reg_read(spi, offset);
+
+	val &= ~clear;
+	val |= set;
+	reg_write(spi, offset, val);
+}
+
+static void apple_spi_init(struct apple_spi *spi)
+{
+	/* Set CS high (inactive) and disable override and auto-CS */
+	reg_write(spi, APPLE_SPI_PIN, APPLE_SPI_PIN_CS);
+	reg_mask(spi, APPLE_SPI_SHIFTCFG, APPLE_SPI_SHIFTCFG_OVERRIDE_CS, 0);
+	reg_mask(spi, APPLE_SPI_PINCFG, APPLE_SPI_PINCFG_CS_IDLE_VAL, APPLE_SPI_PINCFG_KEEP_CS);
+
+	/* Reset FIFOs */
+	reg_write(spi, APPLE_SPI_CTRL, APPLE_SPI_CTRL_RX_RESET | APPLE_SPI_CTRL_TX_RESET);
+
+	/* Configure defaults */
+	reg_write(spi, APPLE_SPI_CFG,
+		  FIELD_PREP(APPLE_SPI_CFG_FIFO_THRESH, APPLE_SPI_CFG_FIFO_THRESH_8B) |
+		  FIELD_PREP(APPLE_SPI_CFG_MODE, APPLE_SPI_CFG_MODE_IRQ) |
+		  FIELD_PREP(APPLE_SPI_CFG_WORD_SIZE, APPLE_SPI_CFG_WORD_SIZE_8B));
+
+	/* Disable IRQs */
+	reg_write(spi, APPLE_SPI_IE_FIFO, 0);
+	reg_write(spi, APPLE_SPI_IE_XFER, 0);
+
+	/* Disable delays */
+	reg_write(spi, APPLE_SPI_DELAY_PRE, 0);
+	reg_write(spi, APPLE_SPI_DELAY_POST, 0);
+}
+
+static int apple_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *msg)
+{
+	struct apple_spi *spi = spi_controller_get_devdata(ctlr);
+	struct spi_device *device = msg->spi;
+
+	u32 cfg = ((device->mode & SPI_CPHA ? APPLE_SPI_CFG_CPHA : 0) |
+		   (device->mode & SPI_CPOL ? APPLE_SPI_CFG_CPOL : 0) |
+		   (device->mode & SPI_LSB_FIRST ? APPLE_SPI_CFG_LSB_FIRST : 0));
+
+	/* Update core config */
+	reg_mask(spi, APPLE_SPI_CFG,
+		 APPLE_SPI_CFG_CPHA | APPLE_SPI_CFG_CPOL | APPLE_SPI_CFG_LSB_FIRST, cfg);
+
+	return 0;
+}
+
+static void apple_spi_set_cs(struct spi_device *device, bool is_high)
+{
+	struct apple_spi *spi = spi_controller_get_devdata(device->controller);
+
+	reg_mask(spi, APPLE_SPI_PIN, APPLE_SPI_PIN_CS, is_high ? APPLE_SPI_PIN_CS : 0);
+}
+
+static bool apple_spi_prep_transfer(struct apple_spi *spi, struct spi_transfer *t)
+{
+	u32 cr;
+
+	/* Calculate and program the clock rate */
+	cr = DIV_ROUND_UP(clk_get_rate(spi->clk), t->speed_hz);
+	reg_write(spi, APPLE_SPI_CLKDIV, min_t(u32, cr, APPLE_SPI_CLKDIV_MAX));
+
+	/* Update bits per word */
+	reg_mask(spi, APPLE_SPI_SHIFTCFG, APPLE_SPI_SHIFTCFG_BITS,
+		 FIELD_PREP(APPLE_SPI_SHIFTCFG_BITS, t->bits_per_word));
+
+	/* We will want to poll if the time we need to wait is
+	 * less than the context switching time.
+	 * Let's call that threshold 5us. The operation will take:
+	 *    bits_per_word * fifo_threshold / hz <= 5 * 10^-6
+	 *    200000 * bits_per_word * fifo_threshold <= hz
+	 */
+	return 200000 * t->bits_per_word * APPLE_SPI_FIFO_DEPTH / 2 <= t->speed_hz;
+}
+
+static irqreturn_t apple_spi_irq(int irq, void *dev_id)
+{
+	struct apple_spi *spi = dev_id;
+	u32 fifo = reg_read(spi, APPLE_SPI_IF_FIFO) & reg_read(spi, APPLE_SPI_IE_FIFO);
+	u32 xfer = reg_read(spi, APPLE_SPI_IF_XFER) & reg_read(spi, APPLE_SPI_IE_XFER);
+
+	if (fifo || xfer) {
+		/* Disable interrupts until next transfer */
+		reg_write(spi, APPLE_SPI_IE_XFER, 0);
+		reg_write(spi, APPLE_SPI_IE_FIFO, 0);
+		complete(&spi->done);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int apple_spi_wait(struct apple_spi *spi, u32 fifo_bit, u32 xfer_bit, int poll)
+{
+	int ret = 0;
+
+	if (poll) {
+		u32 fifo, xfer;
+		unsigned long timeout = jiffies + APPLE_SPI_TIMEOUT_MS * HZ / 1000;
+
+		do {
+			fifo = reg_read(spi, APPLE_SPI_IF_FIFO);
+			xfer = reg_read(spi, APPLE_SPI_IF_XFER);
+			if (time_after(jiffies, timeout)) {
+				ret = -ETIMEDOUT;
+				break;
+			}
+		} while (!((fifo & fifo_bit) || (xfer & xfer_bit)));
+	} else {
+		reinit_completion(&spi->done);
+		reg_write(spi, APPLE_SPI_IE_XFER, xfer_bit);
+		reg_write(spi, APPLE_SPI_IE_FIFO, fifo_bit);
+
+		if (!wait_for_completion_timeout(&spi->done,
+						 msecs_to_jiffies(APPLE_SPI_TIMEOUT_MS)))
+			ret = -ETIMEDOUT;
+
+		reg_write(spi, APPLE_SPI_IE_XFER, 0);
+		reg_write(spi, APPLE_SPI_IE_FIFO, 0);
+	}
+
+	return ret;
+}
+
+static void apple_spi_tx(struct apple_spi *spi, const void **tx_ptr, u32 *left,
+			 unsigned int bytes_per_word)
+{
+	u32 inuse, words, wrote;
+
+	if (!*tx_ptr)
+		return;
+
+	inuse = FIELD_GET(APPLE_SPI_FIFOSTAT_LEVEL_TX, reg_read(spi, APPLE_SPI_FIFOSTAT));
+	words = wrote = min_t(u32, *left, APPLE_SPI_FIFO_DEPTH - inuse);
+
+	if (!words)
+		return;
+
+	*left -= words;
+
+	switch (bytes_per_word) {
+	case 1: {
+		const u8 *p = *tx_ptr;
+
+		while (words--)
+			reg_write(spi, APPLE_SPI_TXDATA, *p++);
+		break;
+	}
+	case 2: {
+		const u16 *p = *tx_ptr;
+
+		while (words--)
+			reg_write(spi, APPLE_SPI_TXDATA, *p++);
+		break;
+	}
+	case 4: {
+		const u32 *p = *tx_ptr;
+
+		while (words--)
+			reg_write(spi, APPLE_SPI_TXDATA, *p++);
+		break;
+	}
+	default:
+		WARN_ON(1);
+	}
+
+	*tx_ptr = ((u8 *)*tx_ptr) + bytes_per_word * wrote;
+}
+
+static void apple_spi_rx(struct apple_spi *spi, void **rx_ptr, u32 *left,
+			 unsigned int bytes_per_word)
+{
+	u32 words, read;
+
+	if (!*rx_ptr)
+		return;
+
+	words = read = FIELD_GET(APPLE_SPI_FIFOSTAT_LEVEL_RX, reg_read(spi, APPLE_SPI_FIFOSTAT));
+	WARN_ON(words > *left);
+
+	if (!words)
+		return;
+
+	*left -= min_t(u32, *left, words);
+
+	switch (bytes_per_word) {
+	case 1: {
+		u8 *p = *rx_ptr;
+
+		while (words--)
+			*p++ = reg_read(spi, APPLE_SPI_RXDATA);
+		break;
+	}
+	case 2: {
+		u16 *p = *rx_ptr;
+
+		while (words--)
+			*p++ = reg_read(spi, APPLE_SPI_RXDATA);
+		break;
+	}
+	case 4: {
+		u32 *p = *rx_ptr;
+
+		while (words--)
+			*p++ = reg_read(spi, APPLE_SPI_RXDATA);
+		break;
+	}
+	default:
+		WARN_ON(1);
+	}
+
+	*rx_ptr = ((u8 *)*rx_ptr) + bytes_per_word * read;
+}
+
+static int apple_spi_transfer_one(struct spi_controller *ctlr, struct spi_device *device,
+				  struct spi_transfer *t)
+{
+	struct apple_spi *spi = spi_controller_get_devdata(ctlr);
+	bool poll = apple_spi_prep_transfer(spi, t);
+	const void *tx_ptr = t->tx_buf;
+	void *rx_ptr = t->rx_buf;
+	unsigned int bytes_per_word = t->bits_per_word > 16 ? 4 : t->bits_per_word > 8 ? 2 : 1;
+	u32 words = t->len / bytes_per_word;
+	u32 remaining_tx = tx_ptr ? words : 0;
+	u32 remaining_rx = rx_ptr ? words : 0;
+	u32 xfer_flags = 0;
+	u32 fifo_flags;
+	int retries = 100;
+	int ret = 0;
+
+	/* Reset FIFOs */
+	reg_write(spi, APPLE_SPI_CTRL, APPLE_SPI_CTRL_RX_RESET | APPLE_SPI_CTRL_TX_RESET);
+
+	/* Clear IRQ flags */
+	reg_write(spi, APPLE_SPI_IF_XFER, ~0);
+	reg_write(spi, APPLE_SPI_IF_FIFO, ~0);
+
+	/* Determine transfer completion flags we wait for */
+	if (tx_ptr)
+		xfer_flags |= APPLE_SPI_XFER_TXCOMPLETE;
+	if (rx_ptr)
+		xfer_flags |= APPLE_SPI_XFER_RXCOMPLETE;
+
+	/* Set transfer length */
+	reg_write(spi, APPLE_SPI_TXCNT, remaining_tx);
+	reg_write(spi, APPLE_SPI_RXCNT, remaining_rx);
+
+	/* Prime transmit FIFO */
+	apple_spi_tx(spi, &tx_ptr, &remaining_tx, bytes_per_word);
+
+	/* Start transfer */
+	reg_write(spi, APPLE_SPI_CTRL, APPLE_SPI_CTRL_RUN);
+
+	/* TX again since a few words get popped off immediately */
+	apple_spi_tx(spi, &tx_ptr, &remaining_tx, bytes_per_word);
+
+	while (xfer_flags) {
+		u32 fifo_flags = 0;
+
+		if (remaining_tx)
+			fifo_flags |= APPLE_SPI_FIFO_TXTHRESH;
+		if (remaining_rx)
+			fifo_flags |= APPLE_SPI_FIFO_RXTHRESH;
+
+		/* Wait for anything to happen */
+		ret = apple_spi_wait(spi, fifo_flags, xfer_flags, poll);
+		if (ret) {
+			dev_err(&ctlr->dev, "transfer timed out (remaining %d tx, %d rx)\n",
+				remaining_tx, remaining_rx);
+			goto err;
+		}
+
+		/* Stop waiting on transfer halves once they complete */
+		xfer_flags &= ~reg_read(spi, APPLE_SPI_IF_XFER);
+
+		/* Transmit and receive everything we can */
+		apple_spi_tx(spi, &tx_ptr, &remaining_tx, bytes_per_word);
+		apple_spi_rx(spi, &rx_ptr, &remaining_rx, bytes_per_word);
+	}
+
+	/*
+	 * Sometimes the transfer completes before the last word is in the RX FIFO.
+	 * Normally one retry is all it takes to get the last word out.
+	 */
+	while (remaining_rx && retries--)
+		apple_spi_rx(spi, &rx_ptr, &remaining_rx, bytes_per_word);
+
+	if (remaining_tx)
+		dev_err(&ctlr->dev, "transfer completed with %d words left to transmit\n",
+			remaining_tx);
+	if (remaining_rx)
+		dev_err(&ctlr->dev, "transfer completed with %d words left to receive\n",
+			remaining_rx);
+
+err:
+	fifo_flags = reg_read(spi, APPLE_SPI_IF_FIFO);
+	WARN_ON(fifo_flags & APPLE_SPI_FIFO_TXOVERFLOW);
+	WARN_ON(fifo_flags & APPLE_SPI_FIFO_RXUNDERRUN);
+
+	/* Stop transfer */
+	reg_write(spi, APPLE_SPI_CTRL, 0);
+
+	return ret;
+}
+
+static int apple_spi_probe(struct platform_device *pdev)
+{
+	struct apple_spi *spi;
+	int ret, irq;
+	struct spi_controller *ctlr;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(struct apple_spi));
+	if (!ctlr) {
+		dev_err(&pdev->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+
+	spi = spi_controller_get_devdata(ctlr);
+	init_completion(&spi->done);
+	platform_set_drvdata(pdev, ctlr);
+
+	spi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(spi->regs)) {
+		ret = PTR_ERR(spi->regs);
+		goto put_ctlr;
+	}
+
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(spi->clk)) {
+		dev_err(&pdev->dev, "Unable to find bus clock\n");
+		ret = PTR_ERR(spi->clk);
+		goto put_ctlr;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto put_ctlr;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, apple_spi_irq, 0,
+			       dev_name(&pdev->dev), spi);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
+		goto put_ctlr;
+	}
+
+	ret = clk_prepare_enable(spi->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable bus clock\n");
+		goto put_ctlr;
+	}
+
+	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->bus_num = pdev->id;
+	ctlr->num_chipselect = 1;
+	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
+	ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
+	ctlr->flags = 0;
+	ctlr->prepare_message = apple_spi_prepare_message;
+	ctlr->set_cs = apple_spi_set_cs;
+	ctlr->transfer_one = apple_spi_transfer_one;
+	ctlr->auto_runtime_pm = true;
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	pdev->dev.dma_mask = NULL;
+
+	apple_spi_init(spi);
+
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "spi_register_ctlr failed\n");
+		goto disable_pm;
+	}
+
+	return 0;
+
+disable_pm:
+	pm_runtime_disable(&pdev->dev);
+	clk_disable_unprepare(spi->clk);
+put_ctlr:
+	spi_controller_put(ctlr);
+
+	return ret;
+}
+
+static int apple_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct apple_spi *spi = spi_controller_get_devdata(ctlr);
+
+	pm_runtime_disable(&pdev->dev);
+
+	/* Disable all the interrupts just in case */
+	reg_write(spi, APPLE_SPI_IE_FIFO, 0);
+	reg_write(spi, APPLE_SPI_IE_XFER, 0);
+
+	clk_disable_unprepare(spi->clk);
+
+	return 0;
+}
+
+static const struct of_device_id apple_spi_of_match[] = {
+	{ .compatible = "apple,spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, apple_spi_of_match);
+
+static struct platform_driver apple_spi_driver = {
+	.probe = apple_spi_probe,
+	.remove = apple_spi_remove,
+	.driver = {
+		.name = APPLE_SPI_DRIVER_NAME,
+		.of_match_table = apple_spi_of_match,
+	},
+};
+module_platform_driver(apple_spi_driver);
+
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_DESCRIPTION("Apple SoC SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.33.0

