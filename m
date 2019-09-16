Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CF1B3583
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 09:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfIPHXi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 03:23:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:31087 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfIPHXi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Sep 2019 03:23:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 00:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="190992298"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2019 00:23:34 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v3 2/2] spi: cadence-qspi: Add QSPI support for Intel LGM SoC
Date:   Mon, 16 Sep 2019 15:23:25 +0800
Message-Id: <20190916072325.32104-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190916072325.32104-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190916072325.32104-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

On Intel Lightening Mountain(LGM) SoCs one of the IP is Cadence QSPI.
SPI flash(NAND) memories interface through QSPI controller.
This patch introduces to specific support for QSPI NAND flash.

Existing cadence drivers do not support SPI-NAND, it only supports to
SPI-NOR and SPI devices. To state that is the driver for the same IP
but due to different SPI flash memory(NAND) need to write from scratch.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/spi/Kconfig                |   9 +
 drivers/spi/Makefile               |   1 +
 drivers/spi/spi-cadence-qspi-apb.c | 644 +++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-cadence-qspi-apb.h | 174 ++++++++++
 drivers/spi/spi-cadence-qspi.c     | 461 ++++++++++++++++++++++++++
 drivers/spi/spi-cadence-qspi.h     |  73 +++++
 6 files changed, 1362 insertions(+)
 create mode 100644 drivers/spi/spi-cadence-qspi-apb.c
 create mode 100644 drivers/spi/spi-cadence-qspi-apb.h
 create mode 100644 drivers/spi/spi-cadence-qspi.c
 create mode 100644 drivers/spi/spi-cadence-qspi.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3a1d8f1170de..a3ece0977759 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -192,6 +192,15 @@ config SPI_CADENCE
 	  This selects the Cadence SPI controller master driver
 	  used by Xilinx Zynq and ZynqMP.
 
+config SPI_CADENCE_QSPI_FLASH
+	bool "Cadence QSPI controller support for QSPI-FLASH"
+	depends on X86
+	depends on OF
+	select MTD_SPI_NAND
+	help
+	  This selects the Cadence SPI controller master driver
+	  used by Intel lightning Moutaing(LGM) SoC's.
+
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 63dcab552bcb..8bb6fd20d7e9 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-iproc-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
 obj-$(CONFIG_SPI_CADENCE)		+= spi-cadence.o
+obj-$(CONFIG_SPI_CADENCE_QSPI_FLASH)	+= spi-cadence-qspi.o spi-cadence-qspi-apb.o
 obj-$(CONFIG_SPI_CLPS711X)		+= spi-clps711x.o
 obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
 obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
