Return-Path: <linux-spi+bounces-8714-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56652AE390C
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 10:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDFC07A4536
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8E234977;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdoj8G2K"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9F233736;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668809; cv=none; b=g59V9FIkW6J9Z6eB7NhzS5tDRacflojfMw0iOFQn7BZ4njsHNYoU/VTGVL8JTWVQWJoYwAJfs+8ef9Pb1vQ6dkOd20lDeHQq+y1FEXCHPE16/UsSzkpHE3ZyK+2zz5MHFVQ52ymZqSVy6XfdG60RMA/Fa8XW93OYXDFeQAKkQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668809; c=relaxed/simple;
	bh=0Qcjhb6pFXqJ2rvak208nTQRNxmU8Hx6P12g5Vgdbws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mePtHYO/FC7oSsWc1HZrFJulK1IhC4j+KR7YgQAvtkqzcRmahLdVbwP44WPcT6le40DH0cr1ZPZe0+s5CZpeiDJ4CgJhcTb6wRaifjlgb6f0pYNTYVEThpTx5IbMvXoqCA0bJ3KmibnJSZBuI9CJjI6kl3JkZ2WO9XfLu6uwvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bdoj8G2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61C99C4CEF6;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750668809;
	bh=0Qcjhb6pFXqJ2rvak208nTQRNxmU8Hx6P12g5Vgdbws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bdoj8G2KlcD71KIOqgozhgazKkrjguc++c6Ifp6WHSDrEKL2HcyFDRRSkol9GAjFa
	 38PMH3oF3jM8j3vIexnqxgHsIl/y23xFb+XIX9Q16TxE31fpUiU53m4IaOvewX+Zv+
	 h8wYoMx2fAsfT6Xk8sGIgeCuS8jo4U9HmVt5+ICDG8WHqGlzRPfQDtixk/QupoPAsK
	 VDQlwM65VZxLvTrntHT3l59QvPPBuR3wAHc7WH5MQcVbSI570IYNDWyeQ/bTT9j2yq
	 WKvMHBfBZNoZ975uotTZLTIRHOCeJYzie3j6yt5AAK0HVSBGOOvK9CtwwGhDkrlb+9
	 eKRLvprz7Cu4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53359C7EE30;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 23 Jun 2025 16:53:28 +0800
Subject: [PATCH v3 2/3] spi: Add Amlogic SPISG driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-spisg-v3-2-c731f57e289c@amlogic.com>
References: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
In-Reply-To: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750668807; l=27568;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=gYPmsQNGB8f2eejB5wA1m/PyfX11iFwu6lzIwrldghI=;
 b=jBfYvJ7f5XMkY+4tS6eL2xCvMi+5W2Slxeq0/DQ7d0Y8bBVK0WU81P5V4NnJE81bxB4R32mlt
 ICyEHabdjB1DLU1KFjtLlZSRyaPwBgQgA1jM9U/lxy5dolu80JhA6/E
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Sunny Luo <sunny.luo@amlogic.com>

Introduced support for the new SPI IP (SPISG) driver. The SPISG is
a communication-oriented SPI controller from Amlogic,supporting
three operation modes: PIO, block DMA, and scatter-gather DMA.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/spi/Kconfig             |   9 +
 drivers/spi/Makefile            |   1 +
 drivers/spi/spi-amlogic-spisg.c | 876 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 886 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c51da3fc3604..e11341df2ecf 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -99,6 +99,15 @@ config SPI_AMLOGIC_SPIFC_A1
 	  This enables master mode support for the SPIFC (SPI flash
 	  controller) available in Amlogic A1 (A113L SoC).
 
+config SPI_AMLOGIC_SPISG
+	tristate "Amlogic SPISG controller"
+	depends on COMMON_CLK
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+	  This enables master mode support for the SPISG (SPI scatter-gather
+	  communication controller), which is available on platforms such as
+	  Amlogic A4 SoCs.
+
 config SPI_APPLE
 	tristate "Apple SoC SPI Controller platform driver"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4ea89f6fc531..b74e3104d71f 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
 obj-$(CONFIG_SPI_ALTERA_CORE)		+= spi-altera-core.o
 obj-$(CONFIG_SPI_ALTERA_DFL)		+= spi-altera-dfl.o
 obj-$(CONFIG_SPI_AMLOGIC_SPIFC_A1)	+= spi-amlogic-spifc-a1.o
+obj-$(CONFIG_SPI_AMLOGIC_SPISG)		+= spi-amlogic-spisg.o
 obj-$(CONFIG_SPI_APPLE)			+= spi-apple.o
 obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
