Return-Path: <linux-spi+bounces-868-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799283E26B
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 20:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B121F23124
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jan 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7D224D3;
	Fri, 26 Jan 2024 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kspVoq8K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46193224CC;
	Fri, 26 Jan 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296990; cv=none; b=chzW5KkCc+HlBpQqMaM/1lq79LcVlkC31r3tXB5ewGKFYcDBHjyVka4iA09C6zBuehlzjl1UETtKTHeeHkL+R2GEiZwRCloZKB0sGzCoN+vJ/Vfryzw8KEMsn3kzs6YSdC4X0lUcJGKxD+3thc2AzH3TRxTe7+VCmap9yFUv3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296990; c=relaxed/simple;
	bh=mZPODikZGByOoaS0XQWvyYVnm0Q6peBX7kl97gM7l7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNVhNd6gNNbteks8/av2qZuRtN0I8tCKBf7mrMop/p0INQdLGCbrqjrYzCd1v36YVCJvh2HaGslYKm0KPxfpmgt5QaUeQwlY4e1VPrKDGR1BkzdeEO8MaztzX+8E57nCUGivo/Dotq8z76GDrDGYg/WE+zLq74M2ciCjG0Qnuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kspVoq8K; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-339231c062bso818961f8f.0;
        Fri, 26 Jan 2024 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706296986; x=1706901786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7XyfHafPzk4o7TH4Z/Q88VVxtW7j3Tbp7VfVnvGsEc=;
        b=kspVoq8KnUjYi2tICO4pf7WFm3v47x+Xazz/C6lk1j1Mpx1/dm8lw+x7ac2e4v7+Qw
         Nmss4pul689hEkY3SU+4NbHpL2Li13OQq+F4BsBF7gJGSmy2GlO8UlPe7ZFkGHFP6EVK
         Y/UG98rG/zXHGx/h1pYgmKb3PY1E95wbTwkbOVejBlZ15QKlSDmu9XyhU9KGTWer3Zzg
         7rVtuZre1VOD02hYQc3xMk3atg+RHeMfDmFVQGOJJHXF59lgiKIvnoYwaW0fqrvZFoex
         h9U1dm/jKdo83Pzc1QMoTS99Xr32J4/HjKwGs78W0MLFwWMdnUfJgtniAEHiUht+LRhF
         iB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706296986; x=1706901786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7XyfHafPzk4o7TH4Z/Q88VVxtW7j3Tbp7VfVnvGsEc=;
        b=kB3qMZYp0N8GeTiwUKh9lhIvfAbVweo1mmi1uZBG6HSZoLJxyfG+EYNHzrAqhjA7rD
         MazpM3V3Qwnr2EKwhMU1ZCTW47WENm6KbpmXgJ252alM8fHTFsAiqkApcA7awymX8ECH
         DM913Pp055otvyMD8DHuBdVDX9jtC+L/ZJWtA7x1WD6IWRtbsCA/lXvLcu/4/nkmAxfC
         CopHH8Jn5/TNH7sdipDIYOHupV7F5pKl+WR/F0XJF2JUme3JCys7nCfMO9S6b7E5imX4
         O8u8fQmTKdnKAnt7l3hMOAKkjsGbZxS+sEajcM68MbgkkqzDcm4VqTZLQAHpKpKp35v5
         ynaQ==
X-Gm-Message-State: AOJu0YxrI7RdYUeK4HCUrN5Y/0DywYyey4+bUekqxcizPiDfAZDAmr2E
	VVgBLLUWI8CnX7jSQeCKIONVe1St+PL5pbnqVpPo1kqK6PDpXSZ6HVM+tXKiOOeqSQ==
X-Google-Smtp-Source: AGHT+IF1+PZeX7PZt2kTQgTViZHQHL+3yVD7+6dcQhCOhwvZBDjkk41rFIK3ofAq4p5K5JETMKgALQ==
X-Received: by 2002:a5d:4008:0:b0:337:c7ff:85e1 with SMTP id n8-20020a5d4008000000b00337c7ff85e1mr83945wrp.131.1706296986249;
        Fri, 26 Jan 2024 11:23:06 -0800 (PST)
