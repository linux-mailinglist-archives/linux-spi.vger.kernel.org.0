Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26D14D1BB
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2020 21:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgA2UIq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jan 2020 15:08:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbgA2UIq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jan 2020 15:08:46 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00TK6rhk121644;
        Wed, 29 Jan 2020 15:08:39 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xu5x96xg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 15:08:38 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00TK6XAK030552;
        Wed, 29 Jan 2020 20:08:36 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 2xrda7632a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jan 2020 20:08:36 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00TK8ZqJ62914842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 20:08:35 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DFEB78069;
        Wed, 29 Jan 2020 20:08:35 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0527B7805E;
        Wed, 29 Jan 2020 20:08:34 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jan 2020 20:08:34 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] spi: Add FSI-attached SPI controller driver
Date:   Wed, 29 Jan 2020 14:08:24 -0600
Message-Id: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_06:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 priorityscore=1501 suspectscore=1 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001290154
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There exists a set of SPI controllers on some POWER processors that may
be accessed through the FSI bus. Add a driver to traverse the FSI CFAM
engine that can access and drive the SPI controllers. This driver would
typically be used by a baseboard management controller (BMC).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 MAINTAINERS           |   6 +
 drivers/spi/Kconfig   |   7 +
 drivers/spi/Makefile  |   1 +
 drivers/spi/spi-fsi.c | 547 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 drivers/spi/spi-fsi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fc1e24c..56a50c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6862,6 +6862,12 @@ S:	Maintained
 F:	drivers/i2c/busses/i2c-fsi.c
 F:	Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 
+FSI-ATTACHED SPI DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-fsi.c
+
 FSNOTIFY: FILESYSTEM NOTIFICATION INFRASTRUCTURE
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6ed0c3..c6fc9f1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -264,6 +264,13 @@ config SPI_FALCON
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
index 9b65ec5..d4ea24e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -40,6 +40,7 @@ spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
 obj-$(CONFIG_SPI_EFM32)			+= spi-efm32.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
 obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
+obj-$(CONFIG_SPI_FSI)			+= spi-fsi.o
 obj-$(CONFIG_SPI_FSL_CPM)		+= spi-fsl-cpm.o
 obj-$(CONFIG_SPI_FSL_DSPI)		+= spi-fsl-dspi.o
 obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
new file mode 100644
index 0000000..4be0a0f
--- /dev/null
+++ b/drivers/spi/spi-fsi.c
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) IBM Corporation 2020
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/fsi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+#define FSI_ENGID_SPI			0x23
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
+	struct device *dev;
+	struct fsi_device *fsi;
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
+
+	*value = 0ULL;
+
+	cmd_be = cpu_to_be32(offset + ctx->base);
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
+
+	dev_dbg(ctx->dev, "Write %02x[%016llx].\n", offset, value);
+
+	data_be = cpu_to_be32((value >> 32) & 0xFFFFFFFF);
+	rc = fsi_device_write(ctx->fsi, FSI2SPI_DATA0, &data_be,
+			      sizeof(data_be));
+	if (rc)
+		return rc;
+
+	data_be = cpu_to_be32(value & 0xFFFFFFFF);
+	rc = fsi_device_write(ctx->fsi, FSI2SPI_DATA1, &data_be,
+			      sizeof(data_be));
+	if (rc)
+		return rc;
+
+	cmd_be = cpu_to_be32((offset + ctx->base) | FSI2SPI_CMD_WRITE);
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
+	int num_bytes = len > 8 ? 8 : len;
+
+	for (i = 0; i < num_bytes; ++i)
+		rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
+
+	return num_bytes;
+}
+
+static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
+{
+	int i;
+	int num_bytes = len > 8 ? 8 : len;
+
+	*out = 0ULL;
+
+	for (i = 0; i < num_bytes; ++i)
+		*out |= (u64)tx[i] << (8 * (8 - (i + 1)));
+
+	return num_bytes;
+}
+
+static int fsi_spi_reset(struct fsi_spi *ctx)
+{
+	int rc;
+
+	dev_info(ctx->dev, "Resetting SPI controller.\n");
+
+	rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
+			       SPI_FSI_CLOCK_CFG_RESET1);
+	if (rc)
+		return rc;
+
+	rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
+			       SPI_FSI_CLOCK_CFG_RESET2);
+	return rc;
+}
+
+static int fsi_spi_sequence_add(struct fsi_spi_sequence *seq, u8 val)
+{
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
+	int loops = 1;
+	int idx = 0;
+	int rc;
+	u8 len;
+	u8 rem = 0;
+
+	if (transfer->len > 8) {
+		loops = transfer->len / 8;
+		rem = transfer->len - (loops * 8);
+		len = 8;
+	} else {
+		len = transfer->len;
+	}
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
+		if (rc) {
+			/* Ensure error returns < 0 in this case. */
+			if (rc > 0)
+				rc = -rc;
+
+			return rc;
+		}
+
+		return loops;
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
+	u64 seq_state;
+	u64 clock_cfg = 0ULL;
+	u64 status = 0ULL;
+	u64 wanted_clock_cfg = SPI_FSI_CLOCK_CFG_ECC_DISABLE |
+		SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
+		FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 4);
+
+	do {
+		rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
+		if (rc)
+			return rc;
+
+		if (status & (SPI_FSI_STATUS_ANY_ERROR |
+			      SPI_FSI_STATUS_TDR_FULL |
+			      SPI_FSI_STATUS_RDR_FULL)) {
+			rc = fsi_spi_reset(ctx);
+			if (rc)
+				return rc;
+
+			continue;
+		}
+
+		seq_state = status & SPI_FSI_STATUS_SEQ_STATE;
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
+		if (rc < 0)
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
+				if (rc < 0)
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
+	rc = fsi_slave_read(fsi->slave, 0x2860, &root_ctrl_8,
+			    sizeof(root_ctrl_8));
+	if (rc)
+		return rc;
+
+	if (!root_ctrl_8) {
+		dev_dbg(dev, "SPI MUX not set, aborting probe.\n");
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
+static int fsi_spi_remove(struct device *dev)
+{
+	return 0;
+}
+
+static const struct fsi_device_id fsi_spi_ids[] = {
+	{ FSI_ENGID_SPI, FSI_VERSION_ANY },
+	{ }
+};
+
+static struct fsi_driver fsi_spi_driver = {
+	.id_table = fsi_spi_ids,
+	.drv = {
+		.name = "spi-fsi",
+		.bus = &fsi_bus_type,
+		.probe = fsi_spi_probe,
+		.remove = fsi_spi_remove,
+	},
+};
+
+module_fsi_driver(fsi_spi_driver);
+
+MODULE_AUTHOR("Eddie James <eajames@linux.ibm.com>");
+MODULE_DESCRIPTION("FSI attached SPI controller");
+MODULE_LICENSE("GPL");
-- 
1.8.3.1

