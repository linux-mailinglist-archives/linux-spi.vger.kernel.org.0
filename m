Return-Path: <linux-spi+bounces-8402-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94158AD228B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D6F3A8702
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDB0217660;
	Mon,  9 Jun 2025 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GuQBuNaX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC52116F2
	for <linux-spi@vger.kernel.org>; Mon,  9 Jun 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483224; cv=none; b=REpQPKsJKSxAF0zCUBsm1TU40oHlhYuriWPPsuPKM4RxLssDlqEUZdtNgrpFdYJQp2AKEGthnnZEtZRHWPD33Hlbzv0AAiIO4FAMT/OL35pd9XYFjFU20zQurnOiDFxAL1NS2HKWjsu4H9RmihVX/JUZN2PxoKocqfk5mDGrde8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483224; c=relaxed/simple;
	bh=rSD3V0AZT5bLu6rMQRRnpLdBVVlg+XpF/h6tXK3/+rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afJ/YQsFWwMzVzhyDZ7nv+NdTybnu3KDVzNIl9ZBDI63P8FOT7Z0da21IhOmmcAtJDlOE5pqP8i75UT6XffOK78N6/Px0gm7xggZl7oKh0LsAXpezC4WO5OCVda+dc258MmdOXmGN7+8xfXoOn29RrlaYR9xkGQg4vcGoVdkxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GuQBuNaX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a51481a598so2589015f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 09 Jun 2025 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749483221; x=1750088021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2evMSgmcTfKpLULhAcIQOum0d8EQihiDCpbd2Ef3t8=;
        b=GuQBuNaXuBRfjWxZbnjXxjiN+yIEQJh4w4FWmq6rDlDO8XA7oNrWKFmENzZxxtcCFt
         QhMX+6kKlrCWkdHxCxd5fWYhUPO0bbn3JxvcRSBx/0bmJmfGaf44w1GsQ2TLiEZhOlmC
         DpxvfsCeYUV/F49J0bI8rpoHnAkk/HJ2WA0u3oCX3ZYHFoKbNTmAOq2K32WwImdQUVf3
         L2pLXsDVWa42jFbEoyFNIM2AfyfwMVpe/i+XcpN85VIcRq7QqyG3/OaznCfa1NRDA16p
         0KYGuINm4EHd3KXUcCdB8xQcHiVb+QHKaO3TgFQdXVEcitL6LGP1Tfab2ESSS+FvfVGS
         qeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749483221; x=1750088021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2evMSgmcTfKpLULhAcIQOum0d8EQihiDCpbd2Ef3t8=;
        b=QXVT2a09D31mELdxEJXFL3e8zbY38/PwAmUu/QUzh27cquv2SXMqLVmi0sPVA/F1UQ
         o97h0oSZsifQk6zAruDYzCFrduL8L4UgwJWwljTvTIf0iIGzeh1SwG83sHLWPqstTliF
         /DujIIhMwZTHnaz9DxYcaCtTavP4zHb4dmdsmF2uaO6AbEHK7etfMdqWdrv5W9sahBTs
         gjbtSKYM81p7ByEW7CkMu9SRIyj217f4CPmTtRWXPE/5cFuhrOM9tJKu0hAc5Pn79YDr
         kmtr6JhCCjdeXaY2dzJ3lAFwJ+rSORYlVX8+Ckap0ATgycJua7KOC4Gr24TvlvHiTCBi
         Iygw==
X-Forwarded-Encrypted: i=1; AJvYcCXo0qEEDZ/X0KO4criBlC8njBu+RgXORVBYBXZ+xJ69FRirDxMyCaJaxubXvUNBLwb/r6H9TAm7jmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvDr0noWIgmCZY5Zk0WzkrU0V6WEYODiAfz6U5Uy64UiL6Qwho
	6e0VL9imydeIIHfVH9JOEInktURcWYNRTsCMEPMh2+4J8P5Tk0Pl/8Ss4HDsYV5zl/O7ZfpUT2t
	dnY4S3HY=
