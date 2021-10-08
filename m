Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B86426EAF
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhJHQYv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 12:24:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:36397 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhJHQYt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 12:24:49 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BF6DA240011;
        Fri,  8 Oct 2021 16:22:51 +0000 (UTC)
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
Subject: [RFC PATCH 09/10] spi: mxic: Add support for direct mapping
Date:   Fri,  8 Oct 2021 18:22:27 +0200
Message-Id: <20211008162228.1753083-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Implement the ->dirmap_create() and ->dirmap_read/write() hooks to
provide a fast path for read and write accesses.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mxic.c | 171 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 144 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 4fb19e6f94b0..e10c55ee4d06 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -172,6 +172,11 @@ struct mxic_spi {
 	struct clk *send_dly_clk;
 	void __iomem *regs;
 	u32 cur_speed_hz;
+	struct {
+		void __iomem *map;
+		dma_addr_t dma;
+		size_t size;
+	} linear;
 };
 
 static int mxic_spi_clk_enable(struct mxic_spi *mxic)
@@ -280,6 +285,42 @@ static void mxic_spi_hw_init(struct mxic_spi *mxic)
 	       mxic->regs + HC_CFG);
 }
 
+static u32 mxic_spi_mem_prep_op_cfg(const struct spi_mem_op *op)
+{
+	u32 cfg = OP_CMD_BYTES(1) | OP_CMD_BUSW(fls(op->cmd.buswidth) - 1);
+
+	if (op->addr.nbytes)
+		cfg |= OP_ADDR_BYTES(op->addr.nbytes) |
+		       OP_ADDR_BUSW(fls(op->addr.buswidth) - 1);
+
+	if (op->dummy.nbytes)
+		cfg |= OP_DUMMY_CYC(op->dummy.nbytes);
+
+	if (op->data.dir != SPI_MEM_NO_DATA) {
+		cfg |= OP_DATA_BUSW(fls(op->data.buswidth) - 1);
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			cfg |= OP_READ;
+	}
+
+	return cfg;
+}
+
+static void mxic_spi_set_hc_cfg(struct spi_device *spi, u32 flags)
+{
+	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
+	int nio = 1;
+
+	if (spi->mode & (SPI_TX_QUAD | SPI_RX_QUAD))
+		nio = 4;
+	else if (spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
+		nio = 2;
+
+	writel(flags | HC_CFG_NIO(nio) |
+	       HC_CFG_TYPE(spi->chip_select, HC_CFG_TYPE_SPI_NOR) |
+	       HC_CFG_SLV_ACT(spi->chip_select) | HC_CFG_IDLE_SIO_LVL(1),
+	       mxic->regs + HC_CFG);
+}
+
 static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 			      void *rxbuf, unsigned int len)
 {
@@ -328,6 +369,77 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
 	return 0;
 }
 
