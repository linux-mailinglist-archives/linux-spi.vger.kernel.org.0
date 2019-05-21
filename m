Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1724893
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfEUG6j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 02:58:39 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:45414 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfEUG6i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 02:58:38 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x4L6vvQe093632;
        Tue, 21 May 2019 14:57:59 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com
Subject: [PATCH v13 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date:   Tue, 21 May 2019 15:19:33 +0800
Message-Id: <1558423174-10748-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x4L6vvQe093632
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
---
 drivers/spi/Kconfig           |   6 +
 drivers/spi/Makefile          |   1 +
 drivers/spi/spi-renesas-rpc.c | 573 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 580 insertions(+)
 create mode 100644 drivers/spi/spi-renesas-rpc.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0fba8f4..229f6d7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -570,6 +570,12 @@ config SPI_RSPI
 	help
 	  SPI driver for Renesas RSPI and QSPI blocks.
 
+config SPI_RENESAS_RPC
+	tristate "Renesas R-Car Gen3 RPC-IF SPI controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  SPI driver for Renesas R-Car Gen3 RPC-IF.
+
 config SPI_QCOM_QSPI
 	tristate "QTI QSPI controller"
 	depends on ARCH_QCOM
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index f2f78d0..2a6e052 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
+obj-$(CONFIG_SPI_RENESAS_RPC)		+= spi-renesas-rpc.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
 spi-s3c24xx-hw-$(CONFIG_SPI_S3C24XX_FIQ) += spi-s3c24xx-fiq.o
diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
new file mode 100644
index 0000000..86931cf
--- /dev/null
+++ b/drivers/spi/spi-renesas-rpc.c
@@ -0,0 +1,573 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+// Copyright (C) 2019 Macronix International Co., Ltd.
+//
+// R-Car Gen3 RPC-IF SPI/QSPI/Octa driver
+//
+// Author:
+//	Mason Yang <masonccyang@mxic.com.tw>
+//
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/renesas-rpc.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#include <asm/unaligned.h>
+
+struct rpc_spi {
+	struct rpc_mfd *ddata;
+	u32 cur_speed_hz;
+	u32 cmd;
+	u32 addr;
+	u32 dummy;
+	u32 smcr;
+	u32 smenr;
+	u32 xferlen;
+	u32 totalxferlen;
+	enum spi_mem_data_dir xfer_dir;
+};
+
+static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
+{
+	int ret;
+
+	if (rpc->cur_speed_hz == freq)
+		return 0;
+
+	ret = clk_set_rate(rpc->ddata->clk_rpc, freq);
+	if (ret)
+		return ret;
+
+	rpc->cur_speed_hz = freq;
+	return ret;
+}
+
+static void rpc_spi_hw_init(struct rpc_spi *rpc)
+{
+	//
+	// NOTE: The 0x260 are undocumented bits, but they must be set.
+	//	 RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
+	//	 0x0 : the delay is biggest,
+	//	 0x1 : the delay is 2nd biggest,
+	//	 On H3 ES1.x, the value should be 0, while on others,
+	//	 the value should be 6.
+	//
+	regmap_write(rpc->ddata->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
+				  RPC_PHYCNT_STRTIM(6) | 0x260);
+
+	//
+	// NOTE: The 0x1511144 are undocumented bits, but they must be set
+	//       for RPC_PHYOFFSET1.
+	//	 The 0x31 are undocumented bits, but they must be set
+	//	 for RPC_PHYOFFSET2.
+	//
+	regmap_write(rpc->ddata->regmap, RPC_PHYOFFSET1,
+		     RPC_PHYOFFSET1_DDRTMG(3) | 0x1511144);
+	regmap_write(rpc->ddata->regmap, RPC_PHYOFFSET2, 0x31 |
+		     RPC_PHYOFFSET2_OCTTMG(4));
+	regmap_write(rpc->ddata->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
+		     RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
+	regmap_write(rpc->ddata->regmap, RPC_CMNCR, RPC_CMNCR_MD |
+		     RPC_CMNCR_SFDE | RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
+		     RPC_CMNCR_BSZ(0));
+}
+
+static int wait_msg_xfer_end(struct rpc_spi *rpc)
+{
+	u32 sts;
+
+	return regmap_read_poll_timeout(rpc->ddata->regmap, RPC_CMNSR, sts,
+					sts & RPC_CMNSR_TEND, 0, USEC_PER_SEC);
+}
+
+static u8 rpc_bits_set(u32 nbytes)
+{
+	nbytes = clamp(nbytes, 1U, 4U);
+
+	return GENMASK(3, 4 - nbytes);
+}
+
+static int rpc_spi_io_xfer(struct rpc_spi *rpc,
+			   const void *tx_buf, void *rx_buf)
+{
+	u32 smenr, smcr, data, pos = 0;
+	int ret;
+
+	regmap_update_bits(rpc->ddata->regmap, RPC_CMNCR, RPC_CMNCR_MD,
+			   RPC_CMNCR_MD);
+	regmap_write(rpc->ddata->regmap, RPC_SMDRENR, 0);
+	regmap_write(rpc->ddata->regmap, RPC_SMCMR, rpc->cmd);
+	regmap_write(rpc->ddata->regmap, RPC_SMDMCR, rpc->dummy);
+	regmap_write(rpc->ddata->regmap, RPC_SMADR, rpc->addr);
+	smenr = rpc->smenr;
+
+	if (tx_buf) {
+		while (pos < rpc->xferlen) {
+			u32 nbytes = rpc->xferlen - pos;
+
+			regmap_write(rpc->ddata->regmap, RPC_SMWDR0,
+				     get_unaligned((u32 *)(tx_buf + pos)));
+
+			smcr = rpc->smcr | RPC_SMCR_SPIE;
+
+			if (nbytes > 4) {
+				nbytes = 4;
+				smcr |= RPC_SMCR_SSLKP;
+			}
+
+			regmap_write(rpc->ddata->regmap, RPC_SMENR, smenr);
+			regmap_write(rpc->ddata->regmap, RPC_SMCR, smcr);
+			ret = wait_msg_xfer_end(rpc);
+			if (ret)
+				goto err_out;
+
+			pos += nbytes;
+			smenr = rpc->smenr & ~RPC_SMENR_CDE &
+					     ~RPC_SMENR_ADE(0xf);
+		}
+	} else if (rx_buf) {
+		//
+		// RPC-IF spoils the data for the commands without an address
+		// phase (like RDID) in the manual mode, so we'll have to work
+		// around this issue by using the external address space read
+		// mode instead.
+		//
+		if (!(smenr & RPC_SMENR_ADE(0xf)) && rpc->ddata->dirmap) {
+			regmap_update_bits(rpc->ddata->regmap, RPC_CMNCR,
+					   RPC_CMNCR_MD, 0);
+			regmap_write(rpc->ddata->regmap, RPC_DRCR,
+				     RPC_DRCR_RBURST(32) | RPC_DRCR_RBE);
+			regmap_write(rpc->ddata->regmap, RPC_DREAR,
+				     RPC_DREAR_EAC(1));
+			regmap_write(rpc->ddata->regmap, RPC_DRCMR, rpc->cmd);
+			regmap_write(rpc->ddata->regmap, RPC_DRDMCR,
+				     rpc->dummy);
+			regmap_write(rpc->ddata->regmap, RPC_DROPR, 0);
+			regmap_write(rpc->ddata->regmap, RPC_DRENR, smenr);
+			memcpy_fromio(rx_buf, rpc->ddata->dirmap, rpc->xferlen);
+			regmap_write(rpc->ddata->regmap,
+				     RPC_DRCR, RPC_DRCR_RCF);
+		} else {
+			while (pos < rpc->xferlen) {
+				u32 nbytes = rpc->xferlen - pos;
+
+				if (nbytes > 4)
+					nbytes = 4;
+
+				regmap_write(rpc->ddata->regmap, RPC_SMENR,
+					     smenr);
+				regmap_write(rpc->ddata->regmap, RPC_SMCR,
+					     rpc->smcr | RPC_SMCR_SPIE);
+				ret = wait_msg_xfer_end(rpc);
+				if (ret)
+					goto err_out;
+
+				regmap_read(rpc->ddata->regmap, RPC_SMRDR0,
+					    &data);
+				memcpy(rx_buf + pos, &data, nbytes);
+				pos += nbytes;
+
+				regmap_write(rpc->ddata->regmap, RPC_SMADR,
+					     rpc->addr + pos);
+			}
+		}
+	} else {
+		regmap_write(rpc->ddata->regmap, RPC_SMENR, rpc->smenr);
+		regmap_write(rpc->ddata->regmap, RPC_SMCR,
+			     rpc->smcr | RPC_SMCR_SPIE);
+		ret = wait_msg_xfer_end(rpc);
+		if (ret)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	return reset_control_reset(rpc->ddata->rstc);
+}
+
+static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
+					const struct spi_mem_op *op,
+					u64 *offs, size_t *len)
+{
+	struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
+
+	rpc->cmd = RPC_SMCMR_CMD(op->cmd.opcode);
+	rpc->smenr = RPC_SMENR_CDE |
+		     RPC_SMENR_CDB(ilog2(op->cmd.buswidth));
+	rpc->totalxferlen = 1;
+	rpc->xfer_dir = SPI_MEM_NO_DATA;
+	rpc->xferlen = 0;
+	rpc->addr = 0;
+
+	if (op->addr.nbytes) {
+		rpc->smenr |= RPC_SMENR_ADB(ilog2(op->addr.buswidth));
+		if (op->addr.nbytes == 4)
+			rpc->smenr |= RPC_SMENR_ADE(0xf);
+		else
+			rpc->smenr |= RPC_SMENR_ADE(0x7);
+
+		if (offs && len)
+			rpc->addr = *offs;
+		else
+			rpc->addr = op->addr.val;
+		rpc->totalxferlen += op->addr.nbytes;
+	}
+
+	if (op->dummy.nbytes) {
+		rpc->smenr |= RPC_SMENR_DME;
+		rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes * 8 /
+					      op->dummy.buswidth);
+		rpc->totalxferlen += op->dummy.nbytes;
+	}
+
+	if (op->data.nbytes || (offs && len)) {
+		switch (op->data.dir) {
+		case SPI_MEM_DATA_IN:
+			rpc->smcr = RPC_SMCR_SPIRE;
+			rpc->xfer_dir = SPI_MEM_DATA_IN;
+			break;
+		case SPI_MEM_DATA_OUT:
+			rpc->smcr = RPC_SMCR_SPIWE;
+			rpc->xfer_dir = SPI_MEM_DATA_OUT;
+			break;
+		default:
+			break;
+		}
+
+		if (offs && len) {
+			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_set(*len)) |
+				      RPC_SMENR_SPIDB(ilog2(op->data.buswidth));
+			rpc->xferlen = *len;
+			rpc->totalxferlen += *len;
+		} else {
+			rpc->smenr |=
+				RPC_SMENR_SPIDE(rpc_bits_set(op->data.nbytes)) |
+				RPC_SMENR_SPIDB(ilog2(op->data.buswidth));
+			rpc->xferlen = op->data.nbytes;
+			rpc->totalxferlen += op->data.nbytes;
+		}
+	}
+}
+
+static bool rpc_spi_mem_supports_op(struct spi_mem *mem,
+				    const struct spi_mem_op *op)
+{
+	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
+	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4 ||
+	    op->addr.nbytes > 4)
+		return false;
+
+	return true;
+}
+
+static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				       u64 offs, size_t len, void *buf)
+{
+	struct rpc_spi *rpc =
+			spi_controller_get_devdata(desc->mem->spi->controller);
+	loff_t from = offs & (RPC_DIRMAP_SIZE - 1);
+	size_t size = RPC_DIRMAP_SIZE - from;
+	int ret;
+
+	if (offs + desc->info.offset + len > U32_MAX)
+		return -EINVAL;
+
+	if (len > size)
+		len = size;
+
+	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
+	if (ret)
+		return ret;
+
+	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
+				    &desc->info.op_tmpl, &offs, &len);
+
+	regmap_update_bits(rpc->ddata->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
+	regmap_write(rpc->ddata->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
+		     RPC_DRCR_RBE);
+
+	regmap_write(rpc->ddata->regmap, RPC_DRCMR, rpc->cmd);
+	regmap_write(rpc->ddata->regmap, RPC_DREAR,
+		     RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
+	regmap_write(rpc->ddata->regmap, RPC_DROPR, 0);
+	regmap_write(rpc->ddata->regmap, RPC_DRENR, rpc->smenr);
+	regmap_write(rpc->ddata->regmap, RPC_DRDMCR, rpc->dummy);
+	regmap_write(rpc->ddata->regmap, RPC_DRDRENR, 0);
+
+	memcpy_fromio(buf, rpc->ddata->dirmap + desc->info.offset + from, len);
+
+	return len;
+}
+
+static int rpc_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct rpc_spi *rpc =
+			spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -ENOTSUPP;
+
+	if (!rpc_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+		return -ENOTSUPP;
+
+	if (!rpc->ddata->dirmap &&
+	    desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+		return -ENOTSUPP;
+
+	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static int rpc_spi_mem_exec_op(struct spi_mem *mem,
+			       const struct spi_mem_op *op)
+{
+	struct rpc_spi *rpc = spi_controller_get_devdata(mem->spi->controller);
+	int ret;
+
+	ret = rpc_spi_set_freq(rpc, mem->spi->max_speed_hz);
+	if (ret)
+		return ret;
+
+	rpc_spi_mem_set_prep_op_cfg(mem->spi, op, NULL, NULL);
+
+	ret = rpc_spi_io_xfer(rpc,
+			      op->data.dir == SPI_MEM_DATA_OUT ?
+			      op->data.buf.out : NULL,
+			      op->data.dir == SPI_MEM_DATA_IN ?
+			      op->data.buf.in : NULL);
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops rpc_spi_mem_ops = {
+	.supports_op = rpc_spi_mem_supports_op,
+	.exec_op = rpc_spi_mem_exec_op,
+	.dirmap_create = rpc_spi_mem_dirmap_create,
+	.dirmap_read = rpc_spi_mem_dirmap_read,
+};
+
+static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
+				   struct spi_message *msg)
+{
+	struct spi_transfer *t, xfer[4] = { };
+	u32 i, xfercnt, xferpos = 0;
+
+	rpc->totalxferlen = 0;
+	rpc->xfer_dir = SPI_MEM_NO_DATA;
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->tx_buf) {
+			xfer[xferpos].tx_buf = t->tx_buf;
+			xfer[xferpos].tx_nbits = t->tx_nbits;
+		}
+
+		if (t->rx_buf) {
+			xfer[xferpos].rx_buf = t->rx_buf;
+			xfer[xferpos].rx_nbits = t->rx_nbits;
+		}
+
+		if (t->len) {
+			xfer[xferpos++].len = t->len;
+			rpc->totalxferlen += t->len;
+		}
+
+		if (list_is_last(&t->transfer_list, &msg->transfers)) {
+			if (xferpos > 1) {
+				if (t->rx_buf) {
+					rpc->xfer_dir = SPI_MEM_DATA_IN;
+					rpc->smcr = RPC_SMCR_SPIRE;
+				} else if (t->tx_buf) {
+					rpc->xfer_dir = SPI_MEM_DATA_OUT;
+					rpc->smcr = RPC_SMCR_SPIWE;
+				}
+			}
+		}
+	}
+
+	xfercnt = xferpos;
+	rpc->xferlen = xfer[--xferpos].len;
+	rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
+	rpc->smenr = RPC_SMENR_CDE |
+		     RPC_SMENR_CDB(ilog2((unsigned int)xfer[0].tx_nbits));
+	rpc->addr = 0;
+
+	if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
+		rpc->smenr |=
+			RPC_SMENR_ADB(ilog2((unsigned int)xfer[1].tx_nbits));
+
+		for (i = 0; i < xfer[1].len; i++)
+			rpc->addr |= ((u8 *)xfer[1].tx_buf)[i] <<
+				     (8 * (xfer[1].len - i - 1));
+
+		if (xfer[1].len == 4)
+			rpc->smenr |= RPC_SMENR_ADE(0xf);
+		else
+			rpc->smenr |= RPC_SMENR_ADE(0x7);
+	}
+
+	if (xfercnt > 3 && xfer[2].len && xfer[2].tx_buf) {
+		rpc->smenr |= RPC_SMENR_DME;
+		rpc->dummy = RPC_SMDMCR_DMCYC(xfer[2].len * 8 /
+					      xfer[2].tx_nbits);
+	}
+
+	for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
+		if (xfer[i].rx_buf) {
+			rpc->smenr |=
+				RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
+				RPC_SMENR_SPIDB(ilog2
+					((unsigned int)xfer[i].rx_nbits));
+		} else if (xfer[i].tx_buf) {
+			rpc->smenr |=
+				RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
+				RPC_SMENR_SPIDB(ilog2
+					((unsigned int)xfer[i].tx_nbits));
+		}
+	}
+}
+
+static inline int rpc_spi_xfer_message(struct rpc_spi *rpc,
+				       struct spi_transfer *data_xfer)
+{
+	int ret;
+
+	ret = rpc_spi_set_freq(rpc, data_xfer->speed_hz);
+	if (ret)
+		return ret;
+
+	ret = rpc_spi_io_xfer(rpc,
+			      rpc->xfer_dir == SPI_MEM_DATA_OUT ?
+			      data_xfer->tx_buf : NULL,
+			      rpc->xfer_dir == SPI_MEM_DATA_IN ?
+			      data_xfer->rx_buf : NULL);
+
+	return ret;
+}
+
+static int rpc_spi_transfer_one_message(struct spi_controller *ctlr,
+					struct spi_message *msg)
+{
+	struct rpc_spi *rpc = spi_controller_get_devdata(ctlr);
+	struct spi_transfer *data_xfer;
+	int ret;
+
+	rpc_spi_transfer_setup(rpc, msg);
+
+	data_xfer = list_last_entry(&msg->transfers, struct spi_transfer,
+				    transfer_list);
+
+	ret = rpc_spi_xfer_message(rpc, data_xfer);
+	if (ret)
+		goto out;
+
+	msg->status = 0;
+	msg->actual_length = rpc->totalxferlen;
+out:
+	spi_finalize_current_message(ctlr);
+	return 0;
+}
+
+static int rpc_spi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
+	struct rpc_spi *rpc;
+	int ret;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
+	if (!ctlr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctlr);
+
+	rpc = spi_controller_get_devdata(ctlr);
+
+	rpc->ddata = rpc_mfd;
+	ctlr->dev.of_node = pdev->dev.parent->of_node;
+
+	pm_runtime_enable(&pdev->dev);
+	ctlr->auto_runtime_pm = true;
+
+	ctlr->num_chipselect = 1;
+	ctlr->mem_ops = &rpc_spi_mem_ops;
+	ctlr->transfer_one_message = rpc_spi_transfer_one_message;
+
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
+
+	pm_runtime_get_sync(&pdev->dev);
+	rpc_spi_hw_init(rpc);
+	pm_runtime_put(&pdev->dev);
+
+	ret = spi_register_controller(ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		goto err_put_ctlr;
+	}
+
+	return 0;
+err_put_ctlr:
+	spi_controller_put(ctlr);
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int rpc_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	spi_unregister_controller(ctlr);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int rpc_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_suspend(ctlr);
+}
+
+static int rpc_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_resume(ctlr);
+}
+
+static SIMPLE_DEV_PM_OPS(rpc_spi_pm_ops, rpc_spi_suspend, rpc_spi_resume);
+#define DEV_PM_OPS	(&rpc_spi_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
+static struct platform_driver rpc_spi_driver = {
+	.probe = rpc_spi_probe,
+	.remove = rpc_spi_remove,
+	.driver = {
+		.name = "rpc-spi",
+		.pm = DEV_PM_OPS,
+	},
+};
+module_platform_driver(rpc_spi_driver);
+
+MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
+MODULE_DESCRIPTION("Renesas R-Car Gen3 RPC-IF SPI controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

