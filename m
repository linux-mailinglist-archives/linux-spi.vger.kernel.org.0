Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0586B1CA76A
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgEHJol (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 05:44:41 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41260 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgEHJol (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 05:44:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C224F80307C7;
        Fri,  8 May 2020 09:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k1SpiEDPikzy; Fri,  8 May 2020 12:37:09 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Date:   Fri, 8 May 2020 12:36:21 +0300
Message-ID: <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This SPI-controller is a part of the Baikal-T1 System Controller and
is based on the DW APB SSI IP-core, but with very limited resources:
no IRQ, no DMA, only a single native chip-select and just 8 bytes Tx/Rx
FIFO available. In order to provide a transparent initial boot code
execution this controller is also utilized by an vendor-specific block,
which provides an CS0 SPI flash direct mapping interface. Since both
direct mapping and SPI controller normal utilization are mutual exclusive
only a one of these interfaces can be used to access an external SPI
slave device. Taking into account the peculiarities of the controller
registers and physically mapped SPI flash access, very limited resources
and seeing the normal usecase of the controller is to access an external
SPI-nor flash, we decided to create a dedicated SPI driver for it.

The driver provides callbacks for native messages-based SPI interface,
SPI-memory and direct mapping read operations. Due to not having any
asynchronous signaling interface provided by the core we have no choice
but to implement a polling-based data transmission/reception algorithm.
In addition to that in order to bypass the automatic native chip-select
toggle the driver disables the local interrupts during the memory-based
transfers if no complementary GPIO-based chip-select detected in the
platform.

Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/spi/Kconfig       |  13 +
 drivers/spi/Makefile      |   1 +
 drivers/spi/spi-bt1-sys.c | 873 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-bt1-sys.h | 169 ++++++++
 4 files changed, 1056 insertions(+)
 create mode 100644 drivers/spi/spi-bt1-sys.c
 create mode 100644 drivers/spi/spi-bt1-sys.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 741b9140992a..3b1815b6a904 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -171,6 +171,19 @@ config SPI_BCM_QSPI
 	  based platforms. This driver works for both SPI master for spi-nor
 	  flash device as well as MSPI device.
 
+config SPI_BT1_SYS
+	tristate "Baikal-T1 System Boot SPI Controller"
+	depends on (MIPS_BAIKAL_T1 && OF) || COMPILE_TEST
+	imply SPI_MEM
+	help
+	  SPI driver for Baikal-T1 System Boot SPI Controller. It's based on
+	  the DW APB SSI IP block, but with very limited resources available:
+	  no IRQ, no DMA, a single CS, FIFO of just 8 bytes depth. Its primary
+	  usecase is to boot the system from an external SPI-nor flash. So
+	  aside with the poll-based normal SPI interface the memory operations
+	  and read-only direct mapping are supported by the driver from
+	  scratch.
+
 config SPI_BITBANG
 	tristate "Utilities for Bitbanging SPI masters"
 	help
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 28f601327f8c..3c5d40a298e4 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
 obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-iproc-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
+obj-$(CONFIG_SPI_BT1_SYS)		+= spi-bt1-sys.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
 obj-$(CONFIG_SPI_CADENCE)		+= spi-cadence.o
 obj-$(CONFIG_SPI_CLPS711X)		+= spi-clps711x.o
diff --git a/drivers/spi/spi-bt1-sys.c b/drivers/spi/spi-bt1-sys.c
new file mode 100644
index 000000000000..f7ab0eb4c247
--- /dev/null
+++ b/drivers/spi/spi-bt1-sys.c
@@ -0,0 +1,873 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Authors:
+ *   Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
+ *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
+ *
+ * Baikal-T1 System Boot SPI Controller driver
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/irqflags.h>
+#include <linux/preempt.h>
+#include <linux/debugfs.h>
+#include <linux/cpumask.h>
+#include <linux/seq_file.h>
+
+#include "spi-bt1-sys.h"
+
+static void bs_set_cfg(struct bt1_spi *bs, const struct bt1_spi_cfg *req)
+{
+	u32 ctrl0, ctrl1, baudr, min_sckdv, sckdv;
+
+	ctrl0 = FIELD_PREP(BC_SPI_CTRL0_DFS_MASK, req->dfs - 1) |
+		FIELD_PREP(BC_SPI_CTRL0_FRF_MASK, BC_SPI_CTRL0_FRF_SPI) |
+		(req->mode & SPI_CPHA ? BC_SPI_CTRL0_SCPH : 0) |
+		(req->mode & SPI_CPOL ? BC_SPI_CTRL0_SCPOL : 0) |
+		(req->mode & SPI_LOOP ? BC_SPI_CTRL0_SRL : 0) |
+		FIELD_PREP(BC_SPI_CTRL0_TMOD_MASK, req->tmode);
+	ctrl1 = FIELD_PREP(BC_SPI_CTRL1_NDF_MASK, req->ndf ? req->ndf - 1 : 0);
+
+	/*
+	 * There is a very tricky race condition hidden inside Baikal-T1 SoC
+	 * MMIO implementation. Simultaneous accesses to any registers via
+	 * the APB bus are serialized even if they are executed to different
+	 * addresses of even different controllers. This may cause
+	 * IO-operations delays (two, three, four, etc times the normal IO
+	 * operation latency), which in our case may lead to the data loss if
+	 * SPI-bus is fast enough and APB traffic is too heavy (either
+	 * generated by sibling CPU or DMA). So in order to fix this we have
+	 * no other way but to increase the SPI-bus clock divider lower limit.
+	 * Note this limitation isn't applicable to the SPI flash direct
+	 * mapping mode, since IO operations are performed by the Boot
+	 * Controller itself while CPU just reads the requested data.
+	 */
+	sckdv = DIV_ROUND_UP(bs->ref_freq, req->freq);
+	if (!req->dirmap && !req->cs_gpiod && num_possible_cpus() > 1)
+		min_sckdv = BC_SPI_MIN_SCKDV;
+	else
+		min_sckdv = 2;
+	sckdv = clamp_val(sckdv, min_sckdv, BC_SPI_BAUDR_SCKDV_MASK);
+	baudr = FIELD_PREP(BC_SPI_BAUDR_SCKDV_MASK, sckdv);
+
+	/*
+	 * Enable DW APB SSI controller registers access by means of the
+	 * RDA mode control bit. Only then we'll be able to read/write
+	 * from/to the controller memory mapped config-space.
+	 */
+	writel(BC_CSR_SPI_RDA, bs->regs + BC_CSR);
+
+	/*
+	 * Update the SPI controller configuration registers and enable
+	 * the requested slave for further communications.
+	 */
+	writel(0, bs->regs + BC_SPI_SSIENR);
+	writel(ctrl0, bs->regs + BC_SPI_CTRL0);
+	writel(ctrl1, bs->regs + BC_SPI_CTRL1);
+	writel(baudr, bs->regs + BC_SPI_BAUDR);
+	writel(BC_SPI_SSIENR_EN, bs->regs + BC_SPI_SSIENR);
+
+	bs->cfg = *req;
+
+	/*
+	 * DW APB SSI controller has a nasty peculiarity. It doesn't provide
+	 * a direct way to set and clear the native chip-select signal. Instead
+	 * the controller asserts the CS pin if Tx FIFO isn't empty and a
+	 * transmission is going on. When Tx FIFO doesn't have anything to be
+	 * pushed out the chip-select pin will be automatically de-asserted
+	 * back to the high level. Needless to say that the sudden CS
+	 * de-assertion in the middle of the message transfer most likely will
+	 * cause the data loss. So in order to make sure the executed transfers
+	 * are CS-atomic we have to either keep the controller FIFO non-empty
+	 * during the whole series of transfers or use GPIO-based chip-select
+	 * signal. The last case availability depends on the platform
+	 * configuration, while the former one can be achieved by making sure
+	 * nothing preempt the transfer execution context. It can be done by
+	 * disabling the local interrupts while the data being pushed and
+	 * pulled to/from the controller FIFOs. Note we don't have to worry
+	 * about this problem in case of SPI flash transparent access, because
+	 * IO operations are performed by the Boot Controller.
+	 */
+	writel(BIT(req->cs), bs->regs + BC_SPI_SER);
+	if (req->cs_gpiod) {
+		gpiod_set_value_cansleep(req->cs_gpiod,
+					 !!(bs->cfg.mode & SPI_CS_HIGH));
+	} else if (!req->dirmap) {
+		local_irq_save(bs->cfg.flags);
+		preempt_disable();
+	}
+
+	/*
+	 * If direct mapping is requested from now the DW APB SSI registers
+	 * are getting unavailable.
+	 */
+	if (req->dirmap)
+		writel(0, bs->regs + BC_CSR);
+}
+
+/*
+ * Note the next method is applicable only in non-direct mapping case. So
+ * we don't need to disable the transparent mode to access the DW APB SSI
+ * registers since they are already available after bs_set_cfg() actions.
+ */
+static void bs_update_cfg(struct bt1_spi *bs, struct spi_transfer *xfer)
+{
+	u32 ctrl0, baudr, min_sckdv, sckdv;
+
+	sckdv = DIV_ROUND_UP(bs->ref_freq, xfer->speed_hz);
+	if (!bs->cfg.cs_gpiod && num_possible_cpus() > 1)
+		min_sckdv = BC_SPI_MIN_SCKDV;
+	else
+		min_sckdv = 2;
+	sckdv = clamp_val(sckdv, min_sckdv, BC_SPI_BAUDR_SCKDV_MASK);
+	xfer->effective_speed_hz = bs->ref_freq / sckdv;
+
+	if (xfer->bits_per_word == bs->cfg.dfs &&
+	    xfer->speed_hz == bs->cfg.freq)
+		return;
+
+	ctrl0 = readl(bs->regs + BC_SPI_CTRL0) & ~BC_SPI_CTRL0_DFS_MASK;
+	ctrl0 |= FIELD_PREP(BC_SPI_CTRL0_DFS_MASK, xfer->bits_per_word - 1);
+	baudr = FIELD_PREP(BC_SPI_BAUDR_SCKDV_MASK, sckdv);
+
+	writel(0, bs->regs + BC_SPI_SSIENR);
+	writel(ctrl0, bs->regs + BC_SPI_CTRL0);
+	writel(baudr, bs->regs + BC_SPI_BAUDR);
+	writel(BC_SPI_SSIENR_EN, bs->regs + BC_SPI_SSIENR);
+
+	bs->cfg.dfs = xfer->bits_per_word;
+	bs->cfg.freq = xfer->speed_hz;
+}
+
+static void bs_clear_cfg(struct bt1_spi *bs)
+{
+	if (bs->cfg.cs_gpiod) {
+		gpiod_set_value_cansleep(bs->cfg.cs_gpiod,
+					 !(bs->cfg.mode & SPI_CS_HIGH));
+	} else if (!bs->cfg.dirmap) {
+		local_irq_restore(bs->cfg.flags);
+		preempt_enable();
+	}
+
+	/* Disable direct mapping if has been enabled in bs_set_cfg(). */
+	if (bs->cfg.dirmap)
+		writel(BC_CSR_SPI_RDA, bs->regs + BC_CSR);
+
+	writel(0, bs->regs + BC_SPI_SER);
+}
+
+static int bs_check_status(struct bt1_spi *bs)
+{
+	int ret = 0;
+	u32 data;
+
+	/* Check the bogus bits of the controller status register. */
+	data = readl(bs->regs + BC_SPI_RISR);
+	if (data & BC_SPI_RISR_RXO) {
+		dev_err(bs->dev, "RX FIFO overrun detected\n");
+		ret = -EIO;
+	}
+
+	if (data & BC_SPI_RISR_RXU) {
+		dev_err(bs->dev, "RX FIFO underrun detected\n");
+		ret = -EIO;
+	}
+
+	if (data & BC_SPI_RISR_TXO) {
+		dev_err(bs->dev, "TX FIFO overrun detected\n");
+		ret = -EIO;
+	}
+
+	readl(bs->regs + BC_SPI_ICR);
+
+	/*
+	 * Spin around the BUSY-state bit waiting for the controller to finish
+	 * all the requested IO-operations.
+	 */
+	do {
+		data = readl(bs->regs + BC_SPI_SR);
+	} while ((data & BC_SPI_SR_BUSY) || !(data & BC_SPI_SR_TFE));
+
+	return ret;
+}
+
+static int bs_pull_bytes(struct bt1_spi *bs, u8 *dst, unsigned int len)
+{
+	const u8 *end = dst + len;
+	const u8 *next = dst;
+	int retry = BC_SPI_RETRY;
+
+	/* Write dummy-data to the outbound FIFO to trigger the RO-transfer. */
+	if (bs->cfg.tmode == BC_SPI_CTRL0_TMOD_RO)
+		writel(GENMASK(bs->cfg.dfs - 1, 0), bs->regs + BC_SPI_DR);
+
+	while (dst < end) {
+		next += __raw_readl(bs->regs + BC_SPI_RXFLR);
+		if (dst < next) {
+			do {
+				*dst++ = __raw_readl(bs->regs + BC_SPI_DR);
+			} while (dst < next);
+			retry = BC_SPI_RETRY;
+		} else if (!retry--) {
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static void bs_push_bytes(struct bt1_spi *bs, const u8 *src, unsigned int len)
+{
+	const u8 *end = src + len;
+	const u8 *next = src;
+
+	while (src < end) {
+		next += BC_SPI_FIFO_LEN - __raw_readl(bs->regs + BC_SPI_TXFLR);
+		if (src < next) {
+			if (next > end)
+				next = end;
+			do {
+				__raw_writel(*src++, bs->regs + BC_SPI_DR);
+			} while (src < next);
+		}
+	}
+}
+
+static void bs_pp_bytes(struct bt1_spi *bs, const u8 *src, u8 *dst,
+			unsigned int len)
+{
+	unsigned int txlen = len, rxlen = len;
+	u32 data, cnt;
+
+	/*
+	 * Note we have to keep the Tx FIFO only half full in order to prevent
+	 * the Rx FIFO overrun in case of the task rescheduling in the middle
+	 * of the loop.
+	 */
+	while (txlen || rxlen) {
+		cnt = BC_SPI_FIFO_LVL - __raw_readl(bs->regs + BC_SPI_TXFLR);
+		cnt = min(cnt, txlen);
+		txlen -= cnt;
+		while (cnt--) {
+			data = src ? *src++ : 0xFF;
+			__raw_writel(data, bs->regs + BC_SPI_DR);
+		}
+		cnt = __raw_readl(bs->regs + BC_SPI_RXFLR);
+		cnt = min(cnt, rxlen);
+		rxlen -= cnt;
+		while (cnt--) {
+			data = __raw_readl(bs->regs + BC_SPI_DR);
+			if (dst)
+				*dst++ = data;
+		}
+	}
+}
+
+static void bs_pp_words(struct bt1_spi *bs, const u16 *src, u16 *dst,
+			unsigned int len)
+{
+	unsigned int txlen = len, rxlen = len;
+	u32 data, cnt;
+
+	while (txlen || rxlen) {
+		cnt = BC_SPI_FIFO_LVL - __raw_readl(bs->regs + BC_SPI_TXFLR);
+		cnt = min(cnt, txlen);
+		txlen -= cnt;
+		while (cnt--) {
+			data = src ? *src++ : 0xFFFF;
+			__raw_writel(data, bs->regs + BC_SPI_DR);
+		}
+		cnt = __raw_readl(bs->regs + BC_SPI_RXFLR);
+		cnt = min(cnt, rxlen);
+		rxlen -= cnt;
+		while (cnt--) {
+			data = __raw_readl(bs->regs + BC_SPI_DR);
+			if (dst)
+				*dst++ = data;
+		}
+	}
+}
+
+static u8 *bs_create_cmd(struct bt1_spi *bs, const struct spi_mem_op *op,
+			 unsigned int *len)
+{
+	unsigned int i, j;
+	const u8 *data;
+	u8 *cmd;
+
+	/*
+	 * Calculate the total length of the EEPROM command transfer and
+	 * either use the pre-allocated buffer or create a temporary one.
+	 */
+	*len = 1 + op->addr.nbytes + op->dummy.nbytes;
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		*len += op->data.nbytes;
+
+	if (*len <= BC_SPI_BUF_SIZE) {
+		cmd = bs->buf;
+	} else {
+		cmd = kzalloc(*len, GFP_KERNEL);
+		if (!cmd)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Collect the operation code, address and dummy bytes into the single
+	 * buffer.
+	 */
+	cmd[0] = op->cmd.opcode;
+	for (i = 1; i <= op->addr.nbytes; ++i) {
+		cmd[i] = op->addr.val >>
+			 (BITS_PER_BYTE * (op->addr.nbytes - i));
+	}
+	for (; i <= op->addr.nbytes + op->dummy.nbytes; ++i)
+		cmd[i] = 0xFF;
+
+	/*
+	 * If it's a transfer with data to be sent, also copy it into the
+	 * single buffer in order to speed up the push-data loop. Otherwise
+	 * in case of high-frequency SPI transfers we may have an occasional
+	 * output data loss.
+	 */
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		data = op->data.buf.out;
+		for (j = 0; j < op->data.nbytes; ++i, ++j)
+			cmd[i] = data[j];
+	}
+
+	return cmd;
+}
+
+static void bs_clear_cmd(struct bt1_spi *bs, u8 *cmd)
+{
+	if (cmd != bs->buf)
+		kfree(cmd);
+}
+
+static int bs_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		if (op->data.nbytes > (BC_SPI_CTRL1_NDF_MASK + 1))
+			op->data.nbytes = BC_SPI_CTRL1_NDF_MASK + 1;
+	}
+
+	return 0;
+}
+
+static bool bs_supports_mem_op(struct spi_mem *mem,
+			       const struct spi_mem_op *op)
+{
+	if (op->data.buswidth > 1 || op->addr.buswidth > 1 ||
+	    op->dummy.buswidth > 1 || op->cmd.buswidth > 1)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
+static int bs_exec_mem_op(struct spi_mem *mem,
+			  const struct spi_mem_op *op)
+{
+	struct bt1_spi *bs = spi_controller_get_devdata(mem->spi->controller);
+	struct bt1_spi_cfg req;
+	unsigned int len;
+	int ret;
+	u8 *cmd;
+
+	/* Collect the controller configuration required by the operation. */
+	req.dirmap = false;
+	req.cs = mem->spi->chip_select;
+	req.cs_gpiod = mem->spi->cs_gpiod;
+	req.flags = 0;
+	req.mode = mem->spi->mode;
+	if (req.cs_gpiod) {
+		req.tmode = BC_SPI_CTRL0_TMOD_TR;
+		req.ndf = 0;
+	} else if (op->data.dir == SPI_MEM_DATA_IN) {
+		req.tmode = BC_SPI_CTRL0_TMOD_READ_EEPROM;
+		req.ndf = op->data.nbytes;
+	} else {
+		req.tmode = BC_SPI_CTRL0_TMOD_TO;
+		req.ndf = 0;
+	}
+	req.dfs = BITS_PER_BYTE;
+	req.freq = mem->spi->max_speed_hz;
+
+	/*
+	 * Collect the command data into a single output buffer to speed the
+	 * transmission up.
+	 */
+	cmd = bs_create_cmd(bs, op, &len);
+	if (IS_ERR(cmd))
+		return PTR_ERR(cmd);
+
+	bs_set_cfg(bs, &req);
+
+	/*
+	 * In the boosted mode we have to push and pull the data as soon as
+	 * possible otherwise it might be lost, due to either native CS
+	 * getting toggled or Rx FIFO getting overrun. In non-boosted mode we
+	 * can relax and push-pull data synchronously with no worries of losing
+	 * any data or breaking the transfers due to the native CS toggle.
+	 */
+	if (!bs->cfg.cs_gpiod) {
+		bs_push_bytes(bs, cmd, len);
+
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			ret = bs_pull_bytes(bs, op->data.buf.in,
+					    op->data.nbytes);
+	} else {
+		bs_pp_bytes(bs, cmd, NULL, len);
+
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			bs_pp_bytes(bs, NULL, op->data.buf.in,
+				    op->data.nbytes);
+	}
+
+	ret = bs_check_status(bs);
+
+	bs_clear_cfg(bs);
+
+	bs_clear_cmd(bs, cmd);
+
+	return ret;
+}
+
+static int bs_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct spi_controller *ctlr = desc->mem->spi->controller;
+	struct bt1_spi *bs = spi_controller_get_devdata(ctlr);
+
+	if (!bs->map || !bs_supports_mem_op(desc->mem, &desc->info.op_tmpl))
+		return -ENOTSUPP;
+
+	/*
+	 * Make sure the requested region doesn't go out of the physically
+	 * mapped flash memory bounds and the operation is read-only.
+	 */
+	if (desc->info.offset + desc->info.length > bs->map_len ||
+	    desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static void bs_copy_from_map(void *to, void __iomem *from, size_t len)
+{
+	size_t shift, chunk;
+	u32 data;
+
+	/*
+	 * We split the copying up into the next three stages: unaligned head,
+	 * aligned body, unaligned tail.
+	 */
+	shift = (size_t)from & 0x3;
+	if (shift) {
+		chunk = min_t(size_t, 4 - shift, len);
+		data = readl_relaxed(from - shift);
+		memcpy(to, &data + shift, chunk);
+		from += chunk;
+		to += chunk;
+		len -= chunk;
+	}
+
+	while (len >= 4) {
+		data = readl_relaxed(from);
+		memcpy(to, &data, 4);
+		from += 4;
+		to += 4;
+		len -= 4;
+	}
+
+	if (len) {
+		data = readl_relaxed(from);
+		memcpy(to, &data, len);
+	}
+}
+
+static ssize_t bs_dirmap_read(struct spi_mem_dirmap_desc *desc,
+			      u64 offs, size_t len, void *buf)
+{
+	struct spi_mem *mem = desc->mem;
+	struct bt1_spi *bs = spi_controller_get_devdata(mem->spi->controller);
+	struct bt1_spi_cfg req;
+
+	/*
+	 * Make sure the requested operation length is valid. Truncate the
+	 * length if it's greater than the length of the MMIO region.
+	 */
+	if (offs >= bs->map_len || !len)
+		return 0;
+
+	len = min_t(size_t, len, bs->map_len - offs);
+
+	/* Collect the controller configuration required by the operation. */
+	req.dirmap = true;
+	req.cs = mem->spi->chip_select;
+	req.cs_gpiod = mem->spi->cs_gpiod;
+	req.flags = 0;
+	req.mode = mem->spi->mode;
+	req.tmode = BC_SPI_CTRL0_TMOD_READ_EEPROM;
+	req.ndf = 4;
+	req.dfs = BITS_PER_BYTE;
+	req.freq = mem->spi->max_speed_hz;
+
+	bs_set_cfg(bs, &req);
+
+	bs_copy_from_map(buf, bs->map + offs, len);
+
+	bs_clear_cfg(bs);
+
+	return len;
+}
+
+static const struct spi_controller_mem_ops bs_mem_ops = {
+	.adjust_op_size = bs_adjust_mem_op_size,
+	.supports_op = bs_supports_mem_op,
+	.exec_op = bs_exec_mem_op,
+	.dirmap_create = bs_dirmap_create,
+	.dirmap_read = bs_dirmap_read
+};
+
+static int bs_prepare_message(struct spi_controller *ctrl,
+			      struct spi_message *msg)
+{
+	struct bt1_spi *bs = spi_controller_get_devdata(ctrl);
+	struct spi_transfer *xfer;
+	struct bt1_spi_cfg req;
+
+	/*
+	 * Currently the driver doesn't support the generic messages-based
+	 * SPI interface with pure native chip-select signal. This is due
+	 * to the automatic native chip-select toggle peculiarity described
+	 * in the comment of the bs_set_cfg() method. Alas we can't use the
+	 * IRQ-disable-based boost approach here since the native queue-based
+	 * SPI messages transfer method can sleep waiting for the
+	 * transfers/CS-change delays.
+	 */
+	if (!msg->spi->cs_gpiod)
+		return -ENOTSUPP;
+
+	/*
+	 * Collect the controller configuration common for all transfers and
+	 * specific to the very first one.
+	 */
+	xfer = list_first_entry(&msg->transfers, typeof(*xfer), transfer_list);
+	req.dirmap = false;
+	req.cs = msg->spi->chip_select;
+	req.cs_gpiod = msg->spi->cs_gpiod;
+	req.flags = 0;
+	req.mode = msg->spi->mode;
+	req.tmode = BC_SPI_CTRL0_TMOD_TR;
+	req.ndf = 0;
+	req.dfs = xfer->bits_per_word;
+	req.freq = xfer->speed_hz;
+
+	bs_set_cfg(bs, &req);
+
+	return 0;
+}
+
+static int bs_unprepare_message(struct spi_controller *ctrl,
+				struct spi_message *msg)
+{
+	struct bt1_spi *bs = spi_controller_get_devdata(ctrl);
+
+	bs_clear_cfg(bs);
+
+	return 0;
+}
+
+static int bs_transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
+			   struct spi_transfer *xfer)
+{
+	struct bt1_spi *bs = spi_controller_get_devdata(ctrl);
+
+	bs_update_cfg(bs, xfer);
+
+	if (bs->cfg.dfs <= 8)
+		bs_pp_bytes(bs, xfer->tx_buf, xfer->rx_buf, xfer->len);
+	else
+		bs_pp_words(bs, xfer->tx_buf, xfer->rx_buf, xfer->len / 2);
+
+	return bs_check_status(bs);
+}
+
+static struct bt1_spi *bs_create_data(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bt1_spi *bs;
+
+	bs = devm_kzalloc(dev, sizeof(*bs), GFP_KERNEL);
+	if (!bs)
+		return ERR_PTR(-ENOMEM);
+
+	bs->dev = dev;
+	bs->pdev = pdev;
+
+	return bs;
+}
+
+static int bs_request_regs(struct bt1_spi *bs)
+{
+	struct resource *res;
+
+	bs->regs = devm_platform_ioremap_resource_byname(bs->pdev, "config");
+	if (IS_ERR(bs->regs)) {
+		dev_err(bs->dev, "Couldn't get the controller registers\n");
+		return PTR_ERR(bs->regs);
+	}
+
+	/*
+	 * Direct mapping is optional feature, which in fact doesn't really
+	 * give much of the performance gain. But the driver supports it
+	 * anyway.
+	 */
+	bs->map = devm_platform_ioremap_resource_byname(bs->pdev, "map");
+	if (IS_ERR(bs->map)) {
+		bs->map = NULL;
+		bs->map_len = 0;
+		dev_warn(bs->dev, "No direct mapping memory detected\n");
+	} else {
+		res = platform_get_resource_byname(bs->pdev, IORESOURCE_MEM,
+						   "map");
+		bs->map_len = resource_size(res);
+	}
+
+	return 0;
+}
+
+static void bs_disable_clk(void *data)
+{
+	struct bt1_spi *bs = data;
+
+	clk_disable_unprepare(bs->ref);
+}
+
+static int bs_request_clks(struct bt1_spi *bs)
+{
+	int ret;
+
+	/*
+	 * SSI reference and APB clocks are synchronous so we only need a
+	 * single clock source requested and enabled.
+	 */
+	bs->ref = devm_clk_get(bs->dev, NULL);
+	if (IS_ERR(bs->ref)) {
+		dev_err(bs->dev, "Couldn't get the ref clock descriptor\n");
+		return PTR_ERR(bs->ref);
+	}
+
+	ret = clk_prepare_enable(bs->ref);
+	if (ret) {
+		dev_err(bs->dev, "Couldn't enable the reference clock\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(bs->dev, bs_disable_clk, bs);
+	if (ret) {
+		dev_err(bs->dev, "Can't add the clocks disable action\n");
+		return ret;
+	}
+
+	bs->ref_freq = clk_get_rate(bs->ref);
+	if (!bs->ref_freq) {
+		dev_err(bs->dev, "Invalid reference clock frequency\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bs_create_spi_controller(struct bt1_spi *bs)
+{
+	int ret;
+
+	bs->ctrl = spi_alloc_master(bs->dev, 0);
+	if (!bs->ctrl) {
+		dev_err(bs->dev, "No memory for SPI controller descriptor\n");
+		return -ENOMEM;
+	}
+
+	spi_controller_set_devdata(bs->ctrl, bs);
+
+	bs->ctrl->use_gpio_descriptors = true;
+	bs->ctrl->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
+	bs->ctrl->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
+	bs->ctrl->bus_num = bs->pdev->id;
+	bs->ctrl->prepare_message = bs_prepare_message;
+	bs->ctrl->unprepare_message = bs_unprepare_message;
+	bs->ctrl->transfer_one = bs_transfer_one;
+	bs->ctrl->mem_ops = &bs_mem_ops;
+	bs->ctrl->min_speed_hz = bs->ref_freq / (BC_SPI_BAUDR_SCKDV_MASK - 1);
+	bs->ctrl->max_speed_hz = bs->ref_freq / 2;
+	bs->ctrl->dev.of_node = bs->dev->of_node;
+	bs->ctrl->dev.fwnode = bs->dev->fwnode;
+	bs->ctrl->flags = SPI_MASTER_GPIO_SS;
+
+	ret = devm_spi_register_controller(bs->dev, bs->ctrl);
+	if (ret) {
+		spi_controller_put(bs->ctrl);
+		dev_err(bs->dev, "Failed to register the SPI controller\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+#define BC_SPI_DBGFS_REG(_name, _off)	\
+{					\
+	.name = _name,			\
+	.offset = _off			\
+}
+
+static const struct debugfs_reg32 bs_dbgfs_regs[] = {
+	BC_SPI_DBGFS_REG("CSR", BC_CSR),
+	BC_SPI_DBGFS_REG("MAR", BC_MAR),
+	BC_SPI_DBGFS_REG("DRID", BC_DRID),
+	BC_SPI_DBGFS_REG("VID", BC_VID),
+	BC_SPI_DBGFS_REG("CTRL0", BC_SPI_CTRL0),
+	BC_SPI_DBGFS_REG("CTRL1", BC_SPI_CTRL1),
+	BC_SPI_DBGFS_REG("SSIENR", BC_SPI_SSIENR),
+	BC_SPI_DBGFS_REG("SER", BC_SPI_SER),
+	BC_SPI_DBGFS_REG("BAUDR", BC_SPI_BAUDR),
+	BC_SPI_DBGFS_REG("TXFLR", BC_SPI_TXFLR),
+	BC_SPI_DBGFS_REG("RXFLR", BC_SPI_RXFLR),
+	BC_SPI_DBGFS_REG("SR", BC_SPI_SR),
+	BC_SPI_DBGFS_REG("RISR", BC_SPI_RISR),
+	BC_SPI_DBGFS_REG("IDR", BC_SPI_IDR),
+	BC_SPI_DBGFS_REG("VERSION", BC_SPI_VERSION)
+};
+
+static int bs_dbgfs_show_regs(struct seq_file *s, void *data)
+{
+	const struct debugfs_reg32 *regs = bs_dbgfs_regs;
+	struct bt1_spi *bs = s->private;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(bs_dbgfs_regs); i++, regs++) {
+		seq_printf(s, "%s = 0x%08x\n", regs->name,
+			   readl(bs->regs + regs->offset));
+		if (seq_has_overflowed(s))
+			break;
+	}
+
+	return 0;
+}
+
+static int bs_dbgfs_open_regs(struct inode *inode, struct file *file)
+{
+	struct bt1_spi *bs = inode->i_private;
+	int ret;
+
+	ret = single_open(file, bs_dbgfs_show_regs, bs);
+	if (!ret) {
+		mutex_lock(&bs->ctrl->io_mutex);
+		writel(BC_CSR_SPI_RDA, bs->regs + BC_CSR);
+	}
+
+	return ret;
+}
+
+static int bs_dbgfs_release_regs(struct inode *inode, struct file *file)
+{
+	struct bt1_spi *bs = inode->i_private;
+
+	mutex_unlock(&bs->ctrl->io_mutex);
+
+	return single_release(inode, file);
+}
+
+static const struct file_operations bs_fops_regs = {
+	.open = bs_dbgfs_open_regs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = bs_dbgfs_release_regs
+};
+
+static void bs_dbgfs_remove(void *data)
+{
+	struct bt1_spi *bs = data;
+
+	debugfs_remove_recursive(bs->dbgfs);
+}
+
+static void bs_dbgfs_init(struct bt1_spi *bs)
+{
+	char name[32];
+	int ret;
+
+	snprintf(name, 32, "bt1-sys-ssi%d", bs->ctrl->bus_num);
+	bs->dbgfs = debugfs_create_dir(name, NULL);
+
+	ret = devm_add_action_or_reset(bs->dev, bs_dbgfs_remove, bs);
+	if (ret)
+		return;
+
+	debugfs_create_file("registers", 0400, bs->dbgfs, bs, &bs_fops_regs);
+}
+
+#else
+
+static inline int bs_dbgfs_init(struct bt1_spi *bs)
+{
+	return 0;
+}
+
+#endif /* CONFIG_DEBUG_FS */
+
+static int bs_probe(struct platform_device *pdev)
+{
+	struct bt1_spi *bs;
+	int ret;
+
+	bs = bs_create_data(pdev);
+	if (IS_ERR(bs))
+		return PTR_ERR(bs);
+
+	ret = bs_request_regs(bs);
+	if (ret)
+		return ret;
+
+	ret = bs_request_clks(bs);
+	if (ret)
+		return ret;
+
+	ret = bs_create_spi_controller(bs);
+	if (ret)
+		return ret;
+
+	bs_dbgfs_init(bs);
+
+	return 0;
+}
+
+static const struct of_device_id bs_of_match[] = {
+	{ .compatible = "baikal,bt1-sys-ssi" },
+	{ }
+};
+
+static struct platform_driver bs_driver = {
+	.probe = bs_probe,
+	.driver = {
+		.name = "bt1-sys-ssi",
+		.of_match_table = bs_of_match
+	}
+};
+module_platform_driver(bs_driver);
+
+MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
+MODULE_DESCRIPTION("Baikal-T1 System Boot SPI Controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/spi/spi-bt1-sys.h b/drivers/spi/spi-bt1-sys.h
new file mode 100644
index 000000000000..a45c0ef9ff4d
--- /dev/null
+++ b/drivers/spi/spi-bt1-sys.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
+ *
+ * Baikal-T1 System Boot SPI Controller driver
+ */
+#ifndef __SPI_BT1_SYS_H__
+#define __SPI_BT1_SYS_H__
+
+#include <linux/kernel.h>
+#include <linux/bits.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/spi/spi.h>
+
+/*
+ * Baikal-T1 System Boot SPI controller registers. In addition to the Vendor-
+ * specific settings these are normal Synopsys DW APB SSI controller registers.
+ * Exception is that the IP core is synthesized with no IRQ/DMA, with very
+ * small FIFO of just 8 words and have a specific IP block implementing
+ * physically mapped SPI flash found at CS0.
+ */
+#define BC_CSR				0x000
+#define BC_CSR_MODE_FLD			0
+#define BC_CSR_MODE_MASK		GENMASK(1, BC_CSR_MODE_FLD)
+#define BC_CSR_MODE_ROM			0
+#define BC_CSR_MODE_SRAM		1
+#define BC_CSR_MODE_FLASH		2
+#define BC_CSR_SPI_RDA			BIT(8)
+#define BC_MAR				0x004
+#define BC_MAR_BSAB			BIT(0)
+#define BC_DRID				0x008
+#define BC_VID				0x00C
+#define BC_SPI_CTRL0			0x100
+#define BC_SPI_CTRL0_DFS_FLD		0
+#define BC_SPI_CTRL0_DFS_MASK		GENMASK(3, BC_SPI_CTRL0_DFS_FLD)
+#define BC_SPI_CTRL0_FRF_FLD		4
+#define BC_SPI_CTRL0_FRF_MASK		GENMASK(5, BC_SPI_CTRL0_FRF_FLD)
+#define BC_SPI_CTRL0_FRF_SPI		0
+#define BC_SPI_CTRL0_FRF_SSP		1
+#define BC_SPI_CTRL0_FRF_MW		2
+#define BC_SPI_CTRL0_SCPH		BIT(6)
+#define BC_SPI_CTRL0_SCPOL		BIT(7)
+#define BC_SPI_CTRL0_TMOD_FLD		8
+#define BC_SPI_CTRL0_TMOD_MASK		GENMASK(9, BC_SPI_CTRL0_TMOD_FLD)
+#define BC_SPI_CTRL0_TMOD_TR		0
+#define BC_SPI_CTRL0_TMOD_TO		1
+#define BC_SPI_CTRL0_TMOD_RO		2
+#define BC_SPI_CTRL0_TMOD_READ_EEPROM	3
+#define BC_SPI_CTRL0_SRL		BIT(11)
+#define BC_SPI_CTRL1			0x104
+#define BC_SPI_CTRL1_NDF_FLD		0
+#define BC_SPI_CTRL1_NDF_MASK		GENMASK(15, BC_SPI_CTRL1_NDF_FLD)
+#define BC_SPI_SSIENR			0x108
+#define BC_SPI_SSIENR_EN		BIT(0)
+#define BC_SPI_SER			0x110
+#define BC_SPI_SER_0			BIT(0)
+#define BC_SPI_BAUDR			0x114
+#define BC_SPI_BAUDR_SCKDV_FLD		0
+#define BC_SPI_BAUDR_SCKDV_MASK		GENMASK(15, BC_SPI_BAUDR_SCKDV_FLD)
+#define BC_SPI_TXFTLR			0x118
+#define BC_SPI_RXFTLR			0x11C
+#define BC_SPI_TXFLR			0x120
+#define BC_SPI_TXFLR_TXTFL_FLD		0
+#define BC_SPI_TXFLR_TXTFL_MASK		GENMASK(2, BC_SPI_TXFLR_TXTFL_FLD)
+#define BC_SPI_RXFLR			0x124
+#define BC_SPI_RXFLR_RXTFL_FLD		0
+#define BC_SPI_RXFLR_RXTFL_MASK		GENMASK(2, BC_SPI_RXFLR_RXTFL_FLD)
+#define BC_SPI_SR			0x128
+#define BC_SPI_SR_BUSY			BIT(0)
+#define BC_SPI_SR_TFNF			BIT(1)
+#define BC_SPI_SR_TFE			BIT(2)
+#define BC_SPI_SR_RFNE			BIT(3)
+#define BC_SPI_SR_RFF			BIT(4)
+#define BC_SPI_RISR			0x134
+#define BC_SPI_RISR_TXE			BIT(0)
+#define BC_SPI_RISR_TXO			BIT(1)
+#define BC_SPI_RISR_RXU			BIT(2)
+#define BC_SPI_RISR_RXO			BIT(3)
+#define BC_SPI_RISR_RXF			BIT(4)
+#define BC_SPI_TXOICR			0x138
+#define BC_SPI_RXOICR			0x13C
+#define BC_SPI_RXUICR			0x140
+#define BC_SPI_ICR			0x148
+#define BC_SPI_ICR_STS			BIT(0)
+#define BC_SPI_IDR			0x158
+#define BC_SPI_VERSION			0x15C
+#define BC_SPI_DR			0x160
+#define BC_SPI_RX_DLY			0x1F0
+
+/*
+ * Boot controller specific parameters
+ * @BC_SPI_FIFO_LEN: DW APB SSI controller FIFO length.
+ * @BC_SPI_FIFO_LVL: Safe Tx FIFO level so not to afraid the xfer task being
+ *		     scheduled.
+ * @BC_SPI_NUM_CS: Number of hardware chip selects.
+ * @BC_SPI_MIN_SCKDV: Minimal clock divider supported when native CS is used.
+ * @BC_SPI_RETRY: Number of retries before give up in waiting new data.
+ *		  Timeout may happen if the controller detected Rx-overrun
+ *		  event.
+ * @BC_SPI_BUF_SIZE: Size of the cmd-buffer for Read/Write-EEPROM transfer. It
+ *		     includes the opcode, address, dummy and data bytes.
+ */
+#define BC_SPI_FIFO_LEN			8
+#define BC_SPI_FIFO_LVL			(BC_SPI_FIFO_LEN / 2)
+#define BC_SPI_NUM_CS			1
+#define BC_SPI_MIN_SCKDV		6
+#define BC_SPI_RETRY			1000
+#define BC_SPI_BUF_SIZE		(1 + BITS_PER_LONG_LONG / BITS_PER_BYTE + 512)
+
+/*
+ * struct bt1_spi_cfg - DW APB SPI controller configuration
+ * @dirmap: Flag of SPI flash direct mapping.
+ * @cs: Native chip select number.
+ * @cs_gpiod: Chip-select GPIO descriptor.
+ * @flags: IRQ flags saved in case of the boosted transfers.
+ * @mode: SPI transfer mode.
+ * @tmode: TR/TO/RO/EEPROM modes.
+ * @dfs: Data frame size.
+ * @ndf: Number of data frames for RO/EEPROM transfers.
+ * @freq: Transfer frequency.
+ */
+struct bt1_spi_cfg {
+	bool dirmap;
+	u8 cs;
+	struct gpio_desc *cs_gpiod;
+	unsigned long flags;
+	u32 mode;
+	u32 tmode;
+	u32 dfs;
+	u32 ndf;
+	u32 freq;
+};
+
+/*
+ * struct bt1_spi - Bailal-T1 System Boot SPI controller private data
+ * @dev: Pointer to the device structure.
+ * @pdev: Pointer to the platform device structure.
+ * @ctrl: Pointer to the SPI controller structure.
+ * @regs: Memory mapped controller registers.
+ * @map: Physically mapped SPI flash.
+ * @map_len: Length of the physically mapped ROM.
+ * @buf: Temporary buffer.
+ * @cfg: Current controller configuration.
+ * @ref_freq: Reference frequency.
+ * @ref: Reference clock source.
+ */
+struct bt1_spi {
+	struct device *dev;
+	struct platform_device *pdev;
+	struct spi_controller *ctrl;
+
+	void __iomem *regs;
+	void __iomem *map;
+	resource_size_t map_len;
+
+	u8 buf[BC_SPI_BUF_SIZE];
+	struct bt1_spi_cfg cfg;
+	unsigned long ref_freq;
+	struct clk *ref;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dbgfs;
+#endif
+};
+
+#endif /* __SPI_BT1_SYS_H__ */
-- 
2.25.1

