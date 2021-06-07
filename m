Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D785939DCBE
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFGMp1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 08:45:27 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:32784 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGMp0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 08:45:26 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id D7BC0C85D5;
        Mon,  7 Jun 2021 20:43:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32529T140357073352448S1623069785962833_;
        Mon, 07 Jun 2021 20:43:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f1d5792b143f8d8ef430eb4d33484067>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-spi@vger.kernel.org
X-RCPT-COUNT: 17
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v5 2/8] spi: rockchip-sfc: add rockchip serial flash controller
Date:   Mon,  7 Jun 2021 20:42:57 +0800
Message-Id: <20210607124303.22393-3-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607124303.22393-1-jon.lin@rock-chips.com>
References: <20210607124303.22393-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add the rockchip serial flash controller (SFC) driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/spi/Kconfig            |   9 +
 drivers/spi/Makefile           |   1 +
 drivers/spi/spi-rockchip-sfc.c | 863 +++++++++++++++++++++++++++++++++
 3 files changed, 873 insertions(+)
 create mode 100644 drivers/spi/spi-rockchip-sfc.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e71a4c514f7b..d89e5f3c9107 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -658,6 +658,15 @@ config SPI_ROCKCHIP
 	  The main usecase of this controller is to use spi flash as boot
 	  device.
 
+config SPI_ROCKCHIP_SFC
+	tristate "Rockchip Serial Flash Controller (SFC)"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM && HAS_DMA
+	help
+	  This enables support for Rockchip serial flash controller. This
+	  is a specialized controller used to access SPI flash on some
+	  Rockchip SOCs.
+
 config SPI_RB4XX
 	tristate "Mikrotik RB4XX SPI master"
 	depends on SPI_MASTER && ATH79
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 13e54c45e9df..699db95c8441 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_SPI_QCOM_GENI)		+= spi-geni-qcom.o
 obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom-qspi.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
+obj-$(CONFIG_SPI_ROCKCHIP_SFC)		+= spi-rockchip-sfc.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+= spi-realtek-rtl.o
 obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
