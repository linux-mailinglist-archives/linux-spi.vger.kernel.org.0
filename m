Return-Path: <linux-spi+bounces-961-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22958457EB
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C641F23B9C
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0F38662A;
	Thu,  1 Feb 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIBHkEmu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A153364
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791034; cv=none; b=KqmjTegVt9GXvbH9T+QIGCAh2sp02pi2hAQMSAOrAcJ9pp6hFq0Rigvh+EhqXErB5G0bxhjjXBx2Z8/KKqHy65TE1rQGq4xkpGsta/ZnoLA1tzG9lhqyWwH3PxMd9k9jaQ0FZP75oummS7AwAvgsWIKdP+BnBIW5OGD0hormK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791034; c=relaxed/simple;
	bh=gRd5jgrR0O9Xq4TayohMbN1N9hxbfiTlURcTQTvCWmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/i4Cjv5PbPklSqFO8Rdb38qbck/d1n6phDo0qYxWXJmKAwAThjPuKF3Lhh3oIYd4QfArL6C2TEL7gDYJ112PCzqd6IOuowh7GVIj2JH6No7EpzWpY6HWUque07OlhCCgPKZGg5mWZph5aMrhB5+gq5z54Cvh16b4YhuHSqUKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NIBHkEmu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3651c87ebbso115182666b.1
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 04:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706791030; x=1707395830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoTHSXWECzNeEX4hwunhwLYfV1JWZsEFOUBoOk82HaA=;
        b=NIBHkEmuh3qSQ46UaDKUr1eGQKytefOX/RCQVNu2+kcDvnV3GZCkne/MzwdudMrjZ8
         +Br7CqgyVeTP9DCQpdDo672LCcnpnvbRuaqqgIgk59/9zcbonLOmWzuPQfKJsytNzNoT
         QLb4AzfY6a5MZZwFW6PVPY+SLnaIZOVBSJEZLR2xcLonDx+/ZMBm1FAVl5bd5p/3uk9H
         lsDyAc5jSZZYl/bzkcmnK19nCE8ZZRfElSBIN6EY8xZ64PfRs6mvZbg3rSvjZhLnmmCA
         /PujWes0l7GMxgRCQkrTBgJNZhiG0yaYupuuosVCgCrT6tFXJsBqL+/S2aSh/RWlmIVn
         EdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791030; x=1707395830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoTHSXWECzNeEX4hwunhwLYfV1JWZsEFOUBoOk82HaA=;
        b=b3BQIsRoq65XmsiNo7pbJ4C781psW5OmJSB/8GZI9Wv8dCeo+sT7Ksy2r9dd3lr+R6
         r3yJ9PclIgh5++ck9/+5ofL3ZSKZvbr3EWj9Sw5a3zT8sBiRM1PBMpGx9yfpPmgtJwIn
         0pibX/oGzRnb6YFTxvSb8vs+DDclTlhLU+2tkmyYDz1EvmTy43a5C2UKjfKIGzwlKc13
         mXTIx4b9IFCT897e64KCyzk/OR2a1k1/jBS2yCc3VAjFU4AYv4D45QQk0bH78r+4k1v8
         GkmA57w6uOunmjgjtXYwRgRfjWu76G2A+udF1eEIFi6ln9+0DDP+xfV9/D+Tup0Kd3eQ
         N+EA==
X-Gm-Message-State: AOJu0YypdOYHScUdITBP6kAXDwY+pRgftvGPuq5Eh70+lGcvGRdAkH9/
	wj4ZXDJuYGrEe0OpdBYAL4FkCJf1v+iKEbsqSxGrgnKTsCsLChe4Zyc4gF5JBbc=
