Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB4175719
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 10:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCBJaL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 04:30:11 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbgCBJaL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Mar 2020 04:30:11 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D8351E6D818B170870C1;
        Mon,  2 Mar 2020 09:30:09 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 2 Mar 2020 09:30:09 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 09:30:09 +0000
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linuxarm@huawei.com>,
        <linux-spi@vger.kernel.org>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <52ecb988-d842-c04b-a0e8-93e8850009c4@cogentembedded.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <07bb2213-5543-0ef0-9585-be83026c1199@huawei.com>
Date:   Mon, 2 Mar 2020 09:30:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <52ecb988-d842-c04b-a0e8-93e8850009c4@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/03/2020 10:04, Sergei Shtylyov wrote:
> Hello!
> 

Hi Sergei,

> On 28.02.2020 18:18, John Garry wrote:
> 
>> Currently ACPI firmware description for a SPI device does not have any
>> method to describe the data buswidth on the board.
>>
>> So even through the controller and device may support higher modes than
>            ^^^^^^^
>     Though?
> 

right

>> standard SPI, it cannot be assumed that the board does - as such, that
>> device is limited to standard SPI in such a circumstance.
>>
>> As a workaround, allow the controller driver supply buswidth override 
>> bits,
>> which are used inform the core code that the controller driver knows the
>> buswidth supported on that board for that device.
>>
>> A host controller driver might know this info from DMI tables, for 
>> example.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/spi/spi.c       | 4 +++-
>>   include/linux/spi/spi.h | 3 +++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 38b4c78df506..292f26807b41 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct 
>> spi_controller *ctlr)
>>       spi->dev.bus = &spi_bus_type;
>>       spi->dev.release = spidev_release;
>>       spi->cs_gpio = -ENOENT;
>> +    spi->mode = ctlr->buswidth_override_bits;
>>       spin_lock_init(&spi->statistics.lock);
>> @@ -2181,9 +2182,10 @@ static acpi_status 
>> acpi_register_spi_device(struct spi_controller *ctlr,
>>           return AE_NO_MEMORY;
>>       }
>> +
> 
>     What for?

slipped through the net

> 
>>       ACPI_COMPANION_SET(&spi->dev, adev);
>>       spi->max_speed_hz    = lookup.max_speed_hz;
>> -    spi->mode        = lookup.mode;
>> +    spi->mode        |= lookup.mode;
>>       spi->irq        = lookup.irq;
>>       spi->bits_per_word    = lookup.bits_per_word;
>>       spi->chip_select    = lookup.chip_select;
> [...]

TBH, I did not think that this series would be applied since I tagged it 
as RFC, hence the typos which would have been caught. Indeed, this also 
exposes an issue with enabling quad SPI for a spansion SPI NOR part, 
which I need to debug now in the SPI NOR driver.

Hi Mark,

Do you want me to do anything about the above superfluous newline?

Thanks,
John

> 
> MBR, Sergei
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> .

