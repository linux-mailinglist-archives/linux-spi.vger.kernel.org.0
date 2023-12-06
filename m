Return-Path: <linux-spi+bounces-160-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD298072BB
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E9B1C20DF4
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B134CDE;
	Wed,  6 Dec 2023 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGvVur4r"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6FBD4D
	for <linux-spi@vger.kernel.org>; Wed,  6 Dec 2023 06:44:00 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso5893859a12.2
        for <linux-spi@vger.kernel.org>; Wed, 06 Dec 2023 06:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701873839; x=1702478639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/sUNB5ZgX1IJ9770bfc42rc11+iIaUcvTzWeH8l1S8=;
        b=vGvVur4r9oz4kLtWFKhmAyZhH+/d0IpjaC/ioKvsnKpC2Rv9wyPoIclSTqA3uOeEO+
         sNPBIFzf7CG//QMVUuf+fjaDQLxP5R8umXWN5JJLgA0sSZSVKkAlBhcLtFw3s1bfSsW6
         ZX3cOL0tXCpwPc6pTYqyhrYYsHkegDNH7rO0RUwLZ0CdQsBpsgjnbpXv1p20bLBOhehG
         KkeKgdVuRW6l7iyRheNjKV9df9lbok5JHqsY8h1a7RVd+Iw803VUisssTNS+t66pnK+3
         CPjs8nvu1w80J1DUUbS447RlJeI4EN7LDZyfrrQqwTJ8rC/ecX8HldyKXTLua+Tx8wrA
         99SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873839; x=1702478639;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/sUNB5ZgX1IJ9770bfc42rc11+iIaUcvTzWeH8l1S8=;
        b=WUNICuW5MMA1RwmRBlpCnyrXKS0BifMBOMQa20ikt5Y+Vu/3skxNFb+Exmzq12zaED
         WwEuYdbo1s7gw+In1Tqs2n34RFXOgtbSe4uNUZoiQ+IUqQ4saTkSqA4pb/eqXjSNV2nN
         Ce9mNbo+oPAMOOyWVFi4Br+fudS/qiNMHhqnnbyi1iGY0HINjOJoYY6rHOTR68ZkNvsY
         RRjK47pbCJSs6OW4ZPcXFZg16v1nf4jSqS2E2PlagN7AFKdd+K/xxfkQ7gaXyyVkzFjB
         mgtOitfqsxO68Oaj+S/xIvUve3EWDga27jrfsCjZeBP6JnrWzI6meFa3jXQR+M2FnUh9
         ieSw==
X-Gm-Message-State: AOJu0YyVBoDqi3uB3EJgFC8zlL0S38j1K1G3fDcadYEnTTM+4MsWSve2
	mAxyVSQ8G2noEo75RZ0ngmrIrg==
X-Google-Smtp-Source: AGHT+IHDAvptVLTEL9dhcaG+Hbai6J369y6guW1ZLyEztJsP78iBp+Sc57pMqBtc7BIzBcb9a1OzXg==
X-Received: by 2002:a50:d0cc:0:b0:54c:4837:9a9c with SMTP id g12-20020a50d0cc000000b0054c48379a9cmr758869edf.67.1701873838794;
        Wed, 06 Dec 2023 06:43:58 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id bo24-20020a0564020b3800b0054cc22af09esm49861edb.46.2023.12.06.06.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:43:58 -0800 (PST)
Message-ID: <9f577482-30d9-4e1d-9469-812d323b18c6@linaro.org>
Date: Wed, 6 Dec 2023 14:43:56 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, broonie@kernel.org,
 pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, sbinding@opensource.cirrus.com, lee@kernel.org,
 james.schulman@cirrus.com, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael@walle.cc, linux-mtd@lists.infradead.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, michal.simek@amd.com,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, git@amd.com,
 amitrkcian2002@gmail.com
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
In-Reply-To: <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/6/23 14:30, Tudor Ambarus wrote:
> Hi, Amit,
> 
> On 11/25/23 09:21, Amit Kumar Mahapatra wrote:
>> Each flash that is connected in stacked mode should have a separate
>> parameter structure. So, the flash parameter member(*params) of the spi_nor
>> structure is changed to an array (*params[2]). The array is used to store
>> the parameters of each flash connected in stacked configuration.
>>
>> The current implementation assumes that a maximum of two flashes are
>> connected in stacked mode and both the flashes are of same make but can
>> differ in sizes. So, except the sizes all other flash parameters of both
>> the flashes are identical.
> 
> Do you plan to add support for different flashes in stacked mode? If
> not, wouldn't it be simpler to have just an array of flash sizes instead
> of duplicating the entire params struct?
> 
>>
>> SPI-NOR is not aware of the chip_select values, for any incoming request
>> SPI-NOR will decide the flash index with the help of individual flash size
>> and the configuration type (single/stacked). SPI-NOR will pass on the flash
>> index information to the SPI core & SPI driver by setting the appropriate
>> bit in nor->spimem->spi->cs_index_mask. For example, if nth bit of
>> nor->spimem->spi->cs_index_mask is set then the driver would
>> assert/de-assert spi->chip_slect[n].
>>
>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>> ---
>>  drivers/mtd/spi-nor/core.c  | 272 +++++++++++++++++++++++++++++-------
>>  drivers/mtd/spi-nor/core.h  |   4 +
>>  include/linux/mtd/spi-nor.h |  15 +-
>>  3 files changed, 240 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index 93ae69b7ff83..e990be7c7eb6 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
> 
> cut
> 
>> @@ -2905,7 +3007,10 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
>>  static int spi_nor_late_init_params(struct spi_nor *nor)
>>  {
>>  	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
>> -	int ret;
>> +	struct device_node *np = spi_nor_get_flash_node(nor);
>> +	u64 flash_size[SNOR_FLASH_CNT_MAX];
>> +	u32 idx = 0;
>> +	int rc, ret;
>>  
>>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>>  	    nor->manufacturer->fixups->late_init) {
>> @@ -2937,6 +3042,44 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
>>  	if (params->n_banks > 1)
>>  		params->bank_size = div64_u64(params->size, params->n_banks);
>>  
>> +	nor->num_flash = 0;
>> +
>> +	/*
>> +	 * The flashes that are connected in stacked mode should be of same make.
>> +	 * Except the flash size all other properties are identical for all the
>> +	 * flashes connected in stacked mode.
>> +	 * The flashes that are connected in parallel mode should be identical.
>> +	 */
>> +	while (idx < SNOR_FLASH_CNT_MAX) {
>> +		rc = of_property_read_u64_index(np, "stacked-memories", idx, &flash_size[idx]);

also, it's not clear to me why you read this property multiple times.
Have you sent a device tree patch somewhere? It will help me understand
what you're trying to achieve.

> 
> This is a little late in my opinion, as we don't have any sanity check
> on the flashes that are stacked on top of the first. We shall at least
> read and compare the ID for all.
> 
> Cheers,
> ta

