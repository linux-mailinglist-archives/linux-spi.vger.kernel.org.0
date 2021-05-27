Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B7D392FD1
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 15:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhE0Nfa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 09:35:30 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60644 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235947AbhE0Nfa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 09:35:30 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RDMF7M031752;
        Thu, 27 May 2021 15:33:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=VtvsLA+3cxgxLCtN2j8bvO+pXsJVt/NZPq5/BP8dplE=;
 b=D0q7wfaFVbcaTKmNUOYX+ud1s0Brk7EWwvVtRkGyt1dnOKLueVxxxH3X94FBMw5hNheS
 Q9fbi1iEIJBLVm1AAz0arK6mDghXxIlDJ954/iSyRYwCr+RkvBCglT3uAVcxyfDuNdkQ
 VkYxvg4E8h2K+bP+aRmZf8YWhDdTLXwh7SV0B2CfT4WOzFyHDpm1YfDnTggBF0c+Lql1
 naACADqL49VvIMiFjXu0YX5+A4Un3t0uipUS/Qy8fWRQ1Le3LoybpzohcE+75EHo4KEQ
 XJbMCT4yULs0oExKDMLshPuofiYy1R3QKGZqX339AnGY25dBFj6hEzX/2d3pDG56ktrT EA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38t0fr45qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 15:33:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C3FF910025D;
        Thu, 27 May 2021 15:11:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4AF322561A;
        Thu, 27 May 2021 15:11:29 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 15:11:28 +0200
Subject: Re: [PATCH v2] mtd: spinand: add SPI-NAND MTD resume handler
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
References: <20210527084959.1548-1-patrice.chotard@foss.st.com>
 <20210527105346.315cf125@xps13>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <4ec0aea5-0a37-8575-e76d-02388b62efd9@foss.st.com>
Date:   Thu, 27 May 2021 15:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210527105346.315cf125@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_06:2021-05-26,2021-05-27 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel

On 5/27/21 10:53 AM, Miquel Raynal wrote:
> Hi Patrice,
> 
> <patrice.chotard@foss.st.com> wrote on Thu, 27 May 2021 10:49:59 +0200:
> 
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
>> It also adds a new helper spinand_block_unlock() which is
>> called in spinand_init() and in spinand_mtd_resume().
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>> Changes in v2:
>>   - Add helper spinand_block_unlock().
>>   - Add spinand_ecc_enable() call.
>>   - Remove some dev_err().
>>   - Fix commit's title and message.
>>
>>  drivers/mtd/nand/spi/core.c | 62 +++++++++++++++++++++++++++++++------
>>  1 file changed, 53 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 17f63f95f4a2..f77aeff11f43 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -1074,6 +1074,55 @@ static int spinand_detect(struct spinand_device *spinand)
>>  	return 0;
>>  }
>>  
>> +static int spinand_block_unlock(struct spinand_device *spinand)
>> +{
>> +	struct device *dev = &spinand->spimem->spi->dev;
>> +	struct nand_device *nand = spinand_to_nand(spinand);
>> +	int ret = 0, i;
>> +
>> +	for (i = 0; i < nand->memorg.ntargets; i++) {
>> +		ret = spinand_select_target(spinand, i);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> Please insert this helper (and use it in the probe) in a separate
> patch, so that patch 2/2 only implements the _resume hook.

ok

> 
>> +
>> +static void spinand_mtd_resume(struct mtd_info *mtd)
>> +{
>> +	struct spinand_device *spinand = mtd_to_spinand(mtd);
>> +	struct nand_device *nand = mtd_to_nanddev(mtd);
>> +	struct device *dev = &spinand->spimem->spi->dev;
>> +	int ret;
>> +
>> +	ret = spinand_reset_op(spinand);
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
>>  static int spinand_init(struct spinand_device *spinand)
>>  {
>>  	struct device *dev = &spinand->spimem->spi->dev;
>> @@ -1137,15 +1186,9 @@ static int spinand_init(struct spinand_device *spinand)
>>  	}
>>  
>>  	/* After power up, all blocks are locked, so unlock them here. */
>> -	for (i = 0; i < nand->memorg.ntargets; i++) {
>> -		ret = spinand_select_target(spinand, i);
>> -		if (ret)
>> -			goto err_manuf_cleanup;
>> -
>> -		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
>> -		if (ret)
>> -			goto err_manuf_cleanup;
>> -	}
>> +	ret = spinand_block_unlock(spinand);
>> +	if ret)
> 
> I doubt this as even be build-tested :)

I just noticed that the MTD_SPI_NAND kernel flag was disable :-( 
that's explain why i didn't see this compilation issue .... sorry

Thanks

> 
>> +		goto err_manuf_cleanup;
>>  
>>  	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
>>  	if (ret)
>> @@ -1167,6 +1210,7 @@ static int spinand_init(struct spinand_device *spinand)
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
