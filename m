Return-Path: <linux-spi+bounces-9860-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E6B40117
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 14:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C326A4E399D
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 12:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09D2D3EC7;
	Tue,  2 Sep 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="li2BReH+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DDE2D9ED7
	for <linux-spi@vger.kernel.org>; Tue,  2 Sep 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817175; cv=none; b=AUM1egZUgOpJgwyzOn2t1ycEvlwtq40+JfzvTuSjUAcBNAuZwxS8lWMtpNYz81twWQJPvB27BqG0/jHJApJ+7qK/tCaMKOVJ0znUQ0wp5/zcNNidvbyMxD/sKxOiTGC9i67EbqS3plKgrbcVJQ/wCOqtRecjQtV+hMeIvyY3AUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817175; c=relaxed/simple;
	bh=v/uxCKJdP+2z/SZsRX7qf7nC3a/OLUNE6hFHvBrITqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eCDXfYZtiQkCrf0S3r5gNHkKmctoGpekHwugkIFnSpjwbXATGbu/DJyDgRaJ9yvxg2+7douhrtoM4IKWrOFeGw+05Y8w8zEhCo7ZbHjaILDGh6UtlnlIA2DWv6xmHafWOqPk3ZlK4FwDUZYgW2zy9SLcfPuOMrG+yJX+g582iMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=li2BReH+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso1840387f8f.0
        for <linux-spi@vger.kernel.org>; Tue, 02 Sep 2025 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756817171; x=1757421971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO3e10lREs9p/eEtCUsOWQlh8TKJIiFbHYmIoKfi80M=;
        b=li2BReH+E1pcIs3feeQPnCAZZPf7oheRfl3dk3mu+TVex/N1F2jKk6rShlJORpCE9B
         SqNHigthQZQUik0egBjm6dvW7PxsqFC3bE7UI/xbZaztr8O5W46ZQ4bFCtmHSKiWZwgY
         aJvZduD9DOwU648ai3mPFbv6u3Dn9/18REZC8WUSwMFYKGHTHdxGp1c8Q8pC6B0KwV4Y
         NfPK4BCjqIcB0e9qJur1fUXkco0r6ODNxYjJU1KXPX6wn3XAOK9V4iMneXcP54cdpV99
         HKTyEpUJoOpWxzJEUIjSYEqmPA3DGIooY2DELf6gQdrJujTAqZ9nbQyzaqCdbnWSUjmC
         jMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817171; x=1757421971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zO3e10lREs9p/eEtCUsOWQlh8TKJIiFbHYmIoKfi80M=;
        b=mgmxgC6eNm0KuIaxdierhAaSWz9xI2jyLqTKADcF5t3qQfAUKNadhHLGpKOlwLMCFo
         2Dh5E0HkzzNfid7pJjdy+kmkLEn4rZx5LUBajRbqGrXb/QBWLS9DVt9jBFotyT6oiTnx
         BxUvIjzjm9yoiRdP1gSN+nMCNfc3OYDUYFZkQ9rciYUcLNHQ+Uv0LeKkSuB2ItLFqnwH
         1i4v48qc8YWwEl8AWuCZEzCxiy67pywSo2fBskiUg2+NnKoIWFAYZWipDU/KaFtw4XfF
         YZfSTCCd19V2mrPMn3KbjaLQ9hFAWhUCfBWg4Bc4IQP6Ng9RmJw3lqmNa7+88ziw4mUd
         TmTQ==
X-Gm-Message-State: AOJu0Ywx7qVOLPRewslNojNedm02wWTAx2kpYdHFDFNLuHB7c7Tw04Z1
	6fBBJS6etFg82I3kr3+LsuOLAhW9vJ5RiCgfSU7O5RMainq1qDJPw1T42ofNASFCNws=
X-Gm-Gg: ASbGncvIVePJe8BTJ6XdMxbphDbfDNaQ8wRQlOnKxLUp6nAD3RKsQDIhZqPbynWp973
	G1U4eErmkUQv+lKApO24qtSJIuWH0E7dMROXCJm7DrVptIC9Ii3eC4WSuwcBFanR9GyV/PozPxC
	w4a5+byfu9anX6m6xCIsvEBRJxr8VmNo8jg4VnjU5Ue1hope6QUnVsoAPotDvxq4/TcsMpg9g2k
	BzNT0Umw6kUcUtctzj7Fmx91gbQe6ClDAL2DI4OmxbxbzyCYxhw5CCewIFbWpu+zz08GojH/+Yb
	7vQt2VHLID1Dg5m/W1GpXK5MLxT9EqVNzKGDgu3xTYMFjBoUOp9Ca/9plKlOsGRGoM2gcGADIhm
	NGwDtgbHdbZihENXtXLT2x6xtf8uKsN5CsfUd2xvVkg==
X-Google-Smtp-Source: AGHT+IFBOztEmu3TQb+b78WlUZhWND4Jix1WfelrhLf0L9O3+fhi7YgD88/+Eg01QZasQk34F4HsBA==
X-Received: by 2002:a05:6000:2112:b0:3d2:6129:5505 with SMTP id ffacd0b85a97d-3d261295a85mr7852150f8f.36.1756817171365;
        Tue, 02 Sep 2025 05:46:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm19589896f8f.15.2025.09.02.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:46:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Sep 2025 13:44:57 +0100
