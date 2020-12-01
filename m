Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84532CAE28
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 22:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbgLAVNf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 16:13:35 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14570 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbgLAVNd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 16:13:33 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6b1d40000>; Tue, 01 Dec 2020 13:12:52 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 21:12:52 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Dec 2020 21:12:51 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 3/7] spi: qspi-tegra: Add support for Tegra210 QSPI controller
Date:   Tue, 1 Dec 2020 13:12:44 -0800
Message-ID: <1606857168-5839-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606857172; bh=NpH7ZPCmwpZc01FFpOPrDgxCXflgplHupYk9KXlTzeo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=P/m5r8nkOmkYp9ft/basnBfVNkXTpk0tNPw4+h45mxJsWHaEzO09YmgPvFiBq70OQ
         rkoljgaB2axcp+j50PrSXrlgOr77UZAbR2jClpjFKfgBhTQ34ZBrEpmXGRsmhlBFAl
         yTlPydjnptbovHSubBxMYsW7NkIzIx7ap4I+gDQBo7BR28AMQ/02rKlDqMGoFSSdJh
         i9UxOlzUnEVb6J8AR7p+ao/RarLtraHi4UqvTBU7rJWgnMwshrb91bVQXwVgmU99Yv
         32vO6zdBTcYwZ4qCZnGMaSkcWUCgTADFMSRazAz27eG6fL3PU9N6YQXB8yEpWRYzge
         jdTvzsVCRgNtA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tegra SoC has a Quad SPI controller starting from Tegra210.

This patch adds support for Tegra210 QSPI controller.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/Kconfig      |    9 +
 drivers/spi/Makefile     |    1 +
 drivers/spi/qspi-tegra.c | 1418 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1428 insertions(+)
 create mode 100644 drivers/spi/qspi-tegra.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3fd16b7..1a021e8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -844,6 +844,15 @@ config SPI_MXS
 	help
 	  SPI driver for Freescale MXS devices.
 
+config QSPI_TEGRA
+	tristate "Nvidia Tegra QSPI Controller"
+	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
+	depends on RESET_CONTROLLER
+	help
+	  QSPI driver for Nvidia Tegra QSPI Controller interface. This
+	  controller is different from the spi controller and is available
+	  on Tegra SoCs starting from Tegra210.
+
 config SPI_TEGRA114
 	tristate "NVIDIA Tegra114 SPI Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6fea582..eb56f89 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_SPI_ST_SSC4)		+= spi-st-ssc4.o
 obj-$(CONFIG_SPI_SUN4I)			+= spi-sun4i.o
 obj-$(CONFIG_SPI_SUN6I)			+= spi-sun6i.o
 obj-$(CONFIG_SPI_SYNQUACER)		+= spi-synquacer.o
+obj-$(CONFIG_QSPI_TEGRA)		+= qspi-tegra.o
 obj-$(CONFIG_SPI_TEGRA114)		+= spi-tegra114.o
 obj-$(CONFIG_SPI_TEGRA20_SFLASH)	+= spi-tegra20-sflash.o
 obj-$(CONFIG_SPI_TEGRA20_SLINK)		+= spi-tegra20-slink.o