Received: from [192.168.0.5] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id ba11-20020a0560001c0b00b003366c058509sm1859765wrb.23.2024.01.26.11.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:23:05 -0800 (PST)
Message-ID: <c88d56ba-3214-4053-9533-bec12bf110ef@gmail.com>
Date: Fri, 26 Jan 2024 20:23:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: dt-bindings: spi-rockchip: restrict num-cs
To: Robin Murphy <robin.murphy@arm.com>, Johan Jonker <jbx6244@gmail.com>,
 broonie@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <acc4ff4b-811a-4a6d-8f58-9d8da3be40bb@gmail.com>
 <d6fc0ad6-ce20-4604-89e5-2598dc3fc0a6@gmail.com>
 <344a3de8-7f10-46f0-9524-dca58ceda671@gmail.com>
 <97fcde65-9eb0-44e1-a87a-caa308d1998b@arm.com>
Content-Language: en-US
From: Luis de Arquer <ldearquer@gmail.com>
In-Reply-To: <97fcde65-9eb0-44e1-a87a-caa308d1998b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Robin,

On 1/23/24 18:45, Robin Murphy wrote:
> On 23/01/2024 10:49 am, Johan Jonker wrote:
>>
>>
>> On 1/23/24 10:17, Luis de Arquer wrote:
>>> On 1/22/24 23:59, Johan Jonker wrote:
>>>> In the driver spi-rockchip.c max_native_cs is limited to 4 and the
>>>> default num-cs property is 1. Restrict num-cs in spi-rockchip.yaml.
>>>>
>>>
>>
>>> Doesn't num-cs include gpio chip selects too?
>>> I have a setup with num-cs = <12> which uses non-native cs-gpios just 
>>> fine
>>
>> Given that bindings and Linux drivers capabilities are 2 separate things.
> 
> Er, that's the whole point - bindings and drivers *are* separate things, 
> and bindings do not describe drivers. Not least since the fundamental 
> model is to have one canonical binding for multiple different drivers to 
> consume.
> 
> There seems to be some ambiguity as to whether the common "num-cs" 
> property is supposed to describe the number of dedicated hardware 
> chipselects or the total number including additional GPIOs, but either 
> way this change appears to be objectively wrong - if it's the former 
> than the comment in the driver plus a survey of a few TRMs implies that 
> the maximum number of hardware lines is 2; if it's the latter then 
> obviously it's valid for a platform to wire up 3 or more additional 
> GPIOs as desired, and for a DT to accurately describe that, regardless 
> of whether any particular consumer happens to support it yet or not. For 
> example, AFAICS the U-Boot and FreeBSD drivers for Rockchip SPI appear 
> not to support GPIO chipselects at all.
> 

I always understood num-cs was a spi subsystem thing, which can be 
extended with as many gpios as needed.

However, it looks spi-rockchip may be limiting num-cs to 4 after all.

It keeps a copy of the state of the chip selects into an array 
'cs_asserted' of size 4. It wouldn't be a problem if it wasn't because 
the driver sets the flag SPI_CONTROLLER_GPIO_SS, which makes driver's 
set_cs() function to be called even for gpio lines.

All this leads to an out of bounds access when num-cs > 4.

I was able to reproduce the issue with 6 spidev devices (all with gpio 
cs) adding 2 guard u8 variables in 'struct rockchip_spi' right after 
'cs_asserted' array, and they got overwritten when accessing devices 
spidev0.4 and spidev0.5

Even though I did the test with a downstream kernel (I need more time to 
test on mainline), the driver is mostly identical, and the problem seems 
to persist in mainline.

I reviewed and prepared a fix on my system. I am building the fix on 
linux-rockchip tree, and I will try to post it for review soon.

Luis

> Thanks,
> Robin.
> 
>> However this document has also a purpose that must notify mainline 
>> maintainers if users submit bogus DT values.
>> Currently that limit is set to 4 in the mainline driver.
>> You are free to submit a real board file/patch serie afterwords as 
>> proof for review with 12 spi chips and then adjust this limit and 
>> increase ROCKCHIP_SPI_MAX_CS_NUM.
>>
>> Johan
>>
>>>
>>> Luis
>>>
>>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml 
>>>> b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>>> index e4941e9212d1..00d555bcbad3 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
>>>> @@ -65,6 +65,11 @@ properties:
>>>>          - const: tx
>>>>          - const: rx
>>>>
>>>> +  num-cs:
>>>> +    default: 1
>>>> +    minimum: 1
>>>> +    maximum: 4
>>>> +
>>>>      rx-sample-delay-ns:
>>>>        default: 0
>>>>        description:
>>>> -- 
>>>> 2.39.2
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-rockchip mailing list
>>>> Linux-rockchip@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip


