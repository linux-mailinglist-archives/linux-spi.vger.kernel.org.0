Return-Path: <linux-spi+bounces-8967-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07F7AF05C1
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 23:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87DA4482A8
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435327055E;
	Tue,  1 Jul 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pnciLUbd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC5302053
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405980; cv=none; b=fz8OI8tsplFAalUNssIHqyuDtRyVGfTPPRcG6B8584RR+Fr4rKwPb5s6BYh8+RZrCrx/BA0F68p4DgFWE0GZ+RylbvAN/df/Q7FVkTd1FYsML5bBhniXuXQNtgZBdVb3cYI96+2GKeYPZEFTN/vq1qoZuwaFcI9D5Cm9xNEIWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405980; c=relaxed/simple;
	bh=M4/tNur7tRszJi5SmRurWDX7ISkKNes7iozPTRRi7As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QO6omj3moi5bHqXuVR7PU/soxks0p80hxMivy0fR5LIOSKhCXP/5rrPZV7Feuron/kLFE5/DC4lyOBdrf6DnYX883f3cfmYVjWCl0OdpttVk5P62MclWKLYgphEM9w9tdgJHKhSi2lYbEhRmN6BXz9af3qWGH4YId5bRWdwBrFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pnciLUbd; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40791b6969bso2366445b6e.3
        for <linux-spi@vger.kernel.org>; Tue, 01 Jul 2025 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405976; x=1752010776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJKwd/wJqdB50K5/93gQjs+L1bIrA5xTZSKkVy95VeU=;
        b=pnciLUbdK9Wuq+OqTh0HJ7yj/l4vMPqo2n4o5V7Xz8NwgBbj4FI9fsx4Cfpm+Ewl+3
         eT2ZKM6GxCfJBM2B9RJoPlygIV+2IPuR30bSSnHawgt0eEq8lof1thGlptjeLsCP9vAz
         lL8aXlmsAv2fPe15N8bQAGzlnohgiWoKsRdLFz9kRYdagBBdlwIqHAuHLEwBGzKFNfB1
         6+XMstybcKCw1sGv/VL27Q0IMeyGS4js4j2f9yFi8hyI2S3XUJhZjKzb7/1xUz0AEzjD
         MU4QGE0fGnoyy9uPqcYlu0xQL+xwmjqffr+da/HV9cBxfPAUzDBrra424KvKpl8Cga+h
         TrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405976; x=1752010776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJKwd/wJqdB50K5/93gQjs+L1bIrA5xTZSKkVy95VeU=;
        b=bw2PoEFQmjLbsVpNFoAR69+ocpOiJWpxFCW7PInU4NB/8eNUOyEm95DPpB4fwGqZ83
         4T9XI5RzKwDob5jf2/Kq8PZbUunWycevWlEKP6nGrgu9197F9mfyzDagXG5fa2XfSwlm
         ycwvErjpjH+upEXOhOsvLLlQOQHicluG7gEyfV2p2bCkl2j+T1yFTAICVK3wsq8Xcf5y
         9nXtnR1LpdXtiGY+5Qb/5wjzFJ5B2UDu0tV/x6PFgd1Xmdo3i1MBGM2SoZUtNp8qSaYl
         kL9XYmyzBQ1IXcHc3I0J4XsWPL/CNczVmhfx15k2okRxh7njKklVlsZW/b5Bu2RXfqgi
         D9gA==
X-Forwarded-Encrypted: i=1; AJvYcCUW9eOSj3YpdOncmNtWjgvNKUI1FBfzq4r1QKGwWSp5JTGrclvBlXIjByzuLKaP3UuSwQvNBfxUqZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywV5jdKgVAselAqZArtkVO3MGID8ktZgjWemGqVG9sZCR202pW
	yZrcuE7USMB+BDHodN1NfdRWEVUX0eRaW1bJm8LrkMPgcWWwDQ7w/zfbEcOJEXjjlbfHqTuKrJK
	0nYzOaIs=
X-Gm-Gg: ASbGncu9cpAlS4bqY86j3WI2H6+Hx8GwcJ9VOlOg06Szot6N0vBMzv4vRP/8J5DJAhB
	2eWr2RLN+J5PaNAAGticVWVvSMN0qQZ56zR4xd9l/4wzGGN/QYf4TOWAMDKmzw0ZYp5SC6gWYYx
	AyTyoU/5/AJ2u0gEyLx39kXl4/UT8qiBxnw8J/83i8M0o98aG4MnzTfQt4iwztIe23ZWh1G1UaQ
	4uBoWT0/lz0We78/kqc+jm7kP2+dKwJkph86nz+BMBJTT8o0kbAMCbYYT8UzI2OXa0UZ9E9tBES
	xc+g+uMjQTAO7HYGcMLhuUrhbJt4x20y3uA8RR9wRNON6jGzYS9Y3uaH/2/sf3QLxh/W
