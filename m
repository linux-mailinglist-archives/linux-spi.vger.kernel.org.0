Return-Path: <linux-spi+bounces-770-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25D483C58D
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C141F2108C
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09585C6F;
	Thu, 25 Jan 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHkHVRvV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29C6EB54
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194227; cv=none; b=R+zWnYU/dXUp5omm9iLd8FRf10cYPjZxHJMlswZ07bB88Kc8mu7saa7x5edARvvKm4x3sRIgMVWwbirAANZyesKATgKEHdsRjyOCZRgl6aV2m71lshcy06Ire0tlFUIAxf9exH3iLOQaHaP3Ma3FU18YnMTpXv8xrozoklwqdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194227; c=relaxed/simple;
	bh=hXVQ0xlIaveU3XkFuaJGe+I4uTpyEmgE+f4FfHSp1qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQeESNWw1U0WmsuH5yzXrThH1rQ2UFsYL/5sIhz06dN0aYL49Xu9NQzo0yMwyA/6Y43ik6CDnc1mv+BFMzhF7wIuG/e1W4OSqM4aplI5W/iHuAo49HjmD6LHk00Ov2bbCsCvlbp1kpufRLTE60phNFuExDbn9f3cbpGFF60OJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHkHVRvV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e76626170so75552195e9.2
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 06:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194223; x=1706799023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwSZ9ii64mt7cJNVg0lI8ru0eSDBGUd0YlY2mDEiodU=;
        b=rHkHVRvVsq/fC5NwydsH3ES17+/nzhdUHaLe+oOTHj5w0PmXxcNR8wWQoJeh7MIDZ5
         hA/9qXxG78lTObSK3IaxMWsI2ExH6gXe9QagmA3o6znxab8Rw8onBngLEBEnykfLoivO
         vGvnDuKXH4xW3nQX+yhx1OVKPlCUe6Kwr8gWkDCaEyyHdeFwbBrkvvIBvbGgqWuS4cRi
         tM4h2JNKBVxPMJLSbfAHxAJNDolHMVg8t1DzOLfZT0SRb+Wyt2i/+FdpptNst5eP/emG
         +fC3KEHQ3mBYnYw0PJCmAmtN2HoUZCG3ayZzq5T7Z/yr4Zs0aE7sWA4rPRtJf83GqbcL
         8Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194223; x=1706799023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwSZ9ii64mt7cJNVg0lI8ru0eSDBGUd0YlY2mDEiodU=;
        b=KtMxTzsDIhsbpOgdyW3fH/fE/qpVUjg2sHxxlXbCU0RP+NueSpx72PaiOZoHDPOW3O
         jLP4tRQSLXAVMT/T3y/xxwb9bcUy0xW1aQXj6wygSzYcUKh0I3ZvSbr+YLChXFxbK43n
         xffxxjkbGgqIyXcu/LPhrQN0m1uVGaOqOmkpWvcPY9cN2xhPq+kB0/yRS5R8gkvKXg/v
         4LjHHB8U8+0LLz1tK7YUjEuAMV3xwi4h3+r7rd0Uc2jbHTl9BFDW+EbUZBXYVWdnk4El
         Y1TpwkHAQ7wlPTLqNK5sbdJIElQsBBeQro9/m8RYoUtbchSqa/UobX5VMgfCsGLrbnr/
         ziNw==
X-Gm-Message-State: AOJu0Yw+mVqPhQJFgcaaRcGYvxkP0LnJ4NdmbpIcMaau3t2pq2NrDr6m
	iK0aanPqJ5HhQWPSzKcAHnY13cQKwt0JGEvF8DRQ1WIEUfDZ2lP/nQFCoasxOHw=
X-Google-Smtp-Source: AGHT+IHU3uE9VctkwSLc7sy1ouZi/e0ls1mgPCFV1inwCVVGb/ieTXa3QkXnQoUQMDecFLIT7pf3+w==
X-Received: by 2002:a05:600c:458b:b0:40e:af93:54f1 with SMTP id r11-20020a05600c458b00b0040eaf9354f1mr697668wmo.5.1706194223137;
        Thu, 25 Jan 2024 06:50:23 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:22 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 14/28] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
Date: Thu, 25 Jan 2024 14:49:52 +0000
Message-ID: <20240125145007.748295-15-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't monopolize the name. Prepend the driver prefix to the function
name.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 25d642f99278..447320788697 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -273,8 +273,8 @@ static void s3c64xx_spi_dmacb(void *data)
 	spin_unlock_irqrestore(&sdd->lock, flags);
 }
 
-static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
-			struct sg_table *sgt)
+static int s3c64xx_prepare_dma(struct s3c64xx_spi_dma_data *dma,
+			       struct sg_table *sgt)
 {
 	struct s3c64xx_spi_driver_data *sdd;
 	struct dma_slave_config config;
@@ -440,7 +440,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 		chcfg |= S3C64XX_SPI_CH_TXCH_ON;
 		if (dma_mode) {
 			modecfg |= S3C64XX_SPI_MODE_TXDMA_ON;
-			ret = prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->tx_dma, &xfer->tx_sg);
 		} else {
 			switch (sdd->cur_bpw) {
 			case 32:
@@ -472,7 +472,7 @@ static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
 			writel(((xfer->len * 8 / sdd->cur_bpw) & 0xffff)
 					| S3C64XX_SPI_PACKET_CNT_EN,
 					regs + S3C64XX_SPI_PACKET_CNT);
-			ret = prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
+			ret = s3c64xx_prepare_dma(&sdd->rx_dma, &xfer->rx_sg);
 		}
 	}
 
-- 
2.43.0.429.g432eaa2c6b-goog


