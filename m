Return-Path: <linux-spi+bounces-200-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60880C4C5
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FB81F20D44
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A39E21367;
	Mon, 11 Dec 2023 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImcHb/Hl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4199CE
	for <linux-spi@vger.kernel.org>; Mon, 11 Dec 2023 01:35:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5510479806dso1524840a12.0
        for <linux-spi@vger.kernel.org>; Mon, 11 Dec 2023 01:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702287325; x=1702892125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPBBuiUC0h6HJxl4BMSfR4W/EGNQD+gaR8NSJwfR2Gk=;
        b=ImcHb/HlIu0etaVt0ZSg62tLOrwGR6KkXdavkenBaFIp15ADgysOxSgy+qJVD0a4iM
         JJe1ZQFxml+FNi81ZCyftngWktqtlGxJIlOtPYUPb8UicWL0aZZw1kz/XLXpIsUAL5Qc
         tt4hbr6o1EQcyE0ogkHEUPQKFJNPYBTA4iF6El8gUyzQaml7AWIakwRdE+hGqeQlmEqb
         LF8AEzZQ90LeNtsQJWwfyoieH7AfYdRC2USM9Sr3lsvrj3fw1M8vDO/ebtO2tsjdi825
         GAi9MgUsNzs7ymkiKWFFaxzMaR/5pLirBStQlmGIBfT5LZjn7RbmEQqjyL/5EILXN72u
         9NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287325; x=1702892125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPBBuiUC0h6HJxl4BMSfR4W/EGNQD+gaR8NSJwfR2Gk=;
        b=vkX/pZkCrahpsCFo9Mgrek4qn8ah6Fl4fqkVQEvVihSn1mfOHdjBuU82Hj1QBHOoUo
         2MS0cYfl5xVKVKeokOS1j2FN44bQ6n1tV2042vTPGogO/QWVWt6Z8pfWXJvpq+tCqVlu
         cJEebSojCFZPTLCSsQo9bu/Xk+7bnXI4G1cUda+uToSrtKU+AJwWmA9tIzVmllNH8U9Y
         uO1lPmjztCcsmHdDfq6IPbx2LbsNBRbuSCgrtssuWQytjL6/OJndBxQj7DZ4TcJo1/s/
         R+KYevYjvIDqLReJ+96W8xax9d66fwv7xAQX9TPD0z26czjF3Gg4ekwEZLT3umdBB9bF
         lzTw==
X-Gm-Message-State: AOJu0YzH7pUKnNK3/kWjo7oP8E6R3n0/b4ihz9Zmkw0jMWxCgv6F+WWu
	4uqeAbJOe64m/9HhuAYf1LE4vw==
X-Google-Smtp-Source: AGHT+IFX69vaIMEbLW/TqLvsqwcZgbImckFRzF090TZyX4ErPch2iorzjHVHCi6wE4KnWzRGQkk4JQ==
X-Received: by 2002:a50:d4d7:0:b0:548:4774:e59c with SMTP id e23-20020a50d4d7000000b005484774e59cmr1528899edj.35.1702287325265;
        Mon, 11 Dec 2023 01:35:25 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id s2-20020a05640217c200b00551422c2ceasm418127edy.44.2023.12.11.01.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 01:35:24 -0800 (PST)
Message-ID: <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
Date: Mon, 11 Dec 2023 09:35:21 +0000
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
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/11/23 06:56, Mahapatra, Amit Kumar wrote:
> 
> 
>> -----Original Message-----
>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Sent: Monday, December 11, 2023 9:03 AM
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
>>
>>
>> On 12/8/23 17:05, Mahapatra, Amit Kumar wrote:
>>> Hello Tudor,
>>
>> Hi!
> 
> Hello Tudor,
> 

Hi!

