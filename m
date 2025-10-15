Return-Path: <linux-spi+bounces-10678-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF52BDFA76
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E34E6D31
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5989D3376A2;
	Wed, 15 Oct 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FHruKKaT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4D337692
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545771; cv=none; b=lyoGQcZAPws3GASOeS1Jq4ZSBF3YPyEwN3uI+YWyumwyd72u/JhoisVylTziZI6qo2cD7hqLfVZr7SqDkizLqRQz2dIQxtCiGZnttG36fCFy3wRan7pcCPAXmCXt5BSN7P0cyONj1wwNNDBtXnkSDAmzDNe0hK1hfwu+5Oc7QhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545771; c=relaxed/simple;
	bh=c9DRtgxqBjR6FiucDGOUiESyKrgNeSaMO5VAfOIoETQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDGHiJpaQ8q4bcup7fIwqlBuMBnIrDh1tXUoFED5T5oB77irlwMEKIKPdTghZ7xfyYoW50Hj9o9xFehBRDG7pXjhS5j7rCVjXLLtS96Sy1YGcJ0ZzvubtzTHVOE8uISUHkpK3UHcreoUa14fzzaK9KRKdda6CltOG3asGspsC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FHruKKaT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7afbcf24c83so2066678a34.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760545768; x=1761150568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IEFETDXO+bjt4XRF9cGd360VMY2ffLoA1X5D7REdqI=;
        b=FHruKKaTe52nmQ4G4l2uekHbzSAu7GrvHbxeuiVOMqqu89gEJBxz+EmLF1580OOrS6
         6JXbLlsdBpqxhvpQbeNz8ylCyEItkACEzkBEXeAIGmc6Ra7MNWNtOiBxekFi+2xfYCf4
         dr7QyH9GxXE9vY6P+3VJ+k6tFhVJ3KIX7Oa69CQb6Pz18lCB+J2K86XN+Q3ttVaYNHyp
         lc+F60ZrhSW3UXCR4TzWkt9caIOUoqA0SMwGD2OW6d61b6N8hLFiW4JLySkM5TBNDuOZ
         gPCBkNw1xdqa4+Vrj3VALh0hQ2bLpscLep18CE8XZD67YF8eGFDgq6uZYnzkDtQZj19D
         OSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760545768; x=1761150568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IEFETDXO+bjt4XRF9cGd360VMY2ffLoA1X5D7REdqI=;
        b=hGxDMsglliKSu9vKF2W4YtVBXe88txaNsuCbzGtyox15wF61p76qf8Kv3jKRrd0A8c
         1cz/RJVrwIGbm+BnnDOymXsvHtmhe8B7KisekZA3lkuHfwBupnVmdPTd5U6AxQzVqPUr
         8frp8WONXLXJglNNaLlOa4hzULapELDcVlpUdew/6WOtWPit8snz97EEG5K7gPWSrmrg
         9eckARvGSOKDkbfXeh6o7Wv9W/2v03I58SZ+vARe1lRwYuYlQzdwRnGZn+UEAERFMJBu
         tarfoe5KILjdNFgxTj3x6Qt0Z1UYd0X2QmITAmlaCVqqv7ad7H45/pn0x4g/G390+yxB
         r0hw==
X-Forwarded-Encrypted: i=1; AJvYcCUSR8ubp7beN288mikoJmtEUTzvBXn5YvCehma1SfaxPzmnS1O5tjEAO0urDOCEMG+dz9LgCXfPaEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVTppJ1b2mibguleDy47TkzAw+Xo+/JXzdwpQCJpkXEXkZZ2J
	RomK2lyjKjGcR9zKWkSou9+8ri0PYlIArJIDuTKxgUh1dmypnGknQLXwzlNpwdO0DJ8=
X-Gm-Gg: ASbGnctRvzhe5xG7s4H6xRFmy14aS6DFELc9Ilnz3zALDvDyKHeg2mMUHCK0Cnskt/D
	zFzpsMONdO7BAthL8zyb8KsJ+qdhoYd0gXJKUEBOO7Dno/tJCT+nGAqoSMFhhs29FzctpeGge35
	g8v4dUx/FamEd/mgkTpyQcwRHNwcElXQelI0sASapmo3gKfFyxMfiOMpHMO+OpafQT0Lpn3ISkw
	VjFxkZOWjESYUh/vVdn8TpAgp1hBJf5iSoQ2rFeiXKbGludzBQq5BNO5mQq2j9t8hD6M1pmYlKP
	3o3oVAsiX580c2gy3goAFWxoY1XB5dRhE/n9BNRC2LPzaxeyAvRV34S0XnDuUd90ViOvCaXkUjS
	fot9uSLoyHAiQ/SDrytQRJP7ewAgyArvyu+1sCCp39ZZ3fefY9IP/gvsP4qknM0laYmcd+UJAp9
	gOYX8t+iU3SfoQneo5YvGjQYFJFmE/wd7RHk8z
X-Google-Smtp-Source: AGHT+IF+cLJe80ed4cj3kfbQheauCbstntwHjsgvv5HQx7cBnV+AHE/HMRPi8SW58d1ZXb7hcVX00w==
X-Received: by 2002:a05:6808:14c1:b0:439:ad1e:8485 with SMTP id 5614622812f47-4417b38c9e3mr13965693b6e.24.1760545768107;
        Wed, 15 Oct 2025 09:29:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:c482:1912:c2de:367e? ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-650181ff660sm4189888eaf.17.2025.10.15.09.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 09:29:27 -0700 (PDT)
Message-ID: <348b0d94-4b3a-454d-be67-47563808ec76@baylibre.com>
Date: Wed, 15 Oct 2025 11:29:25 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-4-2098c12d6f5f@baylibre.com>
 <3180475bd51e1e057d6aa7e1b62f564cb57a117e.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3180475bd51e1e057d6aa7e1b62f564cb57a117e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 5:30 AM, Nuno Sá wrote:
> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
>> Add support for SPI_MULTI_BUS_MODE_STRIPE to the AXI SPI engine driver.
>>

...

>> +
>> +		if (xfer->rx_buf || xfer->offload_flags &
>> SPI_OFFLOAD_XFER_RX_STREAM ||
>> +		    xfer->tx_buf || xfer->offload_flags &
>> SPI_OFFLOAD_XFER_TX_STREAM) {
> 
> I'm a bit confused by this condition. It looks like setting priv->multi_bus_mode
> (and the other fields) only matters for msg->offload but the above will be true
> for regular rx/tx messages, right? Or am i missing something?

You are correct.

> 
> If so, I wonder why doing this for all transfers if we only care about
> multi_bus_mode for offload messages. I guess you want to validate
> xfer->multi_bus_mode?

Yes, this is important to validate it since we don't support all possible modes.
The mode still applies to the individual xfer even when not using SPI offloading.

> I would then just take the switch() out of the condition
> (I mean trying to setup a no data xfer with an invalid bus_mode should also be
> seen as invalid IMO) and then use the offload conditions (or maybe simply msg-
>> offload?) for the multi_bus_mode handling. To me, it makes the intent more
> clear.

It the validation only matters for xfers that send or receive data. I guess
it doesn't hurt to check the mode in non-data xfers (e.g. ones with just a delay)
but since we needed the condition anyway for the accumulator, it made sense to
me to put it inside the conditional.

I might have put an additional if (msg->offload) around the accumulator part
since it only matters when using SPI offloading, but the indent was already
getting quite deep.

