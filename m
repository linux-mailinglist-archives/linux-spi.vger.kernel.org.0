Return-Path: <linux-spi+bounces-5714-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 669359CF5F4
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88892B3245F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3721F81A9;
	Fri, 15 Nov 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ldfS99y/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0291F6685
	for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701948; cv=none; b=tV0bMi7jnKtNa7beeSCuIIJ0z5RAkrTWKTu3095SKTuDmqJqzNhKSUNixllJK7lJ8tz5oV1+HOdHI5jZB+OeNOZR3Z4IKAebhxGo81PqE79CbSWPBxLjl4Hj70egJ+I5LlelM6nUQ3mLH8sHrJd+ts1DAihyPwo5JKHr8KwB3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701948; c=relaxed/simple;
	bh=kKFzcQWwxfRZslAvb5mFTNlEqtJH2JETnWxcZJ5iPUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9rgtxvkLwQTdZhoUDqiy+4kJ5IUGbEIaGrDJJThgIEyIAEqTuiBlOrR4eKBCSR153BRMLFm3lV2llC8ovdNeC9sH5hIyoddjDQzBxLXVEUS8pxRfX02M0HX7ckbbAIl3FPGD/10/FXFSSg0FPPn+gyvCsVS7VeD0kGk1u7Z4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ldfS99y/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ee58c5c2e3so541741eaf.2
        for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2024 12:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701945; x=1732306745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vpBdskAj4GrGKxQ9kXlXTxFK22DsgbpucNoSRiceYI=;
        b=ldfS99y/O3tuXbMZdfeFAVfDiYdZh03qVDkjHx40pWUqnTN2+9eBEKghX838Ijcb6t
         4NdJXyV9tO9Sa2PNEa8genbwt24WgxLIGmDxxsHIIsitudHM9UX2GNv3EKHxzPGbhgcc
         zvKwvLeq4nQhYTu4s1CQnfKtCnaT4oVhXlS4X/xGJB1CuoUPUuOjKFtXOxQTdT7A78nM
         +ohjSpB9+SAUf25PvxBeyLA5PkVBqEP3hp3ahBWOFgOVlCRFc2EiEh/LgEL9csUkBMgf
         hRlPHG9rKSp/J09BmDZIYCwg8U0depZPtyirUNFVZrxy+tU5ikoZPu1/c89akTGstSqp
         VXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701945; x=1732306745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vpBdskAj4GrGKxQ9kXlXTxFK22DsgbpucNoSRiceYI=;
        b=QNspUBZxT8OV35fxmOiJeS7QKM4JhcUpMZlDqw28HkmV2mOofqnwwjoPy+0yiaAi4j
         qHKuUwqetjVH5T5vjVk7V6girOuUtKRGNOMdug0sw/5lkpvEfa/rJOKaDG7kDj9AUi0E
         P+8EOSZA5IYWJGxqxggf1jv0TdRwT574n9Of9QpmQiNH71Yy4HEn4HfY7qIRbdE31043
         iSRIfRd3tkw7T74Gghj7NdPzeHcCc/Gd98INZOIj3cCV4e3t7Ndf1Xir0G/8CZbRdvfL
         DroDfMj7L4/D4uD76s4FhT7zIOK1W1RjfbLuNFQbhVTzjDF2zJXh5yTiPTQwAfNszRzc
         BgjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+o43nC3mcYljPbicdg5CXnb0Mx5UInGCpTBonh7J/BebHy9rp5edpwKNEPSZWx2m2Tff/pPh6nZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRJunsdExcq/+WxdjI9SLMHo2nni9AYF5lY7+Xk1Iz1EMZ1iH
	o2gpDY+ofdLdDtlAEb2ncHwDRwwZ4bVfsrLwexePdACmuBwEMWd8W0Dt8KQoOkY=
X-Google-Smtp-Source: AGHT+IEZV3/LjtJ7YJvC8Nl7cg9HoNWJp3fP6XrApsH5OzhF03yxaGbNgop8uGTjsrTSl9FpER7avg==
X-Received: by 2002:a05:6820:260e:b0:5e5:7086:ebe8 with SMTP id 006d021491bc7-5eeab0fbd99mr3753008eaf.0.1731701945295;
        Fri, 15 Nov 2024 12:19:05 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:50 -0600
Subject: [PATCH v5 11/16] iio: adc: ad7944: don't use storagebits for
 sizing
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-11-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Replace use of storagebits with realbits for determining the number of
bytes needed for SPI transfers.

When adding SPI offload support, storagebits will no longer be
guaranteed to be the "best fit" for 16-bit chips so we can no longer
rely on storagebits being the correct size expected by the SPI
framework. Instead, derive the correct size from realbits since it will
always be correct even when SPI offloads are used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: none

v4 changes: new patch in v4
---
 drivers/iio/adc/ad7944.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index a5aea4e9f1a7..6d1202bd55a0 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -98,6 +98,9 @@ struct ad7944_chip_info {
 	const struct iio_chan_spec channels[2];
 };
 
+/* get number of bytes for SPI xfer */
+#define AD7944_SPI_BYTES(scan_type) ((scan_type).realbits > 16 ? 4 : 2)
+
 /*
  * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a specific chip
  * @_name: The name of the chip
@@ -164,7 +167,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 
 	/* Then we can read the data during the acquisition phase */
 	xfers[2].rx_buf = &adc->sample.raw;
-	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[2].len = AD7944_SPI_BYTES(chan->scan_type);
 	xfers[2].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 3);
@@ -193,7 +196,7 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &adc->sample.raw;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type);
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
@@ -228,7 +231,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = adc->chain_mode_buf;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits) * n_chain_dev;
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type) * n_chain_dev;
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
@@ -274,12 +277,12 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 		return ret;
 
 	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
-		if (chan->scan_type.storagebits > 16)
+		if (chan->scan_type.realbits > 16)
 			*val = ((u32 *)adc->chain_mode_buf)[chan->scan_index];
 		else
 			*val = ((u16 *)adc->chain_mode_buf)[chan->scan_index];
 	} else {
-		if (chan->scan_type.storagebits > 16)
+		if (chan->scan_type.realbits > 16)
 			*val = adc->sample.raw.u32;
 		else
 			*val = adc->sample.raw.u16;
@@ -409,8 +412,7 @@ static int ad7944_chain_mode_alloc(struct device *dev,
 	/* 1 word for each voltage channel + aligned u64 for timestamp */
 
 	chain_mode_buf_size = ALIGN(n_chain_dev *
-		BITS_TO_BYTES(chan[0].scan_type.storagebits), sizeof(u64))
-		+ sizeof(u64);
+		AD7944_SPI_BYTES(chan[0].scan_type), sizeof(u64)) + sizeof(u64);
 	buf = devm_kzalloc(dev, chain_mode_buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;

-- 
2.43.0


