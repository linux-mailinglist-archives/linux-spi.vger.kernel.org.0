Return-Path: <linux-spi+bounces-1346-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71B85453E
	for <lists+linux-spi@lfdr.de>; Wed, 14 Feb 2024 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0626D1F2C0CE
	for <lists+linux-spi@lfdr.de>; Wed, 14 Feb 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9ED168B9;
	Wed, 14 Feb 2024 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fE2jHZlp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA014ABC
	for <linux-spi@vger.kernel.org>; Wed, 14 Feb 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902980; cv=none; b=BBKFJHQCNW9K8DRADVsEgQ8dafVvRxIxqWGzt1e3+IV3FkYUf3t7Q9/eDvw5/+PIPY4ScC0GFmwYGofFjfAg+XxQJdPdBGTsbB0MpJe9J8qr8EDAI+7RfCnECQfzjUoyADTZvbrqyuv1JwtH6F7SWaHWeA7yxLIQNr4a4jjWQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902980; c=relaxed/simple;
	bh=EQalAKDLMQ7i1XcshRX2Not5YF+7MqvcYpRLQ7QRYyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PES1ZvJdFGcanhZ7Mi4YzCcGvD4hKatMaOwXOfWUZ4F4r0Ri228jcGYN6sq5gluN6YtVcJRg8QTgw/h+bRmxDuTyA02dpVLBLDuH84kTX3tPm4BHe6xvtFurEeGn5XtxcGHOiCpjhhCPWzgwRW5QmDutz5MorBzTfL5TBU13Rak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fE2jHZlp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511a04c837bso1019405e87.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Feb 2024 01:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707902976; x=1708507776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaIiFR3On41h6tc9o9ZJheGqRmPrIZwysG2Ikqlaz3A=;
        b=fE2jHZlpQKWp5jeL7CYtp/JJVxabu8jThxk6xYdzva2CjVSBMuoWsijwN716HQuudC
         SF2rlb6D99fbb83ovJQLuF7S1shem25L3WOwMW3RDD+sbVRF6U2l1X/abEgzJOoNZNw4
         pb52m4U4ODm3TfejuDtwu3i5ftUWr1/ZC2ld/cUpbl8qh7Ys6UqYH/Jpv/u3srSfcvAt
         KEyw3PYnRiWALCMdWSHLS+DDqBSSoFEUWi2Tohs4j0zTwN5nZkNvZaFQ81b6JmL8jG6t
         BbMBhI8aO25JLBgUlzhbErkZyRhcvuI2V/g745LYsBr/xvAvyb9/ko3ciGOS8yuZd6vh
         IUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902976; x=1708507776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaIiFR3On41h6tc9o9ZJheGqRmPrIZwysG2Ikqlaz3A=;
        b=QKbBuJYPN39LQb0XyMAYHcsYoh9lRP1pyZKCsiGa55Rm9YhA8SQsVCwF3xUrW1VHHA
         EezuY9FmNx8ubhz/YHLoLg3mw7ebnwiJBvx8nGJ7NvVP56hQ64RRD/qllfjkbLnmt7fd
         LCa6RpRElXYfyV45OzQM1fcBW083pEf6h61K7M3u/bKapI8ezz/qqxPzYRZodW6IPStV
         RjnzMLlo2kUSVeHIaRODGRrYvtrDH55QXyfFeTLato1fzrX3iOfwKnOSSMrnrjH1kpUr
         aTTkM3lIvrfeLPmZJDwssPMJrO4r2aYLLESPyPdwcSL+1HHPCpbLcGTVQCNgkyBUReKX
         aXvA==
X-Gm-Message-State: AOJu0YwtCqE9Ne16ip6EcuiEpy2Dv2dSa8Vk1t9woEY2dsxGIhRySIRD
	B27j8SGwEibYy7axGyzqS90Gyr6eTkxlygLvYyPK2EHcWoSPlJRw9AStl7QhxJc=
