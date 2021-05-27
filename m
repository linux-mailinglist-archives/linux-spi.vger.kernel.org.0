Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9821F39281E
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhE0HDn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 03:03:43 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:47169 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233092AbhE0HDn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 03:03:43 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14R6qG8u004364;
        Thu, 27 May 2021 09:01:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=m5LUVeVAx0H7+efdYUrqUWDIzqQfwVOfhaTcVb+GW5A=;
 b=ChTJS68yGPIcxkI0k67wVFxq00xNvLuS8K7qe1etRjlMXWmo2bBvZJubcW+JZRwJQ1e8
 5pglsZMtkeQYit0AJVLDoW0fcdlKRkj4erYa7Ne64IKNY1/szESr/sspaVFk/k6U+WCS
 5wJ5J48jIGynjdXiZ2/LlFAyY8Qhi5sYeSTY5pw42EC7FOXg3S4YpF0n/AgiasWp+jKn
 6to0oYcMhiEc1cntBw1eJM7+x7fiYUGTs/LQukcNJaL+nE7wSCi4HRmBlhFhUtyzKj7C
 58r6sF8Wcmv0FCEpedo26nYe4R+sj4fVvGEkBk8RL1+2DRUEx7UQX5qM4FnAx/PEUrv3 Rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38t0x91mr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 09:01:58 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C869610002A;
        Thu, 27 May 2021 09:01:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AE683212FC0;
        Thu, 27 May 2021 09:01:57 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 09:01:57 +0200
Subject: Re: mtd: spinand: add spi nand mtd resume handler
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210526153016.32653-1-patrice.chotard@foss.st.com>
 <20210526174224.2b8714fc@xps13>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <bbfc7b31-c49c-e52d-0ea6-20ec81317cac@foss.st.com>
Date:   Thu, 27 May 2021 09:01:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210526174224.2b8714fc@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_02:2021-05-26,2021-05-27 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel

On 5/26/21 5:42 PM, Miquel Raynal wrote:
> Hello,
> 
> <patrice.chotard@foss.st.com> wrote on Wed, 26 May 2021 17:30:16 +0200:
> 
>> From: Christophe Kerello <christophe.kerello@foss.st.com>
> 
> Would you mind to use "add SPI-NAND MTD resume handler" as title? (with
> upper case letters)

Ok

> 
>> After power up, all SPI NAND's blocks are locked. Only read operations
>> are allowed, write and erase operations are forbidden.
>> The SPI NAND framework unlocks all the blocks during its initialization.
>>
>> During a standby low power, the memory is powered down, losing its
>> configuration.
>> During the resume, the QSPI driver state is restored but the SPI NAND
>> framework does not reconfigured the memory.
>>
>> This patch adds spi nand mtd PM handlers for resume ops.
> 
> ditto             ^^^^^^^^^^^^

Ok

> 
>> SPI NAND resume op re-initializes SPI NAND flash to its probed state.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  drivers/mtd/nand/spi/core.c | 56 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 17f63f95f4a2..6abaf874eb3f 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1074,6 +1074,61 @@ static int spinand_detect(struct spinand_device *spinand)
>>  	return 0;
>>  }
>>  
>> +static void spinand_mtd_resume(struct mtd_info *mtd)
>> +{
>> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
>> +	struct nand_device *nand = mtd_to_nanddev(mtd);
>> +	struct device *dev = &spinand->spimem->spi->dev;
>> +	int ret, i;
>> +
>> +	ret = spinand_reset_op(spinand);
>> +	if (ret)
>> +		return;
>> +
>> +	ret = spinand_init_quad_enable(spinand);
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"Failed to initialize the quad part (err = %d)\n",
> 
> quad part? what about "Failed to resume the quad state" or something
> alike?

Agree, i will update this

> 
>> +			ret);
>> +		return;
>> +	}
>> +
>> +	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"Failed to updtae the OTP (err = %d)\n",
> 
> update

ok

> 
>> +			ret);
>> +		return;
>> +	}
>> +
>> +	ret = spinand_manufacturer_init(spinand);
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"Failed to initialize the SPI NAND chip (err = %d)\n",
>> +			ret);
>> +		return;
>> +	}
>> +
>> +	/* After power up, all blocks are locked, so unlock them here. */
>> +	for (i = 0; i < nand->memorg.ntargets; i++) {
>> +		ret = spinand_select_target(spinand, i);
>> +		if (ret) {
>> +			dev_err(dev,
>> +				"Failed to select the target (err = %d)\n",
>> +				ret);
>> +			return;
>> +		}
>> +
>> +		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
>> +		if (ret) {
>> +			dev_err(dev,
>> +				"Failed to unlock block (err = %d)\n",
>> +				ret);
>> +			return;
>> +		}
>> +	}
> 
> I bet this would deserve a helper as this is the exact same peace of
> code that is being run in spinnand_init()?

I will add a new function spinand_block_unlock(struct spinand_device *spinand)

> 
> At the very least I think that spinand_ecc_enable(spinand, false);
> should be called.
I will add it. 

> 
> Ideally, a resume operation should be provided by ECC engines, but that
> can be added later.
> 
>> +}
>> +
>>  static int spinand_init(struct spinand_device *spinand)
>>  {
>>  	struct device *dev = &spinand->spimem->spi->dev;
>> @@ -1167,6 +1222,7 @@ static int spinand_init(struct spinand_device *spinand)
>>  	mtd->_block_isreserved = spinand_mtd_block_isreserved;
>>  	mtd->_erase = spinand_mtd_erase;
>>  	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
>> +	mtd->_resume = spinand_mtd_resume;
>>  
>>  	if (nand->ecc.engine) {
>>  		ret = mtd_ooblayout_count_freebytes(mtd);
> 
> Thanks,
> Miquèl
> 
Thanks
Patrice
