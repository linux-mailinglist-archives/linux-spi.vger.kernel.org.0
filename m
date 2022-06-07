Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2918F53F768
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jun 2022 09:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiFGHkq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jun 2022 03:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiFGHkl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jun 2022 03:40:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36EB82E8;
        Tue,  7 Jun 2022 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654587639; x=1686123639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t01Q373aC/fOkytkIRu4axBkhJnImgzP+7a036VrlaU=;
  b=XXb6ap0F3BQNCOGmBROzRTuVsdfgJr7Ie77CCc9xX/F2MvXa5bDHepgC
   y9Nky133td6Dkd4U3R1bY1OvwlrLszv1tMDaYYp1mzROuVk8U4LslmAn3
   pcZlbCew6PjfWfCOmTU7CqJAfTXz0nTdMux6nbBqHiho42BkEVtYfTEn1
   n1qAXfU7fNjVzw4w3rNGvOq2uzR7QDZmx323n/NhgLu5ZeUys0Olhr2c2
   JtvIZtDSj2LlHB5PVoUEidQjcG6n+i1FlWdycAPM4p/Lhw5T7auxs34+i
   BtX3Up7n11McP/7SI6moym8Xc2JCDl3m7A6SbvvvxODkXCsUeOo/WIcre
   w==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="98876891"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 00:40:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 00:40:36 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Jun 2022 00:40:34 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 1/2] spi: add support for microchip fpga spi controllers
Date:   Tue, 7 Jun 2022 08:38:33 +0100
Message-ID: <20220607073833.2331539-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607073833.2331539-1-conor.dooley@microchip.com>
References: <20220607073833.2331539-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a driver for Microchip FPGA SPI controllers, specifically
supporting the "hard" controllers on PolarFire SoC.

Co-developed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/Kconfig              |   9 +
 drivers/spi/Makefile             |   1 +
 drivers/spi/spi-microchip-core.c | 632 +++++++++++++++++++++++++++++++
 3 files changed, 642 insertions(+)
 create mode 100644 drivers/spi/spi-microchip-core.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d2815eb361c0..b142e3499bc9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -565,6 +565,15 @@ config SPI_MESON_SPIFC
 	  This enables master mode support for the SPIFC (SPI flash
 	  controller) available in Amlogic Meson SoCs.
 
+config SPI_MICROCHIP_CORE
+	tristate "Microchip FPGA SPI controllers"
+	depends on SPI_MASTER
+	help
+	  This enables the SPI driver for Microchip FPGA SPI controllers.
+	  Say Y or M here if you want to use the "hard" controllers on
+	  PolarFire SoC.
+	  If built as a module, it will be called spi-microchip-core.
+
 config SPI_MT65XX
 	tristate "MediaTek SPI controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 3aa28ed3f761..b1e559ff17a9 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
 obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
