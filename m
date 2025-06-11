Return-Path: <linux-spi+bounces-8450-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3174DAD585C
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 16:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A945E189421A
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03628A1D9;
	Wed, 11 Jun 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="izLqvBZw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA31885B4
	for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651383; cv=none; b=n/PxMm+zhrCX1SPW5/AwGaoRo5+yOk4Z6tjrUe0QTOvCgtram4o0lAKWPYWF+4q4m4pPzc3R77tOAbZjmOhiZS1hVYrXuEMM3fi+4pWAP2V+tmqHPRu2KPyRuGZSZofScy2PirdWNMD/cJbjqlv2F0Sb2VICX0hOcCrYJeWyJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651383; c=relaxed/simple;
	bh=EXJnlVTnNud7vFOMtkEXkO8+20lQ+8pjSYNNNw59vac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bslM5pP7bNX9hie5fXsJz1ODnSUHviN3VOhrI0OEwwJGyr+fq9drFeIKezc/YrUOfVKg60YjLj0ESVMTCoNtBQ+8L5XSLplp9YDG94DMP9NHoR5wBsyxrvSzEJBTLjcSv7plJkDINsH7U92V/d9quw7/eijmVvYIplBV69U3Ma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=izLqvBZw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f0ad74483fso67254956d6.1
        for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 07:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749651379; x=1750256179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1AY2fjU0MUFNTnTPpkTJ6hjB0BWW24lbL76NZAT2+E=;
        b=izLqvBZwE/raCYSzZHNgg0eiXBHn6pBEPxMWO09cnwCp8FCwNG117tEZz40BiTRGvv
         gPSWeLr2wU7/nF05VV2q29yuAx4L1m7xjbHNSP1U3OWCvd3Ro7G8u6Tt5Z+i8u2hEAee
         fQyAhaQTOAuF9mS32Sh4mfVlf2zBH98cJ803l+we7Vr9NvjVf5exSpVuSu1WhuNOuOh5
         Js74VQnNGFnSVNsRL/A2GtWXH8jne9CfQFZPifR7QF8xMlYGwm5wpFk48mgoXGD9nII4
         G9s2AfCwrpzJdwQyZz0XTx2sflCqsVG4ToO0u5vCdaGaRo+71FPaiIME7uZTXtsVsYlJ
         Hubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651379; x=1750256179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1AY2fjU0MUFNTnTPpkTJ6hjB0BWW24lbL76NZAT2+E=;
        b=f2JGtS/VUeKJ9NFWY27j2vvHrykBVc6DJWGycSWzmot+0agjhTcUUIQmX5XewQBVXk
         RjQ2dmwE2T+Bv1L6GbPWQR/96s2+iOrMb60TlXCZcX5gMJEFiWatZaaMluTr1dqMngIV
         Jqx5E9WclQthlw32xr6s0Ym9EZccZviuGT5yuMAH3silQTtc6/nXo7/8uO4krd16yUg8
         UpqJyYviwVaJQl1/icFNhMI7a3P4M3eJLpa+6M2HWkFKp65RlbwB6O5NPKBn/rp5XU0f
         ZvBpWOzR6xvLEcfBsnX3JGR7jSKGVsEM28kgBZBJL7pV/JugC4k89KBBFv/sgzygJFcP
         xKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0G2CBQaTXD8lHkGXRpDIn937GTBwlO4cEqVwwMC7fejusRP5pvxch/qtYLp/xTj2qNFui+u4go1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXU7OhK0B7d7oD1uuXeCAUAzwlHC91yayDyIqHrjZguGhp2GH
	k1v0buVfin22t8XHPvycsG9VflHAegU3Lx95vEN5rO9dDCARSB7Ah9TF59fMXzZh+DX8kGvr/pq
	6njix
