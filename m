Return-Path: <linux-spi+bounces-3507-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80000910ABA
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48571C22500
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56E1B0131;
	Thu, 20 Jun 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yqqFD4t1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645871B0124
	for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898742; cv=none; b=QwuaTGedMWAxx5EAGF6dir0YY+xdztnSsjQ+iXfzgzJLzNpMreq5p9syYle8QRD9BjuHAeD6JhV0FDSVUut7FhkDxBzUMnDJeo+LuEczzEs0xIlAxRhxT9zBUji62BDK/EUsdbY/z6rkLR97uaiYQFaGtLPm57nGAHwkeJS01Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898742; c=relaxed/simple;
	bh=BYNxbdP/tSiZdSJx/SObM+Ky44A9Mo1KpwOH14PHu00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYzh55ZUaWrxgyOSgD638kAG5m9Dk92JwBozDI2Zn3PWp7yALP6V/tIWUKii4UdAhwSO3pXky2koVTaO0/e2/KS68nQS+IczsMh0567kskxxOAT/4ywi82clUMOSybKGMxPN79YK2rxJQ0ngdSunzJhXk1XgrhGjsT4csHazDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yqqFD4t1; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5baeab9fd60so434108eaf.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Jun 2024 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718898740; x=1719503540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5K50mR+1xPezwh+gwNk3sB+K93FGplia3k1sTjlMTk=;
        b=yqqFD4t1+EIUYmNn8Gfs+mA2W8etFYgFdi72afx9GQuYAJX/1wIKLRMbZ/8sfeWp8D
         RPrmUwV7JmUy+3Z7hshgkPCSgDHBXaJas/Txstl4wAg1ftAmqTXmNKSKctroous9s2g6
         M4pS+9my7BHYo+3HdM7jmpGl+5IJKDVo5UPUIOM1ZZ3uJVBDxd62m+rHLYV6GSNhuQmJ
         inN5oLgpjX99O0XUxYSSw8FjQCZViKJ+K15MUyPcf/G2raJwyGimEZDsZ7hE/GA7NQMR
         uFU5IH/47tMM9yemvsLgy7LXabR4b2qUt6VaPL0WcBqJM8hm2U0QcCMQzGxr2d+TOYlt
         O55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718898740; x=1719503540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5K50mR+1xPezwh+gwNk3sB+K93FGplia3k1sTjlMTk=;
        b=qzIeyS8//E1+urMX2tBcq3M79yK2vLIKrNvdsPfarLlOf2wSIOIdFBXKWQSZLxEW3z
         hUVsROwZViLuW8yn8ygq3F5qcKRXnMokyOVVElfTsMY7sLce7pL0zLMKybwhEVfmg0zQ
         CU6IZnKmnIJQXufe5wz6uyrTiIQ5nYe/EFmfwC+3Th+ZO/Mn0lFGz6NmDS+zBAc9q0eZ
         EE/sxR0nLK7M/vOwTr/eyQYsEfRSZUlPnvwYS+XYMLGMukiPWYn9fqBZysOdnFS3amXv
         rZ2msOu+QhtCt/iohracPEWu1qwkOYpEmobhoFi/8NLU54Zq3zooBCtTgaSC4HUj4WSy
         ONpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHb/E+SEcWjBjCFwS9qEsvxpreqmA2qcWM7rxmoZ2dgEfwFN80GAW6P7uStUqLttQQmDJVP7lZDAgFx7VAMCOdM+2OfVCWvHIv
X-Gm-Message-State: AOJu0Yz6l4gDopAtdNuto3TqDzFu1jJRRw0/h0uu9XmynyHKOFlfllVG
	pgs9yasBKirCjPbZ5dsR2Ao+Vwppo4w/7SwNkYvpQ4WP/D7P0fg5EV0U31BkyTA=
