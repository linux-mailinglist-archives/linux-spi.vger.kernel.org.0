Return-Path: <linux-spi+bounces-197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1AA80BFE9
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 04:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144761C20319
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 03:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91481640D;
	Mon, 11 Dec 2023 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vShUqo+B"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F12F2
	for <linux-spi@vger.kernel.org>; Sun, 10 Dec 2023 19:33:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c9116d05fso5617245a12.3
        for <linux-spi@vger.kernel.org>; Sun, 10 Dec 2023 19:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702265590; x=1702870390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqNPXHMTB4FcRiyJZx6FRt2mBNVGf6u2fS63Yrzy71c=;
        b=vShUqo+BUvwwsk4/uqTriausX9RUfaUguB058RDIReWGbyrI75PE69y0EyePCHVlah
         iDUyeZGGvnizXdqc7S7PVNubP9/LVV293deS2bN9qyfsNCzzXdd+Ffn0e/Oyl1MCaZZ/
         UZJoixLzP3za4D9GSYN50MEuCP6GlXtYdvGVp+HHqH1520pw7I9J/+i6RGM76hFcclM3
         IA9NLdHf21jZpKoKWtW1Ur/qH5tjIX60CdgUKirB0b5TF16vQ3daOfYzEADq26AMrXHT
         8kuIlPDK+C8UTujGG/kXjr/pfqte4Mj3g8g1nOBYvHIWSpdKlGkWbijX06EEY5/nRl9w
         KFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702265590; x=1702870390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqNPXHMTB4FcRiyJZx6FRt2mBNVGf6u2fS63Yrzy71c=;
        b=FmWpYtS34UKVefRB6WIXj3IzfkvIOgTAq62bMg0yDDU7dIFhl9QZMn8q5EZiiSMOds
         jT0ulh5wDeCremoRt428QIigcS3pwHyX8T5qdmNYBRSZRm8uxMA279oLN4ztfDNsukUX
         cGvdSRm4Fam/Z4okNgHtzLTJ9ZDK2JMEv337B3m5LzqTrhaWZ8yJlT4KJg4nKKwLEo0p
         3CEkRPKgVjBPLdRIyIhfC4cijzO+U3v04u9Naqkq1/NHobcZ3QlmLX6g9NHYskw2NGw4
         QFZL1MzXM02a2H4Y8LeSsBuN8BRdADOMKuk0nITsdTPOHQA+t4wbdUFOTMwq6lJEN9JF
         4zBQ==
X-Gm-Message-State: AOJu0YyYHiTczGI+iPwwVCwIcLZSrwnZCnH1pLPwDvqlvWgbzFMTva3x
	zUzFig47bQtnnoYEu2KCY3OLVNAUNRk6HbhirVw=
X-Google-Smtp-Source: AGHT+IF8Dlajrv6pbvu0jejDFv94gGz6TWGl172LjPCSXoBDXsO+7DBqbrZGe8N1+N5g0QfMuU1TPg==
X-Received: by 2002:a05:6402:903:b0:54c:79cc:dad1 with SMTP id g3-20020a056402090300b0054c79ccdad1mr1226451edz.54.1702265590308;
        Sun, 10 Dec 2023 19:33:10 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id dk11-20020a0564021d8b00b0054c8415f834sm3211782edb.34.2023.12.10.19.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 19:33:09 -0800 (PST)
Message-ID: <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
Date: Mon, 11 Dec 2023 03:33:06 +0000
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
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael@walle.cc" <michael@walle.cc>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/8/23 17:05, Mahapatra, Amit Kumar wrote:
> Hello Tudor,

Hi!