new file mode 100644
index 000000000000..ddce87a2f319
--- /dev/null
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -0,0 +1,863 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Rockchip Serial Flash Controller Driver
+//
+// Copyright (c) 2017, Rockchip Inc.
+// Author: Shawn Lin <shawn.lin@rock-chips.com>
+//
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi-mem.h>
+
+/* System control */
+#define SFC_CTRL			0x0
+#define  SFC_CTRL_COMMON_BITS_1		0x0
+#define  SFC_CTRL_COMMON_BITS_2		0x1
+#define  SFC_CTRL_COMMON_BITS_4		0x2
+#define  SFC_CTRL_DATA_BITS_SHIFT	12
+#define  SFC_CTRL_ADDR_BITS_SHIFT	10
+#define  SFC_CTRL_CMD_BITS_SHIFT	8
+#define  SFC_CTRL_PHASE_SEL_NEGETIVE	BIT(1)
+
+/* Interrupt mask */
+#define SFC_IMR				0x4
+#define  SFC_IMR_RX_FULL		BIT(0)
+#define  SFC_IMR_RX_UFLOW		BIT(1)
+#define  SFC_IMR_TX_OFLOW		BIT(2)
+#define  SFC_IMR_TX_EMPTY		BIT(3)
+#define  SFC_IMR_TRAN_FINISH		BIT(4)
+#define  SFC_IMR_BUS_ERR		BIT(5)
+#define  SFC_IMR_NSPI_ERR		BIT(6)
+#define  SFC_IMR_DMA			BIT(7)
+
+/* Interrupt clear */
+#define SFC_ICLR			0x8
+#define  SFC_ICLR_RX_FULL		BIT(0)
+#define  SFC_ICLR_RX_UFLOW		BIT(1)
+#define  SFC_ICLR_TX_OFLOW		BIT(2)
+#define  SFC_ICLR_TX_EMPTY		BIT(3)
+#define  SFC_ICLR_TRAN_FINISH		BIT(4)
+#define  SFC_ICLR_BUS_ERR		BIT(5)
+#define  SFC_ICLR_NSPI_ERR		BIT(6)
+#define  SFC_ICLR_DMA			BIT(7)
+
+/* FIFO threshold level */
+#define SFC_FTLR			0xc
+#define  SFC_FTLR_TX_SHIFT		0
+#define  SFC_FTLR_TX_MASK		0x1f
+#define  SFC_FTLR_RX_SHIFT		8
+#define  SFC_FTLR_RX_MASK		0x1f
+
+/* Reset FSM and FIFO */
+#define SFC_RCVR			0x10
+#define  SFC_RCVR_RESET			BIT(0)
+
+/* Enhanced mode */
+#define SFC_AX				0x14
+
+/* Address Bit number */
+#define SFC_ABIT			0x18
+
+/* Interrupt status */
+#define SFC_ISR				0x1c
+#define  SFC_ISR_RX_FULL_SHIFT		BIT(0)
+#define  SFC_ISR_RX_UFLOW_SHIFT		BIT(1)
+#define  SFC_ISR_TX_OFLOW_SHIFT		BIT(2)
+#define  SFC_ISR_TX_EMPTY_SHIFT		BIT(3)
+#define  SFC_ISR_TX_FINISH_SHIFT	BIT(4)
+#define  SFC_ISR_BUS_ERR_SHIFT		BIT(5)
+#define  SFC_ISR_NSPI_ERR_SHIFT		BIT(6)
+#define  SFC_ISR_DMA_SHIFT		BIT(7)
+
+/* FIFO status */
+#define SFC_FSR				0x20
+#define  SFC_FSR_TX_IS_FULL		BIT(0)
+#define  SFC_FSR_TX_IS_EMPTY		BIT(1)
+#define  SFC_FSR_RX_IS_EMPTY		BIT(2)
+#define  SFC_FSR_RX_IS_FULL		BIT(3)
+#define  SFC_FSR_TXLV_MASK		GENMASK(12, 8)
+#define  SFC_FSR_TXLV_SHIFT		8
+#define  SFC_FSR_RXLV_MASK		GENMASK(20, 16)
+#define  SFC_FSR_RXLV_SHIFT		16
+
+/* FSM status */
+#define SFC_SR				0x24
+#define  SFC_SR_IS_IDLE			0x0
+#define  SFC_SR_IS_BUSY			0x1
+
+/* Raw interrupt status */
+#define SFC_RISR			0x28
+#define  SFC_RISR_RX_FULL		BIT(0)
+#define  SFC_RISR_RX_UNDERFLOW		BIT(1)
+#define  SFC_RISR_TX_OVERFLOW		BIT(2)
+#define  SFC_RISR_TX_EMPTY		BIT(3)
+#define  SFC_RISR_TRAN_FINISH		BIT(4)
+#define  SFC_RISR_BUS_ERR		BIT(5)
+#define  SFC_RISR_NSPI_ERR		BIT(6)
+#define  SFC_RISR_DMA			BIT(7)
+
+/* Master trigger */
+#define SFC_DMA_TRIGGER			0x80
+
+/* Src or Dst addr for master */
+#define SFC_DMA_ADDR			0x84
+
+/* Command */
+#define SFC_CMD				0x100
+#define  SFC_CMD_IDX_SHIFT		0
+#define  SFC_CMD_DUMMY_SHIFT		8
+#define  SFC_CMD_DIR_RD			0
+#define  SFC_CMD_DIR_WR			1
+#define  SFC_CMD_DIR_SHIFT		12
+#define  SFC_CMD_ADDR_ZERO		(0x0 << 14)
+#define  SFC_CMD_ADDR_24BITS		(0x1 << 14)
+#define  SFC_CMD_ADDR_32BITS		(0x2 << 14)
+#define  SFC_CMD_ADDR_FRS		(0x3 << 14)
+#define  SFC_CMD_TRAN_BYTES_SHIFT	16
+#define  SFC_CMD_CS_SHIFT		30
+
+/* Address */
+#define SFC_ADDR			0x104
+
+/* Data */
+#define SFC_DATA			0x108
+
+/* The controller and documentation reports that it supports up to 4 CS
+ * devices (0-3), however I have only been able to test a single CS (CS 0)
+ * due to the configuration of my device.
+ */
+#define SFC_MAX_CHIPSELECT_NUM		4
+
+/* The SFC can transfer max 16KB - 1 at one time
+ * we set it to 15.5KB here for alignment.
+ */
+#define SFC_MAX_TRANS_BYTES		(512 * 31)
+
+/* Maximum clock values from datasheet suggest keeping clock value under
+ * 150MHz. No minimum or average value is suggested, but the U-boot BSP driver
+ * has a minimum of 10MHz and a default of 80MHz which seems reasonable.
+ */
+#define SFC_MIN_SPEED_HZ		(10 * 1000 * 1000)
+#define SFC_DEFAULT_SPEED_HZ		(80 * 1000 * 1000)
+#define SFC_MAX_SPEED_HZ		(150 * 1000 * 1000)
+
+#define SFC_CMD_DUMMY(x) \
+	((x) << SFC_CMD_DUMMY_SHIFT)
+
+enum rockchip_sfc_iftype {
+	IF_TYPE_STD,
+	IF_TYPE_DUAL,
+	IF_TYPE_QUAD,
+};
+
+struct rockchip_sfc;
+struct rockchip_sfc_chip_priv {
+	u8 cs;
+	u32 clk_rate;
+	struct rockchip_sfc *sfc;
+};
+
+struct rockchip_sfc {
+	struct device *dev;
+	void __iomem *regbase;
+	struct clk *hclk;
+	struct clk *clk;
+	/* virtual mapped addr for dma_buffer */
+	void *buffer;
+	dma_addr_t dma_buffer;
+	struct completion cp;
+	struct rockchip_sfc_chip_priv flash[SFC_MAX_CHIPSELECT_NUM];
+	u8 num_chip;
+	bool use_dma;
+};
+
+static int rockchip_sfc_get_if_type(const struct spi_mem_op *op,
+				    struct rockchip_sfc *sfc)
+{
+	switch (op->data.buswidth) {
+	case 1:
+		return IF_TYPE_STD;
+	case 2:
+		return IF_TYPE_DUAL;
+	case 4:
+		return IF_TYPE_QUAD;
+	default:
+		dev_err(sfc->dev, "unsupported SPI read mode\n");
+		return -EINVAL;
+	}
+}
+
+static int rockchip_sfc_reset(struct rockchip_sfc *sfc)
+{
+	int err;
+	u32 status;
+
+	writel_relaxed(SFC_RCVR_RESET, sfc->regbase + SFC_RCVR);
+
+	err = readl_poll_timeout(sfc->regbase + SFC_RCVR, status,
+				 !(status & SFC_RCVR_RESET), 20,
+				 jiffies_to_usecs(HZ));
+	if (err)
+		dev_err(sfc->dev, "SFC reset never finished\n");
+
+	/* Still need to clear the masked interrupt from RISR */
+	writel_relaxed(SFC_ICLR_RX_FULL | SFC_ICLR_RX_UFLOW |
+		       SFC_ICLR_TX_OFLOW | SFC_ICLR_TX_EMPTY |
+		       SFC_ICLR_TRAN_FINISH | SFC_ICLR_BUS_ERR |
+		       SFC_ICLR_NSPI_ERR | SFC_ICLR_DMA,
+		       sfc->regbase + SFC_ICLR);
+
+	dev_dbg(sfc->dev, "reset\n");
+
+	return err;
+}
+
+static int rockchip_sfc_init(struct rockchip_sfc *sfc)
+{
+	int err;
+
+	err = clk_set_rate(sfc->clk, SFC_DEFAULT_SPEED_HZ);
+	if (err)
+		return err;
+
+	err = rockchip_sfc_reset(sfc);
+	if (err)
+		return err;
+
+	/* Mask all eight interrupts */
+	writel_relaxed(0xff, sfc->regbase + SFC_IMR);
+
+	writel_relaxed(SFC_CTRL_PHASE_SEL_NEGETIVE, sfc->regbase + SFC_CTRL);
+
+	return 0;
+}
+
+static inline int rockchip_sfc_get_fifo_level(struct rockchip_sfc *sfc, int wr)
+{
+	u32 fsr = readl_relaxed(sfc->regbase + SFC_FSR);
+	int level;
+
+	if (wr)
+		level = (fsr & SFC_FSR_TXLV_MASK) >> SFC_FSR_TXLV_SHIFT;
+	else
+		level = (fsr & SFC_FSR_RXLV_MASK) >> SFC_FSR_RXLV_SHIFT;
+
+	return level;
+}
+
+static int rockchip_sfc_wait_fifo_ready(struct rockchip_sfc *sfc, int wr, u32 timeout)
+{
+	unsigned long deadline = jiffies + timeout;
+	int level;
+
+	while (!(level = rockchip_sfc_get_fifo_level(sfc, wr))) {
+		if (time_after_eq(jiffies, deadline)) {
+			dev_warn(sfc->dev, "%s fifo timeout\n", wr ? "write" : "read");
+			return -ETIMEDOUT;
+		}
+		udelay(1);
+	}
+
+	return level;
+}
+
+/* The SFC_CTRL register is a global control register,
+ * when the controller is in busy state(SFC_SR),
+ * SFC_CTRL cannot be set.
+ */
+static void rockchip_sfc_wait_idle(struct rockchip_sfc *sfc, u32 timeout_us)
+{
+	u32 status;
+	int ret;
+
+	ret = readl_poll_timeout(sfc->regbase + SFC_SR, status,
+				 !(status & SFC_SR_IS_BUSY),
+				 20, timeout_us);
+	if (ret) {
+		dev_err(sfc->dev, "wait sfc idle timeout\n");
+		rockchip_sfc_reset(sfc);
+	}
+}
+
+static void rockchip_sfc_setup_ctrl(struct rockchip_sfc *sfc)
+{
+	u32 reg;
+
+	reg = IF_TYPE_STD << SFC_CTRL_DATA_BITS_SHIFT;
+	reg |= IF_TYPE_STD << SFC_CTRL_ADDR_BITS_SHIFT;
+	reg |= IF_TYPE_STD << SFC_CTRL_CMD_BITS_SHIFT;
+	reg |= SFC_CTRL_PHASE_SEL_NEGETIVE;
+
+	rockchip_sfc_wait_idle(sfc, 10000);
+
+	writel_relaxed(reg, sfc->regbase + SFC_CTRL);
+}
+
+static int rockchip_sfc_op_reg(struct rockchip_sfc_chip_priv *priv,
+			       u8 opcode, int len, u8 optype)
+{
+	struct rockchip_sfc *sfc = priv->sfc;
+	u32 reg;
+
+	rockchip_sfc_setup_ctrl(sfc);
+
+	reg = opcode << SFC_CMD_IDX_SHIFT;
+	reg |= len << SFC_CMD_TRAN_BYTES_SHIFT;
+	reg |= priv->cs << SFC_CMD_CS_SHIFT;
+	reg |= optype << SFC_CMD_DIR_SHIFT;
+	writel_relaxed(reg, sfc->regbase + SFC_CMD);
+
+	return 0;
+}
+
+static int rockchip_sfc_write_fifo(struct rockchip_sfc *sfc, const u8 *buf, int len)
+{
+	u8 bytes = len & 0x3;
+	u32 dwords;
+	int tx_level;
+	u32 write_words;
+	u32 tmp = 0;
+
+	dwords = len >> 2;
+	while (dwords) {
+		tx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_WR, HZ);
+		if (tx_level < 0)
+			return tx_level;
+		write_words = min_t(u32, tx_level, dwords);
+		iowrite32_rep(sfc->regbase + SFC_DATA, buf, write_words);
+		buf += write_words << 2;
+		dwords -= write_words;
+	}
+
+	/* write the rest of the bytes that are not a multiple of word size */
+	if (bytes) {
+		tx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_WR, HZ);
+		if (tx_level < 0)
+			return tx_level;
+		memcpy(&tmp, buf, bytes);
+		writel_relaxed(tmp, sfc->regbase + SFC_DATA);
+	}
+
+	return len;
+}
+
+static int rockchip_sfc_read_fifo(struct rockchip_sfc *sfc, u8 *buf, int len)
+{
+	u8 bytes = len & 0x3;
+	u32 dwords;
+	u8 read_words;
+	int rx_level;
+	int tmp;
+
+	/* word aligned access only */
+	dwords = len >> 2;
+	while (dwords) {
+		rx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_RD, HZ);
+		if (rx_level < 0)
+			return rx_level;
+		read_words = min_t(u32, rx_level, dwords);
+		ioread32_rep(sfc->regbase + SFC_DATA, buf, read_words);
+		buf += read_words << 2;
+		dwords -= read_words;
+	}
+
+	/* read the rest of the bytes that are not a multiple of word size */
+	if (bytes) {
+		rx_level = rockchip_sfc_wait_fifo_ready(sfc, SFC_CMD_DIR_RD, HZ);
+		if (rx_level < 0)
+			return rx_level;
+		tmp = readl_relaxed(sfc->regbase + SFC_DATA);
+		memcpy(buf, &tmp, bytes);
+	}
+
+	return len;
+}
+
+static int rockchip_sfc_read_reg(struct rockchip_sfc_chip_priv *priv,
+				 const struct spi_mem_op *op)
+{
+	struct rockchip_sfc *sfc = priv->sfc;
+	int ret;
+	int trans;
+	size_t n_rx = op->data.nbytes;
+	u8 opcode = op->cmd.opcode;
+	u8 *rxbuf = op->data.buf.in;
+
+	trans = min_t(int, n_rx, SFC_MAX_TRANS_BYTES);
+	ret = rockchip_sfc_op_reg(priv, opcode, trans, SFC_CMD_DIR_RD);
+	if (ret)
+		return ret;
+
+	ret = rockchip_sfc_read_fifo(sfc, rxbuf, trans);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rockchip_sfc_write_reg(struct rockchip_sfc_chip_priv *priv,
+				  const struct spi_mem_op *op)
+{
+	struct rockchip_sfc *sfc = priv->sfc;
+	int ret;
+	size_t n_tx = op->data.nbytes;
+	u8 opcode = op->cmd.opcode;
+	const u8 *txbuf = op->data.buf.out;
+
+	ret = rockchip_sfc_op_reg(priv, opcode, n_tx, SFC_CMD_DIR_WR);
+	if (ret)
+		return ret;
+	ret = rockchip_sfc_write_fifo(sfc, txbuf, n_tx);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rockchip_sfc_setup_transfer(struct rockchip_sfc_chip_priv *priv,
+				       const struct spi_mem_op *op,
+				       loff_t from_to, size_t len, u8 op_type)
+{
+	struct rockchip_sfc *sfc = priv->sfc;
+	u8 if_type = IF_TYPE_STD;
+	u8 addr_width = op->addr.nbytes;
+	u8 read_dummy_bits = op->dummy.nbytes << 3;
+	u32 reg;
+
+	if (op_type == SFC_CMD_DIR_RD)
+		if_type = rockchip_sfc_get_if_type(op, sfc);
+
+	rockchip_sfc_wait_idle(sfc, 10000);
+
+	writel_relaxed((if_type << SFC_CTRL_DATA_BITS_SHIFT) |
+		       (IF_TYPE_STD << SFC_CTRL_ADDR_BITS_SHIFT) |
+		       (IF_TYPE_STD << SFC_CTRL_CMD_BITS_SHIFT) |
+		       SFC_CTRL_PHASE_SEL_NEGETIVE,
+		       sfc->regbase + SFC_CTRL);
+
+	reg = op->cmd.opcode << SFC_CMD_IDX_SHIFT;
+
+	reg |= op_type << SFC_CMD_DIR_SHIFT;
+	reg |= (addr_width == 4) ?
+		SFC_CMD_ADDR_32BITS : SFC_CMD_ADDR_24BITS;
+
+	reg |= priv->cs << SFC_CMD_CS_SHIFT;
+	reg |= len << SFC_CMD_TRAN_BYTES_SHIFT;
+
+	if (op_type == SFC_CMD_DIR_RD)
+		reg |= SFC_CMD_DUMMY(read_dummy_bits);
+
+	writel_relaxed(reg, sfc->regbase + SFC_CMD);
+	writel_relaxed(from_to, sfc->regbase + SFC_ADDR);
+
+	return 0;
+}
+
+static int rockchip_sfc_do_dma_transfer(struct rockchip_sfc_chip_priv *priv,
+					const struct spi_mem_op *op, loff_t from_to,
+					dma_addr_t dma_buf, size_t len, u8 op_type)
+{
+	struct rockchip_sfc *sfc = priv->sfc;
+	u32 reg;
+	int err = 0;
+
+	init_completion(&sfc->cp);
+
+	writel_relaxed(SFC_ICLR_RX_FULL | SFC_ICLR_RX_UFLOW |
+		       SFC_ICLR_TX_OFLOW | SFC_ICLR_TX_EMPTY |
+		       SFC_ICLR_TRAN_FINISH | SFC_ICLR_BUS_ERR |
+		       SFC_ICLR_NSPI_ERR | SFC_ICLR_DMA,
+		       sfc->regbase + SFC_ICLR);
+
+	/* Enable transfer complete interrupt */
+	reg = readl_relaxed(sfc->regbase + SFC_IMR);
+	reg &= ~SFC_IMR_TRAN_FINISH;
+	writel_relaxed(reg, sfc->regbase + SFC_IMR);
+
+	err = rockchip_sfc_setup_transfer(priv, op, from_to, len, op_type);
+	if (err < 0)
+		return err;
+
+	writel_relaxed(dma_buf, sfc->regbase + SFC_DMA_ADDR);
+
+	/*
+	 * Start dma but note that the sfc->dma_buffer is derived from
+	 * dmam_alloc_coherent so we don't actually need any sync operations
+	 * for coherent dma memory.
+	 */
+	writel(0x1, sfc->regbase + SFC_DMA_TRIGGER);
+
+	/* Wait for the interrupt. */
+	if (!wait_for_completion_timeout(&sfc->cp, msecs_to_jiffies(2000))) {
+		dev_err(sfc->dev, "DMA wait for transfer finish timeout\n");
+		err = -ETIMEDOUT;
+	}
+
+	writel_relaxed(SFC_ICLR_RX_FULL | SFC_ICLR_RX_UFLOW |
+		       SFC_ICLR_TX_OFLOW | SFC_ICLR_TX_EMPTY |
+		       SFC_ICLR_TRAN_FINISH | SFC_ICLR_BUS_ERR |
+		       SFC_ICLR_NSPI_ERR | SFC_ICLR_DMA,
+		       sfc->regbase + SFC_ICLR);
+	/* Disable transfer finish interrupt */
+	reg = readl_relaxed(sfc->regbase + SFC_IMR);
+	reg |= SFC_IMR_TRAN_FINISH;
+	writel_relaxed(reg, sfc->regbase + SFC_IMR);
+
+	if (err) {
+		rockchip_sfc_reset(sfc);
+		return err;
+	}
+
+	return 0;
+}
+
+static inline int rockchip_sfc_pio_write(struct rockchip_sfc *sfc, u_char *buf,
+					 size_t len)
+{
+	return rockchip_sfc_write_fifo(sfc, buf, len);
+}
+
+static inline int rockchip_sfc_pio_read(struct rockchip_sfc *sfc, u_char *buf,
+					size_t len)
+{
+	return rockchip_sfc_read_fifo(sfc, buf, len);
+}
+
+static int rockchip_sfc_pio_transfer(struct rockchip_sfc_chip_priv *priv,
+				     const struct spi_mem_op *op, loff_t from_to, size_t len,
+				     u_char *buf, u8 op_type)
+{
+	struct rockchip_sfc *sfc = priv->sfc;
+	size_t trans;
+	int ret;
+
+	trans = min_t(size_t, SFC_MAX_TRANS_BYTES, len);
+	ret = rockchip_sfc_setup_transfer(priv, op, from_to, trans, op_type);
+	if (ret < 0)
+		return ret;
+
+	if (op_type == SFC_CMD_DIR_WR)
+		ret = rockchip_sfc_pio_write(sfc, buf, trans);
+	else
+		ret = rockchip_sfc_pio_read(sfc, buf, trans);
+
+	return ret;
+}
+
+static int rockchip_sfc_dma_transfer(struct rockchip_sfc_chip_priv *priv,
+				     const struct spi_mem_op *op, loff_t from_to, size_t len,
+				     u_char *buf, u8 op_type)
+{
+	struct rockchip_sfc *sfc = priv->sfc;
+	size_t trans;
+	int ret;
+
+	trans = min_t(size_t, SFC_MAX_TRANS_BYTES, len);
+
+	if (op_type == SFC_CMD_DIR_WR)
+		memcpy(sfc->buffer, buf, trans);
+
+	ret = rockchip_sfc_do_dma_transfer(priv, op, from_to, sfc->dma_buffer,
+					   trans, op_type);
+	if (ret) {
+		dev_warn(sfc->dev, "DMA timeout\n");
+		return ret;
+	}
+
+	if (op_type == SFC_CMD_DIR_RD)
+		memcpy(buf, sfc->buffer, trans);
+
+	return trans;
+}
+
+static ssize_t rockchip_sfc_do_rd_wr(struct rockchip_sfc_chip_priv *priv,
+				     const struct spi_mem_op *op, loff_t from_to, size_t len,
+				     u_char *buf, u32 op_type)
+{
+	struct rockchip_sfc *sfc = priv->sfc;
+
+	/* DMA can only handle word aligned transfer chunks */
+	if (likely(sfc->use_dma) && !(len & 0x3))
+		return rockchip_sfc_dma_transfer(priv, op, from_to, len, buf, op_type);
+	else
+		return rockchip_sfc_pio_transfer(priv, op, from_to, len, buf, op_type);
+}
+
+static ssize_t rockchip_sfc_read(struct rockchip_sfc_chip_priv *priv,
+				 const struct spi_mem_op *op)
+{
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	u_char *read_buf = op->data.buf.in;
+
+	return rockchip_sfc_do_rd_wr(priv, op, from, len, read_buf, SFC_CMD_DIR_RD);
+}
+
+static ssize_t rockchip_sfc_write(struct rockchip_sfc_chip_priv *priv,
+				  const struct spi_mem_op *op)
+{
+	loff_t to = op->addr.val;
+	size_t len = op->data.nbytes;
+	const u_char *write_buf = op->data.buf.out;
+
+	return rockchip_sfc_do_rd_wr(priv, op, to, len, (u_char *)write_buf, SFC_CMD_DIR_WR);
+}
+
+static int rockchip_sfc_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct rockchip_sfc *sfc = spi_master_get_devdata(mem->spi->master);
+	struct rockchip_sfc_chip_priv *priv = &sfc->flash[mem->spi->chip_select];
+
+	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
+		if (!op->addr.nbytes)
+			return rockchip_sfc_read_reg(priv, op);
+
+		return rockchip_sfc_read(priv, op);
+	}
+
+	if (!op->addr.nbytes || !op->data.buf.out)
+		return rockchip_sfc_write_reg(priv, op);
+
+	return rockchip_sfc_write(priv, op);
+}
+
+static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct rockchip_sfc *sfc = spi_master_get_devdata(mem->spi->master);
+	struct rockchip_sfc_chip_priv *priv = &sfc->flash[mem->spi->chip_select];
+	int ret;
+
+	ret = clk_set_rate(sfc->clk, priv->clk_rate);
+	if (ret)
+		return ret;
+
+	ret = rockchip_sfc_mem_process(mem, op);
+	if (ret < 0) {
+		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const char *rockchip_sfc_get_name(struct spi_mem *mem)
+{
+	struct rockchip_sfc *sfc = spi_master_get_devdata(mem->spi->master);
+	struct device *dev = sfc->dev;
+
+	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
+}
+
+static const struct spi_controller_mem_ops rockchip_sfc_mem_ops = {
+	.exec_op = rockchip_sfc_exec_mem_op,
+	.get_name = rockchip_sfc_get_name,
+};
+
+static int rockchip_sfc_register(struct device_node *np,
+				 struct rockchip_sfc *sfc)
+{
+	struct device *dev = sfc->dev;
+	int ret;
+
+	ret = of_property_read_u8(np, "reg", &sfc->flash[sfc->num_chip].cs);
+	if (ret) {
+		dev_err(dev, "No reg property for %s\n",
+			np->full_name);
+		return ret;
+	}
+
+	ret = of_property_read_u32(np, "spi-max-frequency",
+				   &sfc->flash[sfc->num_chip].clk_rate);
+	if (ret) {
+		dev_err(dev, "No spi-max-frequency property for %s\n",
+			np->full_name);
+		return ret;
+	}
+
+	sfc->flash[sfc->num_chip].sfc = sfc;
+	sfc->num_chip++;
+	return 0;
+}
+
+static int rockchip_sfc_register_all(struct rockchip_sfc *sfc)
+{
+	struct device *dev = sfc->dev;
+	struct device_node *np;
+	int ret;
+
+	for_each_available_child_of_node(dev->of_node, np) {
+		ret = rockchip_sfc_register(np, sfc);
+		if (ret)
+			dev_err(dev, "Failed to register all chips\n");
+			return ret;
+
+		if (sfc->num_chip >= SFC_MAX_CHIPSELECT_NUM) {
+			dev_warn(dev, "Exceeds the max cs limitation\n");
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t rockchip_sfc_irq_handler(int irq, void *dev_id)
+{
+	struct rockchip_sfc *sfc = dev_id;
+	u32 reg;
+
+	reg = readl(sfc->regbase + SFC_RISR);
+
+	/* Clear interrupt if transfer is finished */
+	if (reg & SFC_RISR_TRAN_FINISH) {
+		writel_relaxed(reg, sfc->regbase + SFC_ICLR);
+		complete(&sfc->cp);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int rockchip_sfc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_master *master;
+	struct resource *res;
+	struct rockchip_sfc *sfc;
+	int ret;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*sfc));
+	if (!master) {
+		dev_err(&pdev->dev, "spi_alloc_master failed\n");
+		return -ENOMEM;
+	}
+
+	master->mem_ops = &rockchip_sfc_mem_ops;
+	master->dev.of_node = pdev->dev.of_node;
+	master->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
+	master->min_speed_hz = SFC_MIN_SPEED_HZ;
+	master->max_speed_hz = SFC_MAX_SPEED_HZ;
+
+	sfc = spi_master_get_devdata(master);
+	sfc->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sfc->regbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sfc->regbase))
+		return PTR_ERR(sfc->regbase);
+
+	sfc->clk = devm_clk_get(&pdev->dev, "sfc");
+	if (IS_ERR(sfc->clk)) {
+		dev_err(&pdev->dev, "Failed to get sfc interface clk\n");
+		return PTR_ERR(sfc->clk);
+	}
+
+	sfc->hclk = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(sfc->hclk)) {
+		dev_err(&pdev->dev, "Failed to get sfc ahb clk\n");
+		return PTR_ERR(sfc->hclk);
+	}
+
+	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node,
+					      "rockchip,sfc-no-dma");
+
+	if (sfc->use_dma) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_warn(dev, "Unable to set dma mask\n");
+			return ret;
+		}
+
+		sfc->buffer = dmam_alloc_coherent(dev, SFC_MAX_TRANS_BYTES,
+						  &sfc->dma_buffer,
+						  GFP_KERNEL);
+		if (!sfc->buffer)
+			return -ENOMEM;
+	}
+
+	ret = clk_prepare_enable(sfc->hclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable ahb clk\n");
+		goto err_hclk;
+	}
+
+	ret = clk_prepare_enable(sfc->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable interface clk\n");
+		goto err_clk;
+	}
+
+	/* Find the irq */
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get the irq\n");
+		goto err_irq;
+	}
+
+	ret = devm_request_irq(dev, ret, rockchip_sfc_irq_handler,
+			       0, pdev->name, sfc);
+	if (ret) {
+		dev_err(dev, "Failed to request irq\n");
+		goto err_irq;
+	}
+
+	sfc->num_chip = 0;
+	ret = rockchip_sfc_init(sfc);
+	if (ret)
+		goto err_irq;
+
+	ret = rockchip_sfc_register_all(sfc);
+	if (ret)
+		goto err_irq;
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret)
+		goto err_irq;
+
+	return 0;
+
+err_irq:
+	clk_disable_unprepare(sfc->clk);
+err_clk:
+	clk_disable_unprepare(sfc->hclk);
+err_hclk:
+	return ret;
+}
+
+static int rockchip_sfc_remove(struct platform_device *pdev)
+{
+	struct rockchip_sfc *sfc = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(sfc->clk);
+	clk_disable_unprepare(sfc->hclk);
+	return 0;
+}
+
+static const struct of_device_id rockchip_sfc_dt_ids[] = {
+	{ .compatible = "rockchip,rk3036-sfc"},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rockchip_sfc_dt_ids);
+
+static struct platform_driver rockchip_sfc_driver = {
+	.driver = {
+		.name	= "rockchip-sfc",
+		.of_match_table = rockchip_sfc_dt_ids,
+	},
+	.probe	= rockchip_sfc_probe,
+	.remove	= rockchip_sfc_remove,
+};
+module_platform_driver(rockchip_sfc_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Rockchip Serial Flash Controller Driver");
+MODULE_AUTHOR("Shawn Lin <shawn.lin@rock-chips.com>");
-- 
2.17.1