Subject: [PATCH v6 5/7] spi: spi-fsl-dspi: Use whole page for DMA buffers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-james-nxp-spi-dma-v6-5-f7aa2c5e56e2@linaro.org>
References: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
In-Reply-To: <20250902-james-nxp-spi-dma-v6-0-f7aa2c5e56e2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

dma_alloc_noncoherent() allocations are backed by a full page anyway, so
use it all.

VF610 devices used to use the full page before commit a957499bd437
("spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode"), but
others still used the FIFO size. After that commit, all devices used the
FIFO size. Now all devices use the full page.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 81d1e4470f94..6bf87ef01c13 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -331,6 +331,8 @@ struct fsl_dspi_dma {
 	dma_addr_t				rx_dma_phys;
 	struct completion			cmd_rx_complete;
 	struct dma_async_tx_descriptor		*rx_desc;
+
+	size_t					bufsize;
 };
 
 struct fsl_dspi {
@@ -493,6 +495,24 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
+static size_t dspi_dma_max_datawords(struct fsl_dspi *dspi)
+{
+	/*
+	 * Transfers look like one of these, so we always use a full DMA word
+	 * regardless of SPI word size:
+	 *
+	 * 31              16 15                   0
+	 * -----------------------------------------
+	 * |   CONTROL WORD  |     16-bit DATA     |
+	 * -----------------------------------------
+	 * or
+	 * -----------------------------------------
+	 * |   CONTROL WORD  | UNUSED | 8-bit DATA |
+	 * -----------------------------------------
+	 */
+	return dspi->dma->bufsize / DMA_SLAVE_BUSWIDTH_4_BYTES;
+}
+
 static size_t dspi_dma_transfer_size(struct fsl_dspi *dspi)
 {
 	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -620,9 +640,8 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
 		/* Figure out operational bits-per-word for this chunk */
 		dspi_setup_accel(dspi);
 
-		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
-		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
-			dspi->words_in_flight = dspi->devtype_data->fifo_size;
+		dspi->words_in_flight = min(dspi->len / dspi->oper_word_size,
+					    dspi_dma_max_datawords(dspi));
 
 		message->actual_length += dspi->words_in_flight *
 					  dspi->oper_word_size;
@@ -637,7 +656,6 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
-	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct device *dev = &dspi->pdev->dev;
 	struct dma_slave_config cfg;
 	struct fsl_dspi_dma *dma;
@@ -657,8 +675,10 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 		goto err_tx_channel;
 	}
 
+	dma->bufsize = PAGE_SIZE;
+
 	dma->tx_dma_buf = dma_alloc_noncoherent(dma->chan_tx->device->dev,
-						dma_bufsize, &dma->tx_dma_phys,
+						dma->bufsize, &dma->tx_dma_phys,
 						DMA_TO_DEVICE, GFP_KERNEL);
 	if (!dma->tx_dma_buf) {
 		ret = -ENOMEM;
@@ -666,7 +686,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	}
 
 	dma->rx_dma_buf = dma_alloc_noncoherent(dma->chan_rx->device->dev,
-						dma_bufsize, &dma->rx_dma_phys,
+						dma->bufsize, &dma->rx_dma_phys,
 						DMA_FROM_DEVICE, GFP_KERNEL);
 	if (!dma->rx_dma_buf) {
 		ret = -ENOMEM;
@@ -702,11 +722,11 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 	return 0;
 
 err_slave_config:
-	dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
+	dma_free_noncoherent(dma->chan_rx->device->dev, dma->bufsize,
 			     dma->rx_dma_buf, dma->rx_dma_phys,
 			     DMA_FROM_DEVICE);
 err_rx_dma_buf:
-	dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
+	dma_free_noncoherent(dma->chan_tx->device->dev, dma->bufsize,
 			     dma->tx_dma_buf, dma->tx_dma_phys, DMA_TO_DEVICE);
 err_tx_dma_buf:
 	dma_release_channel(dma->chan_tx);
@@ -721,21 +741,20 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
-	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
 	struct fsl_dspi_dma *dma = dspi->dma;
 
 	if (!dma)
 		return;
 
 	if (dma->chan_tx) {
-		dma_free_noncoherent(dma->chan_tx->device->dev, dma_bufsize,
+		dma_free_noncoherent(dma->chan_tx->device->dev, dma->bufsize,
 				     dma->tx_dma_buf, dma->tx_dma_phys,
 				     DMA_TO_DEVICE);
 		dma_release_channel(dma->chan_tx);
 	}
 
 	if (dma->chan_rx) {
-		dma_free_noncoherent(dma->chan_rx->device->dev, dma_bufsize,
+		dma_free_noncoherent(dma->chan_rx->device->dev, dma->bufsize,
 				     dma->rx_dma_buf, dma->rx_dma_phys,
 				     DMA_FROM_DEVICE);
 		dma_release_channel(dma->chan_rx);

-- 
2.34.1


