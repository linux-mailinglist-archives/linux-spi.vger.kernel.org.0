Return-Path: <linux-spi+bounces-4815-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5C7978A71
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 23:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6442B281764
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A3B148FEC;
	Fri, 13 Sep 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6zsKAKg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38F126C01
	for <linux-spi@vger.kernel.org>; Fri, 13 Sep 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261667; cv=none; b=XQxcjd33kNTETHDe6JmqJM1WufLkwG2huLnLC126t0/AI0LipHiurxiM7P0hjfSrb0palwza+Z82Jl117nB5AJPfW+L8k/tKaKFnJX4Z9hjyqo/3DlRcLdwkaUQ4BCaPdtI7NXfuGM4AXFos6cQQan3PisuiGx8WKd8csqqJb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261667; c=relaxed/simple;
	bh=oguSULFJRSSUqbNjkm6OMrWDpYu2DfA9lEtQvbYP2j0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBWDFiQAHm3x3NyjJse9BaO01NK9SOgHW6pDy7aTFhVnIMOjV1IDzfB+KgF+Zqb/pcZzCSxHqEEd/Ac5ciHJ52Avf6kAaLMR3/Lwe3ffRYSPHrGm7ZfIfZ217W5tap62tzk/c42tsRqGWGXLLZuk+3e/rWNpjvEX559g9jgYSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6zsKAKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CBFC4CEC0;
	Fri, 13 Sep 2024 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726261666;
	bh=oguSULFJRSSUqbNjkm6OMrWDpYu2DfA9lEtQvbYP2j0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J6zsKAKgTJiWzj2PWe8uE+1ouHR4PTs6HAjyd607q8boNqrW+CtPOe2lF2j3N0i9j
	 jHL3UJqbgz2IY+0DwBZa02PfyY3Fsm5OUGUGhIfLcjaJei69PhFjqlCUn3niGmht/8
	 o0wV42Mkm26udMsSGDaR7WpUwojrsI39CFhjfM60sfvg4hZOCzTmHMD65Zz597Tpbb
	 B34e1bVUBqyJr3+JTWnm8SYDmstRAi2lOBT5thvbfVC3ot8ylRqFuHQr95YfKJ25o1
	 Fu6efUsbi081Rzv8bEkmhKSKzNmBAR58PlPtqceK+J1i+2AV7d4TInulpKOaxukfDh
	 XG3Wlbcc1qRCQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 13 Sep 2024 23:07:16 +0200
Subject: [PATCH 4/4] spi: airoha: do not keep {tx,rx} dma buffer always
 mapped
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-airoha-spi-fixes-v1-4-de2e74ed4664@kernel.org>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
In-Reply-To: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Mark Brown <broonie@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.1

DMA map txrx_buf on demand and do not keep it always mapped.
This patch does not introduce any functional change to the driver, it just
simplifies the code without any performance degradation according to the
results of the mtd_speedtest kernel module test.

Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 152 +++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 83 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 94458df53eae..16c528883cca 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -206,13 +206,6 @@ enum airoha_snand_cs {
 	SPI_CHIP_SEL_LOW,
 };
 
-struct airoha_snand_dev {
-	size_t buf_len;
-
-	u8 *txrx_buf;
-	dma_addr_t dma_addr;
-};
-
 struct airoha_snand_ctrl {
 	struct device *dev;
 	struct regmap *regmap_ctrl;
@@ -617,9 +610,9 @@ static bool airoha_snand_supports_op(struct spi_mem *mem,
 
 static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(desc->mem->spi);
+	u8 *txrx_buf = spi_get_ctldata(desc->mem->spi);
 
-	if (!as_dev->txrx_buf)
+	if (!txrx_buf)
 		return -EINVAL;
 
 	if (desc->info.offset + desc->info.length > U32_MAX)
@@ -634,10 +627,11 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_device *spi = desc->mem->spi;
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
 	struct spi_mem_op *op = &desc->info.op_tmpl;
+	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
+	u8 *txrx_buf = spi_get_ctldata(spi);
+	dma_addr_t dma_addr;
 	u32 val, rd_mode;
 	int err;
 
@@ -662,14 +656,16 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		return err;
 
-	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
-				   as_dev->buf_len, DMA_BIDIRECTIONAL);
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(as_ctrl->dev, dma_addr))
+		return -ENOMEM;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
-			   as_dev->dma_addr);
+			   dma_addr);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set cust sec size */
 	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
@@ -678,58 +674,58 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_READ_DATA_BYTE_NUM, val);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
 			   op->cmd.opcode);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set read mode */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
 			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, rd_mode));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set read addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set nfi read */
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 				 SPI_NFI_OPMODE,
 				 FIELD_PREP(SPI_NFI_OPMODE, 6));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 			      SPI_NFI_READ_MODE | SPI_NFI_DMA_MODE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x0);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* trigger dma start read */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_RD_TRIG);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 			      SPI_NFI_RD_TRIG);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_read_poll_timeout(as_ctrl->regmap_nfi,
 				       REG_SPI_NFI_SNF_STA_CTL1, val,
 				       (val & SPI_NFI_READ_FROM_CACHE_DONE),
 				       0, 1 * USEC_PER_SEC);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/*
 	 * SPI_NFI_READ_FROM_CACHE_DONE bit must be written at the end
@@ -739,35 +735,41 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				SPI_NFI_READ_FROM_CACHE_DONE,
 				SPI_NFI_READ_FROM_CACHE_DONE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_read_poll_timeout(as_ctrl->regmap_nfi, REG_SPI_NFI_INTR,
 				       val, (val & SPI_NFI_AHB_DONE), 0,
 				       1 * USEC_PER_SEC);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* DMA read need delay for data ready from controller to DRAM */
 	udelay(1);
 
