Return-Path: <linux-spi+bounces-8738-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3E8AE629F
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 12:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB9A179299
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 10:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1785128B7EC;
	Tue, 24 Jun 2025 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGNkWtKj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874525C821
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761403; cv=none; b=rZuprWfEYd/EBbtSEGQM46A6AfNa4PcgYXi54we398UXiXDTmmkrtlXCztC3IGUCFocrvcND4a7CqxERONa6r4MLleezwVTgaDwjUdXDYthfivKIfGOJrqXHwsZxgpa454oMo7IMbni9fZmB7t/3DeNil37WREAglVvIMOLGY1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761403; c=relaxed/simple;
	bh=X4TMFyCSx8+go3pfcWGphm0X5j2rswwDLDyFMqRvmhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SvWtHGou/NIV9XkfCvYTsh0g8GSl+yWGrFtFeDy2EuMscY36nrrtaAISDl3sjEO1kB3SNIpTQTjydy2LXs0afkEkwfur2AG2i0dmMswRZJWIhatqY8VhHoMPeRYF/rXSD7oikUJ2qZ3ePZogMqLXCJLDojK+3EaXXoYKgkIwCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HGNkWtKj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4530921461aso2356175e9.0
        for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750761399; x=1751366199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfaJB4wgBJF9kKkXQUfWPFPPVgluIefucU17tIlexuI=;
        b=HGNkWtKjyS+loBQXGemKg+KQ4MT/yigDhQJwr4+0UCsQ1XVODFiXTyoVSl47BZr4ao
         WOvxAGztnXTdg2dcqrlqWT2a72fJDuw4oRGNmvnD11av5kh6nQoZFNXAWNW4D7ywcZoM
         qo6EQqVyy+H/fa9uOmwqMaJpAzysT2hHEYctL3tAYjiILcsyKT9m6+FNCnpJleD5ZAFl
         fDU78B3B/MrEI5O30Ga0V6487+cgxefLd4V1k/5yAIWPKIJr8ljg+4gkpLw7EmwzFYh2
         U7orl8p7kAgR79On/LT43X3ivCh7/ZfV3UNMR5c3ceRn/kIoliNcpYC1f9mB3R47oP7L
         nlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761399; x=1751366199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfaJB4wgBJF9kKkXQUfWPFPPVgluIefucU17tIlexuI=;
        b=RpYEO3GQWIixSlnxkcKQzothtTKUnJjY5Tj8EM8A2MuegYzazdtgeKajTqyvLPY+zP
         5wKThSZ8TRk7aHVuSga4LGlxo17iNxWpppk9sqzyUVKGAe+vzEcvmB5WZ+TTdhc0xqHA
         DAGc6J52O3phsM3YgsSLEXijEFsTTpvZUPfRW5/9TDrecXPy+Dscwv9jERmRnzNOHLvG
         UGAwUj7QzbHcK+SxWkpbjumHJrN8/8TTVVGHD/CVqVEKwlrKeg4kd4f3HdD79P9QIq9W
         HWdM9E3iPn/ZIAS8noPixnuVpC6K5HierGcKEo95LWG5BsdniLVS8bT1UPWgFVvwREyU
         SMKA==
X-Gm-Message-State: AOJu0Yzc7/iGXZdgcRqiOEJEyyJX1Mq1Hjqt6T0jCO4Rfq5cS/b8nyY9
	qyoFxpfqB3c5uosTBLJFSVC0gZ8b3sJiv9jsYNhqRkEaP+K8rI6NFhhZMiBhS6P6ZWs=
X-Gm-Gg: ASbGncumwleVFcQSNHEPH9G9sz40+ETpkrZYVNa3WNH6gJF+r5NsCIfT5qt6k4IAFep
	M/LXOTr/FbZvOdWHGL8lBRb+JvoK0qzg53jCBsT9uwAiAiQfXjZzloWIWZJV6H98J5DPxPPt2vU
	MgzQFNBok3C+1oHItWslK1uTEAVvE63fHZ2nzJtSufIOFgV+50V2UrjejPFVACZK1j+hrCq5KwN
	39lG6G0ewFm108nUfu09Qq63DtKwk1EB9W+ux58wwEXFrA+DLe9YBmB63tx0aDWx/mKj8SfiA/y
	Hg8WtmxXyoS/R0xEqfiBCzM1zTdxBsM4p0C0SaU26W+r65QunAp+qjvEjyx49yIXhEdqGJQ=
X-Google-Smtp-Source: AGHT+IFjHGQ/H+wHW0syoZB/rCcGbth7MceBuzjub/X3klVhpmcprnqWAMJ0DPRZSe/+ArGUdMIdMg==
X-Received: by 2002:a05:600c:5250:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-453653925f1mr135996935e9.6.1750761399129;
        Tue, 24 Jun 2025 03:36:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb641sm143398245e9.3.2025.06.24.03.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 03:36:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 24 Jun 2025 11:35:36 +0100
Subject: [PATCH v3 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-james-nxp-spi-dma-v3-6-e7d574f5f62c@linaro.org>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
In-Reply-To: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
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
index 58881911e74a..16a9769f518d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -560,12 +560,24 @@ static void dspi_rx_dma_callback(void *arg)
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
@@ -614,7 +626,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 	if (spi_controller_is_target(dspi->ctlr)) {
 		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
-		return 0;
+		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+		return dspi_fifo_error(dspi, spi_sr);
 	}
 
 	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
@@ -1069,6 +1082,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
 
 			if (spi_sr & SPI_SR_CMDTCF)
 				break;
+
+			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
+			if (dspi->cur_msg->status)
+				return;
 		} while (--tries);
 
 		if (!tries) {
@@ -1085,6 +1102,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 {
 	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
+	int status;
 	u32 spi_sr;
 
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
@@ -1093,6 +1111,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
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


