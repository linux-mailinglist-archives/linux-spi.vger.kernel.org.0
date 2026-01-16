Return-Path: <linux-spi+bounces-12454-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF0AD38951
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56BAA3032E97
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639873128AC;
	Fri, 16 Jan 2026 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YRwPJoLm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA89311C07
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602918; cv=none; b=J9Vd1vps2F6SBEdmvJN7ln5EAHnYC9qFNSVJSLg/vUI8Y//z5chJd6MxDxCyPx0X35lpV5J1pteNGoL3vxR1wWTlZ5A+iilR1pt2hXhS1/AZsA2fXXzTgW1YgoFb50RUPGfQaAtMdptRHy9m3ozc8QLK0uUT4JrWIKvCZggYtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602918; c=relaxed/simple;
	bh=C3YVRq6FkRPAEoGrvnuuEkgrRjOWxk6ZcB+nI2QzaJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqDsbg8epm0N1KMGF4UNaKKXWmLl7zP+UoC7eCxdPk9XKUcN5k906WYY2WbcTm//OxEiqPUlGIACf/KPX0Ajwi3GLR1t9P6ouy82EiklbzUj1q+c5xhn2KHOodAKj4b683wEaGpWaMOXI3nknjempbayuqNBd9ovLcp1a6tf74Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YRwPJoLm; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-3fe3cc80bc3so1674837fac.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 14:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768602915; x=1769207715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBo+2kpI13pxODG59QrEEo48uykGVjX6vq1JpRuy1dc=;
        b=YRwPJoLm0jJS8Q9V0RlIZCHs2zHE1a0py529krh9q8pwjw9llTAyeaqs4RqloLuBWL
         cCvXZWl+hS2nUbrKwTHp5m1Qai3L6OsH5Rhxqq+wVPFAECvZZEb9FtMe3xGCyry9L1ge
         3eo/miK6jJBpx7go+z8ePYWtZBwoidSt/2ItSGJEXe/NWqrV6HePCl0nlPvCF3tS0Kvp
         YJIzKcVGb93sVa6ii29QIap9AuZS4u4APrsJAJ5tlWpqhRaX+22O2Y5D+TfPbdIxcF0y
         5VmFIsX5CxRQTiikFKT3Rl5LUasCVpamaWSTfprvNOkyceZwvDgJ7/FKxQk8CpHwyxgi
         pVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602915; x=1769207715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBo+2kpI13pxODG59QrEEo48uykGVjX6vq1JpRuy1dc=;
        b=KMHGh9S3bsFFul3T8IYZdJv/b+sJlcniruQhmalb2Dyxbgj9egWeiDt3zd/BI5KnbE
         Xu76d6q+XrPiJoCThccs1ooEUIX+/4JgYUi8mQJAj0g7ap6NQJAs37tg1JrE6ubRa0IS
         Ov5QSKqGz9txJptHMF1vQrtxWXBPcP9LkCtfqFnuHlahEbl0vXpIQnJ+e6V2Om8+8r9N
         WcKp2nR+RFbScJPPTGJfP2HjMQ8I15su6nsiTNg1efpu8ZXZ6YWQgkMBlvlSZSQLNoJy
         u5Jq91aKbnpglInqcFyPRiN8Z/xcnZ1CpSbeGciC3tnXg688YEkIUa5d9g2Hd3ChwJzw
         DHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1PKyJ7ELpHwfKszUhA8Jr8k0VCTgZhXYLdZMBKkC23wDYXjNVJOLYc4KNKi81lMQwwYWbevOXQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYL9Jl2vn4vxFYm/VGrNIwovcHBJHEFVFq1nW3xsp1VxD3GzJw
	bhqgNsyP0Gy5OW1Wtnllv9AgODYyjg35YRzTc913PaP8VZ4lGBoJhpavW+pr6bBIAGE7t4x2W0r
	3/HeMkvY=
X-Gm-Gg: AY/fxX5nDlz0UZRNgXt8Df7VJaD0FZJSRcIQz9DAKXeLqpxXp+KWUT9ZLLB6Dm4Ky/b
	cha+0+b878iRBRNnzH5D6S3NEk16eHF1F34akiGZp4ha+XxA7DU8p7yhdYKOJH3iQcCmaZcaW7Q
	7SemNpLruwuzCyGLIwgl0xp88x8PqDI97VAAjQ+F06xbQv0V+BQNHWu/ddceUYXAtiT11SYEGmv
	JNRGHhO93adjCeS8UlIaJMdB3jswM3ETvnI1JT3z/ZheNq+uzJg6gBeSSn8HXWt/oBAdMHiOHWJ
	MPG3AdOxt0ogtAgvIQM8JUuL1vm/GKtzTi2f1Nc84Vv97lDygjxJ8qEVvhjURZlGFGjnFyfZNbc
	BnEn9czSztJr34YRTPxB8CmzPzYp4YcKWXJZiDfgN2F3YMZcU8Ifv/VbenTuqr7mFyWdDfC+RZJ
	KK6KzU7Rz2w84zhw4+SsP/yulidGJNKxBrVCJEyWdmawIaX22zHvqyhaQvQqGy
