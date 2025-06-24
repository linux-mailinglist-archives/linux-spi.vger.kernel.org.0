Return-Path: <linux-spi+bounces-8735-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E3AE629E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 12:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2659A7B5B2E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1696289E1B;
	Tue, 24 Jun 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uk44DWTr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCB2868BD
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761401; cv=none; b=biKrjvfzp4UYd5SQMwfP91dCIUjvLoDsVeoPfrqK39JFRQsW2zvTKlJeohgxUACeLSjIWUYd9PyzmS3wGgvWNpw05abmIkbj2G6jH6g5rHhdfQlMo4FCl6bAWRYXDoLw+Qc6QGXSmXe7h2pdJBlUvd59VqH43YqcXbY8VLsP4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761401; c=relaxed/simple;
	bh=rPPHmIeX2TaVZwC9/dZT7uMHCVr3ystFWnOCxGonJdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8iEhZiVtsyPRu8UbAq0RN5FnVJ/mHc3COCqTXfKWJLBcrkyou+Sq0sslTb4h1FAVt+JSkn/765eOlPOTxkxlhsqURxAscgqvJ8V/Lo9owHREXa5becLsa+ynZhWN74+0NeVEesoLYN+G4IDy7qNgJG77QFOVPEjvHIIr7SPPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uk44DWTr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4537fdec39fso891945e9.0
        for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750761395; x=1751366195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gysqRRatTbP7tTmH3nSH2f9cu6jlsK5Aa8DruBZasIA=;
        b=uk44DWTrDfVnc66GvbJycE91Y2cBI6zvTvQ5Sw9+AWxmIv2mRzFSWnhlnMvqgk19ya
         uvFGYNnOOJQfFpK0qwsjIKaGT/KQwhHPVMNLEdA2swfH/6V+8ZTH7TjhM2v+mERTMlzS
         1ppnStPih/LTNTBz0GYX3JLPP6KjmrBnqXslKXkjs36Xa2w07FimbiSVyHCEXmEMysAS
         i3vw6+T9NCsIJIUN0aSHOXcsMyA6v/xILCcqWipf1xyYhsMQaEXJwrUv/JORKggFF+Mu
         CJ8Xli6IEVyW9A6sk5EIp8kBKXmW6jjECuclJRuXHZlBvse8vPKALN9GCzus5QW4B78F
         Q4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761395; x=1751366195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gysqRRatTbP7tTmH3nSH2f9cu6jlsK5Aa8DruBZasIA=;
        b=mLtJZJYFNkBrC+1oiMJzdFwwUWnGkzJLf7p+hkhXaOqVPY+ZmRfMTqqE/Fxfrr/EnL
         BFNbJVOJa0wtc8Xw1eorw2V5jphzHTTy8ky6zb4Omftz5xNkPsDNSL08IWKSqB3EAYh+
         9EFXNYlS3KvMhuxU2hEgt0cOG1wWzoAaZBWyhS1Oog923X48vVd4OJYGIAnz9iQYshoe
         yHpnfJkjm3fb5h5m4SZvf+ytzO56Ho+x7dvPmQhsmT8cvAL2S3P8g3ApNUmm8TqyRgOs
         z5IxyB7zyduyGPG2zFgR3L25hguzffMVMUyh2X3x7kXnPWF13FGWwIcZvDvYeuOeBKwF
         KFqw==
X-Gm-Message-State: AOJu0Ywk2eo9M8okKDNgV1grXsiasu6SgRF9RLg6PcI0liVKpMgnt7QS
	ZZdPomEVJ+tr1D1sQdwzUgGC9u+jIY8xE+YX5MXu9wQIZevjx9RPefDPxTP9szIGyGQ=
X-Gm-Gg: ASbGncvYcNHRll6i26yJ2b3CUkoRaCqFYiNWseiYjUHmhRDmC0vu2MznI3ShDHnGleZ
	Ze2FPx3U4HGxg4uf6Tsrs1JUw0U0JVSUjS4esIELg6mrLvQp1PQ43I6jryt/Fq040aZpuHja71r
	ocTh1+tcW7tWUHNZzzrSVtjKfC0RsUzKO+EU2072KvCfZ5qpyS5503llOI2FRVPrapymWU4ciky
	/zUh9O06b+St5Ccj9nZCGdhiWwTBMu1b+5bE5V/4unFkBkSs1i3Zd3TuLXrggfJT0sJZwIu5Oe2
	fkXx2FQG+ngKFqw7UfKPdl0mE4XU4/vcSUAvHVDFjJSV3gJx5hg7IYxyJjAkDlK2T82qOjQ=
X-Google-Smtp-Source: AGHT+IFw0SflV4Dcc0L4irSH0AC03LWWYU+kHmLLJTkRqnESJXIae3FlSgpPvJNiF5otB/q7x9CqBw==
X-Received: by 2002:a05:600c:1991:b0:444:c28f:e81a with SMTP id 5b1f17b1804b1-453659f5888mr134601975e9.27.1750761395024;
        Tue, 24 Jun 2025 03:36:35 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb641sm143398245e9.3.2025.06.24.03.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 03:36:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 24 Jun 2025 11:35:32 +0100
