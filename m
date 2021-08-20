Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA33F2B3C
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhHTLbC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 07:31:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38760 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbhHTLbB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 07:31:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KBUAVo121215;
        Fri, 20 Aug 2021 06:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629459010;
        bh=/eXZvOa4+OXxpc+o5CSitroN9r32lXsrnJlRUMJVfxM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s0XUHsXilO6SHm8ke9tNWJhQN0L2K2QxxjKvAylyhUBf6aMT53/ZnRbFXo7bijMsU
         Jdb+kHfSBlDj0wcROlkEKqIkSus+cGvEDjvNgj/EyyqAe/z0WIRPev1iCsLIEEVMZt
         SCGahDqgezxMG7n05gHuCG4FWHF3NxC1zHyku4cQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KBUAjs116271
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 06:30:10 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 06:30:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 06:30:10 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KBU5B0007043;
        Fri, 20 Aug 2021 06:30:06 -0500
Subject: Re: [PATCH 09/13] mtd: spinand: Add support for write volatile
 configuration register op
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-10-a-nandan@ti.com> <20210806210500.3ead1600@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <24b79a08-96fd-34eb-13d3-f707970aae95@ti.com>
Date:   Fri, 20 Aug 2021 17:00:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806210500.3ead1600@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquèl,

On 07/08/21 12:35 am, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:34
> +0000:
> 
>> Volatile configuration register are a different set of configuration
>> registers, i.e. they differ from the status registers. A different
>> SPI instruction is required to write to these registers. Any changes
>> to the Volatile Configuration Register get transferred directly to
>> the Internal Configuration Register and instantly reflect on the
>> device operation.
>>
>> In Winbond W35N01JW, these volatile configuration register must be
>> configured in order to switch to Octal DTR SPI mode.
>>
>> Add support for writing to volatile configuration registers using a
>> new WRITE_VCR_OP template.
>>
>> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   drivers/mtd/nand/spi/core.c    |  2 +-
>>   drivers/mtd/nand/spi/winbond.c | 28 ++++++++++++++++++++++++++++
>>   include/linux/mtd/spinand.h    |  1 +
>>   3 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 8711e887b795..f577e72da2c4 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -442,7 +442,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
>>   		engine_conf->status = status;
>>   }
>>   
>> -static int spinand_write_enable_op(struct spinand_device *spinand)
>> +int spinand_write_enable_op(struct spinand_device *spinand)
>>   {
>>   	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
>>   
>> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
>> index 76684428354e..a7052a9ca171 100644
>> --- a/drivers/mtd/nand/spi/winbond.c
>> +++ b/drivers/mtd/nand/spi/winbond.c
>> @@ -7,6 +7,7 @@
>>    *	Boris Brezillon <boris.brezillon@bootlin.com>
>>    */
>>   
>> +#include <linux/delay.h>
>>   #include <linux/device.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mtd/spinand.h>
>> @@ -114,6 +115,33 @@ static int winbond_spinand_init(struct spinand_device *spinand)
>>   	return 0;
>>   }
>>   
>> +static int winbond_write_vcr_op(struct spinand_device *spinand, u8 reg, u8 val)
> 
> Maybe a comment to tell people what vcr is?
> 

Okay sure!

>> +{
>> +	int ret;
>> +	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),
>> +					  SPI_MEM_OP_ADDR(3, reg, 1),
>> +					  SPI_MEM_OP_NO_DUMMY,
>> +					  SPI_MEM_OP_DATA_OUT(1, spinand->scratchbuf, 1));
>> +
>> +	*spinand->scratchbuf = val;
>> +
>> +	ret = spinand_write_enable_op(spinand);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = spi_mem_exec_op(spinand->spimem, &op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Write VCR operation doesn't set the busy bit in SR, so can't perform
>> +	 * a status poll. Minimum time of 50ns is needed to complete the write.
>> +	 * So, give thrice the minimum required delay.
> 
> Isn't there an official maximum time?
> 

No, there is only an official minimum time. No maximum time..

>> +	 */
>> +	ndelay(150);
>> +	return 0;
>> +}
>> +
>>   static const struct spinand_manufacturer_ops winbond_spinand_manuf_ops = {
>>   	.init = winbond_spinand_init,
>>   };
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index daa2ac5c3110..21a4e5adcd59 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -560,5 +560,6 @@ int spinand_match_and_init(struct spinand_device *spinand,
>>   
>>   int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
>>   int spinand_select_target(struct spinand_device *spinand, unsigned int target);
>> +int spinand_write_enable_op(struct spinand_device *spinand);
>>   
>>   #endif /* __LINUX_MTD_SPINAND_H */
> 
> 
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