X-Google-Smtp-Source: AGHT+IEqOL816tqer2FcKzdKIzrZxu37nCR4OVV1sPdi6208bjjgPQtyRx83t6fmAz32MCNR/qCo6Q==
X-Received: by 2002:a17:906:131a:b0:a36:5551:ad76 with SMTP id w26-20020a170906131a00b00a365551ad76mr1816766ejb.75.1706791030610;
        Thu, 01 Feb 2024 04:37:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXegE9bb7E1tgis9igkW5e5d8j7Ofe64E7MpUTScWaOz2Jst1S7myw+BaiaIoekPF/Ev4YmvvcK4Q5SO7mmiai2BLEPcvQqFqdqV9O//wu4QvJ64AmswmGi4DUzKdkk0cCAIRlBBDUErQXcxEH1DJ6zMD3jBCp6USxSLXwTxXiR553A0X+1djg/fHLE5L5J/1j9ay/1tayaCM7PcY5ebTiQphOXYyknzHglx4haE7dFZJwCMPdbuEMmRRrd3WjaDcoFME6his8vU0shUpqn7iBi5du4ijJCRy2Wo71/fBjt7Tlb4y6KZKpgg4yUOMKuAR0IpYqWUXUOUMEI0ifRMzTOFU3A8dyuA87//KGsz9YYVbd9tKvmm1wq0xHFcZl8fuE8wY01YvXQUPk8Op6X4Br5zIfRKW7GB7Xu0BmpcdJHfksstj5Le5ipBATnA9fmZHoGH7Rm2hhFu4SndHCPvdbwaKBqypVR7xgez73zuULyE5x7RmXHSwLF5gKzeJwRqnJt9bhOwu2NkoQEGjQV80wfrgr5h7ixuWizAfQD/SYCQSZbc+E=
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id cw1-20020a170907160100b00a359558648esm4864902ejd.24.2024.02.01.04.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:37:10 -0800 (PST)
Message-ID: <9a4339fb-5997-4d94-8471-46ac27c790fa@linaro.org>
Date: Thu, 1 Feb 2024 12:37:08 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mtd: hyperbus: Add support for Infineon S26Hx-T
Content-Language: en-US
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 "Raghavendra, Vignesh" <vigneshr@ti.com>, tkuw584924@gmail.com,
 linux-mtd@lists.infradead.org, sergei.shtylyov@cogentembedded.com,
 geert+renesas@glider.be, Mark Brown <broonie@kernel.org>,
 Christophe KERELLO <christophe.kerello@foss.st.com>
Cc: pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
 richard@nod.at, d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <cover.1680663252.git.Takahiro.Kuwano@infineon.com>
 <d94273b2-9516-2b80-308f-9fd1fdd2b4d5@linaro.org>
 <158830c6-d492-4967-a543-c0f5f8428d8b@linaro.org>
 <2bcf6646-b7ce-48c9-8a9b-0634c3fb40e9@ti.com>
 <508196d4-a533-47c9-bf6e-5718364c8d54@linaro.org>
 <c75f33ce-d7a8-46db-aeab-f4406f3d9cf9@foss.st.com>
 <09b1e193-8a87-4f29-a1d5-8dfd370b03a1@linaro.org>
 <cfe84e34-1dc0-459a-a347-e559718b4d75@foss.st.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <cfe84e34-1dc0-459a-a347-e559718b4d75@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/1/24 12:23, Patrice CHOTARD wrote:
