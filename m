Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767BD3F3033
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbhHTPy2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 11:54:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59444 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbhHTPy1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 11:54:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KFrV6X013962;
        Fri, 20 Aug 2021 10:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629474811;
        bh=J/vo8B832cJn3Xv3wVaMKao5wbidMkr/qtLCpo6Q50Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QVYif6d1Mo5bFWQg+KYT7rSwP1/aIJ2Jvatme+F76Na7N6mD12Eht0N7jOh/2HEyl
         3/7iASVRwUng3O3G92L5zdPT3xz/yjvGiyBQ/c598VNu1mgxtSI2JcbH81r6UpX5Xw
         woAaV35e5r7vnHlUIBYL3hpndsHfGUU4qHFeDyx4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KFrVi7076792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 10:53:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 10:53:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 10:53:30 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KFrQdP081560;
        Fri, 20 Aug 2021 10:53:27 -0500
Subject: Re: [PATCH 08/13] mtd: spinand: Reject 8D-8D-8D op_templates if
 octal_dtr_enale() is missing in manufacturer_op
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-9-a-nandan@ti.com> <20210806210146.3358a85b@xps13>
 <4d428465-59d7-6771-8344-c5090add2a06@ti.com> <20210820141413.6c519255@xps13>
 <11d173f2-2011-d029-e905-a10fdd0f2b85@ti.com> <20210820163802.529482dd@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <68eb2817-1df8-464b-aef8-15e9c9adfead@ti.com>
Date:   Fri, 20 Aug 2021 21:23:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820163802.529482dd@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquèl,

On 20/08/21 8:08 pm, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 19:24:34
> +0530:
> 
>> Hi Miquèl,
>>
>> On 20/08/21 5:44 pm, Miquel Raynal wrote:
>>> Hi Apurva,
>>>
>>> Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 16:56:50
>>> +0530:
>>>    
>>>> On 07/08/21 12:31 am, Miquel Raynal wrote:
>>>>> Hi Apurva,
>>>>>
>>>>> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:33
>>>>> +0000:
>>>>>     >>>> The SPI NAND core doesn't know how to switch the flash to Octal DTR
>>>>>> mode (i.e. which operations to perform). If the manufacturer hasn't
>>>>>> implemented the octal_dtr_enable() manufacturer_op, the SPI NAND core
>>>>>> wouldn't be able to switch to 8D-8D-8D mode and will also not be able
>>>>>> to run in 1S-1S-1S mode due to already selected 8D-8D-8D read/write
>>>>>> cache op_templates.
>>>>>>
>>>>>> So, avoid choosing a Octal DTR SPI op_template for read_cache,
>>>>>> write_cache and update_cache operations, if the manufacturer_op
>>>>>> octal_dtr_enable() is missing.
>>>>>
>>>>> After looking at your previous commit I don't see why this patch would
>>>>> be needed. octal_dtr_enable() only updates the mode when it succeeds so
>>>>> I don't think this patch is really needed.
>>>>>     >>
>>>> I added it to prevent any errors happening dues to a missing implementation of octal_dtr_enable() from manufacturer driver side.
>>>> So, if the manufacturers skips the octal_dtr_enable() implementation, we want the spinand core to run in 1s-1s-1s mode.
>>>
>>> I still don't get the point: you fail the probe if the octal bit is
>>> enabled but the manufacturer did not implement octal_dtr_enable(), so
>>> how could we have issues? Maybe I am overlooking something though, but
>>> this seemed completely redundant to my eyes so far.
>>>    
>>
>> Okay, I feel this may be redundant. This is for the case when the manufacturer has added Octal DTR read/write/update cache variants but hasn't implemented the octal_dtr_enable() method.
>>
>> Without this patch, the probe would fail, if the manufacturer did not implement octal_dtr_enable(). But after using this patch, spinand can still use the chip in 1s-1s-1s mode in that case and just skip the Octal DTR op variants during the selection. And also the probe would succeed.
> 
> Unless I am overlooking something with this series applied
> (with or without this patch) the possibilities are:
> - no octal bit -> continue as before
> - octal bit and vendor callback -> uses octal mode
> - octal bit and no vendor callback -> will return an error from
> spinand_init_octal_dtr_enable() which will fail the probe (patch 7)
> 
> Anyway we have a choice:
> - Either we consider the tables describing chips as pure descriptions
>    and we can support these chips in mode 1-1-1 (will require changes in
>    your series as this is not what you support as far as I understand
>    the code)
> - Or we consider these tables as "what is currently supported" and in
>    this case we just fail if one adds the octal bit without any callback
>    implementation.
> 
> I think the latter is better for now. We can update this choice later
> if needed anyway.
> 

Yes, I fully agree with the latter. I will drop this patch in the v2. 
Thanks!

>>
>>>>
>>>> Read/write/update op variant selection happens in select_op_variant(), much before octal_dtr_enable(). So just check if there is a definition of octal_dtr_enable in manufacturer ops and then only use 8D op variants.
>>>>
>>>> Removing this wouldn't break anything in the current implementation.
>>>> Do you think we should drop this?
>>>>   
>>>>>>
>>>>>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>>>>>> ---
>>>>>>     drivers/mtd/nand/spi/core.c | 7 ++++++-
>>>>>>     1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>>>>>> index 19d8affac058..8711e887b795 100644
>>>>>> --- a/drivers/mtd/nand/spi/core.c
>>>>>> +++ b/drivers/mtd/nand/spi/core.c
>>>>>> @@ -1028,6 +1028,8 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
>>>>>>     		if (id[0] != manufacturer->id)
>>>>>>     			continue;
>>>>>>     >> +		spinand->manufacturer = manufacturer;
>>>>>> +
>>>>>>     		ret = spinand_match_and_init(spinand,
>>>>>>     					     manufacturer->chips,
>>>>>>     					     manufacturer->nchips,
>>>>>> @@ -1035,7 +1037,6 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
>>>>>>     		if (ret < 0)
>>>>>>     			continue;
>>>>>>     >> -		spinand->manufacturer = manufacturer;
>>>>>>     		return 0;
>>>>>>     	}
>>>>>>     	return -ENOTSUPP;
>>>>>> @@ -1097,6 +1098,10 @@ spinand_select_op_variant(struct spinand_device *spinand,
>>>>>>     		unsigned int nbytes;
>>>>>>     		int ret;
>>>>>>     >> +		if (spinand_op_is_octal_dtr(&op) &&
>>>>>> +		    !spinand->manufacturer->ops->octal_dtr_enable)
>>>>>> +			continue;
>>>>>> +
>>>>>>     		nbytes = nanddev_per_page_oobsize(nand) +
>>>>>>     			 nanddev_page_size(nand);
>>>>>>     > > Thanks,
>>>>> Miquèl
>>>>>
>>>>> ______________________________________________________
>>>>> Linux MTD discussion mailing list
>>>>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>>>>>     >>
>>>> Thanks,
>>>> Apurva Nandan
>>>
>>>
>>>
>>>
>>> Thanks,
>>> Miquèl
>>>    
>>
>> Thanks,
>> Apurva Nandan
> 
> Thanks,
> Miquèl
> 

Thanks,
Apurva Nandan