>>
>>>
>>>> -----Original Message-----
>>>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>>>> Sent: Wednesday, December 6, 2023 8:00 PM
>>>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>>>> broonie@kernel.org; pratyush@kernel.org; miquel.raynal@bootlin.com;
>>>> richard@nod.at; vigneshr@ti.com; sbinding@opensource.cirrus.com;
>>>> lee@kernel.org; james.schulman@cirrus.com; david.rhodes@cirrus.com;
>>>> rf@opensource.cirrus.com; perex@perex.cz; tiwai@suse.com
>>>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> michael@walle.cc; linux-mtd@lists.infradead.org;
>>>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>>>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>;
>>>> linux- arm-kernel@lists.infradead.org; alsa-devel@alsa-project.org;
>>>> patches@opensource.cirrus.com; linux-sound@vger.kernel.org; git (AMD-
>>>> Xilinx) <git@amd.com>; amitrkcian2002@gmail.com
>>>> Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories
>>>> support in spi-nor
>>>>
>>>> Hi, Amit,
>>>>
>>>> On 11/25/23 09:21, Amit Kumar Mahapatra wrote:
>>>>> Each flash that is connected in stacked mode should have a separate
>>>>> parameter structure. So, the flash parameter member(*params) of the
>>>>> spi_nor structure is changed to an array (*params[2]). The array is
>>>>> used to store the parameters of each flash connected in stacked
>>>> configuration.
>>>>>
>>>>> The current implementation assumes that a maximum of two flashes are
>>>>> connected in stacked mode and both the flashes are of same make but
>>>>> can differ in sizes. So, except the sizes all other flash parameters
>>>>> of both the flashes are identical.
>>>>
>>>> Do you plan to add support for different flashes in stacked mode? If
>>>> not,
>>>
>>> No, according to the current implementation, in stacked mode, both
>>> flashes must be of the same make.
>>>
>>>> wouldn't it be simpler to have just an array of flash sizes instead
>>>> of duplicating the entire params struct?
>>>
>>> Yes, that is accurate. In alignment with our current stacked support
>>> use case we can have an array of flash sizes instead.
>>> The primary purpose of having an array of params struct was to
>>> facilitate potential future extensions, allowing the addition of
>>> stacked support for different flashes
>>>
>>
>> right. Don't do this change yet, let's decide on the overall architecture first.
> 
> Sure.
>>
>>>>
>>>>>
>>>>> SPI-NOR is not aware of the chip_select values, for any incoming
>>>>> request SPI-NOR will decide the flash index with the help of
>>>>> individual flash size and the configuration type (single/stacked).
>>>>> SPI-NOR will pass on the flash index information to the SPI core &
>>>>> SPI driver by setting the appropriate bit in
>>>>> nor->spimem->spi->cs_index_mask. For example, if nth bit of
>>>>> nor->spimem->spi->cs_index_mask is set then the driver would
>>>>> assert/de-assert spi->chip_slect[n].
>>>>>
>>>>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
>> mahapatra@amd.com>
>>>>> ---
>>>>>  drivers/mtd/spi-nor/core.c  | 272 +++++++++++++++++++++++++++++-----
>> --
>>>>>  drivers/mtd/spi-nor/core.h  |   4 +
>>>>>  include/linux/mtd/spi-nor.h |  15 +-
>>>>>  3 files changed, 240 insertions(+), 51 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>>> index 93ae69b7ff83..e990be7c7eb6 100644
>>>>> --- a/drivers/mtd/spi-nor/core.c
>>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>>
>>>> cut
>>>>
>>>>> @@ -2905,7 +3007,10 @@ static void spi_nor_init_fixup_flags(struct
>>>>> spi_nor *nor)  static int spi_nor_late_init_params(struct spi_nor
>>>>> *nor)  {
>>>>>  	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor,
>>>> 0);
>>>>> -	int ret;
>>>>> +	struct device_node *np = spi_nor_get_flash_node(nor);
>>>>> +	u64 flash_size[SNOR_FLASH_CNT_MAX];
>>>>> +	u32 idx = 0;
>>>>> +	int rc, ret;
>>>>>
>>>>>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>>>>>  	    nor->manufacturer->fixups->late_init) { @@ -2937,6 +3042,44 @@
>>>>> static int spi_nor_late_init_params(struct spi_nor *nor)
>>>>>  	if (params->n_banks > 1)
>>>>>  		params->bank_size = div64_u64(params->size, params-
>> n_banks);
>>>>>
>>>>> +	nor->num_flash = 0;
>>>>> +
>>>>> +	/*
>>>>> +	 * The flashes that are connected in stacked mode should be of
>>>>> +same
>>>> make.
>>>>> +	 * Except the flash size all other properties are identical for all the
>>>>> +	 * flashes connected in stacked mode.
>>>>> +	 * The flashes that are connected in parallel mode should be identical.
>>>>> +	 */
>>>>> +	while (idx < SNOR_FLASH_CNT_MAX) {
>>>>> +		rc = of_property_read_u64_index(np, "stacked-memories",
>>>> idx,
>>>>> +&flash_size[idx]);
>>>>
>>>> This is a little late in my opinion, as we don't have any sanity
>>>> check on the flashes that are stacked on top of the first. We shall
>>>> at least read and compare the ID for all.
>>>
>>> Alright, I will incorporate a sanity check for reading and comparing
>>> the ID of the stacked flash. Subsequently, I believe this stacked
>>> logic should be relocated to spi_nor_get_flash_info() where we
>>> identify the first flash. Please share your thoughts on this.
>>> Additionally, do you
>>
>> I'm wondering whether we can add a layer on top of the flash type to handle
> 
> When you mention "on top," are you referring to incorporating it into 
> the MTD layer? Initially, Miquel had submitted this patch to address 

I mean something above SPI MEM flashes, be it NOR, NANDs or whatever.
Instead of treating the stacked flashes as a monolithic device and treat
in SPI NOR some array of flashes, to have a layer above which probes the
SPI MEM flash driver for each stacked flash. In your case SPI NOR would
be probed twice, as you use 2 SPI NOR flashes.

> stacked/parallel handling in the MTD layer.
> https://lore.kernel.org/linux-mtd/20200114191052.0a16d116@xps13/t/
> However, the Device Tree bindings were initially not accepted. 

Okay, thanks for the pointer. I'll take a look.

> Following a series of discussions, the below bindings were 
> eventually merged.
> https://lore.kernel.org/all/20220126112608.955728-4-miquel.raynal@bootlin.com/

I saw, thanks.

> 
>> the stacked/parallel modes. This way everything will become flash type
>> independent. Would it be possible to stack 2 SPI NANDs? How about a SPI
>> NOR and a SPI NAND?
>>
>> Is the datasheet of the controller public?
> 
> Yes, https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/Quad-SPI-Controller
> 

Wonderful, I'll take a look. I see two clocks there. Does this mean that
the stacked flashes can be operated at different frequencies? Do you
know if we can combine a SPI NOR with a SPI NAND in stacked configuration?

I need to study this a bit. I'll try to involve Michael and Pratyush too.

Cheers,
ta

