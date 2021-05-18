Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D785387B36
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhEROgW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 10:36:22 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34739 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232245AbhEROgV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 10:36:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IEWv7u024660;
        Tue, 18 May 2021 16:34:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IoZWo4g6WYmn4ZvcOIUxvySqtfs8j1f0MrKnheiGUHs=;
 b=DWsG2/8/3Qz8EOE6fD0Ev8WmmPUOpuL+EpzqNukA0oUpU0lEULgvEElHjsHFOFbVcvhP
 tUn4l/mQqYuLQW6Z8PCRcj7hVjryeaBDNhMwJbBX/kan5rFoVnTs98/c99WLsOMac4rl
 WLIDONkX7FU5nrtYQw+Kp7ZLtjfF87D1GFq6yf1OQuNACqDWJgsxkX1w5aiQTrFUiMOu
 n1GpjTi8F1S/XK4ROkVDUOFukZk4W3TjAbkWiRKY6OgbbVP1cMRnpIM/c1rcsXjkIZWa
 O60Pz0hxQ06k1DLcaITk8ZtZsrYW2BEMy4nKOoSVP1oUFOFfPXgsILqRPuwLVJCK89kj qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38maunsss0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 16:34:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DEBA310002A;
        Tue, 18 May 2021 16:34:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C3E0822AED2;
        Tue, 18 May 2021 16:34:53 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May
 2021 16:34:52 +0200
Subject: Re: [PATCH v4 2/3] mtd: spinand: use the spi-mem poll status APIs
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
References: <20210518134332.17826-1-patrice.chotard@foss.st.com>
 <20210518134332.17826-3-patrice.chotard@foss.st.com>
 <20210518161834.6860c310@collabora.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <028d3c29-effe-1604-8e38-b7fb0783c4a2@foss.st.com>
Date:   Tue, 18 May 2021 16:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210518161834.6860c310@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_07:2021-05-18,2021-05-18 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 5/18/21 4:18 PM, Boris Brezillon wrote:
> On Tue, 18 May 2021 15:43:31 +0200
> <patrice.chotard@foss.st.com> wrote:
> 
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Make use of spi-mem poll status APIs to let advanced controllers
>> optimize wait operations.
>> This should also fix the high CPU usage for system that don't have
>> a dedicated STATUS poll block logic.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>> Changes in v4:
>>   - Update commit message.
>>   - Add comment which explains how delays has been calculated.
>>   - Rename SPINAND_STATUS_TIMEOUT_MS to SPINAND_WAITRDY_TIMEOUT_MS.
>>
>> Changes in v3:
>>   - Add initial_delay_us and polling_delay_us parameters to spinand_wait()
>>   - Add SPINAND_READ/WRITE/ERASE/RESET_INITIAL_DELAY_US and
>>     SPINAND_READ/WRITE/ERASE/RESET_POLL_DELAY_US defines.
>>
>> Changes in v2:
>>   - non-offload case is now managed by spi_mem_poll_status()
>>
>>  drivers/mtd/nand/spi/core.c | 45 ++++++++++++++++++++++++++-----------
>>  include/linux/mtd/spinand.h | 22 ++++++++++++++++++
>>  2 files changed, 54 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 17f63f95f4a2..3131fae0c715 100644
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
>> +				  SPINAND_WAITRDY_TIMEOUT_MS);
>> +	if (ret)
>> +		return ret;
>>  
>> -		if (!(status & STATUS_BUSY))
>> -			goto out;
>> -	} while (time_before(jiffies, timeo));
>> +	status = *spinand->scratchbuf;
>> +	if (!(status & STATUS_BUSY))
>> +		goto out;
> 
> Looks like you expect the driver to not only wait for a status change
> but also fill the data buffer with the last status value. I think that
> should be documented in the SPI mem API.

Right, i will update the API.

Thanks
Patrice
> 
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
>> index 6bb92f26833e..6988956b8492 100644
>> --- a/include/linux/mtd/spinand.h
>> +++ b/include/linux/mtd/spinand.h
>> @@ -170,6 +170,28 @@ struct spinand_op;
>>  struct spinand_device;
>>  
>>  #define SPINAND_MAX_ID_LEN	4
>> +/*
>> + * For erase, write and read operation, we got the following timings :
>> + * tBERS (erase) 1ms to 4ms
>> + * tPROG 300us to 400us
>> + * tREAD 25us to 100us
>> + * In order to minimize latency, the min value is divided by 4 for the
>> + * initial delay, and dividing by 20 for the poll delay.
>> + * For reset, 5us/10us/500us if the device is respectively
>> + * reading/programming/erasing when the RESET occurs. Since we always
>> + * issue a RESET when the device is IDLE, 5us is selected for both initial
>> + * and poll delay.
>> + */
>> +#define SPINAND_READ_INITIAL_DELAY_US	6
>> +#define SPINAND_READ_POLL_DELAY_US	5
>> +#define SPINAND_RESET_INITIAL_DELAY_US	5
>> +#define SPINAND_RESET_POLL_DELAY_US	5
>> +#define SPINAND_WRITE_INITIAL_DELAY_US	75
>> +#define SPINAND_WRITE_POLL_DELAY_US	15
>> +#define SPINAND_ERASE_INITIAL_DELAY_US	250
>> +#define SPINAND_ERASE_POLL_DELAY_US	50
>> +
>> +#define SPINAND_WAITRDY_TIMEOUT_MS	400
>>  
>>  /**
>>   * struct spinand_id - SPI NAND id structure
> 
