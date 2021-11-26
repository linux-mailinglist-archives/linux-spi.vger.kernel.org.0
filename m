Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5146245ED34
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 12:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377218AbhKZMBC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 07:01:02 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:39403 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348929AbhKZL7A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 06:59:00 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 73F87C82CC;
        Fri, 26 Nov 2021 11:40:16 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4A4DCFF822;
        Fri, 26 Nov 2021 11:39:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 14/20] mtd: nand: mxic-ecc: Support SPI pipelined mode
Date:   Fri, 26 Nov 2021 12:39:18 +0100
Message-Id: <20211126113924.310459-15-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211126113924.310459-1-miquel.raynal@bootlin.com>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/ecc-mxic.c       | 210 +++++++++++++++++++++++++++++-
 include/linux/mtd/nand-ecc-mxic.h |  50 +++++++
 2 files changed, 259 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/mtd/nand-ecc-mxic.h

diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
index 3aa8b51a46d6..2fe148d2e0a7 100644
--- a/drivers/mtd/nand/ecc-mxic.c
+++ b/drivers/mtd/nand/ecc-mxic.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
+#include <linux/mtd/nand-ecc-mxic.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
@@ -40,7 +41,9 @@
 #define INTRPT_SIG_EN 0x0C
 /* Host Controller Configuration */
 #define HC_CONFIG 0x10
+#define   DEV2MEM 0 /* TRANS_TYP_DMA in the spec */
 #define   MEM2MEM BIT(4) /* TRANS_TYP_IO in the spec */
+#define   MAPPING BIT(5) /* TRANS_TYP_MAPPING in the spec */
 #define   ECC_PACKED 0 /* LAYOUT_TYP_INTEGRATED in the spec */
 #define   ECC_INTERLEAVED BIT(2) /* LAYOUT_TYP_DISTRIBUTED in the spec */
 #define   BURST_TYP_FIXED 0
@@ -87,6 +90,7 @@ struct mxic_ecc_engine {
 	int irq;
 	struct completion complete;
 	struct nand_ecc_engine external_engine;
+	struct nand_ecc_engine pipelined_engine;
 	struct mutex lock;
 };
 
@@ -104,6 +108,7 @@ struct mxic_ecc_ctx {
 	u8 *oobwithstat;
 	struct scatterlist sg[2];
 	struct nand_page_io_req *req;
+	unsigned int pageoffs;
 };
 
 static struct mxic_ecc_engine *ext_ecc_eng_to_mxic(struct nand_ecc_engine *eng)
@@ -111,11 +116,19 @@ static struct mxic_ecc_engine *ext_ecc_eng_to_mxic(struct nand_ecc_engine *eng)
 	return container_of(eng, struct mxic_ecc_engine, external_engine);
 }
 
+static struct mxic_ecc_engine *pip_ecc_eng_to_mxic(struct nand_ecc_engine *eng)
+{
+	return container_of(eng, struct mxic_ecc_engine, pipelined_engine);
+}
+
 static struct mxic_ecc_engine *nand_to_mxic(struct nand_device *nand)
 {
 	struct nand_ecc_engine *eng = nand->ecc.engine;
 
-	return ext_ecc_eng_to_mxic(eng);
+	if (eng->integration == NAND_ECC_ENGINE_INTEGRATION_EXTERNAL)
+		return ext_ecc_eng_to_mxic(eng);
+	else
+		return pip_ecc_eng_to_mxic(eng);
 }
 
 static int mxic_ecc_ooblayout_ecc(struct mtd_info *mtd, int section,
@@ -203,6 +216,31 @@ static irqreturn_t mxic_ecc_isr(int irq, void *dev_id)
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
 	struct mxic_ecc_engine *mxic = nand_to_mxic(nand);
@@ -364,6 +402,42 @@ static int mxic_ecc_init_ctx_external(struct nand_device *nand)
 	return 0;
 }
 
