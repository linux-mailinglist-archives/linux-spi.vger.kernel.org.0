Return-Path: <linux-spi+bounces-551-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A8E835C5B
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 09:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69DA9B2725C
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 08:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811D1879;
	Mon, 22 Jan 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+Xz36RK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A720DDA
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911236; cv=none; b=TcXkozapvNaCdnyCp1xXQ7GW5VPB7ND1+Lku30e0riowY2UnakblELkwreJMh2Hw1Q1yDnRlG9wgDJIwWLeV+HdwmTXb1M4UAk3EovcSZuZyRtKXcOyVWhRz7tNfs18PWEkaYhRIAbSwLBonSgbAy86vQ/Y/n5ydPtfBAkklT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911236; c=relaxed/simple;
	bh=45VAqY6hY9TSXXgegXeM+hWvjah5o92ZB4S//grGjXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCqG7hXiCAQVvL3NBN8K7UZ9S4SFrs9XNNnHuLiNrXLvorQNZ3Wkpo3RIiicFodYuTvaAVNtQYrOOwYgwU+Bow94+Ho50dXltKCDLpTV0JvRNm1JMZBq8G050j34jhX/drvq4C3uwuiMmqDAJFrnUDbuG9ZKhtjyS+nzg1ReKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+Xz36RK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3392b12dd21so1239122f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 00:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705911233; x=1706516033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bETPM8oCthIJxvtz9/EW/JDG11DvuEOvRmdYkisMXk=;
        b=T+Xz36RKLUNANyzJZgHejWUtjcBlkIvdbdSrraDp+tRAY2Ioa5ILoLiYKSoiFoWXQq
         vP3PtWfQoCYHdmQhrla2/CxyWIlIaandvdqHJmj1z/B88jcKzE5o784OIQQgiRP69QLI
         vO5AWyoT7dURlEL1DM12Y3kgiU6Jl/TSalkqpwReJ/neesG0khFBtROt8oqYlGXsjS54
         PBlbvxr2A4l8q+kgsDtKJniZbgkrkAIPDksljbb1dvuDgx/dgpSUjIIEDATY9RcpXYcq
         3dPg46ODTzR4S0JwfgCfDiM5BhnSEo9pxlHMFOgeNJMW7jO8eJPD6Rlre1SEmMrUMxbj
         mfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705911233; x=1706516033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bETPM8oCthIJxvtz9/EW/JDG11DvuEOvRmdYkisMXk=;
        b=OOvlKWKoIcntmCUBu9Sw0cmYE6olYzDE7UTaYkD1mt6ijbLBZQcvBXZPHqMYIOlZik
         m0BZeg3IabhFmuCcQSP94nJoXVAMugqaSRf6Rfho7gLUkW1X5I5jLryY7u8ucRVzuQAp
         nlIia0j0KO/90XpZjRu7af9owpxQ4216LGC39ilyV6Cvxfe7p8b779DBZhB3vzKHTwli
         HhIWdSj/PhVUUenqq+U4KY6cvnYBLh2q/vJw2OldvoF3l3SnWfR1d9qbC4ALSnZPWOOV
         zcpS46MhTEjx8SmN5ybStFXH5uIxLnUiUWMJDjXFEF1dqAwBB7yKIyuUlyUfrHiTVmVc
         9LAA==
X-Gm-Message-State: AOJu0Yw81BqvHYlpT4dMasksL7ieeUXyoU0xNOXEM3ry6LPmJyI0edwS
	fGajEJIa6edz7irrM18PqGIzTheTVNE5tiErZSQUdRHLdDB/SmdHDu7Rl/B4kvU=
X-Google-Smtp-Source: AGHT+IEv81t2Cirbph1WSpZmMPNn9zT/tADSV0WIaGjAKOec1NK91Mm5MQPNd9pObJr69GaIhuvgWQ==
X-Received: by 2002:adf:f6cb:0:b0:337:bfe8:5bfd with SMTP id y11-20020adff6cb000000b00337bfe85bfdmr2263974wrp.50.1705911233429;
        Mon, 22 Jan 2024 00:13:53 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d5608000000b003392bcd6c48sm4780856wrv.79.2024.01.22.00.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:13:52 -0800 (PST)
