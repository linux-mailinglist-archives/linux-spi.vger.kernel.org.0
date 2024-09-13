Return-Path: <linux-spi+bounces-4814-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE29978A70
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 23:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA983281371
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14991474B2;
	Fri, 13 Sep 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS+XAp+3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD3126C01
	for <linux-spi@vger.kernel.org>; Fri, 13 Sep 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261663; cv=none; b=ALeqDTUl16/dKzlN2wbv9f71UkVh/HKtIRLe3jxx80hXnbQ0Ge5dZwqOQwaeYUWhLFEPGHj7lwujLbNvP29/ECEhS7MyjQyEriX+y2TLpmDu9I6AxTQVpxSdig6xU36VqGBZY9FyHeGotcyiOUrPhXbFEQxUM+x0Pev6hl9NpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261663; c=relaxed/simple;
	bh=sVwfHoXKnb1nvxGo5YmthEsmu41bkHDt+t3Z3PhqUGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ij/kveZH5BvkY7QnrLDXIy8g99ltkjRHWjSciU8LVqaVfGW+7pNzxNpEKYgUfwXBdss1rLFCsOzCYb4fINgEgzjodaRx3zKP7Sh5m4KGKox4dv2GRYlYebWu3fD0TXYw68SqlZJU3KH0PoQZPrPjtSEZ4VcRwwRDK1IB0/Ik7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS+XAp+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B147C4CEC0;
	Fri, 13 Sep 2024 21:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726261663;
	bh=sVwfHoXKnb1nvxGo5YmthEsmu41bkHDt+t3Z3PhqUGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JS+XAp+31Rumk0g/OvmlItf9smz0FHGU4JFHhh1P3nu+vUE6acVYjApB7WR/jbHpx
	 m8ztuNp8mOBCVKZqFnJaY35+52V+AJix8fqYKNXD5DVkXxhdTmpE2GLpkirht1tWMC
	 i9bUmUu65YR94wp6E6w0tckMccPCx/q7lnAjZHbuOeHbj9mSYZO4d1iU+LFRgxkljq
	 oQDcAFMyxCUyDp93+PFB8BuXNWmJpB5T5lHV8o7nJOwNgvs4oehguHGopF5frj6yy9
	 lG+TyBaRoAGf990xFbLJts7GDHimhqpsEPlkXWPqavUuMrgPI8/Q8zW1Sf36aBiaCj
	 e+ab6yRQ9W9Cw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 13 Sep 2024 23:07:15 +0200
Subject: [PATCH 3/4] spi: airoha: remove read cache in
 airoha_snand_dirmap_read
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-airoha-spi-fixes-v1-3-de2e74ed4664@kernel.org>
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

Get rid of read cache in airoha_snand_dirmap_read routine since it
introduces errors in mtd_oobtest kernel module test and it does not
add any performance improvements in mtd_speedtest kernel module test.

Fixes: a403997c1201 ("spi: airoha: add SPI-NAND Flash controller driver")
Tested-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index c71be702cf6f..94458df53eae 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -211,9 +211,6 @@ struct airoha_snand_dev {
 
 	u8 *txrx_buf;
 	dma_addr_t dma_addr;
-
-	u64 cur_page_num;
-	bool data_need_update;
 };
 
 struct airoha_snand_ctrl {
@@ -644,11 +641,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 val, rd_mode;
 	int err;
 
-	if (!as_dev->data_need_update)
-		return len;
-
-	as_dev->data_need_update = false;
-
 	switch (op->cmd.opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
 		rd_mode = 1;
@@ -895,23 +887,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	struct airoha_snand_dev *as_dev = spi_get_ctldata(mem->spi);
 	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
-	if (opcode == SPI_NAND_OP_PROGRAM_EXECUTE &&
-	    op->addr.val == as_dev->cur_page_num) {
-		as_dev->data_need_update = true;
-	} else if (opcode == SPI_NAND_OP_PAGE_READ) {
-		if (!as_dev->data_need_update &&
-		    op->addr.val == as_dev->cur_page_num)
-			return 0;
-
-		as_dev->data_need_update = true;
-		as_dev->cur_page_num = op->addr.val;
-	}
 
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
@@ -996,7 +976,6 @@ static int airoha_snand_setup(struct spi_device *spi)
 	if (dma_mapping_error(as_ctrl->dev, as_dev->dma_addr))
 		return -ENOMEM;
 
-	as_dev->data_need_update = true;
 	spi_set_ctldata(spi, as_dev);
 
 	return 0;

-- 
2.46.0