Subject: [PATCH v3 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-james-nxp-spi-dma-v3-2-e7d574f5f62c@linaro.org>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
In-Reply-To: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This will allow us to return a status from the interrupt handler in a
later commit and avoids copying it at the end of
dspi_transfer_one_message(). For consistency make polling and DMA modes
use the same mechanism.

Refactor dspi_rxtx() and dspi_poll() to not return -EINPROGRESS because
this isn't actually a status that was ever returned to the core layer
but some internal state. Wherever that was used we can look at dspi->len
instead.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 68 ++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 744dfc561db2..feb29bb92a77 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -591,11 +591,10 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 static void dspi_setup_accel(struct fsl_dspi *dspi);
 
-static int dspi_dma_xfer(struct fsl_dspi *dspi)
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	struct device *dev = &dspi->pdev->dev;
-	int ret = 0;
 
 	/*
 	 * dspi->len gets decremented by dspi_pop_tx_pushr in
@@ -612,14 +611,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 		message->actual_length += dspi->words_in_flight *
 					  dspi->oper_word_size;
 
-		ret = dspi_next_xfer_dma_submit(dspi);
-		if (ret) {
+		message->status = dspi_next_xfer_dma_submit(dspi);
+		if (message->status) {
 			dev_err(dev, "DMA transfer failed\n");
 			break;
 		}
 	}
-
-	return ret;
 }
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
@@ -986,36 +983,40 @@ static void dspi_fifo_write(struct fsl_dspi *dspi)
 				dspi->progress, !dspi->irq);
 }
 
-static int dspi_rxtx(struct fsl_dspi *dspi)
+static void dspi_rxtx(struct fsl_dspi *dspi)
 {
 	dspi_fifo_read(dspi);
 
 	if (!dspi->len)
 		/* Success! */
-		return 0;
+		return;
 
 	dspi_fifo_write(dspi);
-
-	return -EINPROGRESS;
 }
 
-static int dspi_poll(struct fsl_dspi *dspi)
+static void dspi_poll(struct fsl_dspi *dspi)
 {
 	int tries = 1000;
 	u32 spi_sr;
 
-	do {
-		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
-		regmap_write(dspi->regmap, SPI_SR, spi_sr);
+	while (dspi->len) {
+		do {
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+			regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
-		if (spi_sr & SPI_SR_CMDTCF)
-			break;
-	} while (--tries);
+			if (spi_sr & SPI_SR_CMDTCF)
+				break;
+		} while (--tries);
 
-	if (!tries)
-		return -ETIMEDOUT;
+		if (!tries) {
+			dspi->cur_msg->status = -ETIMEDOUT;
+			return;
+		}
 
-	return dspi_rxtx(dspi);
+		dspi_rxtx(dspi);
+	}
+
+	dspi->cur_msg->status = 0;
 }
 
 static irqreturn_t dspi_interrupt(int irq, void *dev_id)
@@ -1029,8 +1030,13 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	if (dspi_rxtx(dspi) == 0)
+	dspi_rxtx(dspi);
+
+	if (!dspi->len) {
+		if (dspi->cur_msg)
+			WRITE_ONCE(dspi->cur_msg->status, 0);
 		complete(&dspi->xfer_done);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1060,7 +1066,6 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	bool cs = false;
-	int status = 0;
 	u32 val = 0;
 	bool cs_change = false;
 
@@ -1120,7 +1125,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				       dspi->progress, !dspi->irq);
 
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
-			status = dspi_dma_xfer(dspi);
+			dspi_dma_xfer(dspi);
 		} else {
 			/*
 			 * Reset completion counter to clear any extra
@@ -1133,15 +1138,12 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 
 			dspi_fifo_write(dspi);
 
-			if (dspi->irq) {
+			if (dspi->irq)
 				wait_for_completion(&dspi->xfer_done);
-			} else {
-				do {
-					status = dspi_poll(dspi);
-				} while (status == -EINPROGRESS);
-			}
+			else
+				dspi_poll(dspi);
 		}
-		if (status)
+		if (READ_ONCE(message->status))
 			break;
 
 		spi_transfer_delay_exec(transfer);
@@ -1150,7 +1152,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			dspi_deassert_cs(spi, &cs);
 	}
 
-	if (status || !cs_change) {
+	dspi->cur_msg = NULL;
+	if (message->status || !cs_change) {
 		/* Put DSPI in stop mode */
 		regmap_update_bits(dspi->regmap, SPI_MCR,
 				   SPI_MCR_HALT, SPI_MCR_HALT);
@@ -1159,10 +1162,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			;
 	}
 
-	message->status = status;
 	spi_finalize_current_message(ctlr);
 
-	return status;
+	return message->status;
 }
 
 static int dspi_set_mtf(struct fsl_dspi *dspi)

-- 
2.34.1


