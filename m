Return-Path: <linux-spi+bounces-6669-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFACA2CDBE
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84D8188DC48
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 20:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983871DE2A4;
	Fri,  7 Feb 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="em3eQmMW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8D1D9A66
	for <linux-spi@vger.kernel.org>; Fri,  7 Feb 2025 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958987; cv=none; b=Q4N18dWh96qkDZ3NunkSMSOg/hzpR0CAHksvKcUWA8mYyNwOKpDauqT8l03kKhXNbJsmePl8oseRWePlRTQ7DtTWxXtZ0Wax2S96U2UhIJqIqyk2pq1HjqaiX8w+cpnv+GQIG/voOeisJsjl4wKFvwPNRDxhEuqHR0Iz9FqFzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958987; c=relaxed/simple;
	bh=5/ZCGTFk8qr5Qpjjmv0qoJEV9Q10DfHDZbzjSTo2suU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OcmGHpheWMPwNY77OgaJdqxPRHUI5Bq+E/VxDoup8Z5ivkKeZOMb2fTMmiLoGvmOPMwwNtZhCSpI+CCnCiobqJwOuklTt0PRTjdEQ3snWhQ7x+Njro3/s82zKrekDf6ILuDyO7lJ+q0LtR4rZfDGoZ6OmjTVJerXkznJmto0BP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=em3eQmMW; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f321876499so1305220eaf.1
        for <linux-spi@vger.kernel.org>; Fri, 07 Feb 2025 12:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958984; x=1739563784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qltVAB3O9f/S/slNVDINiHvuxo8d2MRRS1EWEiDjZ8w=;
        b=em3eQmMWh57izLwo6bnPibzw9MboUcNCJsSyAsTD/E68XI8sEcc1ZP4UxeTKcW5+Wl
         a4b1Y9dHPLM4nGkQTzh19hravRkaChGwZRlDVNATYcDFZWvNvBmNSTfl2QCnZEPu5sF0
         31QdW7QdqVISLn/FDwsnaNJhMPQjwKiiVEG4NEAW1IPcy3m70k6zQNw8zJv+FlGi4QMF
         78QgZ/ezxBT01kB+8PJBcHY4gfhhtdPnPg0Qo38qNuZ3ae5dvKqO0OPvC3492mAhxpKh
         FUVNkkariWu1cCkOnjh1SmQUgGPI9Yy5cXp6p2aFu0lKHnXAJKznw1w2k6/gmOm+y5Bw
         fG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958984; x=1739563784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qltVAB3O9f/S/slNVDINiHvuxo8d2MRRS1EWEiDjZ8w=;
        b=qY5IbkQ5B51oZGnUKpKNBm05WiYyBFO3yY8wjni7Xv+qXpnUIOeWV5sWAN3n9bAAQS
         2kGHzbLrOAwdXBWDHEYzUuaLpv9lLQfS8AJnuJ/PfUX5JtIn715P7m7Br1a8zyRsEP5P
         kNa+gLtmEhxhJnkzEi2R+/0hd7COvKWlt+rnLPnxFG9ENQg4hps6Tfm6esG0uC9g4uGc
         911Sy9M10f8j2n3pTRuxoJj+ODZfEb9mEu4SgoMAT8r/SjrLNaojovpT+zZThzCkn6te
         YH1un7TqTwmKuSjZa+cmfT58HCUGpxjGWUkTOAnuP93FSehS9ZQkhlt3LAFijNoTzaYq
         UD/g==
X-Forwarded-Encrypted: i=1; AJvYcCXXoTz0gjwg6RCmz3OMSChSpOIPhr3FyB3kEWbrDiaD8/aIrG1HNvGTc3mkLHmqV+aVhDX8AZF4mk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWtUljbZ1Mu13vbs+O96Va0wwm9tRbADlxnLUtH0+hiEk5iIW
	Yct4yw/UMi+bzzA1RzGxKW/nsMBKoxhrXCw2dmQoQEDuPGNyNRqueiv6AfBQHwuM01uM+4St3Su
	p
X-Gm-Gg: ASbGncsTC41vvHWKE8cKN1jLN339eCUrwbpXAQ+e/VMx+KyhlMcSkv4y2HdOurxys0L
	4O2MZebM/82u23qNCKiE7gxJ6LAIGlbObJw3xeQm3Oi+yYi6pw1C8k9n06qgMCM9ryCZw3vBMyK
	rn/wRTi6ReR/ivJ5XMuVZN/nochBpzkYYGVmWdHnjRhX30C/LDclWoNk9PODCQD2da8fiSSQHJK
	0fqrSZzpW15pExL88EfFOTKGiU/m2U84Fwptt8aBCiUb8DIOLUq9XEkUUAPAv1iphIVItW5K8pQ
	SQ5RIsu2LM2C60PgXvy7Vag4o50IRCG0L+CQ5o2B/J/wM68=
X-Google-Smtp-Source: AGHT+IHIDAGX3BhQWlqRFA1YpXfP5CHdNbSk4wUH4SYQ9UZGnd9dymzKZTDir+HrZG6DMWiSrEhmTg==
X-Received: by 2002:a05:6820:491a:b0:5f2:c0df:7ed5 with SMTP id 006d021491bc7-5fc51f8763dmr5806165eaf.3.1738958984295;
        Fri, 07 Feb 2025 12:09:44 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:07 -0600
Subject: [PATCH v8 10/17] iio: adc: ad7944: don't use storagebits for
 sizing
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-10-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Replace use of storagebits with realbits for determining the number of
bytes needed for SPI transfers.

When adding SPI offload support, storagebits will always be 32 rather
than 16 for 16-bit 16-bit chips so we can no longer rely on storagebits
being the correct size expected by the SPI framework (it always uses
4 bytes for > 16-bit xfers and 2 bytes for > 8-bit xfers). Instead,
derive the correct size from realbits since it will always be correct
even when SPI offloading is used.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-vy: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes:
* Make commit message more specific about numbers.

v6 changes: none

v5 changes: none

v4 changes: new patch in v4
---
 drivers/iio/adc/ad7944.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 0ec9cda10f5f8f61727581b152fb921f2e0b4bff..abfababcea10152fe1faa8afc2ec1ea2dc40ae52 100644
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


