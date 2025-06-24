Return-Path: <linux-spi+bounces-8736-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0796BAE629B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EF1192507E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1C289E3F;
	Tue, 24 Jun 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6KBzXRI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF7C2882A1
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761401; cv=none; b=Eg56jVSg7VWA8Vf/9M8IvCacwZtsMWMgI9sAXs0R4tNLo19FVQ5k+DeDOUF6I4yVowI81gRf6kx2nxOhCalCiwuMQxOSL/ONCdCCugfbI9pJW1FIkA8Gl1xxTGMOb3iA+SXdfWx7GHrF0jdTtf2sTxyh6yevkPwDHORQaBxvzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761401; c=relaxed/simple;
	bh=EIo8UQEK9JJZo6Yr7HcjRb0uvfHj1dsrPEXzaMvaVcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFl1MPBSbJVF8W2fLr4Jl3W6V37n0ZZkzRhhe+iWjQanXEkCejUcoTb44POTubMrYdudnwH60w0bQTpn7RJV47IKuyX3ostaGjDmZ/bZ10buizXws7bY8oml1Q6P9nt0Jg82H2x87v7OdTpynRHU85YyHVOlZUHvuxSleLCkYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B6KBzXRI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a588da60dfso3098987f8f.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750761397; x=1751366197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yByveb+QWwpdlj6fZIGqjtAddBVVjLr6cg6k7hq9bAI=;
        b=B6KBzXRIdbT9qu3Dfy5GB5/Wuz6SW8zgGnyf2jrM/HzXRlp4VI46QIs/mLbKZlWo+P
         cPDY03PbH5Zb66iaLh2YqkbijsF0hq0UGKUhoVtCGqdvhpfDCSGtu4ldS2wNR2x2EyWk
         /bklDkzdAlZLKrhrJryEdSGP+sDdgD9GNCs18RL/kPlI1YCL5abYb49Sng/tjIetmMQy
         SQWRQsY1V8EjYxLo2UZ/I+Hw0xdFE2/A5iNj5XVOlx10XJOHts3jETxQoajbhQeREQb0
         LEwqZOclab0b6iwEk2g4EaJ+n80/tEjhqNsWEVWBfjKFj4S97NaC1QfN3YeJajugeCsf
         iCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761397; x=1751366197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yByveb+QWwpdlj6fZIGqjtAddBVVjLr6cg6k7hq9bAI=;
        b=ZCfnI02B3dmvCk/T6Q15XFebWJRL8ci2ogxw873VsqD3Q50p0jubQl8azPZW+ICTm/
         KXeHEgrmfRbdE3zowYs011LySNQ29lYnySdmOdguwzVWyt4l5jCCbmMpfP6iPeSUSQFI
         18tM7ak6jrONbG+Olwn8AzLutBMEmH9tum1ETerGZTzUIh1wvfah0RuUxeqk+L6AkzjY
         AuzM1NM2VecSEuiD6dq4wNnw/2AjmVTVyrGJErOyujIIvFXJwNltSw+V+84B1WO+uo9j
         nI4NEnL7FNpoV/AIB3o6cYI55pJzA8HgNS6HCg6W/7OwGKPOEKe0Iz7Yw+CCPskOax0Z
         mRig==
X-Gm-Message-State: AOJu0YxVzm5HrmvTkRtIGVSUUeuXZ8y24LXoZZIHnO86RuOLcqSF8cVJ
	S6pj6Z/R0awWUeCKFXSiVsfUHBgP1WOFevLTc62KD6Nk3G54p5dm6TOQDVvKoLrES1U=
X-Gm-Gg: ASbGncv3xR2h8GvS+yR7Y7g8cWu7Z8XlrbGidWT/cY9aKa9HPIWPbM6Xu2Zq7ke4FXu
	Hn9B6mDL2B8IOYum9NxMsQBWFx18Dx7bfGfX6xl8KqxtJ+AaqArIstfM7JQVUWY5wYnUxLCmmly
	MbwXNkzhoDRT2anUlkj4/oJ7zgEiZTVRjaNDN3soT4mx0rAvSX/6Nl2drf7hHbFoZbKSO0IzIY5
	y02QFJ2jUH0epHxZD4dg5vZpu6YEx5fhxru2QhRwFsi0aw9zy6SK9RaccNO9g56vZ3M7rhMkRsC
	qjtJuU04qzqLOves1bKXFPS2kYTk5+/0x4eq4UAi6ushLvkwqjj26C9Ol+9+dbmqvSncsos=
X-Google-Smtp-Source: AGHT+IGqtZC+OMEg/cbcuU0+L6AZE/rEDM43V21E/KLrSJ/Lz2QOXzGgEBVldY6JiMoNuXeRqoNsUw==
X-Received: by 2002:a05:6000:2308:b0:3a5:88cf:479c with SMTP id ffacd0b85a97d-3a6d12d52c5mr11376772f8f.30.1750761397115;
        Tue, 24 Jun 2025 03:36:37 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb641sm143398245e9.3.2025.06.24.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 03:36:36 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 24 Jun 2025 11:35:34 +0100
Subject: [PATCH v3 4/6] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-james-nxp-spi-dma-v3-4-e7d574f5f62c@linaro.org>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
In-Reply-To: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Using coherent memory here isn't functionally necessary. Because the
change to use non-coherent memory isn't overly complex and only a few
synchronization points are required, we might as well do it while fixing
up some other DMA issues.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 56 +++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 8212c4193536..172eb9929de1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -492,11 +492,20 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 }
 
 #if IS_ENABLED(CONFIG_HAS_DMA)
+
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
 
@@ -504,9 +513,13 @@ static void dspi_rx_dma_callback(void *arg)
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
@@ -516,6 +529,7 @@ static void dspi_rx_dma_callback(void *arg)
 
 static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 {
+	size_t size = dspi_dma_transfer_size(dspi);
 	struct device *dev = &dspi->pdev->dev;
 	struct fsl_dspi_dma *dma = dspi->dma;
 	int time_left;
@@ -524,10 +538,9 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
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
@@ -542,10 +555,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
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
@@ -642,17 +655,17 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
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
@@ -687,11 +700,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
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
@@ -712,14 +726,16 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
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


