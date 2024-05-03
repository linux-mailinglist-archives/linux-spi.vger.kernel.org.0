Return-Path: <linux-spi+bounces-2739-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD598BB165
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098E91C20D56
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F26156241;
	Fri,  3 May 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxnJX/jQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433E155320
	for <linux-spi@vger.kernel.org>; Fri,  3 May 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755825; cv=none; b=FFvd5PmVojy8/WUvdXUK63qWdPT39ZqrJWsb8DGWOfdsUnbekWZTQ8vsKxWTsul9iNTIJwpPAFraEn2+TxN0G2qWc22v7zdxPZT9zlMbE3Dz9H2y77HhfkCqu5UnLriXqs7cYp8EOhDrEXMOU+VtZbbOlu7rY0IiWrwXzkaKIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755825; c=relaxed/simple;
	bh=ebY4raDCgXSCqHp41gpFuMzedeR8oJ9TC1L5bdF4D+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHe+Se6kMMptdWcxkaCoYCFN2+UdBvL0epbvFrEp0lh8taJDuJgteSVt1YeT9wvFT2Ey/jPD9InHEahF0C1tNxmAtz7HBqX0NgAZQrucIBWGLq81gWs1YCWZkmXLpgudqtlSVDQ4judu38qOZFc/k2/f0ZCpiQh6LxlbcpQYt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxnJX/jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39073C116B1;
	Fri,  3 May 2024 17:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714755824;
	bh=ebY4raDCgXSCqHp41gpFuMzedeR8oJ9TC1L5bdF4D+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=pxnJX/jQwnHsK1otuXwC8ozxaflrpYLSnxvGbhCo/A9cYiDTRrgk5KuADScWnv+ZV
	 lzXVgc+z2LC8nLF0B3+qd6abZQobu4aAT/bV/D07fVvapdJj2mgoMVusVo1p67FzIi
	 BVWI+6qSl2OO75O9ic6YCqc+n9zQPUlw19I5PrYA3N/jxor9fKoDsR5iTYAP3zvMtI
	 bkf7zyhK7WsmrmNi9S965g+1aLJKV6VUicnXrpXGyhnHzRX2n4NWisLD0oZOgeonMz
	 feDeMhpuKo3UV1LQ3mRcNNybl2xe1yMQptSfXda3XGy9M8RN5ld1sfVCBr8EYWYlxm
	 whdX6Re0dOhJw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
	andy.shevchenko@gmail.com,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH] spi: airoha: initialize as_ctrl at pointer declaration
Date: Fri,  3 May 2024 19:03:08 +0200
Message-ID: <580665ed95340031d0d42d1a4a16f7fcd5d150d7.1714755642.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces just two cosmetic changes to airoha spi-nand driver:
- move airoha_snand_ids definition after airoha_snand_probe routine
- always initialize airoha_snand_ctrl pointer similar to
  airoha_snand_dev one

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 9d97ec98881c..7fc3be6d4a6a 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -638,9 +638,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
 	struct spi_device *spi = desc->mem->spi;
+	struct airoha_snand_ctrl *as_ctrl = spi_controller_get_devdata(spi->controller);
 	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
 	struct spi_mem_op *op = &desc->info.op_tmpl;
-	struct airoha_snand_ctrl *as_ctrl;
 	u32 val, rd_mode;
 	int err;
 
@@ -661,7 +661,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		break;
 	}
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
 		return err;
@@ -768,13 +767,12 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len, const void *buf)
 {
 	struct spi_device *spi = desc->mem->spi;
+	struct airoha_snand_ctrl *as_ctrl = spi_controller_get_devdata(spi->controller);
 	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
 	struct spi_mem_op *op = &desc->info.op_tmpl;
-	struct airoha_snand_ctrl *as_ctrl;
 	u32 wr_mode, val;
 	int err;
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
 		return err;
@@ -885,12 +883,12 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(mem->spi);
+	struct spi_device *spi = mem->spi;
+	struct airoha_snand_ctrl *as_ctrl = spi_controller_get_devdata(spi->controller);
+	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
 	u8 data[8], cmd, opcode = op->cmd.opcode;
-	struct airoha_snand_ctrl *as_ctrl;
 	int i, err;
 
-	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 	if (opcode == SPI_NAND_OP_PROGRAM_EXECUTE &&
 	    op->addr.val == as_dev->cur_page_num) {
 		as_dev->data_need_update = true;
@@ -965,11 +963,9 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 
 static int airoha_snand_setup(struct spi_device *spi)
 {
-	struct airoha_snand_ctrl *as_ctrl;
+	struct airoha_snand_ctrl *as_ctrl = spi_controller_get_devdata(spi->controller);
 	struct airoha_snand_dev *as_dev;
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
-
 	as_dev = devm_kzalloc(as_ctrl->dev, sizeof(*as_dev), GFP_KERNEL);
 	if (!as_dev)
 		return -ENOMEM;
@@ -994,10 +990,9 @@ static int airoha_snand_setup(struct spi_device *spi)
 
 static void airoha_snand_cleanup(struct spi_device *spi)
 {
+	struct airoha_snand_ctrl *as_ctrl = spi_controller_get_devdata(spi->controller);
 	struct airoha_snand_dev *as_dev = spi_get_ctldata(spi);
-	struct airoha_snand_ctrl *as_ctrl;
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
 	dma_unmap_single(as_ctrl->dev, as_dev->dma_addr,
 			 as_dev->buf_len, DMA_BIDIRECTIONAL);
 	spi_set_ctldata(spi, NULL);
@@ -1049,12 +1044,6 @@ static const struct regmap_config spi_nfi_regmap_config = {
 	.max_register	= REG_SPI_NFI_SNF_NFI_CNFG,
 };
 
-static const struct of_device_id airoha_snand_ids[] = {
-	{ .compatible	= "airoha,en7581-snand" },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, airoha_snand_ids);
-
 static int airoha_snand_probe(struct platform_device *pdev)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1114,6 +1103,12 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	return devm_spi_register_controller(dev, ctrl);
 }
 
+static const struct of_device_id airoha_snand_ids[] = {
+	{ .compatible	= "airoha,en7581-snand" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, airoha_snand_ids);
+
 static struct platform_driver airoha_snand_driver = {
 	.driver = {
 		.name = "airoha-spi",
-- 
2.44.0


