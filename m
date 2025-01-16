Return-Path: <linux-spi+bounces-6374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF900A144AF
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F52188A96E
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0F524385A;
	Thu, 16 Jan 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fg67W6jS"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607C22FDEE
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737067332; cv=none; b=qc17I+tqoNCgN3oCGvVkYAFGwVrPzPS5zDmbfQH0crJlHaAxzlxNikwjxQg40wAO/9B2ePRAgXbtBBVKDGrsxqz1xoZRaHDsxQzLu6l1mnTwWVMH0Z2O+cudRc1njQQk6XFr6evTEz1N4Hum7FovSLQmhV7JLNT+HdyTQCE6zcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737067332; c=relaxed/simple;
	bh=EweIiN7hHE7Q2jxJEayTj3HnY7p8iKMBIHUJH68RwLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oz6UrdIVf3OvpESwJEcuT1gejrVt/fpUlHuYi+3k0c8VICvvsvUyDt5lvE4rwiQsxqxFpxvCe0WJs8og/2iAIEkh51mjrUBQNof/DnXtwNRZkPKg8QeE1caBnXGUaQgsblupEW7VEISVCbxGovgJRGu5qpjUE6orhh/4TIpXr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fg67W6jS; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737067327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlTb2O1hLU6DYNNrLELtnaMOI/5Cc65WWWQk0wpeFeI=;
	b=Fg67W6jSBcmfvR3rwz2uM3tN9YrtkXiiLEHBp+JI0ZqkSfPLGGlnh1PDvLjl2bhAdoqhvk
	ICkiuFCMxbUEQNlspNiDmvjJAmYXDTTidiMfqRY7LCZe0QhFrZGNAt94is76NlE9zPEmn7
	GmodxdW40t5/JwrRlrHyYBrGoyWYL2o=
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
Subject: [PATCH 5/5] spi: zynqmp-gqspi: Always acknowledge interrupts
Date: Thu, 16 Jan 2025 17:41:30 -0500
Message-Id: <20250116224130.2684544-6-sean.anderson@linux.dev>
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

RXEMPTY can cause an IRQ, even though we may not do anything about it
(such as if we are waiting for more received data). We must still handle
these IRQs because we can tell they were caused by the device.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/spi/spi-zynqmp-gqspi.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index b47973db3490..339639904a7f 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -806,7 +806,6 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 {
 	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_id;
-	irqreturn_t ret = IRQ_NONE;
 	u32 status, mask, dma_status = 0;
 
 	status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
@@ -821,27 +820,24 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 				   dma_status);
 	}
 
-	if (mask & GQSPI_ISR_TXNOT_FULL_MASK) {
+	if (!mask && !dma_status)
+		return IRQ_NONE;
+
+	if (mask & GQSPI_ISR_TXNOT_FULL_MASK)
 		zynqmp_qspi_filltxfifo(xqspi, GQSPI_TX_FIFO_FILL);
-		ret = IRQ_HANDLED;
-	}
 
-	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK) {
+	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK)
 		zynqmp_process_dma_irq(xqspi);
-		ret = IRQ_HANDLED;
-	} else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
-			(mask & GQSPI_IER_GENFIFOEMPTY_MASK)) {
+	else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
+			(mask & GQSPI_IER_GENFIFOEMPTY_MASK))
 		zynqmp_qspi_readrxfifo(xqspi, GQSPI_RX_FIFO_FILL);
-		ret = IRQ_HANDLED;
-	}
 
 	if (xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
 	    ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
 		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
 		complete(&xqspi->data_completion);
-		ret = IRQ_HANDLED;
 	}
-	return ret;
+	return IRQ_HANDLED;
 }
 
 /**
-- 
2.35.1.1320.gc452695387.dirty