+obj-$(CONFIG_SPI_MICROCHIP_CORE)	+= spi-microchip-core.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
new file mode 100644
index 000000000000..5b2aee30fa04
--- /dev/null
+++ b/drivers/spi/spi-microchip-core.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Microchip CoreSPI SPI controller driver
+ *
+ * Copyright (c) 2018-2022 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ *
+ */
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
+#define MAX_LEN				(0xffff)
+#define MAX_CS				(8)
+#define DEFAULT_FRAMESIZE		(8)
+#define FIFO_DEPTH			(32)
+#define CLK_GEN_MODE1_MAX		(255)
+#define CLK_GEN_MODE0_MAX		(15)
+#define CLK_GEN_MIN			(0)
+#define MODE_X_MASK_SHIFT		(24)
+
+#define CONTROL_ENABLE			BIT(0)
+#define CONTROL_MASTER			BIT(1)
+#define CONTROL_RX_DATA_INT		BIT(4)
+#define CONTROL_TX_DATA_INT		BIT(5)
+#define CONTROL_RX_OVER_INT		BIT(6)
+#define CONTROL_TX_UNDER_INT		BIT(7)
+#define CONTROL_SPO			BIT(24)
+#define CONTROL_SPH			BIT(25)
+#define CONTROL_SPS			BIT(26)
+#define CONTROL_FRAMEURUN		BIT(27)
+#define CONTROL_CLKMODE			BIT(28)
+#define CONTROL_BIGFIFO			BIT(29)
+#define CONTROL_OENOFF			BIT(30)
+#define CONTROL_RESET			BIT(31)
+
+#define CONTROL_MODE_MASK		GENMASK(3, 2)
+#define  MOTOROLA_MODE			(0)
+#define CONTROL_FRAMECNT_MASK		GENMASK(23, 8)
+#define CONTROL_FRAMECNT_SHIFT		(8)
+
+#define STATUS_ACTIVE			BIT(14)
+#define STATUS_SSEL			BIT(13)
+#define STATUS_FRAMESTART		BIT(12)
+#define STATUS_TXFIFO_EMPTY_NEXT_READ	BIT(11)
+#define STATUS_TXFIFO_EMPTY		BIT(10)
+#define STATUS_TXFIFO_FULL_NEXT_WRITE	BIT(9)
+#define STATUS_TXFIFO_FULL		BIT(8)
+#define STATUS_RXFIFO_EMPTY_NEXT_READ	BIT(7)
+#define STATUS_RXFIFO_EMPTY		BIT(6)
+#define STATUS_RXFIFO_FULL_NEXT_WRITE	BIT(5)
+#define STATUS_RXFIFO_FULL		BIT(4)
+#define STATUS_TX_UNDERRUN		BIT(3)
+#define STATUS_RX_OVERFLOW		BIT(2)
+#define STATUS_RXDAT_RXED		BIT(1)
+#define STATUS_TXDAT_SENT		BIT(0)
+
+#define INT_TXDONE			BIT(0)
+#define INT_RXRDY			BIT(1)
+#define INT_RX_CHANNEL_OVERFLOW		BIT(2)
+#define INT_TX_CHANNEL_UNDERRUN		BIT(3)
+
+#define INT_ENABLE_MASK (CONTROL_RX_DATA_INT | CONTROL_TX_DATA_INT | \
+			 CONTROL_RX_OVER_INT | CONTROL_TX_UNDER_INT)
+
+#define REG_CONTROL		(0x00)
+#define REG_FRAME_SIZE		(0x04)
+#define REG_STATUS		(0x08)
+#define REG_INT_CLEAR		(0x0c)
+#define REG_RX_DATA		(0x10)
+#define REG_TX_DATA		(0x14)
+#define REG_CLK_GEN		(0x18)
+#define REG_SLAVE_SELECT	(0x1c)
+#define  SSEL_MASK		GENMASK(7, 0)
+#define  SSEL_DIRECT		BIT(8)
+#define  SSELOUT_SHIFT		9
+#define  SSELOUT		BIT(SSELOUT_SHIFT)
+#define REG_MIS			(0x20)
+#define REG_RIS			(0x24)
+#define REG_CONTROL2		(0x28)
+#define REG_COMMAND		(0x2c)
+#define REG_PKTSIZE		(0x30)
+#define REG_CMD_SIZE		(0x34)
+#define REG_HWSTATUS		(0x38)
+#define REG_STAT8		(0x3c)
+#define REG_CTRL2		(0x48)
+#define REG_FRAMESUP		(0x50)
+
+struct mchp_corespi {
+	void __iomem *regs;
+	struct clk *clk;
+	const u8 *tx_buf;
+	u8 *rx_buf;
+	u32 clk_gen; /* divider for spi output clock generated by the controller */
+	u32 clk_mode;
+	int irq;
+	int tx_len;
+	int rx_len;
+	int pending;
+};
+
+static inline u32 mchp_corespi_read(struct mchp_corespi *spi, unsigned int reg)
+{
+	return readl(spi->regs + reg);
+}
+
+static inline void mchp_corespi_write(struct mchp_corespi *spi, unsigned int reg, u32 val)
+{
+	writel(val, spi->regs + reg);
+}
+
+static inline void mchp_corespi_enable(struct mchp_corespi *spi)
+{
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
+
+	control |= CONTROL_ENABLE;
+
+	mchp_corespi_write(spi, REG_CONTROL, control);
+}
+
+static inline void mchp_corespi_disable(struct mchp_corespi *spi)
+{
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
+
+	control &= ~CONTROL_ENABLE;
+
+	mchp_corespi_write(spi, REG_CONTROL, control);
+}
+
+static inline void mchp_corespi_read_fifo(struct mchp_corespi *spi)
+{
+	u8 data;
+	int fifo_max, i = 0;
+
+	fifo_max = min(spi->rx_len, FIFO_DEPTH);
+
+	while ((i < fifo_max) && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_RXFIFO_EMPTY)) {
+		data = mchp_corespi_read(spi, REG_RX_DATA);
+
+		if (spi->rx_buf)
+			*spi->rx_buf++ = data;
+		i++;
+	}
+	spi->rx_len -= i;
+	spi->pending -= i;
+}
+
+static void mchp_corespi_enable_ints(struct mchp_corespi *spi)
+{
+	u32 control, mask = INT_ENABLE_MASK;
+
+	mchp_corespi_disable(spi);
+
+	control = mchp_corespi_read(spi, REG_CONTROL);
+
+	control |= mask;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+
+	control |= CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+}
+
+static void mchp_corespi_disable_ints(struct mchp_corespi *spi)
+{
+	u32 control, mask = INT_ENABLE_MASK;
+
+	mchp_corespi_disable(spi);
+
+	control = mchp_corespi_read(spi, REG_CONTROL);
+	control &= ~mask;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+
+	control |= CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+}
+
+static inline void mchp_corespi_set_xfer_size(struct mchp_corespi *spi, int len)
+{
+	u32 control;
+	u16 lenpart;
+
+	/*
+	 * Disable the SPI controller. Writes to transfer length have
+	 * no effect when the controller is enabled.
+	 */
+	mchp_corespi_disable(spi);
+
+	/*
+	 * The lower 16 bits of the frame count are stored in the control reg
+	 * for legacy reasons, but the upper 16 written to a different register:
+	 * FRAMESUP. While both the upper and lower bits can be *READ* from the
+	 * FRAMESUP register, writing to the lower 16 bits is a NOP
+	 */
+	lenpart = len & 0xffff;
+
+	control = mchp_corespi_read(spi, REG_CONTROL);
+	control &= ~CONTROL_FRAMECNT_MASK;
+	control |= lenpart << CONTROL_FRAMECNT_SHIFT;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+
+	lenpart = len & 0xffff0000;
+	mchp_corespi_write(spi, REG_FRAMESUP, lenpart);
+
+	control |= CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+}
+
+static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi)
+{
+	u8 byte;
+	int fifo_max, i = 0;
+
+	fifo_max = min(spi->tx_len, FIFO_DEPTH);
+	mchp_corespi_set_xfer_size(spi, fifo_max);
+
+	while ((i < fifo_max) && !(mchp_corespi_read(spi, REG_STATUS) & STATUS_TXFIFO_FULL)) {
+		byte = spi->tx_buf ? *spi->tx_buf++ : 0xaa;
+		mchp_corespi_write(spi, REG_TX_DATA, byte);
+		i++;
+	}
+
+	spi->tx_len -= i;
+	spi->pending += i;
+}
+
+static inline void mchp_corespi_set_framesize(struct mchp_corespi *spi, int bt)
+{
+	u32 control;
+
+	/*
+	 * Disable the SPI controller. Writes to the frame size have
+	 * no effect when the controller is enabled.
+	 */
+	mchp_corespi_disable(spi);
+
+	mchp_corespi_write(spi, REG_FRAME_SIZE, bt);
+
+	control = mchp_corespi_read(spi, REG_CONTROL);
+	control |= CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+}
+
+static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
+{
+	u32 reg;
+	struct mchp_corespi *corespi = spi_master_get_devdata(spi->master);
+
+	reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
+	reg &= ~BIT(spi->chip_select);
+	reg |= !disable << spi->chip_select;
+
+	mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
+}
+
+static int mchp_corespi_setup(struct spi_device *spi)
+{
+	struct mchp_corespi *corespi = spi_master_get_devdata(spi->master);
+	u32 reg;
+
+	/*
+	 * Active high slaves need to be specifically set to their inactive
+	 * states during probe by adding them to the "control group" & thus
+	 * driving their select line low.
+	 */
+	if (spi->mode & SPI_CS_HIGH) {
+		reg = mchp_corespi_read(corespi, REG_SLAVE_SELECT);
+		reg |= BIT(spi->chip_select);
+		mchp_corespi_write(corespi, REG_SLAVE_SELECT, reg);
+	}
+	return 0;
+}
+
+static void mchp_corespi_init(struct spi_master *master, struct mchp_corespi *spi)
+{
+	unsigned long clk_hz;
+	u32 control = mchp_corespi_read(spi, REG_CONTROL);
+
+	control |= CONTROL_MASTER;
+
+	control &= ~CONTROL_MODE_MASK;
+	control |= MOTOROLA_MODE;
+
+	mchp_corespi_set_framesize(spi, DEFAULT_FRAMESIZE);
+
+	/* max. possible spi clock rate is the apb clock rate */
+	clk_hz = clk_get_rate(spi->clk);
+	master->max_speed_hz = clk_hz;
+
+	/*
+	 * The controller must be configured so that it doesn't remove Chip
+	 * Select until the entire message has been transferred, even if at
+	 * some points TX FIFO becomes empty.
+	 *
+	 * BIGFIFO mode is also enabled, which sets the fifo depth to 32 frames
+	 * for the 8 bit transfers that this driver uses.
+	 */
+	control = mchp_corespi_read(spi, REG_CONTROL);
+	control |= CONTROL_SPS | CONTROL_BIGFIFO;
+
+	mchp_corespi_write(spi, REG_CONTROL, control);
+
+	mchp_corespi_enable_ints(spi);
+
+	/*
+	 * It is required to enable direct mode, otherwise control over the chip
+	 * select is relinquished to the hardware. SSELOUT is enabled too so we
+	 * can deal with active high slaves.
+	 */
+	mchp_corespi_write(spi, REG_SLAVE_SELECT, SSELOUT | SSEL_DIRECT);
+
+	control = mchp_corespi_read(spi, REG_CONTROL);
+
+	control &= ~CONTROL_RESET;
+	control |= CONTROL_ENABLE;
+
+	mchp_corespi_write(spi, REG_CONTROL, control);
+}
+
+static inline void mchp_corespi_set_clk_gen(struct mchp_corespi *spi)
+{
+	u32 control;
+
+	mchp_corespi_disable(spi);
+
+	control = mchp_corespi_read(spi, REG_CONTROL);
+	if (spi->clk_mode)
+		control |= CONTROL_CLKMODE;
+	else
+		control &= ~CONTROL_CLKMODE;
+
+	mchp_corespi_write(spi, REG_CLK_GEN, spi->clk_gen);
+	mchp_corespi_write(spi, REG_CONTROL, control);
+	mchp_corespi_write(spi, REG_CONTROL, control | CONTROL_ENABLE);
+}
+
+static inline void mchp_corespi_set_mode(struct mchp_corespi *spi, unsigned int mode)
+{
+	u32 control, mode_val;
+
+	switch (mode & SPI_MODE_X_MASK) {
+	case SPI_MODE_0:
+		mode_val = 0;
+		break;
+	case SPI_MODE_1:
+		mode_val = CONTROL_SPH;
+		break;
+	case SPI_MODE_2:
+		mode_val = CONTROL_SPO;
+		break;
+	case SPI_MODE_3:
+		mode_val = CONTROL_SPH | CONTROL_SPO;
+		break;
+	}
+
+	/*
+	 * Disable the SPI controller. Writes to the frame size have
+	 * no effect when the controller is enabled.
+	 */
+	mchp_corespi_disable(spi);
+
+	control = mchp_corespi_read(spi, REG_CONTROL);
+	control &= ~(SPI_MODE_X_MASK << MODE_X_MASK_SHIFT);
+	control |= mode_val;
+
+	mchp_corespi_write(spi, REG_CONTROL, control);
+
+	control |= CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
+}
+
+static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
+{
+	struct spi_master *master = dev_id;
+	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	u32 intfield = mchp_corespi_read(spi, REG_MIS) & 0xf;
+	bool finalise = false;
+
+	/* Interrupt line may be shared and not for us at all */
+	if (intfield == 0)
+		return IRQ_NONE;
+
+	if (intfield & INT_TXDONE) {
+		mchp_corespi_write(spi, REG_INT_CLEAR, INT_TXDONE);
+
+		if (spi->rx_len)
+			mchp_corespi_read_fifo(spi);
+
+		if (spi->tx_len)
+			mchp_corespi_write_fifo(spi);
+
+		if (!spi->rx_len)
+			finalise = true;
+	}
+
+	if (intfield & INT_RXRDY)
+		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RXRDY);
+
+	if (intfield & INT_RX_CHANNEL_OVERFLOW) {
+		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RX_CHANNEL_OVERFLOW);
+		finalise = true;
+		dev_err(&master->dev,
+			"%s: RX OVERFLOW: rxlen: %d, txlen: %d\n", __func__,
+			spi->rx_len, spi->tx_len);
+	}
+
+	if (intfield & INT_TX_CHANNEL_UNDERRUN) {
+		mchp_corespi_write(spi, REG_INT_CLEAR, INT_TX_CHANNEL_UNDERRUN);
+		finalise = true;
+		dev_err(&master->dev,
+			"%s: TX UNDERFLOW: rxlen: %d, txlen: %d\n", __func__,
+			spi->rx_len, spi->tx_len);
+	}
+
+	if (finalise)
+		spi_finalize_current_transfer(master);
+
+	return IRQ_HANDLED;
+}
+
+static int mchp_corespi_calculate_clkgen(struct mchp_corespi *spi,
+					 unsigned long target_hz)
+{
+	unsigned long clk_hz, spi_hz, clk_gen;
+
+	clk_hz = clk_get_rate(spi->clk);
+	spi_hz = min(target_hz, clk_hz);
+
+	/*
+	 * There are two possible clock modes for the controller generated
+	 * clock's division ratio:
+	 * CLK_MODE = 0: 1 / (2^(CLK_GEN + 1)) where CLK_GEN = 0 to 15.
+	 * CLK_MODE = 1: 1 / (2 * CLK_GEN + 1) where CLK_GEN = 0 to 255.
+	 * First try mode 1, fall back to 0 and if we have tried both modes and
+	 * we /still/ can't get a good setting, we then throw the toys out of
+	 * the pram and give up
+	 * clk_gen is the register name for the clock divider on MPFS.
+	 */
+	clk_gen = DIV_ROUND_UP(clk_hz, 2 * spi_hz) - 1;
+	if (clk_gen > CLK_GEN_MODE1_MAX || clk_gen <= CLK_GEN_MIN) {
+		clk_gen = DIV_ROUND_UP(clk_hz, spi_hz);
+		clk_gen = fls(clk_gen) - 1;
+
+		if (clk_gen > CLK_GEN_MODE0_MAX)
+			return -EINVAL;
+
+		spi->clk_mode = 0;
+	} else {
+		spi->clk_mode = 1;
+	}
+
+	spi->clk_gen = clk_gen;
+	return 0;
+}
+
+static int mchp_corespi_transfer_one(struct spi_master *master,
+				     struct spi_device *spi_dev,
+				     struct spi_transfer *xfer)
+{
+	struct mchp_corespi *spi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = mchp_corespi_calculate_clkgen(spi, (unsigned long)xfer->speed_hz);
+	if (ret) {
+		dev_err(&master->dev, "failed to set clk_gen for target %u Hz\n", xfer->speed_hz);
+		return ret;
+	}
+
+	mchp_corespi_set_clk_gen(spi);
+
+	spi->tx_buf = xfer->tx_buf;
+	spi->rx_buf = xfer->rx_buf;
+	spi->tx_len = xfer->len;
+	spi->rx_len = xfer->len;
+	spi->pending = 0;
+
+	mchp_corespi_set_xfer_size(spi, (spi->tx_len > FIFO_DEPTH)
+				   ? FIFO_DEPTH : spi->tx_len);
+
+	if (spi->tx_len)
+		mchp_corespi_write_fifo(spi);
+	return 1;
+}
+
+static int mchp_corespi_prepare_message(struct spi_master *master,
+					struct spi_message *msg)
+{
+	struct spi_device *spi_dev = msg->spi;
+	struct mchp_corespi *spi = spi_master_get_devdata(master);
+
+	mchp_corespi_set_framesize(spi, DEFAULT_FRAMESIZE);
+	mchp_corespi_set_mode(spi, spi_dev->mode);
+
+	return 0;
+}
+
+static int mchp_corespi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct mchp_corespi *spi;
+	struct resource *res;
+	u32 num_cs;
+	int ret = 0;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
+	if (!master)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "unable to allocate master for SPI controller\n");
+
+	platform_set_drvdata(pdev, master);
+
+	if (of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs))
+		num_cs = MAX_CS;
+
+	master->num_chipselect = num_cs;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->setup = mchp_corespi_setup;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->transfer_one = mchp_corespi_transfer_one;
+	master->prepare_message = mchp_corespi_prepare_message;
+	master->set_cs = mchp_corespi_set_cs;
+	master->dev.of_node = pdev->dev.of_node;
+
+	spi = spi_master_get_devdata(master);
+
+	spi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(spi->regs)) {
+		ret = PTR_ERR(spi->regs);
+		goto error_release_master;
+	}
+
+	spi->irq = platform_get_irq(pdev, 0);
+	if (spi->irq <= 0) {
+		dev_err(&pdev->dev, "invalid IRQ %d for SPI controller\n", spi->irq);
+		ret = spi->irq;
+		goto error_release_master;
+	}
+
+	ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
+			       IRQF_SHARED, dev_name(&pdev->dev), master);
+	if (ret) {
+		dev_err(&pdev->dev, "could not request irq: %d\n", ret);
+		goto error_release_master;
+	}
+
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!spi->clk || IS_ERR(spi->clk)) {
+		ret = PTR_ERR(spi->clk);
+		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
+		goto error_release_master;
+	}
+
+	ret = clk_prepare_enable(spi->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock\n");
+		goto error_release_master;
+	}
+
+	mchp_corespi_init(master, spi);
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to register master for SPI controller\n");
+		goto error_release_hardware;
+	}
+
+	dev_info(&pdev->dev, "Registered SPI controller %d\n", master->bus_num);
+
+	return 0;
+
+error_release_hardware:
+	mchp_corespi_disable(spi);
+	clk_prepare_enable(spi->clk);
+error_release_master:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int mchp_corespi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master  = platform_get_drvdata(pdev);
+	struct mchp_corespi *spi = spi_master_get_devdata(master);
+
+	mchp_corespi_disable_ints(spi);
+	spi_unregister_master(master);
+	spi_master_put(master);
+	clk_disable_unprepare(spi->clk);
+	mchp_corespi_disable(spi);
+
+	return 0;
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
+	{ .compatible = "microchip,mpfs-spi" },
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
+		.owner = THIS_MODULE,
+	},
+	.remove = mchp_corespi_remove,
+};
+module_platform_driver(mchp_corespi_driver);
+MODULE_DESCRIPTION("Microchip coreSPI SPI controller driver");
+MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.36.1

