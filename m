Return-Path: <linux-spi+bounces-8492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD1AD87D0
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D207718963D9
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3F2C15AC;
	Fri, 13 Jun 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD47HNMZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93985291C33
	for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806968; cv=none; b=MeOAfkZQFPoXjudIGZCrcriYLD8242kONknfiFF04pe9Kre1n+f6lz6XeBBNJ+13MDdlyhmOdAr68bt/+PIjzzBOsiJ0KXT+v7WJa83Tc+Nar9BTCO6dccCgUYWfsze24mKK494fs6rP0Rw/w2dZg5koHZ7Bc/1uSoeYdiBSqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806968; c=relaxed/simple;
	bh=CVwoRk0GER0LYrtRwOuy/VUCpYDZks7f+rhuuxXoALQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbKTRv0oToV4U8NRKIAIgPSYOo5hwjT1r2g0mDnu7foTuef87Mea6bp0umskfd+V52uw54I2FJUyNBeO0dDI9zN5p3Hjj7rF94UIdUrxfPf8BhIv2/gkzrg6o+c7eeKHcaT60DWWIP2CAvjbmJwvd21mGJou2tYYaO6ek5NN7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hD47HNMZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d7b50815so15729065e9.2
        for <linux-spi@vger.kernel.org>; Fri, 13 Jun 2025 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749806965; x=1750411765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yB3v1heJMNnrfSWRvq2YsjasUe3fnLxNvvV0vI7w6w=;
        b=hD47HNMZMaNQ2f8OGo5ht2gCb1T3fnG76ZVYWxIYiS9BXZ4RpzTz4/U214W3EXQMQ4
         FLE54/SH3hfbs+sckcucL8EUz//slSPPIZ23JaAg/kvBYpiz3xYnyjAb/2GrOOoiRQZZ
         237febwrH0SGxPRLkBwwkzVLF4JL/VMFEOSZZhZxSibcTeSFzU4spwWHNM9ljQ2RKS3Y
         IDHBZUnLFKg0KKkTGnbaVcZ/h/mmFxSiS72zCMqbaeQYks/GgiFsGtIwuI+41OAlnH/g
         qUs2QsYSXuRDm9YAFLwTyzyqDwtADZB/23pvHQm3/N6Q2/KYTVkqJ3VLqVd+2IMuoWjE
         Wt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806965; x=1750411765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yB3v1heJMNnrfSWRvq2YsjasUe3fnLxNvvV0vI7w6w=;
        b=X3YXr4Sy4fx9mCsGmAmZPlf4Bl97z0B5Gt3LPyRgXVKbsrV9tmQ6YcF0vDeqGBspGq
         m812m8yLdApppXjPgyKDXHDwUbYLiilvo60UhtU9l94tTEUCBx9MQKm0EcueFcjM/arv
         IuGu13foveyZY6tK8ETrMLIGtmKtCrm8IvN2o2IpdlQvD7dPYNdZ8J4iBnQFsOpkKE6Z
         p6zzbV4tHqDrg8MDYjQftl+q6n2qSv8MjF76ML4zraRCSktyr0103HJ3323DnN55XUmm
         OVVgEa5wZHQ6Ibc0nLnJWgk+RMy/0epXdI8Tx29pIDPXkoVsgjy3Zbvc5loWITLBIkIg
         HYMA==
X-Forwarded-Encrypted: i=1; AJvYcCUUCtvg4IPPJw8u22Jr+dYkoh+agyfMfRHo/uF2DK8xoyHTaNAX1LTvH9XedYDJziR50KLT7R5Wmmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9XBd4LSp+Y9G5xhV2++azXn+I1FwVmpuKpywy8VhM715bInG
	41Hkq80yjepMCrT795n5Xy7AnEXkJP6VoK5zHZLRThPXMfHx9FfKxi4QmHbV3vMeHG1NZCmbypj
	wSRz2
X-Gm-Gg: ASbGncumGb1mGgR536+m0gyBjtC5KHg0FKro3SR8gRAP13u5CVc5ZdJePF2ic//H4pW
	ag3aiSnbwxCiPJyyZMp/lcmCBO+U3mPTXVWNdOp7MDgd32JVsuMykYUyzKDtzCRcofGvWS1fUR9
	TLzVeMf6yEmFLRWPcI08No2AnNB2TuYuwXh14VY0xR5QPANVOa9yJB+Nbf8afSAst4tZLE8hhGc
	6B0f9exAMkKjmT5tXnIQh9xkU0b+FM+Whx/oEv8xDUGQ7VgXmLRgVKu976OA0yFQKwpDu1DbDaL
	hQ9gXmaRmk2uwNnIggPmVDGSWK1vYNf8wrwoNUK0WaL95VE4kLEnd81i7NwEwAaJni9Kpt4=
