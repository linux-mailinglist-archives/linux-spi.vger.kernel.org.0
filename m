Return-Path: <linux-spi+bounces-11837-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ED1CB1757
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 01:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10EF30B117B
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 00:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9469ABA45;
	Wed, 10 Dec 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o2mVzEiK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8443F2110
	for <linux-spi@vger.kernel.org>; Wed, 10 Dec 2025 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765324930; cv=none; b=dKG34ahpze65X9SeSDP+uaY/V1Bi8kT0l69dqjgUByN/uvBnCU4pTpeebNp2swlaibzgp5RXHwHl3So92O2EN+mlGgVMuUAlRsGiV+L6macI4/aNVo3Dshb8tlh/uIFGaR4a+mGTp5n4Dhv6vGX5tpsYMcoRvaqCI1VD4OGxcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765324930; c=relaxed/simple;
	bh=XBETjClpZtzYEHwW4MMmqqNrYdl+mNXjJ9Nw2T/r6ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHe5vvQDKi0S2ehAuSnviUfoLphi+bUHqlDrUd39dorwmEFG9qY0sx4BAJDa8psDDEdbl8fByPJ6e4RN9nsLXe7yv84DzTHRREN6uWgqc4Pd3gYY3yGbh4WGHMXw9M22TjA0+mHYryrjrPWQl3+J5KQe3yInvOqQAYkKZ23/3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o2mVzEiK; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4503ee5c160so3381772b6e.1
        for <linux-spi@vger.kernel.org>; Tue, 09 Dec 2025 16:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765324927; x=1765929727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTbKv1vVkKrPnK5tPm0Gi9Pxe85hhjzLCItkx/m3ECs=;
        b=o2mVzEiKtLvParW8MIt+HyguZ8r4uGUCDt2dduQDFXE0LzWQFw0gjui02HG+4IhNkl
         409BV5nvOa059qM61XKZKJ3HYts1U5KAyamuSlkpSV9yNn4wvEQXYGy1/mum7Xhz91O/
         r9NOFOAbwP5vNLpNzyyJTdS/bzJBbL2hlTCK2jtXzSswH+ZgcZjuiSbDpKUFOAVwUqpg
         jC+ESX4b7NsnY3XGW+Y+O6d2S9jP+84wQs8eL6YXcLA0ohvAJZ8UfQuatIeurd78LrNf
         VQotZNh1RJHZD/xZY7Sq/iOzval7WeNL8woxmotj5rgRBzLzkfrkQ6D6JRNGqCUVMnqh
         NMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765324927; x=1765929727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTbKv1vVkKrPnK5tPm0Gi9Pxe85hhjzLCItkx/m3ECs=;
        b=PdaouDYWkGSufGSvRdiTxUVycklsPbb/UFQniMxUf1bLUZ8nQwwAN6XkD6uLKQRb1C
         i89AljAkFxm6PUmlWeTQZOn7//Q7Hk+Cfq92wyOSrfvjDf1/FdROqrq4uPnSEONDAFVk
         e6/yHJ4PCt7ZgKFcpiq0IxtbOxFlmrXt/6BFXJc8cPhxvXFrmF7MBkaYkkD9dWONmTPl
         t2h2tdO6cKUMVUACFGsx1czmEDIDwBRmEtK12Sp7/8HhbSvjgCIx4dGd3oliU7MG1zSi
         xX5AerrgbqMACUrL4BSOkiKAGAzXX87w8rLCrm+8OoT9sH88+UdyL+38R8FDPFZ/bqSm
         0FbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzRLHq/dqGwVBAlD8vHThHgWc9u1lz+u3QfL4MzCwS5b8aqfqWzZ4nIgQzw7r0dEYnbJ9G7MiKhRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy272Kbips8XuSbIGEn4uxZVY9q75TRad9SPROlAlfkfdZuJduw
	6WNP1CjYPS8rtpvCg8ipfI3Ip8eaCRwmxguFTgeET8qUrIKbFZn6vcOPrYl8IPke9EE=
