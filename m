Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B65F37358D
	for <lists+linux-spi@lfdr.de>; Wed,  5 May 2021 09:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhEEH15 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 May 2021 03:27:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53306 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231800AbhEEH1z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 03:27:55 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1457QiO3032463;
        Wed, 5 May 2021 09:26:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pRlWT5qcExpAJYwywO80VV4wmOR+KAWKEfT8LL3UiPw=;
 b=2CJmUexHPWDCfYqyXHrM+Dq9FX5rnioitZX17Nt1HDfaLRCqXCcrgBQ+7o+WwDS0QCYX
 Ngwnhebuo9FURp27FrflMMhExepCYcuRgslw57XoPWnNOpT/UNUwouBtLUsKrGgoeURv
 SpQOvhWwJKfYjc7f2/9HRqyB6rTjCXO5rZnZYU766ZFAMCBW6FS/AI71CTkqO5Yp94lO
 zM+CwAONyuSslko0K+kOyoCcVKAO+YaZh4CR5I1QzjB+pWc3MKJEA5bt88GZ8ezI31Tm
 +o8HQq87mrPSN8fxg8uBGxDuhrAfVbm/ywb8CCdEOBDCGUmuQXY8J912lTNQVOKt3FW3 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38be9ste8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 09:26:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 60F9010002A;
        Wed,  5 May 2021 09:26:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4B79B20F491;
        Wed,  5 May 2021 09:26:48 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 5 May
 2021 09:26:47 +0200
Subject: Re: [PATCH 1/3] spi: spi-mem: add automatic poll status functions
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
References: <20210426143934.25275-1-patrice.chotard@foss.st.com>
 <20210426143934.25275-2-patrice.chotard@foss.st.com>
 <20210430185104.377d1bc6@collabora.com>
 <20210503084742.7cp77snyohkdwwvv@ti.com>
 <20210503111114.26b64e25@collabora.com>
 <20210503092935.vjitc7mc47wttn77@ti.com>
 <20210503115252.08af412c@collabora.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <1357fd09-62e6-3ac8-903d-7b87b29fce23@foss.st.com>
Date:   Wed, 5 May 2021 09:26:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210503115252.08af412c@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_02:2021-05-05,2021-05-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Boris, Pratyush

On 5/3/21 11:52 AM, Boris Brezillon wrote:
> On Mon, 3 May 2021 14:59:37 +0530
> Pratyush Yadav <p.yadav@ti.com> wrote:
> 
>> On 03/05/21 11:11AM, Boris Brezillon wrote:
>>> On Mon, 3 May 2021 14:17:44 +0530
>>> Pratyush Yadav <p.yadav@ti.com> wrote:
>>>   
>>>> On 30/04/21 06:51PM, Boris Brezillon wrote:  
>>>>> On Mon, 26 Apr 2021 16:39:32 +0200
>>>>> <patrice.chotard@foss.st.com> wrote:
>>>>>     
>>>>>> From: Christophe Kerello <christophe.kerello@foss.st.com>
>>>>>>
>>>>>> With STM32 QSPI, it is possible to poll the status register of the device.
>>>>>> This could be done to offload the CPU during an operation (erase or
>>>>>> program a SPI NAND for example).
>>>>>>
>>>>>> spi_mem_poll_status API has been added to handle this feature.
>>>>>>
>>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>>>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>> ---
>>>>>>  drivers/spi/spi-mem.c       | 34 ++++++++++++++++++++++++++++++++++
>>>>>>  include/linux/spi/spi-mem.h |  8 ++++++++
>>>>>>  2 files changed, 42 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>>>>>> index 1513553e4080..43dce4b0efa4 100644
>>>>>> --- a/drivers/spi/spi-mem.c
>>>>>> +++ b/drivers/spi/spi-mem.c
>>>>>> @@ -743,6 +743,40 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
>>>>>>  	return container_of(drv, struct spi_mem_driver, spidrv.driver);
>>>>>>  }
>>>>>>  
>>>>>> +/**
>>>>>> + * spi_mem_poll_status() - Poll memory device status
>>>>>> + * @mem: SPI memory device
>>>>>> + * @op: the memory operation to execute
>>>>>> + * @mask: status bitmask to ckeck
>>>>>> + * @match: status expected value
>>>>>> + * @timeout: timeout
>>>>>> + *
>>>>>> + * This function send a polling status request to the controller driver
>>>>>> + *
>>>>>> + * Return: 0 in case of success, -ETIMEDOUT in case of error,
>>>>>> + *         -EOPNOTSUPP if not supported.
>>>>>> + */
>>>>>> +int spi_mem_poll_status(struct spi_mem *mem,
>>>>>> +			const struct spi_mem_op *op,
>>>>>> +			u8 mask, u8 match, u16 timeout)
>>>>>> +{
>>>>>> +	struct spi_controller *ctlr = mem->spi->controller;
>>>>>> +	int ret = -EOPNOTSUPP;
>>>>>> +
>>>>>> +	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
>>>>>> +		ret = spi_mem_access_start(mem);    
>>>>>
>>>>> You should probably check that op is a single byte read before
>>>>> accepting the command.    
>>>>
>>>> Please do not discriminate against 8D-8D-8D flashes ;-).  
>>>
>>> Then mask and match should probably be u16 :P. And the check as it is
>>> seems a bit lax to me. Drivers will of course be able to reject the op
>>> when there's more than one byte (or 16bit word in case of 8D) to read,
>>> but it feels like the core could automate that a bit.  
>>
>> The two 8D flashes that are currently supported in SPI NOR both have a 
>> 1-byte status register. But to read it, the read op should be 2-byte 
>> long to avoid partial cycles at the end. The second byte is simply 
>> discarded.
>>
>> 2-byte wide registers might show up in the future, but for now at least 
>> we don't have to worry about them.
> 
> Well, I guess it doesn't hurt to take it into account now. I mean,
> what's happening on the bus in that case is a 2byte transfer, with the
> second byte being ignored, which you can describe with a 16bit mask
> of 0xMM00 (assuming big endian transfers here, as done for other ops).

