Return-Path: <linux-spi+bounces-6104-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2869F6274
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 11:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4816D1887828
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11AA19924E;
	Wed, 18 Dec 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iT/sFrrZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC319755B
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516825; cv=none; b=K6jb5R8uWRbnMLr+2D0iO3ZHPHxrN6kDj+E2bSwJ9odKpFCgP0VgJSlx1Mf1qm3HrxyqJCYfIYcucyfnf9Zz2rrPSQoQHoCC3IiN3XbCDh6fUsZ/bbysDKNj2cya/OzhxzZHRwyLaHzTIFV+jeTsNRLSwwVUqYWxI7gRnOXWhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516825; c=relaxed/simple;
	bh=Zr5idGKpBV6GiKj0rCjdPkT4cSGE9ZMLueAkneiKm/k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kZ0RWWIlqy3avCO2kje5ktXVcTKQR6N14Db0KYpLEJupp71TueL4mm02+O9buecnSGKzMg6gcdx98PFNatPCb6dSvW7wGgKQTlMC4TWKjjuh1C9JZ5qyoFjGnHJ8qVOZ3urmgg/kuwsDpwcYCZwb4dyLQ4OmGxsR9z+ydt7oYYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iT/sFrrZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so400198f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734516822; x=1735121622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EA1xX6cgrhop91VdIdUzvo0xa1Ga6IZLwxed7ZgRuGI=;
        b=iT/sFrrZtN2d0qqEf4Ba9i8d9kMdDV7zje94epQ3jv7yRqXegJAWtnTL0t+BN5KtRA
         7sNWX0d+pwO4Vi2xFSEOPwmEm29+loBJD2IMxgaLhtBS1US93WwtzTbuw5+U2vGNSmfs
         LwZ5VdAA+q3yMxdso26BMYpeZat4iTcxkI1YaVcKNCVb6qRyCzREOvHeiM3bo3DRaEDP
         3YhdL5+3JqEPbaa3sneP1doiEdltrAWEx5MlFk0tMoPvL2kj6/aTwWt7yqRjuojOceSo
         yvRgTTVuw12+SDK3H+EeAxQMKwlFn1zY7ap+hC0YtcE2SKhzq/MYf0hPc6trbpMB/rEf
         9OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516822; x=1735121622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EA1xX6cgrhop91VdIdUzvo0xa1Ga6IZLwxed7ZgRuGI=;
        b=j8kSHffVGRHTsqd6TawPfnr3zRr64BD/H4fbZbSUXAc43kwwVdr1WJ8eHdky/PVuam
         btzANQHNXhMQS0Dfi2VHRmDdvO27jeU9JXC0EJZsnIb/bWML40qiUqtUiShLQBzq65K0
         /oMQ0yrhklDebwUUK1OtVpSSxkJF8S0rWY+fft3l3qNWnvdHHcchDqdsxdAXhnaaEkXM
         ZfLDqzLIzEBLILYxEjw2tJG8Ox1c24R1U+Z0nC0VupXoACG86YHQwFZ1yotUIVuekzEY
         IbkxVJBV0gE2m5i0ZQhBMB6l4mQk9zCXI9074Bqz1PwUKFZTfsygc4EAb0GmJlxPPsZT
         mLQw==
X-Forwarded-Encrypted: i=1; AJvYcCV9+zqV80kcCiKFLkh62rkofcor7mV6okSoceJa0StdnqB6icEluH817mXLsE0n5Frgz4f8TBsUOig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuUy4DarMhBbbo8isJmeXEEaX1+xCkY71W155ApwoF9m3DN97
	HC2YFlREWHj1wFQlnv6WhfRhzOrvnhbJG/aBKLQYpLAy2uwxgvCkKGyo6qPn+D8=
X-Gm-Gg: ASbGncsxbj/5vBS9gOfcJCWIb2CAo6tVC1PRQ13FbwxyFhyM2QWYOxf4xkDFi2wUrTA
	x41Cra2Y8rQWcSXTRv0ymF0vOa1arQDMCvFtCgMZnz0mIidB+B1NB0sPbUcv3y4wCKpFcIlSJgt
	8xgLlbf1oaU/KctGhddANuY1M0m2Cg2exeHXWJ28ZEMaFTkDgMX1w2zHTAg9eRfV+aUDyfnrySc
	hznlGPgVx/J0czZz1ae5L3nGjfgowOgz8e308HyjI2nLNHW3CBPZqGglbdlBlGi
