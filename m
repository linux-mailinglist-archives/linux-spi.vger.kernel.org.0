Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660703F2A1E
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbhHTK2g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 06:28:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55238 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbhHTK2f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 06:28:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KARfjF101380;
        Fri, 20 Aug 2021 05:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629455261;
        bh=LFbDbUX2EaSwpbZwr8w88r0d5hrA4CmOyZDN3ofcqD4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sXTdtAjGEX8oHbDmZvRWhyJnom6E5959SlOtdb3NmYFbMF5iZupF5jpq4EHqzgTUw
         D4+VYaKaVooqWgFEbx1V54vtVAscY3bHJtzIwBB4U5wCYL+9krp7URFm3X+fr59KaW
         2kxA1qfCSytB1ln/L5lSFL/0ao/FNfiNYKsYRTug=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KARf8V126926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 05:27:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 05:27:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 05:27:41 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KARa1C072931;
        Fri, 20 Aug 2021 05:27:37 -0500
Subject: Re: [PATCH 04/13] mtd: spinand: Fix odd byte addr and data phase in
 read/write reg op and write VCR op for Octal DTR mode
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-5-a-nandan@ti.com> <20210806204334.5fedea42@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <a0decde4-c68e-9494-9ce5-97d60916f9ad@ti.com>
Date:   Fri, 20 Aug 2021 15:57:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806204334.5fedea42@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquèl,

On 07/08/21 12:13 am, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:29
> +0000:
> 
>> In Octal DTR SPI mode, 2 bytes of data gets transmitted over one clock
>> cycle, and half-cycle instruction phases aren't supported yet. So,
>> every DTR spi_mem_op needs to have even nbytes in all phases for
>> non-erratic behaviour from the SPI controller.
>>
>> The odd length cmd and dummy phases get handled by spimem_setup_op()
>> but the odd length address and data phases need to be handled according
>> to the use case. For example in Octal DTR mode, read register operation
>> has one byte long address and data phase. So it needs to extend it
>> by adding a suitable extra byte in addr and reading 2 bytes of data,
>> discarding the second byte.
>>
>> Handle address and data phases for Octal DTR mode in read/write
>> register and write volatile configuration register operations
>> by adding a suitable extra byte in the address and data phase.
>>
>> Create spimem_setup_reg_op() helper function to ease setting up
>> read/write register operations in other functions, e.g. wait().
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   drivers/mtd/nand/spi/core.c | 26 +++++++++++++++++++++-----
>>   1 file changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 2e59faecc8f5..a5334ad34f96 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -65,12 +65,27 @@ static void spinand_setup_op(const struct spinand_device *spinand,
>>   	}
>>   }
>>   
>> +static void spinand_setup_reg_op(const struct spinand_device *spinand,
>> +				 struct spi_mem_op *op)
> 
> Same remark about the naming. In fact I believe we could have this
> logic in _setup_op() (or whatever its name) and add a specific
> parameter for it?
> 

Okay, I will add a parameter in argument and include this logic in 
_setup_op().

>> +{
>> +	if (spinand->reg_proto == SPINAND_OCTAL_DTR) {
>> +		/*
>> +		 * Assigning same first and second byte will result in constant
>> +		 * bits on ths SPI bus between positive and negative clock edges
> 
>                             the
> 

Ok.

>> +		 */
>> +		op->addr.val = (op->addr.val << 8) | op->addr.val;
> 
> I am not sure to understand what you do here?
> 

In Octal DTR mode, 2 bytes of data are sent in a clock cycle. So, we 
need to append one extra byte when sending a single byte. This extra 
byte would be sent on the negative edge.

It will make sense to keep both the bytes same, as when it will be set 
on the SPI pins, the bits on the SPI IO ports will remain constant 
between the positive and negative edges (as 1 complete byte is set in 
one clock edge in MSB order). There are no restrictions by the 
manufacturers on this, the relevant address byte needs to be on positive 
edge and second byte on negative edge is don't care.

>> +		op->addr.nbytes = 2;
>> +		op->data.nbytes = 2;
>> +	}
> 
> Space
> 

Ok.

>> +	spinand_setup_op(spinand, op);
>> +}
>> +
>>   static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>>   {
>> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
>> -						      spinand->scratchbuf);
>> +	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg, spinand->scratchbuf);
> 
> You can do this, but in a different commit.
> 

Got it.

>>   	int ret;
>>   
>> +	spinand_setup_reg_op(spinand, &op);
>>   	ret = spi_mem_exec_op(spinand->spimem, &op);
>>   	if (ret)
>>   		return ret;
>> @@ -81,10 +96,10 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>>   
>>   static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
>>   {
>> -	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
>> -						      spinand->scratchbuf);
>> +	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg, spinand->scratchbuf);
> 
> Same here.
> 

Yes!

>>   
>> -	*spinand->scratchbuf = val;
>> +	spinand_setup_reg_op(spinand, &op);
>> +	memset(spinand->scratchbuf, val, op.data.nbytes);
>>   	return spi_mem_exec_op(spinand->spimem, &op);
>>   }
>>   
>> @@ -547,6 +562,7 @@ static int spinand_wait(struct spinand_device *spinand,
>>   	u8 status;
>>   	int ret;
>>   
>> +	spinand_setup_reg_op(spinand, &op);
>>   	ret = spi_mem_poll_status(spinand->spimem, &op, STATUS_BUSY, 0,
>>   				  initial_delay_us,
>>   				  poll_delay_us,
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
