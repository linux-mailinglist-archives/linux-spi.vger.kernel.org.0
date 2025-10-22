Return-Path: <linux-spi+bounces-10770-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DE7BF9F34
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 06:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CB0E4EB560
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 04:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FB42D8781;
	Wed, 22 Oct 2025 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZHjikOvl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DC2D73AD
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107669; cv=none; b=SobJ3krRdwJ8VrAvK+EZixz5s0CZ8wnKkVWQWd0UUkdX62YVvRd3SFyz0KCbNfTVNRRV4vxvqF4m+ZN6pRzcbeWRC1d1T8rVyoREwe+p8yoxGUtNiGamlNydizzry7a/jC/0jPASErTPFSofKOgPwmYo+lWsW0qEltNuJnNF51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107669; c=relaxed/simple;
	bh=jzTEyl6EsyYKirucDMT2WpjFBD7rzCg5P5uTQ3Im7zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfOF+gwfLsSQXEs6lYY0WkSyYvYNYhr1mxbMmHQLDUMyEIHVcEwWwvOf0vrqai8sbXD1sASmvvTpEYBetNdJYbWGnGbrWrsdzgGsOGlfOfgEYgNQ6L67UawcWjCYQEtjCXYj0Jo/2yfu+5pND/+VuS43iRbSUB9PJcG2Oy7+UEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZHjikOvl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2697899a202so4213765ad.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 21:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107667; x=1761712467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r07oRrpAm0dALdqxQgRoSXIP8i4Uf1rUZOTVIHgHy6w=;
        b=ZHjikOvlCUFLZzQFmYDBTGEQFBcxn32Aq/TgomvhA5bVqmz1oFuvD0yFTjqik163rv
         F06oojH/whjTqyt61/svwsIeMV44VC1l4w0LCWzO2r0AexemCn3GNAZKrYGr96pMANuT
         Bv0QyKH7FI1ty9WGGq72UFyIppMTRxxYKLL8Mdu+QuvQovJ4Gy6evnCKe9t5Q4U/eOul
         9RBentzkJvBrSms7yVMZwGmDZ7n+rhm4ENR0J9iYNo7an/L5Hv2ZDuI+UoLBim3nNFrI
         C3Z4PC2V/0opy1xQLjtLVe5Xu7FSaX8Xw++CIfrlX420n/Iv3nhSCZAeGWn3ckZHR9zx
         GmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107667; x=1761712467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r07oRrpAm0dALdqxQgRoSXIP8i4Uf1rUZOTVIHgHy6w=;
        b=bLlJNi7v5Vkw5twbVjwqxC4j5xP7Rsf/iTM0K/Ztl4zO/3FvGikAbMcfJfyofybAFC
         m8zRoqYdewxy+0vDsuaRpCKWzZGMtyGsipgxnZ9MmEfRGH03EcFXapHKx9BmJWol6hAY
         xK2nXDdx4M7wG0cPEh6txcudtB1oBjTx1q0zg2ry98nz3duhIlvPnFPqOdGN6/heKY54
         8JHjHh7KHqnqy8bd/ZW11LTohG+V8LPyG5JKL+09jcGme9YtoRhoHK56/+wPphA49ZsB
         BpgS82IABNZOtf8ZepQjFJyQ7bu5HVqK4P7gu1WMd67mrXolrcaCUEKwjLPTCXPbcE23
         BX5w==
X-Forwarded-Encrypted: i=1; AJvYcCUmEXriHwVTbVgyFJRCOo7DknumNdQna05/ayh8/tzp4/2jE156s1cLMMIKYtRrqUlgUgNI/o5OoXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxPI4YZOXDwcXOltz+k3pwpIuChbaDdVt5I020llLvdvehJ8Tf
	dCbJMIJuctH2KYgaSEpdqeAq0YvfABjqTJwelFp7G9GsrCfV675xlYCrPRNe7iFqmjI=
