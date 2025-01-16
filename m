Return-Path: <linux-spi+bounces-6373-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF49AA144AB
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D4D1882F09
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24DC241696;
	Thu, 16 Jan 2025 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dmZcMHzR"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3223241A16
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067329; cv=none; b=L/PWeOIfSTPNv9PHJynbnW1ZjJCvOZrLMYkL2Z4ppHFJUuFZBAMyuaavOl3BukU2B0Ydj0mpvMFdEoeIFI2yuAUqDVUd0Izo6+lojmlhnYFE5KjWspuPrrUmNVBy7lx0NjB3I50PN5SoEXeQUR/G+270RxNWUKxpA0YHMWKJmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067329; c=relaxed/simple;
	bh=qsoPvRkO2rVX1jEwYM3wluwRZiRheS+wU+pC2PRFS1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5kBclnDryHNGbGrE9bPloD8TuAMinZ05BH9mpeR60abX0q5jLu6oitOQyyxxlq2q97ulgTZOxltVxryEhniFlsQlButP9CeEZRpw51zOtRnRQBRX5/jIe1r1jWqhSAnlkUFAx1aAtCDQnr8craqbhrhd2ZdjLbWBArQJy/yeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dmZcMHzR; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737067325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQgA5NAVbBZn+dpRPKigk0QwJP0EjS+ozP2A1SsiBr0=;
	b=dmZcMHzRlmVGvIDLPN99ildKd0ppwFZRNrEvwZj+tEPI12wPG1MZSUK60rb+dFaLEkRTLi
	wkqjiZHpieYKwd0zxwzQSJRaw4jT1DuUaEjM+lOta6SnMDIMFRgZqBDgelTrOQpq7JRSm8
	BRYSeFdO1r9gvtwkyCBofLgtlnH+pn4=
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
Subject: [PATCH 4/5] spi: zynqmp-gqspi: Clean up fillgenfifo
Date: Thu, 16 Jan 2025 17:41:29 -0500
Message-Id: <20250116224130.2684544-5-sean.anderson@linux.dev>
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

This function does a lot more work (assigning things multiple times,
masking unnecessarily, comparing to zero, using superfluous parentheses)
than it needs to. This makes it difficult to understand and modify.
Clean it up. No functional change intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 78 ++++++++++++----------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index d18fa1282dde..b47973db3490 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -82,7 +82,6 @@
 #define GQSPI_GENFIFO_RX			0x00020000
 #define GQSPI_GENFIFO_STRIPE			0x00040000
 #define GQSPI_GENFIFO_POLL			0x00080000
-#define GQSPI_GENFIFO_EXP_START			0x00000100
 #define GQSPI_FIFO_CTRL_RST_RX_FIFO_MASK	0x00000004
 #define GQSPI_FIFO_CTRL_RST_TX_FIFO_MASK	0x00000002
 #define GQSPI_FIFO_CTRL_RST_GEN_FIFO_MASK	0x00000001
@@ -672,71 +671,50 @@ static void zynqmp_qspi_readrxfifo(struct zynqmp_qspi *xqspi, u32 size)
 static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
 				    u32 genfifoentry)
 {
-	u32 transfer_len = 0;
+	u32 transfer_len, tempcount, exponent;
+	u8 imm_data;
 
-	if (xqspi->txbuf) {
-		genfifoentry &= ~GQSPI_GENFIFO_RX;
-		genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
-		genfifoentry |= GQSPI_GENFIFO_TX;
-		transfer_len = xqspi->bytes_to_transfer;
-	} else if (xqspi->rxbuf) {
-		genfifoentry &= ~GQSPI_GENFIFO_TX;
-		genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
+	genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
+	if (xqspi->rxbuf) {
 		genfifoentry |= GQSPI_GENFIFO_RX;
 		if (xqspi->mode == GQSPI_MODE_DMA)
 			transfer_len = xqspi->dma_rx_bytes;
 		else
 			transfer_len = xqspi->bytes_to_receive;
 	} else {
-		/* Sending dummy circles here */
-		genfifoentry &= ~(GQSPI_GENFIFO_TX | GQSPI_GENFIFO_RX);
-		genfifoentry |= GQSPI_GENFIFO_DATA_XFER;
 		transfer_len = xqspi->bytes_to_transfer;
 	}
+
+	if (xqspi->txbuf)
+		genfifoentry |= GQSPI_GENFIFO_TX;
+
 	genfifoentry |= zynqmp_qspi_selectspimode(xqspi, nbits);
 	xqspi->genfifoentry = genfifoentry;
 	dev_dbg(xqspi->dev, "genfifo %05x transfer_len %u\n",
 		genfifoentry, transfer_len);
 
-	if ((transfer_len) < GQSPI_GENFIFO_IMM_DATA_MASK) {
-		genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
-		genfifoentry |= transfer_len;
-		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
-	} else {
-		int tempcount = transfer_len;
-		u32 exponent = 8;	/* 2^8 = 256 */
-		u8 imm_data = tempcount & 0xFF;
-
-		tempcount &= ~(tempcount & 0xFF);
-		/* Immediate entry */
-		if (tempcount != 0) {
-			/* Exponent entries */
-			genfifoentry |= GQSPI_GENFIFO_EXP;
-			while (tempcount != 0) {
-				if (tempcount & GQSPI_GENFIFO_EXP_START) {
-					genfifoentry &=
-						~GQSPI_GENFIFO_IMM_DATA_MASK;
-					genfifoentry |= exponent;
-					zynqmp_gqspi_write(xqspi,
-							   GQSPI_GEN_FIFO_OFST,
-							   genfifoentry);
-				}
-				tempcount = tempcount >> 1;
-				exponent++;
-			}
-		}
-		if (imm_data != 0) {
-			genfifoentry &= ~GQSPI_GENFIFO_EXP;
-			genfifoentry &= ~GQSPI_GENFIFO_IMM_DATA_MASK;
-			genfifoentry |= (u8)(imm_data & 0xFF);
+	/* Exponent entries */
+	imm_data = transfer_len;
+	tempcount = transfer_len >> 8;
+	exponent = 8;
+	genfifoentry |= GQSPI_GENFIFO_EXP;
+	while (tempcount) {
+		if (tempcount & 1)
 			zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST,
-					   genfifoentry);
-		}
-	}
-	if (xqspi->mode == GQSPI_MODE_IO && xqspi->rxbuf) {
-		/* Dummy generic FIFO entry */
-		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
+					   genfifoentry | exponent);
+		tempcount >>= 1;
+		exponent++;
 	}
+
+	/* Immediate entry */
+	genfifoentry &= ~GQSPI_GENFIFO_EXP;
+	if (imm_data)
+		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST,
+				   genfifoentry | imm_data);
+
+	/* Dummy generic FIFO entry */
+	if (xqspi->mode == GQSPI_MODE_IO && xqspi->rxbuf)
+		zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0);
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


