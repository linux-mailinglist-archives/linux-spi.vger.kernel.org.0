Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C59426EB4
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbhJHQZN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 12:25:13 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:45577 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhJHQYv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 12:24:51 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6A702240013;
        Fri,  8 Oct 2021 16:22:53 +0000 (UTC)
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
Subject: [RFC PATCH 10/10] spi: mxic: Add support for pipelined ECC operations
Date:   Fri,  8 Oct 2021 18:22:28 +0200
Message-Id: <20211008162228.1753083-11-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some SPI-NAND chips do not have a proper on-die ECC engine providing
error correction/detection. This is particularly an issue on embedded
devices with limited resources because all the computations must
happen in software, unless an external hardware engine is provided.

These external engines are new and can be of two categories: external
or pipelined. Macronix is providing both, the former being already
supported. The second, however, is very SoC implementation dependent
and must be instantiated by the SPI host controller directly.

An entire subsystem has been contributed to support these engines which
makes the insertion into another subsystem such as SPI quite
straightforward without the need for a lot of specific functions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mxic.c | 114 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index e10c55ee4d06..9481d1685faf 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -12,6 +12,8 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/nand-ecc-mxic.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -167,6 +169,7 @@
 #define HW_TEST(x)		(0xe0 + ((x) * 4))
 
 struct mxic_spi {
+	struct device *dev;
 	struct clk *ps_clk;
 	struct clk *send_clk;
 	struct clk *send_dly_clk;
@@ -177,6 +180,10 @@ struct mxic_spi {
 		dma_addr_t dma;
 		size_t size;
 	} linear;
+	struct {
+		struct nand_ecc_engine *engine;
+		bool enabled;
+	} ecc;
 };
 
 static int mxic_spi_clk_enable(struct mxic_spi *mxic)
@@ -369,6 +376,13 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 	return 0;
 }
 
+static struct mxic_ecc_engine *mxic_spi_to_ecc_engine(struct mxic_spi *mxic)
+{
+	struct nand_ecc_engine *ecc_engine = mxic->ecc.engine;
+
+	return ecc_engine->priv;
+}
+
 static ssize_t mxic_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
@@ -391,7 +405,14 @@ static ssize_t mxic_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	len = min_t(size_t, len, mxic->linear.size);
 	writel(len, mxic->regs + LRD_RANGE);
 
-	memcpy_fromio(buf, mxic->linear.map, len);
+	if (mxic->ecc.enabled) {
+		ret = mxic_ecc_process_data(mxic_spi_to_ecc_engine(mxic),
+					    mxic->linear.dma + offs);
+		if (ret)
+			return ret;
+	} else {
+		memcpy_fromio(buf, mxic->linear.map, len);
+	}
 
 	writel(INT_LRD_DIS, mxic->regs + INT_STS);
 	writel(0, mxic->regs + LRD_CTRL);
@@ -427,7 +448,14 @@ static ssize_t mxic_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	len = min_t(size_t, len, mxic->linear.size);
 	writel(len, mxic->regs + LWR_RANGE);
 
-	memcpy_toio(mxic->linear.map, buf, len);
+	if (mxic->ecc.enabled) {
+		ret = mxic_ecc_process_data(mxic_spi_to_ecc_engine(mxic),
+					    mxic->linear.dma + offs);
+		if (ret)
+			return ret;
+	} else {
+		memcpy_toio(mxic->linear.map, buf, len);
+	}
 
 	writel(INT_LWR_DIS, mxic->regs + INT_STS);
 	writel(0, mxic->regs + LWR_CTRL);
@@ -595,6 +623,80 @@ static int mxic_spi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
+/* ECC wrapper */
+static int mxic_spi_mem_ecc_init_ctx(struct nand_device *nand)
+{
+	struct nand_ecc_engine_ops *ops = mxic_ecc_get_pipelined_ops();
+
+	return ops->init_ctx(nand);
+}
+
+static void mxic_spi_mem_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	struct nand_ecc_engine_ops *ops = mxic_ecc_get_pipelined_ops();
+
+	ops->cleanup_ctx(nand);
+}
+
+static struct mxic_spi *mxic_nand_to_spi(struct nand_device *nand)
+{
+	struct device *dev = nand->ecc.engine->dev;
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mxic_spi *mxic = spi_master_get_devdata(master);
+
+	return mxic;
+}
+
+static int mxic_spi_mem_ecc_prepare_io_req(struct nand_device *nand,
+					   struct nand_page_io_req *req)
+{
+	struct nand_ecc_engine_ops *ops = mxic_ecc_get_pipelined_ops();
+	struct mxic_spi *mxic = mxic_nand_to_spi(nand);
+
+	mxic->ecc.enabled = (req->mode != MTD_OPS_RAW);
+
+	return ops->prepare_io_req(nand, req);
+}
+
+static int mxic_spi_mem_ecc_finish_io_req(struct nand_device *nand,
+					  struct nand_page_io_req *req)
+{
+	struct nand_ecc_engine_ops *ops = mxic_ecc_get_pipelined_ops();
+	struct mxic_spi *mxic = mxic_nand_to_spi(nand);
+
+	mxic->ecc.enabled = false;
+
+	return ops->finish_io_req(nand, req);
+}
+
+static struct nand_ecc_engine_ops mxic_spi_mem_ecc_engine_pipelined_ops = {
+	.init_ctx = mxic_spi_mem_ecc_init_ctx,
+	.cleanup_ctx = mxic_spi_mem_ecc_cleanup_ctx,
+	.prepare_io_req = mxic_spi_mem_ecc_prepare_io_req,
+	.finish_io_req = mxic_spi_mem_ecc_finish_io_req,
+};
+
+static int mxic_spi_mem_ecc_probe(struct platform_device *pdev,
+				  struct mxic_spi *mxic)
+{
+	struct nand_ecc_engine *ecceng;
+
+	if (!mxic_ecc_get_pipelined_ops())
+		return -EOPNOTSUPP;
+
+	ecceng = devm_kzalloc(&pdev->dev, sizeof(*ecceng), GFP_KERNEL);
+	if (!ecceng)
+		return -ENOMEM;
+
+	ecceng->dev = &pdev->dev;
+	ecceng->ops = &mxic_spi_mem_ecc_engine_pipelined_ops;
+
+	nand_ecc_register_on_host_hw_engine(ecceng);
+	mxic->ecc.engine = ecceng;
+
+	return 0;
+}
+
 static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -640,6 +742,7 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	mxic = spi_master_get_devdata(master);
+	mxic->dev = &pdev->dev;
 
 	master->dev.of_node = pdev->dev.of_node;
 
@@ -684,6 +787,10 @@ static int mxic_spi_probe(struct platform_device *pdev)
 
 	mxic_spi_hw_init(mxic);
 
+	ret = mxic_spi_mem_ecc_probe(pdev, mxic);
+	if (ret)
+		dev_warn(&pdev->dev, "SPI-mem ECC engine not available\n");
+
 	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
@@ -696,8 +803,11 @@ static int mxic_spi_probe(struct platform_device *pdev)
 static int mxic_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
+	struct mxic_spi *mxic = spi_master_get_devdata(master);
+	struct nand_ecc_engine *ecc_engine = mxic->ecc.engine;
 
 	pm_runtime_disable(&pdev->dev);
+	nand_ecc_unregister_on_host_hw_engine(ecc_engine);
 	spi_unregister_master(master);
 
 	return 0;
-- 
2.27.0

