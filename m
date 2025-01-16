Return-Path: <linux-spi+bounces-6372-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D2A144AA
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D813A9CF2
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245CF241A0B;
	Thu, 16 Jan 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E3m2SaJh"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66C23F27D
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067327; cv=none; b=RsLvUca8grHeQj83vqnl62BxZTmpHvtajpNgI8Vfw7YcHvnpY9RXKikVJbrPkcXT5X3fgxOMPv+mNTFpz7ovrchZLtdd44fnaQGrHTVUbnn5Yv80wgg2bCwS3vPqFGB7954kbpN3/v2FpJIQT40+lavjcX4WqzSxRUw628iWcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067327; c=relaxed/simple;
	bh=GParvZMxicrgKugmo7RTNnKjduftg+maWHqcb4yjK8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDM6RjS4hxMe6MMCi2FcZoJRpauhLVhuY8KFN5YgRXO4nCwMEnTkQPTbs94Kjc9/yvpYEChX7zRP+qT2eDADbNGVGc8vo0NugC5MJESM0fZMWnOZBTW2mnr8Gnsqju96m6YqA0t5e21Wqch2ef5Fq/BN4A3pbrLDejNKtFhFkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E3m2SaJh; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737067322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkN93+yrdYBKl9xNfe45DamaUFWg9UXT6+TMNaEpy3s=;
	b=E3m2SaJhGMjqIJ6YCBPI+okrl46/kRMWEsArLRQR/WPgQsimn5anLiRebH/PpuBv4jcj1F
	MJmswt+Iwkhf3ml4X6QzCmhCPkN4vPnTTQkbK44lhpM5vnO1okBfoTQmw1As2Im3nHzZEd
	N+Xs/b87Xy99V89smS/j2jewSBSi6eM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/5] spi: zynqmp-gqspi: Add helpers for enabling/disabling DMA
Date: Thu, 16 Jan 2025 17:41:28 -0500
Message-Id: <20250116224130.2684544-4-sean.anderson@linux.dev>
In-Reply-To: <20250116224130.2684544-1-sean.anderson@linux.dev>
References: <20250116224130.2684544-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

DMA is enabled and disabled several times in the driver. Add some
helper functions for this task.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 61 +++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 79dd1d56d05c..d18fa1282dde 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -739,6 +739,33 @@ static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
 	}
 }
 
+/**
+ * zynqmp_qspi_disable_dma() - Disable DMA mode
+ * @xqspi: GQSPI instance
+ */
+static void zynqmp_qspi_disable_dma(struct zynqmp_qspi *xqspi)
+{
+	u32 config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+
+	config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
+	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+	xqspi->mode = GQSPI_MODE_IO;
+}
+
+/**
+ * zynqmp_qspi_enable_dma() - Enable DMA mode
+ * @xqspi: GQSPI instance
+ */
+static void zynqmp_qspi_enable_dma(struct zynqmp_qspi *xqspi)
+{
+	u32 config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
+
+	config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
+	config_reg |= GQSPI_CFG_MODE_EN_DMA_MASK;
+	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+	xqspi->mode = GQSPI_MODE_DMA;
+}
+
 /**
  * zynqmp_process_dma_irq - Handler for DMA done interrupt of QSPI
  *				controller
@@ -748,7 +775,7 @@ static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
  */
 static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 {
-	u32 config_reg, genfifoentry;
+	u32 genfifoentry;
 
 	dma_unmap_single(xqspi->dev, xqspi->dma_addr,
 			 xqspi->dma_rx_bytes, DMA_FROM_DEVICE);
@@ -762,9 +789,7 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 
 	if (xqspi->bytes_to_receive > 0) {
 		/* Switch to IO mode,for remaining bytes to receive */
-		config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
-		config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
-		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
+		zynqmp_qspi_disable_dma(xqspi);
 
 		/* Initiate the transfer of remaining bytes */
 		genfifoentry = xqspi->genfifoentry;
@@ -849,17 +874,14 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
  */
 static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 {
-	u32 rx_bytes, rx_rem, config_reg;
+	u32 rx_bytes, rx_rem;
 	dma_addr_t addr;
 	u64 dma_align =  (u64)(uintptr_t)xqspi->rxbuf;
 
 	if (xqspi->bytes_to_receive < 8 ||
 	    ((dma_align & GQSPI_DMA_UNALIGN) != 0x0)) {
 		/* Setting to IO mode */
-		config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
-		config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
-		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
-		xqspi->mode = GQSPI_MODE_IO;
+		zynqmp_qspi_disable_dma(xqspi);
 		xqspi->dma_rx_bytes = 0;
 		return 0;
 	}
@@ -882,14 +904,7 @@ static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_ADDR_MSB_OFST,
 			   ((u32)addr) & 0xfff);
 
-	/* Enabling the DMA mode */
-	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
-	config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
-	config_reg |= GQSPI_CFG_MODE_EN_DMA_MASK;
-	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST, config_reg);
-
-	/* Switch to DMA mode */
-	xqspi->mode = GQSPI_MODE_DMA;
+	zynqmp_qspi_enable_dma(xqspi);
 
 	/* Write the number of bytes to transfer */
 	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_SIZE_OFST, rx_bytes);
@@ -909,18 +924,10 @@ static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
 static void zynqmp_qspi_write_op(struct zynqmp_qspi *xqspi, u8 tx_nbits,
 				 u32 genfifoentry)
 {
-	u32 config_reg;
-
 	zynqmp_qspi_fillgenfifo(xqspi, tx_nbits, genfifoentry);
 	zynqmp_qspi_filltxfifo(xqspi, GQSPI_TXD_DEPTH);
-	if (xqspi->mode == GQSPI_MODE_DMA) {
-		config_reg = zynqmp_gqspi_read(xqspi,
-					       GQSPI_CONFIG_OFST);
-		config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
-		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
-				   config_reg);
-		xqspi->mode = GQSPI_MODE_IO;
-	}
+	if (xqspi->mode == GQSPI_MODE_DMA)
+		zynqmp_qspi_disable_dma(xqspi);
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


