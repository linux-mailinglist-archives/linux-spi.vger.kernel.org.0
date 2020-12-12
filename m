Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7118B2D889B
	for <lists+linux-spi@lfdr.de>; Sat, 12 Dec 2020 18:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgLLR3i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Dec 2020 12:29:38 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:57028 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390595AbgLLR3i (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 12 Dec 2020 12:29:38 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd4fdd70003>; Sun, 13 Dec 2020 01:28:55 +0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 12 Dec
 2020 17:28:55 +0000
Received: from [10.2.60.59] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 12 Dec
 2020 17:28:52 +0000
Subject: Re: [PATCH v3 5/9] spi: spi-mem: Allow masters to transfer dummy
 cycles directly by hardware
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>,
        <bbrezillon@kernel.org>, <p.yadav@ti.com>,
        <tudor.ambarus@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
 <1607721363-8879-6-git-send-email-skomatineni@nvidia.com>
 <20201212115715.31a8d755@collabora.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <7efb281a-98d7-68c5-1515-0e980b6cfe12@nvidia.com>
Date:   Sat, 12 Dec 2020 09:28:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212115715.31a8d755@collabora.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607794135; bh=JRdJwxDrHqj84zOr7vEYjGJE0Jucw9ayr/+irmlLuFk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=ZllRZodPRm8gF0TopiB6E9PC3EXyRG2M5XjnGN9KtnwCsMZRK9BEJt+L/wY9FQArN
         3vKCKwhSd7MgrwWwDwDdvVuSM92zMUAIkg7oCmuLSKWTvHkWaEukdUxhvAGf7uPpz6
         EpLcaZxNDZkrk0XqBf0JreZdyxVEZux9pyORxvo7IhnVbIhQTxdu4CMz/ZGBLYVs5M
         2nkoGgZ96EgZ9+RXzLBv/OYQT4SOue3yz+8HtgfRq2S/gVIVL0XJL/TKGAA9Er4c/T
         w2GhNdTsNOmqZulPvh43xaFyZXXHf3N/0+psnBWgreGUjE2zOmdbu7mIV8WmDGUOSt
         rt169kGFJcw4w==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 12/12/20 2:57 AM, Boris Brezillon wrote:
> On Fri, 11 Dec 2020 13:15:59 -0800
> Sowjanya Komatineni <skomatineni@nvidia.com> wrote:
>
>> This patch adds a flag SPI_MASTER_USES_HW_DUMMY_CYCLES for the controllers
>> that support transfer of dummy cycles by the hardware directly.
> Hm, not sure this is a good idea. I mean, if we expect regular SPI
> devices to use this feature, then why not, but if it's just for
> spi-mem, I'd recommend implementing a driver-specific exec_op() instead
> of using the default one.

dummy cycles programming is SPI device specific.

Transfer of dummy bytes by SW or HW controller can be depending on 
features supported by controller.

Adding controller driver specific exec_op() Just for skipping dummy 
bytes transfer will have so much of redundant code pretty much what all 
spi_mem_exec_op does.

So in v1, I handled this in controller driver by skipping SW transfer of 
dummy bytes during dummy phase and programming dummy cycles in 
controller register to allow HW to transfer.

Based on v1 feedback discussion, added this flag 
SPI_MASTER_USES_HW_DUMMY_CYCLES which can be used by controllers 
supporting HW dummy bytes transfer and updated spi_mem_exec_op to skip 
SW dummy bytes.

This helps other controllers supporting HW transfer of dummy bytes as 
well just to set the flag and use dummy cycles directly.

> If we go for those core changes, we should at least add a
> ctrl->max_dummy_cycles field so the core can fallback to regular writes
> when the number of dummy cycles in the spi_mem_op exceeds what the
> controller can do.
Yes makes sense. Will add this once we decide on keeping this flag to 
identify controllers supporting HW transfer of dummy bytes Vs SW transfer.
>> For controller with this flag set, spi-mem driver will skip dummy bytes
>> transfer in the spi message.
>>
>> Controller drivers can get the number of dummy cycles from spi_message.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/spi/spi-mem.c   | 18 +++++++++++-------
>>   include/linux/spi/spi.h |  8 ++++++++
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index f3a3f19..38a523b 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -350,13 +350,17 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>   	}
>>   
>>   	if (op->dummy.nbytes) {
>> -		memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
>> -		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
>> -		xfers[xferpos].len = op->dummy.nbytes;
>> -		xfers[xferpos].tx_nbits = op->dummy.buswidth;
>> -		spi_message_add_tail(&xfers[xferpos], &msg);
>> -		xferpos++;
>> -		totalxferlen += op->dummy.nbytes;
>> +		if (ctlr->flags & SPI_MASTER_USES_HW_DUMMY_CYCLES) {
>> +			msg.dummy_cycles = (op->dummy.nbytes * 8) / op->dummy.buswidth;
>> +		} else {
>> +			memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
>> +			xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
>> +			xfers[xferpos].len = op->dummy.nbytes;
>> +			xfers[xferpos].tx_nbits = op->dummy.buswidth;
>> +			spi_message_add_tail(&xfers[xferpos], &msg);
>> +			xferpos++;
>> +			totalxferlen += op->dummy.nbytes;
>> +		}
>>   	}
>>   
>>   	if (op->data.nbytes) {
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index aa09fdc..2024149 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -512,6 +512,8 @@ struct spi_controller {
>>   
>>   #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
>>   
>> +#define SPI_MASTER_USES_HW_DUMMY_CYCLES	BIT(6)	/* HW dummy bytes transfer */
>> +
>>   	/* flag indicating this is an SPI slave controller */
>>   	bool			slave;
>>   
>> @@ -1022,6 +1024,12 @@ struct spi_message {
>>   	unsigned		actual_length;
>>   	int			status;
>>   
>> +	/*
>> +	 * dummy cycles in the message transfer. This is used by the controller
>> +	 * drivers supports transfer of dummy cycles directly by the hardware.
>> +	 */
>> +	u8			dummy_cycles;
>> +
>>   	/* for optional use by whatever driver currently owns the
>>   	 * spi_message ...  between calls to spi_async and then later
>>   	 * complete(), that's the spi_controller controller driver.
