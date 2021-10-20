Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4872434DB0
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhJTOaq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 10:30:46 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47165 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhJTOan (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 10:30:43 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C7CBA20011;
        Wed, 20 Oct 2021 14:28:26 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 12/18] mtd: nand: mxic-ecc: Add Macronix external ECC engine support
Date:   Wed, 20 Oct 2021 16:28:03 +0200
Message-Id: <20211020142809.349347-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211020142809.349347-1-miquel.raynal@bootlin.com>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some SPI-NAND chips do not support on-die ECC. For these chips,
correction must apply on the SPI controller end. In order to avoid
doing all the calculations by software, Macronix provides a specific
engine that can offload the intensive work.

Add Macronix ECC engine support, this engine can work in conjunction
with a SPI controller and a raw NAND controller, it can be pipelined
or external and supports linear and syndrome layouts.

Right now the simplest configuration is supported: SPI controller
external and linear ECC engine.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/Kconfig    |   6 +
 drivers/mtd/nand/Makefile   |   1 +
 drivers/mtd/nand/ecc-mxic.c | 657 ++++++++++++++++++++++++++++++++++++
 3 files changed, 664 insertions(+)
 create mode 100644 drivers/mtd/nand/ecc-mxic.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index b40455234cbd..8431292ff49d 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -46,6 +46,12 @@ config MTD_NAND_ECC_SW_BCH
 	  ECC codes. They are used with NAND devices requiring more than 1 bit
 	  of error correction.
 
+config MTD_NAND_ECC_MXIC
+	bool "Macronix external hardware ECC engine"
+	select MTD_NAND_ECC
+	help
+	  This enables support for the hardware ECC engine from Macronix.
+
 endmenu
 
 endmenu
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 1c0b46960eb1..a4e6b7ae0614 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -10,3 +10,4 @@ obj-y	+= spi/
 nandcore-$(CONFIG_MTD_NAND_ECC) += ecc.o
 nandcore-$(CONFIG_MTD_NAND_ECC_SW_HAMMING) += ecc-sw-hamming.o
 nandcore-$(CONFIG_MTD_NAND_ECC_SW_BCH) += ecc-sw-bch.o