X-Gm-Gg: ASbGncuXggrnxJCdrfUMZXW3lp+KgeXndde1kzrMKv+gNtMQvMjPtT3X9BC0B0KeWza
	WYp5Rg7dnm0JJCu6gb8oRxzB/2bpkOCxtyt3kBz/urW7rF/a8CQNlGun40T+gVgpnlE8g0hePUs
	MN4IiddSCdU31NmotewJaX9JcanV614zQAq7G0l/xnphezkR8OeWJYxuyjmzZYY+bmmXI+HfvBe
	jobAt4/9AkXVUk9vMAgweYz8Y+HbTq+pLOyz1bq6DwRj8ErVx+vFJHNZhGcCIgVjNwPolALiuN+
	amfSWr+p2dDmkt0cmnAnpiZ4mBbNt6KUtAwsuC1U/REKTtYUi850froyUWhohUHlzEAahi6yBxm
	ORBnsplm5QT5XkWwlELvkAcW2cGNbJPUxrhZYmZ+Yl+U+89H0Ey70KqW4KmOX9sRYkqr0d8xS/S
	T37roZqkjN9jMbPHWTiR8hhL5AilKAyTBLoTqjNGUB5cRI1bD003MfMQTZNBaT
X-Google-Smtp-Source: AGHT+IGelHO7cGCcA6PiEhLrrcOt3bTb3YgxI0Xmgu0mriW2zt4R+0Laragye1p41eo80Tns9fCO7g==
X-Received: by 2002:a05:6808:3989:b0:450:d773:ad1e with SMTP id 5614622812f47-45586960a3bmr393107b6e.66.1765324927565;
        Tue, 09 Dec 2025 16:02:07 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1635:b560:bfdd:f758? ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f6bc9d5sm8556424b6e.0.2025.12.09.16.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 16:02:05 -0800 (PST)
Message-ID: <2aca99a6-9541-4cd4-933e-815ceaabe365@baylibre.com>
Date: Tue, 9 Dec 2025 18:02:03 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
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
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-4-34e05791de83@baylibre.com>
 <aS79ex5Konr_EeMA@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aS79ex5Konr_EeMA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 8:53 AM, Andy Shevchenko wrote:
> On Mon, Dec 01, 2025 at 08:20:42PM -0600, David Lechner wrote:
>> Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.
>>
>> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
>> lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
>> reading from simultaneous sampling ADCs that have a separate SDO line
>> for each analog channel. This allows reading all channels at the same
>> time to increase throughput.
> 
> ...
> 
>> +static u8 spi_engine_all_lane_flags(struct spi_device *spi)
>> +{
>> +	u8 flags = 0;
> 
>> +	int i;
> 
> Why signed?

Because it is conventional.

> 
>> +	for (i = 0; i < spi->num_data_lanes; i++)
>> +		flags |= BIT(spi->data_lanes[i]);
>> +
>> +	return flags;
>> +}
> 
> ...
> 
>>  static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
>> -	struct spi_transfer *xfer)
>> +				struct spi_transfer *xfer, u32 num_lanes)
> 
> Side note: this bool parameter makes code harder to follow. And now we have
> pointers and integers/booleans to be interleaved. Perhaps reconsider the order
> of the parameters (and ideally get rid of boolean by making two distinct
> functions?).

There would be significant code duplication if we split this
which would make it error prone.

Perhaps a bit unusual parameter ordering according to data type,
but they are grouped logically, so I think it is OK. `dry` affects
what is written to `p` and `num_lanes` supplements `xfer`.

> 
> ...
> 
>>  	version = readl(spi_engine->base + ADI_AXI_REG_VERSION);
>> -	if (ADI_AXI_PCORE_VER_MAJOR(version) != 1) {
>> +	if (ADI_AXI_PCORE_VER_MAJOR(version) > 2) {
> 
> But this includes v0 as well!

I think it is OK. There was never a version 0 released, nor
is one expected.

> 
>>  	}
> 


