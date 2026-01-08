Return-Path: <linux-spi+bounces-12215-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DFED02F6B
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 14:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5653B3192CA0
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 13:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D4A4AC792;
	Thu,  8 Jan 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC5YmvjQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4674AACDF
	for <linux-spi@vger.kernel.org>; Thu,  8 Jan 2026 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876287; cv=none; b=jhI+utV1IuLoQlno2/d/XWSGRL8t7SiWXgvHvMkQRqHdiQCBPKCSpLrB1nKIr/jyVPSiRhhF9aS/BMzbqWeqAgAxvRYpda9vVJVLrTaC2xzFN21+1zhVNCMf8b/lcwb3u2QzXYCqS8t+2TFBS1ZNOSPkWQP+1isULRejO9liiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876287; c=relaxed/simple;
	bh=AwhGImIvcBaR3vyUVl2KbbFcTijy2PNb0a3UiV69YTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZoyA/3XShRKakkwzdZtwzVgoxZogFbh+l3OcsoBxBSAM5FznmsUAImu5rsbXxfGQTx6KCWAEsj3F2ueDWi/IUJos3EunkN2WyvYJ8I63LkEOx2WOkZsAHYl7Mw4lV6JeSp9Ux9kgoNh5dyRkZ4uw7/+e0BXfMOElp5WVqmTYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC5YmvjQ; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11f42e97340so2528934c88.0
        for <linux-spi@vger.kernel.org>; Thu, 08 Jan 2026 04:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767876285; x=1768481085; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=whT378guI+ZEoS3nkN8PXSvu/iXsM/AnSpQS/H8en2M=;
        b=MC5YmvjQm+UmRiWaXlQkEU+AAORWiPyM3qfksFFMnYBs1NoPMEUkUYAxuSpw3NJWot
         iUD5qv/lx89VVetTIsjEcTyOVRBEiG+PvmJBcoRSla6xxvf4z9KbSywF2DiPA+kg7oPV
         OEXqHDtLj8m9sy7AMOTnnh5RtMrRE2XiltNhHzPpuIyJCY4CiwVs7MmewPUQ10jjTb4e
         ZMUO3ShnU6YGg5qp2+sETIwMQ5WjdRcBtCH7Zbtjl5zFpmiBD5FFhlr+CyySO/J/nec5
         L0LH89vQ3lXbPIzncXliJdLbC1DclYLgstw+XYJvl2tXH+vAzyl2viG0NuRnOXZIW0EP
         63Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767876285; x=1768481085;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whT378guI+ZEoS3nkN8PXSvu/iXsM/AnSpQS/H8en2M=;
        b=caAjfhC0uYoLEcSWo6wV4FW2E2jm/wu0lsSfet8WYnM3nkeiwzu2p+9aYfXJn7lmO9
         Shrm5SicVW0jkg6h47T61c7+ksEF6aQM5aO989GAnRiQ/b3g3C0nLA9IHsMlXLjORL2H
         EgtxQVyV4xDEc9u/gFBPL9i2bBG9oZqKbuEMUW5S8UsxOaBciqNQFGUZ4/QL24vc3CQv
         iQDKlfGbACvEqaA90FgxBLZrInWWGVhWBveHLGcc/LZRs1RSBEKCI377WZuWSQk93aMx
         77wWl2l+6V294EQXCYBi1k3cl31vUjm/cUkv76ki0rnKChLgVU+CfZjauzG0b9wISzAh
         FiMw==
X-Forwarded-Encrypted: i=1; AJvYcCVNG3TwQDGHhDKCf5qOYNQCQ0rWJStSoh+qnnDdJpTYLG1trHDt2ug7OvaDq2nGVrV8B2jniFS1mmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJOJU19Xrch43Derrr1sPUeS1XMCKs9BvBhCyH98i3z1f6TLE
	GzS0woKxWCKsQAnNrfxMkF2zjpcsZWSIW/uI1UlK/EFOP1Gn5lLP+M5D
X-Gm-Gg: AY/fxX7fGchqzbLamAZQO/xidEUuV2a6jRKBVSWp7iOg792eukcRVR9h2BCmOEnhnfg
	cN9jclO4uFVebKMpumNVOPuVdMS2MkJwalegq8lPHqkwk/x+2OEOGNiNI0dYdebr0edPUWyTalb
	KkiU2MiwrM1uA8WERRQoVhfUB7uLFYHr5xY263HrOjHZr14ZNXf3qgK5V/NhFXf62tO0PXDXmcq
	lhRN+eBp/6LoDZQBnDX1kK8adkug0Xyu64DmwKryh1Ht4avLpPJ4bwbQTaBlQEY8covTXFtDFLg
	fhHho/cacQGzU93ZmEkGFNFlE08FecYCa+fapwYSPcCBY1dGz8VMhBxtLXxWv3oWlazW1hTtn8l
	mFw0eRUG3qiKTipF2kSvOrVYIEd7ESKkfFQ8/Dm4LPDNMDZKMZ3QPZKuNVBfRpxoYu7Tf5kpWaU
	Ccdk202PHUUFH87wOH7529neFIUr8MZA==
X-Google-Smtp-Source: AGHT+IGUmQ23SV+7CSSWfVlEULrNabCZpw88V1MXglBdAIwNayHbWakVzrJclbrbPZNyKd8leH4uRw==
X-Received: by 2002:a05:7022:6728:b0:119:e56b:9592 with SMTP id a92af1059eb24-121f8b4dbc9mr4671745c88.23.1767876284619;
        Thu, 08 Jan 2026 04:44:44 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm13361817c88.12.2026.01.08.04.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:44:43 -0800 (PST)
Date: Thu, 8 Jan 2026 09:46:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 9/9] iio: adc: ad7380: add support for multiple SPI
 lanes
Message-ID: <aV-nJtPKWbmDSlah@debian-BULLSEYE-live-builder-AMD64>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-9-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-9-145dc5204cd8@baylibre.com>

On 12/19, David Lechner wrote:
> Add support for multiple SPI lanes to increase throughput. The AD7380
> family of ADCs have multiple SDO lines on the chip that can be used to
> read each channel on a separate SPI lane. If wired up to a SPI
> controller that supports it, the driver will now take advantage of this
> feature. This allows reaching the maximum sample rate advertised in the
> datasheet when combined with SPI offloading.
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
...
>  	st->sample_freq_range[0] = 1; /* min */
>  	st->sample_freq_range[1] = 1; /* step */
> @@ -1887,6 +1899,11 @@ static int ad7380_probe(struct spi_device *spi)
>  	if (!st->chip_info)
>  		return dev_err_probe(dev, -EINVAL, "missing match data\n");
>  
> +	st->num_sdo_lines = spi->num_rx_lanes;
> +
> +	if (st->num_sdo_lines < 1 || st->num_sdo_lines > st->chip_info->num_simult_channels)
> +		return dev_err_probe(dev, -EINVAL, "invalid number of SDO lines\n");
> +
Maybe also print st->num_sdo_lines here?

Nevertheless,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

>  	ret = devm_regulator_bulk_get_enable(dev, st->chip_info->num_supplies,
>  					     st->chip_info->supplies);
>  

