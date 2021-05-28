Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C143942F3
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 14:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhE1Mxj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 08:53:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21656 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229552AbhE1Mxj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 08:53:39 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SCmRFI006751;
        Fri, 28 May 2021 14:51:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5bkRV64JeR7S4Wy1xYkqeAsCLKk3+CJqtFN26Joa1a0=;
 b=U573ueW0+UpmYW85v1qxLZoNjxN0NSUbzt1y+Wt9/XHpWam/AOXMlUWxIhDSaVWHNu9r
 hXb/+9y6ud9UZKZN7pKZaNIk1n77QJb5Tq5mGKQaRvov4wOyiWHCA/Kqr04hqy3RQ/m5
 1moj71CHuKFZBa7jXLnnNagw9L4aACAbkEuVwzRyXcRoi6AoFNLB4eAh73M6lNHOTZde
 KMN2qoEI+c2kw82H2XMgRz/z5XdcT2hOqI3c9d/mIpp1UT/IX7bW7uxpX2OzW5BDYZJa
 R5VyZjNBVh0vG+9gTNOWFOjqp1bmJib70Y1PbQ6oIEqlUsSPJOdctEi/vfo7U8/wKcjM pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38u03c0805-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 14:51:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F5DA10002A;
        Fri, 28 May 2021 14:51:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 47C622291AB;
        Fri, 28 May 2021 14:51:46 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May
 2021 14:51:45 +0200
Subject: Re: [PATCH v3 3/3] mtd: spinand: add SPI-NAND MTD resume handler
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210527161252.16620-1-patrice.chotard@foss.st.com>
 <20210527161252.16620-4-patrice.chotard@foss.st.com>
 <20210528120508.f6viglv3gkzgweqq@ti.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <3238725c-d7ff-c000-23d1-f18298e1556f@foss.st.com>
Date:   Fri, 28 May 2021 14:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210528120508.f6viglv3gkzgweqq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Pratyush

On 5/28/21 2:05 PM, Pratyush Yadav wrote:
> On 27/05/21 06:12PM, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> After power up, all SPI NAND's blocks are locked. Only read operations
>> are allowed, write and erase operations are forbidden.
>> The SPI NAND framework unlocks all the blocks during its initialization.
>>
>> During a standby low power, the memory is powered down, losing its
>> configuration.
>> During the resume, the QSPI driver state is restored but the SPI NAND
>> framework does not reconfigured the memory.
>>
>> This patch adds SPI-NAND MTD PM handlers for resume ops.
>> SPI NAND resume op re-initializes SPI NAND flash to its probed state.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>> Changes in v3:
>>   - Add spinand_read_cfg() call to repopulate cache
>>
>> Changes in v2:
>>   - Add helper spinand_block_unlock().
>>   - Add spinand_ecc_enable() call.
>>   - Remove some dev_err().
>>   - Fix commit's title and message.
>>
>>  drivers/mtd/nand/spi/core.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 1f699ad84f1b..e3fcbcf381c3 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1099,6 +1099,38 @@ static int spinand_block_unlock(struct spinand_device *spinand)
>>  	return ret;
>>  }
>>  
>> +static void spinand_mtd_resume(struct mtd_info *mtd)
>> +{
>> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
>> +	int ret;
>> +
>> +	ret = spinand_reset_op(spinand);
>> +	if (ret)
>> +		return;
>> +
>> +	ret = spinand_read_cfg(spinand);
>> +	if (ret)
>> +		return;
>> +
>> +	ret = spinand_init_quad_enable(spinand);
>> +	if (ret)
>> +		return;
>> +
>> +	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
>> +	if (ret)
>> +		return;
>> +
>> +	ret = spinand_manufacturer_init(spinand);
>> +	if (ret)
>> +		return;
>> +
>> +	ret = spinand_block_unlock(spinand);
>> +	if (ret)
>> +		return;
>> +
>> +	spinand_ecc_enable(spinand, false);
>> +}
>> +
> 
> I don't think you quite get what me and Miquel are suggesting.
> 
> The helper should call all these functions like read_cfg() 
> quad_enable(), etc. So it should look something like:

Yes, this series was sent too quickly on my side, and i misunderstood 
what you suggested, sorry for that.

> 
> int spinand_init_flash()
> {
> 	ret = spinand_read_cfg(spinand);
> 	if (ret)
> 		return;
> 

The new helper spinand_read_cfg() must not be called in spinand_init_flash()
but directly in spinand_resume().
This because spinand_read_cfg() only performs a REG_CFG read without doing the
memory allocation of spinand->cfg_cache.

In spinand_init(), spinand_init_cfg_cache() must be called as previously as it does spinand->cfg_cache
memory allocation and call the new helper spinand_read_cfg(). 
Then after, spinand_init_flash() can be called.

> 	ret = spinand_init_quad_enable(spinand);
> 	if (ret)
> 		return;
> 
> 	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
> 	if (ret)
> 		return;
> 
> 	ret = spinand_manufacturer_init(spinand);
> 	if (ret)
> 		return;
> 
> 	ret = spinand_block_unlock(spinand);
> 	if (ret)
> 		return;
> 
> 	spinand_ecc_enable(spinand, false);
> }
> 
> Then spinand_mtd_resume should look something like:
> 
> int spinand_mtd_resume()
> {
> 	ret = spinand_reset_op(spinand);
> 	if (ret)
> 		return;
> 
> 	return spinand_init_flash();
> }
> 
> And spinand_init() should look something like:
> 
> int spinand_init()
> {
> 	...
> 	spinand->oobbuf = ...
> 
> 	spinand_init_flash();
> 
> 	spinand_create_dirmaps();
> 
> 	...

As explained just above, spinand_init() will look like :

int spinand_init()
{
	...
	spinand->oobbuf = ...

	spinand_init_cfg_cache();     => perform cfg cache memory allocation and read the REG_CFG

	spinand_init_flash();

	spinand_create_dirmaps();

> }
> 
> 
>>  static int spinand_init(struct spinand_device *spinand)
>>  {
>>  	struct device *dev = &spinand->spimem->spi->dev;
>> @@ -1186,6 +1218,7 @@ static int spinand_init(struct spinand_device *spinand)
>>  	mtd->_block_isreserved = spinand_mtd_block_isreserved;
>>  	mtd->_erase = spinand_mtd_erase;
>>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
>> +	mtd->_resume = spinand_mtd_resume;
>>  
>>  	if (nand->ecc.engine) {
>>  		ret = mtd_ooblayout_count_freebytes(mtd);
>> -- 
>> 2.17.1
> 

Thanks
Patrice
