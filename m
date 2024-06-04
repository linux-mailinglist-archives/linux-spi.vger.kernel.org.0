Return-Path: <linux-spi+bounces-3217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E338FBCAD
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 21:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED981F2359C
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F219514B090;
	Tue,  4 Jun 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E6U7aZLj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26E148300
	for <linux-spi@vger.kernel.org>; Tue,  4 Jun 2024 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529962; cv=none; b=dIbwM4BQU4SEfV80mMty9plRwVTFbo3CQIFt8cGD65J/t4ZNWgCmxBCpnPI4QcoER77N9fFEVysttEmKTTlvyIivK7zuzmjdp6BF7Ed4RJpQnGd3kYAoVDexh8/BBZ/NMGLcNlKuY+hUjYmFORHDKag8O+FFOiHdZnw8MXV/R/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529962; c=relaxed/simple;
	bh=I8Na0X1lr4Anj/n0WwNbTpdssCH6TSBbBWFAR7jHJaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxr8I3nVxgVRtxOQEeHrPwgy6Sf/uTAgSMYqjrRtr9/XgKKrUBunIhiyBWxjY1Sihwe4sugfb1tVsIlMcjz+wPTxLrD5uxFNjV1le+724EvLCZhehSTvieOKSn2CnB2sAxqR607FiaqB6aPYGlxmXqWySEB0nR14uSsULeq0eRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E6U7aZLj; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f938a7f492so671273a34.1
        for <linux-spi@vger.kernel.org>; Tue, 04 Jun 2024 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717529960; x=1718134760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8gskDRDbtXP6DbwUmFPk9QCXBH4Q1DxOfYZZF3juho=;
        b=E6U7aZLjEB1cb5AwDYzuty37NO5Xg4XtHiQVf6wqkhx6je/8VxR+bMdfQIFtZhf9O1
         3sjLHZ9dzjnB0EfNynLyHnjwBWkaWUH5gVALq+xpUcZO8e2ZGwGjCwRwBfLMeBlyP2F1
         FgziUgJyPmo7h1qBFPfuUkGS2Q+MbLbnwxkeNhFEDvUs2uSAVF8BpLAUPldYrJI2UNmd
         p5pzsMiu/n7C/oR6NEE0+/4jlBSydEH7FTHhpZNFNvLl64RobRrBc1voRyaGlvQ4UHGy
         HkxeMnVJv2PUS7jKS+4Tw7QOXLw577JeiLPgFDx70hm1zgsKUxDJexpw1NbQZyUjpdEb
         LizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717529960; x=1718134760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8gskDRDbtXP6DbwUmFPk9QCXBH4Q1DxOfYZZF3juho=;
        b=SJQgZfBvgZH1SH36y9AtRwkbijGYX582lYoO1Cr6CfHts8euCd4Zw6BpoqnKLNFS1N
         kPYWibCgG9uizBNO9bDt2SO0jndF+vv4jvbIIinzH/vBmWlCcNrtKX+t8e/UsG9MHjdN
         e2YpDRZ997dzlqmS6dQAgOXYLbZW5r/nkZkmTqzS8ZadIP5vldAc0Ewx+NtCBxkHa/YW
         L7lwE6I9k3xlwJXzZymG1Y1dnfBr0Ct9RUsHVcdxFH9dkPOCpSHvIlQTVe1PPvdxTt6y
         jycIG4UD+fp9Qc0+X6CqouvSRlsS1bVOivxVG8unBdhZy8z4fQfia6hcuQEJ/3Fpu2xS
         94/g==
X-Forwarded-Encrypted: i=1; AJvYcCUtcRY4jGjB7RIlI2Bls2wgJOsRUQCcjkex4oFS4UqKjq2bMONVBnfJ6gZFcSVBZRfKjaFHPCNlJtfpMAVOB2ZuSiWJ2ZYu00qd
X-Gm-Message-State: AOJu0YycNsgNCl/f6tpuKcKlevwu4wBngmTmOTROoHzkoHaaQC/9KnwL
	E/RpMXtyPyb1TCLwxfZjxrNmEO6X8Sk1UxGUNGQvkbiiNOs2/h+q/rf3bKSScPpEr5mk6jOASbZ
	B