+static int mxic_ecc_init_ctx_pipelined(struct nand_device *nand)
+{
+	struct mxic_ecc_engine *mxic = nand_to_mxic(nand);
+	struct mxic_ecc_ctx *ctx;
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
+	ctx = nand_to_ecc_ctx(nand);
+
+	/* All steps should be handled in one go directly by the internal DMA */
+	writel(ctx->steps, mxic->regs + CHUNK_CNT);
+
+	/*
+	 * Interleaved ECC scheme cannot be used otherwise factory bad block
+	 * markers would be lost. A packed layout is mandatory.
+	 */
+	writel(BURST_TYP_INCREASING | ECC_PACKED | MAPPING,
+	       mxic->regs + HC_CONFIG);
+
+	return 0;
+}
+
 static void mxic_ecc_cleanup_ctx(struct nand_device *nand)
 {
 	struct mxic_ecc_ctx *ctx = nand_to_ecc_ctx(nand);
@@ -419,6 +493,18 @@ static int mxic_ecc_process_data(struct mxic_ecc_engine *mxic,
 	return ret;
 }
 
+int mxic_ecc_process_data_pipelined(struct nand_ecc_engine *eng,
+				    unsigned int direction, dma_addr_t dirmap)
+{
+	struct mxic_ecc_engine *mxic = pip_ecc_eng_to_mxic(eng);
+
+	if (dirmap)
+		writel(dirmap, mxic->regs + HC_SLV_ADDR);
+
+	return mxic_ecc_process_data(mxic, direction);
+}
+EXPORT_SYMBOL_GPL(mxic_ecc_process_data_pipelined);
+
 static void mxic_ecc_extract_status_bytes(struct mxic_ecc_ctx *ctx)
 {
 	u8 *buf = ctx->oobwithstat;
@@ -598,6 +684,65 @@ static int mxic_ecc_finish_io_req_external(struct nand_device *nand,
 	return mxic_ecc_count_biterrs(mxic, nand);
 }
 
+/* Pipelined ECC engine helpers */
+static int mxic_ecc_prepare_io_req_pipelined(struct nand_device *nand,
+					     struct nand_page_io_req *req)
+{
+	struct mxic_ecc_engine *mxic = nand_to_mxic(nand);
+	struct mxic_ecc_ctx *ctx = nand_to_ecc_ctx(nand);
+	int nents;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	nand_ecc_tweak_req(&ctx->req_ctx, req);
+	ctx->req = req;
+
+	/* Copy the OOB buffer and add room for the ECC engine status bytes */
+	mxic_ecc_add_room_in_oobbuf(ctx, ctx->oobwithstat, ctx->req->oobbuf.in);
+
+	sg_set_buf(&ctx->sg[0], req->databuf.in, req->datalen);
+	sg_set_buf(&ctx->sg[1], ctx->oobwithstat,
+		   req->ooblen + (ctx->steps * STAT_BYTES));
+
+	nents = dma_map_sg(mxic->dev, ctx->sg, 2, DMA_BIDIRECTIONAL);
+	if (!nents)
+		return -EINVAL;
+
+	mutex_lock(&mxic->lock);
+
+	writel(sg_dma_address(&ctx->sg[0]), mxic->regs + SDMA_MAIN_ADDR);
+	writel(sg_dma_address(&ctx->sg[1]), mxic->regs + SDMA_SPARE_ADDR);
+
+	return 0;
+}
+
+static int mxic_ecc_finish_io_req_pipelined(struct nand_device *nand,
+					    struct nand_page_io_req *req)
+{
+	struct mxic_ecc_engine *mxic = nand_to_mxic(nand);
+	struct mxic_ecc_ctx *ctx = nand_to_ecc_ctx(nand);
+	int ret = 0;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	mutex_unlock(&mxic->lock);
+
+	dma_unmap_sg(mxic->dev, ctx->sg, 2, DMA_BIDIRECTIONAL);
+
+	if (req->type == NAND_PAGE_READ) {
+		mxic_ecc_extract_status_bytes(ctx);
+		mxic_ecc_reconstruct_oobbuf(ctx, ctx->req->oobbuf.in,
+					    ctx->oobwithstat);
+		ret = mxic_ecc_count_biterrs(mxic, nand);
+	}
+
+	nand_ecc_restore_req(&ctx->req_ctx, req);
+
+	return ret;
+}
+
 static struct nand_ecc_engine_ops mxic_ecc_engine_external_ops = {
 	.init_ctx = mxic_ecc_init_ctx_external,
 	.cleanup_ctx = mxic_ecc_cleanup_ctx,
@@ -605,6 +750,69 @@ static struct nand_ecc_engine_ops mxic_ecc_engine_external_ops = {
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
+static struct platform_device *
+mxic_ecc_get_pdev(struct platform_device *spi_pdev)
+{
+	struct platform_device *eng_pdev;
+	struct device_node *np;
+
+	/* Retrieve the nand-ecc-engine phandle */
+	np = of_parse_phandle(spi_pdev->dev.of_node, "nand-ecc-engine", 0);
+	if (!np)
+		return NULL;
+
+	/* Jump to the engine's device node */
+	eng_pdev = of_find_device_by_node(np);
+	of_node_put(np);
+
+	return eng_pdev;
+}
+
+void mxic_ecc_put_pipelined_engine(struct nand_ecc_engine *eng)
+{
+	struct mxic_ecc_engine *mxic = pip_ecc_eng_to_mxic(eng);
+
+	platform_device_put(to_platform_device(mxic->dev));
+}
+EXPORT_SYMBOL_GPL(mxic_ecc_put_pipelined_engine);
+
+struct nand_ecc_engine *
+mxic_ecc_get_pipelined_engine(struct platform_device *spi_pdev)
+{
+	struct platform_device *eng_pdev;
+	struct mxic_ecc_engine *mxic;
+
+	eng_pdev = mxic_ecc_get_pdev(spi_pdev);
+	if (!eng_pdev)
+		return ERR_PTR(-ENODEV);
+
+	mxic = platform_get_drvdata(eng_pdev);
+	if (!mxic) {
+		platform_device_put(eng_pdev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	return &mxic->pipelined_engine;
+}
+EXPORT_SYMBOL_GPL(mxic_ecc_get_pipelined_engine);
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
index 000000000000..118b5c8d83ff
--- /dev/null
+++ b/include/linux/mtd/nand-ecc-mxic.h
@@ -0,0 +1,50 @@
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
+#include <linux/platform_device.h>
+#include <linux/device.h>
+
+struct mxic_ecc_engine;
+
+#if IS_ENABLED(CONFIG_MTD_NAND_ECC_MXIC)
+
+struct nand_ecc_engine_ops *mxic_ecc_get_pipelined_ops(void);
+struct nand_ecc_engine *
+mxic_ecc_get_pipelined_engine(struct platform_device *spi_pdev);
+void mxic_ecc_put_pipelined_engine(struct nand_ecc_engine *eng);
+int mxic_ecc_process_data_pipelined(struct nand_ecc_engine *eng,
+				    unsigned int direction, dma_addr_t dirmap);
+
+#else /* !CONFIG_MTD_NAND_ECC_MXIC */
+
+static inline struct nand_ecc_engine_ops *mxic_ecc_get_pipelined_ops(void)
+{
+	return NULL;
+}
+
+struct nand_ecc_engine *
+mxic_ecc_get_pipelined_engine(struct platform_device *spi_pdev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+void mxic_ecc_put_pipelined_engine(struct nand_ecc_engine *eng) {}
+
+static inline int
+mxic_ecc_process_data_pipelined(struct nand_ecc_engine *eng,
+				unsigned int direction, dma_addr_t dirmap)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_MTD_NAND_ECC_MXIC */
+
+#endif /* __MTD_NAND_ECC_MXIC_H__ */
-- 
2.27.0

