Return-Path: <linux-spi+bounces-228-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC0780EF8E
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 16:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7078BB20D66
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD273164;
	Tue, 12 Dec 2023 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDGMWLCu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2FE3
	for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 07:02:37 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50d176eb382so5459370e87.2
        for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 07:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702393355; x=1702998155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJSaOj/O3sNlbMjuItblJHTlzvK1I9vT1qpvbGVa2tk=;
        b=vDGMWLCuntHfOed4j8aufB6g8jpv9cfKx3fD/Ibnx0naMC0Ttbeq94vA6ueDUqJ58c
         lBXr+c1OKzP2ZLWNtvihMLNVZcWTfAJzy4Mvvy0/lDMjH5TU4GHDyK7djnieZtb5pA+x
         xWJBHjiYA0zMWq8NaF8IH7PcXXIQ76u1FFujVCMWySlXJox8zNgucuwJxmfkHc5/Cr+p
         9guQAWnkoC34JHhLaQJIA+INd0DvuiF/LbV4CiJ0gCoWR4v7GuFUqWMEI4KiREx+5E6Z
         Cf51fAGfhEyFYF6jwmkhLnFvdorvYerIbfvpvrdn3QmCOagdvS+9aMnyy4kPLch+oey6
         00Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393355; x=1702998155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJSaOj/O3sNlbMjuItblJHTlzvK1I9vT1qpvbGVa2tk=;
        b=Fp5q1vGDKnG0OzuMwVPxeSbrHtdVIM4w4MNPboWjgCbM8oTdkBu4lNDwy8qn8O1KzJ
         qGevXiBGNQxPl7oTb3oQQ8rWiJ6UZ8BBJ8NjDFe4T8TJ45ga+ldj2kUEI2XVkes2MmHp
         3SntPagDfQ0u3/jbpMpFsL4bKNB+SQxhjZj5pc75CJQBtY8jfJJXkGLuoXFPznlC5AAB
         RKveUT0+zYBcW2yvlfg+x7E3ZLklOzfllao/Jcr2jUkLUMwQy6r4r2gyXMntwnlC6/CP
         mKAqsUDqVHdu0VJ5mI/7I3lEvO+NNwoxNMuyLGEjEsAHK5TzkjruQHPeg2hyvG7mORZX
         QTLQ==
X-Gm-Message-State: AOJu0Yyq2n/gCOp03akNeaourisIev7VvhJn2P4RHlhkIAxaYEPcqGYW
	/3gj8CRv1BkPwyK1EJYbx3OjGA==
X-Google-Smtp-Source: AGHT+IEQrTt5tPm83DHZ6HyQKpuEeSOXvUyNiD23wBW25lvvmAykVrQcO2UewxP10LZ8abWJJdsapw==
X-Received: by 2002:a05:6512:3a90:b0:50d:23e4:fe9c with SMTP id q16-20020a0565123a9000b0050d23e4fe9cmr3279122lfu.64.1702393354454;
        Tue, 12 Dec 2023 07:02:34 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906564a00b009fea232316bsm6343831ejr.193.2023.12.12.07.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:02:33 -0800 (PST)
Message-ID: <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
Date: Tue, 12 Dec 2023 15:02:31 +0000
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
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/11/23 13:37, Mahapatra, Amit Kumar wrote:

Hi!

cut

