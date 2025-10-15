Return-Path: <linux-spi+bounces-10666-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390DBDE093
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 12:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF47319C3A28
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6630BBAA;
	Wed, 15 Oct 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZifL0Bsf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066829AB07
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524552; cv=none; b=O3ekhZy6oE1kwyvZr12WtjpF9cKvBijMmaZlKY08xXCOiREmQxQK7/4BvNESz59Qk6cOTWuJW6cxuirggIv/zy2VremFP7uZQejkkG9GPE+Hr7U9EQDUFVbrN7HccM4SOckHqRV0o8rLkJl5aqR6rk+PRpvzyi2EEioMD+YUBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524552; c=relaxed/simple;
	bh=L4wLsqvaNKifFb9kXN1voIWzjV4ev9i8DnZdeTEPjgA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BnzDW4HILuUg10rrbDZSbc2lgIVwQzkKaEFmKZBPz4JPeH2XHRBfYOXW5PGpKOfvlYZDOVJ16tTgWkxfFS+tHDt33TaxALCciDMdj52pt/q3Z3vYfxlRoFUic0fhlp5kMP9d9gYSAjq9YsxN9ol9Q96dI/I1JZwffySoB37NfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZifL0Bsf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710683a644so3203555e9.0
        for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760524548; x=1761129348; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7QNXCpktIYAb1DPjGOe7dO+9+h/oG2Y1WU2nDERyLWo=;
        b=ZifL0BsfiFIMHz/ld2J9irwBtjZlex3rBImlrXEtgVACHZK1as8pZARWpbGup2LRcD
         i4d9iTXIuH+GtiJhJ/rFfzttMHa5+WUYTCBOMU+5eoIE+NcnGhc24FtQz2WbZ8LbrkZc
         CL6gJIKGcgUevB+D1wKpUESM4qfDvT2yTA6MtZblelCLB657hgGtDPH7RkCbvnductmp
         hBSeUBYblMWbpZJagvD/38jmCF7JoCB2I523YLYF0VZfeUvMRYvT1K03Jwbd9fsaYXUK
         /bhGEfcbRpel98FB9LNOfJLH8lMRyadhTT24XnycfIA3AL9Xyy/OLf2LzCtFdUcc1w53
         tuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524548; x=1761129348;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QNXCpktIYAb1DPjGOe7dO+9+h/oG2Y1WU2nDERyLWo=;
        b=HqGGFtd9bZ7DKmyR+Z4yOKVtTQtubu5ZIWvSqdF6hgB83TvJoIo0fCl1thYViXyX7b
         pWezdA0WzilWMjZDLrKcG6QPQ+jZhQXgYLyAqLyKN03qUuLhMz6gb46dq13nastSdn07
         svPmKF8dnsES+FLLqaIbmyzcsHBwXDNiaMYvdSdqRCCUyYLrpdvc05B+w7jPIKEln8pb
         cTZLp7JHhswZESZ0fK+UFJCCO9TNBnR2FbgJTFPvaeL/Rc5HpytW79SG19is7VDBHG7a
         uoklqbf5bOASVD7v3xxQ8wEFysJv8yU9UFGpXPk4cJHsEADq/7ke9tuJYGtZOZKDU89p
         7Kmg==
X-Forwarded-Encrypted: i=1; AJvYcCWfF2GqpccMV1YSBuHeh7Xl9DPRryy6QNiIcgA4bGWHwvRgjO8PBvyAa4Wa8hxnqFVbUbCSm5jaE1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0zQ9xLP69wTXlp/qJMJLDsetwihyOrtrVe9LOWrJAewA5ojfS
	qWgIo8msTPA9AFJ2QTp9xOC6lyWuNZZXvAcNTyruN2ZdUeE2fs3KvzHj
X-Gm-Gg: ASbGnct1zuehGaSFWsqoXi4o9YtaftdCeKQppmrGq5kAWcLuzkRIIYc2TcR1QZmrEJJ
	Qp6N5Hc4Y86SLLXeFtGB9L2DExkiiKzNpKqso+ZOv8ls4oTqqLJxiFE+n+iIJz/9XGaIYPz8fyU
	voYNoDn1Dwgbg9cWDiGcjF2k3xmUEoWM3sU76ui/AVHAUjGBx1sq4oaAd31ZJXQbFh8p+G6Qq8c
	fr12UskBi5J/mYfTUzPLetN1yKgdFg9K4PCiHDPj2viixtmg+wJY1reinlTbRxNuE3Nd1k4xq5i
	SV2JEfAFDx7KPB5Lz7CWfeRyz7kcr17j+ZdHFpB2H8JNpqVzJPD/3vxEzp1Rm5KEJ12jfzrtgrX
	mzwjCDYAygufF9XyoDF7mNS2nYarmlZvHGQ+rDZAhxNWo2YtdsBK7vDilMLOV
