Return-Path: <linux-spi+bounces-10682-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F87BE03DE
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 20:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C555401D5
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F85C28E571;
	Wed, 15 Oct 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OZjNTkPq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7C24DD0E
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553993; cv=none; b=q/r5q8eHAPehuGX48tTdnrLxRiqzmwPFuBSHZGjTDejbr3u+izWdso9V+2fwssRnIK7iqgyzGQ/qkAuJ3KmKWWlf4aPfTvnC2ae2N/6NwM4Vq7OjNXeAWNnlinM3npW3rCoRNT6NYTp2bwoMnzlKrUW/WDcLowtrxeR7IMkd4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553993; c=relaxed/simple;
	bh=YvgiZGtPFbCt2IU0u4vPOg9X+YBDn8GnfhZjI9AxjG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgO2VCVgZBwfaH1/BF0bHfcGcxKt70CeFTXynhNtmM2rd75pUsUhE2vuvqH45Ip2i2nmgS1Jmxu+16Ib1GpIsPnJios24gA2IxL1ueHyK0VBInPT+8+IR3MurIz8vIrE0mjMhAmcwsQk79B9uOU9wEM+oRyEeMbYrqvH9YzRIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OZjNTkPq; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-79f79e37c04so5234736a34.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760553990; x=1761158790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1W1dpMIImxvQoP7g+++7QUy7cb9UdrUIxFQdJbQORk=;
        b=OZjNTkPqz6clw+zEkoi2JtBkcRSS5faiKVbPkh8zt+IremB1i11rtHe5SwqJDD8OI4
         ZtVT8D9M4NqvlSRPdHzXyNICvhv62MJ/cgu2R6N1mNyj2GuXDxjWARQo2ZgZawb7YFJs
         eqG0M2cK8bbxcmLAkIvs/tzucffpGHlE/l36fuZV4BUbU5pc5rlsKr+hsGUe3iubF2hq
         JvL5FbMHayWuKx9XlCpuFfcRKjqvemqLNq5lS9bZ8eT14FWGuGoS4I4Zhnz8pZrR1XXc
         fhwIrWiu+V31qK5MZh8vB3i0cr9chgxS/cA0Eptpi8IiPCHNOS0M7oTOXRx/WuQGFKg8
         09WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553990; x=1761158790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1W1dpMIImxvQoP7g+++7QUy7cb9UdrUIxFQdJbQORk=;
        b=n4xH1XpC60qP1qNaTKb0xm5Td+za/WMORxOhUl6c325BNpfvlsEgUIdKwE9cxEZiK7
         aacVT7LxwpeifaPD6/qmZVaPHS6V1IjWeRxOK1b6NRcAdBuv8j6PYO+ZzyHEgvBZfS4b
         +4R+6gAfoSgVSqEoVq7SXsnbe6tjX5uEsdhhdghl7RCysdRc7A8NJhh0k0ar2wUMsx1K
         sz3CYaU0izNg26zZcit5AuIfChbcoDkg9mOEOIPMcdIIlodbn2vn6GlU/jclk7mckgUR
         k+2kr6/BJgpmXOpO7GgFMPYHLys1gbO8a5ZXKgVOw6tr59aMVnp6Gdgy5L7uPUPHwbmX
         6jKw==
X-Forwarded-Encrypted: i=1; AJvYcCV6uXZJEaSItmBo2rwBkjKYhndZOdE3CdFdQWCJmUmgLIt2B3nzFExGPHYeZVitk5mzF1lPYQno9wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyERzVfynQxEt9sJpqyQzPhTUZF0ofK9u+Hcpb0gf/nfqt9dRkD
	AsoHziECY6P+kp+H+wgsmRUXqlrp3oxVNafwrXVwnuOk1CbOSZ+htkif/+rmDzx64FA=
X-Gm-Gg: ASbGncvEDzqjrEJb0GbkVOnR5EMXJzpRL86rTEncIQ69oWXhzMIHrP0qpfpsUGAdgVF
	AHWASrNc1HUhjXvEvWoFR8L+GThQrjR01o8u6vNPgB2CnAAsPsWOhcR/oC4JmXG90StOHI5N5rD
	qiZWZ7p4YJwIdgNbflpytUrNnrCC5IDS1GOGTkw4Z9WXoOwPdrt/aLHN/ddJOuR6lWwQB1NCMY4
	LTxZfZcY5s+d0nMlwXm2mOj6o1kY51ug2FhlNX2jl75s/1pWXCxrNz9h8tRHuqgiQgtO+qb2wh4
	owwGfHXQJnS5eiD/nswykfkrh4xDWRVHsEFCq6RMjS6eexcTNzunrPiHD6wEBc0TRKHVhbO0vME
	XXC9bRw0XO14/y4gATg7rZLkUqp09r4/DodShrmdj7OInPfjwzh6Tz66/xlOof9Oyku2JxnqpGa
	mSgHf2exmDKroRd0Y=
X-Google-Smtp-Source: AGHT+IEeWyUK5JU0xMQ0zLXGTri5uRlu04b7SEkveGRRQqga9ddNeRw/aypGJc8FLMQHLk6d2PIOZw==
X-Received: by 2002:a05:6808:1b13:b0:43f:7e97:397f with SMTP id 5614622812f47-4417b3de534mr14932239b6e.41.1760553990406;
        Wed, 15 Oct 2025 11:46:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:c482:1912:c2de:367e? ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441c9209c34sm3068700b6e.8.2025.10.15.11.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 11:46:29 -0700 (PDT)
Message-ID: <1d9704c6-1729-4288-973b-3b3596609553@baylibre.com>
Date: Wed, 15 Oct 2025 13:46:27 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ad7380: Add support for multiple SPI buses
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
 <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
 <ef452c01679bee2c8bdbefe1df4775c432f8b345.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ef452c01679bee2c8bdbefe1df4775c432f8b345.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 5:36 AM, Nuno Sá wrote:
> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:

...

>>  
>>  	if (st->seq) {
>>  		xfer[0].delay.value = xfer[1].delay.value = t_convert;
>> @@ -1124,6 +1118,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
>>  			AD7380_SPI_BYTES(scan_type) *
>>  			st->chip_info->num_simult_channels;
>>  		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
>> +		xfer[3].multi_bus_mode = xfer[2].multi_bus_mode;
> 
> Why not doing the above once during probe?
> 

There is nothing else in st->seq_xfer[3] that gets set in probe, so
I didn't really consider it. Seems like it should be fine to do as you
suggest though.