+nandcore-$(CONFIG_MTD_NAND_ECC_MXIC) += ecc-mxic.o
diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
new file mode 100644
index 000000000000..d9b251ab9201
--- /dev/null
+++ b/drivers/mtd/nand/ecc-mxic.c
@@ -0,0 +1,657 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for Macronix external hardware ECC engine for NAND devices, also
+ * called DPE for Data Processing Engine.
+ *
+ * Copyright © 2019 Macronix
+ * Author: Miquel Raynal <miquel.raynal@bootlin.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* DPE Configuration */
+#define DP_CONFIG 0x00
+#define   ECC_EN BIT(0)
+#define   ECC_TYP(idx) (((idx) << 3) & GENMASK(6, 3))
+/* DPE Interrupt Status */
+#define INTRPT_STS 0x04
+#define   TRANS_CMPLT BIT(0)
+#define   SDMA_MAIN BIT(1)
+#define   SDMA_SPARE BIT(2)
+#define   ECC_ERR BIT(3)
+#define   TO_SPARE BIT(4)
+#define   TO_MAIN BIT(5)
+/* DPE Interrupt Status Enable */
+#define INTRPT_STS_EN 0x08
+/* DPE Interrupt Signal Enable */
+#define INTRPT_SIG_EN 0x0C
+/* Host Controller Configuration */
+#define HC_CONFIG 0x10
+#define   MEM2MEM BIT(4) /* TRANS_TYP_IO in the spec */
+#define   ECC_PACKED 0 /* LAYOUT_TYP_INTEGRATED in the spec */
+#define   ECC_INTERLEAVED BIT(2) /* LAYOUT_TYP_DISTRIBUTED in the spec */
+#define   BURST_TYP_FIXED 0
+#define   BURST_TYP_INCREASING BIT(0)
+/* Host Controller Slave Address */
+#define HC_SLV_ADDR 0x14
+/* ECC Chunk Size */
+#define CHUNK_SIZE 0x20
+/* Main Data Size */
+#define MAIN_SIZE 0x24
+/* Spare Data Size */
+#define SPARE_SIZE 0x28
+#define   META_SZ(reg) ((reg) & GENMASK(7, 0))
+#define   PARITY_SZ(reg) (((reg) & GENMASK(15, 8)) >> 8)
+#define   RSV_SZ(reg) (((reg) & GENMASK(23, 16)) >> 16)
+#define   SPARE_SZ(reg) ((reg) >> 24)
+/* ECC Chunk Count */
+#define CHUNK_CNT 0x30
+/* SDMA Control */
+#define SDMA_CTRL 0x40
+#define   WRITE_NAND 0
+#define   READ_NAND BIT(1)
+#define   CONT_NAND BIT(29)
+#define   CONT_SYSM BIT(30) /* Continue System Memory? */
+#define   SDMA_STRT BIT(31)
+/* SDMA Address of Main Data */
+#define SDMA_MAIN_ADDR 0x44
+/* SDMA Address of Spare Data */
+#define SDMA_SPARE_ADDR 0x48
+/* DPE Version Number */
+#define DP_VER 0xD0
+#define   DP_VER_OFFSET 16
+
+/* Status bytes between each chunk of spare data */
+#define STAT_BYTES 4
+#define   NO_ERR 0x00
+#define   MAX_CORR_ERR 0x28
+#define   UNCORR_ERR 0xFE
+#define   ERASED_CHUNK 0xFF
+
+struct mxic_ecc_engine {
+	struct device *dev;
+	void __iomem *regs;
+
+	/* ECC machinery */
+	unsigned int data_step_sz;
+	unsigned int oob_step_sz;
+	unsigned int parity_sz;
+	unsigned int meta_sz;
+	u8 *status;
+	int steps;
+
+	/* Completion boilerplate */
+	int irq;
+	struct completion complete;
+
+	/* DMA boilerplate */
+	struct nand_ecc_req_tweak_ctx req_ctx;
+	u8 *oobwithstat;
+	struct scatterlist sg[2];
+	struct nand_page_io_req *req;
+};
+
+static int mxic_ecc_ooblayout_ecc(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mxic_ecc_engine *eng = nand->ecc.ctx.priv;
+
+	if (section < 0 || section >= eng->steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * eng->oob_step_sz) + eng->meta_sz;
+	oobregion->length = eng->parity_sz;
+
+	return 0;
+}
+
+static int mxic_ecc_ooblayout_free(struct mtd_info *mtd, int section,
+				   struct mtd_oob_region *oobregion)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mxic_ecc_engine *eng = nand->ecc.ctx.priv;
+
+	if (section < 0 || section >= eng->steps)
+		return -ERANGE;
+
+	if (!section) {
+		oobregion->offset = 2;
+		oobregion->length = eng->meta_sz - 2;
+	} else {
+		oobregion->offset = section * eng->oob_step_sz;
+		oobregion->length = eng->meta_sz;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops mxic_ecc_ooblayout_ops = {
+	.ecc = mxic_ecc_ooblayout_ecc,
+	.free = mxic_ecc_ooblayout_free,
+};
+
+static void mxic_ecc_disable_engine(struct mxic_ecc_engine *eng)
+{
+	u32 reg;
+
+	reg = readl(eng->regs + DP_CONFIG);
+	reg &= ~ECC_EN;
+	writel(reg, eng->regs + DP_CONFIG);
+}
+
+static void mxic_ecc_enable_engine(struct mxic_ecc_engine *eng)
+{
+	u32 reg;
+
+	reg = readl(eng->regs + DP_CONFIG);
+	reg |= ECC_EN;
+	writel(reg, eng->regs + DP_CONFIG);
+}
+
+static void mxic_ecc_disable_int(struct mxic_ecc_engine *eng)
+{
+	writel(0, eng->regs + INTRPT_SIG_EN);
+}
+
+static void mxic_ecc_enable_int(struct mxic_ecc_engine *eng)
+{
+	writel(TRANS_CMPLT, eng->regs + INTRPT_SIG_EN);
+}
+
+static irqreturn_t mxic_ecc_isr(int irq, void *dev_id)
+{
+	struct mxic_ecc_engine *eng = dev_id;
+	u32 sts;
+
+	sts = readl(eng->regs + INTRPT_STS);
+	if (!sts)
+		return IRQ_NONE;
+
+	if (sts & TRANS_CMPLT)
+		complete(&eng->complete);
+
+	writel(sts, eng->regs + INTRPT_STS);
+
+	return IRQ_HANDLED;
+}
+
+static int mxic_ecc_init_ctx(struct nand_device *nand, struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
+	struct nand_ecc_props *reqs = &nand->ecc.requirements;
+	struct nand_ecc_props *user = &nand->ecc.user_conf;
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mxic_ecc_engine *eng;
+	int step_size = 0, strength = 0, desired_correction = 0, steps, idx;
+	int possible_strength[] = {4, 8, 40, 48};
+	int spare_size[] = {32, 32, 96, 96};
+	u32 spare_reg;
+	int ret;
+
+	eng = devm_kzalloc(dev, sizeof(*eng), GFP_KERNEL);
+	if (!eng)
+		return -ENOMEM;
+
+	nand->ecc.ctx.priv = eng;
+	nand->ecc.engine->priv = eng;
+
+	eng->dev = dev;
+
+	/*
+	 * Both memory regions for the ECC engine itself and the AXI slave
+	 * address are mandatory.
+	 */
+	eng->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(eng->regs)) {
+		dev_err(dev, "Missing memory region\n");
+		return PTR_ERR(eng->regs);
+	}
+
+	mxic_ecc_disable_engine(eng);
+	mxic_ecc_disable_int(eng);
+
+	/* IRQ is optional yet much more efficient */
+	eng->irq = platform_get_irq_byname(pdev, "ecc-engine");
+	if (eng->irq > 0) {
+		ret = devm_request_irq(dev, eng->irq, mxic_ecc_isr, 0,
+				       "mxic-ecc", eng);
+		if (ret)
+			return ret;
+	} else {
+		dev_info(dev, "No ECC engine IRQ (%d), using polling\n",
+			 eng->irq);
+		eng->irq = 0;
+	}
+
+	/* Only large page NAND chips may use BCH */
+	if (mtd->oobsize < 64) {
+		pr_err("BCH cannot be used with small page NAND chips\n");
+		return -EINVAL;
+	}
+
+	mtd_set_ooblayout(mtd, &mxic_ecc_ooblayout_ops);
+
+	/* Enable all status bits */
+	writel(TRANS_CMPLT | SDMA_MAIN | SDMA_SPARE | ECC_ERR |
+	       TO_SPARE | TO_MAIN, eng->regs + INTRPT_STS_EN);
+
+	/* Configure the correction depending on the NAND device topology */
+	if (user->step_size && user->strength) {
+		step_size = user->step_size;
+		strength = user->strength;
+	} else if (reqs->step_size && reqs->strength) {
+		step_size = reqs->step_size;
+		strength = reqs->strength;
+	}
+
+	if (step_size && strength) {
+		steps = mtd->writesize / step_size;
+		desired_correction = steps * strength;
+	}
+
+	/* Step size is fixed to 1kiB, strength may vary (4 possible values) */
+	conf->step_size = SZ_1K;
+	steps = mtd->writesize / conf->step_size;
+
+	eng->status = devm_kzalloc(dev, steps * sizeof(u8), GFP_KERNEL);
+	if (!eng->status)
+		return -ENOMEM;
+
+	if (desired_correction) {
+		strength = desired_correction / steps;
+
+		for (idx = 0; idx < ARRAY_SIZE(possible_strength); idx++)
+			if (possible_strength[idx] >= strength)
+				break;
+
+		idx = min_t(unsigned int, idx,
+			    ARRAY_SIZE(possible_strength) - 1);
+	} else {
+		/* Missing data, maximize the correction */
+		idx = ARRAY_SIZE(possible_strength) - 1;
+	}
+
+	/* Tune the selected strength until it fits in the OOB area */
+	for (; idx >= 0; idx--) {
+		if (spare_size[idx] * steps <= mtd->oobsize)
+			break;
+	}
+
+	/* This engine cannot be used with this NAND device */
+	if (idx < 0)
+		return -EINVAL;
+
+	/* Configure the engine for the desired strength */
+	writel(ECC_TYP(idx), eng->regs + DP_CONFIG);
+	conf->strength = possible_strength[idx];
+	spare_reg = readl(eng->regs + SPARE_SIZE);
+
+	eng->steps = steps;
+	eng->data_step_sz = mtd->writesize / steps;
+	eng->oob_step_sz = mtd->oobsize / steps;
+	eng->parity_sz = PARITY_SZ(spare_reg);
+	eng->meta_sz = META_SZ(spare_reg);
+
+	/* Ensure buffers will contain enough bytes to store the STAT_BYTES */
+	eng->req_ctx.oob_buffer_size = nanddev_per_page_oobsize(nand) +
+				       (eng->steps * STAT_BYTES);
+	ret = nand_ecc_init_req_tweaking(&eng->req_ctx, nand);
+	if (ret)
+		return ret;
+
+	eng->oobwithstat = kmalloc(mtd->oobsize + (eng->steps * STAT_BYTES),
+				   GFP_KERNEL);
+	if (!eng->oobwithstat) {
+		ret = -ENOMEM;
+		goto cleanup_req_tweak;
+	}
+
+	sg_init_table(eng->sg, 2);
+
+	/* Configuration dump and sanity checks */
+	dev_err(dev, "DPE version number: %d\n",
+		readl(eng->regs + DP_VER) >> DP_VER_OFFSET);
+	dev_err(dev, "Chunk size: %d\n", readl(eng->regs + CHUNK_SIZE));
+	dev_err(dev, "Main size: %d\n", readl(eng->regs + MAIN_SIZE));
+	dev_err(dev, "Spare size: %d\n", SPARE_SZ(spare_reg));
+	dev_err(dev, "Rsv size: %ld\n", RSV_SZ(spare_reg));
+	dev_err(dev, "Parity size: %d\n", eng->parity_sz);
+	dev_err(dev, "Meta size: %d\n", eng->meta_sz);
+
+	if (eng->meta_sz + eng->parity_sz + RSV_SZ(spare_reg) != SPARE_SZ(spare_reg)) {
+		dev_err(dev, "Wrong OOB configuration: %d + %d + %ld != %d\n",
+			eng->meta_sz, eng->parity_sz, RSV_SZ(spare_reg),
+			SPARE_SZ(spare_reg));
+		ret = -EINVAL;
+		goto free_oobwithstat;
+	}
+
+	if (eng->oob_step_sz != SPARE_SZ(spare_reg)) {
+		dev_err(dev, "Wrong OOB configuration: %d != %d\n",
+			eng->oob_step_sz, SPARE_SZ(spare_reg));
+		ret = -EINVAL;
+		goto free_oobwithstat;
+	}
+
+	return 0;
+
+free_oobwithstat:
+	kfree(eng->oobwithstat);
+cleanup_req_tweak:
+	nand_ecc_cleanup_req_tweaking(&eng->req_ctx);
+
+	return ret;
+}
+
+static int mxic_ecc_init_ctx_external(struct nand_device *nand)
+{
+	struct device *dev = nand->ecc.engine->dev;
+	struct mxic_ecc_engine *eng;
+	int ret;
+
+	dev_info(dev, "Macronix ECC engine in external mode\n");
+
+	ret = mxic_ecc_init_ctx(nand, dev);
+	if (ret)
+		return ret;
+
+	eng = nand->ecc.ctx.priv;
+
+	/* Trigger each step manually */
+	writel(1, eng->regs + CHUNK_CNT);
+	writel(BURST_TYP_INCREASING | ECC_PACKED | MEM2MEM,
+	       eng->regs + HC_CONFIG);
+
+	return 0;
+}
+
+static void mxic_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	struct mxic_ecc_engine *eng = nand->ecc.ctx.priv;
+
+	if (eng) {
+		nand_ecc_cleanup_req_tweaking(&eng->req_ctx);
+		kfree(eng->oobwithstat);
+	}
+}
+
+static int mxic_ecc_data_xfer_wait_for_completion(struct mxic_ecc_engine *eng)
+{
+	u32 val;
+	int ret;
+
+	if (eng->irq) {
+		init_completion(&eng->complete);
+		mxic_ecc_enable_int(eng);
+		ret = wait_for_completion_timeout(&eng->complete,
+						  msecs_to_jiffies(1000));
+		mxic_ecc_disable_int(eng);
+	} else {
+		ret = readl_poll_timeout(eng->regs + INTRPT_STS, val,
+					 val & TRANS_CMPLT, 10, USEC_PER_SEC);
+		writel(val, eng->regs + INTRPT_STS);
+	}
+
+	if (ret) {
+		dev_err(eng->dev, "Timeout on data xfer completion (sts 0x%08x)\n", val);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int mxic_ecc_process_data(struct mxic_ecc_engine *eng)
+{
+	/* Retrieve the direction */
+	unsigned int dir = (eng->req->type == NAND_PAGE_READ) ?
+			   READ_NAND : WRITE_NAND;
+
+	/* Trigger processing */
+	writel(SDMA_STRT | dir, eng->regs + SDMA_CTRL);
+
+	/* Wait for completion */
+	return mxic_ecc_data_xfer_wait_for_completion(eng);
+}
+
+static void mxic_ecc_extract_status_bytes(struct mxic_ecc_engine *eng, u8 *buf)
+{
+	int next_stat_pos;
+	int step;
+
+	/* Extract the ECC status */
+	for (step = 0; step < eng->steps; step++) {
+		next_stat_pos = eng->oob_step_sz +
+				((STAT_BYTES + eng->oob_step_sz) * step);
+
+		eng->status[step] = buf[next_stat_pos];
+	}
+}
+
+static void mxic_ecc_reconstruct_oobbuf(struct mxic_ecc_engine *eng,
+					u8 *dst, const u8 *src)
+{
+	int step;
+
+	/* Reconstruct the OOB buffer linearly (without the ECC status bytes) */
+	for (step = 0; step < eng->steps; step++)
+		memcpy(dst + (step * eng->oob_step_sz),
+		       src + (step * (eng->oob_step_sz + STAT_BYTES)),
+		       eng->oob_step_sz);
+}
+
+static void mxic_ecc_add_room_in_oobbuf(struct mxic_ecc_engine *eng,
+					u8 *dst, const u8 *src)
+{
+	int step;
+
+	/* Add some space in the OOB buffer for the status bytes */
+	for (step = 0; step < eng->steps; step++)
+		memcpy(dst + (step * (eng->oob_step_sz + STAT_BYTES)),
+		       src + (step * eng->oob_step_sz),
+		       eng->oob_step_sz);
+}
+
+static int mxic_ecc_count_biterrs(struct mxic_ecc_engine *eng, struct mtd_info *mtd)
+{
+	struct device *dev = eng->dev;
+	unsigned int max_bf = 0;
+	bool failure = false;
+	int step;
+
+	for (step = 0; step < eng->steps; step++) {
+		u8 stat = eng->status[step];
+
+		if (stat == NO_ERR) {
+			dev_dbg(dev, "ECC step %d: no error\n", step);
+		} else if (stat == ERASED_CHUNK) {
+			dev_dbg(dev, "ECC step %d: erased\n", step);
+		} else if (stat == UNCORR_ERR || stat > MAX_CORR_ERR) {
+			dev_dbg(dev, "ECC step %d: uncorrectable\n", step);
+			mtd->ecc_stats.failed++;
+			failure = true;
+		} else {
+			dev_dbg(dev, "ECC step %d: %d bits corrected\n",
+				step, stat);
+			max_bf = max_t(unsigned int, max_bf, stat);
+			mtd->ecc_stats.corrected += stat;
+		}
+	}
+
+	return failure ? -EBADMSG : max_bf;
+}
+
+/* External ECC engine helpers */
+static int mxic_ecc_prepare_io_req_external(struct nand_device *nand,
+					    struct nand_page_io_req *req)
+{
+	struct mxic_ecc_engine *eng = nand->ecc.ctx.priv;
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int offset, nents, step, ret;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	nand_ecc_tweak_req(&eng->req_ctx, req);
+	eng->req = req;
+
+	if (req->type == NAND_PAGE_READ)
+		return 0;
+
+	mxic_ecc_add_room_in_oobbuf(eng, eng->oobwithstat, eng->req->oobbuf.out);
+
+	sg_set_buf(&eng->sg[0], req->databuf.out, req->datalen);
+	sg_set_buf(&eng->sg[1], eng->oobwithstat,
+		   req->ooblen + (eng->steps * STAT_BYTES));
+
+	nents = dma_map_sg(eng->dev, eng->sg, 2, DMA_BIDIRECTIONAL);
+	if (!nents)
+		return -EINVAL;
+
+	mxic_ecc_enable_engine(eng);
+
+	for (step = 0; step < eng->steps; step++) {
+		writel(sg_dma_address(&eng->sg[0]) + (step * eng->data_step_sz),
+		       eng->regs + SDMA_MAIN_ADDR);
+		writel(sg_dma_address(&eng->sg[1]) + (step * (eng->oob_step_sz + STAT_BYTES)),
+		       eng->regs + SDMA_SPARE_ADDR);
+		ret = mxic_ecc_process_data(eng);
+		if (ret)
+			break;
+	}
+
+	mxic_ecc_disable_engine(eng);
+
+	dma_unmap_sg(eng->dev, eng->sg, 2, DMA_BIDIRECTIONAL);
+
+	/* Retrieve the calculated ECC bytes */
+	for (step = 0; step < eng->steps; step++) {
+		offset = eng->meta_sz + (step * eng->oob_step_sz);
+		mtd_ooblayout_get_eccbytes(mtd,
+					   (u8 *)eng->req->oobbuf.out + offset,
+					   eng->oobwithstat + (step * STAT_BYTES),
+					   step * eng->parity_sz,
+					   eng->parity_sz);
+	}
+
+	return ret;
+}
+
+static int mxic_ecc_finish_io_req_external(struct nand_device *nand,
+					   struct nand_page_io_req *req)
+{
+	struct mxic_ecc_engine *eng = nand->ecc.ctx.priv;
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int nents, step, ret;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	if (req->type == NAND_PAGE_WRITE) {
+		nand_ecc_restore_req(&eng->req_ctx, req);
+		return 0;
+	}
+
+	/* Copy the OOB buffer and add room for the ECC engine status bytes */
+	mxic_ecc_add_room_in_oobbuf(eng, eng->oobwithstat, eng->req->oobbuf.in);
+
+	sg_set_buf(&eng->sg[0], req->databuf.in, req->datalen);
+	sg_set_buf(&eng->sg[1], eng->oobwithstat,
+		   req->ooblen + (eng->steps * STAT_BYTES));
+	nents = dma_map_sg(eng->dev, eng->sg, 2, DMA_BIDIRECTIONAL);
+	if (!nents)
+		return -EINVAL;
+
+	mxic_ecc_enable_engine(eng);
+
+	for (step = 0; step < eng->steps; step++) {
+		writel(sg_dma_address(&eng->sg[0]) + (step * eng->data_step_sz),
+		       eng->regs + SDMA_MAIN_ADDR);
+		writel(sg_dma_address(&eng->sg[1]) + (step * (eng->oob_step_sz + STAT_BYTES)),
+		       eng->regs + SDMA_SPARE_ADDR);
+		ret = mxic_ecc_process_data(eng);
+		if (ret)
+			break;
+	}
+
+	mxic_ecc_disable_engine(eng);
+
+	dma_unmap_sg(eng->dev, eng->sg, 2, DMA_BIDIRECTIONAL);
+
+	/* Extract the status bytes and reconstruct the buffer */
+	mxic_ecc_extract_status_bytes(eng, eng->oobwithstat);
+	mxic_ecc_reconstruct_oobbuf(eng, eng->req->oobbuf.in, eng->oobwithstat);
+
+	nand_ecc_restore_req(&eng->req_ctx, req);
+
+	return mxic_ecc_count_biterrs(eng, mtd);
+}
+
+static struct nand_ecc_engine_ops mxic_ecc_engine_external_ops = {
+	.init_ctx = mxic_ecc_init_ctx_external,
+	.cleanup_ctx = mxic_ecc_cleanup_ctx,
+	.prepare_io_req = mxic_ecc_prepare_io_req_external,
+	.finish_io_req = mxic_ecc_finish_io_req_external,
+};
+
+static int mxic_ecc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nand_ecc_engine *ecceng;
+
+	ecceng = devm_kzalloc(dev, sizeof(*ecceng), GFP_KERNEL);
+	if (!ecceng)
+		return -ENOMEM;
+
+	ecceng->dev = dev;
+	ecceng->ops = &mxic_ecc_engine_external_ops;
+	nand_ecc_register_on_host_hw_engine(ecceng);
+
+	return 0;
+}
+
+static int mxic_ecc_remove(struct platform_device *pdev)
+{
+	struct nand_ecc_engine *ecceng;
+
+	ecceng = nand_ecc_match_on_host_hw_engine(&pdev->dev);
+	if (ecceng)
+		nand_ecc_unregister_on_host_hw_engine(ecceng);
+
+	return 0;
+}
+
+static const struct of_device_id mxic_ecc_of_ids[] = {
+	{
+		.compatible = "mxicy,nand-ecc-engine-rev3",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mxic_ecc_of_ids);
+
+static struct platform_driver mxic_ecc_driver = {
+	.driver	= {
+		.name = "mxic-nand-ecc-engine",
+		.of_match_table = mxic_ecc_of_ids,
+	},
+	.probe = mxic_ecc_probe,
+	.remove	= mxic_ecc_remove,
+};
+module_platform_driver(mxic_ecc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
+MODULE_DESCRIPTION("Macronix NAND hardware ECC controller");
-- 
2.27.0

