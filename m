Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5901E382BC1
	for <lists+linux-spi@lfdr.de>; Mon, 17 May 2021 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhEQMGf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 May 2021 08:06:35 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:11264 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236859AbhEQMGd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 May 2021 08:06:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HBup8e021853;
        Mon, 17 May 2021 14:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=2KwkkuHfRJE0R9CP+OHANEZfxy/RymkNrjObI5KIHhQ=;
 b=gZJB3FgoPvoon//iQ+hgH13FcffMIydpr0sUF6PJpS4lHi458zGK5ciqye1a6xNEAq44
 FQj3Hx/g6I6Gg4cus9TN5TieSvvu66lPfaIPjnlzvDEDMbGmOGZF8b8qja2uue9GDhRZ
 D9guc+TvZz3gYklc/nHqMVibunhWsOgDwnY3lRDMSlBrrQwTv1CM+bWrI0deCsbL2257
 sNaeYmbZxUrxGAITluHI0QBUfteLm8JZ5hcuny28NniA72yqrmBd36T8wYbAH8Gdc/Y8
 xusY7byum1cc87K+N50C1lu6N0t+Y6FL6Nv8TLJpHyvEyMN9t2wtixefzGOr7/Qs77Nr +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38kmb2seew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 14:05:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB7D210002A;
        Mon, 17 May 2021 14:04:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B78B722D625;
        Mon, 17 May 2021 14:04:59 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 May
 2021 14:04:58 +0200
Subject: Re: [PATCH v2 1/3] spi: spi-mem: add automatic poll status functions
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
References: <20210507131756.17028-1-patrice.chotard@foss.st.com>
 <20210507131756.17028-2-patrice.chotard@foss.st.com>
 <20210517094140.53cb643a@collabora.com>
 <e70b13ba-7f65-7ff1-0517-94b39615dcdb@foss.st.com>
 <20210517132551.7dd56a5e@collabora.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <45ee6378-271d-aeb5-90ea-ed2e0673f3fb@foss.st.com>
Date:   Mon, 17 May 2021 14:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210517132551.7dd56a5e@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_04:2021-05-17,2021-05-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 5/17/21 1:25 PM, Boris Brezillon wrote:
> On Mon, 17 May 2021 11:24:25 +0200
> Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
> 
>> Hi Boris
>>
>> On 5/17/21 9:41 AM, Boris Brezillon wrote:
>>> On Fri, 7 May 2021 15:17:54 +0200
>>> <patrice.chotard@foss.st.com> wrote:
>>>   
>>>> +/**
>>>> + * spi_mem_poll_status() - Poll memory device status
>>>> + * @mem: SPI memory device
>>>> + * @op: the memory operation to execute
>>>> + * @mask: status bitmask to ckeck
>>>> + * @match: (status & mask) expected value
>>>> + * @timeout_ms: timeout in milliseconds
>>>> + *
>>>> + * This function send a polling status request to the controller driver
>>>> + *
>>>> + * Return: 0 in case of success, -ETIMEDOUT in case of error,
>>>> + *         -EOPNOTSUPP if not supported.
>>>> + */
>>>> +int spi_mem_poll_status(struct spi_mem *mem,
>>>> +			const struct spi_mem_op *op,
>>>> +			u16 mask, u16 match, u16 timeout_ms)  
>>>
>>> Maybe you should pass a delay_us too, to poll the status at the right
>>> rate in the SW-based case (can also be used by drivers if they need to  
>>
>> Ok, i will add a polling_rate_us parameter to poll_status() callback,
>> even if in STM32 driver case we will not use it, i agree it should be useful 
>> depending of driver's implementation.
>>
>>> configure the polling rate). You could also add an initial_delay_us to
>>> avoid polling the status too early: an erase operation will take longer
>>> than a write which will take longer than a read. No need to check the
>>> status just after issuing the command, especially if the polling is
>>> done in SW. Those 2 arguments should also be passed to the driver.  
>>
>> Regarding the addition of an initial_delay_us. We got two solution:
>>   - use the same polling rate already used by read_poll_timeout() and 
>>     set read_poll_timeout()'s sleep_before_read parameter to true (in our case 20 us
>>     will be used as initial delay and as polling rate).
>>
>>   - add an udelay(initial_delay_us) or even better usleep_range(initial_delay_us,
>>     initial_delay_us + delta) before calling read_poll_timeout().
>>
>> I imagine you prefer the second solution ?
> 
> Yep, you might want to use udelay() when the delay is small and
> usleep_range() otherwise.
> 
>>
>> By adding polling_rate_us and initial_delay_us parameters to 
>> spi_mem_poll_status(), it implies to update all spinand_wait() calls for 
>> different operations (reset, read page, write page, erase) with respective  
>> initial_delay_us/polling_rate_us values for spi_mem_poll_status()'s parameters.
>>
>> Can you provide adequate initial_delay_us and polling rate_us for each operation type ?.
> 
> If I refer to the datasheets I have,
> 
> tBERS (erase) 1ms to 4ms
> tPROG 300us to 400us
> tREAD 25us to 100us
> 
> Let's assume we want to minimize the latency, I'd recommend dividing
> the min value by 4 for the initial delay, and dividing it by 20 for the
> poll delay, which gives:
> 
> ERASE -> initial_delay = 250us, poll_delay = 50us
> PROG -> initial_delay = 100us, poll_delay = 20us

another remark, it should be:  PROG -> initial_delay = 75 us (300 / 4) , poll_delay = 15us ( 300 / 20)

Patrice

> READ -> initial_delay = 6us, poll_delay = 5us
> 
> Of course, that'd be even better if we were able to extract this
> information from the NAND ID (or ONFI table), but I guess we can live
> with those optimistic values in the meantime.
> 
