Return-Path: <linux-spi+bounces-4916-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB697E2C3
	for <lists+linux-spi@lfdr.de>; Sun, 22 Sep 2024 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F61F21598
	for <lists+linux-spi@lfdr.de>; Sun, 22 Sep 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC1A29D1C;
	Sun, 22 Sep 2024 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlAXG/Ze"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866E26AC1
	for <linux-spi@vger.kernel.org>; Sun, 22 Sep 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727026736; cv=none; b=cFIwjF3vGgDvFnKopGqUsTAcJdReT+RSGy3v777bh3FUioUfooFgrAeH1AOcG49uCpoXtO31JvBPEEkpulPy0mN+uLvYQotaPtKXDHdz72jqy+Wbo8LvhEZt8mxVNOUE6ecnJwKZoGs4FJie3mNz6OtJRgdn3AsiEATfqZaNs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727026736; c=relaxed/simple;
	bh=jAM/Qp2BMdvx2PNdnpuZVlwmt28kOGKdX1ou7w2Ivys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h3hckrBAhnvyDJLZAC8MTXrMZB8C/TOM9Z1nGd43YuR3akpNudZUNGGgrdhz+eoEr1hztWVDKelfUPT9haJz8/znOYDzLyN6o+9jTvjjIH6phYxwzgEXDWsJy9C4dse+KEFsUEaO94MKv0hyvLKlcPnuBWImkWbO4arXYV2bRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlAXG/Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220AFC4CEC3;
	Sun, 22 Sep 2024 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727026735;
	bh=jAM/Qp2BMdvx2PNdnpuZVlwmt28kOGKdX1ou7w2Ivys=;
	h=From:Date:Subject:To:Cc:From;
	b=NlAXG/Ze6e6a+NUi7Eu2XlVqCiagJrZONOXdmJu9uO9yQPn3W2JTJu7qBIruYs1Hg
	 gN59MxLGHj6OoIMVyHX0Q4/+T81zCsZkgKXPV1646heqfR8i1Umcn/IVkDwrRLSzQo
	 yWZVScowts993Q+EsvZLQ93cmNjMfOxs5CTikXhksvDvRHx4evoO3Uu7iudgHMZ3hv
	 5VCR3lFUBxsJYz2MviFO4dtfIzYzRAE3mNJPajePd5FpAyumSwc0aR7BudNMlOPjIs
	 OvcLpzipIIxwXlMkq3MJj0ozoxjgkMumrZrgQIbD6TB6Hf+9SWXLKda1z1A9qWaw6Z
	 iJc2Ajrbco5YQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 22 Sep 2024 19:38:30 +0200
Subject: [PATCH v3] spi: airoha: do not keep {tx,rx} dma buffer always
 mapped
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240922-airoha-spi-fixes-v3-1-f958802b3d68@kernel.org>
X-B4-Tracking: v=1; b=H4sIABVW8GYC/33NQQrCMBAF0KuUrB1J01iJK+8hLpJm0g5KUyYSl
 NK7m3alIC7/H/6bWSRkwiRO1SwYMyWKYwnNrhLdYMcegXzJQkmlpakbsMRxsJAmgkBPTHBondO
 NDM6YIMpsYtwOZXW5ljxQekR+bR9yvbZ/sFyDBI8Kjxq9blt9viGPeN9H7sWqZfUpmB+CKkLnZ
 JDojVHSfgnLsrwB73sBmPMAAAA=
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Mark Brown <broonie@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.1

DMA map txrx_buf on demand in airoha_snand_dirmap_read and
airoha_snand_dirmap_write routines and do not keep it always mapped.
This patch is not fixing any bug or introducing any functional change
to the driver, it just simplifies the code and improve code readability
without introducing any performance degradation according to the results
obtained from the mtd_speedtest kernel module test.