OK, i will take the 2 byte case into account.

I will grab all remarks done and come back with an updated proposal in a few days.

Thanks
Patrice

> 
>>
>>>   
>>>>   
>>>>>     
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +
>>>>>> +		ret = ctlr->mem_ops->poll_status(mem, op, mask, match, timeout);    
>>>>>
>>>>> You also need some sort of ->poll_status_is_supported() to validate
>>>>> that the controller supports the status polling for this specific op (I    
>>>>
>>>> I don't think a separate function is needed for checking if the poll 
>>>> status op is supported. Return value of -EOPNOTSUPP should be able to 
>>>> signal that. This can also be used to check if Octal DDR capable 
>>>> controllers are able to poll using 2-byte reads.  
>>>
>>> Yeah, I had something more complex in mind to avoid doing this 'try
>>> native mode and fall back on sw-based more if not supported' dance
>>> every time a status poll is requested (something similar to what we do
>>> for dirmaps, with a status poll desc), but I guess that's a bit
>>> premature (and probably uneeded).  
>>
>> I think Mark also suggested something similar. Make the CPU/non-CPU case 
>> transparent to the caller. I agree with with this direction. Makes the 
>> caller simpler.
> 
> It's kind of orthogonal to what I was suggesting, but yes, that's
> definitely a good idea. We certainly don't want the spi-nor layer to
> open code the same logic if the spi-mem layer can do it for us.
> 
>>
>> I also mentioned in a reply to this patch that supports_op() should be 
>> called before the op is executed. That should take care of "base" 
>> support for the op. The poll-specific checks can go in the poll_status() 
>> function itself. If either of those say the op is not supported, it 
>> should fall back to CPU based polling. That's the design that makes the 
>> most sense to me.
> 
> What I had in mind was more:
> 
> 1/ create a poll desc with spi_mem_create_poll_status_desc(). The
>    "operation supported" check is done here. The controller can store
>    all its HW-specific state in there. If the operation is not natively
>    supported, a SW-based poll descriptor (similar to the SW-based
>    dirmap) is created
> 2/ poll the status with spi_mem_poll_status(). This function is passed
>    a poll descriptor which helps select the path that should be taken
>    without having to check every time whether the hardware supports a
>    specific status polling op. I can also imagine some preparation
>    being done during the desc creation if that makes sense (preparing
>    reg values to be written when a status poll request is issued for
>    instance)
> 
> Anyway, as I said, this sort of optimization might be a bit premature.
> 


