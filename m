Return-Path: <linux-spi+bounces-8494-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04B2AD87D9
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4063AB6B8
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5F92D027F;
	Fri, 13 Jun 2025 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kClpTe2R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF82C159D
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806970; cv=none; b=azrT/OO8wv795qKoqN6VVAmjM0nVFPg/nPcPgwaRWRv+RWyt4kGN14BcuB9/EKZ7odtxJYqqAZLpCYh2dOTatjteXtwFCNVACcnp1cZSbquetwV6CMAK2bSyjXsCCo/9hBgqkoF0sr9ehm0Kl1M1UcSBO9ZO08z50yTCRkUs5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806970; c=relaxed/simple;
	bh=olRfOaHDgzZ8i+4C3kFg3nNnJTByQvbKuBFGHGjLU/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2CL8VCmnLMuWWFwmH00skxe3na7AxkyNXBnp4Vg4+oKD/hnpN62TGfxSjSSUOIFQcXre5CASFisScxf23HdT/D/QnQDWj/+En/Tvj0RbKdvn51Z1h2K2tq5HWEzJXus/Nu0rYavUv4Mews2JdUo+S49wIHxj+NKJua1ZLmUjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kClpTe2R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453398e90e9so1973005e9.1
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749806967; x=1750411767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyHiR7U3e06QyZLuhEr1yr+WmILkiHQ+84NE+rNpfGI=;
        b=kClpTe2Rt8+YTYkvpNpK1xvPRimGIdDtdo+oZuTN9Iw+xKtDNxmjSwlFYTM2sOWPUc
         v5G5G91XehbCbDvd5FkFHvtHXLfzOtfpWZH12nP/qC8apgK7cd3xFc2BxadeLO1BMGm4
         LxGGFcpRRxKYzA/KRdzJa9kwiJORiw48QKVBeUBlvNfLf739qZ81tmdodZ5wAESoucHK
         6XapDMAvYCQ/0giQM/S/nJQ9cIIrOwpnZ1AFY4pcNxZuOLASBva96GfvqywEaN0qL2ow
         5oWeGstQPLhC5dASsk5+YO32u48c7YDLYMSK1S1gnkQJ3KvVpXgSjAarA0zU5AdFd3DS
         xvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806967; x=1750411767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyHiR7U3e06QyZLuhEr1yr+WmILkiHQ+84NE+rNpfGI=;
        b=gnvimg2AtehC9Utuao4bA8MvQP8FVRxvTJtQNBtcz9tH+M7Fs5kZ9OrmOLkOHYgiEz
         yr/sIwoczjVrfC2EEJJHcOlF1GqNb94+FWUWaw5x6md6gWN+BadggdKGSx0ZtJ5bYAX8
         3dUgWSaRbudVLJ0YT5x9n++9/3pzE2I9ZfsIYLkAU5IHl+2C8kR47WXbGWF4aU2r+bk5
         G7x+0uXua0g1ELPCE71UAMOlV1YfraGWG8k4Ptqz6K4KfGho+t2FJd9LHtV+CHQ8ViDI
         kBSAVY6J5y2VxIBsMWmjXNWosuf90YOo1BL/a6lMrqYbwGjeeCxtOjhuLrvhD8TZtN8l
         v8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWZfhxR+OjawxnRHBDulAKYjFqZGbjwk4YjbJXyMnz3hG9H9FFHZzuxP6FrEXkUkZvQKQhJaTnC4H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvD2bVCf4ruMqe9DUYTb1V9q6hwO7YtuVUg0WIioT5iBzENRD
	19+ivMPhJqvn+54vagiAEXoB+ngXa+e6BDKuSt4eHN756QuBPu6Pq5oNW6qJLUcGvJE=
X-Gm-Gg: ASbGnctBKoaQhVtqZxJJParYSS3v3i9i+Oj7nsmZdcAVyarv+1W8BfVU1+F22R+hc8Y
	kCQsywOuo2xBRrDBHoziTC/mqnJoClPy/YCjp7DRqKBPufZxWsXmzFKS1maioHGFwV9TafcO7+w
	1BcfGKCy8ITGhgpg6S+gYAlMtssBDTrDx5IjwQF/+yTfQpHIImHz/rGrh0DcBDAIW/1tmWIxaQo
	G7X/Lzm5KhqzopIg+xum+UZUmWSBbeAuY5fE93YCGIB9WozqtqfJE/FQRBc5EmZV7vTlTegFvZE
	ZvyhJYz/wgaEsAMMdBGF7mCsUi+AoD8XtWErsUhQHSJL/Vv4jYP3az0+doRQ9zWWvhuiQx4=
X-Google-Smtp-Source: AGHT+IFGL5ebfXnS6+SsaO2dpfkoeJy4mYNicoKfeWryjtieYLtsaUUUpvT+btcO05B9ZGq86PLAnw==
X-Received: by 2002:a05:600c:8b08:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-45334b80acemr20305265e9.33.1749806966724;
        Fri, 13 Jun 2025 02:29:26 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08a2bsm1805946f8f.62.2025.06.13.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:29:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 13 Jun 2025 10:29:00 +0100
Subject: [PATCH v2 5/5] spi: spi-fsl-dspi: Report FIFO overflows as errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-james-nxp-spi-dma-v2-5-017eecf24aab@linaro.org>
References: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
In-Reply-To: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>, 
 Frank Li <Frank.li@nxp.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

In target mode, the host sending more data than can be consumed would be
a common problem for any message exceeding the FIFO or DMA buffer size.
Cancel the whole message as soon as this condition is hit as the message
will be corrupted.

Only do this for target mode in a DMA transfer because we need to add a
register read. In IRQ and polling modes always do it because SPI_SR was
already read and it might catch some host mode programming/buffer
management errors too.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 31432d533dea..f62f99f272b2 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -556,12 +556,24 @@ static void dspi_rx_dma_callback(void *arg)
 	complete(&dma->cmd_rx_complete);
 }
 
+static int dspi_fifo_error(struct fsl_dspi *dspi, u32 spi_sr)
+{
+	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
+		dev_err_ratelimited(&dspi->pdev->dev, "FIFO errors:%s%s\n",
+				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
+				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
+		return -EIO;
+	}
+	return 0;
+}
+
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
 	size_t size = dspi_dma_transfer_size(dspi);
 	struct device *dev = &dspi->pdev->dev;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
+	u32 spi_sr;
 	int i;
 
 	for (i = 0; i < dspi->words_in_flight; i++)
@@ -610,7 +622,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	if (spi_controller_is_target(dspi->ctlr)) {
 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
-		return 0;
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		return dspi_fifo_error(dspi, spi_sr);
 	}
 
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
@@ -1055,6 +1068,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
 
 			if (spi_sr & SPI_SR_CMDTCF)
 				break;
+
+			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
+			if (dspi->cur_msg->status)
+				return;
 		} while (--tries);
 
 		if (!tries) {
@@ -1071,6 +1088,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	int status;
 	u32 spi_sr;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
@@ -1079,6 +1097,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
+	status = dspi_fifo_error(dspi, spi_sr);
+	if (status) {
+		if (dspi->cur_msg)
+			WRITE_ONCE(dspi->cur_msg->status, status);
+		complete(&dspi->xfer_done);
+		return IRQ_HANDLED;
+	}
+
 	dspi_rxtx(dspi);
 
 	if (!dspi->len) {

-- 
2.34.1


