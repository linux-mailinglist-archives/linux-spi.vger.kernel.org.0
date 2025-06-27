Return-Path: <linux-spi+bounces-8802-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00419AEB495
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FF7642AAD
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC72D3EDC;
	Fri, 27 Jun 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ou2fT85A"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324D2C032C
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019738; cv=none; b=uhmVfU+SH2smGu8TzhVoRT2uIH9dXSprDF8tZy0sHtGg8haL8Ymm9Ttj8LNXbRtrHlnl81kDbPssJ8PVEjZDh1eH4Nwff3J5rvbPFNd7uTYLxYT1YeMUVGNhNsC4JAjjL5GVWE+RlY2aOzWtw9Z+P7PdpRFG7vczrq0h/SCU5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019738; c=relaxed/simple;
	bh=Z8frqqy30nG+OKukuzOwifOyefXL07H88wTOTdMsN+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKWQqgsWpJtdj2gsWJRczMGGdKNR2Rrz/ZC+CWhaeSIJvWV3S941wptIrZ6qPviKizulvsqqi/t24dSWPwvD8TRrALr5eauL+dTvc7boHTyCLMZzdkJIzJdg1gACVGk1Yb3VP6WdaFdNh/VsoJ5P0FaSokEIPg5oiJ3t38rTqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ou2fT85A; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a53359dea5so1232786f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751019733; x=1751624533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbrbKVrAfsFPHXHgG1UiQWZ27CeKEpZkvt6/TbfRDzE=;
        b=Ou2fT85AH+BRsNrhjgVDHQJijwhNjzTDfbw3VKxqdKPrp9Z4PAtzvlSuVRuJmdd+Eu
         dXvhFMubcVTgccRmY82cnX73NQj0Q4SYyTGNI7pck90nNxST8kdc9e5OY+rsbESe5vgW
         vPwzj+PTcwRf2P1qKk4zhYaBa9+r9hd/XcZyyvYqbnzwlwEqhxVvviZiti0NhQfOq5H1
         oI0tIY+m0kDOCR87f4+65uZR/cjzm1PmAxiiSHLPcz5Lm2eaHZ+ddF40FzGQB8ayU8bP
         nXf8GeDxQQXyQSSFkj6poGCy2jJvaUpLCzwAwoixQowxEJw/cK3LR+gjAOlS1b07grPb
         IfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019733; x=1751624533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbrbKVrAfsFPHXHgG1UiQWZ27CeKEpZkvt6/TbfRDzE=;
        b=uxOFpMm82qFnkLTbXtyeCqH0hel7euThURePg6xR8KMNJ8f35KCTCHG5e7WCDgpsdD
         SpPGC7A4XqZtJO55I2Efyr7uxGMKbmWy9q+xDm2mhOVE9bXrYVEbXuzL7eK19tPJTzso
         yYik44EggeGy1fxRdOLRGRrB+qdDkD8T8EE0KIDqIQVlTvlrbPJIbPwpTNQrWA//J35W
         Pk7ybTfXHG3e7QWxSOJsKf5aUQ4M+YkFjik+pZG5f3n9zOSEgQI7DoNr+1+EnClWn/c1
         66iqU9AdzwfctWMuNmYJfh0RseU5e5Ax6nWmOZP2gKQMsBI72ZN6vJ1M9zh7bODfsqXK
         RoyQ==
X-Gm-Message-State: AOJu0Yzg0lPlHe+SzpaW1JTU/kzqc3vsZQugVY3L8xcD2DYer+owyqgR
	9bNbATjDPiVCaS/LHfEyfYv5/Lx00fhDULFQWzV3a82UBsLoj4Cl/JttC63yfrJJiXU=
X-Gm-Gg: ASbGnctOneJY2eiGYfGP3E/guo8NCEGFdzdCiP1Bji9FKCnGN4ULF+r/3uhuorE52kK
	GDVit8DALajGVK39vrSc1pTCpkJc2qj/E4oSBzck9uc8KI7eB+MkKKKDrGwVEXNYbD8rTP167IO
	VvAiYkj0xa70jrTN2DuKTvShlippScoIBsJD4NmOzRM/QeyvmPTzWPmQh9O/ArjLViWiwC/3ZIo
	ihyJ4UXuBYIoR4lrCl166jKExXJrNo6FUIyXdXs3DKHBzBt+R+3IxvX/wCyTeW12W4Q7FE29z7Y
	PlyzKq8pAA07tKm1ZXLQuODy6gqGj3tLeZPBlcEj4wBS+iwm5KWKSy+1iGWj5LK99BVzIL4=
X-Google-Smtp-Source: AGHT+IHT99Km+vRDHeIrDRPxOZCus1ggOuBcUxJZEPSSQ7juhoGgMSdwHinFGAjaa5ldBFrah6fCRQ==
X-Received: by 2002:adf:fccb:0:b0:3a5:3930:f57 with SMTP id ffacd0b85a97d-3a9004801acmr2028143f8f.51.1751019733389;
        Fri, 27 Jun 2025 03:22:13 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5599sm47250955e9.13.2025.06.27.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:22:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 27 Jun 2025 11:21:40 +0100
