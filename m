Return-Path: <linux-spi+bounces-548-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666E2835AD0
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 07:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE72824EC
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jan 2024 06:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A3217F8;
	Mon, 22 Jan 2024 06:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biZrdXLp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD685673
	for <linux-spi@vger.kernel.org>; Mon, 22 Jan 2024 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903905; cv=none; b=qe3PbM2xlEe3RHm6uLJ4roqidnspMngDKWc7gV4a/QpRnoCTyZr77mJogC+fJJaIUi3nti5GNZqNVfh+tHmutzDzEBxrc+JAawLP1E/Xr8keN9y47J2p9lX2kMYPU5zplQeAz8hfTaFczYkcItmk2PN54H29wq/WmCXRfjXU8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903905; c=relaxed/simple;
	bh=Z+xPoD+4pYZSQHo1V1w/4Y1crTh/ephLD8tSbP8vH5w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PsRuCHFo5dN02hthSApLiWK9U2KnGBrDuPjQQo/fufl3Y41XtxW03W/vAxVkVJ1ZXzcHeLjCL9pikkmHr+R4WXJ3qvWfGcMO9mWS0LMORYtDWFMjaoXy7MK1niamxan3xaqdkQ16AXwuE3SHzhpQ8WNruG485vGvDAyg4N+73Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=biZrdXLp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2fbb646eb4so169516666b.3
        for <linux-spi@vger.kernel.org>; Sun, 21 Jan 2024 22:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705903901; x=1706508701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RIcaNbIbYjZhJZaFVFa9N/62Fsv5I4TrG8yXnt0PL2o=;
        b=biZrdXLp50ILfxDWIhWfTjkmHy3dvN/TZYUOnLMFBSXemksZ7ELOK2VFGXRafCPqHq
         MXr4yBPf+gPjCiR7mUF3LnDz17ufAUQAmmirLenppWLm2Ny3vDdBQlBK6MkLZtv18TN5
         fJW6qVCZONYQWikWAIxvtf6G3j9kLlsfKq3+p8Wo9PiX4/6HfP3LVve8vHv4vpL1o+uV
         o/QRH+MM8/WWiB4EBOiElp7UaXGH60RjYzl+fVyObtUCqhhUqAn8fIhnJjX2Vo0CL+d7
         /iTkd5NtC4bJZs7XYXq8Ms6bDJHrmhOmRaip2BbNa6i5u8EMKeaLP4VyEM68JiIJU1VW
         BYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705903901; x=1706508701;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIcaNbIbYjZhJZaFVFa9N/62Fsv5I4TrG8yXnt0PL2o=;
        b=UvdI9Mn3D49wdDggOcib+TSh2g4VsC3tvkCB0Pryjx41cBEZ4xNzXFEKmRhnqssHqg
         7dIOfTk+VVRS0lrkhWdvzXmzYH4eFu31sQFpKvRaaIAmlqSKuQUDA0deZcGLL/DppoUm
         fahFMB2bum/3ihIJPh0G9f8eozS+5fJ4Hk8gPcxzWYBpwCro0MkPT1TrmZJlRBjiUmty
         l0nW/muyn7aGODNDdLjpb0XF07urr3T3n8fAkxPN15GzBryvZNAr0gR/Yv9QYvFO63Up
         3YTpc4pfjowWeJHIxclT1TUOu5mHO4a49mwx6gT/0lB6FsZf3sNhT4VMKTfpNgv6Bayk
         faCg==
X-Gm-Message-State: AOJu0YxMHyvAe0/LD/H08k4S+26Vde2+wdlqpoayuFlAasYQ6wtRzX90
	pYubJTf1y+em8JgryJmAIT3A7b3obLM91b6ZNk/b+pyFeL2faF8BHZ0nDzZzwkE=
X-Google-Smtp-Source: AGHT+IFSFZsZFRemCFZuOlTP3Z1DcCiYWF6dB5Cw4RmXxg5Rs8bDDiKyLhYhZPNfo+Z7CiK9NIWnrA==
X-Received: by 2002:a17:906:a008:b0:a2d:edc:de0 with SMTP id p8-20020a170906a00800b00a2d0edc0de0mr1830242ejy.76.1705903901476;
        Sun, 21 Jan 2024 22:11:41 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id wr8-20020a170907700800b00a2e08b24ea3sm8373350ejb.174.2024.01.21.22.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 22:11:40 -0800 (PST)
Message-ID: <158830c6-d492-4967-a543-c0f5f8428d8b@linaro.org>
Date: Mon, 22 Jan 2024 08:11:37 +0200
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
 Vignesh Raghavendra <vigneshr@ti.com>, sergei.shtylyov@cogentembedded.com,
 geert+renesas@glider.be, Mark Brown <broonie@kernel.org>
Cc: pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
 richard@nod.at, d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <cover.1680663252.git.Takahiro.Kuwano@infineon.com>
 <d94273b2-9516-2b80-308f-9fd1fdd2b4d5@linaro.org>
In-Reply-To: <d94273b2-9516-2b80-308f-9fd1fdd2b4d5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Sergei, Geert, Mark & linux-spi

Hi, Sergei,

On 23.05.2023 07:22, Tudor Ambarus wrote:
> Hi, Takahiro, Vignesh,
> 
> 
> On 07.04.2023 09:11, tkuw584924@gmail.com wrote:
>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>
>> This sereis adds support for Infineon S26HL-T/S26HS-T flash family.
>> https://www.infineon.com/dgdl/Infineon-S26HS01GTGABHM020-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7f2a768a017f52f2f5182c91
>>
>> This family supports two interface modes, SPI mode and Hyperbus mode. The mode
>> can be switched at rutime. The default mode is selected by ordering option
>> and non-volatile user configuration. In hyperbus mode, the device is compatible
>> with S26KL-S/S26KS-S hyperflash family that supports hyperbus only so one of
>> use cases of S26Hx-T is replacement of (or migration from) S26Kx-S. This patch
>> set focuses on particular usage that the device is pre-configured as hyperbus
>> mode for compatibility with S26Kx-S.
> 
> I'm questioning the overall hyperbus software architecture, not your
> patches per se. IMO hyperbus framework should have been written on top
> of SPIMEM and the controllers be placed in drivers/spi/. So I'd first
> address the SPIMEM adoption before adding/accepting new support. Would
> love to hear more from Vignesh.
> 

RPC is the only multi IO SPI controller that's upstreamed and capable of
dealing with hyperflashes, but there are others which are not upstreamed
yet (microchip).

Struct ``struct rpcif_op`` [1] duplicates the contents of ``struct
spi_mem_op`` [2] which could have been avoided if hyperflash driver was
extended with SPI MEM support. This way the RPC hyperbus driver, which
is an SPI controller, could have been moved to drivers/spi.

Sergei, do you remember why we haven't used SPI MEM for hyberbus since
the beginning? Was it something that we aimed for in a future patch set?

Thanks,
ta

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/memory/renesas-rpc-if.h?h=mtd/for-6.8#n22

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/include/linux/spi/spi-mem.h?h=mtd/for-6.8#n99