-	dma_sync_single_for_cpu(as_ctrl->dev, as_dev->dma_addr,
-				as_dev->buf_len, DMA_BIDIRECTIONAL);
+	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
+			 DMA_FROM_DEVICE);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
 		return err;
 
-	memcpy(buf, as_dev->txrx_buf + offs, len);
+	memcpy(buf, txrx_buf + offs, len);
 
 	return len;
+
+error_dma_unmap:
+	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
+			 DMA_FROM_DEVICE);
+	return err;
 }
 
 static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len, const void *buf)
 {
-	struct spi_device *spi = desc->mem->spi;
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
 	struct spi_mem_op *op = &desc->info.op_tmpl;
+	struct spi_device *spi = desc->mem->spi;
+	u8 *txrx_buf = spi_get_ctldata(spi);
 	struct airoha_snand_ctrl *as_ctrl;
+	dma_addr_t dma_addr;
 	u32 wr_mode, val;
 	int err;
 
@@ -776,19 +778,19 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err < 0)
 		return err;
 
-	dma_sync_single_for_cpu(as_ctrl->dev, as_dev->dma_addr,
-				as_dev->buf_len, DMA_BIDIRECTIONAL);
-	memcpy(as_dev->txrx_buf + offs, buf, len);
-	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
-				   as_dev->buf_len, DMA_BIDIRECTIONAL);
+	memcpy(txrx_buf + offs, buf, len);
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+	if (dma_mapping_error(as_ctrl->dev, dma_addr))
+		return -ENOMEM;
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-		return err;
+		goto error_dma_unmap;
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	if (op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
 	    op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
@@ -797,9 +799,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		wr_mode = 0;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
-			   as_dev->dma_addr);
+			   dma_addr);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
 			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
@@ -807,65 +809,65 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
 				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL1,
 			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD,
 				      op->cmd.opcode));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
 			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 				SPI_NFI_READ_MODE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 				 SPI_NFI_OPMODE,
 				 FIELD_PREP(SPI_NFI_OPMODE, 3));
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CNFG,
 			      SPI_NFI_DMA_MODE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_CMD, 0x80);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_WR_TRIG);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_set_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 			      SPI_NFI_WR_TRIG);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_read_poll_timeout(as_ctrl->regmap_nfi, REG_SPI_NFI_INTR,
 				       val, (val & SPI_NFI_AHB_DONE), 0,
 				       1 * USEC_PER_SEC);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	err = regmap_read_poll_timeout(as_ctrl->regmap_nfi,
 				       REG_SPI_NFI_SNF_STA_CTL1, val,
 				       (val & SPI_NFI_LOAD_TO_CACHE_DONE),
 				       0, 1 * USEC_PER_SEC);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/*
 	 * SPI_NFI_LOAD_TO_CACHE_DONE bit must be written at the end
@@ -875,13 +877,20 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 				SPI_NFI_LOAD_TO_CACHE_DONE,
 				SPI_NFI_LOAD_TO_CACHE_DONE);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
+	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
+			 DMA_TO_DEVICE);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
 		return err;
 
 	return len;
+
+error_dma_unmap:
+	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
+			 DMA_TO_DEVICE);
+	return err;
 }
 
 static int airoha_snand_exec_op(struct spi_mem *mem,
@@ -956,42 +965,20 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
-	struct airoha_snand_dev *as_dev;
-
-	as_ctrl = spi_controller_get_devdata(spi->controller);
-
-	as_dev = devm_kzalloc(as_ctrl->dev, sizeof(*as_dev), GFP_KERNEL);
-	if (!as_dev)
-		return -ENOMEM;
+	u8 *txrx_buf;
 
 	/* prepare device buffer */
-	as_dev->buf_len = SPI_NAND_CACHE_SIZE;
-	as_dev->txrx_buf = devm_kzalloc(as_ctrl->dev, as_dev->buf_len,
-					GFP_KERNEL);
-	if (!as_dev->txrx_buf)
-		return -ENOMEM;
-
-	as_dev->dma_addr = dma_map_single(as_ctrl->dev, as_dev->txrx_buf,
-					  as_dev->buf_len, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(as_ctrl->dev, as_dev->dma_addr))
+	as_ctrl = spi_controller_get_devdata(spi->controller);
+	txrx_buf = devm_kzalloc(as_ctrl->dev, SPI_NAND_CACHE_SIZE,
+				GFP_KERNEL);
+	if (!txrx_buf)
 		return -ENOMEM;
 
-	spi_set_ctldata(spi, as_dev);
+	spi_set_ctldata(spi, txrx_buf);
 
 	return 0;
 }
 
-static void airoha_snand_cleanup(struct spi_device *spi)
-{
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
-	struct airoha_snand_ctrl *as_ctrl;
-
-	as_ctrl = spi_controller_get_devdata(spi->controller);
-	dma_unmap_single(as_ctrl->dev, as_dev->dma_addr,
-			 as_dev->buf_len, DMA_BIDIRECTIONAL);
-	spi_set_ctldata(spi, NULL);
-}
-
 static int airoha_snand_nfi_setup(struct airoha_snand_ctrl *as_ctrl)
 {
 	u32 val, sec_size, sec_num;
@@ -1093,7 +1080,6 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-	ctrl->cleanup = airoha_snand_cleanup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
 	err = airoha_snand_nfi_setup(as_ctrl);

-- 
2.46.0


