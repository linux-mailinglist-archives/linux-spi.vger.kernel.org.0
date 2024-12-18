Return-Path: <linux-spi+bounces-6103-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E67EF9F624C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 11:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A218813C4
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B53113AA41;
	Wed, 18 Dec 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKtUljBU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D6126F1E
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516203; cv=none; b=Z9IWYxZhYw7YLX31KeWMgdPQaw/UUJRMalXHFGv8nJlnzusq7mh1/sv6ahtYh+83Q01Wbh545K9Z0V4MMFOUFx3DF+DClnj7DzdzYPaReR2ts5Q6F772LAMYwk6EL8ySFNtRFfjN4NV8wtwHHZLa+0DTl+Xvf0cguR3nyctSDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516203; c=relaxed/simple;
	bh=mMYkZ8ncqHT4WHiP4iO3WxU38SjwklvTYkpkec+Rsb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pc93b+InotftnvuiP2hlx7+aj8BraSGgcDiVVbaepoAcC+sjM6J++6jZYz5EmXbftwc8eCZhIbIfN2+bRHAUBXrpd40ra49Lykqn4UmxHFkJlXPF63i8HYlaC2nF7d52IktCLDhJ5FH/kxfA3cESFkHbbxH2WRnrKhyX6of7/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cKtUljBU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so60767475e9.1
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 02:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734516200; x=1735121000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKzI7riGbEMm6mOJZXoMF57L8yBnnT/XbsePOEHKtAc=;
        b=cKtUljBU8KMIFMMpGSWQLMkXYWt840XsWBQNXgiA8Wj+M201JUhUqBk9VMmaK2rhxD
         JIBBkcvtErV17/4S3fpgyOziAegm4KvFAW4STSzExNV8kU0EB9aQs6ZT35mA75OuYAuP
         X3wQItgcJBPxBi1SLd+BT9imz368LyP30q6cId71IPWILd+1lxaJQpYyNo4oV1bbGzrJ
         8OIGu2zlXE60eO+5Cc/58xNKBc19Adg/007cwD+0eI8a0cQw0D/pMMNASIW7aSOK3yfb
         a8lSaPRsBoG2ON7HGZ2cVb5vyECvZwFz8MKrYOpQQWolkkub0plf6C0eJfIsF6l4m+SN
         9eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516200; x=1735121000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKzI7riGbEMm6mOJZXoMF57L8yBnnT/XbsePOEHKtAc=;
        b=PWkvKKhSjRi8GOm3O9/h+T2i86NUnoIrPScd3eg9EINvbB9AglKNcMX4brej17tlXv
         kOoCyWRUEufUsdnBiB8zsN+laUsabKB1oBe4MJTeJbsPTBeA40mD8+rwy0JXcdvWDlCp
         ARdQWTsSDqoSNm05kLlokyn/xk+2/Nqobj5atK88Y1bQ6tT1vdWlzd419gEDBkvmUn0E
         /G6yM8sSzp4TOGPRYQebm+6RmSoLTVSwiY4rxfaNeG8jimKL7bcl02MJ/q3AhssXJvav
         5ZbIuLIM5h8W4Ujmlq0jA8HJU/fLbAkSWbhtjev/mo03nQ7AJXWTyBd0AxBryGRR5Atq
         S8JA==
X-Forwarded-Encrypted: i=1; AJvYcCWm3rTMRam/T3oSQtkeC72WT2iVz04w/YIuU7Cw3WJe4AyTjeXvZZbNPnxd1yVZOUjcu1eKBUomaS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0Eo2b7ESQyuDsAk6WUWd0t590cxlhuj84v5oYKMWVBawhBS9
	JAYQB4W4aInLs+cOYTbs4XwJnZQHJcK3mCYCtp4Gtm7xK69xPWfOHZwammQ14lQ=