+static ssize_t mxic_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+					u64 offs, size_t len, void *buf)
+{
+	struct mxic_spi *mxic = spi_master_get_devdata(desc->mem->spi->master);
+	int ret;
+	u32 sts;
+
+	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
+		return -EINVAL;
+
+	mxic_spi_set_hc_cfg(desc->mem->spi, 0);
+
+	writel(LMODE_CMD0(desc->info.op_tmpl.cmd.opcode) |
+	       LMODE_SLV_ACT(desc->mem->spi->chip_select) |
+	       LMODE_EN,
+	       mxic->regs + LRD_CTRL);
+	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl),
+	       mxic->regs + LRD_CFG);
+	writel(desc->info.offset + offs, mxic->regs + LRD_ADDR);
+	len = min_t(size_t, len, mxic->linear.size);
+	writel(len, mxic->regs + LRD_RANGE);
+
+	memcpy_fromio(buf, mxic->linear.map, len);
+
+	writel(INT_LRD_DIS, mxic->regs + INT_STS);
+	writel(0, mxic->regs + LRD_CTRL);
+
+	ret = readl_poll_timeout(mxic->regs + INT_STS, sts,
+				 sts & INT_LRD_DIS, 0, USEC_PER_SEC);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t mxic_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
+					 u64 offs, size_t len,
+					 const void *buf)
+{
+	struct mxic_spi *mxic = spi_master_get_devdata(desc->mem->spi->master);
+	u32 sts;
+	int ret;
+
+	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
+		return -EINVAL;
+
+	mxic_spi_set_hc_cfg(desc->mem->spi, 0);
+
+	writel(LMODE_CMD0(desc->info.op_tmpl.cmd.opcode) |
+	       LMODE_SLV_ACT(desc->mem->spi->chip_select) |
+	       LMODE_EN,
+	       mxic->regs + LWR_CTRL);
+	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl),
+	       mxic->regs + LWR_CFG);
+	writel(desc->info.offset + offs, mxic->regs + LWR_ADDR);
+	len = min_t(size_t, len, mxic->linear.size);
+	writel(len, mxic->regs + LWR_RANGE);
+
+	memcpy_toio(mxic->linear.map, buf, len);
+
+	writel(INT_LWR_DIS, mxic->regs + INT_STS);
+	writel(0, mxic->regs + LWR_CTRL);
+
+	ret = readl_poll_timeout(mxic->regs + INT_STS, sts,
+				 sts & INT_LWR_DIS, 0, USEC_PER_SEC);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
 static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 				     const struct spi_mem_op *op)
 {
@@ -345,12 +457,27 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static int mxic_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct mxic_spi *mxic = spi_master_get_devdata(desc->mem->spi->master);
+
+	if (!mxic->linear.map)
+		return -ENOTSUPP;
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -ENOTSUPP;
+
+	if (!mxic_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+		return -ENOTSUPP;
+
+	return 0;
+}
+
 static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
 	struct mxic_spi *mxic = spi_master_get_devdata(mem->spi->master);
-	int nio = 1, i, ret;
-	u32 ss_ctrl;
+	int i, ret;
 	u8 addr[8];
 	u8 opcode = op->cmd.opcode;
 
@@ -358,34 +485,12 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	if (ret)
 		return ret;
 
-	if (mem->spi->mode & (SPI_TX_QUAD | SPI_RX_QUAD))
-		nio = 4;
-	else if (mem->spi->mode & (SPI_TX_DUAL | SPI_RX_DUAL))
-		nio = 2;
+	mxic_spi_set_hc_cfg(mem->spi, HC_CFG_MAN_CS_EN);
 
-	writel(HC_CFG_NIO(nio) |
-	       HC_CFG_TYPE(mem->spi->chip_select, HC_CFG_TYPE_SPI_NOR) |
-	       HC_CFG_SLV_ACT(mem->spi->chip_select) | HC_CFG_IDLE_SIO_LVL(1) |
-	       HC_CFG_MAN_CS_EN,
-	       mxic->regs + HC_CFG);
 	writel(HC_EN_BIT, mxic->regs + HC_EN);
 
-	ss_ctrl = OP_CMD_BYTES(1) | OP_CMD_BUSW(fls(op->cmd.buswidth) - 1);
-
-	if (op->addr.nbytes)
-		ss_ctrl |= OP_ADDR_BYTES(op->addr.nbytes) |
-			   OP_ADDR_BUSW(fls(op->addr.buswidth) - 1);
-
-	if (op->dummy.nbytes)
-		ss_ctrl |= OP_DUMMY_CYC(op->dummy.nbytes);
-
-	if (op->data.nbytes) {
-		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1);
-		if (op->data.dir == SPI_MEM_DATA_IN)
-			ss_ctrl |= OP_READ;
-	}
-
-	writel(ss_ctrl, mxic->regs + SS_CTRL(mem->spi->chip_select));
+	writel(mxic_spi_mem_prep_op_cfg(op),
+	       mxic->regs + SS_CTRL(mem->spi->chip_select));
 
 	writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
 	       mxic->regs + HC_CFG);
@@ -423,6 +528,9 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 	.supports_op = mxic_spi_mem_supports_op,
 	.exec_op = mxic_spi_mem_exec_op,
+	.dirmap_create = mxic_spi_mem_dirmap_create,
+	.dirmap_read = mxic_spi_mem_dirmap_read,
+	.dirmap_write = mxic_spi_mem_dirmap_write,
 };
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
@@ -552,6 +660,15 @@ static int mxic_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(mxic->regs))
 		return PTR_ERR(mxic->regs);
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
+	mxic->linear.map = devm_ioremap_resource(&pdev->dev, res);
+	if (!IS_ERR(mxic->linear.map)) {
+		mxic->linear.dma = res->start;
+		mxic->linear.size = resource_size(res);
+	} else {
+		mxic->linear.map = NULL;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	master->auto_runtime_pm = true;
 
-- 
2.27.0