X-Google-Smtp-Source: AGHT+IGJwGygej2LG3wxVUQEglbyRiCBO9CmndTg/hDO9OykoKuP9uFYVTtjhgsdZ18CyZNtp0nULQ==
X-Received: by 2002:a05:6808:1a0e:b0:40b:3bdd:ba22 with SMTP id 5614622812f47-40b887e8847mr258915b6e.24.1751405975748;
        Tue, 01 Jul 2025 14:39:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:53 -0500
Subject: [PATCH v3 05/12] iio: adc: ad_sigma_delta: use BITS_TO_BYTES()
 macro
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-5-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3583; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=M4/tNur7tRszJi5SmRurWDX7ISkKNes7iozPTRRi7As=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFVb7+LH0qfzvjwAMFEUcfYoiQ60yFKMGt7Ci
 pr12dvhRhWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVWwAKCRDCzCAB/wGP
 wNn1B/9y+qz2FL8FnW6WawUuwFMrHtRYMozxtssOsHG/ot66OFx440acYcwz1vhVWCV+oPoCSeC
 TR8Dz4W1lWC34MhU5bZU+S/zYVPcZahiqrN4CHMaSisb+rtyK9uJr4Y+3yl0uVU/XRdlJozY+LH
 iYzpVnyKasHWp0UkNKuUKZ1BA09RgkNw2LPOS/vOzQITcPQM6Wupc2ERC0qYhhVtARYuex5I88r
 PI+EBh/oTdiKNyo7hVleIZjLGja5GiZ9mPn6Oka5MQArXX5FCyE71rWRFsgj48ZNPb0OmpI//3k
 CEZI7AaEnRH4o1vffi29WvPR4lsSqPFtWj324UBgidI+kjmm
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use the BITS_TO_BYTES() macro instead of dividing by 8 to convert bits
to bytes.

This makes it more obvious what unit conversion is taking place.

In one instance, we also avoid the temporary assignment to a variable
as it was confusing that reg_size was being used with two different
units (bits and bytes).

scan_type is factored out to reduce line wrapping.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index dd15c357d1494bf5718e50e50a514cb4d4556f2b..f91f7ae6dfca05cf3ae632a5f19990f3d153b706 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/align.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -190,7 +191,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 	u8 *buf;
 	int ret;
 
-	size = DIV_ROUND_UP(reset_length, 8);
+	size = BITS_TO_BYTES(reset_length);
 	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -419,7 +420,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 		data_reg = AD_SD_REG_DATA;
 
 	ret = ad_sd_read_reg(sigma_delta, data_reg,
-		DIV_ROUND_UP(chan->scan_type.realbits + chan->scan_type.shift, 8),
+		BITS_TO_BYTES(chan->scan_type.realbits + chan->scan_type.shift),
 		&raw_sample);
 
 out:
@@ -453,6 +454,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sigma_delta_single_conversion, "IIO_AD_SIGMA_DELTA");
 static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
+	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	unsigned int i, slot, samples_buf_size;
 	unsigned int channel;
 	u8 *samples_buf;
@@ -488,7 +490,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8,
+	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits),
 				 sizeof(s64));
 	samples_buf_size += sizeof(s64);
 	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
@@ -544,6 +546,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	u8 *data = sigma_delta->rx_buf;
 	unsigned int transfer_size;
@@ -553,9 +556,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	unsigned int reg_size;
 	unsigned int data_reg;
 
-	reg_size = indio_dev->channels[0].scan_type.realbits +
-			indio_dev->channels[0].scan_type.shift;
-	reg_size = DIV_ROUND_UP(reg_size, 8);
+	reg_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
 
 	if (sigma_delta->info->data_reg != 0)
 		data_reg = sigma_delta->info->data_reg;
@@ -617,7 +618,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		}
 	}
 
-	sample_size = indio_dev->channels[0].scan_type.storagebits / 8;
+	sample_size = BITS_TO_BYTES(scan_type->storagebits);
 	sample_pos = sample_size * sigma_delta->current_slot;
 	memcpy(&sigma_delta->samples_buf[sample_pos], data, sample_size);
 	sigma_delta->current_slot++;

-- 
2.43.0


