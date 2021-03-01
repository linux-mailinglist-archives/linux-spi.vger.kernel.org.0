Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2429327DBA
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 12:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhCAL5O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 06:57:14 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13391 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbhCAL4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Mar 2021 06:56:25 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DpzDy4D4Cz7l1R;
        Mon,  1 Mar 2021 19:53:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 19:55:26 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH] spi: Add HiSilicon SPI controller driver support
Date:   Mon, 1 Mar 2021 19:56:11 +0800
Message-ID: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver supports SPI Controller for HiSilicon Kunpeng SOCs. This
driver supports SPI operations using FIFO mode of transfer.

DMA is not supported, and we just use IRQ mode for operation completion
notification.

Only ACPI firmware is supported.

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 MAINTAINERS            |   7 +
 drivers/spi/Kconfig    |  10 +
 drivers/spi/Makefile   |   1 +
 drivers/spi/spi-hisi.c | 573 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 591 insertions(+)
 create mode 100644 drivers/spi/spi-hisi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66..5769049 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8080,6 +8080,13 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
 F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
 F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
+HISILICON SPI Controller Driver
+M:	Jay Fang <f.fangjian@huawei.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+W:	http://www.hisilicon.com
+F:	drivers/spi/spi-hisi.c
+
 HISILICON STAGING DRIVERS FOR HIKEY 960/970
 M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 L:	devel@driverdev.osuosl.org
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index aadaea0..94c4b57 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -339,6 +339,16 @@ config SPI_FSL_QUADSPI
 	  This controller does not support generic SPI messages. It only
 	  supports the high-level SPI memory interface.
 
+config SPI_HISI
+	tristate "HiSilicon SPI controller"
+	depends on (ARM64 && ACPI) || COMPILE_TEST
+	help
+	  Say Y here if you want have SPI controller support available
+	  on the HiSilicon Kunpeng SOCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called spi-hisi.
+
 config SPI_HISI_SFC_V3XX
 	tristate "HiSilicon SPI NOR Flash Controller for Hi16XX chipsets"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6fea582..af3029d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_SPI_FSL_QUADSPI)		+= spi-fsl-qspi.o
 obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
 obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
+obj-$(CONFIG_SPI_HISI)			+= spi-hisi.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
 obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