> 
>> -----Original Message-----
>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Sent: Wednesday, December 6, 2023 8:00 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; pratyush@kernel.org; miquel.raynal@bootlin.com;
>> richard@nod.at; vigneshr@ti.com; sbinding@opensource.cirrus.com;
>> lee@kernel.org; james.schulman@cirrus.com; david.rhodes@cirrus.com;
>> rf@opensource.cirrus.com; perex@perex.cz; tiwai@suse.com
>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> michael@walle.cc; linux-mtd@lists.infradead.org;
>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>; linux-
>> arm-kernel@lists.infradead.org; alsa-devel@alsa-project.org;
>> patches@opensource.cirrus.com; linux-sound@vger.kernel.org; git (AMD-
>> Xilinx) <git@amd.com>; amitrkcian2002@gmail.com
>> Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support
>> in spi-nor
>>
>> Hi, Amit,
>>
>> On 11/25/23 09:21, Amit Kumar Mahapatra wrote:
>>> Each flash that is connected in stacked mode should have a separate
>>> parameter structure. So, the flash parameter member(*params) of the
>>> spi_nor structure is changed to an array (*params[2]). The array is
>>> used to store the parameters of each flash connected in stacked
>> configuration.
>>>
>>> The current implementation assumes that a maximum of two flashes are
>>> connected in stacked mode and both the flashes are of same make but
>>> can differ in sizes. So, except the sizes all other flash parameters
>>> of both the flashes are identical.
>>
>> Do you plan to add support for different flashes in stacked mode? If not,
> 
> No, according to the current implementation, in stacked mode, both flashes 
> must be of the same make.
> 
>> wouldn't it be simpler to have just an array of flash sizes instead of
>> duplicating the entire params struct?
> 
> Yes, that is accurate. In alignment with our current stacked support use case we 
> can have an array of flash sizes instead.
> The primary purpose of having an array of params struct was to facilitate 
> potential future extensions, allowing the addition of stacked support for 
> different flashes
> 

right. Don't do this change yet, let's decide on the overall
architecture first.

>>
>>>
>>> SPI-NOR is not aware of the chip_select values, for any incoming
>>> request SPI-NOR will decide the flash index with the help of
>>> individual flash size and the configuration type (single/stacked).
>>> SPI-NOR will pass on the flash index information to the SPI core & SPI
>>> driver by setting the appropriate bit in
>>> nor->spimem->spi->cs_index_mask. For example, if nth bit of
>>> nor->spimem->spi->cs_index_mask is set then the driver would
>>> assert/de-assert spi->chip_slect[n].
>>>
>>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>>> ---
>>>  drivers/mtd/spi-nor/core.c  | 272 +++++++++++++++++++++++++++++-------
>>>  drivers/mtd/spi-nor/core.h  |   4 +
>>>  include/linux/mtd/spi-nor.h |  15 +-
>>>  3 files changed, 240 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 93ae69b7ff83..e990be7c7eb6 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>
>> cut
>>
>>> @@ -2905,7 +3007,10 @@ static void spi_nor_init_fixup_flags(struct
>>> spi_nor *nor)  static int spi_nor_late_init_params(struct spi_nor
>>> *nor)  {
>>>  	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor,
>> 0);
>>> -	int ret;
>>> +	struct device_node *np = spi_nor_get_flash_node(nor);
>>> +	u64 flash_size[SNOR_FLASH_CNT_MAX];
>>> +	u32 idx = 0;
>>> +	int rc, ret;
>>>
>>>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>>>  	    nor->manufacturer->fixups->late_init) { @@ -2937,6 +3042,44 @@
>>> static int spi_nor_late_init_params(struct spi_nor *nor)
>>>  	if (params->n_banks > 1)
>>>  		params->bank_size = div64_u64(params->size, params-
>>> n_banks);
>>>
>>> +	nor->num_flash = 0;
>>> +
>>> +	/*
>>> +	 * The flashes that are connected in stacked mode should be of same
>> make.
>>> +	 * Except the flash size all other properties are identical for all the
>>> +	 * flashes connected in stacked mode.
>>> +	 * The flashes that are connected in parallel mode should be identical.
>>> +	 */
>>> +	while (idx < SNOR_FLASH_CNT_MAX) {
>>> +		rc = of_property_read_u64_index(np, "stacked-memories",
>> idx,
>>> +&flash_size[idx]);
>>
>> This is a little late in my opinion, as we don't have any sanity check on the
>> flashes that are stacked on top of the first. We shall at least read and compare
>> the ID for all.
> 
> Alright, I will incorporate a sanity check for reading and comparing the 
> ID of the stacked flash. Subsequently, I believe this stacked logic 
> should be relocated to spi_nor_get_flash_info() where we identify the 
> first flash. Please share your thoughts on this. Additionally, do you 

I'm wondering whether we can add a layer on top of the flash type to
handle the stacked/parallel modes. This way everything will become flash
type independent. Would it be possible to stack 2 SPI NANDs? How about a
SPI NOR and a SPI NAND?

Is the datasheet of the controller public?

> anticipate that SPI-NOR should throw an error if the second or any 
> subsequent flash within the stacked connection is different? Or would you 
> prefer it to print a warning and operate in single mode (i.e., only the 
> first flash)?

Both options are fine, but I haven't yet decided on the overall
architecture.

Cheers,
ta

