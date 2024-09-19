Return-Path: <linux-spi+bounces-4889-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B37997CCC3
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C87E1C21BF1
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8221A0AFB;
	Thu, 19 Sep 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsJcEAC6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7B1A0AF8
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765074; cv=none; b=CpDdIPteXYltBjnVU0MGVx58fsPAV0fzmXnsu7ya9+aa4IAs6M8FTd2kUcytlnwuew4lpkppekYg9K+pnkeFWEJUj1qnH9n7wtAPD+Qg24UEpM7t0cbFEZGVZcatKozIV0mlITqHD3CLbzy0lxcvxubE7NzFcZbYjyZyeO8WfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765074; c=relaxed/simple;
	bh=kGoSKIqDQR1llo8wd2zXUAWGdM5EmJJ6KMQxvrwbOV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYQSA92RdUrzctutCowy/Jz6K7GUrVzkrqSSpbDATR+5U9LFX61ZVoyDI3pxd9uhdwocFRVAMDqIpv27GLf3YqZ9v8wdv25JoKAMvF4aLoX8VvPHGg8L9SGpPx13Sc0H4qKh+1T/dHqmIh44cC07KqZ4xHbakK1osxVF92QWR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsJcEAC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7327C4CEC4;
	Thu, 19 Sep 2024 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765074;
	bh=kGoSKIqDQR1llo8wd2zXUAWGdM5EmJJ6KMQxvrwbOV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JsJcEAC6gRC234f5VYZODmJsUfcVN1gbPMz8FcP7S5E+E/cwuv1xFh7AL+HjsmmES
	 g4gllLnojFOeFaN5muIt2taZhaOjhhchTYgJpiDj8qtTTtd/+kxnXugwZTSbaJ9CXx
	 5prcpaMIeWpwDcaz8o2djuKnyujbfBeSze7GjGwuQew5AwQXMIj2nAAaF3G0ElXqNV
	 EmlSZw6UCwJlOfr4kAWEN0SOvbt1rUeViCImWqFhTCAo8Cs4/HtyqcuvwReU81uj99
	 k4CPm21vMl9tEahMeF7881eKJ0lrnvN1IY8Pcbga32hwYLmXlye3xiosVzVB2QJdmB
	 SZv9ouU2YGhiA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 19 Sep 2024 18:57:16 +0200
Subject: [PATCH v2 1/2] spi: airoha: remove read cache in
 airoha_snand_dirmap_read()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-airoha-spi-fixes-v2-1-cb0f0ed9920a@kernel.org>
References: <20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org>
In-Reply-To: <20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Mark Brown <broonie@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.1

Current upstream driver reports errors running mtd_oobtest kernel module
test:

root@OpenWrt:/# insmod mtd_test.ko
root@OpenWrt:/# insmod mtd_oobtest.ko dev=5
[ 7023.730584] =================================================
[ 7023.736399] mtd_oobtest: MTD device: 5
[ 7023.740160] mtd_oobtest: MTD device size 3670016, eraseblock size 131072, page size 2048, count of eraseblocks 28, pages per eraseblock 64, OOB size 128
[ 7023.753837] mtd_test: scanning for bad eraseblocks
[ 7023.758636] mtd_test: scanned 28 eraseblocks, 0 are bad
[ 7023.763861] mtd_oobtest: test 1 of 5
[ 7024.042076] mtd_oobtest: writing OOBs of whole device
[ 7024.682069] mtd_oobtest: written up to eraseblock 0
[ 7041.962077] mtd_oobtest: written 28 eraseblocks
[ 7041.966626] mtd_oobtest: verifying all eraseblocks
[ 7041.972276] mtd_oobtest: error @addr[0x0:0x0] 0xff -> 0xe diff 0xf1
[ 7041.978550] mtd_oobtest: error @addr[0x0:0x1] 0xff -> 0x10 diff 0xef
[ 7041.984932] mtd_oobtest: error @addr[0x0:0x2] 0xff -> 0x82 diff 0x7d
[ 7041.991293] mtd_oobtest: error @addr[0x0:0x3] 0xff -> 0x10 diff 0xef
[ 7041.997659] mtd_oobtest: error @addr[0x0:0x4] 0xff -> 0x0 diff 0xff
[ 7042.003942] mtd_oobtest: error @addr[0x0:0x5] 0xff -> 0x8a diff 0x75
[ 7042.010294] mtd_oobtest: error @addr[0x0:0x6] 0xff -> 0x20 diff 0xdf
[ 7042.016659] mtd_oobtest: error @addr[0x0:0x7] 0xff -> 0x1 diff 0xfe
[ 7042.022935] mtd_oobtest: error @addr[0x0:0x8] 0xff -> 0x2e diff 0xd1
[ 7042.029295] mtd_oobtest: error @addr[0x0:0x9] 0xff -> 0x40 diff 0xbf
[ 7042.035661] mtd_oobtest: error @addr[0x0:0xa] 0xff -> 0x0 diff 0xff
[ 7042.041935] mtd_oobtest: error @addr[0x0:0xb] 0xff -> 0x89 diff 0x76
[ 7042.048300] mtd_oobtest: error @addr[0x0:0xc] 0xff -> 0x82 diff 0x7d
[ 7042.054662] mtd_oobtest: error @addr[0x0:0xd] 0xff -> 0x15 diff 0xea
[ 7042.061014] mtd_oobtest: error @addr[0x0:0xe] 0xff -> 0x90 diff 0x6f
[ 7042.067380] mtd_oobtest: error @addr[0x0:0xf] 0xff -> 0x0 diff 0xff
....
[ 7432.421369] mtd_oobtest: error @addr[0x237800:0x36] 0xff -> 0x5f diff 0xa0
[ 7432.428242] mtd_oobtest: error @addr[0x237800:0x37] 0xff -> 0x21 diff 0xde
[ 7432.435118] mtd_oobtest: error: verify failed at 0x237800
[ 7432.440510] mtd_oobtest: error: too many errors
[ 7432.445053] mtd_oobtest: error -1 occurred

The above errors are due to the buggy logic in the 'read cache' available
in airoha_snand_dirmap_read() routine since there are some corner cases
where we are missing data updates. Since we do not get any read/write speed
improvement using the cache (according to the mtd_speedtest kernel
module test), in order to fix the mtd_oobtest test, remove the 'read cache'
in airoha_snand_dirmap_read routine. Now the driver is passing all the
tests available in mtd_test suite.

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
2.46.1