Message-ID: <508196d4-a533-47c9-bf6e-5718364c8d54@linaro.org>
Date: Mon, 22 Jan 2024 08:13:50 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mtd: hyperbus: Add support for Infineon S26Hx-T
To: "Raghavendra, Vignesh" <vigneshr@ti.com>, tkuw584924@gmail.com,
 linux-mtd@lists.infradead.org, sergei.shtylyov@cogentembedded.com,
 geert+renesas@glider.be, Mark Brown <broonie@kernel.org>
Cc: pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
 richard@nod.at, d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <cover.1680663252.git.Takahiro.Kuwano@infineon.com>
 <d94273b2-9516-2b80-308f-9fd1fdd2b4d5@linaro.org>
 <158830c6-d492-4967-a543-c0f5f8428d8b@linaro.org>
 <2bcf6646-b7ce-48c9-8a9b-0634c3fb40e9@ti.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2bcf6646-b7ce-48c9-8a9b-0634c3fb40e9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/24 06:25, Raghavendra, Vignesh wrote:
> 
> 
> On 1/22/2024 11:41 AM, Tudor Ambarus wrote:
>> + Sergei, Geert, Mark & linux-spi
>>
>> Hi, Sergei,
>>
>> On 23.05.2023 07:22, Tudor Ambarus wrote:
>>> Hi, Takahiro, Vignesh,
>>>
>>>
>>> On 07.04.2023 09:11, tkuw584924@gmail.com wrote:
>>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>
>>>> This sereis adds support for Infineon S26HL-T/S26HS-T flash family.
>>>> https://www.infineon.com/dgdl/Infineon-S26HS01GTGABHM020-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7f2a768a017f52f2f5182c91
>>>>
>>>> This family supports two interface modes, SPI mode and Hyperbus mode. The mode
>>>> can be switched at rutime. The default mode is selected by ordering option
>>>> and non-volatile user configuration. In hyperbus mode, the device is compatible
>>>> with S26KL-S/S26KS-S hyperflash family that supports hyperbus only so one of
>>>> use cases of S26Hx-T is replacement of (or migration from) S26Kx-S. This patch
>>>> set focuses on particular usage that the device is pre-configured as hyperbus
>>>> mode for compatibility with S26Kx-S.
>>>
>>> I'm questioning the overall hyperbus software architecture, not your
>>> patches per se. IMO hyperbus framework should have been written on top
>>> of SPIMEM and the controllers be placed in drivers/spi/. So I'd first
>>> address the SPIMEM adoption before adding/accepting new support. Would
>>> love to hear more from Vignesh.
>>>
>>
>> RPC is the only multi IO SPI controller that's upstreamed and capable of
>> dealing with hyperflashes, but there are others which are not upstreamed
>> yet (microchip).
>>
>> Struct ``struct rpcif_op`` [1] duplicates the contents of ``struct
>> spi_mem_op`` [2] which could have been avoided if hyperflash driver was
>> extended with SPI MEM support. This way the RPC hyperbus driver, which
>> is an SPI controller, could have been moved to drivers/spi.
>>
>> Sergei, do you remember why we haven't used SPI MEM for hyberbus since
>> the beginning? Was it something that we aimed for in a future patch set?
>>
>> Thanks,
>> ta
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/memory/renesas-rpc-if.h?h=mtd/for-6.8#n22
>>
>> [2]
>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/linux/spi/spi-mem.h?h=mtd/for-6.8#n99
>>
> 
> The initial hyperflash predates opening up of HyperBus protocol and
> inclusion of it in xSPI spec. First gen Flashes followed CFI specification
> and hence made sense to make use of cfi_cmdset_0002.c
> 
> We did have a discussion on extending spi_mem to support xSPI profile 
> 2.0 during the RPC_IF [3] [4].
> 
> Overall, both Controllers and Flashes have moved away from CFI parallel 
> flash protocol over to xSPI / SPI NOR flash protocol (profile 2.0), so I 
> agree with Tudor's assessment that we need to move towards spi_mem in 
> longer term. So
> 

Good, thanks Vignesh! I'll study a bit more and let you know about the
progress on this topic.

Cheers,
ta

> a) Extend spi_mem_op to support xSPI profile 2.0 transaction template
> b) HyperBus layer can then either be a adapter from CFI to spi_mem for CFI
> compliant devices. And  be subsumed completely within SPI NOR for SFDP
> compliant devices.
> c) Move the existing controllers over to new framework.
> 
> 
> [3] https://lore.kernel.org/all/b8224f46-fc2e-de35-0a90-a2a86cacb489@ti.com/
> [4] https://lore.kernel.org/all/20200220084927.7a411d40@collabora.com/
> 