X-Google-Smtp-Source: AGHT+IGlRq284CuS7uoaLeloaLt5eflG4sksdjOOEUhLk3CPJGbxo8PFGszZT7dZb0Hrr/bKuI1PhA==
X-Received: by 2002:a5d:6481:0:b0:386:37f8:450b with SMTP id ffacd0b85a97d-388db22a3d5mr5484500f8f.5.1734516822024;
        Wed, 18 Dec 2024 02:13:42 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016678sm13587517f8f.27.2024.12.18.02.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:13:41 -0800 (PST)
Message-ID: <8738dbbc-e2a9-49dc-9234-65de6435bc45@linaro.org>
Date: Wed, 18 Dec 2024 10:13:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] spi: spi-mem: Extend spi-mem operations with a
 per-operation maximum frequency
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-2-miquel.raynal@bootlin.com>
 <e76ff30b-342e-4e4c-aa84-40312c3ffc72@linaro.org>
 <87jzc3oo6g.fsf@bootlin.com>
 <01f1bddd-7aee-4c90-9fa0-3b94c87eb469@linaro.org>
 <878qsde3i4.fsf@bootlin.com>
 <d12cc014-1e59-455e-8ee4-202997ddf846@linaro.org>
Content-Language: en-US
In-Reply-To: <d12cc014-1e59-455e-8ee4-202997ddf846@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/24 10:03 AM, Tudor Ambarus wrote:
> 
> 
> On 12/18/24 9:37 AM, Miquel Raynal wrote:
>> On 18/12/2024 at 08:07:24 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>>> On 12/13/24 10:46 AM, Miquel Raynal wrote:
>>>> Hello Tudor,
>>>>
>>>
>>> Hi!
>>>
>>>> On 11/11/2024 at 13:07:09 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>>
>>>>> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>>>>>
>>>>> cut
>>>>>
>>>>>>
>>>>>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>>>>>> index 17b8baf749e6..ab650ae953bb 100644
>>>>>> --- a/drivers/spi/spi-mem.c
>>>>>> +++ b/drivers/spi/spi-mem.c
>>>
>>> cut
>>>
>>>>>> +	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
>>>>>> +		((struct spi_mem_op *)op)->max_freq = mem->spi->max_speed_hz;
>>>>>
>>>>> not a big fan of casting the const out. How about introducing a
>>>>> spi_mem_adjust_op_freq()? The upper layers will use that were needed,
>>>>> and you'll still be able to pass a const op to spi_mem_exec_op()
>>>>
>>>> I know it is not ideal so to follow your idea I drafted the use of
>>>> spi_mem_adjust_op_freq(). In order to avoid the cast, we actually need
>>>> to call this function everywhere in the core and the drivers to make
>>>> sure we never get out of bounds, but here is the problem:
>>>>
>>>>     $ git grep -w spi_mem_exec_op -- drivers/ | wc -l
>>>>     42
>>>>
>>>> This approach requires to add a call to spi_mem_adjust_op_freq() before
>>>> *every* spi_mem_exec_op(). Yes I can do that but that means to be very
>>>> attentive to the fact that these two functions are always called
>>>> together. I am not sure it is a good idea.
>>>>
>>>> What about doing the following once in spi_mem_exec_op() instead?
>>>>
>>>>     spi_mem_adjust_op_freq(desc->mem, (struct spi_mem_op *)op);
>>>>
>>>> I know we still have a cast, but it feels more acceptable than the one I
>>>> initially proposed and covers all cases. I would not accept that in a
>>>> driver, but here we are in the core, so that sounds acceptable.
>>>>
>>>> Another possibility otherwise would be to drop the const from the
>>>> spi_mem_op structure entirely. But I prefer the above function call.
>>>
>>> How about introducing a spi_nand_spimem_exec_op() where you call
>>> spi_mem_adjust_op_freq() and spi_mem_exec_op()?
>>
>> That would work to make the cast disappear but TBH would not be totally
>> relevant as adjusting the frequency is typically something that would
>> benefit to spi-nor as well (maybe in the future) and therefore would
> 
> Right, SPI NOR will benefit of this too.
> 
>> fully apply to spi memories as a whole, not just spi-nand. We can think
>> about another naming maybe, but I find like spi_mem_exec_op() is the
>> right location to do this.
>>
> 
> It's not the first time that we adjust spi_mem_op parameters, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/drivers/mtd/spi-nor/core.c?h=spi-nor/next#n153
> 
> Does SPI NAND need to call spi_mem_adjust_op_size as well? I see it
> calls it when using dirmap, but not with a plain spi_mem_exec_op().
> 

I ask because I'm thinking of adding in the SPIMEM core a prepare()
method, and maybe rename exec_op() to exec(). And then introduce a
prepare_exec() method that the upper layers would call? Similar to
clk_prepare_enable.

