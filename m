Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50C8393EAD
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhE1IYk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 04:24:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26658 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234905AbhE1IYj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 04:24:39 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14S8MGrN010780;
        Fri, 28 May 2021 10:22:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SC8NOG3k/WMH3/oxYElq4I18/iOVJMr+y1hZSlPxh+M=;
 b=uyWVP4X7Gi+YyCvJ2gJlz6DLBAjgmUWTiPX735isWGACciSdQi3nywuNMYtn9eA+H7GF
 KLmap4uD03uYJNbpF7X59L7G07eRBbNLzt46jQPujg6Yhj7ocHFP12ReO3/mInsrsTo6
 IpMShFWtHUBSltkqmxanq05CQAArQ3x9A3MWzvh3Vw0et3ZjRiob4jhMv/59mwhMw116
 ugl/cxnpr1Bb+OQb4KZnTc2hUfDektzDT8cJ3VIRhsUE8ao8CQyx7OQ2chBCXKP75Jgv
 yqDGnRlcoG9bo0nzwIhy4RTrLvJoS0rWJXF8GU/uskwsJhZa2K4S4X9qjWDTKpUtbIn8 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38t7k3eps8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 10:22:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3E8810002A;
        Fri, 28 May 2021 10:22:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B68E621CA64;
        Fri, 28 May 2021 10:22:52 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May
 2021 10:22:51 +0200
Subject: Re: [PATCH v3 3/3] mtd: spinand: add SPI-NAND MTD resume handler
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        Pratyush Yadav <p.yadav@ti.com>
References: <20210527161252.16620-1-patrice.chotard@foss.st.com>
 <20210527161252.16620-4-patrice.chotard@foss.st.com>
 <20210527182317.38d5edc6@xps13>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <1ed72554-311d-5f6f-a108-e29138166dc0@foss.st.com>
Date:   Fri, 28 May 2021 10:22:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210527182317.38d5edc6@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Miquel

On 5/27/21 6:23 PM, Miquel Raynal wrote:
> Hi Patrice,
> 
> + Pratyush
> 
> <patrice.chotard@foss.st.com> wrote on Thu, 27 May 2021 18:12:52 +0200:
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
> 
> Sorry for not being clear, but I think what Pratyush meant was that
> you could create a helper doing all the common initializations between
> spinand_init() and spinand_resume() and call it from these places to
> avoid code duplication. His comment somehow outclassed mine as I only
> focused on the unlock part (which I think is clearer anyway, please keep
> it like that).
> 

My bad too, i read too quickly Pratyush's asnwer.
I am preparing a v4.

Thanks
Patrice


>> +
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
> 
> Thanks,
> Miquèl
> 