diff --git a/drivers/spi/spi-cadence-qspi-apb.c b/drivers/spi/spi-cadence-qspi-apb.c
new file mode 100644
index 000000000000..476a898de752
--- /dev/null
+++ b/drivers/spi/spi-cadence-qspi-apb.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Cadence QSPI Controller
+ *
+ * Copyright (C) 2012 Altera Corporation
+ * Copyright (C) 2019 Intel Corporation
+ */
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/unaligned/be_byteshift.h>
+
+#include "spi-cadence-qspi.h"
+#include "spi-cadence-qspi-apb.h"
+
+static unsigned int cadence_qspi_wait_idle(void __iomem *reg_base)
+{
+	unsigned int count = 0;
+	unsigned int timeout;
+
+	timeout = cadence_qspi_init_timeout(CQSPI_TIMEOUT_MS);
+	while (cadence_qspi_check_timeout(timeout)) {
+		if (CQSPI_REG_IS_IDLE(reg_base)) {
+			count++;
+			if (count >= CQSPI_POLL_IDLE_RETRY)
+				return 1;
+		} else {
+			count = 0;
+		}
+	}
+	return 0;
+}
+
+static void cqspi_apb_readdata_capture(void __iomem *reg_base, u32 delay)
+{
+	u32 reg;
+
+	cqspi_apb_controller_enable(reg_base, 0);
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+	reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		<< CQSPI_REG_READCAPTURE_DELAY_LSB);
+	reg |= ((delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+		<< CQSPI_REG_READCAPTURE_DELAY_LSB);
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+
+	cqspi_apb_controller_enable(reg_base, 1);
+}
+
+static void cqspi_apb_config_baudrate_div(void __iomem *reg_base,
+					  u32 ref_clk_hz, u32 sclk_hz)
+{
+	u32 reg, div;
+
+	cqspi_apb_controller_enable(reg_base, 0);
+
+	div = DIV_ROUND_UP(ref_clk_hz, 2 * sclk_hz) - 1;
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_BAUD_MASK << CQSPI_REG_CONFIG_BAUD_LSB);
+	div = (div & CQSPI_REG_CONFIG_BAUD_MASK) << CQSPI_REG_CONFIG_BAUD_LSB;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	cqspi_apb_controller_enable(reg_base, 1);
+}
+
+static void cadence_qspi_apb_chipselect(void __iomem *reg_base, u32 chip_select)
+{
+	u32 reg;
+
+	cqspi_apb_controller_enable(reg_base, 0);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~CQSPI_REG_CONFIG_DECODE_MASK;
+	chip_select = 0xF & ~(1 << chip_select);
+	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
+			<< CQSPI_REG_CONFIG_CHIPSELECT_LSB);
+	reg |= (chip_select & CQSPI_REG_CONFIG_CHIPSELECT_MASK)
+			<< CQSPI_REG_CONFIG_CHIPSELECT_LSB;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	cqspi_apb_controller_enable(reg_base, 1);
+}
+
+static int cadence_qspi_apb_exec_flash_cmd(void __iomem *reg_base, u32 reg)
+{
+	u32 timeout;
+
+	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
+	reg |= CQSPI_REG_CMDCTRL_EXECUTE_MASK;
+	writel(reg, reg_base + CQSPI_REG_CMDCTRL);
+
+	timeout = cadence_qspi_init_timeout(CQSPI_TIMEOUT_MS);
+	while (cadence_qspi_check_timeout(timeout)) {
+		reg = readl(reg_base + CQSPI_REG_CMDCTRL) &
+			CQSPI_REG_CMDCTRL_INPROGRESS_MASK;
+		if (!reg)
+			break;
+	}
+	if (!cadence_qspi_wait_idle(reg_base) || reg != 0)
+		return -EIO;
+
+	return 0;
+}
+
+static int cqspi_apb_command_read(void __iomem *reg_base, u32 txlen,
+				  const u8 *txbuf, u32 addrlen,
+				  const u8 *addrbuf, u32 rxlen, u8 *rxbuf)
+{
+	u32 addr_value, read_len, reg;
+	int ret;
+
+	if (!rxlen || rxlen > CQSPI_STIG_DATA_LEN_MAX || !rxbuf)
+		return -EINVAL;
+
+	reg = txbuf[0] << CQSPI_REG_CMDCTRL_OPCODE_LSB;
+	reg |= BIT(CQSPI_REG_CMDCTRL_RD_EN_LSB);
+	if (addrlen) {
+		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
+		reg |= ((addrlen - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
+			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
+		addr_value = get_unaligned_be32(&addrbuf[0]);
+		writel(addr_value, reg_base + CQSPI_REG_CMDADDRESS);
+			}
+	reg |= (((rxlen - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
+		<< CQSPI_REG_CMDCTRL_RD_BYTES_LSB);
+	ret = cadence_qspi_apb_exec_flash_cmd(reg_base, reg);
+	if (ret != 0)
+		return ret;
+
+	reg = readl(reg_base + CQSPI_REG_CMDREADDATALOWER);
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
+static int cqspi_apb_command_write(void __iomem *reg_base, u32 txlen,
+				   const u8 *txbuf, u32 addrlen,
+				   const u8 *addrbuf, u32 datalen,
+				   const u8 *databuf)
+{
+	u32 addr_value, reg, data = 0;
+
+	if (!txlen || !txbuf)
+		return -EINVAL;
+
+	reg = txbuf[0] << CQSPI_REG_CMDCTRL_OPCODE_LSB;
+	if (datalen != 0) {
+		reg |= BIT(CQSPI_REG_CMDCTRL_WR_EN_LSB);
+		reg |= ((datalen - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
+			<< CQSPI_REG_CMDCTRL_WR_BYTES_LSB;
+		memcpy(&data, txbuf, datalen);
+		writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
+	}
+	if (addrlen) {
+		reg |= BIT(CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
+		reg |= ((addrlen - 1) & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
+			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
+		addr_value = get_unaligned_be32(&addrbuf[0]);
+		writel(addr_value, reg_base + CQSPI_REG_CMDADDRESS);
+	}
+
+	return cadence_qspi_apb_exec_flash_cmd(reg_base, reg);
+}
+
+static int cqspi_apb_indirect_read_setup(void __iomem *reg_base,
+					 u32 ahb_phy_addr, u32 txlen,
+					 const u8 *txbuf, u32 addrlen,
+					 const u8 *addrbuf, u32 dummy_bytes,
+					 u32 quad_mode)
+{
+	u32 addr_val, dummy_clk, reg;
+
+	writel(ahb_phy_addr, reg_base + CQSPI_REG_INDIRECTTRIGGER);
+	if (addrlen) {
+		addr_val = get_unaligned_be16(&addrbuf[0]);
+		writel(addr_val, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
+	}
+	reg = txbuf[0] << CQSPI_REG_RD_INSTR_OPCODE_LSB;
+	reg |= (quad_mode & CQSPI_REG_RD_INSTR_TYPE_DATA_MASK)
+		<< CQSPI_REG_RD_INSTR_TYPE_DATA_LSB;
+
+	if (dummy_bytes) {
+		if (dummy_bytes > CQSPI_DUMMY_BYTES_MAX)
+			dummy_bytes = CQSPI_DUMMY_BYTES_MAX;
+		reg |= BIT(CQSPI_REG_RD_INSTR_MODE_EN_LSB);
+		writel(0xFF, reg_base + CQSPI_REG_MODE_BIT);
+		dummy_clk = dummy_bytes * CQSPI_DUMMY_CLKS_PER_BYTE;
+		dummy_clk -= CQSPI_DUMMY_CLKS_PER_BYTE;
+		if (dummy_clk)
+			reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
+				<< CQSPI_REG_RD_INSTR_DUMMY_LSB;
+	}
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	reg = readl(reg_base + CQSPI_REG_SIZE);
+	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
+	reg |= (addrlen - 1);
+	writel(reg, reg_base + CQSPI_REG_SIZE);
+
+	return 0;
+}
+
+static int cqspi_apb_indirect_read_execute(struct struct_cqspi *cadence_qspi,
+					   u32 rxlen, u8 *rxbuf)
+{
+	struct platform_device *pdev = cadence_qspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	void __iomem *reg_base = cadence_qspi->iobase;
+	void __iomem *ahb_base = cadence_qspi->qspi_ahb_virt;
+	u8 *rxbuf_end = rxbuf + rxlen;
+	int remaining = (int)rxlen;
+	u32 mod_bytes = rxlen % 4;
+	u32 bytes_to_read = 0;
+	u32 timeout;
+	int ret, status = 0;
+
+	writel(0, reg_base + CQSPI_REG_INDIRECTRDWATERMARK);
+	writel(0xa, reg_base + CQSPI_REG_INDIRECTTRIGGERADDRRANGE);
+	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
+	/* flush previous writes before starting read operation */
+	mb();
+
+	writel((pdata->fifo_depth - CQSPI_REG_SRAM_RESV_WORDS),
+	       reg_base + CQSPI_REG_SRAMPARTITION);
+	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
+	writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
+
+	writel(CQSPI_REG_INDIRECTRD_START_MASK,
+	       reg_base + CQSPI_REG_INDIRECTRD);
+	while (remaining > 0) {
+		bytes_to_read = CQSPI_GET_RD_SRAM_LEVEL(reg_base);
+
+		while (bytes_to_read != 0) {
+			unsigned int word_remain = round_down(remaining, 4);
+
+			bytes_to_read *= CQSPI_FIFO_WIDTH;
+			bytes_to_read = bytes_to_read > remaining ?
+					remaining : bytes_to_read;
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
+	}
+
+	/* Check indirect done status */
+	timeout = cadence_qspi_init_timeout(CQSPI_TIMEOUT_MS);
+	while (cadence_qspi_check_timeout(timeout)) {
+		status = readl(reg_base + CQSPI_REG_INDIRECTRD);
+		if (status & CQSPI_REG_INDIRECTRD_DONE_MASK)
+			break;
+	}
+	if (!(status & CQSPI_REG_INDIRECTRD_DONE_MASK)) {
+		ret = -ETIMEDOUT;
+		goto failrd;
+	}
+	writel(0, reg_base + CQSPI_REG_IRQMASK);
+	writel(CQSPI_REG_INDIRECTRD_DONE_MASK,
+	       reg_base + CQSPI_REG_INDIRECTRD);
+	return 0;
+failrd:
+	writel(0, reg_base + CQSPI_REG_IRQMASK);
+	writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
+	       reg_base + CQSPI_REG_INDIRECTRD);
+	return ret;
+}
+
+static int cqspi_apb_indirect_write_setup(void __iomem *reg_base,
+					  u32 ahb_phy_addr, u32 txlen,
+					  const u8 *txbuf, u32 addrlen,
+					  const u8 *addrbuf, u32 quad_mode)
+{
+	u32 reg;
+
+	if (!txbuf)
+		return -EINVAL;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_DIRECT_MASK);
+	reg &= ~(CQSPI_REG_CONFIG_DMA_MASK);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	writel(ahb_phy_addr, reg_base + CQSPI_REG_INDIRECTTRIGGER);
+	reg = txbuf[0] << CQSPI_REG_WR_INSTR_OPCODE_LSB;
+	reg |= BIT(CQSPI_REG_WR_INSTR_WEL_DISABLE_POS);
+	if (quad_mode == QUAD_QIO) {
+		reg |= (quad_mode & CQSPI_REG_WR_INSTR_TYPE_ADDR_MASK) <<
+			CQSPI_REG_WR_INSTR_TYPE_ADDR_LSB;
+	}
+	/* Configure the quad */
+	reg |= (quad_mode & CQSPI_REG_WR_INSTR_TYPE_DATA_MASK) <<
+	       CQSPI_REG_WR_INSTR_TYPE_DATA_LSB;
+	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
+
+	reg = get_unaligned_be32(&addrbuf[0]);
+	writel(reg, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
+	reg = readl(reg_base + CQSPI_REG_SIZE);
+	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
+	reg |= ((addrlen - 1) & CQSPI_REG_SIZE_ADDRESS_MASK);
+	writel(reg, reg_base +  CQSPI_REG_SIZE);
+
+	return 0;
+}
+
+static int cqspi_apb_indirect_write_execute(struct struct_cqspi *cadence_qspi,
+					    u32 txlen, const u8 *txbuf)
+{
+	struct platform_device *pdev = cadence_qspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata =
+			&pdata->f_pdata[cadence_qspi->current_cs];
+	unsigned int *irq_status = &cadence_qspi->irq_status;
+	void __iomem *reg_base = cadence_qspi->iobase;
+	void __iomem *ahb_base = cadence_qspi->qspi_ahb_virt;
+	unsigned int page_size = f_pdata->page_size;
+	int remaining = (int)txlen;
+	u32 write_bytes, timeout, reg;
+	int ret, status = 0;
+
+	writel(0xa, reg_base + CQSPI_REG_INDIRECTTRIGGERADDRRANGE);
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
+	writel(CQSPI_REG_INDIRECTWR_START_MASK,
+	       reg_base + CQSPI_REG_INDIRECTWR);
+
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
+		ret = wait_event_interruptible_timeout(cadence_qspi->waitqueue,
+						       *irq_status &
+						       CQSPI_IRQ_MASK_WR,
+						       CQSPI_TIMEOUT_MS);
+		if (!ret & (*irq_status & CQSPI_IRQ_STATUS_ERR)) {
+			ret = -ETIMEDOUT;
+			goto failwr;
+		} else {
+			ret = 0;
+		}
+		remaining -= write_bytes;
+	}
+
+	/* Check indirect done status */
+	timeout = cadence_qspi_init_timeout(CQSPI_TIMEOUT_MS);
+	while (cadence_qspi_check_timeout(timeout)) {
+		status = readl(reg_base + CQSPI_REG_INDIRECTWR);
+		if (status & CQSPI_REG_INDIRECTWR_DONE_MASK)
+			break;
+	}
+	if (!(status & CQSPI_REG_INDIRECTWR_DONE_MASK)) {
+		ret = -ETIMEDOUT;
+		goto failwr;
+	}
+	return 0;
+
+failwr:
+	writel(0, reg_base + CQSPI_REG_IRQMASK);
+	writel(CQSPI_REG_INDIRECTWR_DONE_MASK,
+	       reg_base + CQSPI_REG_INDIRECTWR);
+	if (ret)
+		writel(CQSPI_REG_INDIRECTWR_CANCEL_MASK,
+		       reg_base + CQSPI_REG_INDIRECTWR);
+	return ret;
+}
+
+void cqspi_apb_controller_enable(void __iomem *reg_base, bool enable)
+{
+	u32 reg;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	if (enable)
+		reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
+	else
+		reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+}
+
+unsigned int cadence_qspi_apb_is_controller_ready(void __iomem *reg_base)
+{
+	return cadence_qspi_wait_idle(reg_base);
+}
+
+void cadence_qspi_apb_controller_init(struct struct_cqspi *cadence_qspi)
+{
+	cqspi_apb_controller_enable(cadence_qspi->iobase, 0);
+	writel(0, cadence_qspi->iobase + CQSPI_REG_REMAP);
+	writel(0, cadence_qspi->iobase + CQSPI_REG_IRQMASK);
+	cqspi_apb_controller_enable(cadence_qspi->iobase, 1);
+}
+
+unsigned int calculate_ticks_for_ns(u32 ref_clk_hz, u32 ns_val)
+{
+	u32 ticks;
+
+	ticks = ref_clk_hz / 1000;      /* kHz */
+	ticks = DIV_ROUND_UP(ticks * ns_val, 1000000);
+
+	return ticks;
+}
+
+static void cqspi_apb_delay(struct struct_cqspi *cqspi, u32 ref_clk, u32 sclk)
+{
+	void __iomem *iobase = cqspi->iobase;
+	struct platform_device *pdev = cqspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata =
+			&pdata->f_pdata[cqspi->current_cs];
+	u32 tshsl, tchsh, tslch, tsd2d, tsclk;
+	u32 ref_clk_ns, sclk_ns, reg;
+
+	cqspi_apb_controller_enable(cqspi->iobase, 0);
+	ref_clk_ns = (1000000000) / ref_clk;
+	sclk_ns = (1000000000) / sclk;
+	tsclk = (ref_clk + sclk - 1) / sclk;
+	tshsl = calculate_ticks_for_ns(ref_clk, f_pdata->tshsl_ns);
+	if (tshsl < tsclk)
+		tshsl = tsclk;
+	tchsh = calculate_ticks_for_ns(ref_clk, f_pdata->tchsh_ns);
+	tslch = calculate_ticks_for_ns(ref_clk, f_pdata->tslch_ns);
+	tsd2d = calculate_ticks_for_ns(ref_clk, f_pdata->tsd2d_ns);
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
+	cqspi_apb_controller_enable(cqspi->iobase, 1);
+}
+
+static void cadence_qspi_switch_cs(struct struct_cqspi *cadence_qspi, u32 cs)
+{
+	struct platform_device *pdev = cadence_qspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata = &pdata->f_pdata[cs];
+	void __iomem *iobase = cadence_qspi->iobase;
+	u32 reg;
+
+	cqspi_apb_controller_enable(iobase, 0);
+
+	reg = readl(iobase + CQSPI_REG_SIZE);
+	reg &= ~(CQSPI_REG_SIZE_PAGE_MASK << CQSPI_REG_SIZE_PAGE_LSB);
+	reg &= ~(CQSPI_REG_SIZE_BLOCK_MASK << CQSPI_REG_SIZE_BLOCK_LSB);
+	reg |= (f_pdata->page_size << CQSPI_REG_SIZE_PAGE_LSB);
+	reg |= (f_pdata->block_size << CQSPI_REG_SIZE_BLOCK_LSB);
+	writel(reg, iobase + CQSPI_REG_SIZE);
+	cadence_qspi_apb_chipselect(iobase, cs);
+
+	cqspi_apb_controller_enable(iobase, 1);
+}
+
+int cadence_qspi_apb_process_queue(struct struct_cqspi *cadence_qspi,
+				   struct spi_device *spi, u32 n_trans,
+				   struct spi_transfer **spi_xfer)
+{
+	struct platform_device *pdev = cadence_qspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata;
+	void __iomem *iobase = cadence_qspi->iobase;
+	struct spi_transfer *cmd_xfer = NULL;
+	struct spi_transfer *data_xfer = NULL;
+	struct spi_transfer *dummy_xfer = NULL;
+	struct spi_transfer *addr_xfer = NULL;
+	int rdid_length, mode, ret, i;
+	u32 sclk;
+
+	for (i = 0; i < n_trans; i++)
+		dev_dbg(&pdev->dev, "xfer[%d] %d\n", i, spi_xfer[i]->len);
+
+	if (cadence_qspi->current_cs != spi->chip_select) {
+		cadence_qspi->current_cs = spi->chip_select;
+		cadence_qspi_switch_cs(cadence_qspi, spi->chip_select);
+	}
+
+	f_pdata = &pdata->f_pdata[cadence_qspi->current_cs];
+	rdid_length = 6;
+
+	switch (n_trans) {
+	case 1:
+		cmd_xfer = spi_xfer[0];
+		break;
+	case 2:
+		cmd_xfer = spi_xfer[0];
+		data_xfer = spi_xfer[1];
+		break;
+	case 3:
+		cmd_xfer = spi_xfer[0];
+		addr_xfer = spi_xfer[1];
+		data_xfer = spi_xfer[2];
+		break;
+	case 4:
+		cmd_xfer = spi_xfer[0];
+		addr_xfer = spi_xfer[1];
+		dummy_xfer = spi_xfer[2];
+		data_xfer = spi_xfer[3];
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported n_trans %u\n", n_trans);
+		return -EINVAL;
+	}
+
+	if (!data_xfer)
+		mode = STIG_WRITE_MODE;
+	else if (data_xfer->len > rdid_length)
+		mode = data_xfer->tx_buf ? IDC_WRITE_MODE : IDC_READ_MODE;
+	else
+		mode = data_xfer->tx_buf ? STIG_WRITE_MODE : STIG_READ_MODE;
+
+	sclk = cmd_xfer->speed_hz ? cmd_xfer->speed_hz : spi->max_speed_hz;
+	cqspi_apb_controller_enable(iobase, 0);
+	cqspi_apb_config_baudrate_div(iobase, pdata->master_ref_clk_hz, sclk);
+	cqspi_apb_delay(cadence_qspi, pdata->master_ref_clk_hz, sclk);
+	cqspi_apb_readdata_capture(iobase, f_pdata->read_delay);
+	cqspi_apb_controller_enable(iobase, 1);
+
+	switch (mode) {
+	case STIG_WRITE_MODE:
+		ret = cqspi_apb_command_write(iobase, cmd_xfer->len,
+					      cmd_xfer->tx_buf,
+					      addr_xfer ? addr_xfer->len : 0,
+					      addr_xfer ?
+					      addr_xfer->tx_buf : NULL,
+					      data_xfer ? data_xfer->len : 0,
+					      data_xfer ?
+					      data_xfer->tx_buf : NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "command write error (%i)\n", ret);
+			return ret;
+		}
+		break;
+	case STIG_READ_MODE:
+		ret = cqspi_apb_command_read(iobase, cmd_xfer->len,
+					     cmd_xfer->tx_buf,
+					     addr_xfer ? addr_xfer->len : 0,
+					     addr_xfer ?
+					     addr_xfer->tx_buf : NULL,
+					     data_xfer ? data_xfer->len : 0,
+					     data_xfer ?
+					     data_xfer->rx_buf : NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "command read error (%i)\n", ret);
+			return ret;
+		}
+		break;
+	case IDC_WRITE_MODE:
+		ret = cqspi_apb_indirect_write_setup(iobase,
+						     pdata->qspi_ahb_phy &
+						     pdata->qspi_ahb_mask,
+						     cmd_xfer->len,
+						     cmd_xfer->tx_buf,
+						     addr_xfer ?
+						     addr_xfer->len : 0,
+						     addr_xfer ?
+						     addr_xfer->tx_buf : NULL,
+						     f_pdata->quad);
+		ret = cqspi_apb_indirect_write_execute(cadence_qspi,
+						       data_xfer->len,
+						       data_xfer->tx_buf);
+		if (ret) {
+			dev_err(&pdev->dev, "indirect write error (%i)\n", ret);
+			return ret;
+		}
+		break;
+	case IDC_READ_MODE:
+		ret = cqspi_apb_indirect_read_setup(iobase,
+						    pdata->qspi_ahb_phy &
+						    pdata->qspi_ahb_mask,
+						    cmd_xfer->len,
+						    cmd_xfer->tx_buf,
+						    addr_xfer ?
+						    addr_xfer->len : 0,
+						    addr_xfer ?
+						    addr_xfer->tx_buf : NULL,
+						    dummy_xfer ?
+						    dummy_xfer->len : 0,
+						    f_pdata->quad);
+		ret = cqspi_apb_indirect_read_execute(cadence_qspi,
+						      data_xfer->len,
+						      data_xfer->rx_buf);
+		if (ret) {
+			dev_err(&pdev->dev, "indirect read error (%i)\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported mode %u\n", mode);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/spi/spi-cadence-qspi-apb.h b/drivers/spi/spi-cadence-qspi-apb.h
new file mode 100644
index 000000000000..e8e920b50105
--- /dev/null
+++ b/drivers/spi/spi-cadence-qspi-apb.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Cadence QSPI Controller
+ *
+ * Copyright (C) 2012 Altera Corporation
+ * Copyright (C) 2019 Intel Corporation
+ */
+#ifndef __CADENCE_QSPI_APB_H__
+#define __CADENCE_QSPI_APB_H__
+#include "spi-cadence-qspi.h"
+
+/* Operation timeout value */
+#define CQSPI_TIMEOUT_MS			5000
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
+#define CQSPI_REG_WR_INSTR_WEL_DISABLE_POS	8
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
+#define CQSPI_REG_INDIRECTTRIGGERADDRRANGE	0x80
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
+
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
+#define CQSPI_IRQ_STATUS_MASK		(0xFFFFFFFF)
+#define CQSPI_REG_IS_IDLE(base)						\
+		((readl((base) + CQSPI_REG_CONFIG) >>		\
+			CQSPI_REG_CONFIG_IDLE_LSB) & 0x1)
+#define CQSPI_CAL_DELAY(tdelay_ns, tref_ns, tsclk_ns)			\
+		((((tdelay_ns) - (tsclk_ns)) / (tref_ns)))
+#define CQSPI_GET_RD_SRAM_LEVEL(reg_base)				\
+		(((readl(reg_base + CQSPI_REG_SDRAMLEVEL)) >>	\
+		CQSPI_REG_SDRAMLEVEL_RD_LSB) & CQSPI_REG_SDRAMLEVEL_RD_MASK)
+#define CQSPI_READ_IRQ_STATUS(reg_base)					\
+		readl((reg_base) + CQSPI_REG_IRQSTATUS)
+#define CQSPI_CLEAR_IRQ(reg_base, status)				\
+		writel(status, (reg_base) + CQSPI_REG_IRQSTATUS)
+
+unsigned int cadence_qspi_apb_is_controller_ready(void *reg_base_addr);
+void cadence_qspi_apb_controller_init(struct struct_cqspi *cadence_qspi);
+int cadence_qspi_apb_process_queue(struct struct_cqspi *cadence_qspi,
+				   struct spi_device *spi,
+				   unsigned int n_trans,
+				   struct spi_transfer **spi_xfer);
+void cqspi_apb_controller_enable(void *reg_base_addr, bool enable);
+
+#endif /* __CADENCE_QSPI_APB_H__ */
diff --git a/drivers/spi/spi-cadence-qspi.c b/drivers/spi/spi-cadence-qspi.c
new file mode 100644
index 000000000000..ad85fe5894e3
--- /dev/null
+++ b/drivers/spi/spi-cadence-qspi.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Cadence QSPI Controller
+ * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
+ * Copyright Altera Corporation (C) 2019. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/spi/spi.h>
+
+#include "spi-cadence-qspi.h"
+#include "spi-cadence-qspi-apb.h"
+
+#define CADENCE_QSPI_NAME			"cdns-qspi-flash"
+
+unsigned int cadence_qspi_init_timeout(const unsigned long timeout_in_ms)
+{
+	return jiffies + msecs_to_jiffies(timeout_in_ms);
+}
+
+unsigned int cadence_qspi_check_timeout(const unsigned long timeout)
+{
+	return time_before(jiffies, timeout);
+}
+
+static irqreturn_t cadence_qspi_irq_handler(int this_irq, void *dev)
+{
+	struct struct_cqspi *cadence_qspi = dev;
+	u32 irq_status;
+
+	irq_status = CQSPI_READ_IRQ_STATUS(cadence_qspi->iobase);
+	if (!irq_status)
+		return IRQ_HANDLED;
+
+	cadence_qspi->irq_status = irq_status;
+
+	/* Clear interrupt */
+	CQSPI_CLEAR_IRQ(cadence_qspi->iobase, irq_status);
+	wake_up(&cadence_qspi->waitqueue);
+	return IRQ_HANDLED;
+}
+
+static void cadence_qspi_work(struct work_struct *work)
+{
+	struct struct_cqspi *cadence_qspi = container_of(work,
+							 struct struct_cqspi,
+							 work);
+	unsigned long flags;
+
+	spin_lock_irqsave(&cadence_qspi->lock, flags);
+	while ((!list_empty(&cadence_qspi->msg_queue)) &&
+	       cadence_qspi->running) {
+		struct spi_message *spi_msg;
+		struct spi_device *spi;
+		struct spi_transfer *spi_xfer;
+		struct spi_transfer *xfer[CQSPI_MAX_TRANS];
+		int status = 0;
+		int n_trans = 0;
+		int skip_xfer = 0;
+		unsigned int total_len = 0;
+
+		spi_msg = container_of(cadence_qspi->msg_queue.next,
+				       struct spi_message, queue);
+		list_del_init(&spi_msg->queue);
+		spin_unlock_irqrestore(&cadence_qspi->lock, flags);
+		spi = spi_msg->spi;
+		list_for_each_entry(spi_xfer, &spi_msg->transfers,
+				    transfer_list) {
+			if (n_trans >= CQSPI_MAX_TRANS) {
+				dev_err(&spi->dev, "err: spi_xfer exceed %d.\n",
+					CQSPI_MAX_TRANS);
+				/* Skip process the queue if number of
+				 * transaction is greater than max 2.
+				 */
+				skip_xfer = 1;
+				break;
+			}
+			xfer[n_trans++] = spi_xfer;
+			total_len += spi_xfer->len;
+		}
+
+		if (!skip_xfer) {
+			status = cadence_qspi_apb_process_queue(cadence_qspi,
+								spi,
+								n_trans, xfer);
+			if (!status)
+				spi_msg->actual_length = total_len;
+
+			spi_msg->status = status;
+			spi_msg->complete(spi_msg->context);
+		}
+		spin_lock_irqsave(&cadence_qspi->lock, flags);
+	}
+	spin_unlock_irqrestore(&cadence_qspi->lock, flags);
+}
+
+static int cadence_qspi_transfer(struct spi_device *spi,
+				 struct spi_message *msg)
+{
+	struct struct_cqspi *cadence_qspi =
+		spi_master_get_devdata(spi->master);
+	struct spi_transfer *spi_xfer;
+	struct platform_device *pdev = cadence_qspi->pdev;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	unsigned long flags;
+
+	list_for_each_entry(spi_xfer, &msg->transfers, transfer_list) {
+		if (spi_xfer->speed_hz > (pdata->master_ref_clk_hz / 2)) {
+			dev_err(&spi->dev,
+				"speed_hz%d greater than maximum %dHz\n",
+				spi_xfer->speed_hz,
+				(pdata->master_ref_clk_hz / 2));
+			msg->status = -EINVAL;
+			return -EINVAL;
+		}
+	}
+	spin_lock_irqsave(&cadence_qspi->lock, flags);
+	if (!cadence_qspi->running) {
+		spin_unlock_irqrestore(&cadence_qspi->lock, flags);
+		return -ESHUTDOWN;
+	}
+	msg->status = -EINPROGRESS;
+	msg->actual_length = 0;
+	list_add_tail(&msg->queue, &cadence_qspi->msg_queue);
+	queue_work(cadence_qspi->workqueue, &cadence_qspi->work);
+	spin_unlock_irqrestore(&cadence_qspi->lock, flags);
+	return 0;
+}
+
+static int cadence_qspi_setup(struct spi_device *spi)
+{
+	if (spi->chip_select > spi->master->num_chipselect) {
+		dev_err(&spi->dev, "%d chip select is out of range\n",
+			spi->chip_select);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int cadence_qspi_start_queue(struct struct_cqspi *cadence_qspi)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cadence_qspi->lock, flags);
+	if (cadence_qspi->running) {
+		spin_unlock_irqrestore(&cadence_qspi->lock, flags);
+		return -EBUSY;
+	}
+	if (!cadence_qspi_apb_is_controller_ready(cadence_qspi->iobase)) {
+		spin_unlock_irqrestore(&cadence_qspi->lock, flags);
+		return -EBUSY;
+	}
+	cadence_qspi->running = true;
+	spin_unlock_irqrestore(&cadence_qspi->lock, flags);
+	queue_work(cadence_qspi->workqueue, &cadence_qspi->work);
+	return 0;
+}
+
+static int cadence_qspi_of_get_pdata(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *nc;
+	struct cqspi_platform_data *pdata = pdev->dev.platform_data;
+	struct cqspi_flash_pdata *f_pdata;
+	unsigned int cs;
+	unsigned int prop;
+
+	if (of_property_read_u32(np, "cdns,qspi-phyaddr", &prop)) {
+		dev_err(&pdev->dev,
+			"couldn't determine cdns,qspi-phyaddr\n");
+		return -ENXIO;
+	}
+	pdata->qspi_ahb_phy = prop;
+
+	if (of_property_read_u32(np, "cdns,qspi-physize", &prop)) {
+		dev_info(&pdev->dev,
+			 "missing cdns,qspi-physize; default to 128 kB\n");
+		prop = 128;
+	}
+	pdata->qspi_ahb_size = prop * 1024;
+
+	if (of_property_read_u32(np, "cdns,qspi-phymask", &prop))
+		prop = CQSPI_INDIRECTTRIGGER_ADDR_MASK;
+
+	pdata->qspi_ahb_mask = prop;
+
+	if (of_property_read_u32(np, "bus-num", &prop)) {
+		dev_err(&pdev->dev, "couldn't determine bus-num\n");
+		return -ENXIO;
+	}
+	pdata->bus_num = prop;
+	if (of_property_read_u32(np, "num-chipselect", &prop)) {
+		dev_err(&pdev->dev, "couldn't determine num-chipselect\n");
+		return -ENXIO;
+	}
+	pdata->num_chipselect = prop;
+	if (of_property_read_u32(np, "cdns,fifo-depth", &prop)) {
+		dev_err(&pdev->dev, "couldn't determine fifo-depth\n");
+		return -ENXIO;
+	}
+	pdata->fifo_depth = prop;
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
+		if (of_property_read_u32(nc, "spi-rx-bus-width", &prop)) {
+			dev_err(&pdev->dev, "couldn't determine quad\n");
+			return -ENXIO;
+		}
+		f_pdata->quad = (prop == 4) ? QUAD_QIO : QUAD_SIO;
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
+	}
+	return 0;
+}
+
+static int cadence_qspi_probe(struct platform_device *pdev)
+{
+	struct cqspi_platform_data *pdata;
+	struct struct_cqspi *cadence_qspi;
+	struct spi_master *master;
+	struct resource *res;
+	int status;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*cadence_qspi));
+	if (!master) {
+		dev_err(&pdev->dev, "spi_alloc_master failed\n");
+		return -ENOMEM;
+	}
+	master->mode_bits = SPI_CS_HIGH | SPI_CPOL | SPI_CPHA | SPI_TX_QUAD |
+			    SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL;
+	master->setup = cadence_qspi_setup;
+	master->transfer = cadence_qspi_transfer;
+	master->dev.of_node = pdev->dev.of_node;
+	cadence_qspi = spi_master_get_devdata(master);
+	cadence_qspi->pdev = pdev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cadence_qspi->iobase = devm_ioremap_resource(&pdev->dev, res);
+	if (!cadence_qspi->iobase) {
+		dev_err(&pdev->dev, "devm_ioremap_resource res 0 failed\n");
+		status = -EADDRNOTAVAIL;
+		goto err_ioremap;
+	}
+
+	pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		status = -ENOMEM;
+		goto err_pdata;
+	}
+	pdev->dev.platform_data = pdata;
+	cadence_qspi->clk = devm_clk_get(&pdev->dev, "qspi");
+	if (IS_ERR(cadence_qspi->clk)) {
+		dev_err(&pdev->dev, "cannot get qspi clk\n");
+		return PTR_ERR(cadence_qspi->clk);
+	}
+	cadence_qspi->fpi_clk = devm_clk_get(&pdev->dev, "freq");
+	if (IS_ERR(cadence_qspi->fpi_clk)) {
+		dev_err(&pdev->dev, "cannot get qspi fpi_clk\n");
+		return PTR_ERR(cadence_qspi->fpi_clk);
+	}
+	pdata->master_ref_clk_hz = clk_get_rate(cadence_qspi->fpi_clk);
+	status = clk_prepare_enable(cadence_qspi->clk);
+	if (status < 0) {
+		dev_err(&pdev->dev,
+			"failed to enable qspi clock: %d\n", status);
+		return status;
+	}
+
+	status = cadence_qspi_of_get_pdata(pdev);
+	if (status) {
+		dev_err(&pdev->dev, "Get platform data failed.\n");
+		goto err_of;
+	}
+
+	cadence_qspi->res = res;
+
+	/* request and remap ahb */
+	res = devm_request_mem_region(&pdev->dev, pdata->qspi_ahb_phy,
+				      pdata->qspi_ahb_size, "ahb");
+	if (!res) {
+		dev_err(&pdev->dev, "failed to request memory region\n");
+		status = -EADDRNOTAVAIL;
+		goto err_ahbremap;
+	}
+
+	cadence_qspi->qspi_ahb_virt = devm_ioremap(&pdev->dev,
+						   pdata->qspi_ahb_phy,
+						   pdata->qspi_ahb_size);
+	if (!cadence_qspi->qspi_ahb_virt) {
+		dev_err(&pdev->dev, "failed to remap memory region\n");
+		status = -EADDRNOTAVAIL;
+		goto err_ahbremap;
+	}
+
+	cadence_qspi->reset = devm_reset_control_get(&pdev->dev, "qspi");
+	if (IS_ERR(cadence_qspi->reset))
+		dev_err(&pdev->dev, "qspi get reset fail.\n");
+
+	reset_control_assert(cadence_qspi->reset);
+	reset_control_deassert(cadence_qspi->reset);
+
+	cadence_qspi->workqueue =
+		create_singlethread_workqueue(dev_name(master->dev.parent));
+	if (!cadence_qspi->workqueue) {
+		dev_err(&pdev->dev, "create_workqueue failed\n");
+		status = -ENOMEM;
+		goto err_wq;
+	}
+	cadence_qspi->running = false;
+	INIT_WORK(&cadence_qspi->work, cadence_qspi_work);
+	spin_lock_init(&cadence_qspi->lock);
+	INIT_LIST_HEAD(&cadence_qspi->msg_queue);
+	init_waitqueue_head(&cadence_qspi->waitqueue);
+	status = cadence_qspi_start_queue(cadence_qspi);
+	if (status) {
+		dev_err(&pdev->dev, "problem starting queue.\n");
+		goto err_start_q;
+	}
+	cadence_qspi->irq = platform_get_irq(pdev, 0);
+	if (cadence_qspi->irq < 0) {
+		dev_err(&pdev->dev, "platform_get_irq failed\n");
+		status = -ENXIO;
+		goto err_irq;
+	}
+	status = request_irq(cadence_qspi->irq, cadence_qspi_irq_handler,
+			     0, pdev->name, cadence_qspi);
+	if (status) {
+		dev_err(&pdev->dev, "request_irq failed\n");
+		goto err_irq;
+	}
+	master->bus_num = pdata->bus_num;
+	master->num_chipselect = pdata->num_chipselect;
+	platform_set_drvdata(pdev, master);
+	cadence_qspi_apb_controller_init(cadence_qspi);
+	cadence_qspi->current_cs = 0;
+	status = spi_register_master(master);
+	if (status) {
+		dev_err(&pdev->dev, "spi_register_master=%d failed\n", status);
+		goto err_of;
+	}
+	return 0;
+
+err_pdata:
+	free_irq(cadence_qspi->irq, cadence_qspi);
+err_start_q:
+err_irq:
+	destroy_workqueue(cadence_qspi->workqueue);
+err_of:
+err_wq:
+err_ahbremap:
+err_ioremap:
+	spi_master_put(master);
+	dev_err(&pdev->dev, "Cadence QSPI controller probe failed\n");
+	return status;
+}
+
+static int cadence_qspi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct struct_cqspi *cadence_qspi = spi_master_get_devdata(master);
+
+	cqspi_apb_controller_enable(cadence_qspi->iobase, 0);
+	platform_set_drvdata(pdev, NULL);
+	destroy_workqueue(cadence_qspi->workqueue);
+	free_irq(cadence_qspi->irq, cadence_qspi);
+	iounmap(cadence_qspi->iobase);
+	iounmap(cadence_qspi->qspi_ahb_virt);
+	release_mem_region(cadence_qspi->res->start,
+			   resource_size(cadence_qspi->res));
+	kfree(pdev->dev.platform_data);
+	spi_unregister_master(master);
+	spi_master_put(master);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cadence_qspi_of_match[] = {
+	{ .compatible = "cadence,qspi-nand",},
+	{ /* end of table */}
+};
+MODULE_DEVICE_TABLE(of, cadence_qspi_of_match);
+#else
+#define cadence_qspi_of_match NULL
+#endif /* CONFIG_OF */
+
+static struct platform_driver cadence_qspi_platform_driver = {
+	.probe		= cadence_qspi_probe,
+	.remove		= cadence_qspi_remove,
+	.driver = {
+		.name	= CADENCE_QSPI_NAME,
+		.of_match_table = cadence_qspi_of_match,
+	},
+};
+
+module_platform_driver(cadence_qspi_platform_driver);
+
+MODULE_DESCRIPTION("Cadence QSPI Controller Driver for flash");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" CADENCE_QSPI_NAME);
+MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
diff --git a/drivers/spi/spi-cadence-qspi.h b/drivers/spi/spi-cadence-qspi.h
new file mode 100644
index 000000000000..77d768ff75c7
--- /dev/null
+++ b/drivers/spi/spi-cadence-qspi.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later  */
+/*
+ * Driver for Cadence QSPI Controller
+ *
+ * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
+ * Copyright Intel Corporation (C) 2019. All rights reserved.
+ */
+#include <linux/reset.h>
+#ifndef __CADENCE_QSPI_H__
+#define __CADENCE_QSPI_H__
+#define CQSPI_MAX_TRANS			10
+#define CQSPI_MAX_CHIP_SELECT		16
+#define DC_MODE				0
+#define STIG_READ_MODE			1
+#define STIG_WRITE_MODE			2
+#define STIG_WRITE_READ_MODE		3
+#define IDC_READ_MODE			4
+#define IDC_WRITE_MODE			5
+
+#define QUAD_SIO			0
+#define QUAD_DIO			1
+#define QUAD_QIO			2
+
+#define QUAD_LSB			4
+
+struct cqspi_flash_pdata {
+	unsigned int	page_size;
+	unsigned int	block_size;
+	unsigned int	flash_type;
+	unsigned int	quad;
+	unsigned int	read_delay;
+	unsigned int	tshsl_ns;
+	unsigned int	tsd2d_ns;
+	unsigned int	tchsh_ns;
+	unsigned int	tslch_ns;
+};
+
+struct cqspi_platform_data {
+	unsigned int	bus_num;
+	unsigned int	num_chipselect;
+	unsigned int	qspi_ahb_phy;
+	unsigned int	qspi_ahb_size;
+	unsigned int	qspi_ahb_mask;
+	unsigned int	master_ref_clk_hz;
+	unsigned int	fifo_depth;
+	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIP_SELECT];
+};
+
+struct struct_cqspi {
+	struct platform_device	*pdev;
+
+	struct work_struct	work;
+	struct workqueue_struct *workqueue;
+	wait_queue_head_t	waitqueue;
+	struct list_head	msg_queue;
+	struct clk		*clk;
+	struct clk		*fpi_clk;
+	struct reset_control	*reset;
+	/* lock protects queue and registers */
+	spinlock_t		lock;
+	void __iomem		*iobase;
+	void __iomem		*qspi_ahb_virt;
+	struct resource		*res;
+	struct resource		*res_ahb;
+	int			irq;
+	unsigned int		irq_status;
+	int			current_cs;
+	u8	running;
+};
+
+unsigned int cadence_qspi_init_timeout(const unsigned long timeout_in_ms);
+unsigned int cadence_qspi_check_timeout(const unsigned long timeout);
+#endif /* __CADENCE_QSPI_H__ */
-- 
2.11.0