diff --git a/drivers/spi/qspi-tegra.c b/drivers/spi/qspi-tegra.c
new file mode 100644
index 0000000..67a8b44
--- /dev/null
+++ b/drivers/spi/qspi-tegra.c
@@ -0,0 +1,1418 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+
+#define QSPI_COMMAND1				0x000
+#define QSPI_BIT_LENGTH(x)			(((x) & 0x1f) << 0)
+#define QSPI_PACKED				BIT(5)
+#define QSPI_INTERFACE_WIDTH_MASK		(0x03 << 7)
+#define QSPI_INTERFACE_WIDTH(x)			(((x) & 0x03) << 7)
+#define QSPI_INTERFACE_WIDTH_SINGLE		QSPI_INTERFACE_WIDTH(0)
+#define QSPI_INTERFACE_WIDTH_DUAL		QSPI_INTERFACE_WIDTH(1)
+#define QSPI_INTERFACE_WIDTH_QUAD		QSPI_INTERFACE_WIDTH(2)
+#define QSPI_SDR_DDR_SEL			BIT(9)
+#define QSPI_TX_EN				BIT(11)
+#define QSPI_RX_EN				BIT(12)
+#define QSPI_CS_SW_VAL				BIT(20)
+#define QSPI_CS_SW_HW				BIT(21)
+#define QSPI_CONTROL_MODE_0			(0 << 28)
+#define QSPI_CONTROL_MODE_3			(3 << 28)
+#define QSPI_CONTROL_MODE_MASK			(3 << 28)
+#define QSPI_M_S				BIT(30)
+#define QSPI_PIO				BIT(31)
+
+#define QSPI_COMMAND2				0x004
+#define QSPI_TX_TAP_DELAY(x)			(((x) & 0x3f) << 10)
+#define QSPI_RX_TAP_DELAY(x)			(((x) & 0xff) << 0)
+
+#define QSPI_CS_TIMING1				0x008
+#define QSPI_SETUP_HOLD(setup, hold)		(((setup) << 4) | (hold))
+
+#define QSPI_CS_TIMING2				0x00c
+#define CYCLES_BETWEEN_PACKETS_0(x)		(((x) & 0x1f) << 0)
+#define CS_ACTIVE_BETWEEN_PACKETS_0		BIT(5)
+
+#define QSPI_TRANS_STATUS			0x010
+#define QSPI_BLK_CNT(val)			(((val) >> 0) & 0xffff)
+#define QSPI_RDY				BIT(30)
+
+#define QSPI_FIFO_STATUS			0x014
+#define QSPI_RX_FIFO_EMPTY			BIT(0)
+#define QSPI_RX_FIFO_FULL			BIT(1)
+#define QSPI_TX_FIFO_EMPTY			BIT(2)
+#define QSPI_TX_FIFO_FULL			BIT(3)
+#define QSPI_RX_FIFO_UNF			BIT(4)
+#define QSPI_RX_FIFO_OVF			BIT(5)
+#define QSPI_TX_FIFO_UNF			BIT(6)
+#define QSPI_TX_FIFO_OVF			BIT(7)
+#define QSPI_ERR				BIT(8)
+#define QSPI_TX_FIFO_FLUSH			BIT(14)
+#define QSPI_RX_FIFO_FLUSH			BIT(15)
+#define QSPI_TX_FIFO_EMPTY_COUNT(val)		(((val) >> 16) & 0x7f)
+#define QSPI_RX_FIFO_FULL_COUNT(val)		(((val) >> 23) & 0x7f)
+
+#define QSPI_FIFO_ERROR				(QSPI_RX_FIFO_UNF | \
+						 QSPI_RX_FIFO_OVF | \
+						 QSPI_TX_FIFO_UNF | \
+						 QSPI_TX_FIFO_OVF)
+#define QSPI_FIFO_EMPTY				(QSPI_RX_FIFO_EMPTY | \
+						 QSPI_TX_FIFO_EMPTY)
+
+#define QSPI_TX_DATA				0x018
+#define QSPI_RX_DATA				0x01c
+
+#define QSPI_DMA_CTL				0x020
+#define QSPI_TX_TRIG(n)				(((n) & 0x3) << 15)
+#define QSPI_TX_TRIG_1				QSPI_TX_TRIG(0)
+#define QSPI_TX_TRIG_4				QSPI_TX_TRIG(1)
+#define QSPI_TX_TRIG_8				QSPI_TX_TRIG(2)
+#define QSPI_TX_TRIG_16				QSPI_TX_TRIG(3)
+
+#define QSPI_RX_TRIG(n)				(((n) & 0x3) << 19)
+#define QSPI_RX_TRIG_1				QSPI_RX_TRIG(0)
+#define QSPI_RX_TRIG_4				QSPI_RX_TRIG(1)
+#define QSPI_RX_TRIG_8				QSPI_RX_TRIG(2)
+#define QSPI_RX_TRIG_16				QSPI_RX_TRIG(3)
+
+#define QSPI_DMA_EN				BIT(31)
+
+#define QSPI_DMA_BLK				0x024
+#define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
+
+#define QSPI_TX_FIFO				0x108
+#define QSPI_RX_FIFO				0x188
+
+#define QSPI_FIFO_DEPTH				64
+
+#define QSPI_INTR_MASK				0x18c
+#define QSPI_INTR_RX_FIFO_UNF_MASK		BIT(25)
+#define QSPI_INTR_RX_FIFO_OVF_MASK		BIT(26)
+#define QSPI_INTR_TX_FIFO_UNF_MASK		BIT(27)
+#define QSPI_INTR_TX_FIFO_OVF_MASK		BIT(28)
+#define QSPI_INTR_RDY_MASK			BIT(29)
+#define QSPI_INTR_RX_TX_FIFO_ERR		(QSPI_INTR_RX_FIFO_UNF_MASK | \
+						 QSPI_INTR_RX_FIFO_OVF_MASK | \
+						 QSPI_INTR_TX_FIFO_UNF_MASK | \
+						 QSPI_INTR_TX_FIFO_OVF_MASK)
+
+#define QSPI_MISC_REG                           0x194
+#define QSPI_NUM_DUMMY_CYCLE(x)			(((x) & 0xff) << 0)
+
+#define DATA_DIR_TX				BIT(0)
+#define DATA_DIR_RX				BIT(1)
+
+#define QSPI_DMA_TIMEOUT			(msecs_to_jiffies(1000))
+#define DEFAULT_QSPI_DMA_BUF_LEN		(64 * 1024)
+#define QSPI_MAX_SPEED				102000000
+
+enum transfer_phase {
+	CMD_BYTE_XFER = 0,
+	ADDR_BYTES_XFER,
+	DUMMY_BYTES_XFER,
+	DATA_BYTES_XFER,
+	MAX_XFERS,
+};
+
+struct tegra_qspi_client_data {
+	int tx_clk_tap_delay;
+	int rx_clk_tap_delay;
+};
+
+struct tegra_qspi_data {
+	struct device				*dev;
+	struct spi_master			*master;
+	/* Lock to protect data accessed by irq */
+	spinlock_t				lock;
+
+	struct clk				*clk;
+	struct reset_control			*rst;
+	void __iomem				*base;
+	phys_addr_t				phys;
+	unsigned int				irq;
+
+	u32					cur_speed;
+	unsigned int				cur_pos;
+	unsigned int				words_per_32bit;
+	unsigned int				bytes_per_word;
+	unsigned int				curr_dma_words;
+	unsigned int				cur_direction;
+
+	unsigned int				cur_rx_pos;
+	unsigned int				cur_tx_pos;
+
+	unsigned int				dma_buf_size;
+	unsigned int				max_buf_size;
+	bool					is_curr_dma_xfer;
+
+	struct completion			rx_dma_complete;
+	struct completion			tx_dma_complete;
+
+	u32					tx_status;
+	u32					rx_status;
+	u32					status_reg;
+	bool					is_packed;
+	bool					use_dma;
+
+	u32					command1_reg;
+	u32					dma_control_reg;
+	u32					def_command1_reg;
+	u32					def_command2_reg;
+	u32					spi_cs_timing1;
+	u32					spi_cs_timing2;
+	u8					dummy_cycles;
+
+	struct completion			xfer_completion;
+	struct spi_transfer			*curr_xfer;
+
+	struct dma_chan				*rx_dma_chan;
+	u32					*rx_dma_buf;
+	dma_addr_t				rx_dma_phys;
+	struct dma_async_tx_descriptor		*rx_dma_desc;
+
+	struct dma_chan				*tx_dma_chan;
+	u32					*tx_dma_buf;
+	dma_addr_t				tx_dma_phys;
+	struct dma_async_tx_descriptor		*tx_dma_desc;
+};
+
+static int tegra_qspi_runtime_suspend(struct device *dev);
+static int tegra_qspi_runtime_resume(struct device *dev);
+
+static inline u32 tegra_qspi_readl(struct tegra_qspi_data *tqspi,
+				   unsigned long reg)
+{
+	return readl(tqspi->base + reg);
+}
+
+static inline void tegra_qspi_writel(struct tegra_qspi_data *tqspi,
+				     u32 val, unsigned long reg)
+{
+	writel(val, tqspi->base + reg);
+
+	/* Read back register to make sure that register writes completed */
+	if (reg != QSPI_TX_FIFO)
+		readl(tqspi->base + QSPI_COMMAND1);
+}
+
+static void tegra_qspi_mask_clear_irq(struct tegra_qspi_data *tqspi)
+{
+	u32 val;
+
+	/* Write 1 to clear status register */
+	val = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	tegra_qspi_writel(tqspi, val, QSPI_TRANS_STATUS);
+
+	val = tegra_qspi_readl(tqspi, QSPI_INTR_MASK);
+	if (!(val & QSPI_INTR_RDY_MASK)) {
+		val |= (QSPI_INTR_RDY_MASK | QSPI_INTR_RX_TX_FIFO_ERR);
+		tegra_qspi_writel(tqspi, val, QSPI_INTR_MASK);
+	}
+
+	/* Clear fifo status error if any */
+	val = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	if (val & QSPI_ERR)
+		tegra_qspi_writel(tqspi, QSPI_ERR | QSPI_FIFO_ERROR,
+				  QSPI_FIFO_STATUS);
+}
+
+static unsigned int
+tegra_qspi_calculate_curr_xfer_param(struct tegra_qspi_data *tqspi,
+				     struct spi_transfer *t)
+{
+	unsigned int remain_len = t->len - tqspi->cur_pos;
+	unsigned int max_word;
+	unsigned int bits_per_word = t->bits_per_word;
+	unsigned int max_len;
+	unsigned int total_fifo_words;
+
+	tqspi->bytes_per_word = DIV_ROUND_UP(bits_per_word, 8);
+
+	if ((bits_per_word == 8 || bits_per_word == 16 ||
+	     bits_per_word == 32) && t->len > 3) {
+		tqspi->is_packed = true;
+		tqspi->words_per_32bit = 32 / bits_per_word;
+	} else {
+		tqspi->is_packed = false;
+		tqspi->words_per_32bit = 1;
+	}
+
+	if (tqspi->is_packed) {
+		max_len = min(remain_len, tqspi->max_buf_size);
+		tqspi->curr_dma_words = max_len / tqspi->bytes_per_word;
+		total_fifo_words = (max_len + 3) / 4;
+	} else {
+		max_word = (remain_len - 1) / tqspi->bytes_per_word + 1;
+		max_word = min(max_word, tqspi->max_buf_size / 4);
+		tqspi->curr_dma_words = max_word;
+		total_fifo_words = max_word;
+	}
+
+	return total_fifo_words;
+}
+
+static unsigned int
+tegra_qspi_fill_tx_fifo_from_client_txbuf(struct tegra_qspi_data *tqspi,
+					  struct spi_transfer *t)
+{
+	unsigned int len;
+	unsigned int tx_empty_count;
+	u32 fifo_status, x;
+	unsigned int max_n_32bit;
+	unsigned int i, count;
+	unsigned int written_words;
+	unsigned int fifo_words_left;
+	u8 *tx_buf = (u8 *)t->tx_buf + tqspi->cur_tx_pos;
+
+	fifo_status = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	tx_empty_count = QSPI_TX_FIFO_EMPTY_COUNT(fifo_status);
+
+	if (tqspi->is_packed) {
+		fifo_words_left = tx_empty_count * tqspi->words_per_32bit;
+		written_words = min(fifo_words_left, tqspi->curr_dma_words);
+		len = written_words * tqspi->bytes_per_word;
+		max_n_32bit = DIV_ROUND_UP(len, 4);
+		for (count = 0; count < max_n_32bit; count++) {
+			x = 0;
+
+			for (i = 0; (i < 4) && len; i++, len--)
+				x |= (u32)(*tx_buf++) << (i * 8);
+			tegra_qspi_writel(tqspi, x, QSPI_TX_FIFO);
+		}
+
+		tqspi->cur_tx_pos += written_words * tqspi->bytes_per_word;
+	} else {
+		unsigned int write_bytes;
+		u8 bytes_per_word = tqspi->bytes_per_word;
+
+		max_n_32bit = min(tqspi->curr_dma_words, tx_empty_count);
+		written_words = max_n_32bit;
+		len = written_words * tqspi->bytes_per_word;
+		if (len > t->len - tqspi->cur_pos)
+			len = t->len - tqspi->cur_pos;
+		write_bytes = len;
+		for (count = 0; count < max_n_32bit; count++) {
+			x = 0;
+
+			for (i = 0; len && (i < bytes_per_word); i++, len--)
+				x |= (u32)(*tx_buf++) << (i * 8);
+			tegra_qspi_writel(tqspi, x, QSPI_TX_FIFO);
+		}
+
+		tqspi->cur_tx_pos += write_bytes;
+	}
+
+	return written_words;
+}
+
+static unsigned int
+tegra_qspi_read_rx_fifo_to_client_rxbuf(struct tegra_qspi_data *tqspi,
+					struct spi_transfer *t)
+{
+	unsigned int rx_full_count;
+	u32 fifo_status, x;
+	unsigned int i, count;
+	unsigned int read_words = 0;
+	unsigned int len;
+	u8 *rx_buf = (u8 *)t->rx_buf + tqspi->cur_rx_pos;
+
+	fifo_status = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	rx_full_count = QSPI_RX_FIFO_FULL_COUNT(fifo_status);
+	if (tqspi->is_packed) {
+		len = tqspi->curr_dma_words * tqspi->bytes_per_word;
+		for (count = 0; count < rx_full_count; count++) {
+			x = tegra_qspi_readl(tqspi, QSPI_RX_FIFO);
+
+			for (i = 0; len && (i < 4); i++, len--)
+				*rx_buf++ = (x >> i * 8) & 0xff;
+		}
+
+		read_words += tqspi->curr_dma_words;
+		tqspi->cur_rx_pos += tqspi->curr_dma_words *
+				     tqspi->bytes_per_word;
+	} else {
+		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
+		u8 bytes_per_word = tqspi->bytes_per_word;
+		unsigned int read_bytes;
+
+		len = rx_full_count * bytes_per_word;
+		if (len > t->len - tqspi->cur_pos)
+			len = t->len - tqspi->cur_pos;
+		read_bytes = len;
+		for (count = 0; count < rx_full_count; count++) {
+			x = tegra_qspi_readl(tqspi, QSPI_RX_FIFO) & rx_mask;
+
+			for (i = 0; len && (i < bytes_per_word); i++, len--)
+				*rx_buf++ = (x >> (i * 8)) & 0xff;
+		}
+
+		read_words += rx_full_count;
+		tqspi->cur_rx_pos += read_bytes;
+	}
+
+	return read_words;
+}
+
+static void
+tegra_qspi_copy_client_txbuf_to_qspi_txbuf(struct tegra_qspi_data *tqspi,
+					   struct spi_transfer *t)
+{
+	/* Make the dma buffer to read by cpu */
+	dma_sync_single_for_cpu(tqspi->dev, tqspi->tx_dma_phys,
+				tqspi->dma_buf_size, DMA_TO_DEVICE);
+
+	if (tqspi->is_packed) {
+		unsigned int len = tqspi->curr_dma_words *
+				   tqspi->bytes_per_word;
+
+		memcpy(tqspi->tx_dma_buf, t->tx_buf + tqspi->cur_pos, len);
+		tqspi->cur_tx_pos += tqspi->curr_dma_words *
+				     tqspi->bytes_per_word;
+	} else {
+		u8 *tx_buf = (u8 *)t->tx_buf + tqspi->cur_tx_pos;
+		unsigned int i;
+		unsigned int count;
+		unsigned int consume;
+		unsigned int write_bytes;
+
+		consume = tqspi->curr_dma_words * tqspi->bytes_per_word;
+		if (consume > t->len - tqspi->cur_pos)
+			consume = t->len - tqspi->cur_pos;
+		write_bytes = consume;
+		for (count = 0; count < tqspi->curr_dma_words; count++) {
+			u32 x = 0;
+
+			for (i = 0; consume && (i < tqspi->bytes_per_word);
+							i++, consume--)
+				x |= (u32)(*tx_buf++) << (i * 8);
+			tqspi->tx_dma_buf[count] = x;
+		}
+
+		tqspi->cur_tx_pos += write_bytes;
+	}
+
+	/* Make the dma buffer to read by dma */
+	dma_sync_single_for_device(tqspi->dev, tqspi->tx_dma_phys,
+				   tqspi->dma_buf_size, DMA_TO_DEVICE);
+}
+
+static void
+tegra_qspi_copy_qspi_rxbuf_to_client_rxbuf(struct tegra_qspi_data *tqspi,
+					   struct spi_transfer *t)
+{
+	/* Make the dma buffer to read by cpu */
+	dma_sync_single_for_cpu(tqspi->dev, tqspi->rx_dma_phys,
+				tqspi->dma_buf_size, DMA_FROM_DEVICE);
+
+	if (tqspi->is_packed) {
+		unsigned int len = tqspi->curr_dma_words *
+				   tqspi->bytes_per_word;
+
+		memcpy(t->rx_buf + tqspi->cur_rx_pos, tqspi->rx_dma_buf, len);
+		tqspi->cur_rx_pos += tqspi->curr_dma_words *
+				     tqspi->bytes_per_word;
+	} else {
+		unsigned char *rx_buf = t->rx_buf + tqspi->cur_rx_pos;
+		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
+		unsigned int i;
+		unsigned int count;
+		unsigned int consume;
+		unsigned int read_bytes;
+
+		consume = tqspi->curr_dma_words * tqspi->bytes_per_word;
+		if (consume > t->len - tqspi->cur_pos)
+			consume = t->len - tqspi->cur_pos;
+		read_bytes = consume;
+		for (count = 0; count < tqspi->curr_dma_words; count++) {
+			u32 x = tqspi->rx_dma_buf[count] & rx_mask;
+
+			for (i = 0; consume && (i < tqspi->bytes_per_word);
+							i++, consume--)
+				*rx_buf++ = (x >> (i * 8)) & 0xFF;
+		}
+
+		tqspi->cur_rx_pos += read_bytes;
+	}
+
+	/* Make the dma buffer to read by dma */
+	dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
+				   tqspi->dma_buf_size, DMA_FROM_DEVICE);
+}
+
+static void tegra_qspi_dma_complete(void *args)
+{
+	struct completion *dma_complete = args;
+
+	complete(dma_complete);
+}
+
+static int tegra_qspi_start_tx_dma(struct tegra_qspi_data *tqspi, int len)
+{
+	reinit_completion(&tqspi->tx_dma_complete);
+	tqspi->tx_dma_desc = dmaengine_prep_slave_single(tqspi->tx_dma_chan,
+				tqspi->tx_dma_phys, len, DMA_MEM_TO_DEV,
+				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
+	if (!tqspi->tx_dma_desc) {
+		dev_err(tqspi->dev, "Not able to get desc for Tx\n");
+		return -EIO;
+	}
+
+	tqspi->tx_dma_desc->callback = tegra_qspi_dma_complete;
+	tqspi->tx_dma_desc->callback_param = &tqspi->tx_dma_complete;
+
+	dmaengine_submit(tqspi->tx_dma_desc);
+	dma_async_issue_pending(tqspi->tx_dma_chan);
+	return 0;
+}
+
+static int tegra_qspi_start_rx_dma(struct tegra_qspi_data *tqspi, int len)
+{
+	reinit_completion(&tqspi->rx_dma_complete);
+	tqspi->rx_dma_desc = dmaengine_prep_slave_single(tqspi->rx_dma_chan,
+				tqspi->rx_dma_phys, len, DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT |  DMA_CTRL_ACK);
+	if (!tqspi->rx_dma_desc) {
+		dev_err(tqspi->dev, "Not able to get desc for Rx\n");
+		return -EIO;
+	}
+
+	tqspi->rx_dma_desc->callback = tegra_qspi_dma_complete;
+	tqspi->rx_dma_desc->callback_param = &tqspi->rx_dma_complete;
+
+	dmaengine_submit(tqspi->rx_dma_desc);
+	dma_async_issue_pending(tqspi->rx_dma_chan);
+	return 0;
+}
+
+static int tegra_qspi_flush_fifos(struct tegra_qspi_data *tqspi)
+{
+	unsigned long timeout = jiffies + HZ;
+	u32 status;
+
+	status = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	if ((status & QSPI_FIFO_EMPTY) == QSPI_FIFO_EMPTY)
+		return 0;
+
+	status |= QSPI_RX_FIFO_FLUSH | QSPI_TX_FIFO_FLUSH;
+	tegra_qspi_writel(tqspi, status, QSPI_FIFO_STATUS);
+	while ((status & QSPI_FIFO_EMPTY) != QSPI_FIFO_EMPTY) {
+		status = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+		if (time_after(jiffies, timeout)) {
+			dev_err(tqspi->dev,
+				"timeout waiting for fifo flush\n");
+			return -EIO;
+		}
+
+		udelay(1);
+	}
+
+	return 0;
+}
+
+static void tegra_qspi_unmask_irq(struct tegra_qspi_data *tqspi)
+{
+	u32 intr_mask;
+
+	intr_mask = tegra_qspi_readl(tqspi, QSPI_INTR_MASK);
+	intr_mask &= ~(QSPI_INTR_RDY_MASK | QSPI_INTR_RX_TX_FIFO_ERR);
+	tegra_qspi_writel(tqspi, intr_mask, QSPI_INTR_MASK);
+}
+
+static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi_data *tqspi,
+					       struct spi_transfer *t)
+{
+	u32 val;
+	unsigned int len;
+	int ret = 0;
+	u8 dma_burst;
+	struct dma_slave_config dma_sconfig = {0};
+
+	val = QSPI_DMA_BLK_SET(tqspi->curr_dma_words - 1);
+	tegra_qspi_writel(tqspi, val, QSPI_DMA_BLK);
+
+	tegra_qspi_unmask_irq(tqspi);
+
+	if (tqspi->is_packed)
+		len = DIV_ROUND_UP(tqspi->curr_dma_words *
+				   tqspi->bytes_per_word, 4) * 4;
+	else
+		len = tqspi->curr_dma_words * 4;
+
+	/* Set attention level based on length of transfer */
+	val = 0;
+	if (len & 0xF) {
+		val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
+		dma_burst = 1;
+	} else if (((len) >> 4) & 0x1) {
+		val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
+		dma_burst = 4;
+	} else {
+		val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
+		dma_burst = 8;
+	}
+
+	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
+	tqspi->dma_control_reg = val;
+
+	dma_sconfig.device_fc = true;
+	if (tqspi->cur_direction & DATA_DIR_TX) {
+		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
+		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.dst_maxburst = dma_burst;
+		ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
+		if (ret < 0) {
+			dev_err(tqspi->dev,
+				"DMA slave config failed: %d\n", ret);
+			return ret;
+		}
+
+		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
+		ret = tegra_qspi_start_tx_dma(tqspi, len);
+		if (ret < 0) {
+			dev_err(tqspi->dev,
+				"Starting tx dma failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (tqspi->cur_direction & DATA_DIR_RX) {
+		dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
+		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dma_sconfig.src_maxburst = dma_burst;
+		ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
+		if (ret < 0) {
+			dev_err(tqspi->dev,
+				"DMA slave config failed: %d\n", ret);
+			return ret;
+		}
+
+		/* Make the dma buffer to read by dma */
+		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
+					   tqspi->dma_buf_size,
+					   DMA_FROM_DEVICE);
+
+		ret = tegra_qspi_start_rx_dma(tqspi, len);
+		if (ret < 0) {
+			dev_err(tqspi->dev,
+				"Starting rx dma failed: %d\n", ret);
+			if (tqspi->cur_direction & DATA_DIR_TX)
+				dmaengine_terminate_all(tqspi->tx_dma_chan);
+			return ret;
+		}
+	}
+
+	tegra_qspi_writel(tqspi, tqspi->command1_reg, QSPI_COMMAND1);
+
+	tqspi->is_curr_dma_xfer = true;
+	tqspi->dma_control_reg = val;
+	val |= QSPI_DMA_EN;
+	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
+
+	return ret;
+}
+
+static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi_data *qspi,
+					       struct spi_transfer *t)
+{
+	u32 val;
+	unsigned int cur_words;
+
+	if (qspi->cur_direction & DATA_DIR_TX)
+		cur_words = tegra_qspi_fill_tx_fifo_from_client_txbuf(qspi, t);
+	else
+		cur_words = qspi->curr_dma_words;
+
+	val = QSPI_DMA_BLK_SET(cur_words - 1);
+	tegra_qspi_writel(qspi, val, QSPI_DMA_BLK);
+
+	tegra_qspi_unmask_irq(qspi);
+
+	qspi->is_curr_dma_xfer = false;
+	val = qspi->command1_reg;
+	val |= QSPI_PIO;
+	tegra_qspi_writel(qspi, val, QSPI_COMMAND1);
+
+	return 0;
+}
+
+static int tegra_qspi_init_dma_param(struct tegra_qspi_data *tqspi,
+				     bool dma_to_memory)
+{
+	struct dma_chan *dma_chan;
+	u32 *dma_buf;
+	dma_addr_t dma_phys;
+
+	if (!device_property_present(tqspi->dev, "dmas"))
+		return 0;
+
+	dma_chan = dma_request_chan(tqspi->dev, dma_to_memory ? "rx" : "tx");
+	if (IS_ERR(dma_chan))
+		return dev_err_probe(tqspi->dev, PTR_ERR(dma_chan),
+				     "Dma channel is not available\n");
+
+	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size,
+				     &dma_phys, GFP_KERNEL);
+	if (!dma_buf) {
+		dma_release_channel(dma_chan);
+		return -ENOMEM;
+	}
+
+	if (dma_to_memory) {
+		tqspi->rx_dma_chan = dma_chan;
+		tqspi->rx_dma_buf = dma_buf;
+		tqspi->rx_dma_phys = dma_phys;
+	} else {
+		tqspi->tx_dma_chan = dma_chan;
+		tqspi->tx_dma_buf = dma_buf;
+		tqspi->tx_dma_phys = dma_phys;
+	}
+
+	tqspi->use_dma = true;
+
+	return 0;
+}
+
+static void tegra_qspi_deinit_dma_param(struct tegra_qspi_data *tqspi,
+					bool dma_to_memory)
+{
+	u32 *dma_buf;
+	dma_addr_t dma_phys;
+	struct dma_chan *dma_chan;
+
+	if (dma_to_memory) {
+		dma_buf = tqspi->rx_dma_buf;
+		dma_chan = tqspi->rx_dma_chan;
+		dma_phys = tqspi->rx_dma_phys;
+		tqspi->rx_dma_chan = NULL;
+		tqspi->rx_dma_buf = NULL;
+	} else {
+		dma_buf = tqspi->tx_dma_buf;
+		dma_chan = tqspi->tx_dma_chan;
+		dma_phys = tqspi->tx_dma_phys;
+		tqspi->tx_dma_buf = NULL;
+		tqspi->tx_dma_chan = NULL;
+	}
+	if (!dma_chan)
+		return;
+
+	dma_free_coherent(tqspi->dev, tqspi->dma_buf_size, dma_buf, dma_phys);
+	dma_release_channel(dma_chan);
+}
+
+static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi,
+					 struct spi_transfer *t,
+					 bool is_first_of_msg)
+{
+	struct tegra_qspi_data *tqspi = spi_master_get_devdata(spi->master);
+	u32 speed = t->speed_hz;
+	u8 bits_per_word = t->bits_per_word;
+	u32 command1;
+	int req_mode;
+
+	if (speed != tqspi->cur_speed) {
+		clk_set_rate(tqspi->clk, speed);
+		tqspi->cur_speed = speed;
+	}
+
+	tqspi->cur_pos = 0;
+	tqspi->cur_rx_pos = 0;
+	tqspi->cur_tx_pos = 0;
+	tqspi->curr_xfer = t;
+
+	if (is_first_of_msg) {
+		tegra_qspi_mask_clear_irq(tqspi);
+
+		command1 = tqspi->def_command1_reg;
+		command1 |= QSPI_BIT_LENGTH(bits_per_word - 1);
+
+		command1 &= ~QSPI_CONTROL_MODE_MASK;
+		req_mode = spi->mode & 0x3;
+		if (req_mode == SPI_MODE_3)
+			command1 |= QSPI_CONTROL_MODE_3;
+		else
+			command1 |= QSPI_CONTROL_MODE_0;
+		tegra_qspi_writel(tqspi, command1, QSPI_COMMAND1);
+
+		/* toggle cs to active state */
+		if (spi->mode & SPI_CS_HIGH)
+			command1 |= QSPI_CS_SW_VAL;
+		else
+			command1 &= ~QSPI_CS_SW_VAL;
+		tegra_qspi_writel(tqspi, command1, QSPI_COMMAND1);
+	} else {
+		command1 = tqspi->command1_reg;
+		command1 &= ~QSPI_BIT_LENGTH(~0);
+		command1 |= QSPI_BIT_LENGTH(bits_per_word - 1);
+	}
+
+	command1 &= ~QSPI_SDR_DDR_SEL;
+
+	return command1;
+}
+
+static int tegra_qspi_start_transfer_one(struct spi_device *spi,
+					 struct spi_transfer *t, u32 command1)
+{
+	struct tegra_qspi_data *tqspi = spi_master_get_devdata(spi->master);
+	unsigned int total_fifo_words;
+	u8 bus_width = 0;
+	int ret;
+
+	total_fifo_words = tegra_qspi_calculate_curr_xfer_param(tqspi, t);
+
+	command1 &= ~QSPI_PACKED;
+	if (tqspi->is_packed)
+		command1 |= QSPI_PACKED;
+	tegra_qspi_writel(tqspi, command1, QSPI_COMMAND1);
+
+	command1 &= ~(QSPI_TX_EN | QSPI_RX_EN);
+	tqspi->cur_direction = 0;
+	if (t->rx_buf) {
+		command1 |= QSPI_RX_EN;
+		tqspi->cur_direction |= DATA_DIR_RX;
+		bus_width = t->rx_nbits;
+	}
+
+	if (t->tx_buf) {
+		command1 |= QSPI_TX_EN;
+		tqspi->cur_direction |= DATA_DIR_TX;
+		bus_width = t->tx_nbits;
+	}
+
+	command1 &= ~QSPI_INTERFACE_WIDTH_MASK;
+	if (bus_width == SPI_NBITS_QUAD)
+		command1 |= QSPI_INTERFACE_WIDTH_QUAD;
+	else if (bus_width == SPI_NBITS_DUAL)
+		command1 |= QSPI_INTERFACE_WIDTH_DUAL;
+	else
+		command1 |= QSPI_INTERFACE_WIDTH_SINGLE;
+	tqspi->command1_reg = command1;
+
+	tegra_qspi_writel(tqspi, QSPI_NUM_DUMMY_CYCLE(tqspi->dummy_cycles),
+			  QSPI_MISC_REG);
+
+	ret = tegra_qspi_flush_fifos(tqspi);
+	if (ret < 0)
+		return ret;
+
+	if (tqspi->use_dma && total_fifo_words > QSPI_FIFO_DEPTH)
+		ret = tegra_qspi_start_dma_based_transfer(tqspi, t);
+	else
+		ret = tegra_qspi_start_cpu_based_transfer(tqspi, t);
+	return ret;
+}
+
+static struct tegra_qspi_client_data
+	*tegra_qspi_parse_cdata_dt(struct spi_device *spi)
+{
+	struct tegra_qspi_client_data *cdata;
+	struct device_node *slave_np;
+
+	slave_np = spi->dev.of_node;
+	if (!slave_np) {
+		dev_dbg(&spi->dev, "device node not found\n");
+		return NULL;
+	}
+
+	cdata = kzalloc(sizeof(*cdata), GFP_KERNEL);
+	if (!cdata)
+		return NULL;
+
+	of_property_read_u32(slave_np, "nvidia,tx-clk-tap-delay",
+			     &cdata->tx_clk_tap_delay);
+	of_property_read_u32(slave_np, "nvidia,rx-clk-tap-delay",
+			     &cdata->rx_clk_tap_delay);
+	return cdata;
+}
+
+static void tegra_qspi_cleanup(struct spi_device *spi)
+{
+	struct tegra_qspi_client_data *cdata = spi->controller_data;
+
+	spi->controller_data = NULL;
+	if (spi->dev.of_node)
+		kfree(cdata);
+}
+
+static int tegra_qspi_setup(struct spi_device *spi)
+{
+	struct tegra_qspi_data *tqspi = spi_master_get_devdata(spi->master);
+	struct tegra_qspi_client_data *cdata = spi->controller_data;
+	u32 tx_tap = 0, rx_tap = 0;
+	u32 val;
+	unsigned long flags;
+	int ret;
+
+	dev_dbg(&spi->dev, "setup %d bpw, %scpol, %scpha, %dHz\n",
+		spi->bits_per_word,
+		spi->mode & SPI_CPOL ? "" : "~",
+		spi->mode & SPI_CPHA ? "" : "~",
+		spi->max_speed_hz);
+
+	if (!cdata) {
+		cdata = tegra_qspi_parse_cdata_dt(spi);
+		spi->controller_data = cdata;
+	}
+
+	ret = pm_runtime_get_sync(tqspi->dev);
+	if (ret < 0) {
+		dev_err(tqspi->dev, "runtime resume failed: %d\n", ret);
+		if (cdata)
+			tegra_qspi_cleanup(spi);
+		return ret;
+	}
+
+	spin_lock_irqsave(&tqspi->lock, flags);
+	/* keep default cs state to inactive */
+	val = tqspi->def_command1_reg;
+	if (spi->mode & SPI_CS_HIGH)
+		val &= ~QSPI_CS_SW_VAL;
+	else
+		val |= QSPI_CS_SW_VAL;
+
+	tqspi->def_command1_reg = val;
+	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
+
+	if (cdata && cdata->tx_clk_tap_delay)
+		tx_tap = cdata->tx_clk_tap_delay;
+	if (cdata && cdata->rx_clk_tap_delay)
+		rx_tap = cdata->rx_clk_tap_delay;
+	tqspi->def_command2_reg = QSPI_TX_TAP_DELAY(tx_tap) |
+				  QSPI_RX_TAP_DELAY(rx_tap);
+	tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMAND2);
+
+	spin_unlock_irqrestore(&tqspi->lock, flags);
+
+	pm_runtime_put(tqspi->dev);
+	return 0;
+}
+
+static void tegra_qspi_dump_regs(struct tegra_qspi_data *tqspi)
+{
+	dev_dbg(tqspi->dev, "============ QSPI REGISTER DUMP ============\n");
+	dev_dbg(tqspi->dev, "Command1:    0x%08x | Command2:    0x%08x\n",
+		tegra_qspi_readl(tqspi, QSPI_COMMAND1),
+		tegra_qspi_readl(tqspi, QSPI_COMMAND2));
+	dev_dbg(tqspi->dev, "DMA_CTL:     0x%08x | DMA_BLK:     0x%08x\n",
+		tegra_qspi_readl(tqspi, QSPI_DMA_CTL),
+		tegra_qspi_readl(tqspi, QSPI_DMA_BLK));
+	dev_dbg(tqspi->dev, "INTR_MASK:  0x%08x | MISC: 0x%08x\n",
+		tegra_qspi_readl(tqspi, QSPI_INTR_MASK),
+		tegra_qspi_readl(tqspi, QSPI_MISC_REG));
+	dev_dbg(tqspi->dev, "TRANS_STAT:  0x%08x | FIFO_STATUS: 0x%08x\n",
+		tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS),
+		tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS));
+}
+
+static int tegra_qspi_transfer_one_message(struct spi_master *master,
+					   struct spi_message *msg)
+{
+	bool is_first_msg = true;
+	struct tegra_qspi_data *tqspi = spi_master_get_devdata(master);
+	struct spi_transfer *xfer;
+	struct spi_device *spi = msg->spi;
+	u8 dummy_cycles, ntransfers = 0;
+	int ret;
+	bool skip = false;
+	int xfer_phase = 0;
+
+	msg->status = 0;
+	msg->actual_length = 0;
+	tqspi->tx_status = 0;
+	tqspi->rx_status = 0;
+
+	/*
+	 * Tegra QSPI hardware support dummy bytes transfer based on the
+	 * programmed dummy clock cyles in QSPI register.
+	 * So, get the total dummy bytes from the dummy bytes transfer in
+	 * spi_messages and convert to dummy clock cyles.
+	 */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (ntransfers == DUMMY_BYTES_XFER &&
+		    !(list_is_last(&xfer->transfer_list, &msg->transfers)))
+			dummy_cycles = xfer->len * 8 / xfer->tx_nbits;
+		ntransfers++;
+	}
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		u32 cmd1;
+
+		/*
+		 * Program dummy clock cycles in Tegra QSPI register only
+		 * during address transfer phase.
+		 */
+		if (xfer_phase == ADDR_BYTES_XFER)
+			tqspi->dummy_cycles = dummy_cycles;
+		else
+			tqspi->dummy_cycles = 0;
+
+		/*
+		 * Tegra QSPI hardware support dummy bytes transfer.
+		 * So, skip the transfer of dummy bytes from the software.
+		 */
+		if (ntransfers == MAX_XFERS &&
+		    xfer_phase == DUMMY_BYTES_XFER) {
+			msg->actual_length += xfer->len;
+			xfer_phase++;
+			continue;
+		}
+
+		reinit_completion(&tqspi->xfer_completion);
+
+		cmd1 = tegra_qspi_setup_transfer_one(spi, xfer, is_first_msg);
+		if (!xfer->len) {
+			ret = 0;
+			skip = true;
+			goto exit;
+		}
+
+		ret = tegra_qspi_start_transfer_one(spi, xfer, cmd1);
+		if (ret < 0) {
+			dev_err(tqspi->dev,
+				"failed to start transfer: %d\n", ret);
+			goto exit;
+		}
+
+		is_first_msg = false;
+		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
+						  QSPI_DMA_TIMEOUT);
+		if (WARN_ON(ret == 0)) {
+			dev_err(tqspi->dev,
+				"qspi transfer timeout: %d\n", ret);
+			if (tqspi->is_curr_dma_xfer &&
+			    (tqspi->cur_direction & DATA_DIR_TX))
+				dmaengine_terminate_all(tqspi->tx_dma_chan);
+			if (tqspi->is_curr_dma_xfer &&
+			    (tqspi->cur_direction & DATA_DIR_RX))
+				dmaengine_terminate_all(tqspi->rx_dma_chan);
+			ret = -EIO;
+			tegra_qspi_dump_regs(tqspi);
+			tegra_qspi_flush_fifos(tqspi);
+			reset_control_assert(tqspi->rst);
+			udelay(2);
+			reset_control_deassert(tqspi->rst);
+			goto exit;
+		}
+
+		if (tqspi->tx_status ||  tqspi->rx_status) {
+			ret = -EIO;
+			dev_err(tqspi->dev, "error in transfer: %d\n", ret);
+			tegra_qspi_dump_regs(tqspi);
+			goto exit;
+		}
+
+		msg->actual_length += xfer->len;
+		xfer_phase++;
+	}
+
+	ret = 0;
+exit:
+	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
+	msg->status = ret;
+	spi_finalize_current_message(master);
+	return ret;
+}
+
+static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi_data *tqspi)
+{
+	struct spi_transfer *t = tqspi->curr_xfer;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tqspi->lock, flags);
+	if (tqspi->tx_status ||  tqspi->rx_status) {
+		dev_err(tqspi->dev, "CpuXfer ERROR bit set 0x%x\n",
+			tqspi->status_reg);
+		dev_err(tqspi->dev, "CpuXfer 0x%08x:0x%08x\n",
+			tqspi->command1_reg, tqspi->dma_control_reg);
+		tegra_qspi_dump_regs(tqspi);
+		tegra_qspi_flush_fifos(tqspi);
+		complete(&tqspi->xfer_completion);
+		spin_unlock_irqrestore(&tqspi->lock, flags);
+		reset_control_assert(tqspi->rst);
+		udelay(2);
+		reset_control_deassert(tqspi->rst);
+		return IRQ_HANDLED;
+	}
+
+	if (tqspi->cur_direction & DATA_DIR_RX)
+		tegra_qspi_read_rx_fifo_to_client_rxbuf(tqspi, t);
+
+	if (tqspi->cur_direction & DATA_DIR_TX)
+		tqspi->cur_pos = tqspi->cur_tx_pos;
+	else
+		tqspi->cur_pos = tqspi->cur_rx_pos;
+
+	if (tqspi->cur_pos == t->len) {
+		complete(&tqspi->xfer_completion);
+		goto exit;
+	}
+
+	tegra_qspi_calculate_curr_xfer_param(tqspi, t);
+	tegra_qspi_start_cpu_based_transfer(tqspi, t);
+exit:
+	spin_unlock_irqrestore(&tqspi->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t handle_dma_based_xfer(struct tegra_qspi_data *tqspi)
+{
+	struct spi_transfer *t = tqspi->curr_xfer;
+	long wait_status;
+	int err = 0;
+	unsigned int total_fifo_words;
+	unsigned long flags;
+
+	/* Abort dmas if any error */
+	if (tqspi->cur_direction & DATA_DIR_TX) {
+		if (tqspi->tx_status) {
+			dmaengine_terminate_all(tqspi->tx_dma_chan);
+			err += 1;
+		} else {
+			wait_status = wait_for_completion_interruptible_timeout(
+				&tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
+			if (wait_status <= 0) {
+				dmaengine_terminate_all(tqspi->tx_dma_chan);
+				dev_err(tqspi->dev, "TxDma Xfer failed\n");
+				err += 1;
+			}
+		}
+	}
+
+	if (tqspi->cur_direction & DATA_DIR_RX) {
+		if (tqspi->rx_status) {
+			dmaengine_terminate_all(tqspi->rx_dma_chan);
+			err += 2;
+		} else {
+			wait_status = wait_for_completion_interruptible_timeout(
+				&tqspi->rx_dma_complete, QSPI_DMA_TIMEOUT);
+			if (wait_status <= 0) {
+				dmaengine_terminate_all(tqspi->rx_dma_chan);
+				dev_err(tqspi->dev, "RxDma Xfer failed\n");
+				err += 2;
+			}
+		}
+	}
+
+	spin_lock_irqsave(&tqspi->lock, flags);
+	if (err) {
+		dev_err(tqspi->dev, "DmaXfer: ERROR bit set 0x%x\n",
+			tqspi->status_reg);
+		dev_err(tqspi->dev, "DmaXfer 0x%08x:0x%08x\n",
+			tqspi->command1_reg, tqspi->dma_control_reg);
+		tegra_qspi_dump_regs(tqspi);
+		tegra_qspi_flush_fifos(tqspi);
+		complete(&tqspi->xfer_completion);
+		spin_unlock_irqrestore(&tqspi->lock, flags);
+		reset_control_assert(tqspi->rst);
+		udelay(2);
+		reset_control_deassert(tqspi->rst);
+		return IRQ_HANDLED;
+	}
+
+	if (tqspi->cur_direction & DATA_DIR_RX)
+		tegra_qspi_copy_qspi_rxbuf_to_client_rxbuf(tqspi, t);
+
+	if (tqspi->cur_direction & DATA_DIR_TX)
+		tqspi->cur_pos = tqspi->cur_tx_pos;
+	else
+		tqspi->cur_pos = tqspi->cur_rx_pos;
+
+	if (tqspi->cur_pos == t->len) {
+		complete(&tqspi->xfer_completion);
+		goto exit;
+	}
+
+	/* Continue transfer in current message */
+	total_fifo_words = tegra_qspi_calculate_curr_xfer_param(tqspi, t);
+	if (total_fifo_words > QSPI_FIFO_DEPTH)
+		err = tegra_qspi_start_dma_based_transfer(tqspi, t);
+	else
+		err = tegra_qspi_start_cpu_based_transfer(tqspi, t);
+
+exit:
+	spin_unlock_irqrestore(&tqspi->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
+{
+	struct tegra_qspi_data *tqspi = context_data;
+
+	if (!tqspi->is_curr_dma_xfer)
+		return handle_cpu_based_xfer(tqspi);
+	return handle_dma_based_xfer(tqspi);
+}
+
+static irqreturn_t tegra_qspi_isr(int irq, void *context_data)
+{
+	struct tegra_qspi_data *tqspi = context_data;
+
+	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
+	if (tqspi->cur_direction & DATA_DIR_TX)
+		tqspi->tx_status = tqspi->status_reg &
+				   (QSPI_TX_FIFO_UNF | QSPI_TX_FIFO_OVF);
+
+	if (tqspi->cur_direction & DATA_DIR_RX)
+		tqspi->rx_status = tqspi->status_reg &
+				   (QSPI_RX_FIFO_OVF | QSPI_RX_FIFO_UNF);
+	tegra_qspi_mask_clear_irq(tqspi);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static const struct of_device_id tegra_qspi_of_match[] = {
+	{ .compatible = "nvidia,tegra210-qspi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tegra_qspi_of_match);
+
+static int tegra_qspi_probe(struct platform_device *pdev)
+{
+	struct spi_master	*master;
+	struct tegra_qspi_data	*tqspi;
+	struct resource		*r;
+	int ret, qspi_irq;
+	int bus_num;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*tqspi));
+	if (!master) {
+		dev_err(&pdev->dev, "master allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, master);
+	tqspi = spi_master_get_devdata(master);
+
+	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
+				 &master->max_speed_hz))
+		master->max_speed_hz = QSPI_MAX_SPEED;
+
+	/* the spi->mode bits understood by this driver: */
+	master->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_CS_HIGH |
+			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD |
+			    SPI_RX_QUAD;
+	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
+				     SPI_BPW_MASK(8);
+	master->setup = tegra_qspi_setup;
+	master->cleanup = tegra_qspi_cleanup;
+	master->transfer_one_message = tegra_qspi_transfer_one_message;
+	master->num_chipselect = 1;
+	master->auto_runtime_pm = true;
+	bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
+	if (bus_num >= 0)
+		master->bus_num = bus_num;
+
+	tqspi->master = master;
+	tqspi->dev = &pdev->dev;
+	spin_lock_init(&tqspi->lock);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tqspi->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(tqspi->base)) {
+		ret = PTR_ERR(tqspi->base);
+		goto exit_free_master;
+	}
+
+	tqspi->phys = r->start;
+	qspi_irq = platform_get_irq(pdev, 0);
+	tqspi->irq = qspi_irq;
+
+	tqspi->clk = devm_clk_get(&pdev->dev, "qspi");
+	if (IS_ERR(tqspi->clk)) {
+		ret = PTR_ERR(tqspi->clk);
+		dev_err(&pdev->dev, "failed to get clock: %d\n", ret);
+		goto exit_free_master;
+	}
+
+	tqspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "qspi");
+	if (IS_ERR(tqspi->rst)) {
+		ret = PTR_ERR(tqspi->rst);
+		dev_err(&pdev->dev, "failed to get reset control: %d\n", ret);
+		goto exit_free_master;
+	}
+
+	tqspi->max_buf_size = QSPI_FIFO_DEPTH << 2;
+	tqspi->dma_buf_size = DEFAULT_QSPI_DMA_BUF_LEN;
+
+	ret = tegra_qspi_init_dma_param(tqspi, true);
+	if (ret < 0)
+		goto exit_free_master;
+	ret = tegra_qspi_init_dma_param(tqspi, false);
+	if (ret < 0)
+		goto exit_rx_dma_free;
+
+	if (tqspi->use_dma)
+		tqspi->max_buf_size = tqspi->dma_buf_size;
+
+	init_completion(&tqspi->tx_dma_complete);
+	init_completion(&tqspi->rx_dma_complete);
+
+	init_completion(&tqspi->xfer_completion);
+
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = tegra_qspi_runtime_resume(&pdev->dev);
+		if (ret)
+			goto exit_pm_disable;
+	}
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "runtime resume failed: %d\n", ret);
+		pm_runtime_put_noidle(&pdev->dev);
+		goto exit_pm_disable;
+	}
+
+	reset_control_assert(tqspi->rst);
+	udelay(2);
+	reset_control_deassert(tqspi->rst);
+	tqspi->def_command1_reg = QSPI_M_S | QSPI_CS_SW_HW |  QSPI_CS_SW_VAL;
+	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
+	tqspi->spi_cs_timing1 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING1);
+	tqspi->spi_cs_timing2 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING2);
+	tqspi->def_command2_reg = tegra_qspi_readl(tqspi, QSPI_COMMAND2);
+
+	pm_runtime_put(&pdev->dev);
+
+	ret = request_threaded_irq(tqspi->irq, tegra_qspi_isr,
+				   tegra_qspi_isr_thread, IRQF_ONESHOT,
+				   dev_name(&pdev->dev), tqspi);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"failed to request IRQ#%u: %d\n", tqspi->irq, ret);
+		goto exit_pm_disable;
+	}
+
+	master->dev.of_node = pdev->dev.of_node;
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register master: %d\n", ret);
+		goto exit_free_irq;
+	}
+	return ret;
+
+exit_free_irq:
+	free_irq(qspi_irq, tqspi);
+exit_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		tegra_qspi_runtime_suspend(&pdev->dev);
+	tegra_qspi_deinit_dma_param(tqspi, false);
+exit_rx_dma_free:
+	tegra_qspi_deinit_dma_param(tqspi, true);
+exit_free_master:
+	spi_master_put(master);
+	return ret;
+}
+
+static int tegra_qspi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct tegra_qspi_data	*tqspi = spi_master_get_devdata(master);
+
+	free_irq(tqspi->irq, tqspi);
+
+	tegra_qspi_deinit_dma_param(tqspi, false);
+	tegra_qspi_deinit_dma_param(tqspi, true);
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		tegra_qspi_runtime_suspend(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int tegra_qspi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+
+	return spi_master_suspend(master);
+}
+
+static int tegra_qspi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct tegra_qspi_data *tqspi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "runtime resume failed: %d\n", ret);
+		return ret;
+	}
+
+	tegra_qspi_writel(tqspi, tqspi->command1_reg, QSPI_COMMAND1);
+	tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMAND2);
+	pm_runtime_put(dev);
+
+	return spi_master_resume(master);
+}
+#endif
+
+static int tegra_qspi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct tegra_qspi_data *tqspi = spi_master_get_devdata(master);
+
+	/* Flush all write which are in PPSB queue by reading back */
+	tegra_qspi_readl(tqspi, QSPI_COMMAND1);
+
+	clk_disable_unprepare(tqspi->clk);
+	return 0;
+}
+
+static int tegra_qspi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct tegra_qspi_data *tqspi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_prepare_enable(tqspi->clk);
+	if (ret < 0) {
+		dev_err(tqspi->dev, "clk_prepare failed: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_qspi_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra_qspi_runtime_suspend,
+			   tegra_qspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_qspi_suspend, tegra_qspi_resume)
+};
+
+static struct platform_driver tegra_qspi_driver = {
+	.driver = {
+		.name		= "tegra-qspi",
+		.pm		= &tegra_qspi_pm_ops,
+		.of_match_table	= tegra_qspi_of_match,
+	},
+	.probe =	tegra_qspi_probe,
+	.remove =	tegra_qspi_remove,
+};
+module_platform_driver(tegra_qspi_driver);
+
+MODULE_ALIAS("platform:qspi-tegra");
+MODULE_DESCRIPTION("NVIDIA Tegra QSPI Controller Driver");
+MODULE_AUTHOR("Sowjanya Komatineni <skomatineni@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