X-Google-Smtp-Source: AGHT+IHVoRas9OADbI1CexwPchRHvmKk79BDFD51FrhgWuPNDtOHfG14Xc4l+6ijC1aURbgK4Ow2vA==
X-Received: by 2002:a05:6000:310d:b0:3a4:f6bc:d6f1 with SMTP id ffacd0b85a97d-3a56866f804mr2073879f8f.14.1749806964790;
        Fri, 13 Jun 2025 02:29:24 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08a2bsm1805946f8f.62.2025.06.13.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:29:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 13 Jun 2025 10:28:58 +0100
Subject: [PATCH v2 3/5] spi: spi-fsl-dspi: Increase DMA buffer size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-james-nxp-spi-dma-v2-3-017eecf24aab@linaro.org>
References: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
In-Reply-To: <20250613-james-nxp-spi-dma-v2-0-017eecf24aab@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>, 
 Frank Li <Frank.li@nxp.com>, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

When the device is configured as a target, the host won't stop sending
data while we're draining the buffer which leads to FIFO underflows
and corruption.

Increase the DMA buffer size to the maximum words that edma can
transfer once to reduce the chance of this happening.

While we're here, also change the buffer size for host mode back to a
page as it was before commit a957499bd437 ("spi: spi-fsl-dspi: Fix
bits-per-word acceleration in DMA mode"). dma_alloc_noncoherent()
allocations are backed by a full page anyway, so we might as well use it
all.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f19404e10c92..48c2ebefcd4a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -384,6 +384,39 @@ static int dspi_dma_transfer_size(struct fsl_dspi *dspi)
 	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
 }
 
+static int dspi_dma_bufsize(struct fsl_dspi *dspi)
+{
+	if (spi_controller_is_target(dspi->ctlr)) {
+		/*
+		 * In target mode we have to be ready to receive the maximum
+		 * that can possibly be transferred at once by EDMA without any
+		 * FIFO underflows. This is CITER * SSIZE, where SSIZE is a max
+		 * of 4 when transferring to a peripheral.
+		 */
+		return GENMASK(14, 0) * DMA_SLAVE_BUSWIDTH_4_BYTES;
+	}
+
+	return PAGE_SIZE;
+}
+
+static int dspi_dma_max_datawords(struct fsl_dspi *dspi)
+{
+	/*
+	 * Transfers look like this so we always use a full DMA word regardless
+	 * of SPI word size:
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
+	return dspi_dma_bufsize(dspi) / DMA_SLAVE_BUSWIDTH_4_BYTES;
+}
+
 static void dspi_native_host_to_dev(struct fsl_dspi *dspi, u32 *txdata)
 {
 	switch (dspi->oper_word_size) {
@@ -606,6 +639,7 @@ static void dspi_setup_accel(struct fsl_dspi *dspi);
 static int dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
+	int max_words = dspi_dma_max_datawords(dspi);
 	struct device *dev = &dspi->pdev->dev;
 	int ret = 0;
 
@@ -618,8 +652,8 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 		dspi_setup_accel(dspi);
 
 		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
-		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
-			dspi->words_in_flight = dspi->devtype_data->fifo_size;
+		if (dspi->words_in_flight > max_words)
+			dspi->words_in_flight = max_words;
 
 		message->actual_length += dspi->words_in_flight *
 					  dspi->oper_word_size;
@@ -636,7 +670,7 @@ static int dspi_dma_xfer(struct fsl_dspi *dspi)
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
-	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
+	int dma_bufsize = dspi_dma_bufsize(dspi);
 	struct device *dev = &dspi->pdev->dev;
 	struct dma_slave_config cfg;
 	struct fsl_dspi_dma *dma;
@@ -720,7 +754,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
-	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
+	int dma_bufsize = dspi_dma_bufsize(dspi);
 	struct fsl_dspi_dma *dma = dspi->dma;
 
 	if (!dma)

-- 
2.34.1


