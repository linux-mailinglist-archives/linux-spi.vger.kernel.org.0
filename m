Return-Path: <linux-spi+bounces-3219-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377EF8FBD01
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 22:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D0C1C22CDD
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587414C5A4;
	Tue,  4 Jun 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bWF4Oy4a"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6314B06E
	for <linux-spi@vger.kernel.org>; Tue,  4 Jun 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531456; cv=none; b=RX4cThHYzoMWNgJQZT4fulIxto9DS3+SkdusytVKBfakDY1lndLKJ6H9SBffmUcUQiPWPtoPRSNuzieTZ80MqAIsUqxzr5oGtmOC4rADARLTzvxyM89h/uqrG7cldsiAITZUIHYbL45Tefhev7fT4RgjfjEKn+TrMTxnaTvyjUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531456; c=relaxed/simple;
	bh=ifJgSeAIFZRASnV+MOrg6/T+pJieJwJGF0TCkFg1iog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ye8Mxiiao8ftd2aihZqCIjQnUX3yq4yyVclQ37bay1Fu18gmWDlpslChyyYi+I4pnDy0wN7uii6y64EkM7mrD9FlFNinMlC1mgEyddgC8c33xVOJhFUphHnuNCN/O3UWMLrnbl6XAMNHGwnznB0rEVO34KufEzcru1kbST4Lq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bWF4Oy4a; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24ca03ad307so3321090fac.3
        for <linux-spi@vger.kernel.org>; Tue, 04 Jun 2024 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717531453; x=1718136253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reaUaxTBxuoFAX9L6V67TsUNn1f3x3XIHPqfoIBlQq0=;
        b=bWF4Oy4ah+pkPTKMUvAGc1NaRuEQXO511gk38H+n7/NXkpZBaB1h2DeKwHKWBRaPPl
         JucdfVl/jv7650wwhX6JmlfhfkZqw0g66CitfXPcULpuK7EYRWox8qWngbH5MIWG9IVb
         H8MbefRuDnzrKFKalzc9csJrkeuQ7aJTVHOn97yT+BDynJIBwjejJ3DTrhk5Leu+o/tv
         NhGIKDgE6RtbAzx1nte96/jgNpsijeTBVXEpYPko1KtXGKFrthKEIWKTWXS47P3EPqOo
         f/yysWr/TitWs505ghnTxD0x6ESQ3zm1W4o6tq+egs4PpoB57QUOiD5AN5pxnNLUfUuV
         9psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717531453; x=1718136253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reaUaxTBxuoFAX9L6V67TsUNn1f3x3XIHPqfoIBlQq0=;
        b=TKc+jzUSJDrswmT8JAl4ifPtpoJgTMooKkI/lhlh6/twHpHG0bypOsUW3vr8+PlZla
         uqbkUCo8qu3z8Jw4U8JGGTcETsTbzmG5qSQDmc2hyx6hrQ+jIevQ3DBpiE27VfWsz8ow
         5Xv5HGlL1zA04Ez4FkzqqK7ToUThlSOpnh4TL95oTMt0QEvr7S5zLk7rhUFNoSX0pQGP
         1LzxyvwDX/JVGwUsdKjUFzbCQaxboeLXbLX9bVRhvsfN2Sd6EvrFxhVFP+M/sxXnkGwe
         J0TlsDZLx9o0edThc4tqmhm2D8ebL+PdDkd4b1dpC9ojzYSWqdlfu7ay0Rp5DIoww1qy
         xOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbxlwVl2uTVP4vDupfaRFVyACbqim68H1uKAz0ElwNtVUbRcAPLtBlcC+YxjHyiCxOb8eB8wqCD5KY2IZ7o1KuPLJrDkFXqR5d
X-Gm-Message-State: AOJu0YwwfJ9WFndOG+s0IGi6kMqx0b0vR73QmVXpc8MQZBpVI8PRyYPP
	bmjI3Chyw0DXM67q3YUI0vrIL1q6UHagcevWlaDW6pzl77ES+V0Q4KL7lh/BBRU=
