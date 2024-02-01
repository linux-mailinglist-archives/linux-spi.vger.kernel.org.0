Return-Path: <linux-spi+bounces-954-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C98456BD
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 13:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7C11C25562
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A703A1C3;
	Thu,  1 Feb 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmPUfTdY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC464D9E7
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788985; cv=none; b=PFW6LE3AOyCNL8Zz9enGhkAD3XTwrR7Y/dynVTaAP4wANbQeDVMbtw1obwd/Y8j1xNG4BRuZZpsI03eKdPxwRwSqi5R2UY0vd+un5W9tuF6qcr/+H1b84VXVwZuT8WR0np5G/8SHlTaJom3yn+/h2iU0S3LkgIFq7QMfOGg5nFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788985; c=relaxed/simple;
	bh=tXe53h5cR8lPoSaiDlDZg8vlgXZwc1dsVmVshyZvBmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvwpXnQqe28eiCH5IHHCmbGESj5oBsXTiwhoRkYF5XIBEJjyGSZzMEWyTNJu2C2G8v7cFGlTtXXBWOUPG/jzvzDl23sPpg1eFVUpVvHXHIXO9vxYkPvBHByIh/eeMwdWi9VmHRCwcDDmkxjTgsqTdL6QMZLMulCYiahRhHyIipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zmPUfTdY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55fc8f91b79so395744a12.3
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 04:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706788982; x=1707393782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRvnHveVZ1Az/l6vbFOJUdq9O7cxAFSAEDNUgmlrpLg=;
        b=zmPUfTdYpNUrVICrgjyIX9xJZCdwNZi3r/25we6z8J069w2/BQ5s8ycns8Mi+NAx5p
         gS6qSpXg5vvtQwyPaHNg1QN62GMvTElC0uof2OjGByzsKWEQHgUnGXjRmRNg4yqf8AXV
         pZtMLw556SX/jAQZnGoO4KUADv7kqX2loZ+SsAoW/Ao3ESceLR9bVpmMCQsp9fgUIHwh
         Q6/VK2HYBTibZ7fjWYPB0x7TruMz7HrFymPEJKgOqskLzeo6x/SsXMnUbTyoSI+/9mg0
         Xr/NaVasVNonfgM2ccCU1iidYkVJyZwmfPinlEiBwiG7MwC1uV1c3TUyATj753LgyV+B
         QVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788982; x=1707393782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRvnHveVZ1Az/l6vbFOJUdq9O7cxAFSAEDNUgmlrpLg=;
        b=MApQX9FmAz/v38f1c3s8lr9ZdWPW6Wb4+gdy/wF694Fz2owOyMxde8mVqkIqojtHlj
         yHU67mCDiYCjwvfHNNJCzeXu0fuIeL4mGdwtaEnZklk/f049n9KDbs1YyP6n/556utK7
         Wtj4muGkjI0rpEVujetEQq4NWroJCkUnTT1X+y8KkIW31CVX1ElddYmSbKaO0frc4oQo
         JuMJyVp8blyL8Je+yUt4i44j8hwnZHnpxV+I7S5KeHuv+ZOxpIzVYwxydddHgYz7y1Da
         d5UDs65Ab9gnFMfxhvycEqQJi4YAsO+UJApv8svDaOFWJai8NM+6ZP3d+77uUfMbero9
         mCew==
X-Gm-Message-State: AOJu0YxDHs6sHjimSWj0Wp402ZEs0GNEDSGMONYPPrgaxAri89zx8+O9
	gM3l6wMod7DOyKpD3wM9X9Rg3MoIrl8mmfs5Yv/3iAf3dK1GILN/5asqy17Zz8Q=