X-Google-Smtp-Source: AGHT+IEPaPev8mq9yNex0xMT7oLMK9BzcFk5HoZ1wPT+Wy0i/qNKreBpHshf/CiK8BITXXvvgk0A8Q==
X-Received: by 2002:a19:7717:0:b0:511:54f2:df07 with SMTP id s23-20020a197717000000b0051154f2df07mr1263243lfc.11.1707902976082;
        Wed, 14 Feb 2024 01:29:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXS5Vr5UuX5BNKS8v/mi5XV9iNfELUz/NPEeFedP2cthhm3vMwChbKrggQZDb81efYi1eOHQUMz8PoVugv2gQPxUYybXLgnJNrmDWS1c2RHjFy95NW0Im0NBoXSsZeGaEuZTdKp7qWM8eZ61F4sDAVYr4ftlYMF59I8/yR98dW9VLygwOmkc4lPJNqcfpeiJbLGxtTuTfhsKQpAajLvGavFtLvifoHatSMGycYLPRr8h75k1jIKulYLZ5drccjY8g/kKKvNhoPvYaTfYCBa/7d+g6ueVVuxUBJD+KV4HBkWexaS5FYKl6QU
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b00411e1782d33sm1367616wmb.23.2024.02.14.01.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:29:35 -0800 (PST)
Message-ID: <c5230e6b-b988-4fdb-a8d6-543c3e9cda23@linaro.org>
Date: Wed, 14 Feb 2024 09:29:34 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
 <b0844e5a-ee4b-4608-99a1-877660e01d57@linaro.org>
 <CZ41HDHS7WX6.6MJL1O2PBVW1@bootlin.com>
 <7b3c08b0-80ed-4409-96d4-d55b938df6f4@linaro.org>
 <CZ4O9QACM45B.2HA0L2O4QL5PL@bootlin.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CZ4O9QACM45B.2HA0L2O4QL5PL@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/14/24 08:51, Théo Lebrun wrote:
> Hello,

Hi, Théo,
> 
> On Wed Feb 14, 2024 at 9:00 AM CET, Tudor Ambarus wrote:
>> On 2/13/24 15:00, Théo Lebrun wrote:
>>> On Tue Feb 13, 2024 at 1:39 PM CET, Tudor Ambarus wrote:
>>>>>  /**
>>>>>   * spi_mem_exec_op() - Execute a memory operation
>>>>>   * @mem: the SPI memory
>>>>> @@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>>>>  		 * read path) and expect the core to use the regular SPI
>>>>>  		 * interface in other cases.
>>>>>  		 */
>>>>> -		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
>>>>> +		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
>>>>> +			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
>>>>> +			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
>>>>> +
>>>>
>>>> Would be good to be able to opt out the statistics if one wants it.
>>>>
>>>> SPI NORs can write with a single write op maximum page_size bytes, which
>>>> is typically 256 bytes. And since there are SPI NORs that can run at 400
>>>> MHz, I guess some performance penalty shouldn't be excluded.
>>>
>>> I did my testing on a 40 MHz octal SPI NOR with most reads being much
>>> bigger than 256 bytes, so I probably didn't have the fastest setup
>>> indeed.
>>
>> yeah, reads are bigger, the entire flash can be read with a single read op.
>>
>>>
>>> What shape would that take? A spi-mem DT prop? New field in the SPI
>>> statistics sysfs directory?
>>>
>>
>> I think I'd go with a sysfs entry, it provides flexibility. But I guess
>> we can worry about this if we have some numbers, and I don't have, so
>> you're fine even without the opt-out option.
> 
> Some ftrace numbers:
> - 48002 calls to spi_mem_add_op_stats();
> - min 1.053000µs;
> - avg 1.175652µs;
> - max 16.272000µs.
> 
> Platform is Mobileye EyeQ5. Cores are Imagine Technologies I6500-F. I
> don't know the precision of our timer but we might be getting close to
> what is measurable.
> 
Thanks.

I took a random SPI NOR flash [1], its page program typical time is 64µs
according to its SFDP data. We'll have to add here the delay the
software handling takes.

If you want to play a bit more, you can write the entire flash then
compare the ftrace numbers of spi_mem_add_op_stats() with spi_nor_write().

Cheers,
ta

[1] https://ww1.microchip.com/downloads/en/DeviceDoc/20005119G.pdf

