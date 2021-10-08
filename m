Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562FE426EAA
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhJHQYs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 12:24:48 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36397 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhJHQYo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 12:24:44 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D62CC24000B;
        Fri,  8 Oct 2021 16:22:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaimeliao@mxic.com.tw,
        juliensu@mxic.com.tw,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [RFC PATCH 07/10] mtd: nand: mxic-ecc: Support SPI pipelined mode
Date:   Fri,  8 Oct 2021 18:22:25 +0200
Message-Id: <20211008162228.1753083-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce the support for another possible configuration: the ECC
engine may work as DMA master (pipelined) and move itself the data
to/from the NAND chip into the buffer, applying the necessary
corrections/computations on the fly.

This driver offers an ECC engine implementation that must be
instatiated from a SPI controller driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/ecc-mxic.c       | 148 +++++++++++++++++++++++++++++-
 include/linux/mtd/nand-ecc-mxic.h |  36 ++++++++
 2 files changed, 181 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/mtd/nand-ecc-mxic.h

diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
index 8be816381f68..509e50a9136e 100644
--- a/drivers/mtd/nand/ecc-mxic.c
+++ b/drivers/mtd/nand/ecc-mxic.c
@@ -39,7 +39,9 @@
 #define INTRPT_SIG_EN 0x0C
 /* Host Controller Configuration */
 #define HC_CONFIG 0x10
+#define   DEV2MEM 0 /* TRANS_TYP_DMA in the spec */
 #define   MEM2MEM BIT(4) /* TRANS_TYP_IO in the spec */
+#define   MAPPING BIT(5) /* TRANS_TYP_MAPPING in the spec */
 #define   ECC_PACKED 0 /* LAYOUT_TYP_INTEGRATED in the spec */
 #define   ECC_INTERLEAVED BIT(2) /* LAYOUT_TYP_DISTRIBUTED in the spec */
 #define   BURST_TYP_FIXED 0
