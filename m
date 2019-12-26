Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B112AAC0
	for <lists+linux-spi@lfdr.de>; Thu, 26 Dec 2019 08:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLZHLL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Dec 2019 02:11:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:59766 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfLZHLL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Dec 2019 02:11:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 23:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,358,1571727600"; 
   d="scan'208";a="300327095"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 25 Dec 2019 23:11:06 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, vigneshr@ti.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v5 2/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller
Date:   Thu, 26 Dec 2019 15:10:58 +0800
Message-Id: <20191226071058.20041-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191226071058.20041-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20191226071058.20041-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add support for the Cadence QSPI controller. This controller is
present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
This driver has been tested on the Intel LGM SoCs.

This driver does not support generic SPI and also the implementation
only supports spi-mem interface to replace the existing driver in
mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
flash memory.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/spi/Kconfig               |    8 +
 drivers/spi/Makefile              |    1 +
 drivers/spi/spi-cadence-quadspi.c | 1175 +++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.h |  245 ++++++++
 4 files changed, 1429 insertions(+)
 create mode 100644 drivers/spi/spi-cadence-quadspi.c
 create mode 100644 drivers/spi/spi-cadence-quadspi.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 870f7797b56b..6d48a89737a4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -193,6 +193,14 @@ config SPI_CADENCE
 	  This selects the Cadence SPI controller master driver
 	  used by Xilinx Zynq and ZynqMP.
 
+config SPI_CADENCE_QUADSPI
+	tristate "Cadence Quad SPI controller"
+	depends on OF && (ARM || ARM64 || COMPILE_TEST || X86)
+	depends on MTD || MTD_SPI_NOR || MTD_SPI_NAND
+	help
+	  Cadence QSPI is a specialized controller for connecting an SPI
+	  Flash over 1/2/4/8-bit wide bus. This enables support for the Quad SPI
+
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index bb49c9e6d0a0..288f5fa903fe 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-iproc-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
 obj-$(CONFIG_SPI_CADENCE)		+= spi-cadence.o
+obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= spi-cadence-quadspi.o
 obj-$(CONFIG_SPI_CLPS711X)		+= spi-clps711x.o
 obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
 obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