X-Gm-Gg: ASbGncud9KOv6fcLW1dBbvfu9W6w6+9WdXSYIzfy1pYGUdwiRr9Sk4Tpjw4JbN7IKrV
	cRdGMYd2ZmAR8eRqVb7ccDlR11tTGCHBY9zdYh76MADeLj9LVVgxNCmqlA/Amwb+3Lh6hGHeUfm
	TOy9bRTFTTNh4HJsYsEc1VSPXWBZzGB/g838LTpij3sFyd6ITeyaSmf5FR1kZzGKSzb0oe2PkKe
	FRqSnWWnR+tVP6bnsGPlUcaP3dPdPZeDZ/jAi4NSwBeiNqDWjw31A6mAxDdwoCMZTterWFVXx9l
	ngngsu7QU46xsT8JwRCkpauyzEQvnzsAOkWzMIeIiz3+7B85tdfkyDgGUbJB3VWsdGtX64/XfHn
	cMOA8qnkiftBv9IXfl9lQHNiQLZjm6lW9JcGoedj0qxtjDiE2qIMUyoeZAZDiQD8GZgKauNPs28
	WCRUJfh/X7qErR
X-Google-Smtp-Source: AGHT+IEXbwpYqOJzdRZX+yeVCW+HRgEFHEhSfhpnfqLc9E63Y9hId0Tl9GklX8WzGZZ/QxYr9McgUg==
X-Received: by 2002:a17:903:17cb:b0:292:9ac7:2608 with SMTP id d9443c01a7336-2935e02e491mr1133385ad.8.1761107667134;
        Tue, 21 Oct 2025 21:34:27 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:26 -0700 (PDT)
Message-ID: <06af60b7-7ef7-451c-babd-e612a356013c@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:26 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] spi: fsl-qspi: allot 1KB per chip
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-6-elder@riscstar.com>
 <aPaLibm+oVKSDbL9@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPaLibm+oVKSDbL9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 2:20 PM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 11:51:48AM -0500, Alex Elder wrote:
>> In fsl_qspi_default_setup(), four registers define the size
>> of blocks of data to written to each of four chips that
>> comprise SPI NOR flash storage.  They are currently defined
>> to be the same as the AHB buffer size (which is always 1KB).
>>
>> The SpacemiT QSPI has an AHB buffer size of 512 bytes, but
>> requires these four sizes to be multiples of 1024 bytes.
> 
> I think it'd better to add field at fsl_qspi_devtype_data, like
> sfa_size.

OK.

> sz = q->devtype_data->sfa_size ? q->devtype_data->sfa_size : q->devtype_data->ahb_buf_size.

Why not just set sfa_size always then?

Anyway my biggest concern on this was what to call it.  What
does "sfa" stand for?

I'll do it the way you suggest for v2.

Thanks.

					-Alex


> 
> qspi_writel(q, addr_offset + 1 * sz, base + QUADSPI_SFA1AD);
> ...
> 
> Frank
>>
>> Rather than add a new quirk to support this scenario, just
>> define the four sizes to be 1KB rather than being dependent
>> on the AHB buffer size.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/spi-fsl-qspi.c | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 703a7df394c00..9ecb756b33dba 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -795,17 +795,14 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>>   	 * In HW there can be a maximum of four chips on two buses with
>>   	 * two chip selects on each bus. We use four chip selects in SW
>>   	 * to differentiate between the four chips.
>> -	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
>> -	 * SFB2AD accordingly.
>> +	 *
>> +	 * We use 1K for each chip and set SFA1AD, SFA2AD, SFB1AD, SFB2AD
>> +	 * accordingly.
>>   	 */
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
>> -		    base + QUADSPI_SFA1AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
>> -		    base + QUADSPI_SFA2AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
>> -		    base + QUADSPI_SFB1AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
>> -		    base + QUADSPI_SFB2AD);
>> +	qspi_writel(q, addr_offset + 1 * SZ_1K, base + QUADSPI_SFA1AD);
>> +	qspi_writel(q, addr_offset + 2 * SZ_1K, base + QUADSPI_SFA2AD);
>> +	qspi_writel(q, addr_offset + 3 * SZ_1K, base + QUADSPI_SFB1AD);
>> +	qspi_writel(q, addr_offset + 4 * SZ_1K, base + QUADSPI_SFB2AD);
>>
>>   	q->selected = -1;
>>
>> --
>> 2.48.1
>>


