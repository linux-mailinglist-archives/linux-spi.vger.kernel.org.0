Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667F23F2A28
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhHTKgY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 06:36:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57274 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbhHTKgX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 06:36:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KAZX6w104323;
        Fri, 20 Aug 2021 05:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629455733;
        bh=kDWvlbjEYm+ZPP7kxDBAMIyz5QxNzRAE46pJTRwzxAs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HMlE6qvQFDOCM27LSlRTWFn7N2sfgD69kACQ2vWG1jQcxgg1t2reyADYQ7lN0QBHm
         QdWoQX1E8jNkH8kQXMhKed4Qe2cBM/EY6yQEZ5aEgNAkirRKPLZzf583vKOgDZKyyC
         oELIBRjThei7qH/OfuNeJXh1Vg/OmEO0Zqm7tmGM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KAZXHp007024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 05:35:33 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 05:35:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 05:35:32 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KAZSkE049156;
        Fri, 20 Aug 2021 05:35:29 -0500
Subject: Re: [PATCH 06/13] mtd: spinand: Add macros for Octal DTR page read
 and write operations
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-7-a-nandan@ti.com> <20210806205424.51511388@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <88915cc5-a2b7-4971-f9a1-a98bd944d5e7@ti.com>
Date:   Fri, 20 Aug 2021 16:05:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806205424.51511388@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquèl,

On 07/08/21 12:24 am, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:31
> +0000:
> 
>> Define new PAGE_READ_FROM_CACHE and PROG_LOAD op templates for Octal
>> DTR SPI mode. These templates would used in op_variants and
> 
>                                  will be
> 

Yeah, ok!

>> op_templates for defining Octal DTR read from cache and write to
>> cache operations.
>>
>> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   include/linux/mtd/spinand.h | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index ebb19b2cec84..35816b8cfe81 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -122,6 +122,12 @@
>>   		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
>>   		   SPI_MEM_OP_DATA_IN(len, buf, 4))
>>   
>> +#define SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(addr, ndummy, buf, len) \
>> +	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, 0x9d9d, 8),			\
>> +		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
>> +		   SPI_MEM_OP_DUMMY_DTR(ndummy, 8),			\
>> +		   SPI_MEM_OP_DATA_IN_DTR(len, buf, 8))
>> +
>>   #define SPINAND_PROG_EXEC_OP(addr)					\
>>   	SPI_MEM_OP(SPI_MEM_OP_CMD(0x10, 1),				\
>>   		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>> @@ -140,6 +146,12 @@
>>   		   SPI_MEM_OP_NO_DUMMY,					\
>>   		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
>>   
>> +#define SPINAND_PROG_LOAD_OCTALIO_DTR(reset, addr, buf, len)		\
>> +	SPI_MEM_OP(SPI_MEM_OP_CMD_DTR(2, reset ? 0x0202 : 0x8484, 8),	\
>> +		   SPI_MEM_OP_ADDR_DTR(2, addr, 8),			\
>> +		   SPI_MEM_OP_NO_DUMMY,					\
>> +		   SPI_MEM_OP_DATA_OUT_DTR(len, buf, 8))
>> +
>>   #define SPINAND_PROTO_BUSWIDTH_MASK	GENMASK(6, 0)
>>   #define SPINAND_PROTO_DTR_BIT		BIT(7)
>>   
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
