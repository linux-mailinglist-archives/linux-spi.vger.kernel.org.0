Return-Path: <linux-spi+bounces-6029-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147979ED7BD
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 21:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82400283A77
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 20:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E623694E;
	Wed, 11 Dec 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0nOqMb6P"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E322A7FA
	for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950516; cv=none; b=LvaUeBKb5dJBnyo56btDmqnEUmcHcqePFLNdnwU4PqVAt6XQETxekspgZm+hs88tXSkAMaWOQabel+C32QUkAMpyW6m3G3vSArI2iZSJhSnqBmKa+KbcdoZYEo9JZbvL6uOloQqqjazoJA+fM8sKSVr+kuOmXD1Rmlq57RUdKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950516; c=relaxed/simple;
	bh=RXtN+ZlXyzAwOezAfCb6pGRZWfRx3OQsYBS7+p6Pau8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKBkwZ+8Mpq8YoBlxlDL2ozjpRD2mC1i3hsPpBFrVN6HjMNRDAtYBDQ+meGmclWKX1WFeayj8PsBlbpq44LDiWE0KJCh8QupLY6eXLagbxkDfLrlGMK41/t67aSfpS8Fi0xdvSwmkmnHUD2s0Aj3QZqbfoxnIpLXSCqIyR7pdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0nOqMb6P; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71de8527314so2000944a34.1
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 12:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950514; x=1734555314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/mtqzUHCDOIOGk+UzABFLtCD4LD723lD2d5BkSVSB4=;
        b=0nOqMb6Pa0ygC8Bk/TLu2ucX7cUmT9DnAn0HsHYMxDfL+KfC7HcUxfP9/0zGyX7uMh
         0JNlf1KquKkoBSdap6GNUBYepwx2R6++VvbjkdvIevNDlE4zVAQj98XSZvCSaElQPzAr
         Cc0WBCHmvzNEWLzkjW4UguBgJVG9TAYk2CzNbvV8zn7D+DnSaRPglDKCX6KR/Ph7x7Km
         jd4wnOIVB/dH4o1itzVwRlZtoOfRMDpzdwPxpc3xzfiBz/Ere0672n9tyuae9dTo1ORJ
         +LCp+EUI4/nZifATCnojWBnsIhP9C9ngVnNCRMpgK+lXn7yMjh67VJ1H0ZdbsmtJirvc
         QzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950514; x=1734555314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/mtqzUHCDOIOGk+UzABFLtCD4LD723lD2d5BkSVSB4=;
        b=KZe6rVPWrpR4X4rBEiHJscDROPhxKj2j0qMNyNgyoH8eEM7fqVGdjRThUqW74FckOG
         eOCgb7hcg1wpdLoMT8LrhckcvOc2DMrMEKpX02AOQR7kR/3wd/zNb4F2yELwwa1s3Oz/
         Xik6KHFLSCBzbPxDqJOwl/AjUfG28jy6bdlCs6Ki8qyPGhM9ca0vZgHo9jsbGjZ3CpPI
         1iuDhe7q7jRzx2zzNCupuiuCedE0NIzvuw2YY05w3Pqu3AFPlipODCXYTxBUCKXASzyZ
         ku5jhkS7jz430skg5XHPamb8J1ozxZCXixRFmEodGkbu8aPR6iH3ZQp4jalaDoKR6h8v
         /6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXqXVXXLiNtNj2XPMj00Fh5vfToYU6aeXodhZLdJimQ8YvIwTqnS9dAzR/ubnpJne+hSxaked0UFLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSF3SNz6lCO/LNhy20N2UDTEHbwwS7bKv9X5IJuM9LBu76E2rf
	4ZRNGgDbXLET/85dO6oYQofuP7faxT/CJGqxWMyrYIBVdce8TXrhnq26zFo5Hdk=
X-Gm-Gg: ASbGncvFCrxGJg9nDzU8hkdYOIZkSO10Cv0+UHTjCEV2sS6UO3n1S4vzsXDcigywS9O
	qGVgIttcxZwk9yZaLF1TY0VXRerjGkiixClrKVDplhmbABZnmb7oCdm4I1nlTsKkVgCBT4ctbzs
	SSsVsuMZoT+qOara1uZkBuBBqhEClSu4npuvt9b9R1UNVh6v/h1Rj/lJH21NNBMi57cuBJOMEbL
	HiOX9psJpSWCORdJO0r3IFuGllaFA9BUyD6e+L3PDo1eVWwgq5jzHmBoF5Xo0VdlJPKRhHD5f7u
	gQHjv0Eu9w==
X-Google-Smtp-Source: AGHT+IGD900a6tvPRINCtCM4IMb/iOb1ill3kWUKiGi0HHllonE397r1f/IJeJKW8su2cRC6lDPWBg==
X-Received: by 2002:a05:6830:4984:b0:71e:212e:9115 with SMTP id 46e09a7af769-71e29c6a87fmr683208a34.30.1733950513833;
        Wed, 11 Dec 2024 12:55:13 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:47 -0600
Subject: [PATCH v6 10/17] iio: adc: ad7944: don't use storagebits for
 sizing
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-10-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
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
X-Mailer: b4 0.14.2

Replace use of storagebits with realbits for determining the number of
bytes needed for SPI transfers.

When adding SPI offload support, storagebits will no longer be
guaranteed to be the "best fit" for 16-bit chips so we can no longer
rely on storagebits being the correct size expected by the SPI
framework. Instead, derive the correct size from realbits since it will
always be correct even when SPI offloads are used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v6 changes: none

v5 changes: none

v4 changes: new patch in v4
---
 drivers/iio/adc/ad7944.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index a5aea4e9f1a7bdd8ca10f9f4580ad3216ddcdfcb..6d1202bd55a013b092ff803f2065fd128dfa9bdd 100644
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


