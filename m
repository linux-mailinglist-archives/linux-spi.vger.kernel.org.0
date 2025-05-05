Return-Path: <linux-spi+bounces-7911-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E6AAAD6B
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 04:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F8F7B630E
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 02:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8428399ED5;
	Mon,  5 May 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLZqf+49"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD23B8151;
	Mon,  5 May 2025 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487306; cv=none; b=lx2/ZIcB/g0BKTxhNeiu1tV7iuQizthQIFdMWu3ERAwd2jWQLhaB1wTtV/IwHxXYPdCWzFqPkoLVYfexz+0bb+Qlb8i1tkuYgaw0fx+flPgMF+/QpCJM0RBwXvM9QtDY6wnJvepJssfZq2UcX9Dg3AET/1AZBX1YG/JNB7WSVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487306; c=relaxed/simple;
	bh=YL/6gS3ufwCvufLSwSN11e8t9tnMrA7loUadZRkixVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEXSyvTON+6APkriQA3JSTpHhKrhsIvGQyEHi5yZOGBoxUw2Gt5RYp0+nqqvS5xxR3Je3iBJrIg0QXmbAO/w+BW31X4o/Y+SIRsP0kjDALuRdVKzYuEH1mXApKdMvOo8HYL4FqJLpLtT0rbj8ziE7ObFRhOUwIHkP3WSu76tJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLZqf+49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D08C4CEE4;
	Mon,  5 May 2025 23:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487305;
	bh=YL/6gS3ufwCvufLSwSN11e8t9tnMrA7loUadZRkixVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLZqf+49WS7Zlq3uWCmT8Qb2nkp2O83zwCqeLumnTiKf2LjdczwBUudFD90d9hE76
	 gqtj3pdPIv5aVM6XPgUd1WQC1QEAaTa5rOzbuq+XhKq0Ckl033UkirzYRT7LiVNhfz
	 eU2852jmclF8yzvMePoFsmIT4e5knC+fuRuNnurGVBvm5hh44ByHiK9IT3AkbTHvoD
	 hduUaAdZiZdUzEvCN6/CcB02OtuMIcTglN1bl/Hy9SuXBEDF7IQiqFtLTnj+aYml5P
	 zJTu6npFQAU2eLDAuYK7Q3CdQczCyrM5ccQHnCSkZaWPN9GEvqu3x2MXoFbGSc6gkd
	 S10T83+Ms04Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	michal.simek@amd.com,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 111/114] spi: zynqmp-gqspi: Always acknowledge interrupts
Date: Mon,  5 May 2025 19:18:14 -0400
Message-Id: <20250505231817.2697367-111-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 3d3ac48243ebd..408b83882dae2 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -689,7 +689,6 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 {
 	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_id;
-	irqreturn_t ret = IRQ_NONE;
 	u32 status, mask, dma_status = 0;
 
 	status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
@@ -704,27 +703,24 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
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