X-Gm-Gg: ASbGncuu6xOKa6tZ1uwuoybLE/0yS4oh3OOgc4gVYH6/GPXv7rkvzo0vTnXl0AQXExw
	BgNtALwiZcidE0c8ZnzhnLX/SfEYsfFDNKxGp7Qa0puDiYEYkRCA3bgva/+pupnC0eyC+ML28u0
	Ty4zcGhOIm9HMj0hDf7GZKPXdwUgG6MhRePB/d80nS8dhov73irZw/FH6qbH91zCt3UJGLWOjdF
	5kfBPOtIut9imAY85uYVzjvum5vX+/M+4pX+//xB5o8B1s+fghd+wiUdsACe/TN/qCwGU0DCJjo
	zCAhINOAQsHQIKc1VfSpaO9FDrXYuMbwKIgGBR/WYLDifWgaR1f875yStC1JYOskjrhYXds=
X-Google-Smtp-Source: AGHT+IHBXdZ7nRsdTP/ieOD8Dsk48GSLcaI+CHSrivHzqKwnQ4+fdPwvoxNtjRK48GGMl4ok4emrhw==
X-Received: by 2002:a05:6000:2411:b0:3a4:dfaa:df8d with SMTP id ffacd0b85a97d-3a53168448amr10210931f8f.9.1749483220742;
        Mon, 09 Jun 2025 08:33:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452137277basm115728695e9.32.2025.06.09.08.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:33:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Jun 2025 16:32:41 +0100
Subject: [PATCH 4/4] spi: spi-fsl-dspi: Report FIFO overflows as errors
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-james-nxp-spi-dma-v1-4-2b831e714be2@linaro.org>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
In-Reply-To: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
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
 drivers/spi/spi-fsl-dspi.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index e211e44e977f..75767d756496 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -228,6 +228,7 @@ struct fsl_dspi {
 	const struct fsl_dspi_devtype_data	*devtype_data;
 
 	struct completion			xfer_done;
+	int                                     xfer_status;
 
 	struct fsl_dspi_dma			*dma;
 
@@ -504,12 +505,22 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 
 static void dspi_setup_accel(struct fsl_dspi *dspi);
 
+static bool dspi_is_fifo_overflow(struct fsl_dspi *dspi, u32 spi_sr)
+{
+	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
+		dev_err(&dspi->pdev->dev, "FIFO under/overflow");
+		return true;
+	}
+	return false;
+}
+
 static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
 	int max_words = dspi_dma_max_datawords(dspi);
 	struct device *dev = &dspi->pdev->dev;
 	int ret = 0;
+	u32 spi_sr;
 
 	/*
 	 * dspi->len gets decremented by dspi_pop_tx_pushr in
@@ -531,6 +542,12 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 			dev_err(dev, "DMA transfer failed\n");
 			break;
 		}
+
+		if (spi_controller_is_target(dspi->ctlr)) {
+			regmap_read(dspi->regmap, SPI_SR, &spi_sr);
+			if (dspi_is_fifo_overflow(dspi, spi_sr))
+				return -EIO;
+		}
 	}
 
 	return ret;
@@ -918,6 +935,8 @@ static int dspi_poll(struct fsl_dspi *dspi)
 		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 		regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
+		if (dspi_is_fifo_overflow(dspi, spi_sr))
+			return -EIO;
 		if (spi_sr & SPI_SR_CMDTCF)
 			break;
 	} while (--tries);
@@ -939,8 +958,12 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	if (!(spi_sr & SPI_SR_CMDTCF))
 		return IRQ_NONE;
 
-	if (dspi_rxtx(dspi) == 0)
+	if (dspi_is_fifo_overflow(dspi, spi_sr)) {
+		WRITE_ONCE(dspi->xfer_status, -EIO);
+		complete(&dspi->xfer_done);
+	} else if (dspi_rxtx(dspi) == 0) {
 		complete(&dspi->xfer_done);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1032,13 +1055,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			status = dspi_dma_xfer(dspi);
 		} else {
-			if (dspi->irq)
+			if (dspi->irq) {
+				WRITE_ONCE(dspi->xfer_status, 0);
 				reinit_completion(&dspi->xfer_done);
-
+			}
 			dspi_fifo_write(dspi);
 
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
+				status = READ_ONCE(dspi->xfer_status);
 			} else {
 				do {
 					status = dspi_poll(dspi);

-- 
2.34.1