X-Google-Smtp-Source: AGHT+IERvd+DCsAGw5wufhvSoXWWpJyqmq8RwH0h8dyTRRhpT1w1j/81EeNMDn3zr7X5Guqk61mo0A==
X-Received: by 2002:a05:600c:450e:b0:46e:1a60:c995 with SMTP id 5b1f17b1804b1-46fa9e8dcc7mr223056895e9.2.1760524548098;
        Wed, 15 Oct 2025 03:35:48 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c23a52sm19972125e9.12.2025.10.15.03.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:35:47 -0700 (PDT)
Message-ID: <ef452c01679bee2c8bdbefe1df4775c432f8b345.camel@gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad7380: Add support for multiple SPI buses
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko	
 <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Wed, 15 Oct 2025 11:36:20 +0100
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
> Add support for multiple SPI buses to increase throughput. The AD7380
> family of ADCs have multiple SDO lines on the chip that can be used to
> read each channel on a separate SPI bus. If wired up to a SPI controller
> that supports it, the driver will now take advantage of this feature.
> This allows reaching the maximum sample rate advertised in the datasheet
> when combined with SPI offloading.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

One minor thing. With it,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 41 ++++++++++++++++++++++++++++---------=
----
> =C2=A01 file changed, 28 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> bfd908deefc0f40b42bd8a44bfce7a2510b2fdf1..36abe95852006a81f7e31f8034699e5=
9292a
> f79e 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -77,8 +77,7 @@
> =C2=A0#define AD7380_CONFIG1_REFSEL		BIT(1)
> =C2=A0#define AD7380_CONFIG1_PMODE		BIT(0)
> =C2=A0
> -#define AD7380_CONFIG2_SDO2		GENMASK(9, 8)
> -#define AD7380_CONFIG2_SDO		BIT(8)
> +#define AD7380_CONFIG2_SDO		GENMASK(9, 8)
> =C2=A0#define AD7380_CONFIG2_RESET		GENMASK(7, 0)
> =C2=A0
> =C2=A0#define AD7380_CONFIG2_RESET_SOFT	0x3C
> @@ -92,11 +91,6 @@
> =C2=A0#define T_CONVERT_X_NS 500		/* xth conversion start time
> (oversampling) */
> =C2=A0#define T_POWERUP_US 5000		/* Power up */
> =C2=A0
> -/*
> - * AD738x support several SDO lines to increase throughput, but driver
> currently
> - * supports only 1 SDO line (standard SPI transaction)
> - */
> -#define AD7380_NUM_SDO_LINES		1
> =C2=A0#define AD7380_DEFAULT_GAIN_MILLI	1000
> =C2=A0
> =C2=A0/*
> @@ -1084,7 +1078,7 @@ static int ad7380_set_ch(struct ad7380_state *st,
> unsigned int ch)
> =C2=A0	if (oversampling_ratio > 1)
> =C2=A0		xfer.delay.value =3D T_CONVERT_0_NS +
> =C2=A0			T_CONVERT_X_NS * (oversampling_ratio - 1) *
> -			st->chip_info->num_simult_channels /
> AD7380_NUM_SDO_LINES;
> +			st->chip_info->num_simult_channels / st->spi-
> >num_data_bus;
> =C2=A0
> =C2=A0	return spi_sync_transfer(st->spi, &xfer, 1);
> =C2=A0}
> @@ -1113,7 +1107,7 @@ static int ad7380_update_xfers(struct ad7380_state =
*st,
> =C2=A0	if (oversampling_ratio > 1)
> =C2=A0		t_convert =3D T_CONVERT_0_NS + T_CONVERT_X_NS *
> =C2=A0			(oversampling_ratio - 1) *
> -			st->chip_info->num_simult_channels /
> AD7380_NUM_SDO_LINES;
> +			st->chip_info->num_simult_channels / st->spi-
> >num_data_bus;
> =C2=A0
> =C2=A0	if (st->seq) {
> =C2=A0		xfer[0].delay.value =3D xfer[1].delay.value =3D t_convert;
> @@ -1124,6 +1118,7 @@ static int ad7380_update_xfers(struct ad7380_state =
*st,
> =C2=A0			AD7380_SPI_BYTES(scan_type) *
> =C2=A0			st->chip_info->num_simult_channels;
> =C2=A0		xfer[3].rx_buf =3D xfer[2].rx_buf + xfer[2].len;
> +		xfer[3].multi_bus_mode =3D xfer[2].multi_bus_mode;

Why not doing the above once during probe?

- Nuno S=C3=A1