X-Google-Smtp-Source: AGHT+IHzmirGSZwk7eF5IYHac1w6eYWR/iLdsie89rjXgKwtbKLBtgIkMS7H+CYX1Oklvx1IlWWrZw==
X-Received: by 2002:a05:6402:1602:b0:55f:c3c1:34e with SMTP id f2-20020a056402160200b0055fc3c1034emr679915edv.15.1706788981786;
        Thu, 01 Feb 2024 04:03:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWVNol4pV3Y/qLWUIfhsIVIX9uyU12YeJgjplq9+R0EJPBGsHkzCA/c588Vp3dluHz1aaUa+q5U0d0l3Vb0SDCR+iKcUZlSbR9VYSsTd9Ah+p0WQ4VihdWiaNw1d+Ux4hymqvMmZPHpTbhM/HyPLGYZjqMwHH6pRcRLilRIPTlbgs4nIV0I5ZhKr0huXBHl10DErFtaoIU5SYM2Q7MqAG1w1HSmVEG4u5nrdT/Gm2T5DKmiQiLHZejzQRCErnx8Crm8nh/F0KCD3daO9jm+yc8dkgdCDGUhrUBJWFX77YjQQntGW8DliJhFN7uqiehXZMaTJgrQm03ah9NI8XFMwytK/JAqyptgrJOGKGFDC0h/OC5sq38Adj0XUDI2JJMa7+OCXQL1va5gF4RzXirWVAMGfRW6ztYkvQOnn0GVozeTe8q/zP3eFEnRCpAM8Uw2CdxR+nGjQoBgOG0GMOnyOyjF65ejONEJLTYpQmEBJeVZJ6m3K9E3PXWWsu/koEhndL0TDrZsicvx1sTHCKWLc+qNeyW1RA7F/HS1lzBaRQ0tsll8JLY=
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id ba8-20020a0564021ac800b0055f2af9b01bsm2989175edb.17.2024.02.01.04.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:03:01 -0800 (PST)
Message-ID: <09b1e193-8a87-4f29-a1d5-8dfd370b03a1@linaro.org>
Date: Thu, 1 Feb 2024 12:02:59 +0000
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
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <c75f33ce-d7a8-46db-aeab-f4406f3d9cf9@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/1/24 10:46, Patrice CHOTARD wrote:
> 
> 
> On 1/22/24 09:13, Tudor Ambarus wrote:
>>
>>
>> On 1/22/24 06:25, Raghavendra, Vignesh wrote:
>>>
>>>
>>> On 1/22/2024 11:41 AM, Tudor Ambarus wrote:
>>>> + Sergei, Geert, Mark & linux-spi
>>>>
>>>> Hi, Sergei,
>>>>
>>>> On 23.05.2023 07:22, Tudor Ambarus wrote:
>>>>> Hi, Takahiro, Vignesh,
>>>>>
>>>>>
>>>>> On 07.04.2023 09:11, tkuw584924@gmail.com wrote:
>>>>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>>>
>>>>>> This sereis adds support for Infineon S26HL-T/S26HS-T flash family.
>>>>>> https://www.infineon.com/dgdl/Infineon-S26HS01GTGABHM020-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7f2a768a017f52f2f5182c91
>>>>>>
>>>>>> This family supports two interface modes, SPI mode and Hyperbus mode. The mode
>>>>>> can be switched at rutime. The default mode is selected by ordering option
>>>>>> and non-volatile user configuration. In hyperbus mode, the device is compatible
>>>>>> with S26KL-S/S26KS-S hyperflash family that supports hyperbus only so one of
>>>>>> use cases of S26Hx-T is replacement of (or migration from) S26Kx-S. This patch
>>>>>> set focuses on particular usage that the device is pre-configured as hyperbus
>>>>>> mode for compatibility with S26Kx-S.
>>>>>
>>>>> I'm questioning the overall hyperbus software architecture, not your
>>>>> patches per se. IMO hyperbus framework should have been written on top
>>>>> of SPIMEM and the controllers be placed in drivers/spi/. So I'd first
>>>>> address the SPIMEM adoption before adding/accepting new support. Would
>>>>> love to hear more from Vignesh.
>>>>>
>>>>
>>>> RPC is the only multi IO SPI controller that's upstreamed and capable of
>>>> dealing with hyperflashes, but there are others which are not upstreamed
>>>> yet (microchip).
>>>>
>>>> Struct ``struct rpcif_op`` [1] duplicates the contents of ``struct
>>>> spi_mem_op`` [2] which could have been avoided if hyperflash driver was
>>>> extended with SPI MEM support. This way the RPC hyperbus driver, which
>>>> is an SPI controller, could have been moved to drivers/spi.
>>>>
>>>> Sergei, do you remember why we haven't used SPI MEM for hyberbus since
>>>> the beginning? Was it something that we aimed for in a future patch set?
>>>>
>>>> Thanks,
>>>> ta
>>>>
>>>> [1]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/memory/renesas-rpc-if.h?h=mtd/for-6.8#n22
>>>>
>>>> [2]
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/linux/spi/spi-mem.h?h=mtd/for-6.8#n99
>>>>
>>>
>>> The initial hyperflash predates opening up of HyperBus protocol and
>>> inclusion of it in xSPI spec. First gen Flashes followed CFI specification
>>> and hence made sense to make use of cfi_cmdset_0002.c
>>>
>>> We did have a discussion on extending spi_mem to support xSPI profile 
>>> 2.0 during the RPC_IF [3] [4].
>>>
>>> Overall, both Controllers and Flashes have moved away from CFI parallel 
>>> flash protocol over to xSPI / SPI NOR flash protocol (profile 2.0), so I 
>>> agree with Tudor's assessment that we need to move towards spi_mem in 
>>> longer term. So
>>>
>>
>> Good, thanks Vignesh! I'll study a bit more and let you know about the
>> progress on this topic.
> 
> Hi All

Hi,

> 
> At STMicroelectronics we got an OSPI block which is supporting both OSPI and HyperBus protocol
> similarly to the mentioned RPC-IF.
> 
> This means that we intend to split our implementation in 3 drivers as RPC-IF:
>   _ backend driver including common source code to OSPI and HyperBus
>   _ OSPI frontend driver
>   _ HyperBus frontend driver
> 
> Following this discussion thread, we are wondering if it will be the right direction to 
> choose in order to propose this implementation to MTD mailing list.

I think the right direction would be to have hyperflash on top of
SPIMEM, and the SPI controller under drivers/spi.
> 
> Have you an idea about time scale regarding the HyperBus migration over spi-mem ?
> 

No, sorry. It's at best effort from my side. Happy to review proposals
though.

> Thanks
> Patrice
> 
> 
>>
>> Cheers,
>> ta
>>
>>> a) Extend spi_mem_op to support xSPI profile 2.0 transaction template
>>> b) HyperBus layer can then either be a adapter from CFI to spi_mem for CFI
>>> compliant devices. And  be subsumed completely within SPI NOR for SFDP
>>> compliant devices.
>>> c) Move the existing controllers over to new framework.
>>>
>>>
>>> [3] https://lore.kernel.org/all/b8224f46-fc2e-de35-0a90-a2a86cacb489@ti.com/
>>> [4] https://lore.kernel.org/all/20200220084927.7a411d40@collabora.com/
>>>
>>
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/