root@OpenWrt:# insmod mtd_test.ko
root@OpenWrt:# insmod mtd_speedtest.ko dev=5
[   49.849869] =================================================
[   49.855659] mtd_speedtest: MTD device: 5
[   49.859583] mtd_speedtest: MTD device size 8388608, eraseblock size 131072, page size 2048, count of eraseblocks 64, pages per eraseblock 64, OOB size 128
[   49.874622] mtd_test: scanning for bad eraseblocks
[   49.879433] mtd_test: scanned 64 eraseblocks, 0 are bad
[   50.106372] mtd_speedtest: testing eraseblock write speed
[   53.083380] mtd_speedtest: eraseblock write speed is 2756 KiB/s
[   53.089322] mtd_speedtest: testing eraseblock read speed
[   54.143360] mtd_speedtest: eraseblock read speed is 7811 KiB/s
[   54.370365] mtd_speedtest: testing page write speed
[   57.349480] mtd_speedtest: page write speed is 2754 KiB/s
[   57.354895] mtd_speedtest: testing page read speed
[   58.410431] mtd_speedtest: page read speed is 7796 KiB/s
[   58.636805] mtd_speedtest: testing 2 page write speed
[   61.612427] mtd_speedtest: 2 page write speed is 2757 KiB/s
[   61.618021] mtd_speedtest: testing 2 page read speed
[   62.672653] mtd_speedtest: 2 page read speed is 7804 KiB/s
[   62.678159] mtd_speedtest: Testing erase speed
[   62.903617] mtd_speedtest: erase speed is 37063 KiB/s
[   62.908678] mtd_speedtest: Testing 2x multi-block erase speed
[   63.134083] mtd_speedtest: 2x multi-block erase speed is 37292 KiB/s
[   63.140442] mtd_speedtest: Testing 4x multi-block erase speed
[   63.364262] mtd_speedtest: 4x multi-block erase speed is 37566 KiB/s
[   63.370632] mtd_speedtest: Testing 8x multi-block erase speed
[   63.595740] mtd_speedtest: 8x multi-block erase speed is 37344 KiB/s
[   63.602089] mtd_speedtest: Testing 16x multi-block erase speed
[   63.827426] mtd_speedtest: 16x multi-block erase speed is 37320 KiB/s
[   63.833860] mtd_speedtest: Testing 32x multi-block erase speed
[   64.059389] mtd_speedtest: 32x multi-block erase speed is 37288 KiB/s
[   64.065833] mtd_speedtest: Testing 64x multi-block erase speed
[   64.290609] mtd_speedtest: 64x multi-block erase speed is 37415 KiB/s
[   64.297063] mtd_speedtest: finished
[   64.300555] =================================================

Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v3:
- repost patch 4/4 reporting proper error code in airoha_snand_dirmap_read
  and airoha_snand_dirmap_write if dma_map_single fails.
- Link to v2: https://lore.kernel.org/r/20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org

Changes in v2:
- repost patch 3/4 and 4/4 improving commit log
- Link to v1: https://lore.kernel.org/r/20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org
---
 drivers/spi/spi-airoha-snfi.c | 154 +++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 83 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 94458df53eae..ec7a71b347df 100644
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
 
@@ -662,14 +656,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		return err;
 
-	dma_sync_single_for_device(as_ctrl->dev, as_dev->dma_addr,
-				   as_dev->buf_len, DMA_BIDIRECTIONAL);
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_FROM_DEVICE);
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		return err;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
-			   as_dev->dma_addr);
+			   dma_addr);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	/* set cust sec size */
 	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
@@ -678,58 +675,58 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
@@ -739,35 +736,41 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
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
 
@@ -776,19 +779,20 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		return err;
 
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
@@ -797,9 +801,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		wr_mode = 0;
 
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
-			   as_dev->dma_addr);
+			   dma_addr);
 	if (err)
-		return err;
+		goto error_dma_unmap;
 
 	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM,
 			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
@@ -807,65 +811,65 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -875,13 +879,20 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
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
@@ -956,42 +967,20 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
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
@@ -1093,7 +1082,6 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-	ctrl->cleanup = airoha_snand_cleanup;
 	device_set_node(&ctrl->dev, dev_fwnode(dev));
 
 	err = airoha_snand_nfi_setup(as_ctrl);

---
base-commit: 55f79eb7b89e12d795cdee4b73e63ddf91f63592
change-id: 20240913-airoha-spi-fixes-56bb430fb99f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


