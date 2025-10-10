Return-Path: <linux-spi+bounces-10531-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 158AABCE325
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB12C4F05F3
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28E22FBE1A;
	Fri, 10 Oct 2025 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PBX1mq5r"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D922F5487
	for <linux-spi@vger.kernel.org>; Fri, 10 Oct 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119939; cv=none; b=fL3uahq+tu1Wg6IlJmTfub1fl7XOg/oJv3VtGOUjy0vx/3WZPBJB3g58lylOkJDzKVJZIeCkkS9k7h2aG7coB2lovI4gyU7roEHfx8Eao/RzO8E0jnSwHpwuArGYzLsM0GHFXcLK+pC9kTC7nlSJEQbj+fEfkGzpKNkkWTQ3EDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119939; c=relaxed/simple;
	bh=5sOPNs/pVYr2aEdLdYkxtrupFFKn+aERSvll06ITe7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5SXkSj9JC0RbV6dj7eLT4taYBJo/T4l90a5U+y52SMau9eC/YnoRIrlCDnvDAG8TVjixmuKvzisz8rPiNhhqxfh8Xvd4C9YPR/V97AfWTWJAOe2ElmfstFukQ9a2kFK5LU/0HUpgKXyJilweNF7B+cGjTaeQAeRkpWPMdbfli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PBX1mq5r; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c0e357ab51so1937140a34.2
        for <linux-spi@vger.kernel.org>; Fri, 10 Oct 2025 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760119936; x=1760724736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJITi+/a5Uy4Ywybn43TGus/0RCOWKapqQ9K/U9rCqU=;
        b=PBX1mq5r9veqx2nhSMlcRzjG3ZXNZ9XKO0P3mfcjQjQD8uBRKof0H5usVKH1PJ1D3n
         OC1mFKC2hhXvY/jJCBYq/WHUNrKuJKcAW+r7pB3cWDJz26HdKJXPW+H9K9WY6Rhtl829
         Xgh4jNNgtgVJu0ZvwwopeQ0BzIwxAg3kTIViaickRGBjH9vTUwPhB7LfUj0eZwB2OC7L
         nDvQMJApSYJC7d3yw4qz5COMORlGmk/cQyeqGAwlbHLMPdo9Y37ym58fV2tzsaa6uNBF
         8ZuQV9N9+UlrMhHkI4IqrXYkfhYHGpwCkq4TMqGnj8UI+4jDyCKXpXFpM5BzLXVB3hNV
         nFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760119936; x=1760724736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJITi+/a5Uy4Ywybn43TGus/0RCOWKapqQ9K/U9rCqU=;
        b=Ng2b9E3wUROKcpif2wlTC2kzTtx1+iOxvbvf4spxXq1+fXm7f0YFeOFAX9Gmif014B
         cbamPZ2IbjNa5G80ynZnzma26Yf0lAgdHI9QInXTR+XAjmXIBXaecUsSlhUbKIe/9aDx
         9y9onFCNEmGJFnPeT2kWAlzMTFZ30ZzmMgWr/dQYQkKY3U6P/Di7syPjqsUSRbrubMPM
         AiVzdChmsJ+QtAjTkkNY3ipUGOVbojAL1pynOa0B7Aj5U99w/rpvOLQQ8xEBwNo/4Wl4
         cVQrPNGZ6eUn3EO0Qsuegql5d31pMR6mkLxNJJ82pLI2zA/q4sZjDhyM+U6PR2l+YbrX
         JQJg==
X-Forwarded-Encrypted: i=1; AJvYcCV4jxqnOJxniCM3heRxI525yadREMBBVnMWugQYu45waj6bH9v5Mr6hTA0zpLoviT9K2/mzR5DP2Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1v4NyrigUbQvfUb5OVIMK17WFfldzNpvJY8lWWYHn2EPJUmd
	M3O900dIfVSODA45xdUSe9l6GBh2/h9fBZdJD6nRzmou9Nzhi9FVBrwHBb9AVjAbWOk=