new file mode 100644
index 000000000000..2f2982154d49
--- /dev/null
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -0,0 +1,876 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Amlogic SPI communication Scatter-Gather Controller
+ *
+ * Copyright (C) 2025 Amlogic, Inc. All rights reserved
+ *
+ * Author: Sunny Luo <sunny.luo@amlogic.com>
+ * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+#include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/reset.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/delay.h>
+#include <linux/cacheflush.h>
+#include <linux/regmap.h>
+
+/* Register Map */
+#define SPISG_REG_CFG_READY		0x00
+
+#define SPISG_REG_CFG_SPI		0x04
+#define CFG_BUS64_EN			BIT(0)
+#define CFG_SLAVE_EN			BIT(1)
+#define CFG_SLAVE_SELECT		GENMASK(3, 2)
+#define CFG_SFLASH_WP			BIT(4)
+#define CFG_SFLASH_HD			BIT(5)
+/* start on vsync rising */
+#define CFG_HW_POS			BIT(6)
+/* start on vsync falling */
+#define CFG_HW_NEG			BIT(7)
+
+#define SPISG_REG_CFG_START		0x08
+#define CFG_BLOCK_NUM			GENMASK(19, 0)
+#define CFG_BLOCK_SIZE			GENMASK(22, 20)
+#define CFG_DATA_COMMAND		BIT(23)
+#define CFG_OP_MODE			GENMASK(25, 24)
+#define CFG_RXD_MODE			GENMASK(27, 26)
+#define CFG_TXD_MODE			GENMASK(29, 28)
+#define CFG_EOC				BIT(30)
+#define CFG_PEND			BIT(31)
+
+#define SPISG_REG_CFG_BUS		0x0C
+#define CFG_CLK_DIV			GENMASK(7, 0)
+#define CLK_DIV_WIDTH			8
+#define CFG_RX_TUNING			GENMASK(11, 8)
+#define CFG_TX_TUNING			GENMASK(15, 12)
+#define CFG_CS_SETUP			GENMASK(19, 16)
+#define CFG_LANE			GENMASK(21, 20)
+#define CFG_HALF_DUPLEX			BIT(22)
+#define CFG_B_L_ENDIAN			BIT(23)
+#define CFG_DC_MODE			BIT(24)
+#define CFG_NULL_CTL			BIT(25)
+#define CFG_DUMMY_CTL			BIT(26)
+#define CFG_READ_TURN			GENMASK(28, 27)
+#define CFG_KEEP_SS			BIT(29)
+#define CFG_CPHA			BIT(30)
+#define CFG_CPOL			BIT(31)
+
+#define SPISG_REG_PIO_TX_DATA_L		0x10
+#define SPISG_REG_PIO_TX_DATA_H		0x14
+#define SPISG_REG_PIO_RX_DATA_L		0x18
+#define SPISG_REG_PIO_RX_DATA_H		0x1C
+#define SPISG_REG_MEM_TX_ADDR_L		0x10
+#define SPISG_REG_MEM_TX_ADDR_H		0x14
+#define SPISG_REG_MEM_RX_ADDR_L		0x18
+#define SPISG_REG_MEM_RX_ADDR_H		0x1C
+#define SPISG_REG_DESC_LIST_L		0x20
+#define SPISG_REG_DESC_LIST_H		0x24
+#define LIST_DESC_PENDING		BIT(31)
+#define SPISG_REG_DESC_CURRENT_L	0x28
+#define SPISG_REG_DESC_CURRENT_H	0x2c
+#define SPISG_REG_IRQ_STS		0x30
+#define SPISG_REG_IRQ_ENABLE		0x34
+#define IRQ_RCH_DESC_EOC		BIT(0)
+#define IRQ_RCH_DESC_INVALID		BIT(1)
+#define IRQ_RCH_DESC_RESP		BIT(2)
+#define IRQ_RCH_DATA_RESP		BIT(3)
+#define IRQ_WCH_DESC_EOC		BIT(4)
+#define IRQ_WCH_DESC_INVALID		BIT(5)
+#define IRQ_WCH_DESC_RESP		BIT(6)
+#define IRQ_WCH_DATA_RESP		BIT(7)
+#define IRQ_DESC_ERR			BIT(8)
+#define IRQ_SPI_READY			BIT(9)
+#define IRQ_DESC_DONE			BIT(10)
+#define IRQ_DESC_CHAIN_DONE		BIT(11)
+
+#define SPISG_MAX_REG			0x40
+
+#define SPISG_BLOCK_MAX			0x100000
+
+#define SPISG_OP_MODE_WRITE_CMD		0
+#define SPISG_OP_MODE_READ_STS		1
+#define SPISG_OP_MODE_WRITE		2
+#define SPISG_OP_MODE_READ		3
+
+#define SPISG_DATA_MODE_NONE		0
+#define SPISG_DATA_MODE_PIO		1
+#define SPISG_DATA_MODE_MEM		2
+#define SPISG_DATA_MODE_SG		3
+
+#define SPISG_CLK_DIV_MAX		256
+/* recommended by specification */
+#define SPISG_CLK_DIV_MIN		4
+#define DIV_NUM (SPISG_CLK_DIV_MAX - SPISG_CLK_DIV_MIN + 1)
+
+#define SPISG_PCLK_RATE_MIN		24000000
+
+#define SPISG_SINGLE_SPI		0
+#define SPISG_DUAL_SPI			1
+#define SPISG_QUAD_SPI			2
+
+struct spisg_sg_link {
+#define LINK_ADDR_VALID		BIT(0)
+#define LINK_ADDR_EOC		BIT(1)
+#define LINK_ADDR_IRQ		BIT(2)
+#define LINK_ADDR_ACT		GENMASK(5, 3)
+#define LINK_ADDR_RING		BIT(6)
+#define LINK_ADDR_LEN		GENMASK(31, 8)
+	u32			addr;
+	u32			addr1;
+};
+
+struct spisg_descriptor {
+	u32				cfg_start;
+	u32				cfg_bus;
+	u64				tx_paddr;
+	u64				rx_paddr;
+};
+
+struct spisg_descriptor_extra {
+	struct spisg_sg_link		*tx_ccsg;
+	struct spisg_sg_link		*rx_ccsg;
+	int				tx_ccsg_len;
+	int				rx_ccsg_len;
+};
+
+struct spisg_device {
+	struct spi_controller		*controller;
+	struct platform_device		*pdev;
+	struct regmap			*map;
+	struct clk			*core;
+	struct clk			*pclk;
+	struct clk			*sclk;
+	struct clk_div_table		*tbl;
+	struct completion		completion;
+	u32				status;
+	u32				speed_hz;
+	u32				effective_speed_hz;
+	u32				bytes_per_word;
+	u32				cfg_spi;
+	u32				cfg_start;
+	u32				cfg_bus;
+};
+
+static int spi_delay_to_sclk(u32 slck_speed_hz, struct spi_delay *delay)
+{
+	u32 ns;
+
+	if (!delay)
+		return 0;
+
+	if (delay->unit == SPI_DELAY_UNIT_SCK)
+		return delay->value;
+
+	ns = spi_delay_to_ns(delay, NULL);
+	if (ns < 0)
+		return 0;
+
+	return DIV_ROUND_UP_ULL(slck_speed_hz * ns, NSEC_PER_SEC);
+}
+
+static inline u32 aml_spisg_sem_down_read(struct spisg_device *spisg)
+{
+	u32 ret;
+
+	regmap_read(spisg->map, SPISG_REG_CFG_READY, &ret);
+	if (ret)
+		regmap_write(spisg->map, SPISG_REG_CFG_READY, 0);
+
+	return ret;
+}
+
+static inline void aml_spisg_sem_up_write(struct spisg_device *spisg)
+{
+	regmap_write(spisg->map, SPISG_REG_CFG_READY, 1);
+}
+
+static int aml_spisg_set_speed(struct spisg_device *spisg, uint speed_hz)
+{
+	u32 cfg_bus;
+
+	if (!speed_hz || speed_hz == spisg->speed_hz)
+		return 0;
+
+	spisg->speed_hz = speed_hz;
+	clk_set_rate(spisg->sclk, speed_hz);
+	/* Store the div for the descriptor mode */
+	regmap_read(spisg->map, SPISG_REG_CFG_BUS, &cfg_bus);
+	spisg->cfg_bus &= ~CFG_CLK_DIV;
+	spisg->cfg_bus |= cfg_bus & CFG_CLK_DIV;
+	spisg->effective_speed_hz = clk_get_rate(spisg->sclk);
+	dev_dbg(&spisg->pdev->dev,
+		"desired speed %dHz, effective speed %dHz\n",
+		speed_hz, spisg->effective_speed_hz);
+
+	return 0;
+}
+
+static bool aml_spisg_can_dma(struct spi_controller *ctlr,
+			      struct spi_device *spi,
+			      struct spi_transfer *xfer)
+{
+	return true;
+}
+
+static void aml_spisg_sg_xlate(struct sg_table *sgt, struct spisg_sg_link *ccsg)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		ccsg->addr = FIELD_PREP(LINK_ADDR_VALID, 1) |
+			     FIELD_PREP(LINK_ADDR_RING, 0) |
+			     FIELD_PREP(LINK_ADDR_EOC, sg_is_last(sg)) |
+			     FIELD_PREP(LINK_ADDR_LEN, sg_dma_len(sg));
+		ccsg->addr1 = (u32)sg_dma_address(sg);
+		ccsg++;
+	}
+}
+
+static int nbits_to_lane[] = {
+	SPISG_SINGLE_SPI,
+	SPISG_SINGLE_SPI,
+	SPISG_DUAL_SPI,
+	-EINVAL,
+	SPISG_QUAD_SPI
+};
+
+static int aml_spisg_setup_transfer(struct spisg_device *spisg,
+				    struct spi_transfer *xfer,
+				    struct spisg_descriptor *desc,
+				    struct spisg_descriptor_extra *exdesc)
+{
+	int block_size, blocks;
+	struct device *dev = &spisg->pdev->dev;
+	struct spisg_sg_link *ccsg;
+	int ccsg_len;
+	dma_addr_t paddr;
+	int ret;
+
+	memset(desc, 0, sizeof(*desc));
+	if (exdesc)
+		memset(exdesc, 0, sizeof(*exdesc));
+	aml_spisg_set_speed(spisg, xfer->speed_hz);
+	xfer->effective_speed_hz = spisg->effective_speed_hz;
+
+	desc->cfg_start = spisg->cfg_start;
+	desc->cfg_bus = spisg->cfg_bus;
+
+	block_size = xfer->bits_per_word >> 3;
+	blocks = xfer->len / block_size;
+
+	desc->cfg_start |= FIELD_PREP(CFG_EOC, 0);
+	desc->cfg_bus |= FIELD_PREP(CFG_KEEP_SS, !xfer->cs_change);
+	desc->cfg_bus |= FIELD_PREP(CFG_NULL_CTL, 0);
+
+	if (xfer->tx_buf || xfer->tx_dma) {
+		desc->cfg_bus |= FIELD_PREP(CFG_LANE, nbits_to_lane[xfer->tx_nbits]);
+		desc->cfg_start |= FIELD_PREP(CFG_OP_MODE, SPISG_OP_MODE_WRITE);
+	}
+	if (xfer->rx_buf || xfer->rx_dma) {
+		desc->cfg_bus |= FIELD_PREP(CFG_LANE, nbits_to_lane[xfer->rx_nbits]);
+		desc->cfg_start |= FIELD_PREP(CFG_OP_MODE, SPISG_OP_MODE_READ);
+	}
+
+	if (FIELD_GET(CFG_OP_MODE, desc->cfg_start) == SPISG_OP_MODE_READ_STS) {
+		desc->cfg_start |= FIELD_PREP(CFG_BLOCK_SIZE, blocks) |
+				   FIELD_PREP(CFG_BLOCK_NUM, 1);
+	} else {
+		blocks = min_t(int, blocks, SPISG_BLOCK_MAX);
+		desc->cfg_start |= FIELD_PREP(CFG_BLOCK_SIZE, block_size & 0x7) |
+				   FIELD_PREP(CFG_BLOCK_NUM, blocks);
+	}
+
+	if (xfer->tx_sg.nents && xfer->tx_sg.sgl) {
+		ccsg_len = xfer->tx_sg.nents * sizeof(struct spisg_sg_link);
+		ccsg = kzalloc(ccsg_len, GFP_KERNEL | GFP_DMA);
+		if (!ccsg) {
+			dev_err(dev, "alloc tx_ccsg failed\n");
+			return -ENOMEM;
+		}
+
+		aml_spisg_sg_xlate(&xfer->tx_sg, ccsg);
+		paddr = dma_map_single(dev, (void *)ccsg,
+				       ccsg_len, DMA_TO_DEVICE);
+		ret = dma_mapping_error(dev, paddr);
+		if (ret) {
+			kfree(ccsg);
+			dev_err(dev, "tx ccsg map failed\n");
+			return ret;
+		}
+
+		desc->tx_paddr = paddr;
+		desc->cfg_start |= FIELD_PREP(CFG_TXD_MODE, SPISG_DATA_MODE_SG);
+		exdesc->tx_ccsg = ccsg;
+		exdesc->tx_ccsg_len = ccsg_len;
+		dma_sync_sgtable_for_device(spisg->controller->cur_tx_dma_dev,
+					    &xfer->tx_sg, DMA_TO_DEVICE);
+	} else if (xfer->tx_buf || xfer->tx_dma) {
+		paddr = xfer->tx_dma;
+		if (!paddr) {
+			paddr = dma_map_single(dev, (void *)xfer->tx_buf,
+					       xfer->len, DMA_TO_DEVICE);
+			ret = dma_mapping_error(dev, paddr);
+			if (ret) {
+				dev_err(dev, "tx buf map failed\n");
+				return ret;
+			}
+		}
+		desc->tx_paddr = paddr;
+		desc->cfg_start |= FIELD_PREP(CFG_TXD_MODE, SPISG_DATA_MODE_MEM);
+	}
+
+	if (xfer->rx_sg.nents && xfer->rx_sg.sgl) {
+		ccsg_len = xfer->rx_sg.nents * sizeof(struct spisg_sg_link);
+		ccsg = kzalloc(ccsg_len, GFP_KERNEL | GFP_DMA);
+		if (!ccsg) {
+			dev_err(dev, "alloc rx_ccsg failed\n");
+			return -ENOMEM;
+		}
+
+		aml_spisg_sg_xlate(&xfer->rx_sg, ccsg);
+		paddr = dma_map_single(dev, (void *)ccsg,
+				       ccsg_len, DMA_TO_DEVICE);
+		ret = dma_mapping_error(dev, paddr);
+		if (ret) {
+			kfree(ccsg);
+			dev_err(dev, "rx ccsg map failed\n");
+			return ret;
+		}
+
+		desc->rx_paddr = paddr;
+		desc->cfg_start |= FIELD_PREP(CFG_RXD_MODE, SPISG_DATA_MODE_SG);
+		exdesc->rx_ccsg = ccsg;
+		exdesc->rx_ccsg_len = ccsg_len;
+		dma_sync_sgtable_for_device(spisg->controller->cur_rx_dma_dev,
+					    &xfer->rx_sg, DMA_FROM_DEVICE);
+	} else if (xfer->rx_buf || xfer->rx_dma) {
+		paddr = xfer->rx_dma;
+		if (!paddr) {
+			paddr = dma_map_single(dev, xfer->rx_buf,
+					       xfer->len, DMA_FROM_DEVICE);
+			ret = dma_mapping_error(dev, paddr);
+			if (ret) {
+				dev_err(dev, "rx buf map failed\n");
+				return ret;
+			}
+		}
+
+		desc->rx_paddr = paddr;
+		desc->cfg_start |= FIELD_PREP(CFG_RXD_MODE, SPISG_DATA_MODE_MEM);
+	}
+
+	return 0;
+}
+
+static void aml_spisg_cleanup_transfer(struct spisg_device *spisg,
+				       struct spi_transfer *xfer,
+				       struct spisg_descriptor *desc,
+				       struct spisg_descriptor_extra *exdesc)
+{
+	struct device *dev = &spisg->pdev->dev;
+
+	if (desc->tx_paddr) {
+		if (FIELD_GET(CFG_TXD_MODE, desc->cfg_start) == SPISG_DATA_MODE_SG) {
+			dma_unmap_single(dev, (dma_addr_t)desc->tx_paddr,
+					 exdesc->tx_ccsg_len, DMA_TO_DEVICE);
+			kfree(exdesc->tx_ccsg);
+			dma_sync_sgtable_for_cpu(spisg->controller->cur_tx_dma_dev,
+						 &xfer->tx_sg, DMA_TO_DEVICE);
+		} else if (!xfer->tx_dma) {
+			dma_unmap_single(dev, (dma_addr_t)desc->tx_paddr,
+					 xfer->len, DMA_TO_DEVICE);
+		}
+	}
+
+	if (desc->rx_paddr) {
+		if (FIELD_GET(CFG_RXD_MODE, desc->cfg_start) == SPISG_DATA_MODE_SG) {
+			dma_unmap_single(dev, (dma_addr_t)desc->rx_paddr,
+					 exdesc->rx_ccsg_len, DMA_TO_DEVICE);
+			kfree(exdesc->rx_ccsg);
+			dma_sync_sgtable_for_cpu(spisg->controller->cur_rx_dma_dev,
+						 &xfer->rx_sg, DMA_FROM_DEVICE);
+		} else if (!xfer->rx_dma) {
+			dma_unmap_single(dev, (dma_addr_t)desc->rx_paddr,
+					 xfer->len, DMA_FROM_DEVICE);
+		}
+	}
+}
+
+static void aml_spisg_setup_null_desc(struct spisg_device *spisg,
+				      struct spisg_descriptor *desc,
+				      u32 n_sclk)
+{
+	/* unit is the last xfer sclk */
+	desc->cfg_start = spisg->cfg_start;
+	desc->cfg_bus = spisg->cfg_bus;
+
+	desc->cfg_start |= FIELD_PREP(CFG_OP_MODE, SPISG_OP_MODE_WRITE) |
+			   FIELD_PREP(CFG_BLOCK_SIZE, 1) |
+			   FIELD_PREP(CFG_BLOCK_NUM, DIV_ROUND_UP(n_sclk, 8));
+
+	desc->cfg_bus |= FIELD_PREP(CFG_NULL_CTL, 1);
+}
+
+static void aml_spisg_pending(struct spisg_device *spisg,
+			      dma_addr_t desc_paddr,
+			      bool trig,
+			      bool irq_en)
+{
+	u32 desc_l, desc_h, cfg_spi;
+
+#ifdef	CONFIG_ARCH_DMA_ADDR_T_64BIT
+	desc_l = (u64)desc_paddr & 0xffffffff;
+	desc_h = (u64)desc_paddr >> 32;
+#else
+	desc_l = desc_paddr & 0xffffffff;
+	desc_h = 0;
+#endif
+
+	cfg_spi = spisg->cfg_spi;
+	if (trig)
+		cfg_spi |= CFG_HW_POS;
+	else
+		desc_h |= LIST_DESC_PENDING;
+
+	regmap_write(spisg->map, SPISG_REG_IRQ_ENABLE, irq_en ? IRQ_DESC_CHAIN_DONE : 0);
+	regmap_write(spisg->map, SPISG_REG_CFG_SPI, cfg_spi);
+	regmap_write(spisg->map, SPISG_REG_DESC_LIST_L, desc_l);
+	regmap_write(spisg->map, SPISG_REG_DESC_LIST_H, desc_h);
+}
+
+static irqreturn_t aml_spisg_irq(int irq, void *data)
+{
+	struct spisg_device *spisg = (void *)data;
+	u32 sts;
+
+	spisg->status = 0;
+	regmap_read(spisg->map, SPISG_REG_IRQ_STS, &sts);
+	regmap_write(spisg->map, SPISG_REG_IRQ_STS, sts);
+	if (sts & (IRQ_RCH_DESC_INVALID |
+		   IRQ_RCH_DESC_RESP |
+		   IRQ_RCH_DATA_RESP |
+		   IRQ_WCH_DESC_INVALID |
+		   IRQ_WCH_DESC_RESP |
+		   IRQ_WCH_DATA_RESP |
+		   IRQ_DESC_ERR))
+		spisg->status = sts;
+
+	complete(&spisg->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int aml_spisg_transfer_one_message(struct spi_controller *ctlr,
+					  struct spi_message *msg)
+{
+	struct spisg_device *spisg = spi_controller_get_devdata(ctlr);
+	struct device *dev = &spisg->pdev->dev;
+	unsigned long long ms = 0;
+	struct spi_transfer *xfer;
+	struct spisg_descriptor *descs, *desc;
+	struct spisg_descriptor_extra *exdescs, *exdesc;
+	dma_addr_t descs_paddr;
+	int desc_num = 1, descs_len;
+	u32 cs_hold_in_sclk = 0;
+	int ret = -EIO;
+
+	if (!aml_spisg_sem_down_read(spisg)) {
+		spi_finalize_current_message(ctlr);
+		dev_err(dev, "controller busy\n");
+		return -EBUSY;
+	}
+
+	/* calculate the desc num for all xfer */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list)
+		desc_num++;
+
+	/* alloc descriptor/extra-descriptor table */
+	descs = kcalloc(desc_num, sizeof(*desc) + sizeof(*exdesc),
+			GFP_KERNEL | GFP_DMA);
+	if (!descs) {
+		spi_finalize_current_message(ctlr);
+		aml_spisg_sem_up_write(spisg);
+		return -ENOMEM;
+	}
+	descs_len = sizeof(*desc) * desc_num;
+	exdescs = (struct spisg_descriptor_extra *)(descs + desc_num);
+
+	/* config descriptor for each xfer */
+	desc = descs;
+	exdesc = exdescs;
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		ret = aml_spisg_setup_transfer(spisg, xfer, desc, exdesc);
+		if (ret) {
+			dev_err(dev, "config descriptor failed\n");
+			goto end;
+		}
+
+		/* calculate cs-setup delay with the first xfer speed */
+		if (list_is_first(&xfer->transfer_list, &msg->transfers))
+			desc->cfg_bus |= FIELD_PREP(CFG_CS_SETUP,
+				spi_delay_to_sclk(xfer->effective_speed_hz, &msg->spi->cs_setup));
+
+		/* calculate cs-hold delay with the last xfer speed */
+		if (list_is_last(&xfer->transfer_list, &msg->transfers))
+			cs_hold_in_sclk =
+				spi_delay_to_sclk(xfer->effective_speed_hz, &msg->spi->cs_hold);
+
+		desc++;
+		exdesc++;
+		ms += DIV_ROUND_UP_ULL(8LL * MSEC_PER_SEC * xfer->len,
+				       xfer->effective_speed_hz);
+	}
+
+	if (cs_hold_in_sclk)
+		/* additional null-descriptor to achieve the cs-hold delay */
+		aml_spisg_setup_null_desc(spisg, desc, cs_hold_in_sclk);
+	else
+		desc--;
+
+	desc->cfg_bus |= FIELD_PREP(CFG_KEEP_SS, 0);
+	desc->cfg_start |= FIELD_PREP(CFG_EOC, 1);
+
+	/* some tolerances */
+	ms += ms + 20;
+	if (ms > UINT_MAX)
+		ms = UINT_MAX;
+
+	descs_paddr = dma_map_single(dev, (void *)descs,
+				     descs_len, DMA_TO_DEVICE);
+	ret = dma_mapping_error(dev, descs_paddr);
+	if (ret) {
+		dev_err(dev, "desc table map failed\n");
+		goto end;
+	}
+
+	reinit_completion(&spisg->completion);
+	aml_spisg_pending(spisg, descs_paddr, false, true);
+	if (wait_for_completion_timeout(&spisg->completion,
+					spi_controller_is_target(spisg->controller) ?
+					MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(ms)))
+		ret = spisg->status ? -EIO : 0;
+	else
+		ret = -ETIMEDOUT;
+
+	dma_unmap_single(dev, descs_paddr, descs_len, DMA_TO_DEVICE);
+end:
+	desc = descs;
+	exdesc = exdescs;
+	list_for_each_entry(xfer, &msg->transfers, transfer_list)
+		aml_spisg_cleanup_transfer(spisg, xfer, desc++, exdesc++);
+	kfree(descs);
+
+	if (!ret)
+		msg->actual_length = msg->frame_length;
+	msg->status = ret;
+	spi_finalize_current_message(ctlr);
+	aml_spisg_sem_up_write(spisg);
+
+	return ret;
+}
+
+static int aml_spisg_prepare_message(struct spi_controller *ctlr,
+				     struct spi_message *message)
+{
+	struct spisg_device *spisg = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = message->spi;
+
+	if (!spi->bits_per_word || spi->bits_per_word % 8) {
+		dev_err(&spisg->pdev->dev, "invalid wordlen %d\n", spi->bits_per_word);
+		return -EINVAL;
+	}
+
+	spisg->bytes_per_word = spi->bits_per_word >> 3;
+
+	spisg->cfg_spi &= ~CFG_SLAVE_SELECT;
+	spisg->cfg_spi |= FIELD_PREP(CFG_SLAVE_SELECT, spi_get_chipselect(spi, 0));
+
+	spisg->cfg_bus &= ~(CFG_CPOL | CFG_CPHA | CFG_B_L_ENDIAN | CFG_HALF_DUPLEX);
+	spisg->cfg_bus |= FIELD_PREP(CFG_CPOL, !!(spi->mode & SPI_CPOL)) |
+			  FIELD_PREP(CFG_CPHA, !!(spi->mode & SPI_CPHA)) |
+			  FIELD_PREP(CFG_B_L_ENDIAN, !!(spi->mode & SPI_LSB_FIRST)) |
+			  FIELD_PREP(CFG_HALF_DUPLEX, !!(spi->mode & SPI_3WIRE));
+
+	return 0;
+}
+
+static int aml_spisg_setup(struct spi_device *spi)
+{
+	if (!spi->controller_state)
+		spi->controller_state = spi_controller_get_devdata(spi->controller);
+
+	return 0;
+}
+
+static void aml_spisg_cleanup(struct spi_device *spi)
+{
+	spi->controller_state = NULL;
+}
+
+static int aml_spisg_target_abort(struct spi_controller *ctlr)
+{
+	struct spisg_device *spisg = spi_controller_get_devdata(ctlr);
+
+	spisg->status = 0;
+	regmap_write(spisg->map, SPISG_REG_DESC_LIST_H, 0);
+	complete(&spisg->completion);
+
+	return 0;
+}
+
+static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
+{
+	struct device *dev = &spisg->pdev->dev;
+	struct clk_init_data init;
+	struct clk_divider *div;
+	struct clk_div_table *tbl;
+	const char *parent_names[1];
+	char name[32];
+	int i;
+
+	spisg->core = devm_clk_get_enabled(dev, "core");
+	if (IS_ERR_OR_NULL(spisg->core)) {
+		dev_err(dev, "core clock request failed\n");
+		return PTR_ERR(spisg->core);
+	}
+
+	spisg->pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR_OR_NULL(spisg->pclk)) {
+		dev_err(dev, "pclk clock request failed\n");
+		return PTR_ERR(spisg->pclk);
+	}
+
+	clk_set_min_rate(spisg->pclk, SPISG_PCLK_RATE_MIN);
+
+	clk_disable_unprepare(spisg->pclk);
+
+	tbl = devm_kzalloc(dev, sizeof(struct clk_div_table) * (DIV_NUM + 1), GFP_KERNEL);
+	if (!tbl)
+		return -ENOMEM;
+
+	for (i = 0; i < DIV_NUM; i++) {
+		tbl[i].val = i + SPISG_CLK_DIV_MIN - 1;
+		tbl[i].div = i + SPISG_CLK_DIV_MIN;
+	}
+	spisg->tbl = tbl;
+
+	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return -ENOMEM;
+
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+	div->reg = base + SPISG_REG_CFG_BUS;
+	div->shift = __bf_shf(CFG_CLK_DIV);
+	div->width = CLK_DIV_WIDTH;
+	div->table = tbl;
+
+	/* Register value should not be outside of the table */
+	regmap_update_bits(spisg->map, SPISG_REG_CFG_BUS, CFG_CLK_DIV,
+			   FIELD_PREP(CFG_CLK_DIV, SPISG_CLK_DIV_MIN - 1));
+
+	/* Register clk-divider */
+	parent_names[0] = __clk_get_name(spisg->pclk);
+	snprintf(name, sizeof(name), "%s_div", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_divider_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+	div->hw.init = &init;
+
+	spisg->sclk = devm_clk_register(dev, &div->hw);
+	if (IS_ERR_OR_NULL(spisg->sclk)) {
+		dev_err(dev, "clock registration failed\n");
+		return PTR_ERR(spisg->sclk);
+	}
+
+	clk_prepare_enable(spisg->sclk);
+
+	return 0;
+}
+
+static int aml_spisg_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct spisg_device *spisg;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int ret, irq;
+
+	const struct regmap_config aml_regmap_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.max_register = SPISG_MAX_REG,
+	};
+
+	if (of_property_read_bool(dev->of_node, "slave"))
+		ctlr = spi_alloc_target(dev, sizeof(*spisg));
+	else
+		ctlr = spi_alloc_host(dev, sizeof(*spisg));
+	if (!ctlr)
+		return dev_err_probe(dev, -ENOMEM, "controller allocation failed\n");
+
+	spisg = spi_controller_get_devdata(ctlr);
+	spisg->controller = ctlr;
+
+	spisg->pdev = pdev;
+	platform_set_drvdata(pdev, spisg);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "resource ioremap failed\n");
+
+	spisg->map = devm_regmap_init_mmio(dev, base, &aml_regmap_config);
+	if (IS_ERR(spisg->map))
+		return dev_err_probe(dev, PTR_ERR(spisg->map), "regmap init failed\n");
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto out_controller;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, aml_spisg_irq, 0, NULL, spisg);
+	if (ret) {
+		dev_err(&pdev->dev, "irq request failed\n");
+		goto out_controller;
+	}
+
+	ret = aml_spisg_clk_init(spisg, base);
+	if (ret)
+		goto out_controller;
+
+	spisg->cfg_spi = 0;
+	spisg->cfg_start = 0;
+	spisg->cfg_bus = 0;
+
+	spisg->cfg_spi = FIELD_PREP(CFG_SFLASH_WP, 1) |
+			 FIELD_PREP(CFG_SFLASH_HD, 1);
+	if (spi_controller_is_target(ctlr)) {
+		spisg->cfg_spi |= FIELD_PREP(CFG_SLAVE_EN, 1);
+		spisg->cfg_bus = FIELD_PREP(CFG_TX_TUNING, 0xf);
+	}
+	/* default pending */
+	spisg->cfg_start = FIELD_PREP(CFG_PEND, 1);
+
+	pm_runtime_set_active(&spisg->pdev->dev);
+	pm_runtime_enable(&spisg->pdev->dev);
+	pm_runtime_resume_and_get(&spisg->pdev->dev);
+
+	device_reset_optional(dev);
+	ctlr->num_chipselect = 4;
+	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST |
+			  SPI_3WIRE | SPI_TX_QUAD | SPI_RX_QUAD;
+	ctlr->max_speed_hz = 1000 * 1000 * 100;
+	ctlr->min_speed_hz = 1000 * 10;
+	ctlr->setup = aml_spisg_setup;
+	ctlr->cleanup = aml_spisg_cleanup;
+	ctlr->prepare_message = aml_spisg_prepare_message;
+	ctlr->transfer_one_message = aml_spisg_transfer_one_message;
+	ctlr->target_abort = aml_spisg_target_abort;
+	ctlr->can_dma = aml_spisg_can_dma;
+	ctlr->max_dma_len = SPISG_BLOCK_MAX;
+	ctlr->auto_runtime_pm = true;
+
+	dma_set_max_seg_size(&pdev->dev, SPISG_BLOCK_MAX);
+	ret = devm_spi_register_controller(dev, ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi controller registration failed\n");
+		goto out_clk;
+	}
+
+	init_completion(&spisg->completion);
+
+	pm_runtime_put(&spisg->pdev->dev);
+
+	return 0;
+out_clk:
+	if (spisg->core)
+		clk_disable_unprepare(spisg->core);
+	clk_disable_unprepare(spisg->pclk);
+out_controller:
+	spi_controller_put(ctlr);
+
+	return ret;
+}
+
+static void aml_spisg_remove(struct platform_device *pdev)
+{
+	struct spisg_device *spisg = platform_get_drvdata(pdev);
+
+	if (!pm_runtime_suspended(&pdev->dev)) {
+		pinctrl_pm_select_sleep_state(&spisg->pdev->dev);
+		clk_disable_unprepare(spisg->core);
+		clk_disable_unprepare(spisg->pclk);
+	}
+}
+
+static int spisg_suspend_runtime(struct device *dev)
+{
+	struct spisg_device *spisg = dev_get_drvdata(dev);
+
+	pinctrl_pm_select_sleep_state(&spisg->pdev->dev);
+	clk_disable_unprepare(spisg->sclk);
+	clk_disable_unprepare(spisg->core);
+
+	return 0;
+}
+
+static int spisg_resume_runtime(struct device *dev)
+{
+	struct spisg_device *spisg = dev_get_drvdata(dev);
+
+	clk_prepare_enable(spisg->core);
+	clk_prepare_enable(spisg->sclk);
+	pinctrl_pm_select_default_state(&spisg->pdev->dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops amlogic_spisg_pm_ops = {
+	.runtime_suspend	= spisg_suspend_runtime,
+	.runtime_resume		= spisg_resume_runtime,
+};
+
+static const struct of_device_id amlogic_spisg_of_match[] = {
+	{
+		.compatible = "amlogic,a4-spisg",
+	},
+
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, amlogic_spisg_of_match);
+
+static struct platform_driver amlogic_spisg_driver = {
+	.probe = aml_spisg_probe,
+	.remove = aml_spisg_remove,
+	.driver  = {
+		.name = "amlogic-spisg",
+		.of_match_table = of_match_ptr(amlogic_spisg_of_match),
+		.pm = &amlogic_spisg_pm_ops,
+	},
+};
+
+module_platform_driver(amlogic_spisg_driver);
+
+MODULE_DESCRIPTION("Amlogic SPI Scatter-Gather Controller driver");
+MODULE_AUTHOR("Sunny Luo <sunny.luo@amlogic.com>");
+MODULE_LICENSE("GPL");

-- 
2.37.1