X-Gm-Gg: ASbGncvNgYlqj5M32RmXOpn30xiTJV30T7dZABDjoa6f8fMPXdBJbdSA2tMUfFlYztF
	be1W/4jfxX0EYMZjh2+zGvIM96xqGkU+RV8zO+MMTf65qgLj/ZCWEey5j9mTI23eaUO8oMY7nR2
	URsDf0wFs8dx0BNiFAj7h3POlXdYQk9vhsraC0M/ikvqZ1DuZ8eNeIT25OMXGACXy3C5PhNqe5O
	Y09YyelehhFjqA8p8+daZ/fp6qYz7Ey9dqU3voucodFXhdWmvZrp/sF8xSjV16v
X-Google-Smtp-Source: AGHT+IFgSZnSfBoewe1UVvXyC66jjcSa1rlW+n+CvSPPGczGxny8+Gx87jTbercBXIIuR0+kNeYvHA==
X-Received: by 2002:a05:600c:4587:b0:435:fa90:f19f with SMTP id 5b1f17b1804b1-4365535b6eemr18452215e9.12.1734516200119;
        Wed, 18 Dec 2024 02:03:20 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656afc103sm15144885e9.7.2024.12.18.02.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:03:19 -0800 (PST)
Message-ID: <d12cc014-1e59-455e-8ee4-202997ddf846@linaro.org>
Date: Wed, 18 Dec 2024 10:03:17 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] spi: spi-mem: Extend spi-mem operations with a
 per-operation maximum frequency
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
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <878qsde3i4.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/24 9:37 AM, Miquel Raynal wrote:
> On 18/12/2024 at 08:07:24 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 12/13/24 10:46 AM, Miquel Raynal wrote:
>>> Hello Tudor,
>>>
>>
>> Hi!
>>
>>> On 11/11/2024 at 13:07:09 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>
>>>> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>>>>
>>>> cut
>>>>
>>>>>
>>>>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>>>>> index 17b8baf749e6..ab650ae953bb 100644
>>>>> --- a/drivers/spi/spi-mem.c
>>>>> +++ b/drivers/spi/spi-mem.c
>>
>> cut
>>
>>>>> +	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
>>>>> +		((struct spi_mem_op *)op)->max_freq = mem->spi->max_speed_hz;
>>>>
>>>> not a big fan of casting the const out. How about introducing a
>>>> spi_mem_adjust_op_freq()? The upper layers will use that were needed,
>>>> and you'll still be able to pass a const op to spi_mem_exec_op()
>>>
>>> I know it is not ideal so to follow your idea I drafted the use of
>>> spi_mem_adjust_op_freq(). In order to avoid the cast, we actually need
>>> to call this function everywhere in the core and the drivers to make
>>> sure we never get out of bounds, but here is the problem:
>>>
>>>     $ git grep -w spi_mem_exec_op -- drivers/ | wc -l
>>>     42
>>>
>>> This approach requires to add a call to spi_mem_adjust_op_freq() before
>>> *every* spi_mem_exec_op(). Yes I can do that but that means to be very
>>> attentive to the fact that these two functions are always called
>>> together. I am not sure it is a good idea.
>>>
>>> What about doing the following once in spi_mem_exec_op() instead?
>>>
>>>     spi_mem_adjust_op_freq(desc->mem, (struct spi_mem_op *)op);
>>>
>>> I know we still have a cast, but it feels more acceptable than the one I
>>> initially proposed and covers all cases. I would not accept that in a
>>> driver, but here we are in the core, so that sounds acceptable.
>>>
>>> Another possibility otherwise would be to drop the const from the
>>> spi_mem_op structure entirely. But I prefer the above function call.
>>
>> How about introducing a spi_nand_spimem_exec_op() where you call
>> spi_mem_adjust_op_freq() and spi_mem_exec_op()?
> 
> That would work to make the cast disappear but TBH would not be totally
> relevant as adjusting the frequency is typically something that would
> benefit to spi-nor as well (maybe in the future) and therefore would

Right, SPI NOR will benefit of this too.

> fully apply to spi memories as a whole, not just spi-nand. We can think
> about another naming maybe, but I find like spi_mem_exec_op() is the
> right location to do this.
> 

It's not the first time that we adjust spi_mem_op parameters, see:
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/drivers/mtd/spi-nor/core.c?h=spi-nor/next#n153

Does SPI NAND need to call spi_mem_adjust_op_size as well? I see it
calls it when using dirmap, but not with a plain spi_mem_exec_op().