X-Google-Smtp-Source: AGHT+IHncNjOje8u1WIEw9Wc86WeCNVSVv8Wbvs9UjaDytJFANc+0rllOYq/KhKNXJZkScsH5FWhpA==
X-Received: by 2002:a05:6820:1d97:b0:5c1:b9ec:7258 with SMTP id 006d021491bc7-5c1b9ec7316mr3702687eaf.0.1718898740473;
        Thu, 20 Jun 2024 08:52:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c198460ab5sm936795eaf.38.2024.06.20.08.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:52:19 -0700 (PDT)
Message-ID: <08c09a34-af59-4387-8db9-594f30f85b7a@baylibre.com>
Date: Thu, 20 Jun 2024 10:52:19 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI protocol
 with MOSI idle configuration
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>
 <ZnMqOAPc3IXP-eHC@debian-BULLSEYE-live-builder-AMD64>
 <e7a2438a-f6a3-439e-8058-937248dd5b3f@baylibre.com>
 <ZnRG9wgY3WIaYFyQ@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ZnRG9wgY3WIaYFyQ@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 10:12 AM, Marcelo Schmitt wrote:
> On 06/19, David Lechner wrote:
>> On 6/19/24 1:58 PM, Marcelo Schmitt wrote:
>>> On 06/19, David Lechner wrote:
>>>> On 6/18/24 6:10 PM, Marcelo Schmitt wrote:
>>>>
>>>>
>>
>> ...
>>
>>>>
>>>>> +the peripheral and also when CS is inactive.
>>>>
>>>> As I mentioned in a previous review, I think the key detail here is that the
>>>> MOSI line has to be in the required state during the CS line assertion
>>>> (falling edge). I didn't really get that from the current wording. The current
>>>> wording makes it sound like MOSI needs to be high indefinitely longer.
>>>
>>> It may be that we only need MOSI high just before bringing CS low. Though,
>>> I don't see that info in the datasheets. How much time would MOSI be required
>>> to be high prior to bringing CS low? The timing diagrams for register access and
>>> ADC sampling in "3-wire" mode all start and end with MOSI at logical 1 (high).
>>> I think reg access work if MOSI is brought low after CS gets low, but sample
>>> read definitely don't work.
>>>
>>> From the info available in datasheets, it looks like MOSI is indeed expected 
>>> to be high indefinitely amount of time. Except when the controller is clocking
>>> out data to the peripheral.
>>>
>>> Even if find out the amount of time MOSI would be required high prior to CS low,
>>> then we would need some sort of MOSI high/low state set with a delay prior to
>>> active CS. That might be enough to support the AD4000 series of devices but,
>>> would it be worth the added complexity?
>>>
>>
>> It needs to happen at the same time as setting CPOL for the SCLK line for the
>> device that is about to have the CS asserted. So I don't think we are breaking
>> new ground here. Typically, in most datasheets I've seen they tend to say
>> something like 2 ns before the CS change. So in most cases, I don't think
> which datasheets? Are any of those for devices supported by the ad4000 driver?

In the AD4000 datasheet, Figure 59, it shows the time needed for SDI setup
before CS assertion, labeled as t_SSDICNV. Table 2 gives this value to be
2 ns.

So unless a SPI controller has a functional clock of > 500 MHz or somehow
sets the SDI state and the CS assertion in the same register write this
minimum delay will always be met. I highly suspect noting like this has
happened before so no one ever needed to worry about the timing and it
just works (for the similar case of CPOL).

> 
>> anyone bothers adding a delay. But if a longer delay was really needed for
>> a specific peripheral, we could add a SPI xfer with no read/write that has
>> cs_off=1 and a delay to get the correct state of both MOSI and SCLK a longer
>> time before the CS change.
> 
> I don't know if that would actually work. I have not tested doing something like that.
> This also implies the controller will be able to start the next transfer right
> after the first preparatory transfer ends and it will meet that inter-transfer
> timing requirement (which I still didn't find documented anywhere).
> I'm not convinced that would be the best way to support those devices.

I did something like this in the ad7944 driver where we needed an up to
500ns delay before asserting CS. On SPI controllers without a hardware
sleep or FIFO, the delay will of course be much longer. But the delay
is just a minimum delay, so longer doesn't hurt. It just affects the
max sample rate that can be reliably achieved.