>>>>>>>  drivers/mtd/spi-nor/core.c  | 272
>>>>>>> +++++++++++++++++++++++++++++-----
>>>> --
>>>>>>>  drivers/mtd/spi-nor/core.h  |   4 +
>>>>>>>  include/linux/mtd/spi-nor.h |  15 +-
>>>>>>>  3 files changed, 240 insertions(+), 51 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mtd/spi-nor/core.c
>>>>>>> b/drivers/mtd/spi-nor/core.c index 93ae69b7ff83..e990be7c7eb6
>>>>>>> 100644
>>>>>>> --- a/drivers/mtd/spi-nor/core.c
>>>>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>>>>
>>>>>> cut
>>>>>>
>>>>>>> @@ -2905,7 +3007,10 @@ static void spi_nor_init_fixup_flags(struct
>>>>>>> spi_nor *nor)  static int spi_nor_late_init_params(struct spi_nor
>>>>>>> *nor)  {
>>>>>>>  	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor,
>>>>>> 0);
>>>>>>> -	int ret;
>>>>>>> +	struct device_node *np = spi_nor_get_flash_node(nor);
>>>>>>> +	u64 flash_size[SNOR_FLASH_CNT_MAX];
>>>>>>> +	u32 idx = 0;
>>>>>>> +	int rc, ret;
>>>>>>>
>>>>>>>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>>>>>>>  	    nor->manufacturer->fixups->late_init) { @@ -2937,6 +3042,44
>>>>>>> @@ static int spi_nor_late_init_params(struct spi_nor *nor)
>>>>>>>  	if (params->n_banks > 1)
>>>>>>>  		params->bank_size = div64_u64(params->size, params-
>>>> n_banks);
>>>>>>>
>>>>>>> +	nor->num_flash = 0;
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * The flashes that are connected in stacked mode should be
>> of
>>>>>>> +same
>>>>>> make.
>>>>>>> +	 * Except the flash size all other properties are identical for all
>> the
>>>>>>> +	 * flashes connected in stacked mode.
>>>>>>> +	 * The flashes that are connected in parallel mode should be
>> identical.
>>>>>>> +	 */
>>>>>>> +	while (idx < SNOR_FLASH_CNT_MAX) {
>>>>>>> +		rc = of_property_read_u64_index(np, "stacked-
>> memories",
>>>>>> idx,
>>>>>>> +&flash_size[idx]);
>>>>>>
>>>>>> This is a little late in my opinion, as we don't have any sanity
>>>>>> check on the flashes that are stacked on top of the first. We shall
>>>>>> at least read and compare the ID for all.
>>>>>
>>>>> Alright, I will incorporate a sanity check for reading and comparing
>>>>> the ID of the stacked flash. Subsequently, I believe this stacked
>>>>> logic should be relocated to spi_nor_get_flash_info() where we
>>>>> identify the first flash. Please share your thoughts on this.
>>>>> Additionally, do you
>>>>
>>>> I'm wondering whether we can add a layer on top of the flash type to
>>>> handle
>>>
>>> When you mention "on top," are you referring to incorporating it into
>>> the MTD layer? Initially, Miquel had submitted this patch to address
>>
>> I mean something above SPI MEM flashes, be it NOR, NANDs or whatever.
>> Instead of treating the stacked flashes as a monolithic device and treat in SPI
>> NOR some array of flashes, to have a layer above which probes the SPI MEM
>> flash driver for each stacked flash. In your case SPI NOR would be probed
>> twice, as you use 2 SPI NOR flashes.
>>
>>> stacked/parallel handling in the MTD layer.
>>> https://lore.kernel.org/linux-mtd/20200114191052.0a16d116@xps13/t/
>>> However, the Device Tree bindings were initially not accepted.
>>
>> Okay, thanks for the pointer. I'll take a look.

haven't yet read the thread from above, but I skimmed over the AMD
controller datasheet.

>>
>>> Following a series of discussions, the below bindings were eventually
>>> merged.
>>> https://lore.kernel.org/all/20220126112608.955728-4-miquel.raynal@boot
>>> lin.com/
>>
>> I saw, thanks.
>>
>>>
>>>> the stacked/parallel modes. This way everything will become flash
>>>> type independent. Would it be possible to stack 2 SPI NANDs? How
>>>> about a SPI NOR and a SPI NAND?
>>>>
>>>> Is the datasheet of the controller public?
>>>
>>> Yes,
>>> https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/Quad-SPI-Control
>>> ler
>>>
>>
>> Wonderful, I'll take a look. I see two clocks there. Does this mean that the
>> stacked flashes can be operated at different frequencies? Do you know if we
> 
> In stacked configuration, both flashes utilize a common clock (single 
> clock line). In a parallel setup, the flashes share the same clock but 
> have distinct clock lines. Please refer the diagrams in the sections 
> below for reference.
> https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/QSPI-Flash-Interface-Diagrams

Thanks! Can you share with us what flashes you used for testing in the
stacked and parallel configurations?

>> can combine a SPI NOR with a SPI NAND in stacked configuration?
> 
> No, Xilinx/AMD QSPI controllers doesn't support this configuration.
> 

2 SPI NANDs shall work with the AMD controller, right?

I skimmed over the QSPI controller datasheet and wondered why one would
get complicated with 2 Quad Flashes when we have Octal. But then I saw
that the same SoC can configure an Octal controller (the Octal and Quad
controllers seems mutual exclusive) and that the Octal one can operate 2
octal flashes in stacked mode :).

Cheers,
ta

