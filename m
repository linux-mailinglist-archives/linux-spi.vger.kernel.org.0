Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A423F2D78
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbhHTNzf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 09:55:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55826 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbhHTNze (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 09:55:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KDseA2093976;
        Fri, 20 Aug 2021 08:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629467680;
        bh=ZTEkCbfVveh63g8MrqRX7KoRq3oOMeKH00MGady+1Fw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UJituv4+gXNZfvuhyeVDflXh9Es++8u2u/iAOP2v4gU8hcz7tRVUtjCFP284vErRZ
         CqEj1NUuymJZeMpc3+00jVdoJ8ZumNVvPHNQ5QV80OX+8lfz3HqjbyfNpNXuqrDHml
         gkPK8oYKNgmDfdRIUxj6/LcDcPAM+agDWtNmtkZs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KDse6A049821
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 08:54:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 08:54:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 08:54:39 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KDsZ50130304;
        Fri, 20 Aug 2021 08:54:36 -0500
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
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <11d173f2-2011-d029-e905-a10fdd0f2b85@ti.com>
Date:   Fri, 20 Aug 2021 19:24:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820141413.6c519255@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquèl,

On 20/08/21 5:44 pm, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Fri, 20 Aug 2021 16:56:50
> +0530:
> 
>> On 07/08/21 12:31 am, Miquel Raynal wrote:
>>> Hi Apurva,
>>>
>>> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:33
>>> +0000:
>>>    
>>>> The SPI NAND core doesn't know how to switch the flash to Octal DTR
>>>> mode (i.e. which operations to perform). If the manufacturer hasn't
>>>> implemented the octal_dtr_enable() manufacturer_op, the SPI NAND core
>>>> wouldn't be able to switch to 8D-8D-8D mode and will also not be able
>>>> to run in 1S-1S-1S mode due to already selected 8D-8D-8D read/write
>>>> cache op_templates.
>>>>
>>>> So, avoid choosing a Octal DTR SPI op_template for read_cache,
>>>> write_cache and update_cache operations, if the manufacturer_op
>>>> octal_dtr_enable() is missing.
>>>
>>> After looking at your previous commit I don't see why this patch would
>>> be needed. octal_dtr_enable() only updates the mode when it succeeds so
>>> I don't think this patch is really needed.
>>>    
>>
>> I added it to prevent any errors happening dues to a missing implementation of octal_dtr_enable() from manufacturer driver side.
>> So, if the manufacturers skips the octal_dtr_enable() implementation, we want the spinand core to run in 1s-1s-1s mode.
> 
> I still don't get the point: you fail the probe if the octal bit is
> enabled but the manufacturer did not implement octal_dtr_enable(), so
> how could we have issues? Maybe I am overlooking something though, but
> this seemed completely redundant to my eyes so far.
> 

Okay, I feel this may be redundant. This is for the case when the 
manufacturer has added Octal DTR read/write/update cache variants but 
hasn't implemented the octal_dtr_enable() method.

Without this patch, the probe would fail, if the manufacturer did not 
implement octal_dtr_enable(). But after using this patch, spinand can 
still use the chip in 1s-1s-1s mode in that case and just skip the Octal 
DTR op variants during the selection. And also the probe would succeed.

>>
>> Read/write/update op variant selection happens in select_op_variant(), much before octal_dtr_enable(). So just check if there is a definition of octal_dtr_enable in manufacturer ops and then only use 8D op variants.
>>
>> Removing this wouldn't break anything in the current implementation.
>> Do you think we should drop this?
>>
>>>>
>>>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>>>> ---
>>>>    drivers/mtd/nand/spi/core.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>>>> index 19d8affac058..8711e887b795 100644
>>>> --- a/drivers/mtd/nand/spi/core.c
>>>> +++ b/drivers/mtd/nand/spi/core.c
>>>> @@ -1028,6 +1028,8 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
>>>>    		if (id[0] != manufacturer->id)
>>>>    			continue;
>>>>    >> +		spinand->manufacturer = manufacturer;
>>>> +
>>>>    		ret = spinand_match_and_init(spinand,
>>>>    					     manufacturer->chips,
>>>>    					     manufacturer->nchips,
>>>> @@ -1035,7 +1037,6 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
>>>>    		if (ret < 0)
>>>>    			continue;
>>>>    >> -		spinand->manufacturer = manufacturer;
>>>>    		return 0;
>>>>    	}
>>>>    	return -ENOTSUPP;
>>>> @@ -1097,6 +1098,10 @@ spinand_select_op_variant(struct spinand_device *spinand,
>>>>    		unsigned int nbytes;
>>>>    		int ret;
>>>>    >> +		if (spinand_op_is_octal_dtr(&op) &&
>>>> +		    !spinand->manufacturer->ops->octal_dtr_enable)
>>>> +			continue;
>>>> +
>>>>    		nbytes = nanddev_per_page_oobsize(nand) +
>>>>    			 nanddev_page_size(nand);
>>>>    > > Thanks,
>>> Miquèl
>>>
>>> ______________________________________________________
>>> Linux MTD discussion mailing list
>>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>>>    
>>
>> Thanks,
>> Apurva Nandan
> 
> 
> 
> 
> Thanks,
> Miquèl
> 

Thanks,
Apurva Nandan
