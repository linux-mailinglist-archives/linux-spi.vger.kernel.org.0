Return-Path: <linux-spi+bounces-5519-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2879B1FF2
	for <lists+linux-spi@lfdr.de>; Sun, 27 Oct 2024 20:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3A82813D6
	for <lists+linux-spi@lfdr.de>; Sun, 27 Oct 2024 19:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4617C219;
	Sun, 27 Oct 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nzxP9hJW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06838145A0B
	for <linux-spi@vger.kernel.org>; Sun, 27 Oct 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730058744; cv=none; b=EQi6VM/iHVBvfAnrhxscTHtx1d7lxFI90Zwqt/ZDmmK5ZIevT46dCZ8WmSr9e2qdGYOXrZ1b31ELZtt1bg1K2Dookghz607Bk8dHQV0Fwr6S4hkLCVjgOguVtu7UvAVmLMz6yoWwtLBMl8eLMN3uu29BlHtWcN4jIpK0V9FR7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730058744; c=relaxed/simple;
	bh=ueiLs+nLh8dmTHigot/Hj12sD7IB5HdWNU888qp/+8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFaBR+SU7qoX+VT3pqnxwFthh3gjYvogW7MqLFBpQILbM/bSzulAHd79v5/gkDZvPEQ6GZDfWG43xCbFX5u7e42e7b/CWQAATyZCdN2TKp1BrJXX+XYB9Apq6AJiX2fXroLJDOHkLvGLIGllQK/cNFdM2pxUTgw3s9x3PIsfSas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nzxP9hJW; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc05007daso1974761eaf.1
        for <linux-spi@vger.kernel.org>; Sun, 27 Oct 2024 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730058740; x=1730663540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9de6YcBQ4CAkrMC7sV/+iMopqKB6hodYcK4fGhfmxw=;
        b=nzxP9hJWDi5WtCVyPod3kCMQJH0dWdV2ypIrCpHez1mgBjgyqBA41St91MngZ2miRV
         tnRyY+Nbd6V1Tp5UzRa2UFa90JD0szKVZsJrP8ZW+4RZc0zikMNj1xHroFzHdDUvb/zZ
         LZzTHDQ3cJ5zixqcvndUIrOleSGmGApK8OyYy/0gJrJoCjxKDZGeXrEj4lm1RyqEjKa3
         UzK+wF0YQIOBNPE4j+sNfXP2DEdudP1AmupHT26gofd2Trfe/jN7NbG3Tsl+ysUJMv8P
         bhYtTt4ISLYzzKzueRLVsoj8xmMI+12a0WnmucqF3+yuCb4z45hlXE1gg9hrp7z++0+v
         uRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730058740; x=1730663540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9de6YcBQ4CAkrMC7sV/+iMopqKB6hodYcK4fGhfmxw=;
        b=RXEJZZfhZDWSMP6Sw29+Tlhsqclu2KqLQqB9JczFd0Xr2bM3xyYTDBtCdCVar7Vam/
         lXmrTusx6A96YArl7UBE+mPAjWdDhSs+YtxoiVu4a95GzdFh6qsGorskYw5S1DYYupbL
         v/e7eOY2kKlpqJ17qfSmaERjIIDs5gT7U8SeuXNsOFMGHdYMOHzm/XZFfqvBIx3lVsAX
         kNqhSB2EvtguadL2pVs8vDdJagDzIEQM5iPB1frVuRtyGfWdu0JtoHMWsPlx+ZSLOmYB
         jsmJ1Gz1thD2VQESwzpjR0V1uS+wawngo29A6uzZcjUnNlca5tvCX3x6KBVYpGxZu1P8
         WHgA==
X-Forwarded-Encrypted: i=1; AJvYcCUupwL8D+L2jPEEQS3h4MDf3me5g3GUVfZXaYyLTSVDqGxER5aOwpa5Nfby4D8PCilEvu+BYckev7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEULXxOAKTGDCgBFpVAR122rXjHsbg71A+x2I4+Rc4UKo6a08h
	5LRRU8+VuYT7UVvFO8VUKJADwSjiQDtzBvL1+/nG6DqB/M7OPqtfTs8xqLF3Fb0=
