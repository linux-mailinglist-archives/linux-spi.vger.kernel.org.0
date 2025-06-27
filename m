Return-Path: <linux-spi+bounces-8803-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B7AEB483
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659227AF7E2
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937E2D3EDF;
	Fri, 27 Jun 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTubgysl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F3299943
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019738; cv=none; b=CiMqBEFRe03FPKyQhG7CPP5HeEs+eSjlMpJTpSJpOfkjytQRtvbJAKBS3tZ5ufMDh7MNL8qnPfvZaovpe/DhSjnPdCsyqNMc2oZOoZn7z1c3nibHG90poV1JjP3zWbhhJ6YsUrmO2d19j9xeSKXC+y1SmwWtMqFXJS9hCONRXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019738; c=relaxed/simple;
	bh=W5RB8ofdrCpDCxp+XelolJjRKHlOwBuWzYdhjuY+18A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTIyGF/2XvfoUpGWtJ0s/Um9L4sAulZGCNFNgpjO+VhLg8/BYmepEijtn58NjArBD0PxfyS8sMy+1gPhKixnoYLYM4wEXvjIisEzG+ffAckKWceW9/hMHfT7QMTbwWvunTs6tqQZyN1yjvjrpSJgbSGYGgtoLcPNl+BjQ2iPxx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTubgysl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45377776935so21255465e9.3
        for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751019732; x=1751624532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1FhM4WVr7ZEX7RFMvmUpdlE0FbKvEgU2ax6ATn6XZY=;
        b=kTubgyslG8YTj8izLLDgl5CWuMoDOxDfur6QV6TfLEi0F9G+J7oMCdTDNHTvQt1m+Q
         dVEI8Yi03bnlsQJNve0bkXwlxjaq13dEpE2khBN91F5a1M06xvYNi/HMTdGOue3Lih1d
         /M041DSg2G4/GlvlOUMPMu/X8MqvA6Bpt9cBoY7n1XYGb660+W1MWXXZ0JM+FgBbl9AK
         UBDc3v1QGp+s/w/OlG3a7q26wMErlrg7v++ox0KHtsQcMDjr01dC5lPS2VPS9A+OdU2c
         l5Ijy2KlGhK5ZmdPFs/uy6AknoK2szcmHgFSaOg5hv2gsJbqe0XQGyfuh0GsKAqN5P9W
         IlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019732; x=1751624532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1FhM4WVr7ZEX7RFMvmUpdlE0FbKvEgU2ax6ATn6XZY=;
        b=td6V5cStGjOGe+lSp3ROgQbmzT2UdFPvPDyRlqYDCDkJF2TWD6WPzpKAZ7sx/7QdKi
         tT+CQB0i0sSMIOOcq30S2bil50/Gybaev9cbCm0KvNVgRBpspibh1TrRJ8fC1QNMY87e
         X8GltMzDH5ljUf7O4bYHkk8Uhsw/k8Qm5+LNtwxT+xbavB/zmxgMTO2qcKVz1t7clN3y
         9CoROm9FwT0XhqV4Oh9ZBjSN8hWM0lrkaJSerUh32baXERpv31jlySe49+tXxXRH8MuB
         Bs3ITz4bNUu2TpxG/zBmc7WmbSLLbtKzvmZuLp8Pe2+bXlN59KDuuux2KbDm3TGv1G+t
         OIBg==
X-Gm-Message-State: AOJu0YyBCA3U/UabuV+AKVP7jnGPGVr5cfM7cpE/lbK88j/l7RMW4Bzh
	yYXuRsk7vpli8l1cgoXoZkVYBJOjR38S9ksG3Z3fT3l6KUR5oiwDEe6Hk+UKXKh9rDM=
X-Gm-Gg: ASbGnct8w5YWaJbGmKciayvwBuqbc3KcVbX2pK7TbwWk6nUy3pocYaFc4cCw+iDP7lk
	2Nlr2WW4f7VtLS2OvhATJ3zwN0WBwuRJ+aVEVTGYjZV5I7ym3QFkIHe4z7X6XHiq4HOJZar+zL6
	FlWy0PxrcbQ4Ve8g/X5RsAb6Xysc2Ryv2d/tXjlX4tt8htp3HX+nYsEVaF+9x+qSEE6R5cb2pN4
	po/ZgZeEMQH+t8S9fbs4+DWs1BrnRpTKr7l55gKTrteMSl0lFhAy3f/V9mm/RjOBSsfYxOunv2m
	95YMQyMu9VZKX8HxB6PRXq0WGpzwz9eJ9M3Q2JLDkygLZgkf++jNthC4sRY60COj2nldyBU=
X-Google-Smtp-Source: AGHT+IHlOyXervQn+haGiBOZ0vl0FJLTAGumJfi3y5HJSPxa1Q9XBHEO6HL8VaKj5iB0Ic1H05DlqQ==
X-Received: by 2002:a05:600c:608a:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4538ee4f7c2mr28086715e9.7.1751019732480;
        Fri, 27 Jun 2025 03:22:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5599sm47250955e9.13.2025.06.27.03.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:22:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 27 Jun 2025 11:21:39 +0100
Subject: [PATCH v4 3/6] spi: spi-fsl-dspi: Stub out DMA functions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-james-nxp-spi-dma-v4-3-178dba20c120@linaro.org>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
In-Reply-To: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>, 
 Christoph Hellwig <hch@lst.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This will allow the build to succeed with !CONFIG_HAS_DMA, either due to
a randconfig build test or when the target only uses one of the non-DMA
transfer modes which this driver supports.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 65567745fe9a..feff475dddfc 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -373,6 +373,8 @@ struct fsl_dspi {
 	void (*dev_to_host)(struct fsl_dspi *dspi, u32 rxdata);
 };
 
+static void dspi_setup_accel(struct fsl_dspi *dspi);
+
 static bool is_s32g_dspi(struct fsl_dspi *data)
 {
 	return data->devtype_data == &devtype_data[S32G] ||
@@ -468,6 +470,16 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 	return txdata;
 }
 
+/* Push one word to the RX buffer from the POPR register (RX FIFO) */
+static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
+{
+	if (!dspi->rx)
+		return;
+	dspi->dev_to_host(dspi, rxdata);
+}
+
+#if IS_ENABLED(CONFIG_DMA_ENGINE)
+
 /* Prepare one TX FIFO entry (txdata plus cmd) */
 static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
@@ -481,14 +493,6 @@ static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 	return cmd << 16 | data;
 }
 
-/* Push one word to the RX buffer from the POPR register (RX FIFO) */
-static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
-{
-	if (!dspi->rx)
-		return;
-	dspi->dev_to_host(dspi, rxdata);
-}
-
 static void dspi_tx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
@@ -589,8 +593,6 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	return 0;
 }
 
-static void dspi_setup_accel(struct fsl_dspi *dspi);
-
 static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
@@ -722,6 +724,18 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 		dma_release_channel(dma->chan_rx);
 	}
 }
+#else
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
+{
+	dspi->cur_msg->status = -EINVAL;
+}
+static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
+{
+	dev_err(&dspi->pdev->dev, "DMA support not enabled in kernel\n");
+	return -EINVAL;
+}
+static void dspi_release_dma(struct fsl_dspi *dspi) {}
+#endif
 
 static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 			   unsigned long clkrate, bool mtf_enabled)

-- 
2.34.1


