Return-Path: <linux-spi+bounces-12299-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA1D1449F
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A31B030F73AD
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB1437999B;
	Mon, 12 Jan 2026 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xHRGWeGK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2928B379982
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237278; cv=none; b=Cazt3tfCmVyPOA2DNnADFk15vJ3tBBah7XyxcNZ7IoQQPFk3kxsnQku+DD95pRNEDBlcg4tLuz1k12FZywfjUsLDiHpmKELcyC2v9x5aiEXDacM9q+yZbkms9+Sea/QAq40MynO6Ety+TO/fSMPX2k94Tfhcilic73smyUSyL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237278; c=relaxed/simple;
	bh=Mj1Yo/+kMDe7Z3d4CNX1daTeAOa9r7LVOIZJ6VYDsaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+UgZzCH+iTjoH5ONeT0ZCunNaxHo/uWaUhjMCPEvhOkiSItYgrw59kXJwDoEPDI71Gtw0PfosXdSb3zjG9K3mxQR93mmaQ7USrWv6rBORHIAY2xHdF0/ZmHN5znmbTtZgTdz788PVujB921knwEmTPqSdkAr/KgJ7o7nLfro6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xHRGWeGK; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-455a461ab6eso2627229b6e.2
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768237275; x=1768842075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so8XntnCWLt6fJSRVtTMtZ7eRh+xR/oddnPqW1/m8DM=;
        b=xHRGWeGKZX3KgiIUrMfHbYMq9+LJ8rYw1YEQ1S79GOn6RAg0TZmC/9WocNULcU0ImX
         uy0/NnfRckmWECwpf82eJqV95yr+Agju6ATc1hELu0AyoT246dsdweEO+u/OL1jqcZeD
         8FRcJIVgNBczDhyLrhH2GxLpHzq9fLAHc9nUNZrmRbi36j64qUBR7w1v+qS+/wc9X+W8
         pw3OCpAUqVXeeXNOw16yQr4NpWbxuQXmz3cTmo3SleyIh3IRiZfAXxLkuWLsXHAgDJ8n
         etQblsostg5hi7jSdPDL5fKDgyXQly9u7Jybae85YQZ472Q91XwQKAHkwreTAn+IaJF9
         jpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237275; x=1768842075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=so8XntnCWLt6fJSRVtTMtZ7eRh+xR/oddnPqW1/m8DM=;
        b=FQXPaglEU9230rhHlJHnslw2dfmxwKNVf2sd/p2AU7jzFHVTde6dyh9Jit5UlfNS+G
         m6GQ4f179pzjOxwsWX7tQfhNzZcx+3qmaztDthqiinByQ1aAKRmDGY+3g2QVQAQgLlAx
         rnm4xdPDhfd05bsM4+LkEjFFPuXsPVCx705LEwpZ8r08HS/FD2LYAN2vBUKACehAnezC
         MpD8UI28d2ahM7OfgDR/OmQVF4HVF8pe6P6GlPkF+SPAhPjTw/EkSUhd3wEuFmvBHY51
         bA8jyNcE5eCoqjNEXV5UgcY+mP2526OT8ZaLsmeaF98GsB2qQpMhNg6W409cqPTBpdre
         f/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWCf05Hj/vohtz4wgrfJ2pQgqsirGAuOk/moQ5G2ZnabTA8KjkRM+/IMgpDGg7xqoYIsbaT8VGdy6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+daYp6Hoo+5Epsq3yKLR+t3Sk2re0a7+WmDHcWlNYDtGIOwh
	Gokc6fPoDYqiNOtqmafp80SAbVsjxoOXfMbZovz2ZE8BH350CyG2ETYrdwykU7eaQNE=
X-Gm-Gg: AY/fxX7dFR3J+mH5ERLaVzRbnjngcVBm2GVTR//v2/lNiDNU8izWcUsRP+Ihs3CZdxU
	zEA8HTI5JDHQTUXpTfG/VNdj8bJBNTBBO8e4aOvFkUPDz2U8KrQeAbfGeIuNng7yY2RaboAm67C
	RWlA8k5JdSIjjMe88gsusQMqt3GHtr9a6gEu4ovX4sRuDEz1HPpDjymlRLyYKhjFdI4jWRPYl8R
	Zi26KegtFGUvHuNAhjwDx8tXqoYbQNNP9na++7PejLNqhEXTIqRWwcBFI1UqCdI9Nz7qPtDAlNu
	6LWdfOgKauKh3Rm5JoTkY4NBAP60CsHPuObfbF84myPdVjLyU7zMwqUt48kEVt2sVE/XhUarvPG
	clqym7Uhs94zvUnay4mrIU0106BHMStXOSy7gLHTAZzu+lucn5wIhVV7tfh4ZQAeFIJmig4jIQ7
	RtUEPVAAiQe1cjpnPiPTM+G/ggZ38CwK3qgy8wiW6nY/RgINa7HgBFd9A2fhwD
X-Google-Smtp-Source: AGHT+IHF2zSPcETdBanHmPj9qpqYedDpsO+mBiC5UofQ2hlmzyKmZYBQU3SkAtpC5qjlsIgfZvRPcg==
X-Received: by 2002:a05:6808:1311:b0:450:d693:4d2d with SMTP id 5614622812f47-45a6bebb60emr9095964b6e.33.1768237273286;
        Mon, 12 Jan 2026 09:01:13 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b4b:49b3:cce5:b58f? ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2b2b20sm8500125b6e.18.2026.01.12.09.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 09:01:11 -0800 (PST)
Message-ID: <2d7b3105-1bb4-40db-9a2b-dfc133b15840@baylibre.com>
Date: Mon, 12 Jan 2026 11:01:09 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] spi: support controllers with multiple data lanes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-3-145dc5204cd8@baylibre.com>
 <aU_4RhfUlJ5R_inQ@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aU_4RhfUlJ5R_inQ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/25 9:16 AM, Andy Shevchenko wrote:
> On Fri, Dec 19, 2025 at 03:32:11PM -0600, David Lechner wrote:
>> Add support for SPI controllers with multiple physical SPI data lanes.
>> (A data lane in this context means lines connected to a serializer, so a
>> controller with two data lanes would have two serializers in a single
>> controller).
>>
>> This is common in the type of controller that can be used with parallel
>> flash memories, but can be used for general purpose SPI as well.
>>
>> To indicate support, a controller just needs to set ctlr->num_data_lanes
>> to something greater than 1. Peripherals indicate which lane they are
>> connected to via device tree (ACPI support can be added if needed).
>>
>> The spi-{tx,rx}-bus-width DT properties can now be arrays. The length of
>> the array indicates the number of data lanes, and each element indicates
>> the bus width of that lane. For now, we restrict all lanes to have the
>> same bus width to keep things simple. Support for an optional controller
>> lane mapping property is also implemented.
> 
> ...
> 
>> +#define SPI_DEVICE_DATA_LANE_CNT_MAX 8
> 
>> +	/* Multi-lane SPI controller support. */
>> +	u32			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
>> +	u32			num_tx_lanes;
>> +	u32			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
>> +	u32			num_rx_lanes;
> 
> This adds 8*4 + 4 + 8*4 + 4 bytes to the already big enough structure for
> the rather rare use cases. Can we start doing it separately and use just
> a pointer here?
> 

There are rarely more than a few SPI devices, so the tradeoff between
making the code more complex to handle the allocation vs. making the
struct just a bit smaller does not seem worth it to me.