X-Google-Smtp-Source: AGHT+IGWUBqQJOc0LHLzKdUR+del2BWW0rhqTnu+2S39NuLIHBVHgE7vqg/VdKu40BelYN5BpLWjyQ==
X-Received: by 2002:a9d:6d0c:0:b0:6f0:e870:e3e8 with SMTP id 46e09a7af769-6f943486643mr519655a34.21.1717529960085;
        Tue, 04 Jun 2024 12:39:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f910539e69sm2092702a34.28.2024.06.04.12.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 12:39:19 -0700 (PDT)
Message-ID: <97246fdc-bb33-45bc-a24a-c2595920421f@baylibre.com>
Date: Tue, 4 Jun 2024 14:39:18 -0500
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
References: <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <20240526-peculiar-panama-badda4f02336@spud>
 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
 <6db8ba66-841b-4425-9dd4-9d6e7b0463bf@baylibre.com>
 <20240604-oink-recognize-682c553a18e5@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240604-oink-recognize-682c553a18e5@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/24 2:33 PM, Conor Dooley wrote:
> On Thu, May 30, 2024 at 02:24:17PM -0500, David Lechner wrote:
>> On 5/29/24 3:07 AM, Nuno Sá wrote:
>>> On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
>>
>>
>>>> It might be easy to do it this way right now, but be problematic for a
>>>> future device or if someone wants to chuck away the ADI provided RTL and
>>>> do their own thing for this device. Really it just makes me wonder if
>>>> what's needed to describe more complex data pipelines uses an of_graph,
>>>> just like how video pipelines are handled, rather than the implementation
>>>> of io-backends that don't really seem to model the flow of data.
>>>>
>>>
>>> Yeah, backends is more for devices/soft-cores that extend the functionality of the
>>> device they are connected too. Like having DACs/ADCs hdl cores for connecting to high
>>> speed controllers. Note that in some cases they also manipulate or even create data
>>> but since they fit in IIO, having things like the DMA property in the hdl binding was
>>> fairly straight.
>>>
>>> Maybe having an offload dedicated API (through spi) to get/share a DMA handle would
>>> be acceptable. Then we could add support to "import" it in the IIO core. Then it
>>> would be up to the controller to accept or not to share the handle (in some cases the
>>> controller could really want to have the control of the DMA transfers).
>>
>> I could see this working for some SPI controllers, but for the AXI SPI Engine
>> + DMA currently, the DMA has a fixed word size, so can't be used as a generic
>> DMA with arbitrary SPI xfers. For example, if the HDL is compiled with a 32-bit
>> word size, then even if we are reading 16-bit sample data, the DMA is going to
>> put it in a 32-bit slot. So one could argue that this is still doing some data
>> manipulation similar to the CRC checker example.
>>
>>>
>>> Not familiar enough with of_graph so can't argue about it but likely is something
>>> worth looking at.
>>
>> I did try implementing something using graph bindings when I first started
>> working on this, but it didn't seem to really give us any extra useful
>> information. It was just describing connections (endpoints) that I thought
>> we could just implicitly assume. After this discussion though, maybe worth
>> a second look. I'll have to think about it more.
> 
> Could you elaborate on why you think you can assume the connections? What
> happens when you have multiple stages of data processing and/or multiple
> ADCs in your system? As I've previously said, I work on FPGA stuff, and
> everyone here seems to fawn over having <insert custom DSP IP here> in
> their data pipelines. I can't imagine it being any different for ADC data,
> and an io-backend property that doesn't describe how the data flows is
> gonna become lacklustre I think.

I was more ignorant back then. :-)

That is is why I said "thought" instead of "think". I am more enlightened now.

