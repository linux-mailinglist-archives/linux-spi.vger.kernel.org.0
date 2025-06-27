Return-Path: <linux-spi+bounces-8801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345EBAEB494
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1C2642A1D
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C00E298CB3;
	Fri, 27 Jun 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjKZu+m0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFE2989B1
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019737; cv=none; b=A5SnyGNLwJV+lQhg3oIU4W1vRqamO7SlVWNMClswhr2aqt5OpUhPlhVjH+K0vOeRHAeWLwskLdkZivCBa+Msv82lf4VDRJlA0uOQn9NnAzAQVyIz+K+Z4Sbc/a/h3oEMljfbvvgm+9BYSGZYjqPZiBZu9w1xf6mseYY4EyDQT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019737; c=relaxed/simple;
	bh=tDElKRBLK/qNKu5SjxAXb85BKJ6QoLktzarB0QqasrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flUYh5qq9oz2jrb0wEL64PjMBXeZcoX+CDTkAr6ecAqfCIis9RjDhyTun6qVIv2HXPK++EHBok9c+4Z3m8SSt05lCOpZCyFio9T0JEELa9pFuWAnGP/s3BmQQBjtMJIo+fGq3T1cJdwBRum0VUvHKW/n09vmBL+/00YJS1cNfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BjKZu+m0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1224241f8f.2
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751019734; x=1751624534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwlNaAwBOfLtistkNFy2ROGaDKhEVpmQrgosAfN44tc=;
        b=BjKZu+m0LiUjWSgI9BmefKEZj3TO/kLPB758BZwrZ/3r3709psLuiwnfqnn7CHXCxq
         unylcrfVsaPot3pqCdc/qbM6xWqhqEb7CHMyfqomkn2dg37If8dBI2cC6kkqcO2do6UJ
         ZFFsfQ7Eb11q0S0wv2UtQ8NFWFSojbF+udmZon/cMmQS9ah/dxM57+DoKs/qbB3W1JM8
         h3jhkifqZWDPIeSSlnP924qQ86A177v4rXGf9SKxWCDEyq5W8Bk44luz9fADqlYD5XEM
         A0O0sj4Wg3EMLMI/VBpV0X6wPiBaMsG7XST6BVmuTr8CRn3ocqZrlR8vuIzDu86JbAYk
         IOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019734; x=1751624534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwlNaAwBOfLtistkNFy2ROGaDKhEVpmQrgosAfN44tc=;
        b=P6tQDbchxoy2xiHmjKfkUZjlChXov/tpwXSQEvUuys2YWFnPrnOKasMEF8KnLvtSeD
         Qgb29MXLkt6Ee+AekZs0aZZnaNHadheHZ9mLqB2jCAGzKCPcEoSp2ATdXNUtjngxzYp5
         ZYWhB6JwQvxwyAZ+HO/2xQTvKGmshfDYEoFdVScNnTXEyiHilukov7xY79vNoa44uouC
         Z7XLhyFniD3x+PTOYHTKAaD+lu3D3lSuv6cSjXweeybrjInqlh2f21qWeYaIHHuZjk9D
         g6UAsaoXx069i9lleyYZdaxsWxklD8U3IOzT5gWf4X0eeh/Z+7V4MNnaENCuBB7pZl96
         VSnA==
X-Gm-Message-State: AOJu0Yzz+e4DBqNdP+azDm+Z+RNv+oT3z+k2pAupbikeu70KGUtPlLtR
	LDc0EMM/9SDfQov52sSCLpY/QOpJR9K7enhtIaLVBDV8/qMjwkgcl9y2xp2LpUbwxNQ=
X-Gm-Gg: ASbGncu1nddhtGc5Yps5qif9U62fLvUzv011wworanHErDD/WATGQCuGOZlPNmctT6E
	cybRzi7FyVq1Fdl6py/otvhqroNEB3dPQJu3y8CfKdxAhT+6wv8f4TouLspXsGWJdfeKgCEsDiH
	r/Q9MvhysIwuokn5CgGLmX6j7kl3+0t5uhhs0tqmcEOxWToH+vCTWORozUjlJhiBZwU8BakFNsX
	SbhLGj3ZmVVSpjBe2SKGXmsEcKv4Fr1eYHhDC1aPP7ZBtMHfAaJfcuGGGVZ+PFUi1gH8eDEzvnh
	12r77ZBFcwJ+NEwsyS0ul9Km85ZF1Y4oWC9kdpZD89wbTiFKioPm6NmJIR2TUPLjsh+rzUo=
X-Google-Smtp-Source: AGHT+IHTsdKq6puWRpwlj/VM3TSQdnueqR9QrLPQyNLzpjBixFVOdE5jwKmG5jakQu4jPPketOSLPw==
X-Received: by 2002:a05:6000:25ca:b0:3a4:ddd6:427f with SMTP id ffacd0b85a97d-3a8ff51fab7mr2718088f8f.35.1751019734307;
        Fri, 27 Jun 2025 03:22:14 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5599sm47250955e9.13.2025.06.27.03.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:22:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 27 Jun 2025 11:21:41 +0100
Subject: [PATCH v4 5/6] spi: spi-fsl-dspi: Increase DMA buffer size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-james-nxp-spi-dma-v4-5-178dba20c120@linaro.org>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
In-Reply-To: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
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
index e7856f9c9440..46d3cae9efed 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -493,6 +493,39 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
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
 static int dspi_dma_transfer_size(struct fsl_dspi *dspi)
 {
 	return dspi->words_in_flight * DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -608,6 +641,7 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
+	int max_words = dspi_dma_max_datawords(dspi);
 	struct device *dev = &dspi->pdev->dev;
 
 	/*
@@ -619,8 +653,8 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
 		dspi_setup_accel(dspi);
 
 		dspi->words_in_flight = dspi->len / dspi->oper_word_size;
-		if (dspi->words_in_flight > dspi->devtype_data->fifo_size)
-			dspi->words_in_flight = dspi->devtype_data->fifo_size;
+		if (dspi->words_in_flight > max_words)
+			dspi->words_in_flight = max_words;
 
 		message->actual_length += dspi->words_in_flight *
 					  dspi->oper_word_size;
@@ -635,7 +669,7 @@ static void dspi_dma_xfer(struct fsl_dspi *dspi)
 
 static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 {
-	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
+	int dma_bufsize = dspi_dma_bufsize(dspi);
 	struct device *dev = &dspi->pdev->dev;
 	struct dma_slave_config cfg;
 	struct fsl_dspi_dma *dma;
@@ -719,7 +753,7 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
 
 static void dspi_release_dma(struct fsl_dspi *dspi)
 {
-	int dma_bufsize = dspi->devtype_data->fifo_size * 2;
+	int dma_bufsize = dspi_dma_bufsize(dspi);
 	struct fsl_dspi_dma *dma = dspi->dma;
 
 	if (!dma)

-- 
2.34.1