> 
> 
> On 2/1/24 13:02, Tudor Ambarus wrote:
>>
>>
>> On 2/1/24 10:46, Patrice CHOTARD wrote:
>>>
>>>
>>> On 1/22/24 09:13, Tudor Ambarus wrote:
>>>>
>>>>
>>>> On 1/22/24 06:25, Raghavendra, Vignesh wrote:
>>>>>
>>>>>
>>>>> On 1/22/2024 11:41 AM, Tudor Ambarus wrote:
>>>>>> + Sergei, Geert, Mark & linux-spi
>>>>>>
>>>>>> Hi, Sergei,
>>>>>>
>>>>>> On 23.05.2023 07:22, Tudor Ambarus wrote:
>>>>>>> Hi, Takahiro, Vignesh,
>>>>>>>
>>>>>>>
>>>>>>> On 07.04.2023 09:11, tkuw584924@gmail.com wrote:
>>>>>>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>>>>>
>>>>>>>> This sereis adds support for Infineon S26HL-T/S26HS-T flash family.
>>>>>>>> https://www.infineon.com/dgdl/Infineon-S26HS01GTGABHM020-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7f2a768a017f52f2f5182c91
>>>>>>>>
>>>>>>>> This family supports two interface modes, SPI mode and Hyperbus mode. The mode
>>>>>>>> can be switched at rutime. The default mode is selected by ordering option
>>>>>>>> and non-volatile user configuration. In hyperbus mode, the device is compatible
>>>>>>>> with S26KL-S/S26KS-S hyperflash family that supports hyperbus only so one of
>>>>>>>> use cases of S26Hx-T is replacement of (or migration from) S26Kx-S. This patch
>>>>>>>> set focuses on particular usage that the device is pre-configured as hyperbus
>>>>>>>> mode for compatibility with S26Kx-S.
>>>>>>>
>>>>>>> I'm questioning the overall hyperbus software architecture, not your
>>>>>>> patches per se. IMO hyperbus framework should have been written on top
>>>>>>> of SPIMEM and the controllers be placed in drivers/spi/. So I'd first
>>>>>>> address the SPIMEM adoption before adding/accepting new support. Would
>>>>>>> love to hear more from Vignesh.
>>>>>>>
>>>>>>
>>>>>> RPC is the only multi IO SPI controller that's upstreamed and capable of
>>>>>> dealing with hyperflashes, but there are others which are not upstreamed
>>>>>> yet (microchip).
>>>>>>
>>>>>> Struct ``struct rpcif_op`` [1] duplicates the contents of ``struct
>>>>>> spi_mem_op`` [2] which could have been avoided if hyperflash driver was
>>>>>> extended with SPI MEM support. This way the RPC hyperbus driver, which
>>>>>> is an SPI controller, could have been moved to drivers/spi.
>>>>>>
>>>>>> Sergei, do you remember why we haven't used SPI MEM for hyberbus since
>>>>>> the beginning? Was it something that we aimed for in a future patch set?
>>>>>>
>>>>>> Thanks,
>>>>>> ta
>>>>>>
>>>>>> [1]
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/memory/renesas-rpc-if.h?h=mtd/for-6.8#n22
>>>>>>
>>>>>> [2]
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/linux/spi/spi-mem.h?h=mtd/for-6.8#n99
>>>>>>
>>>>>
>>>>> The initial hyperflash predates opening up of HyperBus protocol and
>>>>> inclusion of it in xSPI spec. First gen Flashes followed CFI specification
>>>>> and hence made sense to make use of cfi_cmdset_0002.c
>>>>>
>>>>> We did have a discussion on extending spi_mem to support xSPI profile 
>>>>> 2.0 during the RPC_IF [3] [4].
>>>>>
>>>>> Overall, both Controllers and Flashes have moved away from CFI parallel 
>>>>> flash protocol over to xSPI / SPI NOR flash protocol (profile 2.0), so I 
>>>>> agree with Tudor's assessment that we need to move towards spi_mem in 
>>>>> longer term. So
>>>>>
>>>>
>>>> Good, thanks Vignesh! I'll study a bit more and let you know about the
>>>> progress on this topic.
>>>
>>> Hi All
>>
>> Hi,
>>
>>>
>>> At STMicroelectronics we got an OSPI block which is supporting both OSPI and HyperBus protocol
>>> similarly to the mentioned RPC-IF.
>>>
>>> This means that we intend to split our implementation in 3 drivers as RPC-IF:
>>>   _ backend driver including common source code to OSPI and HyperBus
>>>   _ OSPI frontend driver
>>>   _ HyperBus frontend driver
>>>
>>> Following this discussion thread, we are wondering if it will be the right direction to 
>>> choose in order to propose this implementation to MTD mailing list.
>>
>> I think the right direction would be to have hyperflash on top of
>> SPIMEM, and the SPI controller under drivers/spi.
> 
> 
> To be more precise, when you say "would be to have", you mean you will NAK 
> an implementation in 3 drivers as RPC-IF ?
> 

Yes. I think we should move towards SPIMEM adoption, don't you?

> 
>>>
>>> Have you an idea about time scale regarding the HyperBus migration over spi-mem ?
>>>
>>
>> No, sorry. It's at best effort from my side. Happy to review proposals
>> though.
>>
>>> Thanks
>>> Patrice
>>>
>>>
>>>>
>>>> Cheers,
>>>> ta
>>>>
>>>>> a) Extend spi_mem_op to support xSPI profile 2.0 transaction template
>>>>> b) HyperBus layer can then either be a adapter from CFI to spi_mem for CFI
>>>>> compliant devices. And  be subsumed completely within SPI NOR for SFDP
>>>>> compliant devices.
>>>>> c) Move the existing controllers over to new framework.
>>>>>
>>>>>
>>>>> [3] https://lore.kernel.org/all/b8224f46-fc2e-de35-0a90-a2a86cacb489@ti.com/
>>>>> [4] https://lore.kernel.org/all/20200220084927.7a411d40@collabora.com/
>>>>>
>>>>
>>>> ______________________________________________________
>>>> Linux MTD discussion mailing list
>>>> http://lists.infradead.org/mailman/listinfo/linux-mtd/