@@ -101,6 +103,7 @@ struct mxic_ecc_engine {
 	u8 *oobwithstat;
 	struct scatterlist sg[2];
 	struct nand_page_io_req *req;
+	unsigned int pageoffs;
 };
 
 static int mxic_ecc_ooblayout_ecc(struct mtd_info *mtd, int section,
@@ -188,6 +191,31 @@ static irqreturn_t mxic_ecc_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static struct device *mxic_ecc_get_engine_dev(struct device *dev)
+{
+	struct platform_device *eccpdev;
+	struct device_node *np;
+
+	/*
+	 * If the device node contains this property, it means the device does
+	 * not represent the actual ECC engine.
+	 */
+	np = of_parse_phandle(dev->of_node, "nand-ecc-engine", 0);
+	if (!np)
+		return dev;
+
+	eccpdev = of_find_device_by_node(np);
+	if (!eccpdev) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	platform_device_put(eccpdev);
+	of_node_put(np);
+
+	return &eccpdev->dev;
+}
+
 static int mxic_ecc_init_ctx(struct nand_device *nand, struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -379,6 +407,41 @@ static int mxic_ecc_init_ctx_external(struct nand_device *nand)
 	return 0;
 }
 
+static int mxic_ecc_init_ctx_pipelined(struct nand_device *nand)
+{
+	struct mxic_ecc_engine *eng;
+	struct device *dev;
+	int ret;
+
+	/*
+	 * In the case of a pipelined engine, the device registering the ECC
+	 * engine is not the actual ECC engine device but the host controller.
+	 */
+	dev = mxic_ecc_get_engine_dev(nand->ecc.engine->dev);
+	if (!dev)
+		return -EINVAL;
+
+	dev_info(dev, "Macronix ECC engine in pipelined/mapping mode\n");
+
+	ret = mxic_ecc_init_ctx(nand, dev);
+	if (ret)
+		return ret;
+
+	eng = nand->ecc.ctx.priv;
+
+	/* All steps should be handled in one go directly by the internal DMA */
+	writel(eng->steps, eng->regs + CHUNK_CNT);
+
+	/*
+	 * Interleaved ECC scheme cannot be used otherwise factory bad block
+	 * markers would be lost. A packed layout is mandatory.
+	 */
+	writel(BURST_TYP_INCREASING | ECC_PACKED | MAPPING,
+	       eng->regs + HC_CONFIG);
+
+	return 0;
+}
+
 static void mxic_ecc_cleanup_ctx(struct nand_device *nand)
 {
 	struct mxic_ecc_engine *eng = nand->ecc.ctx.priv;
@@ -414,18 +477,22 @@ static int mxic_ecc_data_xfer_wait_for_completion(struct mxic_ecc_engine *eng)
 	return 0;
 }
 
-static int mxic_ecc_process_data(struct mxic_ecc_engine *eng)
+int mxic_ecc_process_data(struct mxic_ecc_engine *eng, dma_addr_t dirmap)
 {
 	/* Retrieve the direction */
 	unsigned int dir = (eng->req->type == NAND_PAGE_READ) ?
 			   READ_NAND : WRITE_NAND;
 
+	if (dirmap)
+		writel(dirmap, eng->regs + HC_SLV_ADDR);
+
 	/* Trigger processing */
 	writel(SDMA_STRT | dir, eng->regs + SDMA_CTRL);
 
 	/* Wait for completion */
 	return mxic_ecc_data_xfer_wait_for_completion(eng);
 }
+EXPORT_SYMBOL_GPL(mxic_ecc_process_data);
 
 static void mxic_ecc_extract_status_bytes(struct mxic_ecc_engine *eng, u8 *buf)
 {
@@ -526,7 +593,7 @@ static int mxic_ecc_prepare_io_req_external(struct nand_device *nand,
 		       eng->regs + SDMA_MAIN_ADDR);
 		writel(sg_dma_address(&eng->sg[1]) + (step * (eng->oob_step_sz + STAT_BYTES)),
 		       eng->regs + SDMA_SPARE_ADDR);
-		ret = mxic_ecc_process_data(eng);
+		ret = mxic_ecc_process_data(eng, 0);
 		if (ret)
 			break;
 	}
@@ -580,7 +647,7 @@ static int mxic_ecc_finish_io_req_external(struct nand_device *nand,
 		       eng->regs + SDMA_MAIN_ADDR);
 		writel(sg_dma_address(&eng->sg[1]) + (step * (eng->oob_step_sz + STAT_BYTES)),
 		       eng->regs + SDMA_SPARE_ADDR);
-		ret = mxic_ecc_process_data(eng);
+		ret = mxic_ecc_process_data(eng, 0);
 		if (ret)
 			break;
 	}
@@ -598,6 +665,64 @@ static int mxic_ecc_finish_io_req_external(struct nand_device *nand,
 	return mxic_ecc_count_biterrs(eng, mtd);
 }
 
+/* Pipelined ECC engine helpers */
+static int mxic_ecc_prepare_io_req_pipelined(struct nand_device *nand,
+					     struct nand_page_io_req *req)
+{
+	struct mxic_ecc_engine *eng = nand->ecc.ctx.priv;
+	int nents;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	nand_ecc_tweak_req(&eng->req_ctx, req);
+	eng->req = req;
+
+	/* Copy the OOB buffer and add room for the ECC engine status bytes */
+	mxic_ecc_add_room_in_oobbuf(eng, eng->oobwithstat, eng->req->oobbuf.in);
+
+	sg_set_buf(&eng->sg[0], req->databuf.in, req->datalen);
+	sg_set_buf(&eng->sg[1], eng->oobwithstat,
+		   req->ooblen + (eng->steps * STAT_BYTES));
+
+	nents = dma_map_sg(eng->dev, eng->sg, 2, DMA_BIDIRECTIONAL);
+	if (!nents)
+		return -EINVAL;
+
+	writel(sg_dma_address(&eng->sg[0]), eng->regs + SDMA_MAIN_ADDR);
+	writel(sg_dma_address(&eng->sg[1]), eng->regs + SDMA_SPARE_ADDR);
+
+	mxic_ecc_enable_engine(eng);
+
+	return 0;
+}
+
+static int mxic_ecc_finish_io_req_pipelined(struct nand_device *nand,
+					    struct nand_page_io_req *req)
+{
+	struct mxic_ecc_engine *eng = nand->ecc.ctx.priv;
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	int ret = 0;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	mxic_ecc_disable_engine(eng);
+
+	dma_unmap_sg(eng->dev, eng->sg, 2, DMA_BIDIRECTIONAL);
+
+	if (req->type == NAND_PAGE_READ) {
+		mxic_ecc_extract_status_bytes(eng, eng->oobwithstat);
+		mxic_ecc_reconstruct_oobbuf(eng, eng->req->oobbuf.in,
+					    eng->oobwithstat);
+		ret = mxic_ecc_count_biterrs(eng, mtd);
+	}
+
+	nand_ecc_restore_req(&eng->req_ctx, req);
+
+	return ret;
+}
+
 static struct nand_ecc_engine_ops mxic_ecc_engine_external_ops = {
 	.init_ctx = mxic_ecc_init_ctx_external,
 	.cleanup_ctx = mxic_ecc_cleanup_ctx,
@@ -605,6 +730,23 @@ static struct nand_ecc_engine_ops mxic_ecc_engine_external_ops = {
 	.finish_io_req = mxic_ecc_finish_io_req_external,
 };
 
+static struct nand_ecc_engine_ops mxic_ecc_engine_pipelined_ops = {
+	.init_ctx = mxic_ecc_init_ctx_pipelined,
+	.cleanup_ctx = mxic_ecc_cleanup_ctx,
+	.prepare_io_req = mxic_ecc_prepare_io_req_pipelined,
+	.finish_io_req = mxic_ecc_finish_io_req_pipelined,
+};
+
+struct nand_ecc_engine_ops *mxic_ecc_get_pipelined_ops(void)
+{
+	return &mxic_ecc_engine_pipelined_ops;
+}
+EXPORT_SYMBOL_GPL(mxic_ecc_get_pipelined_ops);
+
+/*
+ * Only the external ECC engine is exported as the pipelined is SoC specific, so
+ * it is registered directly by the drivers that wrap it.
+ */
 static int mxic_ecc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/mtd/nand-ecc-mxic.h b/include/linux/mtd/nand-ecc-mxic.h
new file mode 100644
index 000000000000..d48b7fe05644
--- /dev/null
+++ b/include/linux/mtd/nand-ecc-mxic.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright © 2019 Macronix
+ * Author: Miquèl Raynal <miquel.raynal@bootlin.com>
+ *
+ * Header for the Macronix external ECC engine.
+ */
+
+#ifndef __MTD_NAND_ECC_MXIC_H__
+#define __MTD_NAND_ECC_MXIC_H__
+
+#include <linux/device.h>
+
+struct mxic_ecc_engine;
+
+#if IS_ENABLED(CONFIG_MTD_NAND_ECC_MXIC)
+
+struct nand_ecc_engine_ops *mxic_ecc_get_pipelined_ops(void);
+int mxic_ecc_process_data(struct mxic_ecc_engine *eng, dma_addr_t dirmap);
+
+#else /* !CONFIG_MTD_NAND_ECC_MXIC */
+
+struct nand_ecc_engine_ops *mxic_ecc_get_pipelined_ops(void)
+{
+	return NULL;
+}
+
+static inline
+int mxic_ecc_process_data(struct mxic_ecc_engine *eng, dma_addr_t dirmap)
+{
+	return -ENOTSUPP;
+}
+
+#endif /* CONFIG_MTD_NAND_ECC_MXIC */
+
+#endif /* __MTD_NAND_ECC_MXIC_H__ */
-- 
2.27.0