X-Gm-Gg: ASbGncvwNBazbiBHz5vtOOOO8tNjwWnPyzlh9X9ilNzUdrkexXs01raTEYu365rlxz/
	TsbXkfBkRKWVaM7AxdRiEfRyPZrjbKzjTpbhkQj37X/QZtM9LviXmgTlkTj1abJxeGkYhxnPVg7
	7iloWzHDtE+LgdpAW7/qSscbWzY7z/5XfLu/SG0jbMb7pYJruzgT5x3Wo1qQoBoqakxHvgJ+zze
	efhYVZcMcTV9uK5sINvMje600nWVom1DQbS3j5SUSbEp2zlFtYDQQQTP84+sdUw8L2ttEz3+O2/
	A1bWWOVetWSDZEaQQ1S2umBk4A9l0KIbLHfhF9CrK56I5qa0DheHDE5JUKJKT/qE7zzv11o4HM3
	eUv3KbDTuM1QrzY0MyS2EFm3whxOlAEwqKSJtkzh14NQoQWIfdfv60TDJylxVaigq0wzGNUzBUn
	prFqkNFYNiZ/zq/fqopJj2UV22mw==
X-Google-Smtp-Source: AGHT+IGdiPP3DRGOJKjYj4pluDC86vZ/Ybmz+/mK35EcOXVcyBnRq20OMLL70oFsIcshIMYVWisL+w==
X-Received: by 2002:a05:6830:210d:b0:746:d22b:11f2 with SMTP id 46e09a7af769-7c0df752992mr6630275a34.4.1760119936239;
        Fri, 10 Oct 2025 11:12:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f911aefasm1045881a34.31.2025.10.10.11.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:12:14 -0700 (PDT)
Message-ID: <07c11aae-6440-46bb-880f-80d09da1bf40@baylibre.com>
Date: Fri, 10 Oct 2025 13:12:12 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7f8a65deb597d2d26e1d1d373d70851c7cb3d3e3.1759929814.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7f8a65deb597d2d26e1d1d373d70851c7cb3d3e3.1759929814.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 8:51 AM, Marcelo Schmitt wrote:

...

> +static const int adaq4216_hw_gains_db[] = {
> +	-10,	/* 1/3 V/V gain */
> +	-5,	/* 5/9 V/V gain */
> +	7,	/* 20/9 V/V gain */
> +	16,	/* 20/3 V/V gain */
> +};

This is only being used for ARRAY_SIZE() and can be dropped.

> +
> +/*
> + * Gains computed as fractions of 1000 so they can be expressed by integers.
> + */
> +static const int adaq4216_hw_gains_vpv[] = {
> +	MILLI / 3,		/* 333 */
> +	(5 * MILLI / 9),	/* 555 */
> +	(20 * MILLI / 9),	/* 2222 */
> +	(20 * MILLI / 3),	/* 6666 */
> +};
> +
> +static const int adaq4216_hw_gains_frac[][2] = {
> +	{ 1, 3 },  /* 1/3 V/V gain */
> +	{ 5, 9 },  /* 5/9 V/V gain */
> +	{ 20, 9 }, /* 20/9 V/V gain */
> +	{ 20, 3 }, /* 20/3 V/V gain */
> +};
> +

...

> @@ -432,7 +533,14 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
>  
>  	*val2 = scan_type->realbits;
>  
> -	return IIO_VAL_FRACTIONAL_LOG2;
> +	/* The LSB of the 8-bit common-mode data is always vref/256. */
> +	if (scan_type->realbits == 8 || !st->chip->has_pga)
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	*val = st->scale_avail[st->pga_index][0];
> +	*val2 = st->scale_avail[st->pga_index][1];

Instead of writing over val and val2, it would make more sense to
move the if up a bit, invert the condition, and have it return early.

> +
> +	return IIO_VAL_INT_PLUS_NANO;
>  }
>  

