Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B2D38780B
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244942AbhERLvq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 07:51:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55148 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241753AbhERLvp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 07:51:45 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IBkjQf031794;
        Tue, 18 May 2021 13:50:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=DdKE7jcPLmE85L7BIvJpkrZObmvEJo2niKAbOooRnxo=;
 b=r2NGqWkTgccIRkM36eSnUH6IR+Doa3zxzRMFmvDqWXy58W9H3P/Zw24YMwmIfVJeVWrk
 7SdCgrOVo/6CJ4evAl4LYpnE9altycG5HgzX70tA+myXpNte9RAkknWsI/uk0EZw8HKa
 PbmwxbnRzpaBR6jeJC1bIYzLci/TSACl1WI5IlThtlLldNuDX6UdAEvTCHjpUi5fiWzr
 L18uV/et5cb05wttXHKTRzFIOaXmcFQhHq3YlP7gyQwXlOi/hnF2T6VXz+AEoe/7zWuP
 TMH79t1gGeIR3fNRcVzd/JJ8qOmZe1L5OXE2/jae2K00wKF4qS1T9mrsi3gZPYrdvC7R kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38km7pqc18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 13:50:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DFF6010002A;
        Tue, 18 May 2021 13:50:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C8ABD2237A4;
        Tue, 18 May 2021 13:50:14 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May
 2021 13:50:13 +0200
Subject: Re: [PATCH v3 2/3] mtd: spinand: use the spi-mem poll status APIs
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210518093951.23136-1-patrice.chotard@foss.st.com>
 <20210518093951.23136-3-patrice.chotard@foss.st.com>
 <20210518132850.1558e46b@collabora.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <84113017-8ba8-4de3-24d8-719c63f458fe@foss.st.com>
Date:   Tue, 18 May 2021 13:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518132850.1558e46b@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_04:2021-05-18,2021-05-18 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi 

On 5/18/21 1:28 PM, Boris Brezillon wrote:
> On Tue, 18 May 2021 11:39:50 +0200
> <patrice.chotard@foss.st.com> wrote:
> 
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Make use of spi-mem poll status APIs to let advanced controllers
>> optimize wait operations.
> 
> This should also fix the high CPU usage you were reporting for those
> that don't have a dedicated STATUS poll block logic, which is great!

I will update the commit message by indicating what you mention here.

> 
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>> Changes in v3:
>>   - Add initial_delay_us and polling_delay_us parameters to spinand_wait()
>>   - Add SPINAND_READ/WRITE/ERASE/RESET_INITIAL_DELAY_US and
>>     SPINAND_READ/WRITE/ERASE/RESET_POLL_DELAY_US defines.
>>
>> Changes in v2:
>>   - non-offload case is now managed by spi_mem_poll_status()
>>
>>  drivers/mtd/nand/spi/core.c | 45 ++++++++++++++++++++++++++-----------
>>  include/linux/mtd/spinand.h | 11 ++++++++-
>>  2 files changed, 42 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 17f63f95f4a2..ef2a692ab5b6 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -473,20 +473,26 @@ static int spinand_erase_op(struct spinand_device *spinand,
>>  	return spi_mem_exec_op(spinand->spimem, &op);
>>  }
>>  
>> -static int spinand_wait(struct spinand_device *spinand, u8 *s)
>> +static int spinand_wait(struct spinand_device *spinand,
>> +			unsigned long initial_delay_us,
>> +			unsigned long poll_delay_us,
>> +			u8 *s)
>>  {
>> -	unsigned long timeo =  jiffies + msecs_to_jiffies(400);
>> +	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(REG_STATUS,
>> +						      spinand->scratchbuf);
>>  	u8 status;
>>  	int ret;
>>  
>> -	do {
>> -		ret = spinand_read_status(spinand, &status);
>> -		if (ret)
>> -			return ret;
>> +	ret = spi_mem_poll_status(spinand->spimem, &op, STATUS_BUSY, 0,
>> +				  initial_delay_us,
>> +				  poll_delay_us,
>> +				  SPINAND_STATUS_TIMEOUT_MS);
>> +	if (ret)
>> +		return ret;
>>  
>> -		if (!(status & STATUS_BUSY))
>> -			goto out;
>> -	} while (time_before(jiffies, timeo));
>> +	status = *spinand->scratchbuf;
>> +	if (!(status & STATUS_BUSY))
>> +		goto out;
>>  
>>  	/*
>>  	 * Extra read, just in case the STATUS_READY bit has changed
>> @@ -526,7 +532,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
>>  	if (ret)
>>  		return ret;
>>  
>> -	return spinand_wait(spinand, NULL);
>> +	return spinand_wait(spinand,
>> +			    SPINAND_RESET_INITIAL_DELAY_US,
>> +			    SPINAND_RESET_POLL_DELAY_US,
>> +			    NULL);
>>  }
>>  
>>  static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
>> @@ -549,7 +558,10 @@ static int spinand_read_page(struct spinand_device *spinand,
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = spinand_wait(spinand, &status);
>> +	ret = spinand_wait(spinand,
>> +			   SPINAND_READ_INITIAL_DELAY_US,
>> +			   SPINAND_READ_POLL_DELAY_US,
>> +			   &status);
>>  	if (ret < 0)
>>  		return ret;
>>  
>> @@ -585,7 +597,10 @@ static int spinand_write_page(struct spinand_device *spinand,
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = spinand_wait(spinand, &status);
>> +	ret = spinand_wait(spinand,
>> +			   SPINAND_WRITE_INITIAL_DELAY_US,
>> +			   SPINAND_WRITE_POLL_DELAY_US,
>> +			   &status);
>>  	if (!ret && (status & STATUS_PROG_FAILED))
>>  		return -EIO;
>>  
>> @@ -768,7 +783,11 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = spinand_wait(spinand, &status);
>> +	ret = spinand_wait(spinand,
>> +			   SPINAND_ERASE_INITIAL_DELAY_US,
>> +			   SPINAND_ERASE_POLL_DELAY_US,
>> +			   &status);
>> +
>>  	if (!ret && (status & STATUS_ERASE_FAILED))
>>  		ret = -EIO;
>>  
>> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
>> index 6bb92f26833e..180c1fa64e62 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -169,7 +169,16 @@
>>  struct spinand_op;
>>  struct spinand_device;
>>  
>> -#define SPINAND_MAX_ID_LEN	4
>> +#define SPINAND_MAX_ID_LEN		4
>> +#define SPINAND_READ_INITIAL_DELAY_US	6
>> +#define SPINAND_READ_POLL_DELAY_US	5
>> +#define SPINAND_RESET_INITIAL_DELAY_US	5
>> +#define SPINAND_RESET_POLL_DELAY_US	5
>> +#define SPINAND_WRITE_INITIAL_DELAY_US	75
>> +#define SPINAND_WRITE_POLL_DELAY_US	15
>> +#define SPINAND_ERASE_INITIAL_DELAY_US	250
>> +#define SPINAND_ERASE_POLL_DELAY_US	50
> 
> Could you add a comment explaining where those numbers come from?

Sure

> 
>> +#define SPINAND_STATUS_TIMEOUT_MS	400
> 
> I would name that one SPINAND_WAITRDY_TIMEOUT_MS.
Ok

> 
>>  
>>  /**
>>   * struct spinand_id - SPI NAND id structure
> 

Thanks 
Patrice
