Return-Path: <linux-spi+bounces-5689-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942F19C6BB0
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 10:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525552859A9
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F068165EE3;
	Wed, 13 Nov 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CR8uBsEW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD532AF04
	for <linux-spi@vger.kernel.org>; Wed, 13 Nov 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491168; cv=none; b=FdnCBzTvmQPzLqNFc8o5m8N6jf+kgRLXqARbo9fWoK+BXN9nMkCb1UkGfVi4x6g19OkAMg4MbDc9Zg6warqa5pwp8Ywq2kqLGsCBkJoQ5LkTT0pUiSkgG6Vbf08m6V/nje4MKRjCabzCojjwkCSga85CJJTvYfCY72ARzgNXPTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491168; c=relaxed/simple;
	bh=dJQCmwut/8SzovXPWlCtM73t0CcN8/w6CyK6LbRy3DA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mxwUWgk4H0RVn7vfF9Yh9xMGbLNFNe49i5UUqSxt12b6LP87OSkW9y9+5Lgdywb/1ypv7yCuhUuDiUb5/Kkm1pEFGgTa5ZEu4cKDIJKh4SVKKHQpkBPCk7YV+2uR4v1JOspDG0qq96IvZ1wE+pKuwlRFnFTfuiJzDEbpyC14ttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CR8uBsEW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e59dadebso7891380e87.0
        for <linux-spi@vger.kernel.org>; Wed, 13 Nov 2024 01:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731491164; x=1732095964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aG6ULzMF9hbDS27IR5UiwotWanEPH5uCO+27foPjqlQ=;
        b=CR8uBsEWDquRWfO8xDFi3KClGZTawjQLFxjlazdYGE9XW20+0+vs3yXlT3EJfjvd+K
         EBAPIPHhv8Hc7KVIorS4v3rMExhMifwjfMGQIQnrKZcfyaTiMQLvkBLMc3R0Cm02YOM0
         50R2AbJCCHN3XJP8BydY/WmqSo5ACqcTidpyMigXD/XddWLbdlsPl5D7GhmEt7jbPyo3
         6FEWPdnu8qk4rX9d9nMer0EeXhUme0OYiGahGue6ENCavYlhnS479/zcfuy0kSkSa79l
         cHfB+AXoJa1mmmLEniZl8qfruSfeRtwzPbh9WZJtJUil9sEjqINRifvNQt3hZeliYKa3
         L8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731491164; x=1732095964;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG6ULzMF9hbDS27IR5UiwotWanEPH5uCO+27foPjqlQ=;
        b=V0BuoUrMIt5M7GT9IXUi6TYxjlsMarTri/3XFFfFWEmTzv3KCstlJx6kWGAPCiA/b7
         5K+M6Da0PgpMw+Ls4qFm7tiul5BoRof5wFUEruoQd73vJIlasVDpyBnfd6k+yj32gvcc
         5r8oykeqDfAbQQll6T8OceEagNtzEiFvNdsvLAFD61Ery+8u0ZsToGqOt/hxVSFwBdZf
         bJhB0gZayYJ2JRPY3MwB2WugWmnBARW7+wzAcw6mu2DcUb8vKxgIbDKJ/TLKD8fO6olK
         6WVcafQwEEhiXqqbkAEXGsxrwuMcpDCc8Rgmsp2VLzj5jlDedeHyL+U4+g2rzKEVG6PL
         vyCg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/QnskswU/JOTSabm7sEJVu8Vd4URzOx3EMoCCy9t1RedPW7LzkLZxaJvLUjxYT3aOf2O9Nv6dvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbQ6CsTuHrUNewYAvxwvWA/qPMxYecvlpIZMIIcFx0/SNKkxc
	51j2hR/ytAw2c4dbdFv/YQeXiDEE2iMOquDuMEJrETRJrJtWeTRZwpzIHzAf6fI=
X-Google-Smtp-Source: AGHT+IFinPVZrq/hLk/0lgYBm9HvM0TRhKieSiVYy09rroN9+LJLpX1N0tWlZzOj1cxmi5mGxUMnJg==
X-Received: by 2002:ac2:5a41:0:b0:53d:a0cf:8101 with SMTP id 2adb3069b0e04-53da0cf81demr687896e87.50.1731491164199;
        Wed, 13 Nov 2024 01:46:04 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54673a8sm18486025e9.0.2024.11.13.01.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 01:46:03 -0800 (PST)
Message-ID: <432f6a9d-3fa5-44c2-9e6e-b66bf57e71f7@linaro.org>
Date: Wed, 13 Nov 2024 09:46:01 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] mtd: spinand: winbond: Add comment about naming
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
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
 <20241025161501.485684-24-miquel.raynal@bootlin.com>
 <71d0cf83-6866-46be-b76f-291a8a6a1346@linaro.org>
Content-Language: en-US
In-Reply-To: <71d0cf83-6866-46be-b76f-291a8a6a1346@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/24 2:38 PM, Tudor Ambarus wrote:
> 
> 
> On 10/25/24 5:15 PM, Miquel Raynal wrote:
>> Make the link between the core macros and the datasheet.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/mtd/nand/spi/winbond.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
>> index 686e872fe0ff..9e2562805d23 100644
>> --- a/drivers/mtd/nand/spi/winbond.c
>> +++ b/drivers/mtd/nand/spi/winbond.c
>> @@ -18,6 +18,11 @@
>>  
>>  #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
>>  
>> +/*
>> + * "X2" in the core is equivalent to "dual output" in the datasheets,
>> + * "X4" in the core is equivalent to "quad output" in the datasheets.
>> + */
> 
> doesn't help great for an outsider like me. Is quad referring to cmd,
> addr or data? Or maybe of all? I need to read the code anyway.

more straight forward would be to use the X-Y-Z terminology in the
comment, where X,Y and Z are the number of IO lines for cmd, address and
data.

>> +
>>  static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
>>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),