X-Gm-Gg: ASbGncsR+sju9XveTcS/CKvpi68sOhsCio2xyGpE83j4HyVeE/RjPXYLsf392LvtFCd
	Nql6ld+uDFDeJ41s15W/g9yfv6IipeCjsswm6GrerpHlsPYpC0t58H15ybOktrM/C0ZUuBqvpck
	nYLqeEoA0QKDYlLjFwVq1uFbeZWIR9DfaYrrCtdUYr2EogqpJriJqEJ2MPVn9OLAiTuDkT9fY5n
	bIxzQP3Hz8f+Adg/fe2Yf2udxPBQiKPqMBuhTUXfS210fk4HxYy+TqBtRa9GmB9xH/lMx/QVmsa
	hLe3bzgHWxexlgWp8voGcRsG+Vm5BB5z6gZn/w08nxvifLkp9fVjISyhelNRwyszpQ6HX1hMq+H
	UtNz8g32puB6JQ2/ZFyLKDhZoXknTwW86BQxD
X-Google-Smtp-Source: AGHT+IHUfOaV6u8X5qxFKUlC7LB2yebCfftGMi8JimcjPKwM6QWalazzeWJt1jF5l4ISY9kVP+ktuQ==
X-Received: by 2002:a05:6808:3086:b0:403:3814:b2b1 with SMTP id 5614622812f47-40a5d081c0emr2562964b6e.10.1749651368697;
        Wed, 11 Jun 2025 07:16:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:eb6c:30d1:632b:494? ([2600:8803:e7e4:1d00:eb6c:30d1:632b:494])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a5d95e797sm337318b6e.40.2025.06.11.07.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 07:16:08 -0700 (PDT)
Message-ID: <71b66cbb-ab2f-44e3-926f-9ae4bcb3aadc@baylibre.com>
Date: Wed, 11 Jun 2025 09:16:06 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] spi: expand bits_per_word_mask to 64 bits
To: Da Xue <da@libre.computer>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mark Brown <broonie@kernel.org>, Rui Miguel Silva <rmfrfs@gmail.com>,
 Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev
References: <20250611000516.1383268-1-da@libre.computer>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250611000516.1383268-1-da@libre.computer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 7:05 PM, Da Xue wrote:
> Most current controller IP support 64-bit words.
> Update the mask to u64 from u32.
> 
> Signed-off-by: Da Xue <da@libre.computer>
> ---
>  drivers/iio/adc/ad7949.c         | 2 +-
>  drivers/spi/spi-dln2.c           | 2 +-
>  drivers/spi/spi-ingenic.c        | 2 +-
>  drivers/spi/spi-sh-msiof.c       | 2 +-
>  drivers/spi/spi.c                | 4 ++--
>  drivers/staging/greybus/spilib.c | 2 +-
>  include/linux/spi/altera.h       | 2 +-
>  include/linux/spi/spi.h          | 6 +++---
>  8 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index edd0c3a35ab7..469789ffa4a3 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -308,7 +308,7 @@ static void ad7949_disable_reg(void *reg)
>  
>  static int ad7949_spi_probe(struct spi_device *spi)
>  {
> -	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
> +	u64 spi_ctrl_mask = spi->controller->bits_per_word_mask;

I think this driver is incorrectly accessing bits_per_word_mask
directly and should be using spi_is_bpw_supported() instead.

This driver checks for SPI_BPW_MASK(8) at one point but doesn't
take into account that if bits_per_word_mask == 0, then 8 is
implied. spi_is_bpw_supported(), on the other hand, takes this
into account.

>  	struct device *dev = &spi->dev;
>  	const struct ad7949_adc_spec *spec;
>  	struct ad7949_adc_chip *ad7949_adc;

...

> diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
> index 24e9c909fa02..087eed1879b1 100644
> --- a/drivers/staging/greybus/spilib.c
> +++ b/drivers/staging/greybus/spilib.c
> @@ -27,7 +27,7 @@ struct gb_spilib {
>  	unsigned int		op_timeout;
>  	u16			mode;
>  	u16			flags;
> -	u32			bits_per_word_mask;
> +	u64			bits_per_word_mask;

This is assigned by:

	spi->bits_per_word_mask = le32_to_cpu(response.bits_per_word_mask);

in gb_spi_get_master_config(), so changing to u64 doesn't have any
effect and should likely be omitted to avoid confusion.

(The response struct is defined by a communication protocol and can't be
changed, otherwise it would break the communications.)

>  	u8			num_chipselect;
>  	u32			min_speed_hz;
>  	u32			max_speed_hz;