diff --git a/drivers/spi/spi-hisi.c b/drivers/spi/spi-hisi.c
new file mode 100644
index 00000000..5d48bbf
--- /dev/null
+++ b/drivers/spi/spi-hisi.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * HiSilicon SPI Controller Driver (refer spi-dw-core.c)
+ *
+ * Copyright (c) 2021, HiSilicon Corporation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+/* Register offsets */
+#define HISI_SPI_CSCR		0x00	/* cs control register */
+#define HISI_SPI_CR		0x04	/* spi common control register */
+#define HISI_SPI_ENR		0x08	/* spi enable register */
+#define HISI_SPI_FIFOC		0x0c	/* fifo level control register */
+#define HISI_SPI_IMR		0x10	/* interrupt mask register */
+#define HISI_SPI_DIN		0x14	/* data in register */
+#define HISI_SPI_DOUT		0x18	/* data out register */
+#define HISI_SPI_SR		0x1c	/* status register */
+#define HISI_SPI_RISR		0x20	/* raw interrupt status register */
+#define HISI_SPI_ISR		0x24	/* interrupt status register */
+#define HISI_SPI_ICR		0x28	/* interrupt clear register */
+#define HISI_SPI_VERSION	0xfe0	/* version register */
+
+/* Bit fields in HISI_SPI_CR */
+#define CR_LOOP_MASK		GENMASK(1, 1)
+#define CR_CPOL_MASK		GENMASK(2, 2)
+#define CR_CPHA_MASK		GENMASK(3, 3)
+#define CR_DIV_PRE_MASK		GENMASK(11, 4)
+#define CR_DIV_POST_MASK	GENMASK(19, 12)
+#define CR_BPW_MASK		GENMASK(24, 20)
+#define CR_SPD_MODE_MASK	GENMASK(25, 25)
+
+/* Bit fields in HISI_SPI_FIFOC */
+#define FIFOC_TX_MASK		GENMASK(5, 3)
+#define FIFOC_RX_MASK		GENMASK(11, 9)
+
+/* Bit fields in HISI_SPI_IMR, 4 bits */
+#define IMR_RXOF		BIT(0)		/* Receive Overflow */
+#define IMR_RXTO		BIT(1)		/* Receive Timeout */
+#define IMR_RX			BIT(2)		/* Receive */
+#define IMR_TX			BIT(3)		/* Transmit */
+#define IMR_MASK		(IMR_RXOF | IMR_RXTO | IMR_RX | IMR_TX)
+
+/* Bit fields in HISI_SPI_SR, 5 bits */
+#define SR_TXE			BIT(0)		/* Transmit FIFO empty */
+#define SR_TXNF			BIT(1)		/* Transmit FIFO not full */
+#define SR_RXNE			BIT(2)		/* Receive FIFO not empty */
+#define SR_RXF			BIT(3)		/* Receive FIFO full */
+#define SR_BUSY			BIT(4)		/* Busy Flag */
+
+/* Bit fields in HISI_SPI_ISR, 4 bits */
+#define ISR_RXOF		BIT(0)		/* Receive Overflow */
+#define ISR_RXTO		BIT(1)		/* Receive Timeout */
+#define ISR_RX			BIT(2)		/* Receive */
+#define ISR_TX			BIT(3)		/* Transmit */
+#define ISR_MASK		(ISR_RXOF | ISR_RXTO | ISR_RX | ISR_TX)
+
+/* Bit fields in HISI_SPI_ICR, 2 bits */
+#define ICR_RXOF		BIT(0)		/* Receive Overflow */
+#define ICR_RXTO		BIT(1)		/* Receive Timeout */
+#define ICR_MASK		(ICR_RXOF | ICR_RXTO)
+
+#define DIV_POST_MAX		0xFF
+#define DIV_POST_MIN		0x00
+#define DIV_PRE_MAX		0xFE
+#define DIV_PRE_MIN		0x02
+#define CLK_DIV_MAX		((1 + DIV_POST_MAX) * DIV_PRE_MAX)
+#define CLK_DIV_MIN		((1 + DIV_POST_MIN) * DIV_PRE_MIN)
+
+#define DEFAULT_NUM_CS		1
+
+enum hisi_spi_rx_level_trig {
+	HISI_SPI_RX_1,
+	HISI_SPI_RX_4,
+	HISI_SPI_RX_8,
+	HISI_SPI_RX_16,
+	HISI_SPI_RX_32,
+	HISI_SPI_RX_64,
+	HISI_SPI_RX_128
+};
+
+enum hisi_spi_tx_level_trig {
+	HISI_SPI_TX_1_OR_LESS,
+	HISI_SPI_TX_4_OR_LESS,
+	HISI_SPI_TX_8_OR_LESS,
+	HISI_SPI_TX_16_OR_LESS,
+	HISI_SPI_TX_32_OR_LESS,
+	HISI_SPI_TX_64_OR_LESS,
+	HISI_SPI_TX_128_OR_LESS
+};
+
+enum hisi_spi_frame_n_bytes {
+	HISI_SPI_N_BYTES_NULL,
+	HISI_SPI_N_BYTES_U8,
+	HISI_SPI_N_BYTES_U16,
+	HISI_SPI_N_BYTES_U32 = 4
+};
+
+/* Slave spi_dev related */
+struct hisi_chip_data {
+	u32 cr;
+	u32 speed_hz;	/* baud rate */
+	u16 clk_div;	/* baud rate divider */
+
+	/* clk_div = (1 + div_post) * div_pre */
+	u8 div_post;	/* value from 0 to 255 */
+	u8 div_pre;	/* value from 2 to 254 (even only!) */
+};
+
+struct hisi_spi {
+	struct spi_controller	*master;
+
+	void __iomem		*regs;
+	int			irq;
+	u32			fifo_len; /* depth of the FIFO buffer */
+	u32			max_freq; /* max bus freq supported */
+	u16			bus_num;
+	u16			num_cs; /* supported slave numbers */
+
+	/* Current message transfer state info */
+	void			*tx;
+	unsigned int		tx_len;
+	void			*rx;
+	unsigned int		rx_len;
+	u8			n_bytes; /* current is a 1/2/4 bytes op */
+};
+
+static void hisi_spi_enable(struct hisi_spi *hs)
+{
+	writel(1, hs->regs + HISI_SPI_ENR);
+}
+
+static void hisi_spi_disable(struct hisi_spi *hs)
+{
+	writel(0, hs->regs + HISI_SPI_ENR);
+}
+
+/* Disable IRQ bits */
+static void hisi_spi_mask_intr(struct hisi_spi *hs, u32 mask)
+{
+	u32 new_mask;
+
+	new_mask = readl(hs->regs + HISI_SPI_IMR) | mask;
+	writel(new_mask, hs->regs + HISI_SPI_IMR);
+}
+
+/* Enable IRQ bits */
+static void hisi_spi_umask_intr(struct hisi_spi *hs, u32 mask)
+{
+	u32 new_mask;
+
+	new_mask = readl(hs->regs + HISI_SPI_IMR) & ~mask;
+	writel(new_mask, hs->regs + HISI_SPI_IMR);
+}
+
+/* Clear IRQ bits */
+static void hisi_spi_clear_intr(struct hisi_spi *hs, u32 clear)
+{
+	writel(clear, hs->regs + HISI_SPI_ICR);
+}
+
+static u32 hisi_spi_busy(struct hisi_spi *hs)
+{
+	return readl(hs->regs + HISI_SPI_SR) & SR_BUSY;
+}
+
+static u32 hisi_spi_rx_not_empty(struct hisi_spi *hs)
+{
+	return readl(hs->regs + HISI_SPI_SR) & SR_RXNE;
+}
+
+static u32 hisi_spi_tx_not_full(struct hisi_spi *hs)
+{
+	return readl(hs->regs + HISI_SPI_SR) & SR_TXNF;
+}
+
+/* Disable the controller and all interrupts */
+static void hisi_spi_reset(struct hisi_spi *hs)
+{
+	hisi_spi_disable(hs);
+	hisi_spi_mask_intr(hs, IMR_MASK);
+	hisi_spi_clear_intr(hs, ICR_MASK);
+}
+
+static u8 hisi_spi_n_bytes(struct spi_transfer *transfer)
+{
+	if (transfer->bits_per_word <= 8)
+		return HISI_SPI_N_BYTES_U8;
+	else if (transfer->bits_per_word <= 16)
+		return HISI_SPI_N_BYTES_U16;
+	else
+		return HISI_SPI_N_BYTES_U32;
+}
+
+static void hisi_spi_reader(struct hisi_spi *hs)
+{
+	u32 max = min_t(u32, hs->rx_len, hs->fifo_len);
+	u32 rxw;
+
+	while (hisi_spi_rx_not_empty(hs) && max--) {
+		rxw = readl(hs->regs + HISI_SPI_DOUT);
+		/* Check the transfer's original "rx" is not null */
+		if (hs->rx) {
+			switch (hs->n_bytes) {
+			case HISI_SPI_N_BYTES_U8:
+				*(u8 *)(hs->rx) = rxw;
+				break;
+			case HISI_SPI_N_BYTES_U16:
+				*(u16 *)(hs->rx) = rxw;
+				break;
+			case HISI_SPI_N_BYTES_U32:
+				*(u32 *)(hs->rx) = rxw;
+				break;
+			}
+			hs->rx += hs->n_bytes;
+		}
+		--hs->rx_len;
+	}
+}
+
+static void hisi_spi_writer(struct hisi_spi *hs)
+{
+	u32 max = min_t(u32, hs->tx_len, hs->fifo_len);
+	u32 txw = 0;
+
+	while (hisi_spi_tx_not_full(hs) && max--) {
+		/* Check the transfer's original "tx" is not null */
+		if (hs->tx) {
+			switch (hs->n_bytes) {
+			case HISI_SPI_N_BYTES_U8:
+				txw = *(u8 *)(hs->tx);
+				break;
+			case HISI_SPI_N_BYTES_U16:
+				txw = *(u16 *)(hs->tx);
+				break;
+			case HISI_SPI_N_BYTES_U32:
+				txw = *(u32 *)(hs->tx);
+				break;
+			}
+			hs->tx += hs->n_bytes;
+		}
+		writel(txw, hs->regs + HISI_SPI_DIN);
+		--hs->tx_len;
+	}
+}
+
+static void hisi_spi_flush_fifo(struct hisi_spi *hs)
+{
+	unsigned long limit = loops_per_jiffy << 1;
+
+	do {
+		while (hisi_spi_rx_not_empty(hs))
+			readl(hs->regs + HISI_SPI_DOUT);
+	} while (hisi_spi_busy(hs) && limit--);
+}
+
+static void __hisi_calc_div_reg(struct hisi_chip_data *chip)
+{
+	chip->div_pre = DIV_PRE_MAX;
+	while (chip->div_pre >= DIV_PRE_MIN) {
+		if (chip->clk_div % chip->div_pre == 0)
+			break;
+
+		chip->div_pre -= 2;
+	}
+
+	if (chip->div_pre > chip->clk_div)
+		chip->div_pre = chip->clk_div;
+
+	chip->div_post = (chip->clk_div / chip->div_pre) - 1;
+}
+
+static u32 hisi_calc_effective_speed(struct hisi_spi *hs,
+			struct hisi_chip_data *chip, u32 speed_hz)
+{
+	u32 effective_speed;
+
+	/* Note clock divider doesn't support odd numbers */
+	chip->clk_div = DIV_ROUND_UP(hs->max_freq, speed_hz) + 1;
+	chip->clk_div &= 0xfffe;
+	if (chip->clk_div > CLK_DIV_MAX)
+		chip->clk_div = CLK_DIV_MAX;
+
+	effective_speed = hs->max_freq / chip->clk_div;
+	if (chip->speed_hz != effective_speed) {
+		__hisi_calc_div_reg(chip);
+		chip->speed_hz = effective_speed;
+	}
+
+	return effective_speed;
+}
+
+static u32 hisi_spi_prepare_cr(struct hisi_spi *hs,
+				struct spi_device *spi)
+{
+	u32 cr;
+
+	cr = FIELD_PREP(CR_SPD_MODE_MASK, 1);
+
+	cr |= FIELD_PREP(CR_CPHA_MASK, (spi->mode & SPI_CPHA) ? 1 : 0);
+	cr |= FIELD_PREP(CR_CPOL_MASK, (spi->mode & SPI_CPOL) ? 1 : 0);
+	cr |= FIELD_PREP(CR_LOOP_MASK, (spi->mode & SPI_LOOP) ? 1 : 0);
+
+	return cr;
+}
+
+/* Handle per transfer options for speed and bpw */
+static void hisi_spi_update_cr(struct hisi_spi *hs,
+	struct spi_device *spi, struct spi_transfer *transfer)
+{
+	struct hisi_chip_data *chip = spi_get_ctldata(spi);
+	u32 cr = chip->cr;
+
+	transfer->effective_speed_hz =
+		hisi_calc_effective_speed(hs, chip, transfer->speed_hz);
+
+	cr |= FIELD_PREP(CR_DIV_PRE_MASK, chip->div_pre);
+	cr |= FIELD_PREP(CR_DIV_POST_MASK, chip->div_post);
+	cr |= FIELD_PREP(CR_BPW_MASK, transfer->bits_per_word - 1);
+
+	writel(cr, hs->regs + HISI_SPI_CR);
+}
+
+static void hisi_spi_hw_init(struct hisi_spi *hs)
+{
+	hisi_spi_reset(hs);
+
+	/* FIFO default config */
+	writel(FIELD_PREP(FIFOC_TX_MASK, HISI_SPI_TX_64_OR_LESS) |
+		FIELD_PREP(FIFOC_RX_MASK, HISI_SPI_RX_16),
+		hs->regs + HISI_SPI_FIFOC);
+
+	hs->fifo_len = 256;
+}
+
+static irqreturn_t hisi_spi_handle_transfer(struct hisi_spi *hs,
+			u32 irq_status)
+{
+	struct spi_controller *master = hs->master;
+
+	/* Error handling */
+	if (irq_status & ISR_RXOF) {
+		dev_err(&master->dev, "%s\n",
+			"interrupt_transfer: fifo overflow");
+		master->cur_msg->status = -EIO;
+		goto finalize_transfer;
+	}
+
+	/*
+	 * Read data from the Rx FIFO every time we've got a chance
+	 * executing this method. If there is nothing left to receive,
+	 * clear irq status and terminate the procedure.
+	 */
+	hisi_spi_reader(hs);
+	if (!hs->rx_len)
+		goto finalize_transfer;
+
+	/*
+	 * Send data out if Tx FIFO IRQ is received. The Tx IRQ will be
+	 * disabled after the data transmission is finished.
+	 */
+	if (irq_status & ISR_TX) {
+		hisi_spi_writer(hs);
+
+		if (!hs->tx_len)
+			hisi_spi_mask_intr(hs, ISR_TX);
+	}
+
+	return IRQ_HANDLED;
+
+finalize_transfer:
+	hisi_spi_reset(hs);
+	spi_finalize_current_transfer(master);
+	return IRQ_HANDLED;
+
+}
+
+static irqreturn_t hisi_spi_irq(int irq, void *dev_id)
+{
+	struct spi_controller *master = dev_id;
+	struct hisi_spi *hs = spi_controller_get_devdata(master);
+	u32 irq_status = readl(hs->regs + HISI_SPI_ISR) & ISR_MASK;
+
+	if (!irq_status)
+		return IRQ_NONE;
+
+	if (!master->cur_msg) {
+		hisi_spi_mask_intr(hs, IMR_MASK);
+		return IRQ_HANDLED;
+	}
+
+	return hisi_spi_handle_transfer(hs, irq_status);
+}
+
+static int hisi_spi_transfer_one(struct spi_controller *master,
+		struct spi_device *spi, struct spi_transfer *transfer)
+{
+	struct hisi_spi *hs = spi_controller_get_devdata(master);
+
+	hs->n_bytes = hisi_spi_n_bytes(transfer);
+	hs->tx = (void *)transfer->tx_buf;
+	hs->tx_len = transfer->len / hs->n_bytes;
+	hs->rx = transfer->rx_buf;
+	hs->rx_len = hs->tx_len;
+
+	/* Ensure the data above is visible for all CPUs */
+	smp_mb();
+
+	/* Disable is needed to deal with transfer timeout */
+	hisi_spi_disable(hs);
+
+	hisi_spi_flush_fifo(hs);
+	hisi_spi_update_cr(hs, spi, transfer);
+
+	/* Kickoff */
+	hisi_spi_umask_intr(hs, IMR_MASK);
+	hisi_spi_enable(hs);
+
+	return 1;
+}
+
+static void hisi_spi_handle_err(struct spi_controller *master,
+		struct spi_message *msg)
+{
+	struct hisi_spi *hs = spi_controller_get_devdata(master);
+
+	hisi_spi_reset(hs);
+}
+
+static int hisi_spi_setup(struct spi_device *spi)
+{
+	struct hisi_spi *hs = spi_controller_get_devdata(spi->controller);
+	struct hisi_chip_data *chip;
+
+	/* Only alloc on first setup */
+	chip = spi_get_ctldata(spi);
+	if (!chip) {
+		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+		if (!chip)
+			return -ENOMEM;
+		spi_set_ctldata(spi, chip);
+	}
+
+	chip->cr = hisi_spi_prepare_cr(hs, spi);
+
+	return 0;
+}
+
+static void hisi_spi_cleanup(struct spi_device *spi)
+{
+	struct hisi_chip_data *chip = spi_get_ctldata(spi);
+
+	kfree(chip);
+	spi_set_ctldata(spi, NULL);
+}
+
+static int hisi_spi_add_host(struct device *dev, struct hisi_spi *hs)
+{
+	struct spi_controller *master;
+	int ret;
+
+	master = devm_spi_alloc_master(dev, 0);
+	if (!master)
+		return -ENOMEM;
+
+	hs->master = master;
+	spi_controller_set_devdata(master, hs);
+
+	hisi_spi_hw_init(hs);
+
+	ret = devm_request_irq(dev, hs->irq, hisi_spi_irq, IRQF_SHARED,
+				dev_name(dev), master);
+	if (ret < 0) {
+		dev_err(dev, "failed to get IRQ=%d, ret=%d\n", hs->irq, ret);
+		return ret;
+	}
+
+	master->use_gpio_descriptors = true;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	master->bus_num = hs->bus_num;
+	master->num_chipselect = hs->num_cs;
+	master->setup = hisi_spi_setup;
+	master->cleanup = hisi_spi_cleanup;
+	master->transfer_one = hisi_spi_transfer_one;
+	master->handle_err = hisi_spi_handle_err;
+	master->max_speed_hz = hs->max_freq;
+	master->dev.fwnode = dev->fwnode;
+
+	ret = devm_spi_register_controller(dev, master);
+	if (ret) {
+		dev_err(&master->dev,
+			"failed to register spi master, ret=%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hisi_spi_probe(struct platform_device *pdev)
+{
+	struct hisi_spi *hs;
+	u32 version;
+	int ret;
+
+	hs = devm_kzalloc(&pdev->dev, sizeof(*hs), GFP_KERNEL);
+	if (!hs)
+		return -ENOMEM;
+
+	hs->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hs->regs))
+		return PTR_ERR(hs->regs);
+
+	hs->irq = platform_get_irq(pdev, 0);
+	if (hs->irq < 0)
+		return hs->irq;
+
+	hs->bus_num = pdev->id;
+
+	ret = device_property_read_u16(&pdev->dev, "num-cs", &hs->num_cs);
+	if (ret)
+		hs->num_cs = DEFAULT_NUM_CS;
+
+	/* Specify maximum SPI clocking speed (master only) by firmware */
+	ret = device_property_read_u32(&pdev->dev, "spi-max-frequency",
+					&hs->max_freq);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to get max SPI clocking speed, ret=%d\n", ret);
+		return -EINVAL;
+	}
+
+	version = readl(hs->regs + HISI_SPI_VERSION);
+
+	ret = hisi_spi_add_host(&pdev->dev, hs);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, hs);
+
+	dev_info(&pdev->dev, "hw version:0x%x max-freq:%u kHz\n",
+		version, hs->max_freq / 1000);
+
+	return 0;
+}
+
+static const struct acpi_device_id hisi_spi_acpi_match[] = {
+	{"HISI03E1", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, hisi_spi_acpi_match);
+
+static struct platform_driver hisi_spi_driver = {
+	.probe		= hisi_spi_probe,
+	.driver		= {
+		.name	= "hisi_spi",
+		.acpi_match_table = hisi_spi_acpi_match,
+	},
+};
+module_platform_driver(hisi_spi_driver);
+
+MODULE_AUTHOR("Jay Fang <f.fangjian@huawei.com>");
+MODULE_DESCRIPTION("HiSilicon SPI Controller Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

