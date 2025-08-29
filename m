Return-Path: <linux-spi+bounces-9774-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C85DB3BA2F
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 13:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ADCD7B62F2
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BA315774;
	Fri, 29 Aug 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yC3td3pP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3E314B67
	for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468053; cv=none; b=LHNntCcDVZ8JfXsZErjjPnSvAZg0Atj+BIuQNzS6B+GTAXLDuSThoZymo2e6qbmMrygP/UOpPd1DK9g3oKk1brXFuwM0u1rdL1NuQKMMPjaOrE2C24giSMFoGuyADoJ8Mp2b1NVFy6bRtuyqFWprOIwSEDCYAI4VmOf+iPGB8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468053; c=relaxed/simple;
	bh=bTUKpVXwp9125KIPPU8YBtuFfyyzlP1eFCD8gRj3p3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHgE5Grs2WVX98k9extBO9AHKpaQSdEm6Sapbo7wXgEQG+YvMu2lEyc1osrTGyZG0WwCC98MNk08Tnv16b/UdTp5I3pzNFzcEaTiiv5iPsepkKvdzhmsuTQ2js9YRjYEOIMVYTuArvM0rZ2RsfnYB6YzDpZ2ppMWjpMbIGSMigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yC3td3pP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b77f59bd8so9660025e9.0
        for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756468050; x=1757072850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Og+6Xc5xVCmdDpeujz/1JM5sB4nNH/Jrk3ZxlgxIXaM=;
        b=yC3td3pPa4IdmO9hA6HREwOVnB2x0XO5lwX8SNDvkDbvoEwymeLQ8SCZbPkHgEA1wp
         8OiPSwchxUtn5uH4TiDJGkvoj+a2Y4dT5JT6dvB/ZC/sbNOpVwlo1z2pDqhjxO+Y+/Ac
         BH68cEAFQHY1pzRMcLf5QntTHXbHRQsnqypanJQvomxB4u5liyaImI/RvxWp39tUob9i
         maZmI3iu+JknpMbUgMKVaqYplKuTL3YdKAVI83J+58VUQHi7fPrneIWnfaXnVBtqPRZ0
         +KlRHXoEhO1wRR9V/6B+c9y5HxjqZR1IdRohDKdSXs476Wjak8GvY+e8gsyuwukzeL7k
         R/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468050; x=1757072850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og+6Xc5xVCmdDpeujz/1JM5sB4nNH/Jrk3ZxlgxIXaM=;
        b=lSZdr8SVHRmjnnRnFGZQjlLM1MtgyJUod/5ayNDERCc4yBf9pC4mNtW7QSyap0y34N
         FPaAYscn5feSzn/+5vaRG+KGLCDYxz0GNHyvbOt+4F1VRxrmGbzsmj/iNn82BViGj71M
         AzF5TKedoifzYR2RbzkoDmvL8dOCO1Vqvlf9Vsa/wci8roSgoVfM7jeby8m4Txgjvbvu
         vsrv2a7pF2GHqGSv+5e1+XL8OnO5QEJfTcx/zPnIjiV51kcV5aZzgwZZW8R1iE4wmPt9
         MpfL8+QTkZ357zkMdGaJ01novy1tnreDikARav9qprBNn8CZW3gcI+5xShFybrn2D1Jt
         M6mQ==
X-Gm-Message-State: AOJu0Yxspiyio3wka8k0SH0LnoDWYKOLpn+x3p3flPniRU19Zej42ASO
	bxKie84ximWMtJflk2bGg3H7YZpeibkuZ/YtdFGgomjSnDziOJ8B+Blq9C2kxGMe8oc=
X-Gm-Gg: ASbGncv2S9QIHatKbRTCoJs26H66B9quMVYau5/OFU6l0ghgG6ucF5ILbxuFSwvKVb6
	X96DVN53vcWkGiaqF1e/uFBaS3pmlZv1x8B8Fs1TNkEaECP1DA2VEhFnOe1Uqq0phoNER7hWVcq
	GDDeD/lp7UH4qPLFie93kHxOKXfe+Tw1Gvp/WqZ+3T31qd14R+1W+pO91RXiMASoh5T6bKyeX7c
	Fbgpi2WE3w08s59iMdq6++4xGZ58b6h6Iuqb7hx/USbm/dS1+JIGauHobLuWxwgA0Hr+BVfhYh4
	zfZHsRVgypRKw4sfuvC/BuRWDla50VXDNzuyZycv8Y5NJ/h4R2/s+6zrZbFdcn1j1G0rJP1agNd
	Lkf44bAojPkneKs2UZ00A4jt/2xwTrCYYxRoRqDgJwA==
X-Google-Smtp-Source: AGHT+IH/phP73RQmSHEL2ORjRZUORQjGvA9s+Grw6jbwknB2ZMXwWIYweFFb5AdJvkfbItdXPSBBBQ==
X-Received: by 2002:a05:600c:4443:b0:459:e39e:e5a5 with SMTP id 5b1f17b1804b1-45b6870e392mr116803305e9.5.1756468050364;
        Fri, 29 Aug 2025 04:47:30 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm29873255e9.9.2025.08.29.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:47:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 29 Aug 2025 12:46:48 +0100
Subject: [PATCH v5 6/7] spi: spi-fsl-dspi: Increase target mode DMA buffer
 size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-james-nxp-spi-dma-v5-6-3246957a6ea9@linaro.org>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
In-Reply-To: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

When the device is configured as a target, the host won't stop sending
data while we're draining the buffer which leads to FIFO underflows
and corruption.

Increase the DMA buffer size to the maximum words that edma can
transfer once to reduce the chance of this happening.

In host mode, the driver is able to split up a transfer into smaller
chunks so we don't need to increase the size. While in target mode, the
length of the transfer is determined by the remote host and can be
larger than whatever default buffer size we pick. Keeping the buffer
small in host mode avoids wasting memory, but allocating the largest
possible in target mode gives the lowest possible chance of dropping any
data from the host.

While we could allocate per-transfer using the exact size of the
transfer, 128K is quite a large allocation and there is a chance it
could fail due to memory fragmentation unless it's allocated once at
init time.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0e5f65d58342..3b652d744492 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -673,7 +673,18 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
-	dma->bufsize = PAGE_SIZE;
+	if (spi_controller_is_target(dspi->ctlr)) {
+		/*
+		 * In target mode we have to be ready to receive the maximum
+		 * that can possibly be transferred at once by EDMA without any
+		 * FIFO underflows.
+		 */
+		dma->bufsize = min(dma_get_max_seg_size(dma->chan_rx->device->dev),
+				   dma_get_max_seg_size(dma->chan_tx->device->dev)) *
+			       DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else {
+		dma->bufsize = PAGE_SIZE;
+	}
 
 	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
 						dma->bufsize, &dma->tx_dma_phys,

-- 
2.34.1


