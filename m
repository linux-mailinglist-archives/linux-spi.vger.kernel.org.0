Return-Path: <linux-spi+bounces-7915-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCF4AAB4A8
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 07:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92208467EC5
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212454801F0;
	Tue,  6 May 2025 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJYzoq0w"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A22F22EB;
	Mon,  5 May 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486791; cv=none; b=IgwlS7/tyh2ofBD5y0Mg4g2l7ufYPjXa3HtUUkALqY5Z8xLzTydYAkMg274MFd14ka//SW1ZLtAKHyTG0tTyO0/Hg1ALhi25HzmMQ+rAbM6CXmw3iLiYjftTHs4KS4iZH2WA8oVIMHn4RBlFN/yZnHqDbDnKlly0EdTGwwvfqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486791; c=relaxed/simple;
	bh=YPrXTFG2lpUg6wiT2rhW35aIaDIxdm64SvVqNrB7gVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4u9lNOwDiqYYjYqyWCaM1ew1+eJOCQV5ag6pN0C5dlOp9Iuc2/Ap2WGyE15fcH7bLi0edmcLK75aLxULVHeOAvJxpWCFMLSJl3JJ/A+KJisKBX0EVg+b8QSHzMikDC//V5Pqb9zv49wckxNKFaEh2tz8B/QXsTZRcpRzLTsotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJYzoq0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F82BC4CEEF;
	Mon,  5 May 2025 23:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486791;
	bh=YPrXTFG2lpUg6wiT2rhW35aIaDIxdm64SvVqNrB7gVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJYzoq0wiLpYppgTzKuMZ++5i+Qc7bY62tDIsLUqhjlBLBRs/QOrS7XcE5N9Q1mcM
	 /lCEijdFBXhyyAu5SQ8msFFj3bBFVWPeq79GNSt+TdMBFanMAk5jcrnHq5SRWiI+Ne
	 kSLftAw2v8WzXkyk2oo0BB0s16mHsYOtRrE700h8JiRzV6aTjxN/2E2Prb0No3lr42
	 osGkgCfXF5ce0voXTqoWBGC/VuE6hrltoTYvleSspTQ753QrLtD3dq+RKwmseoXRIx
	 vLXlI72hEE1g9iHuw1do0rmDFeR/3D/w1+/4bRpP1fwVmg7LJ4InFI1GgLMIVO12Ql
	 2eZF8uUPp6/Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	michal.simek@amd.com,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 207/212] spi: zynqmp-gqspi: Always acknowledge interrupts
Date: Mon,  5 May 2025 19:06:19 -0400
Message-Id: <20250505230624.2692522-207-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit 89785306453ce6d949e783f6936821a0b7649ee2 ]

RXEMPTY can cause an IRQ, even though we may not do anything about it
(such as if we are waiting for more received data). We must still handle
these IRQs because we can tell they were caused by the device.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Link: https://patch.msgid.link/20250116224130.2684544-6-sean.anderson@linux.dev
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c89544ae5ed91..fde7c38103596 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -698,7 +698,6 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 {
 	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_id;
-	irqreturn_t ret = IRQ_NONE;
 	u32 status, mask, dma_status = 0;
 
 	status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
@@ -713,27 +712,24 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
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
2.39.5