Subject: [PATCH v4 4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-james-nxp-spi-dma-v4-4-178dba20c120@linaro.org>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
In-Reply-To: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Using coherent memory here isn't functionally necessary, we're only
either sending data to the device or reading from it. This means
explicit synchronizations are only required around those points and the
change is fairly trivial.

This gives us around a 10% increase in throughput for large DMA
transfers and no loss for small transfers.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 55 +++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index feff475dddfc..e7856f9c9440 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -493,11 +493,19 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
+static int dspi_dma_transfer_size(struct fsl_dspi *dspi)
+{
+	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
+}
+
 static void dspi_tx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
 	struct fsl_dspi_dma *dma = dspi->dma;
+	struct device *dev = &dspi->pdev->dev;
 
+	dma_sync_single_for_cpu(dev, dma->tx_dma_phys,
+				dspi_dma_transfer_size(dspi), DMA_TO_DEVICE);
 	complete(&dma->cmd_tx_complete);
 }
 
@@ -505,9 +513,13 @@ static void dspi_rx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
 	struct fsl_dspi_dma *dma = dspi->dma;
+	struct device *dev = &dspi->pdev->dev;
 	int i;
 
 	if (dspi->rx) {
+		dma_sync_single_for_cpu(dev, dma->rx_dma_phys,
+					dspi_dma_transfer_size(dspi),
+					DMA_FROM_DEVICE);
 		for (i = 0; i < dspi->words_in_flight; i++)
 			dspi_push_rx(dspi, dspi->dma->rx_dma_buf[i]);
 	}
@@ -517,6 +529,7 @@ static void dspi_rx_dma_callback(void *arg)
 
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
+	size_t size = dspi_dma_transfer_size(dspi);
 	struct device *dev = &dspi->pdev->dev;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
@@ -525,10 +538,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	for (i = 0; i < dspi->words_in_flight; i++)
 		dspi->dma->tx_dma_buf[i] = dspi_pop_tx_pushr(dspi);
 
+	dma_sync_single_for_device(dev, dma->tx_dma_phys, size, DMA_TO_DEVICE);
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
-					dma->tx_dma_phys,
-					dspi->words_in_flight *
-					DMA_SLAVE_BUSWIDTH_4_BYTES,
+					dma->tx_dma_phys, size,
 					DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!dma->tx_desc) {
@@ -543,10 +555,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 		return -EINVAL;
 	}
 
+	dma_sync_single_for_device(dev, dma->rx_dma_phys, size,
+				   DMA_FROM_DEVICE);
 	dma->rx_desc = dmaengine_prep_slave_single(dma->chan_rx,
-					dma->rx_dma_phys,
-					dspi->words_in_flight *
-					DMA_SLAVE_BUSWIDTH_4_BYTES,
+					dma->rx_dma_phys, size,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!dma->rx_desc) {
@@ -643,17 +655,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->tx_dma_buf = dma_alloc_coherent(dma->chan_tx->device->dev,
-					     dma_bufsize, &dma->tx_dma_phys,
-					     GFP_KERNEL);
+	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
+						dma_bufsize, &dma->tx_dma_phys,
+						DMA_TO_DEVICE, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_tx_dma_buf;
 	}
 
-	dma->rx_dma_buf = dma_alloc_coherent(dma->chan_rx->device->dev,
-					     dma_bufsize, &dma->rx_dma_phys,
-					     GFP_KERNEL);
+	dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
+						dma_bufsize, &dma->rx_dma_phys,
+						DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
 		goto err_rx_dma_buf;
@@ -688,11 +700,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_coherent(dma->chan_rx->device->dev,
-			  dma_bufsize, dma->rx_dma_buf, dma->rx_dma_phys);
+	dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
+			     dma->rx_dma_buf, dma->rx_dma_phys,
+			     DMA_FROM_DEVICE);
 err_rx_dma_buf:
-	dma_free_coherent(dma->chan_tx->device->dev,
-			  dma_bufsize, dma->tx_dma_buf, dma->tx_dma_phys);
+	dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
+			     dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
 err_tx_channel:
@@ -713,14 +726,16 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 		return;
 
 	if (dma->chan_tx) {
-		dma_free_coherent(dma->chan_tx->device->dev, dma_bufsize,
-				  dma->tx_dma_buf, dma->tx_dma_phys);
+		dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
+				     dma->tx_dma_buf, dma->tx_dma_phys,
+				     DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_free_coherent(dma->chan_rx->device->dev, dma_bufsize,
-				  dma->rx_dma_buf, dma->rx_dma_phys);
+		dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
+				     dma->rx_dma_buf, dma->rx_dma_phys,
+				     DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);
 	}
 }

-- 
2.34.1