new file mode 100644
index 000000000000..01f4985b37f5
--- /dev/null
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -0,0 +1,1175 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Cadence QSPI Controller
+ *
+ * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
+ * Copyright Intel Corporation (C) 2019-2020. All rights reserved.
+ */
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/unaligned/be_byteshift.h>
+
+#include "spi-cadence-quadspi.h"
+
+/* Quirks */
+#define CQSPI_NEEDS_WR_DELAY		BIT(0)
+#define CQSPI_DISABLE_DAC_MODE		BIT(1)
+
+#define CADENCE_QSPI_NAME		"cadence-qspi"
+
+struct cqspi_driver_platdata {
+	u32 hwcaps_mask;
+	u8 quirks;
+};
+
+static int cqspi_wait_for_bit(void __iomem *reg, const u32 mask, bool clr)
+{
+	u32 val;
+
+	return readl_relaxed_poll_timeout(reg, val,
+					  (((clr ? ~val : val) & mask) == mask),
+					  10, CQSPI_TIMEOUT_MS * 1000);
+}
+
+static bool cqspi_is_idle(struct struct_cqspi *cqspi)
+{
+	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+
+	return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
+}
+
+static int cqspi_wait_idle(struct struct_cqspi *cqspi)
+{
+	const unsigned int poll_idle_retry = 3;
+	unsigned int count = 0;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(CQSPI_TIMEOUT_MS);
+	while (1) {
+		/*
+		 * Read few times in succession to ensure the controller
+		 * is indeed idle, that is, the bit does not transition
+		 * low again.
+		 */
+		if (cqspi_is_idle(cqspi))
+			count++;
+		else
+			count = 0;
+
+		if (count >= poll_idle_retry)
+			return 0;
+
+		if (time_after(jiffies, timeout)) {
+		/* Timeout, in busy mode. */
+			dev_err(&cqspi->pdev->dev,
+				"QSPI is still busy after %dms timeout.\n",
+				CQSPI_TIMEOUT_MS);
+			return -ETIMEDOUT;
+		}
+
+		cpu_relax();
+	}
+}
+
+static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
+{
+	struct struct_cqspi *cqspi = dev;
+	u32 irq_status;
+
+	/* Read interrupt status */
+	irq_status = readl(cqspi->iobase + CQSPI_REG_IRQSTATUS);
+	if (!irq_status)
+		return IRQ_HANDLED;
+
+	cqspi->irq_status = irq_status;
+
+	/* Clear interrupt */
+	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
+	if (irq_status)
+		complete(&cqspi->transfer_complete);
+
+	return IRQ_HANDLED;
+}
+
+static u32 cqspi_cmd2addr(const unsigned char *addr_buf, u32 addr_width)
+{
+	unsigned int addr = 0;
+	int i;
+
+	/* Invalid address return zero. */
+	if (addr_width > 4)
+		return 0;
+
+	for (i = 0; i < addr_width; i++) {
+		addr = addr << 8;
+		addr |= addr_buf[i];
+	}
+
+	return addr;
+}
+
+static void cqspi_direct_access_enable(void __iomem *reg_base, bool enable)
+{
+	u32 reg;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	if (enable)
+		reg |= CQSPI_REG_CONFIG_DIRECT_MASK;
+	else
+		reg &= ~CQSPI_REG_CONFIG_DIRECT_MASK;
+
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+}
+
+static void cqspi_controller_enable(void __iomem *reg_base, bool enable)
+{
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	if (enable)
+		reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
+	else
+		reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
+
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+}
+
+static void cqspi_readdata_capture(void __iomem *reg_base, u32 bypass,
+				   u32 delay)
+{
+	unsigned int reg;
+
+	cqspi_controller_enable(reg_base, 0);
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+	if (bypass)
+		reg |= (1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
+	else
+		reg &= ~(1 << CQSPI_REG_READCAPTURE_BYPASS_LSB);
+
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		<< CQSPI_REG_READCAPTURE_DELAY_LSB);
+	reg |= ((delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+		<< CQSPI_REG_READCAPTURE_DELAY_LSB);
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+
+	cqspi_controller_enable(reg_base, 1);
+}
+
+static void cqspi_config_baudrate_div(void __iomem *reg_base, u32 ref_clk_hz,
+				      u32 sclk)
+{
+	unsigned int reg, div;
+
+	/* Recalculate the baudrate divisor based on QSPI specification. */
+	div = DIV_ROUND_UP(ref_clk_hz, 2 * sclk) - 1;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
+	div = (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+}
+
+static void cqspi_chip_select(void __iomem *reg_base, u32 chip_select,
+			      u32 decoder_en)
+{
+	unsigned int reg;
+
+	cqspi_controller_enable(reg_base, 0);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	/* decoders */
+	if (decoder_en) {
+		reg |= CQSPI_REG_CONFIG_DECODE_MASK;
+	} else {
+		reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
+
+		/* Convert CS if without decoder.
+		 * CS0 to 4b'1110
+		 * CS1 to 4b'1101
+		 * CS2 to 4b'1011
+		 * CS3 to 4b'0111
+		 */
+		chip_select = 0xF & ~(1 << chip_select);
+	}
+	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
+			<< CQSPI_REG_CONFIG_CHIPSELECT_LSB);
+	reg |= (chip_select & CQSPI_REG_CONFIG_CHIPSELECT_MASK)
+			<< CQSPI_REG_CONFIG_CHIPSELECT_LSB;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+	cqspi_controller_enable(reg_base, 1);
+}
+
+static int cqspi_exec_flash_cmd(struct struct_cqspi *cqspi, unsigned int reg)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	void __iomem *reg_base = cqspi->iobase;
+	int ret;
+
+	/* Write the CMDCTRL without start execution. */
+	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
+	/* Start execute */
+	reg |= CQSPI_REG_CMDCTRL_EXECUTE_MASK;
+	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
+
+	/* Polling for completion. */
+	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_CMDCTRL,
+				 CQSPI_REG_CMDCTRL_INPROGRESS_MASK, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Flash command execution timed out.\n");
+		return ret;
+	}
+	/* Polling QSPI idle status. */
+	return cqspi_wait_idle(cqspi);
+}
+
+static int cqspi_command_read(struct struct_cqspi *cqspi,
+			      const struct spi_mem_op *op)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	void __iomem *reg_base = cqspi->iobase;
+	size_t rxlen = op->data.nbytes;
+	void *rxbuf = op->data.buf.in;
+	size_t addrlen = op->addr.nbytes;
+	const u8 *addrbuf = (u8 *)op->addr.val;
+	u32 addr_value, read_len, reg;
+	int ret;
+
+	if (rxlen > CQSPI_STIG_DATA_LEN_MAX || !rxbuf) {
+		dev_err(&pdev->dev, "QSPI: rxlen is invalid %zu\n", rxlen);
+		return -EINVAL;
+	}
+
+	reg = op->cmd.opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
+	reg |= BIT(CQSPI_REG_CMDCTRL_RD_EN_LSB);
+
+	if (addrlen) {
+		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
+		reg |= ((addrlen - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
+			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
+		addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
+		writel(addr_value, reg_base + CQSPI_REG_CMDADDRESS);
+	}
+	/* 0 means 1 byte. */
+	reg |= (((rxlen - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
+		<< CQSPI_REG_CMDCTRL_RD_BYTES_LSB);
+	ret = cqspi_exec_flash_cmd(cqspi, reg);
+	if (ret != 0)
+		return ret;
+
+	reg = readl(reg_base + CQSPI_REG_CMDREADDATALOWER);
+
+	/* Put the read value into rx_buf */
+	read_len = (rxlen > 4) ? 4 : rxlen;
+	memcpy(rxbuf, &reg, read_len);
+	rxbuf += read_len;
+
+	if (rxlen > 4) {
+		reg = readl(reg_base + CQSPI_REG_CMDREADDATAUPPER);
+		read_len = rxlen - read_len;
+		memcpy(rxbuf, &reg, read_len);
+	}
+
+	return 0;
+}
+
+static int cqspi_command_write(struct struct_cqspi *cqspi,
+			       const struct spi_mem_op *op)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	void __iomem *reg_base = cqspi->iobase;
+	size_t txlen = sizeof(op->cmd.opcode);
+	const u8 *databuf = op->data.buf.out;
+	size_t datalen = op->data.nbytes;
+	const u8 *addrbuf = (u8 *)op->addr.val;
+	size_t addrlen = op->addr.nbytes;
+	unsigned int addr_value, reg, data = 0;
+
+	if (txlen > CQSPI_STIG_DATA_LEN_MAX) {
+		dev_err(&pdev->dev, "QSPI: txlen is invalid %zu\n", txlen);
+		return -EINVAL;
+	}
+
+	reg = op->cmd.opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
+
+	if (datalen != 0) {
+		reg |= BIT(CQSPI_REG_CMDCTRL_WR_EN_LSB);
+		reg |= ((datalen - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
+			<< CQSPI_REG_CMDCTRL_WR_BYTES_LSB;
+		memcpy(&data, databuf, datalen);
+		writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
+	}
+
+	if (addrlen) {
+		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
+		reg |= ((addrlen - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
+			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
+		addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
+		writel(addr_value, reg_base + CQSPI_REG_CMDADDRESS);
+	}
+
+	return cqspi_exec_flash_cmd(cqspi, reg);
+}
+
+static int cqspi_apb_read_setup(struct struct_cqspi *cqspi,
+				const struct spi_mem_op *op,
+				const u8 *addrbuf)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	size_t addrlen = op->addr.nbytes;
+	size_t dummy_bytes = op->dummy.nbytes;
+	unsigned int addr_value, dummy_clk, reg;
+
+	if (addrlen) {
+		addr_value = cqspi_cmd2addr(&addrbuf[0], addrlen);
+		writel(addr_value, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
+	}
+
+	reg = op->cmd.opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
+	reg |= (op->data.buswidth & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK) <<
+		CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
+
+	if (dummy_bytes) {
+		if (dummy_bytes > CQSPI_DUMMY_BYTES_MAX)
+			dummy_bytes = CQSPI_DUMMY_BYTES_MAX;
+
+		reg |= BIT(CQSPI_REG_RD_INSTR_MODE_EN_LSB);
+
+		writel(0xFF, reg_base + CQSPI_REG_MODE_BIT);
+
+		dummy_clk = dummy_bytes * CQSPI_DUMMY_CLKS_PER_BYTE;
+		dummy_clk -= CQSPI_DUMMY_CLKS_PER_BYTE;
+
+		if (dummy_clk)
+			reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
+				<< CQSPI_REG_RD_INSTR_DUMMY_LSB;
+	}
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	/* Set device size */
+	reg = readl(reg_base + CQSPI_REG_SIZE);
+	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
+	reg |= (addrlen - 1);
+	writel(reg, reg_base + CQSPI_REG_SIZE);
+
+	/* disable auto-polling */
+	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	reg |= BIT(CQSPI_REG_WR_COMPLETION_DIS_POLLING_FLD_POS);
+	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+
+	return 0;
+}
+
+static int cqspi_read_execute(struct struct_cqspi *cqspi,
+			      const struct spi_mem_op *op, u8 *rxbuf)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	void *reg_base = cqspi->iobase;
+	void *ahb_base = cqspi->qspi_ahb_virt;
+	u32 rxlen = op->data.nbytes;
+	u8 *rxbuf_end = rxbuf + rxlen;
+	u32 mod_bytes = rxlen % 4;
+	u32 bytes_to_read = 0;
+	int remaining = op->data.nbytes;
+	unsigned long timeout;
+	int ret;
+
+	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
+
+	mb();/* flush previous writes */
+
+	writel(pdata->fifo_depth - CQSPI_REG_SRAM_RESV_WORDS,
+	       reg_base + CQSPI_REG_SRAMPARTITION);
+	/* Clear all interrupts. */
+	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
+	writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
+
+	reinit_completion(&cqspi->transfer_complete);
+	writel(CQSPI_REG_INDIRECTRD_START_MASK,
+	       reg_base + CQSPI_REG_INDIRECTRD);
+
+	timeout = msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS);
+	while (remaining > 0) {
+		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
+						 timeout))
+		ret = -ETIMEDOUT;
+
+		bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
+
+		while (bytes_to_read != 0) {
+			unsigned int word_remain = round_down(remaining, 4);
+
+			bytes_to_read *= CQSPI_FIFO_WIDTH;
+			bytes_to_read = bytes_to_read > remaining ?
+						remaining : bytes_to_read;
+			bytes_to_read = round_down(bytes_to_read, 4);
+			if (bytes_to_read) {
+				ioread32_rep(ahb_base, rxbuf,
+					     (bytes_to_read / 4));
+			} else if (!word_remain && mod_bytes) {
+				unsigned int temp = ioread32(ahb_base);
+
+				bytes_to_read = mod_bytes;
+				memcpy(rxbuf, &temp, min((unsigned int)
+				       (rxbuf_end - rxbuf), bytes_to_read));
+			}
+
+			rxbuf += bytes_to_read;
+			remaining -= bytes_to_read;
+			bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
+		}
+
+		if (remaining < 0)
+			reinit_completion(&cqspi->transfer_complete);
+	}
+
+	/* Check indirect done status */
+	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTRD,
+				 CQSPI_REG_INDIRECTRD_DONE_MASK, 0);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Indirect read completion error (%i)\n", ret);
+		goto failrd;
+	}
+
+	/* Disable interrupt */
+	writel(0, reg_base + CQSPI_REG_IRQMASK);
+	/* Clear indirect completion status */
+	writel(CQSPI_REG_INDIRECTRD_DONE_MASK, reg_base + CQSPI_REG_INDIRECTRD);
+
+	return 0;
+failrd:
+	/* Disable interrupt */
+	writel(0, reg_base + CQSPI_REG_IRQMASK);
+	/* Cancel the indirect read */
+	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
+	       reg_base + CQSPI_REG_INDIRECTRD);
+	return ret;
+}
+
+static int cqspi_apb_write_setup(struct struct_cqspi *cqspi,
+				 const struct spi_mem_op *op, const u8 *addrbuf)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	void __iomem *reg_base = cqspi->iobase;
+	size_t addrlen = op->addr.nbytes;
+	const u8 *txbuf = &op->cmd.opcode;
+	unsigned int reg;
+
+	if (!txbuf) {
+		dev_err(&pdev->dev, "QSPI: Invalid input txbuf\n");
+		return -EINVAL;
+	}
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_DIRECT_MASK);
+	reg &= ~(CQSPI_REG_CONFIG_DMA_MASK);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	/* Set opcode. */
+	reg = txbuf[0] << CQSPI_REG_WR_INSTR_OPCODE_LSB;
+	reg |= BIT(CQSPI_REG_WR_CONFIG_WEL_DIS_FLD_POS);
+	/* Configure the mode for address */
+	reg |= (op->addr.buswidth & CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK) <<
+		CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
+
+	/* Configure the mode for data */
+	reg |= (op->data.buswidth & CQSPI_REG_WR_INSTR_TYPE_DATA_MASK) <<
+		CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
+	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
+	/* Setup write address. */
+	reg = cqspi_cmd2addr(&addrbuf[0], addrlen);
+	writel(reg, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
+	reg = readl(reg_base + CQSPI_REG_SIZE);
+	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
+	reg |= ((addrlen - 1) & CQSPI_REG_SIZE_ADDRESS_MASK);
+	writel(reg, reg_base +  CQSPI_REG_SIZE);
+
+	/* disable auto-polling */
+	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	reg |= BIT(CQSPI_REG_WR_COMPLETION_DIS_POLLING_FLD_POS);
+	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+
+	return 0;
+}
+
+static int cqspi_write_execute(struct struct_cqspi *cqspi,
+			       const struct spi_mem_op *op, const u8 *txbuf)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata =
+			&pdata->f_pdata[cqspi->current_cs];
+	void *reg_base = cqspi->iobase;
+	void *ahb_base = cqspi->qspi_ahb_virt;
+	u32 page_size = f_pdata->page_size;
+	u32 write_bytes, reg = 0;
+	int remaining = op->data.nbytes;
+	unsigned long timeout;
+	int ret;
+
+	writel(0xa, reg_base + CQSPI_INDIRECT_TRIGGER_ADDR_RANGE_REG);
+	writel(0x0, reg_base + CQSPI_REG_INDIRECTWRWATERMARK);
+	reg = readl(reg_base + CQSPI_REG_SIZE);
+	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
+	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
+	reg |= (f_pdata->page_size << CQSPI_REG_SIZE_PAGE_LSB);
+	reg |= (f_pdata->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
+	writel(reg, reg_base +  CQSPI_REG_SIZE);
+
+	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
+	writel(CQSPI_REG_SRAM_PARTITION_WR, reg_base + CQSPI_REG_SRAMPARTITION);
+	/* Clear all interrupts. */
+	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
+	writel(CQSPI_IRQ_MASK_WR, reg_base + CQSPI_REG_IRQMASK);
+	reinit_completion(&cqspi->transfer_complete);
+	writel(CQSPI_REG_INDIRECTWR_START_MASK,
+	       reg_base + CQSPI_REG_INDIRECTWR);
+
+	if (cqspi->wr_delay)
+		ndelay(cqspi->wr_delay);
+
+	timeout = msecs_to_jiffies(CQSPI_TIMEOUT_MS);
+	while (remaining > 0) {
+		size_t write_words, mod_bytes;
+
+		write_bytes = remaining > page_size ? page_size : remaining;
+		write_words = write_bytes / 4;
+		mod_bytes = write_bytes % 4;
+
+		if (write_words) {
+			iowrite32_rep(ahb_base, txbuf, write_words);
+			txbuf += (write_words * 4);
+		}
+		if (mod_bytes) {
+			unsigned int temp = 0xFFFFFFFF;
+
+			memcpy(&temp, txbuf, mod_bytes);
+			iowrite32(temp, ahb_base);
+			txbuf += mod_bytes;
+		}
+		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
+						 timeout)) {
+			dev_err(&pdev->dev, "Indirect write timeout\n");
+			ret = -ETIMEDOUT;
+			goto failwr;
+		}
+		remaining -= write_bytes;
+		if (remaining < 0)
+			reinit_completion(&cqspi->transfer_complete);
+	}
+
+	/* Check indirect done status */
+	ret = cqspi_wait_for_bit(reg_base + CQSPI_REG_INDIRECTWR,
+				 CQSPI_REG_INDIRECTWR_DONE_MASK, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "Indirect write completion error.\n");
+		goto failwr;
+	}
+
+	return 0;
+
+failwr:
+	/* Disable interrupt. */
+	writel(0, reg_base + CQSPI_REG_IRQMASK);
+	/* Clear indirect completion status */
+	writel(CQSPI_REG_INDIRECTWR_DONE_MASK, reg_base + CQSPI_REG_INDIRECTWR);
+
+	/* Cancel the indirect write */
+	if (ret)
+		writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
+		       reg_base + CQSPI_REG_INDIRECTWR);
+
+	return ret;
+}
+
+static void cqspi_controller_init(struct struct_cqspi *cqspi)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+
+	cqspi_controller_enable(cqspi->iobase, 0);
+
+	/* Configure the remap address register, no remap */
+	writel(0, cqspi->iobase + CQSPI_REG_REMAP);
+
+	/* Disable all interrupts. */
+	writel(0, cqspi->iobase + CQSPI_REG_IRQMASK);
+
+	/* Load indirect trigger address. */
+	writel(pdata->trigger_address,
+	       cqspi->iobase + CQSPI_REG_INDIRECTTRIGGER);
+
+	/* Enable Direct Access Controller */
+	if (cqspi->use_dac_mode)
+		cqspi_direct_access_enable(cqspi, 1);
+
+	cqspi_controller_enable(cqspi->iobase, 1);
+}
+
+static u32 cqspi_calculate_ticks_for_ns(u32 ref_clk_hz, u32 ns_val)
+{
+	unsigned int ticks;
+
+	ticks = ref_clk_hz / 1000;      /* kHz */
+	ticks = DIV_ROUND_UP(ticks * ns_val, 1000000);
+
+	return ticks;
+}
+
+static void cqspi_delay(struct struct_cqspi *cqspi, u32 ref_clk, u32 sclk_hz)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata = &pdata->f_pdata[cqspi->current_cs];
+	void __iomem *iobase = cqspi->iobase;
+	const unsigned int ref_clk_hz = pdata->master_ref_clk_hz;
+	unsigned int tchsh, tshsl, tslch, tsd2d;
+	unsigned int reg;
+	unsigned int tsclk;
+
+	cqspi_controller_enable(cqspi->iobase, 0);
+	/* calculate the number of ref ticks for one sclk tick */
+	tsclk = DIV_ROUND_UP(ref_clk_hz, sclk_hz);
+
+	/* The controller adds additional delay to that programmed in the reg */
+	if (f_pdata->tshsl_ns < tsclk)
+		tshsl = tsclk;
+
+	tchsh = cqspi_calculate_ticks_for_ns(ref_clk_hz, f_pdata->tchsh_ns);
+	tslch = cqspi_calculate_ticks_for_ns(ref_clk_hz, f_pdata->tslch_ns);
+	tsd2d = cqspi_calculate_ticks_for_ns(ref_clk_hz, f_pdata->tsd2d_ns);
+	tshsl = cqspi_calculate_ticks_for_ns(ref_clk_hz, f_pdata->tshsl_ns);
+
+	reg = ((tshsl & CQSPI_REG_DELAY_TSHSL_MASK)
+			<< CQSPI_REG_DELAY_TSHSL_LSB);
+	reg |= ((tchsh & CQSPI_REG_DELAY_TCHSH_MASK)
+			<< CQSPI_REG_DELAY_TCHSH_LSB);
+	reg |= ((tslch & CQSPI_REG_DELAY_TSLCH_MASK)
+			<< CQSPI_REG_DELAY_TSLCH_LSB);
+	reg |= ((tsd2d & CQSPI_REG_DELAY_TSD2D_MASK)
+			<< CQSPI_REG_DELAY_TSD2D_LSB);
+	writel(reg, iobase + CQSPI_REG_DELAY);
+	cqspi_controller_enable(cqspi->iobase, 1);
+}
+
+static void cqspi_switch_chipselect(struct struct_cqspi *cqspi, u32 cs)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata = &pdata->f_pdata[cs];
+	void __iomem *iobase = cqspi->iobase;
+	unsigned int reg;
+
+	cqspi_controller_enable(cqspi->iobase, 0);
+	/* Configure page size and block size. */
+	reg = readl(iobase + CQSPI_REG_SIZE);
+	/* clear the previous value */
+	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
+	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
+	reg |= (f_pdata->page_size << CQSPI_REG_SIZE_PAGE_LSB);
+	reg |= (f_pdata->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
+	writel(reg, iobase + CQSPI_REG_SIZE);
+	/* configure the chip select */
+	cqspi_chip_select(iobase, cs, pdata->ext_decoder);
+	cqspi_controller_enable(cqspi->iobase, 1);
+}
+
+static int cqspi_apb_read_execute(struct struct_cqspi *cqspi,
+				  const struct spi_mem_op *op, u8 *rxbuf)
+{
+	u32 from = op->addr.val;
+	void *buf = op->data.buf.in;
+	size_t len = op->data.nbytes;
+
+	if (cqspi->use_dac_mode && (from + len < cqspi->ahb_size)) {
+		memcpy_fromio(buf, cqspi->ahbbase + from, len);
+		if (!cqspi_wait_idle(cqspi))
+			return -EIO;
+		return 0;
+	}
+
+	return cqspi_read_execute(cqspi, op, rxbuf);
+}
+
+static int cqspi_apb_write_execute(struct struct_cqspi *cqspi,
+				   const struct spi_mem_op *op, const u8 *txbuf)
+{
+	u32 to = op->addr.val;
+	const void *buf = op->data.buf.out;
+	size_t len = op->data.nbytes;
+
+	if (cqspi->use_dac_mode && (to + len < cqspi->ahb_size)) {
+		memcpy_toio(cqspi->ahbbase + to, buf, len);
+		if (!cqspi_wait_idle(cqspi))
+			return -EIO;
+		return 0;
+	}
+
+	return cqspi_write_execute(cqspi, op, txbuf);
+}
+
+static int cqspi_mem_process(struct struct_cqspi *cqspi, struct spi_mem *mem,
+			     const struct spi_mem_op *op)
+{
+	struct platform_device *pdev = cqspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	unsigned int tmpbufsize, n_trans = 0, totalxferlen = 0;
+	void __iomem *iobase = cqspi->iobase;
+	struct spi_mem_op_cadence ops[4] = { };
+	struct spi_mem_op_cadence *addr_ops = NULL;
+	struct cqspi_flash_pdata *f_pdata;
+	int mode, err;
+	u8 *tmpbuf;
+	u32 sclk;
+
+	if (cqspi->current_cs != mem->spi->chip_select) {
+		cqspi->current_cs = mem->spi->chip_select;
+		cqspi_switch_chipselect(cqspi, mem->spi->chip_select);
+	}
+
+	f_pdata = &pdata->f_pdata[cqspi->current_cs];
+
+	tmpbufsize = sizeof(op->cmd.opcode) + op->addr.nbytes +
+			op->dummy.nbytes;
+
+	tmpbuf = kzalloc(tmpbufsize, GFP_KERNEL | GFP_DMA);
+	if (!tmpbuf)
+		return -ENOMEM;
+
+	tmpbuf[0] = op->cmd.opcode;
+	ops[n_trans].tx_buf = tmpbuf;
+	ops[n_trans].len = sizeof(op->cmd.opcode);
+	ops[n_trans].tx_nbits = op->cmd.buswidth;
+
+	n_trans++;
+	totalxferlen++;
+
+	if (op->addr.nbytes) {
+		int i;
+
+		for (i = 0; i < op->addr.nbytes; i++)
+			tmpbuf[i + 1] = op->addr.val >>
+					(8 * (op->addr.nbytes - i - 1));
+
+		ops[n_trans].tx_buf = tmpbuf + 1;
+		ops[n_trans].len = op->addr.nbytes;
+		ops[n_trans].tx_nbits = op->addr.buswidth;
+
+		n_trans++;
+		totalxferlen += op->addr.nbytes;
+	}
+
+	if (op->dummy.nbytes)
+		n_trans++;
+
+	if (op->data.nbytes)
+		n_trans++;
+
+	if (n_trans == 3 || n_trans == 4)
+		addr_ops = &ops[1];
+
+	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
+		if (!op->addr.nbytes)
+			mode = CQSPI_STIG_READ;
+		else
+			mode = CQSPI_READ;
+	} else {
+		if (!op->addr.nbytes || !op->data.buf.out)
+			mode = CQSPI_STIG_WRITE;
+		else
+			mode = CQSPI_WRITE;
+	}
+
+	sclk = mem->spi->max_speed_hz;
+	cqspi_controller_enable(iobase, 0);
+	cqspi_config_baudrate_div(iobase, pdata->master_ref_clk_hz, sclk);
+	cqspi_delay(cqspi, pdata->master_ref_clk_hz, sclk);
+	cqspi_readdata_capture(iobase, 1, f_pdata->read_delay);
+	cqspi_controller_enable(iobase, 1);
+
+	/* execute transfer */
+	switch (mode) {
+	case CQSPI_STIG_WRITE:
+		err = cqspi_command_write(cqspi, op);
+		if (err) {
+			dev_err(&pdev->dev, "QSPI: Command Write failed!.\n");
+			return err;
+		}
+		break;
+	case CQSPI_STIG_READ:
+		err = cqspi_command_read(cqspi, op);
+		if (err) {
+			dev_err(&pdev->dev, "QSPI: Command Read failed!.\n");
+			return err;
+		}
+		break;
+	case CQSPI_WRITE:
+		err = cqspi_apb_write_setup(cqspi, op, addr_ops->tx_buf);
+		err = cqspi_apb_write_execute(cqspi, op, op->data.buf.out);
+		if (err) {
+			dev_err(&pdev->dev, "QSPI: Write Execution failed!.\n");
+			return err;
+		}
+		break;
+	case CQSPI_READ:
+		err = cqspi_apb_read_setup(cqspi, op, addr_ops->tx_buf);
+		err = cqspi_apb_read_execute(cqspi, op, op->data.buf.in);
+		if (err) {
+			dev_err(&pdev->dev, "QSPI: Read Execution failed!.\n");
+			return err;
+		}
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported mode %u\n", mode);
+		return -EINVAL;
+	}
+
+	return err;
+}
+
+int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct struct_cqspi *cqspi = spi_master_get_devdata(mem->spi->master);
+	int ret;
+
+	mutex_lock(&cqspi->lock);
+	ret = cqspi_mem_process(cqspi, mem, op);
+	if (ret)
+		dev_err(&mem->spi->dev, "QSPI: qspi transfer failed!!!.\n");
+	mutex_unlock(&cqspi->lock);
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops cqspi_mem_ops = {
+	.exec_op = cqspi_exec_mem_op,
+};
+
+static int cqspi_setup(struct spi_device *spi)
+{
+	if (spi->chip_select > spi->master->num_chipselect) {
+		dev_err(&spi->dev, "QSPI: chip_select is out of range\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cqspi_of_get_flash_pdata(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *nc;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata;
+	u32 prop, cs;
+
+	/* Get flash devices platform data */
+	for_each_child_of_node(np, nc) {
+		if (!of_device_is_available(nc))
+			continue;
+
+		if (of_property_read_u32(nc, "reg", &cs)) {
+			dev_err(&pdev->dev, "couldn't determine reg\n");
+			return -ENXIO;
+		}
+		f_pdata = &pdata->f_pdata[cs];
+
+		if (of_property_read_u32(nc, "cdns,read-delay", &prop)) {
+			dev_err(&pdev->dev, "couldn't determine read-delay\n");
+			return -ENXIO;
+		}
+		f_pdata->read_delay = prop;
+
+		if (of_property_read_u32(nc, "cdns,tshsl-ns", &prop)) {
+			dev_err(&pdev->dev, "couldn't determine tshsl-ns\n");
+			return -ENXIO;
+		}
+		f_pdata->tshsl_ns = prop;
+
+		if (of_property_read_u32(nc, "cdns,tsd2d-ns", &prop)) {
+			dev_err(&pdev->dev, "couldn't determine tsd2d-ns\n");
+			return -ENXIO;
+		}
+		f_pdata->tsd2d_ns = prop;
+
+		if (of_property_read_u32(nc, "cdns,tchsh-ns", &prop)) {
+			dev_err(&pdev->dev, "couldn't determine tchsh-ns\n");
+			return -ENXIO;
+		}
+		f_pdata->tchsh_ns = prop;
+
+		if (of_property_read_u32(nc, "cdns,tslch-ns", &prop)) {
+			dev_err(&pdev->dev, "couldn't determine tslch-ns\n");
+			return -ENXIO;
+		}
+		f_pdata->tslch_ns = prop;
+
+		if (of_property_read_u32(nc, "page-size", &prop)) {
+			dev_err(&pdev->dev, "couldn't determine page-size\n");
+			return -ENXIO;
+		}
+		f_pdata->page_size = prop;
+
+		if (of_property_read_u32(nc, "block-size", &prop)) {
+			dev_err(&pdev->dev, "couldn't determine block-size\n");
+			return -ENXIO;
+		}
+		f_pdata->block_size = prop;
+	}
+	return 0;
+}
+
+static int cqspi_of_get_pdata(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	unsigned int prop;
+	int ret;
+
+	pdata->is_decoded_cs = of_property_read_bool(np, "cdns,is-decoded-cs");
+
+	if (of_property_read_u32(np, "cdns,fifo-depth", &prop)) {
+		dev_err(&pdev->dev, "couldn't determine fifo-depth\n");
+		return -ENXIO;
+	}
+	pdata->fifo_depth = prop;
+
+	if (of_property_read_u32(np, "cdns,fifo-width", &prop)) {
+		dev_err(&pdev->dev, "couldn't determine fifo-width\n");
+		return -ENXIO;
+	}
+	pdata->fifo_width = prop;
+
+	if (of_property_read_u32(np, "cdns,trigger-address", &prop)) {
+		dev_err(&pdev->dev, "couldn't determine trigger-address\n");
+		return -ENXIO;
+	}
+	pdata->trigger_address = prop;
+
+	pdata->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
+
+	ret = cqspi_of_get_flash_pdata(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Get flash data failed.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int cqspi_probe(struct platform_device *pdev)
+{
+	struct cqspi_platform_data *pdata;
+	struct device *dev = &pdev->dev;
+	struct struct_cqspi *cqspi;
+	struct spi_master *master;
+	struct reset_control *rstc, *rstc_ocp;
+	const struct cqspi_driver_platdata *ddata;
+	struct resource *res = NULL;
+	int ret;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*cqspi));
+	if (!master) {
+		dev_err(&pdev->dev, "spi_alloc_master failed\n");
+		return -ENOMEM;
+	}
+	master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL |
+				SPI_RX_OCTAL;
+	master->setup = cqspi_setup;
+	master->mem_ops = &cqspi_mem_ops;
+	master->dev.of_node = pdev->dev.of_node;
+	cqspi = spi_master_get_devdata(master);
+	cqspi->pdev = pdev;
+
+	pdata = devm_kmalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		ret = -ENOMEM;
+
+	pdev->dev.platform_data = pdata;
+
+	/* Obtain QSPI clock. */
+	cqspi->clk = devm_clk_get(&pdev->dev, "qspi");
+	if (IS_ERR(cqspi->clk)) {
+		dev_err(&pdev->dev, "cannot get qspi clk\n");
+		return PTR_ERR(cqspi->clk);
+	}
+	pdata->master_ref_clk_hz = clk_get_rate(cqspi->clk);
+
+	ret = clk_prepare_enable(cqspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to enable qspi clock: %d\n", ret);
+		return ret;
+	}
+
+	/* Obtain configuration from OF. */
+	ret = cqspi_of_get_pdata(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "Get platform data failed.\n");
+		return -ENODEV;
+	}
+
+	cqspi->res = res;
+	/* Obtain and remap controller address. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cqspi->iobase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(cqspi->iobase)) {
+		dev_err(dev, "Cannot remap controller address.\n");
+		return PTR_ERR(cqspi->iobase);
+	}
+
+	/* Obtain and remap AHB address. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cqspi->qspi_ahb_virt = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cqspi->qspi_ahb_virt)) {
+		dev_err(dev, "Cannot remap AHB address.\n");
+		return PTR_ERR(cqspi->qspi_ahb_virt);
+	}
+	cqspi->ahbbase = res;
+	cqspi->ahb_size = resource_size(res);
+
+	/* Obtain QSPI reset control */
+	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
+	if (IS_ERR(rstc)) {
+		dev_err(dev, "Cannot get QSPI reset.\n");
+		return PTR_ERR(rstc);
+	}
+
+	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
+	if (IS_ERR(rstc_ocp)) {
+		dev_err(dev, "Cannot get QSPI OCP reset.\n");
+		return PTR_ERR(rstc_ocp);
+	}
+
+	reset_control_assert(rstc);
+	reset_control_deassert(rstc);
+
+	reset_control_assert(rstc_ocp);
+	reset_control_deassert(rstc_ocp);
+
+	ddata  = of_device_get_match_data(dev);
+	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
+		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
+						   pdata->master_ref_clk_hz);
+
+	if (ddata && (ddata->quirks & CQSPI_DISABLE_DAC_MODE))
+		cqspi->use_dac_mode = false;
+
+	init_completion(&cqspi->transfer_complete);
+
+	/* Obtain IRQ line. */
+	cqspi->irq = platform_get_irq(pdev, 0);
+	if (cqspi->irq < 0) {
+		dev_err(dev, "platform_get_irq failed.\n");
+		ret = -ENXIO;
+	}
+	ret = devm_request_irq(dev, cqspi->irq, cqspi_irq_handler, 0,
+			       pdev->name, cqspi);
+	if (ret) {
+		dev_err(dev, "request_irq failed.\n");
+		goto out_clk_disable;
+	}
+
+	master->bus_num = pdata->bus_num;
+	master->num_chipselect = pdata->num_chipselect;
+	mutex_init(&cqspi->lock);
+	platform_set_drvdata(pdev, master);
+	cqspi_controller_init(cqspi);
+	cqspi->current_cs = -1;
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret) {
+		dev_err(&pdev->dev, "devm_spi_register_master failed.\n");
+		goto err_of;
+	}
+
+	return 0;
+
+out_clk_disable:
+	clk_disable_unprepare(cqspi->clk);
+err_of:
+	spi_master_put(master);
+	dev_err(&pdev->dev, "Cadence QSPI controller probe failed\n");
+	return ret;
+}
+
+static int cqspi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct struct_cqspi *cadence_qspi = spi_master_get_devdata(master);
+
+	cqspi_controller_enable(cadence_qspi->iobase, 0);
+	return 0;
+}
+
+static const struct cqspi_driver_platdata k2g_qspi = {
+	.quirks = CQSPI_NEEDS_WR_DELAY,
+};
+
+static const struct cqspi_driver_platdata am654_ospi = {
+	.quirks = CQSPI_NEEDS_WR_DELAY,
+};
+
+static const struct cqspi_driver_platdata intel_lgm_qspi = {
+	.quirks = CQSPI_DISABLE_DAC_MODE,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id cqspi_of_match[] = {
+	{
+		.compatible = "cdns,qspi-nor",
+	},
+	{
+		.compatible = "ti,k2g-qspi",
+		.data = &k2g_qspi,
+	},
+	{
+		.compatible = "ti,am654-ospi",
+		.data = &am654_ospi,
+	},
+	{
+		.compatible = "intel,lgm-qspi",
+		.data = &intel_lgm_qspi,
+	},
+	{ /* end of table */}
+};
+MODULE_DEVICE_TABLE(of, cqspi_of_match);
+#else
+#define cqspi_of_match NULL
+#endif /* CONFIG_OF */
+
+static struct platform_driver cqspi_platform_driver = {
+	.probe          = cqspi_probe,
+	.remove         = cqspi_remove,
+	.driver = {
+		.name   = CADENCE_QSPI_NAME,
+		.of_match_table = cqspi_of_match,
+	},
+};
+
+module_platform_driver(cqspi_platform_driver);
+
+MODULE_DESCRIPTION("Cadence QSPI Controller Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" CADENCE_QSPI_NAME);
+MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
+MODULE_AUTHOR("Graham Moore <grmoore@opensource.altera.com>");
+MODULE_AUTHOR("Vadivel Murugan R <vadivel.muruganx.ramuthevar@intel.com>");
diff --git a/drivers/spi/spi-cadence-quadspi.h b/drivers/spi/spi-cadence-quadspi.h
new file mode 100644
index 000000000000..ce4d872d1c52
--- /dev/null
+++ b/drivers/spi/spi-cadence-quadspi.h
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Cadence QSPI Controller
+ *
+ * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
+ * Copyright Intel Corporation (C) 2019-2020. All rights reserved.
+ */
+#ifndef __CADENCE_QSPI__H__
+#define __CADENCE_QSPI__H__
+#include <linux/reset.h>
+#include <linux/spi/spi-mem.h>
+
+#define CQSPI_MAX_CHIP_SELECT			(16)
+#define CQSPI_STIG_READ				1
+#define CQSPI_STIG_WRITE			2
+#define CQSPI_READ				3
+#define CQSPI_WRITE				4
+
+/* Operation timeout value */
+#define CQSPI_TIMEOUT_MS			5000
+#define CQSPI_READ_TIMEOUT_MS			10
+#define CQSPI_POLL_IDLE_RETRY			3
+#define CQSPI_FIFO_WIDTH			4
+
+/* Controller sram size in word */
+#define CQSPI_REG_SRAM_RESV_WORDS		2
+#define CQSPI_REG_SRAM_PARTITION_WR		1
+#define CQSPI_REG_SRAM_THRESHOLD_BYTES		50
+
+/* Instruction type */
+#define CQSPI_INST_TYPE_SINGLE			0
+#define CQSPI_INST_TYPE_DUAL			1
+#define CQSPI_INST_TYPE_QUAD			2
+#define CQSPI_DUMMY_CLKS_PER_BYTE		8
+#define CQSPI_DUMMY_BYTES_MAX			4
+#define CQSPI_STIG_DATA_LEN_MAX			8
+#define CQSPI_INDIRECTTRIGGER_ADDR_MASK		0xFFFFF
+
+/* Register map */
+#define	CQSPI_REG_CONFIG			0x00
+#define	CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
+#define	CQSPI_REG_CONFIG_DIRECT_MASK		BIT(7)
+#define	CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
+#define	CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
+#define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
+#define	CQSPI_REG_CONFIG_BAUD_LSB		19
+#define	CQSPI_REG_CONFIG_IDLE_LSB		31
+#define	CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
+#define	CQSPI_REG_CONFIG_BAUD_MASK		0xF
+#define	CQSPI_REG_RD_INSTR			0x04
+#define	CQSPI_REG_RD_INSTR_OPCODE_LSB		0
+#define	CQSPI_REG_RD_INSTR_TYPE_INSTR_LSB	8
+#define	CQSPI_REG_RD_INSTR_TYPE_ADDR_LSB	12
+#define	CQSPI_REG_RD_INSTR_TYPE_DATA_LSB	16
+#define	CQSPI_REG_RD_INSTR_MODE_EN_LSB		20
+#define	CQSPI_REG_RD_INSTR_DUMMY_LSB		24
+#define	CQSPI_REG_RD_INSTR_TYPE_INSTR_MASK	0x3
+#define	CQSPI_REG_RD_INSTR_TYPE_ADDR_MASK	0x3
+#define	CQSPI_REG_RD_INSTR_TYPE_DATA_MASK	0x3
+#define	CQSPI_REG_RD_INSTR_DUMMY_MASK		0x1F
+#define	CQSPI_REG_WR_INSTR			0x08
+#define	CQSPI_REG_WR_INSTR_OPCODE_LSB		0
+#define	CQSPI_REG_WR_INSTR_TYPE_DATA_MASK	0x3
+#define	CQSPI_REG_WR_INSTR_TYPE_DATA_LSB	16
+#define	CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK	0x3
+#define	CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB	12
+
+/*! Field WEL_DIS_FLD - wel_dis_fld */
+#define CQSPI_REG_WR_CONFIG_WEL_DIS_FLD_POS	8
+#define CQSPI_REG_WR_COMPLETION_CTRL		0x38
+#define CQSPI_REG_WR_COMPLETION_DIS_POLLING_FLD_POS	14
+
+#define	CQSPI_REG_DELAY				0x0C
+#define	CQSPI_REG_DELAY_TSLCH_LSB		0
+#define	CQSPI_REG_DELAY_TCHSH_LSB		8
+#define	CQSPI_REG_DELAY_TSD2D_LSB		16
+#define	CQSPI_REG_DELAY_TSHSL_LSB		24
+#define	CQSPI_REG_DELAY_TSLCH_MASK		0xFF
+#define	CQSPI_REG_DELAY_TCHSH_MASK		0xFF
+#define	CQSPI_REG_DELAY_TSD2D_MASK		0xFF
+#define	CQSPI_REG_DELAY_TSHSL_MASK		0xFF
+#define	CQSPI_REG_READCAPTURE			0x10
+#define	CQSPI_REG_READCAPTURE_BYPASS_LSB	0
+#define	CQSPI_REG_READCAPTURE_DELAY_LSB		1
+#define	CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define	CQSPI_REG_SIZE				0x14
+#define	CQSPI_REG_SIZE_ADDRESS_LSB		0
+#define	CQSPI_REG_SIZE_PAGE_LSB			4
+#define	CQSPI_REG_SIZE_BLOCK_LSB		16
+#define	CQSPI_REG_SIZE_ADDRESS_MASK		0xF
+#define	CQSPI_REG_SIZE_PAGE_MASK		0xFFF
+#define	CQSPI_REG_SIZE_BLOCK_MASK		0x3F
+#define	CQSPI_REG_SRAMPARTITION			0x18
+#define	CQSPI_REG_INDIRECTTRIGGER		0x1C
+#define	CQSPI_REG_DMA				0x20
+#define	CQSPI_REG_DMA_SINGLE_LSB		0
+#define	CQSPI_REG_DMA_BURST_LSB			8
+#define	CQSPI_REG_DMA_SINGLE_MASK		0xFF
+#define	CQSPI_REG_DMA_BURST_MASK		0xFF
+#define	CQSPI_REG_REMAP				0x24
+#define	CQSPI_REG_MODE_BIT			0x28
+#define	CQSPI_REG_SDRAMLEVEL			0x2C
+#define	CQSPI_REG_SDRAMLEVEL_RD_LSB		0
+#define	CQSPI_REG_SDRAMLEVEL_WR_LSB		16
+#define	CQSPI_REG_SDRAMLEVEL_RD_MASK		0xFFFF
+#define	CQSPI_REG_SDRAMLEVEL_WR_MASK		0xFFFF
+
+#define	CQSPI_REG_IRQSTATUS			0x40
+#define	CQSPI_REG_IRQMASK			0x44
+#define	CQSPI_REG_INDIRECTRD			0x60
+#define	CQSPI_REG_INDIRECTRD_START_MASK		BIT(0)
+#define	CQSPI_REG_INDIRECTRD_CANCEL_MASK	BIT(1)
+#define	CQSPI_REG_INDIRECTRD_DONE_MASK		BIT(5)
+#define	CQSPI_REG_INDIRECTRDWATERMARK		0x64
+#define	CQSPI_REG_INDIRECTRDSTARTADDR		0x68
+#define	CQSPI_REG_INDIRECTRDBYTES		0x6C
+#define CQSPI_INDIRECT_TRIGGER_ADDR_RANGE_REG	0x80
+#define	CQSPI_REG_CMDCTRL			0x90
+#define	CQSPI_REG_CMDCTRL_EXECUTE_MASK		BIT(0)
+#define	CQSPI_REG_CMDCTRL_INPROGRESS_MASK	BIT(1)
+#define	CQSPI_REG_CMDCTRL_WR_BYTES_LSB		12
+#define	CQSPI_REG_CMDCTRL_WR_EN_LSB		15
+#define	CQSPI_REG_CMDCTRL_ADD_BYTES_LSB		16
+#define	CQSPI_REG_CMDCTRL_ADDR_EN_LSB		19
+#define	CQSPI_REG_CMDCTRL_RD_BYTES_LSB		20
+#define	CQSPI_REG_CMDCTRL_RD_EN_LSB		23
+#define	CQSPI_REG_CMDCTRL_OPCODE_LSB		24
+#define	CQSPI_REG_CMDCTRL_WR_BYTES_MASK		0x7
+#define	CQSPI_REG_CMDCTRL_ADD_BYTES_MASK	0x3
+#define	CQSPI_REG_CMDCTRL_RD_BYTES_MASK		0x7
+#define	CQSPI_REG_INDIRECTWR			0x70
+#define	CQSPI_REG_INDIRECTWR_START_MASK		BIT(0)
+#define	CQSPI_REG_INDIRECTWR_CANCEL_MASK	BIT(1)
+#define	CQSPI_REG_INDIRECTWR_DONE_MASK		BIT(5)
+#define	CQSPI_REG_INDIRECTWRWATERMARK		0x74
+#define	CQSPI_REG_INDIRECTWRSTARTADDR		0x78
+#define	CQSPI_REG_INDIRECTWRBYTES		0x7C
+#define	CQSPI_REG_CMDADDRESS			0x94
+#define	CQSPI_REG_CMDREADDATALOWER		0xA0
+#define	CQSPI_REG_CMDREADDATAUPPER		0xA4
+#define	CQSPI_REG_CMDWRITEDATALOWER		0xA8
+#define	CQSPI_REG_CMDWRITEDATAUPPER		0xAC
+
+/* Interrupt status bits */
+#define CQSPI_REG_IRQ_MODE_ERR			BIT(0)
+#define CQSPI_REG_IRQ_UNDERFLOW			BIT(1)
+#define CQSPI_REG_IRQ_IND_COMP			BIT(2)
+#define CQSPI_REG_IRQ_IND_RD_REJECT		BIT(3)
+#define CQSPI_REG_IRQ_WR_PROTECTED_ERR		BIT(4)
+#define CQSPI_REG_IRQ_ILLEGAL_AHB_ERR		BIT(5)
+#define CQSPI_REG_IRQ_WATERMARK			BIT(6)
+#define CQSPI_REG_IRQ_IND_RD_OVERFLOW		BIT(12)
+#define CQSPI_IRQ_STATUS_ERR		(CQSPI_REG_IRQ_MODE_ERR		| \
+					 CQSPI_REG_IRQ_IND_RD_REJECT	| \
+					 CQSPI_REG_IRQ_WR_PROTECTED_ERR	| \
+					 CQSPI_REG_IRQ_ILLEGAL_AHB_ERR)
+#define CQSPI_IRQ_MASK_RD		(CQSPI_REG_IRQ_MODE_ERR		| \
+					 CQSPI_REG_IRQ_IND_RD_REJECT	| \
+					 CQSPI_REG_IRQ_WATERMARK	| \
+					 CQSPI_REG_IRQ_IND_RD_OVERFLOW	| \
+					 CQSPI_REG_IRQ_IND_COMP)
+#define CQSPI_IRQ_MASK_WR		(CQSPI_REG_IRQ_MODE_ERR		| \
+					 CQSPI_REG_IRQ_WR_PROTECTED_ERR	| \
+					 CQSPI_REG_IRQ_IND_COMP		| \
+					 CQSPI_REG_IRQ_WATERMARK	| \
+					 CQSPI_REG_IRQ_UNDERFLOW)
+
+#define CQSPI_IRQ_STATUS_MASK			(0xFFFFFFFF)
+#define CQSPI_CAL_DELAY(tdelay_ns, tref_ns, tsclk_ns)		\
+		((((tdelay_ns) - (tsclk_ns)) / (tref_ns)))
+#define CQSPI_GET_RD_SRAM_LEVEL(reg_basse)			\
+		(((readl(reg_base + CQSPI_REG_SDRAMLEVEL)) >>	\
+		CQSPI_REG_SDRAMLEVEL_RD_LSB) & CQSPI_REG_SDRAMLEVEL_RD_MASK)
+
+struct cqspi_flash_pdata {
+	u32	page_size;
+	u32	block_size;
+	u32	flash_type;
+	u32	quad;
+	u32	read_delay;
+	u32	tshsl_ns;
+	u32	tsd2d_ns;
+	u32	tchsh_ns;
+	u32	tslch_ns;
+};
+
+struct cqspi_platform_data {
+	u32	bus_num;
+	u32	num_chipselect;
+	u32	qspi_ahb_phy;
+	u32	qspi_ahb_size;
+	u32	qspi_ahb_mask;
+	u32	master_ref_clk_hz;
+	u32	ext_decoder;
+	u32	fifo_depth;
+	u32	fifo_width;
+	u32	enable_dma;
+	u32	tx_dma_peri_id;
+	u32	rx_dma_peri_id;
+	u32	trigger_address;
+	bool	is_decoded_cs;
+	bool	rclk_en;
+	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIP_SELECT];
+};
+
+struct struct_cqspi {
+	struct platform_device	*pdev;
+
+	struct clk		*clk;
+	struct clk		*fpi_clk;
+
+	struct reset_control	*reset;
+	struct completion	transfer_complete;
+	struct workqueue_struct	*workqueue;
+	wait_queue_head_t	waitqueue;
+	/* mutex lock for synchronization */
+	struct mutex		lock;
+
+	void __iomem		*iobase;
+	void __iomem		*qspi_ahb_virt;
+	struct resource		*res;
+	struct resource		*ahbbase;
+	resource_size_t		ahb_size;
+
+	struct dma_chan		*rx_chan;
+	struct completion       rx_dma_complete;
+	dma_addr_t		mmap_phys_base;
+	int			dma_done;
+	u32			trigger_address;
+	u32			wr_delay;
+	u32			irq_status;
+	int			current_cs;
+	int			irq;
+	bool			use_dac_mode;
+};
+
+struct spi_mem_op_cadence {
+	const void	*tx_buf;
+	void		*rx_buf;
+	u32		len;
+	u32		tx_nbits:3;
+	u32		rx_nbits:3;
+};
+
+#endif /* __CADENCE_QSPI__H__ */
-- 
2.11.0