X-Google-Smtp-Source: AGHT+IFepVB2QqdqP+C+Q8M8uASn8/LF4xicUTp5DH6V9fqU0SsmPYBPQioFgC1LGcXGMjTtSzGTeg==
X-Received: by 2002:a05:6870:15d5:b0:278:978:9e9 with SMTP id 586e51a60fabf-29051e0360bmr4809398fac.44.1730058740066;
        Sun, 27 Oct 2024 12:52:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-290380f4bdasm1563675fac.46.2024.10.27.12.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 12:52:18 -0700 (PDT)
Message-ID: <2679570d-6255-467b-8312-117e553a52b4@baylibre.com>
Date: Sun, 27 Oct 2024 14:52:17 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 15/15] iio: adc: ad4695: Add support for SPI
 offload
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-15-f8125b99f5a1@baylibre.com>
 <20241026170038.4b629cff@jic23-huawei>
 <5a090847-ee53-41be-ad28-b7604cf9020a@baylibre.com>
 <20241027091244.2fe3c0ad@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241027091244.2fe3c0ad@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/24 4:12 AM, Jonathan Cameron wrote:
> On Sat, 26 Oct 2024 19:01:53 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 10/26/24 11:00 AM, Jonathan Cameron wrote:
>>> On Wed, 23 Oct 2024 15:59:22 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>   

...

>>>   
>>>>  static int ad4695_probe(struct spi_device *spi)
>>>>  {
>>>>  	struct device *dev = &spi->dev;
>>>>  	struct ad4695_state *st;
>>>>  	struct iio_dev *indio_dev;
>>>> -	struct gpio_desc *cnv_gpio;
>>>>  	bool use_internal_ldo_supply;
>>>>  	bool use_internal_ref_buffer;
>>>>  	int ret;
>>>>  
>>>> -	cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
>>>> -	if (IS_ERR(cnv_gpio))
>>>> -		return dev_err_probe(dev, PTR_ERR(cnv_gpio),
>>>> -				     "Failed to get CNV GPIO\n");
>>>> -
>>>> -	/* Driver currently requires CNV pin to be connected to SPI CS */
>>>> -	if (cnv_gpio)
>>>> -		return dev_err_probe(dev, -ENODEV,
>>>> -				     "CNV GPIO is not supported\n");
>>>> -
>>>>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>>>>  	if (!indio_dev)
>>>>  		return -ENOMEM;
>>>> @@ -1002,8 +1374,13 @@ static int ad4695_probe(struct spi_device *spi)
>>>>  		return -EINVAL;
>>>>  
>>>>  	/* Registers cannot be read at the max allowable speed */
>>>> +	st->spi_max_speed_hz = spi->max_speed_hz;
>>>>  	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
>>>>  
>>>> +	ret = devm_add_action_or_reset(dev, ad4695_restore_spi_max_speed_hz, st);  
>>>
>>> Why do you need to put it back in devm? What happens after this but without
>>> a driver restart that uses that faster rate?
>>>   
>> I should have added a comment here as this was a weird bug to trace.
>>
>> The core SPI framework sets the initial value of spi->max_speed_hz
>> to the minimum of the controller max rate and the max rate specified
>> by the devicetree.
>>
>> The SPI device lives beyond this driver, so if we bind the driver
>> and set spi->max_speed_hz to something other than what the SPI core
>> set it, then the next time we bind the driver, we don't get the
>> the max rate from the SPI core, but rather we changed it to when
>> the driver unbound.
>>
>> So on the second bind, the max rate would be the slow register
>> read rate instead of the actual max allowable rate.
>>
>> So we need to reset spi->max_speed_hz to what it was originally
>> on driver unbind so that everything works as expected on the
>> next bind.
>>
>> (Or we call this a SPI core bug and fix it there instead).
> Definitely a question to ask.  Directly accessing spi_max_speed_hz may
> be the fundamental issue as I don't think the driver is generally
> expected to touch that in a dynamic fashion.  Should we be instead setting it
> per transfer for the ones that need it controlled?
> 
> Jonathan
> 

The problem is that we are using regmap and that doesn't have
a way to specify the max frequency for register reads that is
different from other uses of the SPI bus (i.e. reading sample
data). So we could fix it in the generic SPI regmap (not exactly
trivial) or we could write our own regmap read/write callbacks
in this driver that properly sets the per-transfer max speed.


