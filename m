Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005251BD70B
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 10:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD2IU6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 04:20:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:45208 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgD2IU6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 04:20:58 -0400
IronPort-SDR: MJjDMPTL/m+7S/haGmN/VWkXcpqZq3g2N87bfukpI75In7LVG2o5I4i5A473I5gpY9fYajDSV3
 CSfzAE3OImMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 01:20:58 -0700
IronPort-SDR: HN7dPtWwjRSKyR2zf95hM1aSJwyC3AoFan/vq9re5KmJF+BFnTRXJTUK6JlkMfhCTYpYXCtc13
 JXofrmp3SOXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="459104221"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2020 01:20:58 -0700
Received: from [10.215.242.51] (ekotax-mobl.gar.corp.intel.com [10.215.242.51])
        by linux.intel.com (Postfix) with ESMTP id C4228580619;
        Wed, 29 Apr 2020 01:20:54 -0700 (PDT)
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
To:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <310ca761-e7ae-1192-99fd-a1960697806b@gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <46f31699-e781-ae33-3ee5-d51e6940ee43@linux.intel.com>
Date:   Wed, 29 Apr 2020 16:20:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <310ca761-e7ae-1192-99fd-a1960697806b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/28/2020 7:10 PM, Daniel Schwierzeck wrote:
>
> Am 24.04.20 um 12:42 schrieb Dilip Kota:
>> Synchronize tx, rx and error interrupts by registering to the
>> same interrupt handler. Interrupt handler will recognize and process
>> the appropriate interrupt on the basis of interrupt status register.
>> Also, establish synchronization between the interrupt handler and
>> transfer operation by taking the locks and registering the interrupt
>> handler as thread IRQ which avoids the bottom half.
> actually there is no real bottom half. Reading or writing the FIFOs is
> fast and is therefore be done in hard IRQ context. But as the comment
Doing FIFO r/w in threaded irqs shouldn't cause any impact on maximum 
transfer rate i think.
Also the ISR should be quick enough, doing FIFO r/w in ISR adds up more 
latency to ISR.
Handling the FIFOs r/w in threaded irq will be a better way.
> for lantiq_ssc_bussy_work() state, the driver needs some busy-waiting
> after the last interrupt. I don't think it's worth to replace this with
> threaded interrupts which add more runtime overhead and likely decrease
> the maximum transfer speed.
Workqueue has a higher chances of causing SPI transfers timedout.

>
>> Fixes the wrongly populated interrupt register offsets too.
>>
>> Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
>> Fixes: ad2fca0721d1 ("spi: lantiq-ssc: add LTQ_ prefix to defines")
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>>   drivers/spi/spi-lantiq-ssc.c | 89 ++++++++++++++++++++++----------------------
>>   1 file changed, 45 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
>> index 1fd7ee53d451..b67f5925bcb0 100644
>> --- a/drivers/spi/spi-lantiq-ssc.c
>> +++ b/drivers/spi/spi-lantiq-ssc.c
>> @@ -6,6 +6,7 @@
>>   
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/mutex.h>
>>   #include <linux/of_device.h>
>>   #include <linux/clk.h>
>>   #include <linux/io.h>
>> @@ -13,7 +14,6 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/sched.h>
>>   #include <linux/completion.h>
>> -#include <linux/spinlock.h>
>>   #include <linux/err.h>
>>   #include <linux/gpio.h>
>>   #include <linux/pm_runtime.h>
>> @@ -50,8 +50,8 @@
>>   #define LTQ_SPI_RXCNT		0x84
>>   #define LTQ_SPI_DMACON		0xec
>>   #define LTQ_SPI_IRNEN		0xf4
>> -#define LTQ_SPI_IRNICR		0xf8
>> -#define LTQ_SPI_IRNCR		0xfc
>> +#define LTQ_SPI_IRNCR		0xf8
>> +#define LTQ_SPI_IRNICR		0xfc
> the values are matching the datasheets for Danube and VRX200 family.
> AFAICS the registers have been swapped for some newer SoCs like GRX330
> or GRX550. It didn't matter until now because those registers were
> unused by the driver. So if you want to use those registers, you have to
> deal somehow with the register offset swap in struct lantiq_ssc_hwcfg.
In the initial phase of the patch, i have written the code considering 
the interrupt offsets in latest chipsets are different from the older 
chipsets.
But, when i refered the Hauke's changes to add support for xrx500(which 
he done internally), offsets are corrected . So i did the same.

I will define these offsets in the SoC data structure which i have done 
initially.

Regards,
Dilip
>>   
>>