X-Google-Smtp-Source: AGHT+IFmokxHSxeNvyckXE29Vnqzww3ngNVts94JIyWTd7qV9z3pyvK1uQADmcIceFZn/wnrLR5f1Q==
X-Received: by 2002:a05:6871:5b10:b0:250:6f7c:495 with SMTP id 586e51a60fabf-251225ff3c6mr570468fac.9.1717531453076;
        Tue, 04 Jun 2024 13:04:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2508502c58esm3504232fac.29.2024.06.04.13.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 13:04:12 -0700 (PDT)
Message-ID: <aea1d78a-8982-46b5-9a9e-06da6462b6c1@baylibre.com>
Date: Tue, 4 Jun 2024 15:04:11 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <20240526-peculiar-panama-badda4f02336@spud>
 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
 <6db8ba66-841b-4425-9dd4-9d6e7b0463bf@baylibre.com>
 <20240604-oink-recognize-682c553a18e5@spud>
 <97246fdc-bb33-45bc-a24a-c2595920421f@baylibre.com>
 <20240604-awry-container-a8c12f421a81@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240604-awry-container-a8c12f421a81@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/24 2:42 PM, Conor Dooley wrote:
> On Tue, Jun 04, 2024 at 02:39:18PM -0500, David Lechner wrote:
>> On 6/4/24 2:33 PM, Conor Dooley wrote:
>>> On Thu, May 30, 2024 at 02:24:17PM -0500, David Lechner wrote:
>>>> On 5/29/24 3:07 AM, Nuno Sá wrote:
>>>>> On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
>>>>
>>>>
>>>>>> It might be easy to do it this way right now, but be problematic for a
>>>>>> future device or if someone wants to chuck away the ADI provided RTL and
>>>>>> do their own thing for this device. Really it just makes me wonder if
>>>>>> what's needed to describe more complex data pipelines uses an of_graph,
>>>>>> just like how video pipelines are handled, rather than the implementation
>>>>>> of io-backends that don't really seem to model the flow of data.
>>>>>>
>>>>>
>>>>> Yeah, backends is more for devices/soft-cores that extend the functionality of the
>>>>> device they are connected too. Like having DACs/ADCs hdl cores for connecting to high
>>>>> speed controllers. Note that in some cases they also manipulate or even create data
>>>>> but since they fit in IIO, having things like the DMA property in the hdl binding was
>>>>> fairly straight.
>>>>>
>>>>> Maybe having an offload dedicated API (through spi) to get/share a DMA handle would
>>>>> be acceptable. Then we could add support to "import" it in the IIO core. Then it
>>>>> would be up to the controller to accept or not to share the handle (in some cases the
>>>>> controller could really want to have the control of the DMA transfers).
>>>>
>>>> I could see this working for some SPI controllers, but for the AXI SPI Engine
>>>> + DMA currently, the DMA has a fixed word size, so can't be used as a generic
>>>> DMA with arbitrary SPI xfers. For example, if the HDL is compiled with a 32-bit
>>>> word size, then even if we are reading 16-bit sample data, the DMA is going to
>>>> put it in a 32-bit slot. So one could argue that this is still doing some data
>>>> manipulation similar to the CRC checker example.
>>>>
>>>>>
>>>>> Not familiar enough with of_graph so can't argue about it but likely is something
>>>>> worth looking at.
>>>>
>>>> I did try implementing something using graph bindings when I first started
>>>> working on this, but it didn't seem to really give us any extra useful
>>>> information. It was just describing connections (endpoints) that I thought
>>>> we could just implicitly assume. After this discussion though, maybe worth
>>>> a second look. I'll have to think about it more.
>>>
>>> Could you elaborate on why you think you can assume the connections? What
>>> happens when you have multiple stages of data processing and/or multiple
>>> ADCs in your system? As I've previously said, I work on FPGA stuff, and
>>> everyone here seems to fawn over having <insert custom DSP IP here> in
>>> their data pipelines. I can't imagine it being any different for ADC data,
>>> and an io-backend property that doesn't describe how the data flows is
>>> gonna become lacklustre I think.
>>
>> I was more ignorant back then. :-)
>>
>> That is is why I said "thought" instead of "think". I am more enlightened now.
> 
> Heh, I didn't mean it in a bad way. I just wanted to flesh out why you
> thought that way.
> 

Back then, we were going on the assumption that no one would want to
make their own custom IP and only use the IP blocks provided by ADI
for ADI chips. So given chip X + SPI offload, we could assume HDL
project Y was being used.