X-Received: by 2002:a05:6870:cb83:b0:2e9:93c6:6e4a with SMTP id 586e51a60fabf-4044c424d74mr2115040fac.38.1768602915208;
        Fri, 16 Jan 2026 14:35:15 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:bd39:740e:f70f:5f7d? ([2600:8803:e7e4:500:bd39:740e:f70f:5f7d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd150dasm2693327fac.14.2026.01.16.14.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 14:35:14 -0800 (PST)
Message-ID: <ad688ba9-7771-4b64-a9d7-ec5100345460@baylibre.com>
Date: Fri, 16 Jan 2026 16:35:13 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] spi: Documentation: add page on multi-lane support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-5-295f4f09f6ba@baylibre.com>
 <20260114091024.390432c0@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260114091024.390432c0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 3:10 AM, Jonathan Cameron wrote:
> On Mon, 12 Jan 2026 11:45:23 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add a new page to Documentation/spi/ describing how multi-lane SPI
>> support works. This is uncommon functionality so it deserves its own
>> documentation page.
>>

...

>> +
>> +For example, a dual-simultaneous-sampling ADC with two 4-bit lanes might be
>> +wired up like this::
>> +
>> +    +--------------+    +----------+
>> +    | SPI          |    | AD4630   |
>> +    | Controller   |    | ADC      |
>> +    |              |    |          |
>> +    |          CS0 |--->| CS       |
>> +    |          SCK |--->| SCK      |
>> +    |          SDO |--->| SDI      |
>> +    |              |    |          |
>> +    |        SDIA0 |<---| SDOA0    |
>> +    |        SDIA1 |<---| SDOA1    |
>> +    |        SDIA2 |<---| SDOA2    |
>> +    |        SDIA3 |<---| SDOA3    |
>> +    |              |    |          |
>> +    |        SDIB0 |<---| SDOB0    |
>> +    |        SDIB1 |<---| SDOB1    |
>> +    |        SDIB2 |<---| SDOB2    |
>> +    |        SDIB3 |<---| SDOB3    |
>> +    |              |    |          |
>> +    +--------------+    +----------+
>> +
>> +It is described in a devicetree like this::
>> +
>> +    spi {
>> +        compatible = "my,spi-controller";
>> +
>> +        ...
>> +
>> +        adc@0 {
>> +            compatible = "adi,ad4630";
>> +            reg = <0>;
>> +            ...
>> +            spi-rx-bus-width = <4>, <4>; /* 2 lanes of 4 bits each */
>> +            ...
>> +        };
>> +    };


...

>> +properties are needed to provide a mapping between controller lanes and the
>> +physical lane wires.
>> +
>> +Here is an example where a multi-lane SPI controller has each lane wired to
>> +separate single-lane peripherals::
>> +
>> +    +--------------+    +----------+
>> +    | SPI          |    | Thing 1  |
>> +    | Controller   |    |          |
>> +    |              |    |          |
>> +    |          CS0 |--->| CS       |
>> +    |         SDO0 |--->| SDI      |
>> +    |         SDI0 |<---| SDO      |
>> +    |        SCLK0 |--->| SCLK     |
>> +    |              |    |          |
>> +    |              |    +----------+
>> +    |              |
>> +    |              |    +----------+
>> +    |              |    | Thing 2  |
>> +    |              |    |          |
>> +    |          CS1 |--->| CS       |
>> +    |         SDO1 |--->| SDI      |
>> +    |         SDI1 |<---| SDO      |
>> +    |        SCLK1 |--->| SCLK     |
>> +    |              |    |          |
>> +    +--------------+    +----------+
>> +
>> +This is described in a devicetree like this::
>> +
>> +    spi {
>> +        compatible = "my,spi-controller";
>> +
>> +        ...
>> +
>> +        thing1@0 {
>> +            compatible = "my,thing1";
>> +            reg = <0>;
>> +            ...
>> +        };
>> +
>> +        thing2@1 {
>> +            compatible = "my,thing2";
>> +            reg = <1>;
>> +            ...
>> +            spi-tx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for tx wire */
>> +            spi-rx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for rx wire */
> 
> Whilst simple I'd kind of expect a multi lane case as the example, or this and
> the multilane one? For me the comment that follows is sufficient for the 1 lane
> offset case you have here.

I thought that is what I did. I have one example that shows multiple lanes (ADC)
and one example that shows the map (Thing 1/2).

But I guess you mean that you want a 3rd example that show both the map and
multiple lanes at the same time?

I chose these two examples because they came from real-world use cases that
drove adding this feature. We didn't have a real-world case yet that used
both the map and multiple lanes at the same time so I didn't include that.

> 
>> +            ...
>> +        };
>> +    };
>> +
>> +
>> +The default values of ``spi-rx-bus-width`` and ``spi-tx-bus-width`` are ``<1>``,
>> +so these properties can still be omitted even when ``spi-rx-lane-map`` and
>> +``spi-tx-lane-map`` are used.
> 
> 
> 


