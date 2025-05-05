Return-Path: <linux-spi+bounces-7913-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5856AAB6A5
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 07:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C993ABC55
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 05:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FEE429551;
	Tue,  6 May 2025 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXHqAdUv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E727876A;
	Mon,  5 May 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485754; cv=none; b=mzUhMa2nVtNQj/GWeSmkMug3HkIdEkBzm591T2vgGuLP6zAh71IoXatK7coUkhGMSTTou86z2dHh3ZQwaZ9fgpHU/UiP5HTYJPeiS5mRnNSq2MEpmRHBrcbfeb6Smz6u5IYLNAjQVxR1qp4Ovd5GgkviO2NnrECmoM0nuFAZtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485754; c=relaxed/simple;
	bh=o4+uztkPQXenoWSyVjeVRZRqnUM8k5WafB0IE+JZD7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vw0otwGAyscEvXG1Eavqe987VJxp9FPXfx+UIjj7WAjPmIIUaYowPRyABsk2p3AMtoCR35F7wAHSGnTzdj/FuAYSQZpOsQnL9+0yGgrUMslvhY0qXbA0HD2m+xbL++jGcwxBtvZ6URjwDw8xoLBrxnRLuubaZulSIKa0CLjQ1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXHqAdUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45322C4CEE4;
	Mon,  5 May 2025 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485754;
	bh=o4+uztkPQXenoWSyVjeVRZRqnUM8k5WafB0IE+JZD7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXHqAdUv03rDaifF5dY6Z2ABl76wuWQiaaIMeDn8n9bijGUuIHUeYaofZ7sV7GEsQ
	 +nlS6lXmwk36d0du7nWIc2iIktCDgcZWubU8Dj1sY8ctnD+6dZ3NU59+QDWGXsX3No
	 BJtZEkKdkcVF3+vAPq45q/QDoe5eF8VTAKSyuJUsxcgqukoI1XcGyt7Cz3JiXgWUwE
	 hTwAlt9dWcezyNUI5wNQJU+sB+YaeFCC67nEYKG3xNNLVkWn0OFImtJt0usV0xKJ6m
	 MSgWzSiwqpWZc61Y3DfwYzk+29700v4hoN7uyortY8NztlLz2nP3cPIyVbfClA0s+8
	 BqPmuxSYcyiTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	michal.simek@amd.com,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 465/486] spi: zynqmp-gqspi: Always acknowledge interrupts
Date: Mon,  5 May 2025 18:39:01 -0400
Message-Id: <20250505223922.2682012-465-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index b9df39e06e7cd..4b091b4d4ff37 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -799,7 +799,6 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 {
 	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_id;
-	irqreturn_t ret = IRQ_NONE;
 	u32 status, mask, dma_status = 0;
 
 	status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
@@ -814,27 +813,24 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
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


