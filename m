Return-Path: <linux-spi+bounces-549-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3F835AE4
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 07:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5461C2231F
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B005C96;
	Mon, 22 Jan 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vwikl4ot"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFF63A0
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705904475; cv=none; b=CfhTCM6jbJQtsMgbBStRlXeG4ckZ29s+wk2jBR0MxxGtyyb3zviPW+6686XIIpGSv2cLiiSe6SO41oE7SvzDX1swHlwWJ4FP3E0ex9cAVtGYIW8awW11myLYYmINJJUOhKnxKEJT8EY5nfV8F4OdwF9+mofhkXubyG48OgOGeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705904475; c=relaxed/simple;
	bh=xBuXJbLy1Pw5aT6D5UaKOow4sGv2m13i6WVrP/7UuZc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=etfmzD29k1WpL/M4+NnhXmgRgjbbxmLOPfH3UAyLxKhgPp7IjrR4i8Ym9XZG6kVjF5yfruQZyMPOoXAscVTZ8PbgEbG8ewcsKHtYq0yN5zjv/FtCdEKTuXGkuJt5S8YFci6fymC3v4AtAsax/utqmOH1K+OSL9PhotrWBRvte+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vwikl4ot; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bd6581bc66so2350364b6e.1
        for <linux-spi@vger.kernel.org>; Sun, 21 Jan 2024 22:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705904473; x=1706509273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOUvrfJMtFQiu+APkiSNEq21pDYlm0+yFD3itYMGbKU=;
        b=Vwikl4otyUV7pH0htrdgwaHUqLPtmGOhHsoowjBpqHLPmYqESr8myufdotEpefza+L
         MRlo0ENP33yYNxSe5rIjY4FbkdpiZuLWzYszEWxqO/1sSENXhs5lT4pbtHVjKnTtOp9w
         MO50f2A7r5MBfsoRV8jb3YMsicUC349YnuamkT8l3I8mT+vSc7Fjc2S2BouF107xB+dW
         c5fjzZwiZBsPdSAP4x3I6+4no+NKdLfiykmAUlkv1nEFFTLWiGvGKKNEKpjjinIAP79r
         5P2JZveuJfq85qsCN0A5i37f20fvKeXsyu3gTqNsTEpk5DR1IVPad7vhcJPJIZUBCwM5
         uE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705904473; x=1706509273;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOUvrfJMtFQiu+APkiSNEq21pDYlm0+yFD3itYMGbKU=;
        b=GDYGWmo2tId4aKf3Tt36el+XO2w6iNLJu9n+GLC+Xv3GfPCJ9vDEJGrXw5jxzXmSvs
         qVafzGol2E60zJ3Oz6BG0Vh6LbJYbxYkxrLs6OvAF2Wos0BmoY+KH9PUO4cUMYHLwWPU
         K2I2jEHHLIbaEWJJt5OKwK52+XQ8F9MpXDeQ2avanUCaT+QO0hpYx5bRCuOycB7ge+Wm
         ldJT1D+vB3x3IQzNRrOTu++KKJDzAe0hkIjUYfzIQAzAYrqe8ZktHSicuawL7pCdbAkf
         i7VexL1mZtztJoBrUGmJ51HFzwx8RUWXJ4cbZLXtv0FMjW8fdpYb/wgGI7FnZIAZhx/A
         pcFA==
X-Gm-Message-State: AOJu0YzXws8iLkq5C21VhMJwVJHtZWJpkKwFOBALvxCn/hfmHWpf9bOl
	QURCG7lRYxi8oHNXV+bhwoDuxlhKtm8zo7XN/Op1krtSCNv7wf63Wn51EuEH79Q=
X-Google-Smtp-Source: AGHT+IHiiWSWHMAuT/uXZCmNUeGYNGRNw8x3kzfBHMhQYQVfqLWMUHXSt3FfdxF6WDBOd3dxxuzVSQ==
X-Received: by 2002:a05:6808:11c5:b0:3bd:ac25:a179 with SMTP id p5-20020a05680811c500b003bdac25a179mr4141385oiv.10.1705904473254;
        Sun, 21 Jan 2024 22:21:13 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id fd37-20020a056a002ea500b006dbe4452741sm691415pfb.72.2024.01.21.22.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 22:21:13 -0800 (PST)
Message-ID: <66b923af-8d10-42ac-8a24-b967d716be99@linaro.org>
Date: Mon, 22 Jan 2024 08:21:04 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mtd: hyperbus: Add support for Infineon S26Hx-T
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: tkuw584924@gmail.com, linux-mtd@lists.infradead.org,
 Vignesh Raghavendra <vigneshr@ti.com>, geert+renesas@glider.be,
 Mark Brown <broonie@kernel.org>, s.shtylyov@omp.ru
Cc: pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
 richard@nod.at, d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <cover.1680663252.git.Takahiro.Kuwano@infineon.com>
 <d94273b2-9516-2b80-308f-9fd1fdd2b4d5@linaro.org>
 <158830c6-d492-4967-a543-c0f5f8428d8b@linaro.org>
In-Reply-To: <158830c6-d492-4967-a543-c0f5f8428d8b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ah, Sergei's email was bouncing, I updated his email address.

Sergei, would you please read the thread? Thanks!

On 22.01.2024 08:11, Tudor Ambarus wrote:
> + Sergei, Geert, Mark & linux-spi
> 
> Hi, Sergei,
> 
> On 23.05.2023 07:22, Tudor Ambarus wrote:
>> Hi, Takahiro, Vignesh,
>>
>>
>> On 07.04.2023 09:11, tkuw584924@gmail.com wrote:
>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>
>>> This sereis adds support for Infineon S26HL-T/S26HS-T flash family.
>>> https://www.infineon.com/dgdl/Infineon-S26HS01GTGABHM020-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7f2a768a017f52f2f5182c91
>>>
>>> This family supports two interface modes, SPI mode and Hyperbus mode. The mode
>>> can be switched at rutime. The default mode is selected by ordering option
>>> and non-volatile user configuration. In hyperbus mode, the device is compatible
>>> with S26KL-S/S26KS-S hyperflash family that supports hyperbus only so one of
>>> use cases of S26Hx-T is replacement of (or migration from) S26Kx-S. This patch
>>> set focuses on particular usage that the device is pre-configured as hyperbus
>>> mode for compatibility with S26Kx-S.
>>
>> I'm questioning the overall hyperbus software architecture, not your
>> patches per se. IMO hyperbus framework should have been written on top
>> of SPIMEM and the controllers be placed in drivers/spi/. So I'd first
>> address the SPIMEM adoption before adding/accepting new support. Would
>> love to hear more from Vignesh.
>>
> 
> RPC is the only multi IO SPI controller that's upstreamed and capable of
> dealing with hyperflashes, but there are others which are not upstreamed
> yet (microchip).
> 
> Struct ``struct rpcif_op`` [1] duplicates the contents of ``struct
> spi_mem_op`` [2] which could have been avoided if hyperflash driver was
> extended with SPI MEM support. This way the RPC hyperbus driver, which
> is an SPI controller, could have been moved to drivers/spi.
> 
> Sergei, do you remember why we haven't used SPI MEM for hyberbus since
> the beginning? Was it something that we aimed for in a future patch set?
> 
> Thanks,
> ta
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/memory/renesas-rpc-if.h?h=mtd/for-6.8#n22
> 
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/linux/spi/spi-mem.h?h=mtd/for-6.8#n99
> 

