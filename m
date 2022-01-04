Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D738483E48
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiADIg5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jan 2022 03:36:57 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59913 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiADIg5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 03:36:57 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id AB45A1C000D;
        Tue,  4 Jan 2022 08:36:54 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Zhengxun Li <zhengxunli@mxic.com.tw>
Subject: [PATCH v9 12/13] spi: mxic: Add support for direct mapping
Date:   Tue,  4 Jan 2022 09:36:30 +0100
Message-Id: <20220104083631.40776-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220104083631.40776-1-miquel.raynal@bootlin.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Implement the ->dirmap_create() and ->dirmap_read/write() hooks to
provide a fast path for read and write accesses.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Zhengxun Li <zhengxunli@mxic.com.tw>
Reviewed-by: Zhengxun Li <zhengxunli@mxic.com.tw>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxic.c | 112 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index ba9cda4bf161..0d3390964c6f 100644
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
@@ -296,7 +301,8 @@ static u32 mxic_spi_prep_hc_cfg(struct spi_device *spi, u32 flags)
 	       HC_CFG_SLV_ACT(spi->chip_select) | HC_CFG_IDLE_SIO_LVL(1);
 }
 
-static u32 mxic_spi_mem_prep_op_cfg(const struct spi_mem_op *op)
+static u32 mxic_spi_mem_prep_op_cfg(const struct spi_mem_op *op,
+				    unsigned int data_len)
 {
 	u32 cfg = OP_CMD_BYTES(op->cmd.nbytes) |
 		  OP_CMD_BUSW(fls(op->cmd.buswidth) - 1) |
@@ -310,7 +316,8 @@ static u32 mxic_spi_mem_prep_op_cfg(const struct spi_mem_op *op)
 	if (op->dummy.nbytes)
 		cfg |= OP_DUMMY_CYC(op->dummy.nbytes);
 
-	if (op->data.nbytes) {
+	/* Direct mapping data.nbytes field is not populated */
+	if (data_len) {
 		cfg |= OP_DATA_BUSW(fls(op->data.buswidth) - 1) |
 		       (op->data.dtr ? OP_DATA_DDR : 0);
 		if (op->data.dir == SPI_MEM_DATA_IN) {
@@ -371,6 +378,77 @@ static int mxic_spi_data_xfer(struct mxic_spi *mxic, const void *txbuf,
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
+	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0), mxic->regs + HC_CFG);
+
+	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl, len),
+	       mxic->regs + LRD_CFG);
+	writel(desc->info.offset + offs, mxic->regs + LRD_ADDR);
+	len = min_t(size_t, len, mxic->linear.size);
+	writel(len, mxic->regs + LRD_RANGE);
+	writel(LMODE_CMD0(desc->info.op_tmpl.cmd.opcode) |
+	       LMODE_SLV_ACT(desc->mem->spi->chip_select) |
+	       LMODE_EN,
+	       mxic->regs + LRD_CTRL);
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
+	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0), mxic->regs + HC_CFG);
+
+	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl, len),
+	       mxic->regs + LWR_CFG);
+	writel(desc->info.offset + offs, mxic->regs + LWR_ADDR);
+	len = min_t(size_t, len, mxic->linear.size);
+	writel(len, mxic->regs + LWR_RANGE);
+	writel(LMODE_CMD0(desc->info.op_tmpl.cmd.opcode) |
+	       LMODE_SLV_ACT(desc->mem->spi->chip_select) |
+	       LMODE_EN,
+	       mxic->regs + LWR_CTRL);
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
@@ -388,6 +466,22 @@ static bool mxic_spi_mem_supports_op(struct spi_mem *mem,
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static int mxic_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct mxic_spi *mxic = spi_master_get_devdata(desc->mem->spi->master);
+
+	if (!mxic->linear.map)
+		return -EINVAL;
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -EINVAL;
+
+	if (!mxic_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
@@ -404,7 +498,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 
 	writel(HC_EN_BIT, mxic->regs + HC_EN);
 
-	writel(mxic_spi_mem_prep_op_cfg(op),
+	writel(mxic_spi_mem_prep_op_cfg(op, op->data.nbytes),
 	       mxic->regs + SS_CTRL(mem->spi->chip_select));
 
 	writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
@@ -446,6 +540,9 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 	.supports_op = mxic_spi_mem_supports_op,
 	.exec_op = mxic_spi_mem_exec_op,
+	.dirmap_create = mxic_spi_mem_dirmap_create,
+	.dirmap_read = mxic_spi_mem_dirmap_read,
+	.dirmap_write = mxic_spi_mem_dirmap_write,
 };
 
 static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
@@ -579,6 +676,15 @@ static int mxic_spi_probe(struct platform_device *pdev)
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

