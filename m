Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677D7483E4A
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 09:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiADIg7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jan 2022 03:36:59 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53201 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiADIg7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 03:36:59 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 891A91C0006;
        Tue,  4 Jan 2022 08:36:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v9 13/13] spi: mxic: Add support for pipelined ECC operations
Date:   Tue,  4 Jan 2022 09:36:31 +0100
Message-Id: <20220104083631.40776-14-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220104083631.40776-1-miquel.raynal@bootlin.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
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
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig    |   2 +-
 drivers/spi/spi-mxic.c | 113 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 83e352b0c8f9..bff75629e872 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -856,7 +856,7 @@ config SPI_SYNQUACER
 
 config SPI_MXIC
 	tristate "Macronix MX25F0A SPI controller"
-	depends on SPI_MASTER
+	depends on SPI_MASTER && MTD_NAND_ECC
 	help
 	  This selects the Macronix MX25F0A SPI controller driver.
 
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 0d3390964c6f..55c092069301 100644
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
@@ -177,6 +180,12 @@ struct mxic_spi {
 		dma_addr_t dma;
 		size_t size;
 	} linear;
+
+	struct {
+		bool use_pipelined_conf;
+		struct nand_ecc_engine *pipelined_engine;
+		void *ctx;
+	} ecc;
 };
 
 static int mxic_spi_clk_enable(struct mxic_spi *mxic)
@@ -400,7 +409,15 @@ static ssize_t mxic_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	       LMODE_EN,
 	       mxic->regs + LRD_CTRL);
 
-	memcpy_fromio(buf, mxic->linear.map, len);
+	if (mxic->ecc.use_pipelined_conf && desc->info.op_tmpl.data.ecc) {
+		ret = mxic_ecc_process_data_pipelined(mxic->ecc.pipelined_engine,
+						      NAND_PAGE_READ,
+						      mxic->linear.dma + offs);
+		if (ret)
+			return ret;
+	} else {
+		memcpy_fromio(buf, mxic->linear.map, len);
+	}
 
 	writel(INT_LRD_DIS, mxic->regs + INT_STS);
 	writel(0, mxic->regs + LRD_CTRL);
@@ -436,7 +453,15 @@ static ssize_t mxic_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	       LMODE_EN,
 	       mxic->regs + LWR_CTRL);
 
-	memcpy_toio(mxic->linear.map, buf, len);
+	if (mxic->ecc.use_pipelined_conf && desc->info.op_tmpl.data.ecc) {
+		ret = mxic_ecc_process_data_pipelined(mxic->ecc.pipelined_engine,
+						      NAND_PAGE_WRITE,
+						      mxic->linear.dma + offs);
+		if (ret)
+			return ret;
+	} else {
+		memcpy_toio(mxic->linear.map, buf, len);
+	}
 
 	writel(INT_LWR_DIS, mxic->regs + INT_STS);
 	writel(0, mxic->regs + LWR_CTRL);
@@ -547,6 +572,7 @@ static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 
 static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 	.dtr = true,
+	.ecc = true,
 };
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
@@ -611,6 +637,80 @@ static int mxic_spi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
+/* ECC wrapper */
+static int mxic_spi_mem_ecc_init_ctx(struct nand_device *nand)
+{
+	struct nand_ecc_engine_ops *ops = mxic_ecc_get_pipelined_ops();
+	struct mxic_spi *mxic = nand->ecc.engine->priv;
+
+	mxic->ecc.use_pipelined_conf = true;
+
+	return ops->init_ctx(nand);
+}
+
+static void mxic_spi_mem_ecc_cleanup_ctx(struct nand_device *nand)
+{
+	struct nand_ecc_engine_ops *ops = mxic_ecc_get_pipelined_ops();
+	struct mxic_spi *mxic = nand->ecc.engine->priv;
+
+	mxic->ecc.use_pipelined_conf = false;
+
+	ops->cleanup_ctx(nand);
+}
+
+static int mxic_spi_mem_ecc_prepare_io_req(struct nand_device *nand,
+					   struct nand_page_io_req *req)
+{
+	struct nand_ecc_engine_ops *ops = mxic_ecc_get_pipelined_ops();
+
+	return ops->prepare_io_req(nand, req);
+}
+
+static int mxic_spi_mem_ecc_finish_io_req(struct nand_device *nand,
+					  struct nand_page_io_req *req)
+{
+	struct nand_ecc_engine_ops *ops = mxic_ecc_get_pipelined_ops();
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
+static void mxic_spi_mem_ecc_remove(struct mxic_spi *mxic)
+{
+	if (mxic->ecc.pipelined_engine) {
+		mxic_ecc_put_pipelined_engine(mxic->ecc.pipelined_engine);
+		nand_ecc_unregister_on_host_hw_engine(mxic->ecc.pipelined_engine);
+	}
+}
+
+static int mxic_spi_mem_ecc_probe(struct platform_device *pdev,
+				  struct mxic_spi *mxic)
+{
+	struct nand_ecc_engine *eng;
+
+	if (!mxic_ecc_get_pipelined_ops())
+		return -EOPNOTSUPP;
+
+	eng = mxic_ecc_get_pipelined_engine(pdev);
+	if (IS_ERR(eng))
+		return PTR_ERR(eng);
+
+	eng->dev = &pdev->dev;
+	eng->integration = NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
+	eng->ops = &mxic_spi_mem_ecc_engine_pipelined_ops;
+	eng->priv = mxic;
+	mxic->ecc.pipelined_engine = eng;
+	nand_ecc_register_on_host_hw_engine(eng);
+
+	return 0;
+}
+
 static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -656,6 +756,7 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	mxic = spi_master_get_devdata(master);
+	mxic->dev = &pdev->dev;
 
 	master->dev.of_node = pdev->dev.of_node;
 
@@ -702,6 +803,12 @@ static int mxic_spi_probe(struct platform_device *pdev)
 
 	mxic_spi_hw_init(mxic);
 
+	ret = mxic_spi_mem_ecc_probe(pdev, mxic);
+	if (ret == -EPROBE_DEFER) {
+		pm_runtime_disable(&pdev->dev);
+		return ret;
+	}
+
 	ret = spi_register_master(master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_master failed\n");
@@ -714,8 +821,10 @@ static int mxic_spi_probe(struct platform_device *pdev)
 static int mxic_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
+	struct mxic_spi *mxic = spi_master_get_devdata(master);
 
 	pm_runtime_disable(&pdev->dev);
+	mxic_spi_mem_ecc_remove(mxic);
 	spi_unregister_master(master);
 
 	return 0;
-- 
2.27.0

