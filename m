Return-Path: <linux-spi+bounces-8734-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A937AE6296
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 12:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8274D16C2B9
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292CB286430;
	Tue, 24 Jun 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDTxW/Gx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89E2868B2
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761400; cv=none; b=rGTV1ldq/yFYX2+ruh93LaQrKfwvospSHsVliVgGZuLdssmvl//T8O5R/dpRviokrd88lf9AfWvlpnAGX7sCrQAeWlYDKGeQZ3W/5RUKuh3BP69JxJ5t4xi5wszBXlCXW3Yeoh7SLlTkS0lXSPyt/GzUwLN7VsnuQ2oa0P3hnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761400; c=relaxed/simple;
	bh=Bc44HUdFlRBGiPqYEyrxvW7lVxJh2JmM3ACL/8dmNuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZL85b/5z0+tYEQktiQLeafdiey9UPPV6BhydbTywNn2ZYmeXnJfrndx3czi2gJFg5zQNbIqTrX4FprpVFTQ3fD5dCwV25/glBtILSJmIFeqgslLAdmsVNGIoQZX7Ev6quCW7/SDHlirtC4Vg/YdeZchrHFd4ld+nOCIpqsZlGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDTxW/Gx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so489331f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750761396; x=1751366196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhsIPhnxdKWsYdEi1ghU1/oHIl+/WH0rhmItuuKdl/c=;
        b=YDTxW/GxFlm0tc2AxD5vfwRv9j5j5dPxiSQ5zDPcyise2tpybDIHA2MT/n4nsp3Kq1
         1NfuSehPNv9XOys9YMgaCWi6VIKr+UYyN8BlMIEbqa1DX7EVSOLkIr4zxeXQyMPu0VKM
         e3n98GcfgQ+1/h3sA2B9XecEoDK4Pzn5osbbk7hB2rzrbmbkHEFPpZXmCK8Z98jujYRI
         bkuIC/De5ISslZBWTK7JVYhcJtmaPSGV/69lb266JHFLrNIuq4o9t3+ArxHeUUxj8oU+
         KZU0eRNrw2rE51trYhL3Jv3kvutLUtyaw5gDbbw6Og18clJ8iqTt3xd/SGwa6ztNOM/0
         HQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761396; x=1751366196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhsIPhnxdKWsYdEi1ghU1/oHIl+/WH0rhmItuuKdl/c=;
        b=Lq7vzeoYeYPNbLUw4v/zDrQeAtrr9hsDkjqiAUfJrJhoGxsSO5upNk4dc6WPaHhXv2
         r0WsBH5oELXJbVHO7sGoSA/f3f6XmpqXMeu9i8+OdA7j5akfGWaoKr/NQrH/8AlA2fla
         zSQYlFE4je/kyG9Kc7yv64BDGscsNcaQeAuB5xT5Vumwodzf9JGsH2KhNouQB6y2lQRI
         jlfuHPuyHh5MFvqpKP50/WJGmKBxVoPExhAHhAqfMXMH+I8mvPPukBDqkpwviqEBbpj8
         zh0VadvDFxzOunDDlvTmSJ/JdpejNo6oYzIzWi02LIGuHZtnT4F1f7SO6HtFEmxmMPDJ
         oAkw==
X-Gm-Message-State: AOJu0Ywsrmnl7f3QD6Rf4pnR4SGHGVYgSvXO6Kv4Xe6IIDxRqCTjElTh
	/bSreiXUQnk4uGrWVj9Ub/YUP571kJg75DZt6OoSOWkaECdXX43iN4hc7lUgP861Zdo=
X-Gm-Gg: ASbGncuclQwCMN5ziINdy1KWVIPj1L8HG3zWfWV7zcbWBmDcph6sVb4kHAk0o/g/Olj
	1JCApQvcwSPH7b/FwXs1qeeOprAhnMOhBn2tn/c2/OjiKeaHz10+PFIeNGHSFJJFdObYvwIRDM5
	mwOGrhL+WPgnm8a3ONQtG0szi2JiJEbwDArSLvO8bRFPov2lo0014CT0OzhSjUZIJV4iqcO+ddB
	4chPg+dcxDX499jeECE+mgUv1ijY6OqjdUyXn/e/NcOHW+6oFjKIzyP4FZpxv+3czo4Iev/m1lj
	aX+caqY7PE5OAJbVSH1PMHaUu7gTmDlJPE0SJS+YchjJHhxDk6LraaV8PXU9sGJwc8MeS6s=
X-Google-Smtp-Source: AGHT+IGwIII2547BzKkspjqdAo45Jmh+wiE9tjt9HqPdqBs9RgITkmkDb4pqs/WiMRYtkkZacJt/KQ==
X-Received: by 2002:a05:6000:178a:b0:39c:30cd:352c with SMTP id ffacd0b85a97d-3a6d12c43e6mr12087710f8f.8.1750761396110;
        Tue, 24 Jun 2025 03:36:36 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb641sm143398245e9.3.2025.06.24.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 03:36:35 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 24 Jun 2025 11:35:33 +0100
Subject: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
In-Reply-To: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
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
 drivers/spi/spi-fsl-dspi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index feb29bb92a77..8212c4193536 100644
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
@@ -489,6 +491,7 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	dspi->dev_to_host(dspi, rxdata);
 }
 
+#if IS_ENABLED(CONFIG_HAS_DMA)
 static void dspi_tx_dma_callback(void *arg)
 {
 	struct fsl_dspi *dspi = arg;
@@ -589,8 +592,6 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	return 0;
 }
 
-static void dspi_setup_accel(struct fsl_dspi *dspi);
-
 static void dspi_dma_xfer(struct fsl_dspi *dspi)
 {
 	struct spi_message *message = dspi->cur_msg;
@@ -722,6 +723,18 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 		dma_release_channel(dma->chan_rx);
 	}
 }
+#else
+static void dspi_dma_xfer(struct fsl_dspi *dspi)
+{
+	sdpi->cur_msg->status = -EINVAL;
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


