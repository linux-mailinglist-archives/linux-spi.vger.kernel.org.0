Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD624375ED
	for <lists+linux-spi@lfdr.de>; Fri, 22 Oct 2021 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhJVL13 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 07:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhJVL11 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 07:27:27 -0400
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:65::8:228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44820C061764
        for <linux-spi@vger.kernel.org>; Fri, 22 Oct 2021 04:24:59 -0700 (PDT)
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 2D23752;
        Fri, 22 Oct 2021 11:24:57 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1634901895;
        bh=8wqRFYl46VkPYweKeCsLFKtiuJrjauRmNe77gxaeGSQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=fzDpK0meJN8f/3VYYtcZrfhk07zzO3mbl1t+9qkDtH4HE1KqgXdvSmQqcst25Ipkb
         nW8X402IYZu2FWiaoYUL6GwsykkknhMe2ltyHACAErqxo9RYLtyjPCwlhb0I/6g5n/
         cQf/hB2C1Kq4po9DF8W9C7LfPOPxscW6pqRpDYWJIMgS1Ii4bwuQRFJAuFuilnBJIc
         NQb29MyYKtlO4NU4sRfDStktlNKpDQKq3Miq68TjAb7I7tbMKvUYTwDZ2yrPc2aqIx
         MOb5fxqSgoRCN/MdI5nqdHfyPcMMHapfGdEAn7llgs6t6swEJIXJsWCbJ0R6orT3g1
         g0R4qzAuMpFnQ==
Subject: Re: spi enumeration process
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-spi@vger.kernel.org
References: <7247d1f3-552b-1e48-7fd6-e95edc12d016@deathstar2.nl>
 <d78426ec-3d23-7549-196a-c6802604d92d@metafoo.de>
 <138ff85a-b045-a87d-fa68-a4dabe80e626@deathstar2.nl>
 <b5ea7c2f-4954-f9fa-a6fd-61c52f7d4ee9@metafoo.de>
From:   Henk Medenblik <henk@deathstar2.nl>
Message-ID: <f86f61a8-51da-6208-242c-a8511bfdca93@deathstar2.nl>
Date:   Fri, 22 Oct 2021 13:24:52 +0200
MIME-Version: 1.0
In-Reply-To: <b5ea7c2f-4954-f9fa-a6fd-61c52f7d4ee9@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Update,

I have been messing around with driver moving, deleting and falling back 
to the ZynqMP default cadence controller which seemed to have the same 
issue now...(no ltc6951 probing).
Then after some while with same process of moving, running depmod and 
moving driver files back into /lib/modules/5.4.0-xilinx-v2020.2 again I 
managed to get the proper probing of both the custom spi controller and 
the ltc6951 driver.

However.. what might have happening and what the cause for is for having 
it running correctly now is unclear to me.

Does the order of alias'es which pop up in modules.alias could have 
effect? With the current running system I can see now that the ltc6951 
ltc6951 alias is in front of my spi-ctrl . Unfortunately I did not check 
that order when I had the issues...

Regards

Henk


On 10/22/21 11:06 AM, Lars-Peter Clausen wrote:
> On 10/22/21 10:40 AM, Henk Medenblik wrote:
>> Hi Lars,
>>
>> I don't think that the issue is here the two MODULE_DEVICE_TABLE 
>> modaliases in my ltc6951 driver. I have them both for the 
>> spi_device_id and also the of_device_id defined.
>> And I believe that if any of them would be missing, then manual 
>> modprobe of the ltc6951 driver would fail too.
>
> The table itself is used for the probing process. But the 
> MODULE_DEVICE_TABLE is only used to signal userspace that this module 
> handles the devices that are listed in the table. udev uses this 
> information to load the driver if necessary.
>
> Manual loading will still work without the MODULE_DEVICE_TABLE. But of 
> course not without the table itself.
>
>>
>> The issue is that it does not get automatically enumerated when my 
>> custom spi controller get loaded (i can see after boot that the spi 
>> controller is alive when looking into /proc/modules)
>>
>> However, the spi slave device is not alive. The strange thing is that 
>> this does work if I connect the spi slave to the onboard SPI 
>> controller which resides inside the Zynq MPSoC.. (after putting the 
>> ltc slave in the tree under that controller)
>
> Ok, that's a bit odd that it works with the MPSoC controller. What I'd 
> do is check `/sys/bus/spi/devices/`. Your device will be there even if 
> driver has not been loaded. And then check the `modalias` and `uevent` 
> files of the device. Check if those files look different when using 
> your controller vs. the MPSoC.
>
> - Lars
>
>>
>> Regards
>>
>> Henk
>>
>>
>> On 10/22/21 10:25 AM, Lars-Peter Clausen wrote:
>>> On 10/22/21 9:55 AM, Henk Medenblik wrote:
>>>> Hi all,
>>>>
>>>> I am using a custom SPI controller which I created in my Xilinx 
>>>> MPSoC fpga part. On this custom spi controller bus I have one or 
>>>> more SPI devices (in my case a custom LTC6951 driver) connected in 
>>>> the devicetree under my spi controller.
>>>> Because the controller is custom, I wrote the SPI controller driver 
>>>> and also some slave device drivers which seem to work.
>>>> These drivers are both created as out of tree loadable modules.
>>>>
>>>> My issue is that at boot of my SocFPGA I can see that my SPI 
>>>> controller driver is correctly loaded during the boot process but 
>>>> the spi slave driver which is connected to my controller does not 
>>>> get automatically loaded.
>>>> Therefore, I manually need to do a modprobe ltc6951.ko in my case 
>>>> before the LTC6951 slave in my case is up and running.
>>>>
>>>> So, it seems like if I do not really understand the spi slaves 
>>>> enumeration process or there is something else that I am missing 
>>>> here. I was under the assumption that the slaves automatically get 
>>>> enumerated (they are put as slaves under my controller inside the 
>>>> device tree) whenever it's master controller becomes alive. 
>>>
>>> Hi,
>>>
>>> Modules are loaded by userspace, e.g. udev. It does so based on 
>>> hints that are embedded in the module, these are called MODALIASs. 
>>> When udev sees a device without a driver it will check all the 
>>> modules to see if they have a matching modalias for the driver and 
>>> then load the module.
>>>
>>> In your driver you define the modalias usually using 
>>> MODULE_DEVICE_TABLE(type, table). E.g. for a SPI driver the type 
>>> would be spi and will take a reference to the spi_device_id table 
>>> for your driver. In addition if you are using devicetree you do the 
>>> same for the of_device_id table with `of` as the type.
>>>
>>> - Lars
>>>
>
