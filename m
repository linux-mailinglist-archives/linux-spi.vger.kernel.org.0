Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165973F2B5D
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhHTLkD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 07:40:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40812 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbhHTLkD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Aug 2021 07:40:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17KBdCPq124127;
        Fri, 20 Aug 2021 06:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629459552;
        bh=m/r679Qxo83wv7NROTahTRMLa/GxSpkBSVD1uby0TpU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t+l0HARobLqU2525dAIPdN+gzwqLXKhIHETSGIX6qMHiTzM3F5OtdFA7i5ryrwUii
         MF6irva1ZMvwkEqJUs0ghu550R/T4M5ORRfz03KU7g+azOhMWQllrRxuK4CmGIc3yV
         7ZZSzUa/zgZbxfvI7wG5CxGDT0EWPPNV+VUEM+rU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17KBdCHN082957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 06:39:12 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 20
 Aug 2021 06:39:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 20 Aug 2021 06:39:12 -0500
Received: from [10.250.232.95] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17KBd7Za061904;
        Fri, 20 Aug 2021 06:39:08 -0500
Subject: Re: [PATCH 11/13] mtd: spinand: Add support for Power-on-Reset (PoR)
 instruction
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
 <20210713130538.646-12-a-nandan@ti.com> <20210806210840.65c06b67@xps13>
From:   Apurva Nandan <a-nandan@ti.com>
Message-ID: <403a2b26-fd95-31ab-8992-a6e6862249e6@ti.com>
Date:   Fri, 20 Aug 2021 17:09:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806210840.65c06b67@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquèl,

On 07/08/21 12:38 am, Miquel Raynal wrote:
> Hi Apurva,
> 
> Apurva Nandan <a-nandan@ti.com> wrote on Tue, 13 Jul 2021 13:05:36
> +0000:
> 
>> Manufacturers like Gigadevice and Winbond are adding Power-on-Reset
>> functionality in their SPI NAND flash chips. PoR instruction consists
>> of a 66h command followed by 99h command, and is different from the FFh
>> reset. The reset command FFh just clears the status only registers,
>> while the PoR command erases all the configurations written to the
>> flash and is equivalent to a power-down -> power-up cycle.
>>
>> Add support for the Power-on-Reset command for any flash that provides
>> this feature.
>>
>> Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf
>>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
> 
> [...]
> 				\
>> @@ -218,6 +230,8 @@ struct spinand_device;
>>    * reading/programming/erasing when the RESET occurs. Since we always
>>    * issue a RESET when the device is IDLE, 5us is selected for both initial
>>    * and poll delay.
>> + * Power on Reset can take max upto 500 us to complete, so sleep for 1000 us
> 
> s/max upto/up to/
> 

Okay!

>> + * to 1200 us safely.
> 
> I don't really get why, if the maximum is 500, then let's wait for
> 500us.
> 

Generally we keep some margin from the maximum time, no?

>>    */
>>   #define SPINAND_READ_INITIAL_DELAY_US	6
>>   #define SPINAND_READ_POLL_DELAY_US	5
>> @@ -227,6 +241,8 @@ struct spinand_device;
>>   #define SPINAND_WRITE_POLL_DELAY_US	15
>>   #define SPINAND_ERASE_INITIAL_DELAY_US	250
>>   #define SPINAND_ERASE_POLL_DELAY_US	50
>> +#define SPINAND_POR_MIN_DELAY_US	1000
>> +#define SPINAND_POR_MAX_DELAY_US	1200
>>   
>>   #define SPINAND_WAITRDY_TIMEOUT_MS	400
>>   
>> @@ -351,6 +367,7 @@ struct spinand_ecc_info {
>>   #define SPINAND_HAS_QE_BIT		BIT(0)
>>   #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
>>   #define SPINAND_HAS_OCTAL_DTR_BIT	BIT(2)
>> +#define SPINAND_HAS_POR_CMD_BIT		BIT(3)
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
