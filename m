Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1943B3F2A38
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbhHTKmD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 06:42:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57898 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbhHTKmD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 06:42:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KAfCEr105704;
        Fri, 20 Aug 2021 05:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629456072;
        bh=7MXaO4GKe/fPH6zc16itUHi0h/KHPxryWe1gFsakmI8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XfnMLdRCROtMcwxUefpXWNewRQIbwey1QekMuLbZH9zOoa3fcl7OgpB6+lzUK+l96
         OiEUx+jgi2nu5tbr/NXTnycRc5bYASkeJrCdr0xDMFAyKVt+aHKz3d3b9lN0Jdhu6y
         E+JJ/9mtoWvsvZtr1g4IaTVqghhJoskSFKC6W1gQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KAfCt8055052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 05:41:12 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 05:41:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 05:41:11 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KAf6Th096048;
        Fri, 20 Aug 2021 05:41:07 -0500
Subject: Re: [PATCH 07/13] mtd: spinand: Allow enabling Octal DTR mode in the
 core
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-8-a-nandan@ti.com> <20210806205845.03dd97c9@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <c3e52b84-7ffc-8e48-d0c7-f17fa0b71f6b@ti.com>
Date:   Fri, 20 Aug 2021 16:11:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806205845.03dd97c9@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquèl,

On 07/08/21 12:28 am, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:32
> +0000:
> 
>> Enable Octal DTR SPI mode, i.e. 8D-8D-8D mode, if the SPI NAND flash
>> device supports it. Mixed OSPI (1S-1S-8S & 1S-8S-8S), mixed DTR modes
>> (1S-1D-8D), etc. aren't supported yet.
>>
>> The method to switch to Octal DTR SPI mode may vary across
>> manufacturers. For example, for Winbond, it is enabled by writing
>> values to the volatile configuration register. So, let the
>> manufacturer's code have their own implementation for switching to
>> Octal DTR SPI mode. Mixed OSPI (1S-1S-8S & 1S-8S-8S), mixed DTR modes
>> (1S-1D-8D), etc. aren't supported yet.
> 
> You can drop the final sentence which is a repetition of the previous
> paragraph.
> 

Yes right!

>> Check for the SPI NAND device's support for Octal DTR mode using
>> spinand flags, and if the op_templates allow 8D-8D-8D, call
>                                           allows
> 
>> octal_dtr_enable() manufacturer op. If the SPI controller doesn't
>> supports these modes, the selected op_templates would prevent switching
> 
>                                                    will
> 
>> to the Octal DTR mode. And finally update the spinand reg_proto
>> if success.
> 
>    on
> 

Okay, will correct all!

>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   drivers/mtd/nand/spi/core.c | 46 +++++++++++++++++++++++++++++++++++++
>>   include/linux/mtd/spinand.h |  3 +++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 1e619b6d777f..19d8affac058 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -256,6 +256,48 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
>>   			       enable ? CFG_QUAD_ENABLE : 0);
>>   }
>>   
>> +static bool spinand_op_is_octal_dtr(const struct spi_mem_op *op)
>> +{
>> +	return  op->cmd.buswidth == 8 && op->cmd.dtr &&
>> +		op->addr.buswidth == 8 && op->addr.dtr &&
>> +		op->data.buswidth == 8 && op->data.dtr;
>> +}
>> +
>> +static int spinand_init_octal_dtr_enable(struct spinand_device *spinand)
>> +{
>> +	struct device *dev = &spinand->spimem->spi->dev;
>> +	int ret;
>> +
>> +	if (!(spinand->flags & SPINAND_HAS_OCTAL_DTR_BIT))
>> +		return 0;
>> +
>> +	if (!(spinand_op_is_octal_dtr(spinand->op_templates.read_cache) &&
>> +	      spinand_op_is_octal_dtr(spinand->op_templates.write_cache) &&
>> +	      spinand_op_is_octal_dtr(spinand->op_templates.update_cache)))
>> +		return 0;
>> +
>> +	if (!spinand->manufacturer->ops->octal_dtr_enable) {
>> +		dev_err(dev,
>> +			"Missing ->octal_dtr_enable(), unable to switch mode\n");
> 
> I don't think we want an error here. Perhaps a debug or info call, but
> no more.
> 

Agree!

>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = spinand->manufacturer->ops->octal_dtr_enable(spinand);
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"Failed to enable Octal DTR SPI mode (err = %d)\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	spinand->reg_proto = SPINAND_OCTAL_DTR;
>> +
>> +	dev_dbg(dev,
>> +		"%s SPI NAND switched to Octal DTR SPI (8D-8D-8D) mode\n",
>> +		spinand->manufacturer->name);
>> +	return 0;
>> +}
>> +
>>   static int spinand_ecc_enable(struct spinand_device *spinand,
>>   			      bool enable)
>>   {
>> @@ -1189,6 +1231,10 @@ static int spinand_init_flash(struct spinand_device *spinand)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = spinand_init_octal_dtr_enable(spinand);
>> +	if (ret)
>> +		return ret;
>> +
>>   	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
>>   	if (ret)
>>   		return ret;
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index 35816b8cfe81..daa2ac5c3110 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -271,6 +271,7 @@ struct spinand_devid {
>>    * @init: initialize a SPI NAND device
>>    * @adjust_op: modify the ops for any variation in their cmd, address, dummy or
>>    *	       data phase by the manufacturer
>> + * @octal_dtr_enable: switch the SPI NAND flash into Octal DTR SPI mode
>>    * @cleanup: cleanup a SPI NAND device
>>    *
>>    * Each SPI NAND manufacturer driver should implement this interface so that
>> @@ -280,6 +281,7 @@ struct spinand_manufacturer_ops {
>>   	int (*init)(struct spinand_device *spinand);
>>   	void (*adjust_op)(struct spi_mem_op *op,
>>   			  const enum spinand_proto reg_proto);
>> +	int (*octal_dtr_enable)(struct spinand_device *spinand);
>>   	void (*cleanup)(struct spinand_device *spinand);
>>   };
>>   
>> @@ -348,6 +350,7 @@ struct spinand_ecc_info {
>>   
>>   #define SPINAND_HAS_QE_BIT		BIT(0)
>>   #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
>> +#define SPINAND_HAS_OCTAL_DTR_BIT	BIT(2)
>>   
>>   /**
>>    * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
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
