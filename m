Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078CB3F2B7E
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 13:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbhHTLqn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 07:46:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57842 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhHTLqn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 07:46:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KBjio6048179;
        Fri, 20 Aug 2021 06:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629459944;
        bh=MpYon/18OVO6FRdF3uL/WYr8dvUTShbFfyCbaQQ5h6o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nBeucUyBDfI2f0UWfwHaKB9y+Yn9kmyaNUYW8q/UajkI5kWk0I4PMtu4PBrdX2veK
         nVFrMGJ5nLPRlVPwPjH/4VH6ZSBU2VCJkZNZcsNrftERalTBxXgoiGWhQiojR6tiDc
         SFOR1Yl2kYKGhI7JFmpJ7yqjhjDY4pXxxM3seqvs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KBjiFO122562
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 06:45:44 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 06:45:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 06:45:44 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KBjdEM071957;
        Fri, 20 Aug 2021 06:45:40 -0500
Subject: Re: [PATCH 12/13] mtd: spinand: Perform Power-on-Reset when
 runtime_pm suspend is issued
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-13-a-nandan@ti.com> <20210806211231.5c569939@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <2437d7b9-2a01-28c7-9a81-f38c35f37964@ti.com>
Date:   Fri, 20 Aug 2021 17:15:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806211231.5c569939@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 07/08/21 12:42 am, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:37
> +0000:
> 
>> A soft reset using FFh command doesn't erase the flash's configuration
>> and doesn't reset the SPI IO mode also. This can result in the flash
>> being in a different SPI IO mode, e.g. Octal DTR, when resuming from
>> sleep. This would render the flash in an unusable state.
> 
>                could put the falsh in?
> 

Okay, will make it clearer.
Basically, we don't want the flash to be in an ambiguous state. It might 
or might not have undergone a power off during the suspend state. So, 
the spinand core wouldn't know if the flash is still in Octal DTR mode 
or not. If it is still in Octal DTR mode, then none of the SPI 
instruction during mtd_resume() would work. So this is an ambiguous 
situation for driver. To avoid this, perform a PoR reset before suspending.

>> Perform a Power-on-Reset (PoR), if available in the flash, when
>> suspending the device by runtime_pm. This would set the flash to clean
> 
> I think runtime_pm is something else.
> 

Yeah, will make it clearer.

>> state for reinitialization during resume and would also ensure that it
>> is in standard SPI IO mode (1S-1S-1S) before the resume begins.
> 
> Please add a comment about this to explain why we don't do this reset
> at resume time.
> 

Yes sure!

>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   drivers/mtd/nand/spi/core.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 608f4eb85b0a..6fb3aa6af540 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1329,6 +1329,21 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
>>   	spinand_ecc_enable(spinand, false);
>>   }
>>   
>> +static int spinand_mtd_suspend(struct mtd_info *mtd)
>> +{
>> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
>> +	int ret;
>> +
>> +	if (!(spinand->flags & SPINAND_HAS_POR_CMD_BIT))
>> +		return 0;
>> +
>> +	ret = spinand_power_on_rst_op(spinand);
>> +	if (ret)
>> +		dev_err(&spinand->spimem->spi->dev, "suspend() failed\n");
>> +
>> +	return ret;
>> +}
>> +
>>   static int spinand_init(struct spinand_device *spinand)
>>   {
>>   	struct device *dev = &spinand->spimem->spi->dev;
>> @@ -1401,6 +1416,7 @@ static int spinand_init(struct spinand_device *spinand)
>>   	mtd->_erase = spinand_mtd_erase;
>>   	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
>>   	mtd->_resume = spinand_mtd_resume;
>> +	mtd->_suspend = spinand_mtd_suspend;
>>   
>>   	if (nand->ecc.engine) {
>>   		ret = mtd_ooblayout_count_freebytes(mtd);
> 
> 
> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

Thanks,
Apurva Nandan
