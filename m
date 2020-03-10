Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D4180035
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 15:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCJObZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 10:31:25 -0400
Received: from foss.arm.com ([217.140.110.172]:37824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgCJObY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Mar 2020 10:31:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D85E030E;
        Tue, 10 Mar 2020 07:31:23 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3859A3F6CF;
        Tue, 10 Mar 2020 07:31:23 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:31:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     andrew@aj.id.au, andy.shevchenko@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, robh+dt@kernel.org
Subject: Applied "spi: Add FSI-attached SPI controller driver" to the spi tree
In-Reply-To:  <20200306194118.18581-3-eajames@linux.ibm.com>
Message-Id:  <applied-20200306194118.18581-3-eajames@linux.ibm.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: Add FSI-attached SPI controller driver

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From bbb6b2f9865b3ed23eb457131b9ea541a3173a66 Mon Sep 17 00:00:00 2001
From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 6 Mar 2020 13:41:18 -0600
Subject: [PATCH] spi: Add FSI-attached SPI controller driver

There exists a set of SPI controllers on some POWER processors that may
be accessed through the FSI bus. Add a driver to traverse the FSI CFAM
engine that can access and drive the SPI controllers. This driver would
typically be used by a baseboard management controller (BMC).

The SPI controllers operate by means of programming a sequencing engine
which automatically manages the usual SPI protocol buses. The driver
programs each transfer into the sequencer as various operations
specifying the slave chip and shifting data in and out on the lines.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Link: https://lore.kernel.org/r/20200306194118.18581-3-eajames@linux.ibm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS           |   7 +
 drivers/spi/Kconfig   |   7 +
 drivers/spi/Makefile  |   1 +
 drivers/spi/spi-fsi.c | 558 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 573 insertions(+)
 create mode 100644 drivers/spi/spi-fsi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c1080015943..6f99b4a4ae20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6861,6 +6861,13 @@ S:	Maintained
 F:	drivers/i2c/busses/i2c-fsi.c
 F:	Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 
+FSI-ATTACHED SPI DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-fsi.c
+F:	Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
+
 FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9c5dadb238dc..8ad267cb15cd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -271,6 +271,13 @@ config SPI_FALCON
 	  has only been tested with m25p80 type chips. The hardware has no
 	  support for other types of SPI peripherals.
 
+config SPI_FSI
+	tristate "FSI SPI driver"
+	depends on FSI
+	help
+	  This enables support for the driver for FSI bus attached SPI
+	  controllers.
+
 config SPI_FSL_LPSPI
 	tristate "Freescale i.MX LPSPI controller"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 74db1f2c3299..aba824a2c447 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -42,6 +42,7 @@ spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
 obj-$(CONFIG_SPI_EFM32)			+= spi-efm32.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
 obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
+obj-$(CONFIG_SPI_FSI)			+= spi-fsi.o
 obj-$(CONFIG_SPI_FSL_CPM)		+= spi-fsl-cpm.o
 obj-$(CONFIG_SPI_FSL_DSPI)		+= spi-fsl-dspi.o
 obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
new file mode 100644
index 000000000000..37a3e0f8e752
--- /dev/null
+++ b/drivers/spi/spi-fsi.c
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) IBM Corporation 2020
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/fsi.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+#define FSI_ENGID_SPI			0x23
+#define FSI_MBOX_ROOT_CTRL_8		0x2860
+
+#define FSI2SPI_DATA0			0x00
+#define FSI2SPI_DATA1			0x04
+#define FSI2SPI_CMD			0x08
+#define  FSI2SPI_CMD_WRITE		 BIT(31)
+#define FSI2SPI_RESET			0x18
+#define FSI2SPI_STATUS			0x1c
+#define  FSI2SPI_STATUS_ANY_ERROR	 BIT(31)
+#define FSI2SPI_IRQ			0x20
+
+#define SPI_FSI_BASE			0x70000
+#define SPI_FSI_INIT_TIMEOUT_MS		1000
+#define SPI_FSI_MAX_TRANSFER_SIZE	2048
+
+#define SPI_FSI_ERROR			0x0
+#define SPI_FSI_COUNTER_CFG		0x1
+#define  SPI_FSI_COUNTER_CFG_LOOPS(x)	 (((u64)(x) & 0xffULL) << 32)
+#define SPI_FSI_CFG1			0x2
+#define SPI_FSI_CLOCK_CFG		0x3
+#define  SPI_FSI_CLOCK_CFG_MM_ENABLE	 BIT_ULL(32)
+#define  SPI_FSI_CLOCK_CFG_ECC_DISABLE	 (BIT_ULL(35) | BIT_ULL(33))
+#define  SPI_FSI_CLOCK_CFG_RESET1	 (BIT_ULL(36) | BIT_ULL(38))
+#define  SPI_FSI_CLOCK_CFG_RESET2	 (BIT_ULL(37) | BIT_ULL(39))
+#define  SPI_FSI_CLOCK_CFG_MODE		 (BIT_ULL(41) | BIT_ULL(42))
+#define  SPI_FSI_CLOCK_CFG_SCK_RECV_DEL	 GENMASK_ULL(51, 44)
+#define   SPI_FSI_CLOCK_CFG_SCK_NO_DEL	  BIT_ULL(51)
+#define  SPI_FSI_CLOCK_CFG_SCK_DIV	 GENMASK_ULL(63, 52)
+#define SPI_FSI_MMAP			0x4
+#define SPI_FSI_DATA_TX			0x5
+#define SPI_FSI_DATA_RX			0x6
+#define SPI_FSI_SEQUENCE		0x7
+#define  SPI_FSI_SEQUENCE_STOP		 0x00
+#define  SPI_FSI_SEQUENCE_SEL_SLAVE(x)	 (0x10 | ((x) & 0xf))
+#define  SPI_FSI_SEQUENCE_SHIFT_OUT(x)	 (0x30 | ((x) & 0xf))
+#define  SPI_FSI_SEQUENCE_SHIFT_IN(x)	 (0x40 | ((x) & 0xf))
+#define  SPI_FSI_SEQUENCE_COPY_DATA_TX	 0xc0
+#define  SPI_FSI_SEQUENCE_BRANCH(x)	 (0xe0 | ((x) & 0xf))
+#define SPI_FSI_STATUS			0x8
+#define  SPI_FSI_STATUS_ERROR		 \
+	(GENMASK_ULL(31, 21) | GENMASK_ULL(15, 12))
+#define  SPI_FSI_STATUS_SEQ_STATE	 GENMASK_ULL(55, 48)
+#define   SPI_FSI_STATUS_SEQ_STATE_IDLE	  BIT_ULL(48)
+#define  SPI_FSI_STATUS_TDR_UNDERRUN	 BIT_ULL(57)
+#define  SPI_FSI_STATUS_TDR_OVERRUN	 BIT_ULL(58)
+#define  SPI_FSI_STATUS_TDR_FULL	 BIT_ULL(59)
+#define  SPI_FSI_STATUS_RDR_UNDERRUN	 BIT_ULL(61)
+#define  SPI_FSI_STATUS_RDR_OVERRUN	 BIT_ULL(62)
+#define  SPI_FSI_STATUS_RDR_FULL	 BIT_ULL(63)
+#define  SPI_FSI_STATUS_ANY_ERROR	 \
+	(SPI_FSI_STATUS_ERROR | SPI_FSI_STATUS_TDR_UNDERRUN | \
+	 SPI_FSI_STATUS_TDR_OVERRUN | SPI_FSI_STATUS_RDR_UNDERRUN | \
+	 SPI_FSI_STATUS_RDR_OVERRUN)
+#define SPI_FSI_PORT_CTRL		0x9
+
+struct fsi_spi {
+	struct device *dev;	/* SPI controller device */
+	struct fsi_device *fsi;	/* FSI2SPI CFAM engine device */
+	u32 base;
+};
+
+struct fsi_spi_sequence {
+	int bit;
+	u64 data;
+};
+
+static int fsi_spi_check_status(struct fsi_spi *ctx)
+{
+	int rc;
+	u32 sts;
+	__be32 sts_be;
+
+	rc = fsi_device_read(ctx->fsi, FSI2SPI_STATUS, &sts_be,
+			     sizeof(sts_be));
+	if (rc)
+		return rc;
+
+	sts = be32_to_cpu(sts_be);
+	if (sts & FSI2SPI_STATUS_ANY_ERROR) {
+		dev_err(ctx->dev, "Error with FSI2SPI interface: %08x.\n", sts);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int fsi_spi_read_reg(struct fsi_spi *ctx, u32 offset, u64 *value)
+{
+	int rc;
+	__be32 cmd_be;
+	__be32 data_be;
+	u32 cmd = offset + ctx->base;
+
+	*value = 0ULL;
+
+	if (cmd & FSI2SPI_CMD_WRITE)
+		return -EINVAL;
+
+	cmd_be = cpu_to_be32(cmd);
+	rc = fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cmd_be));
+	if (rc)
+		return rc;
+
+	rc = fsi_spi_check_status(ctx);
+	if (rc)
+		return rc;
+
+	rc = fsi_device_read(ctx->fsi, FSI2SPI_DATA0, &data_be,
+			     sizeof(data_be));
+	if (rc)
+		return rc;
+
+	*value |= (u64)be32_to_cpu(data_be) << 32;
+
+	rc = fsi_device_read(ctx->fsi, FSI2SPI_DATA1, &data_be,
+			     sizeof(data_be));
+	if (rc)
+		return rc;
+
+	*value |= (u64)be32_to_cpu(data_be);
+	dev_dbg(ctx->dev, "Read %02x[%016llx].\n", offset, *value);
+
+	return 0;
+}
+
+static int fsi_spi_write_reg(struct fsi_spi *ctx, u32 offset, u64 value)
+{
+	int rc;
+	__be32 cmd_be;
+	__be32 data_be;
+	u32 cmd = offset + ctx->base;
+
+	if (cmd & FSI2SPI_CMD_WRITE)
+		return -EINVAL;
+
+	dev_dbg(ctx->dev, "Write %02x[%016llx].\n", offset, value);
+
+	data_be = cpu_to_be32(upper_32_bits(value));
+	rc = fsi_device_write(ctx->fsi, FSI2SPI_DATA0, &data_be,
+			      sizeof(data_be));
+	if (rc)
+		return rc;
+
+	data_be = cpu_to_be32(lower_32_bits(value));
+	rc = fsi_device_write(ctx->fsi, FSI2SPI_DATA1, &data_be,
+			      sizeof(data_be));
+	if (rc)
+		return rc;
+
+	cmd_be = cpu_to_be32(cmd | FSI2SPI_CMD_WRITE);
+	rc = fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cmd_be));
+	if (rc)
+		return rc;
+
+	return fsi_spi_check_status(ctx);
+}
+
+static int fsi_spi_data_in(u64 in, u8 *rx, int len)
+{
+	int i;
+	int num_bytes = min(len, 8);
+
+	for (i = 0; i < num_bytes; ++i)
+		rx[i] = (u8)(in >> (8 * ((num_bytes - 1) - i)));
+
+	return num_bytes;
+}
+
+static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
+{
+	int i;
+	int num_bytes = min(len, 8);
+	u8 *out_bytes = (u8 *)out;
+
+	/* Unused bytes of the tx data should be 0. */
+	*out = 0ULL;
+
+	for (i = 0; i < num_bytes; ++i)
+		out_bytes[8 - (i + 1)] = tx[i];
+
+	return num_bytes;
+}
+
+static int fsi_spi_reset(struct fsi_spi *ctx)
+{
+	int rc;
+
+	dev_dbg(ctx->dev, "Resetting SPI controller.\n");
+
+	rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
+			       SPI_FSI_CLOCK_CFG_RESET1);
+	if (rc)
+		return rc;
+
+	return fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
+				 SPI_FSI_CLOCK_CFG_RESET2);
+}
+
+static int fsi_spi_sequence_add(struct fsi_spi_sequence *seq, u8 val)
+{
+	/*
+	 * Add the next byte of instruction to the 8-byte sequence register.
+	 * Then decrement the counter so that the next instruction will go in
+	 * the right place. Return the number of "slots" left in the sequence
+	 * register.
+	 */
+	seq->data |= (u64)val << seq->bit;
+	seq->bit -= 8;
+
+	return ((64 - seq->bit) / 8) - 2;
+}
+
+static void fsi_spi_sequence_init(struct fsi_spi_sequence *seq)
+{
+	seq->bit = 56;
+	seq->data = 0ULL;
+}
+
+static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
+				     struct fsi_spi_sequence *seq,
+				     struct spi_transfer *transfer)
+{
+	int loops;
+	int idx;
+	int rc;
+	u8 len = min(transfer->len, 8U);
+	u8 rem = transfer->len % len;
+
+	loops = transfer->len / len;
+
+	if (transfer->tx_buf) {
+		idx = fsi_spi_sequence_add(seq,
+					   SPI_FSI_SEQUENCE_SHIFT_OUT(len));
+		if (rem)
+			rem = SPI_FSI_SEQUENCE_SHIFT_OUT(rem);
+	} else if (transfer->rx_buf) {
+		idx = fsi_spi_sequence_add(seq,
+					   SPI_FSI_SEQUENCE_SHIFT_IN(len));
+		if (rem)
+			rem = SPI_FSI_SEQUENCE_SHIFT_IN(rem);
+	} else {
+		return -EINVAL;
+	}
+
+	if (loops > 1) {
+		fsi_spi_sequence_add(seq, SPI_FSI_SEQUENCE_BRANCH(idx));
+
+		if (rem)
+			fsi_spi_sequence_add(seq, rem);
+
+		rc = fsi_spi_write_reg(ctx, SPI_FSI_COUNTER_CFG,
+				       SPI_FSI_COUNTER_CFG_LOOPS(loops - 1));
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int fsi_spi_transfer_data(struct fsi_spi *ctx,
+				 struct spi_transfer *transfer)
+{
+	int rc = 0;
+	u64 status = 0ULL;
+
+	if (transfer->tx_buf) {
+		int nb;
+		int sent = 0;
+		u64 out = 0ULL;
+		const u8 *tx = transfer->tx_buf;
+
+		while (transfer->len > sent) {
+			nb = fsi_spi_data_out(&out, &tx[sent],
+					      (int)transfer->len - sent);
+
+			rc = fsi_spi_write_reg(ctx, SPI_FSI_DATA_TX, out);
+			if (rc)
+				return rc;
+
+			do {
+				rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS,
+						      &status);
+				if (rc)
+					return rc;
+
+				if (status & SPI_FSI_STATUS_ANY_ERROR) {
+					rc = fsi_spi_reset(ctx);
+					if (rc)
+						return rc;
+
+					return -EREMOTEIO;
+				}
+			} while (status & SPI_FSI_STATUS_TDR_FULL);
+
+			sent += nb;
+		}
+	} else if (transfer->rx_buf) {
+		int recv = 0;
+		u64 in = 0ULL;
+		u8 *rx = transfer->rx_buf;
+
+		while (transfer->len > recv) {
+			do {
+				rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS,
+						      &status);
+				if (rc)
+					return rc;
+
+				if (status & SPI_FSI_STATUS_ANY_ERROR) {
+					rc = fsi_spi_reset(ctx);
+					if (rc)
+						return rc;
+
+					return -EREMOTEIO;
+				}
+			} while (!(status & SPI_FSI_STATUS_RDR_FULL));
+
+			rc = fsi_spi_read_reg(ctx, SPI_FSI_DATA_RX, &in);
+			if (rc)
+				return rc;
+
+			recv += fsi_spi_data_in(in, &rx[recv],
+						(int)transfer->len - recv);
+		}
+	}
+
+	return 0;
+}
+
+static int fsi_spi_transfer_init(struct fsi_spi *ctx)
+{
+	int rc;
+	bool reset = false;
+	unsigned long end;
+	u64 seq_state;
+	u64 clock_cfg = 0ULL;
+	u64 status = 0ULL;
+	u64 wanted_clock_cfg = SPI_FSI_CLOCK_CFG_ECC_DISABLE |
+		SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
+		FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 4);
+
+	end = jiffies + msecs_to_jiffies(SPI_FSI_INIT_TIMEOUT_MS);
+	do {
+		if (time_after(jiffies, end))
+			return -ETIMEDOUT;
+
+		rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
+		if (rc)
+			return rc;
+
+		seq_state = status & SPI_FSI_STATUS_SEQ_STATE;
+
+		if (status & (SPI_FSI_STATUS_ANY_ERROR |
+			      SPI_FSI_STATUS_TDR_FULL |
+			      SPI_FSI_STATUS_RDR_FULL)) {
+			if (reset)
+				return -EIO;
+
+			rc = fsi_spi_reset(ctx);
+			if (rc)
+				return rc;
+
+			reset = true;
+			continue;
+		}
+	} while (seq_state && (seq_state != SPI_FSI_STATUS_SEQ_STATE_IDLE));
+
+	rc = fsi_spi_read_reg(ctx, SPI_FSI_CLOCK_CFG, &clock_cfg);
+	if (rc)
+		return rc;
+
+	if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
+			  SPI_FSI_CLOCK_CFG_ECC_DISABLE |
+			  SPI_FSI_CLOCK_CFG_MODE |
+			  SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
+			  SPI_FSI_CLOCK_CFG_SCK_DIV)) != wanted_clock_cfg)
+		rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
+				       wanted_clock_cfg);
+
+	return rc;
+}
+
+static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
+					struct spi_message *mesg)
+{
+	int rc = 0;
+	u8 seq_slave = SPI_FSI_SEQUENCE_SEL_SLAVE(mesg->spi->chip_select + 1);
+	struct spi_transfer *transfer;
+	struct fsi_spi *ctx = spi_controller_get_devdata(ctlr);
+
+	list_for_each_entry(transfer, &mesg->transfers, transfer_list) {
+		struct fsi_spi_sequence seq;
+		struct spi_transfer *next = NULL;
+
+		/* Sequencer must do shift out (tx) first. */
+		if (!transfer->tx_buf ||
+		    transfer->len > SPI_FSI_MAX_TRANSFER_SIZE) {
+			rc = -EINVAL;
+			goto error;
+		}
+
+		dev_dbg(ctx->dev, "Start tx of %d bytes.\n", transfer->len);
+
+		rc = fsi_spi_transfer_init(ctx);
+		if (rc < 0)
+			goto error;
+
+		fsi_spi_sequence_init(&seq);
+		fsi_spi_sequence_add(&seq, seq_slave);
+
+		rc = fsi_spi_sequence_transfer(ctx, &seq, transfer);
+		if (rc)
+			goto error;
+
+		if (!list_is_last(&transfer->transfer_list,
+				  &mesg->transfers)) {
+			next = list_next_entry(transfer, transfer_list);
+
+			/* Sequencer can only do shift in (rx) after tx. */
+			if (next->rx_buf) {
+				if (next->len > SPI_FSI_MAX_TRANSFER_SIZE) {
+					rc = -EINVAL;
+					goto error;
+				}
+
+				dev_dbg(ctx->dev, "Sequence rx of %d bytes.\n",
+					next->len);
+
+				rc = fsi_spi_sequence_transfer(ctx, &seq,
+							       next);
+				if (rc)
+					goto error;
+			} else {
+				next = NULL;
+			}
+		}
+
+		fsi_spi_sequence_add(&seq, SPI_FSI_SEQUENCE_SEL_SLAVE(0));
+
+		rc = fsi_spi_write_reg(ctx, SPI_FSI_SEQUENCE, seq.data);
+		if (rc)
+			goto error;
+
+		rc = fsi_spi_transfer_data(ctx, transfer);
+		if (rc)
+			goto error;
+
+		if (next) {
+			rc = fsi_spi_transfer_data(ctx, next);
+			if (rc)
+				goto error;
+
+			transfer = next;
+		}
+	}
+
+error:
+	mesg->status = rc;
+	spi_finalize_current_message(ctlr);
+
+	return rc;
+}
+
+static size_t fsi_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SPI_FSI_MAX_TRANSFER_SIZE;
+}
+
+static int fsi_spi_probe(struct device *dev)
+{
+	int rc;
+	u32 root_ctrl_8;
+	struct device_node *np;
+	int num_controllers_registered = 0;
+	struct fsi_device *fsi = to_fsi_dev(dev);
+
+	/*
+	 * Check the SPI mux before attempting to probe. If the mux isn't set
+	 * then the SPI controllers can't access their slave devices.
+	 */
+	rc = fsi_slave_read(fsi->slave, FSI_MBOX_ROOT_CTRL_8, &root_ctrl_8,
+			    sizeof(root_ctrl_8));
+	if (rc)
+		return rc;
+
+	if (!root_ctrl_8) {
+		dev_dbg(dev, "SPI mux not set, aborting probe.\n");
+		return -ENODEV;
+	}
+
+	for_each_available_child_of_node(dev->of_node, np) {
+		u32 base;
+		struct fsi_spi *ctx;
+		struct spi_controller *ctlr;
+
+		if (of_property_read_u32(np, "reg", &base))
+			continue;
+
+		ctlr = spi_alloc_master(dev, sizeof(*ctx));
+		if (!ctlr)
+			break;
+
+		ctlr->dev.of_node = np;
+		ctlr->num_chipselect = of_get_available_child_count(np) ?: 1;
+		ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
+		ctlr->max_transfer_size = fsi_spi_max_transfer_size;
+		ctlr->transfer_one_message = fsi_spi_transfer_one_message;
+
+		ctx = spi_controller_get_devdata(ctlr);
+		ctx->dev = &ctlr->dev;
+		ctx->fsi = fsi;
+		ctx->base = base + SPI_FSI_BASE;
+
+		rc = devm_spi_register_controller(dev, ctlr);
+		if (rc)
+			spi_controller_put(ctlr);
+		else
+			num_controllers_registered++;
+	}
+
+	if (!num_controllers_registered)
+		return -ENODEV;
+
+	return 0;
+}
+
+static const struct fsi_device_id fsi_spi_ids[] = {
+	{ FSI_ENGID_SPI, FSI_VERSION_ANY },
+	{ }
+};
+MODULE_DEVICE_TABLE(fsi, fsi_spi_ids);
+
+static struct fsi_driver fsi_spi_driver = {
+	.id_table = fsi_spi_ids,
+	.drv = {
+		.name = "spi-fsi",
+		.bus = &fsi_bus_type,
+		.probe = fsi_spi_probe,
+	},
+};
+module_fsi_driver(fsi_spi_driver);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("FSI attached SPI controller");
+MODULE_LICENSE("GPL");
-- 
2.20.1

