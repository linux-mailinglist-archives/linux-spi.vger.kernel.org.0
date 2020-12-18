Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269532DE8D1
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 19:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgLRSJy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 13:09:54 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10526 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgLRSJy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Dec 2020 13:09:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdcf0490000>; Fri, 18 Dec 2020 10:09:13 -0800
Received: from [10.2.61.1] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec
 2020 18:09:11 +0000
Subject: Re: [PATCH v4 5/9] spi: spi-mem: Mark dummy transfers by setting
 dummy_data bit
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>,
        <bbrezillon@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
 <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
 <20201218092106.skwej2g6bk3oksbb@ti.com>
 <20201218105759.43789ccf@collabora.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <31c395ee-d7a6-edc5-a790-89fad91a0a27@nvidia.com>
Date:   Fri, 18 Dec 2020 10:09:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218105759.43789ccf@collabora.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608314953; bh=QmrWsFekqKy4VkeNculLka/YJZ16MtzrspqbyW6h+ZM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=sCi1zECxJvqUpbq7sFXJOQFhnKG7AqdmIQlaj1Sc0xrx3tJl9TxPTcXkfeO7waL9H
         Qq9UWh2LCZ/oc+/IU7xl6DV3S4fhm2L6u+tBcTQmDUQD/MgjUYuiguBs03+ogk6ivQ
         JyqWhLR2E5WF14nDhn+Fy2EIEJHTSELorOF9J4aCPcKUUv8nAR6JLKwO3TMsoSnTqz
         aco6urHkqfDJ0UROaDDu6urtYlhIH1TgV00hQlQHqIEA03WE4Ru3AV6xm1m2iybwiF
         ZR21Y7UARIMD4E6sVPUk0zJkG8NZqrilIOYaHLElPHsv0R35PlmVjtigEbk8XUhwgm
         0AMEs6E0FH4Bg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/18/20 1:57 AM, Boris Brezillon wrote:
> On Fri, 18 Dec 2020 14:51:08 +0530
> Pratyush Yadav <p.yadav@ti.com> wrote:
>
>> Hi Sowjanya,
>>
>> On 17/12/20 12:28PM, Sowjanya Komatineni wrote:
>>> This patch marks dummy transfer by setting dummy_data bit to 1.
>>>
>>> Controllers supporting dummy transfer by hardware use this bit field
>>> to skip software transfer of dummy bytes and use hardware dummy bytes
>>> transfer.
>> What is the benefit you get from this change? You add complexity in
>> spi-mem and the controller driver, so that must come with some benefits.
>> Here I don't see any. The transfer will certainly take the same amount
>> of time because the number or period of the dummy cycles has not
>> changed. So why is this needed?
> Well, you don't have to queue TX bytes if you use HW-based dummy
> cycles, but I agree, I'd expect the overhead to be negligible,
> especially since we're talking about emitting a few bytes, not hundreds.
> This being said, the complexity added to the core is reasonable IMHO,
> so if it really helps reducing the CPU overhead (we might need some
> numbers to prove that), I guess it's okay.

Hardware dummy cycles feature of Tegra QSPI is to save SW transfer cycle 
of dummy bytes by filling FIFO.

I don't have numbers as we always use hardware dummy cycles with Tegra QSPI.

>>   
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   drivers/spi/spi-mem.c   | 1 +
>>>   include/linux/spi/spi.h | 2 ++
>>>   2 files changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>>> index f3a3f19..c64371c 100644
>>> --- a/drivers/spi/spi-mem.c
>>> +++ b/drivers/spi/spi-mem.c
>>> @@ -354,6 +354,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>>   		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
>>>   		xfers[xferpos].len = op->dummy.nbytes;
>>>   		xfers[xferpos].tx_nbits = op->dummy.buswidth;
>>> +		xfers[xferpos].dummy_data = 1;
>>>   		spi_message_add_tail(&xfers[xferpos], &msg);
>>>   		xferpos++;
>>>   		totalxferlen += op->dummy.nbytes;
>>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>>> index aa09fdc..708f2f5 100644
>>> --- a/include/linux/spi/spi.h
>>> +++ b/include/linux/spi/spi.h
>>> @@ -827,6 +827,7 @@ extern void spi_res_release(struct spi_controller *ctlr,
>>>    *      transfer. If 0 the default (from @spi_device) is used.
>>>    * @bits_per_word: select a bits_per_word other than the device default
>>>    *      for this transfer. If 0 the default (from @spi_device) is used.
>>> + * @dummy_data: indicates transfer is dummy bytes transfer.
>>>    * @cs_change: affects chipselect after this transfer completes
>>>    * @cs_change_delay: delay between cs deassert and assert when
>>>    *      @cs_change is set and @spi_transfer is not the last in @spi_message
>>> @@ -939,6 +940,7 @@ struct spi_transfer {
>>>   	struct sg_table tx_sg;
>>>   	struct sg_table rx_sg;
>>>   
>>> +	unsigned	dummy_data:1;
>>>   	unsigned	cs_change:1;
>>>   	unsigned	tx_nbits:3;
>>>   	unsigned	rx_nbits:3;
>>> -- 
>>> 2.7.4
>>>    
