Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C724C1E56
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 23:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiBWWTL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 17:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiBWWTK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 17:19:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C061A3BC
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 14:18:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3F83B821CD
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 22:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2730EC340E7;
        Wed, 23 Feb 2022 22:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645654719;
        bh=MJ7wFV7vxGB0tPVhyv8gDuTIjGxxTwqta4K4R2v1gCo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E5+sbfml/2vgX0jgm25i5pXIpbwod+nNn7dk4CpFD884lrx55VXUXKbO9si8q50IC
         cCIc/g+r7rksgMNoaKUySU+lEoaTaNVHAivCJ0VDprs0lgmqg38A3RwuCv5uRQeYEX
         VRzRyB87vluv6gWomPDiOg7Qdbo7ruBJylo4ITl5+/UpdZ/qtfVaDE/lWRuZG4kMH+
         K3AqioFewJlSoHQVN84ImdtqZCFK04WpR42swlEvu8qL3k6dIl6gRdY5tc31VjIru4
         m0IAj093NdE8xo/TI/g8Nc2PGxYumASqVcXSMd8urPKIWaGX0h351maJFK/0ZpL6V0
         XFb8pP7/aJ5gQ==
Message-ID: <3e9721ff-ba1d-c02b-09da-f3334b1df409@kernel.org>
Date:   Wed, 23 Feb 2022 16:18:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org
Cc:     Pratyush Yadav <p.yadav@ti.com>
References: <20220221043238.295369-1-marex@denx.de>
 <79280984-e71d-e767-bb67-bd2a2fe31858@kernel.org>
 <ccdc4738-0fb0-d3f6-5c56-d61eb8e8bf33@denx.de>
 <04e70d1a-c07b-e1dc-aea6-36fe9b7ce667@kernel.org>
 <8060ae0e-700e-3b72-3ab9-e7ca8e19ad9e@denx.de>
 <8dc7a7d6-d24f-b3a6-32b9-64cdb8c6f3be@kernel.org>
 <bbc84e6b-68ce-84cb-7bc2-3ac844ec3710@denx.de>
 <cd1e80f1-b12e-d8c4-e7f2-bfbc21ebf57c@kernel.org>
 <861ec3ba-65c5-d4e9-d1f4-9f7e5408f7cf@denx.de>
 <0ad3907c-660c-af7a-89b6-ca6954c08813@kernel.org>
 <b44d9a9b-001e-a5ed-2450-0b10b6a222b1@denx.de>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <b44d9a9b-001e-a5ed-2450-0b10b6a222b1@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2/23/22 11:16, Marek Vasut wrote:
> On 2/23/22 17:46, Dinh Nguyen wrote:
>>
>>
>> On 2/23/22 10:43, Marek Vasut wrote:
>>> On 2/23/22 17:28, Dinh Nguyen wrote:
>>>>
>>>>
>>>> On 2/22/22 18:54, Marek Vasut wrote:
>>>>> On 2/22/22 22:32, Dinh Nguyen wrote:
>>>>>>
>>>>>>
>>>>>> On 2/22/22 12:30, Marek Vasut wrote:
>>>>>>> On 2/22/22 16:49, Dinh Nguyen wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/21/22 11:05, Marek Vasut wrote:
>>>>>>>>> On 2/21/22 17:38, Dinh Nguyen wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2/20/22 22:32, Marek Vasut wrote:
>>>>>>>>>>> On SoCFPGA Gen5, DAC memcpy_fromio() in 
>>>>>>>>>>> cqspi_direct_read_execute()
>>>>>>>>>>> leads to data abort, disable DAC to avoid triggering it:
>>>>>>>>>>>
>>>>>>>>>>> Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
>>>>>>>>>>> [0400d3e9] *pgd=00000000
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>>>>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>>>>>>>>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>>>>>>>>>> ---
>>>>>>>>>>>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>>>>>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/spi/spi-cadence-quadspi.c 
>>>>>>>>>>> b/drivers/spi/spi-cadence-quadspi.c
>>>>>>>>>>> index b808c94641fa6..65f2c2449be09 100644
>>>>>>>>>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>>>>>>>>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>>>>>>>>>> @@ -1870,7 +1870,7 @@ static const struct 
>>>>>>>>>>> cqspi_driver_platdata intel_lgm_qspi = {
>>>>>>>>>>>   };
>>>>>>>>>>>   static const struct cqspi_driver_platdata socfpga_qspi = {
>>>>>>>>>>> -    .quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>>>>>>>> +    .quirks = CQSPI_DISABLE_DAC_MODE | 
>>>>>>>>>>> CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>>>>>>>>   };
>>>>>>>>>>>   static const struct cqspi_driver_platdata versal_ospi = {
>>>>>>>>>>
>>>>>>>>>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>>>>>>>>>
>>>>>>>>> Is this DAC really not working on socfpga gen5 or is there some 
>>>>>>>>> other issue ?
>>>>>>>>
>>>>>>>> I don't know the answer to this question. What is the DAC in the 
>>>>>>>> QSPI module and how do I go about testing it?
>>>>>>>
>>>>>>> DAC = direct access.
>>>>>>>
>>>>>>> How do you go about testing this -- compile kernel with/without 
>>>>>>> this patch, boot on SoCFPGA Gen5 with QSPI NOR attached, the 
>>>>>>> kernel crashes without this patch on imprecise external abort.
>>>>>>
>>>>>> Hmm...I just tested v5.17-rc3 on a C5 board and QSPI looks to be 
>>>>>> working fine:
>>>>>>
>>>>>> [    1.744489] spi-nor spi1.0: found n25q512ax3, expected mt25qu02g
>>>>>> [    1.750534] dma-pl330 ffe01000.pdma: Reset Channel-0  CS-f 
>>>>>> FTC-40000
>>>>>> [    1.756941] spi-nor spi1.0: n25q512ax3 (65536 Kbytes)
>>>>>> [    1.762369] 2 fixed-partitions partitions found on MTD device 
>>>>>> ff705000.spi.0
>>>>>> [    1.769425] Creating 2 MTD partitions on "ff705000.spi.0":
>>>>>> [    1.774925] 0x000000000000-0x000000800000 : "Flash 0 Raw Data"
>>>>>> [    1.781942] 0x000000800000-0x000008000000 : "Flash 0 jffs2 
>>>>>> Filesystem"
>>>>>> [    1.788468] mtd: partition "Flash 0 jffs2 Filesystem" extends 
>>>>>> beyond the end of device "ff705000.spi.0" -- size truncated to 
>>>>>> 0x3800000
>>>>>
>>>>> I wonder if we might be missing some clock enable somewhere.
>>>>>
>>>>> Can you mail me the whole boot log ? (I'm using u-boot 2022.01 btw.)
>>>>
>>>> I tested with U-Boot 2022.01 as well:
>>>>
>>>>
>>>> => run nfsboot_dinh
>>>> Kernel image @ 0x1000000 [ 0x000000 - 0x54edd0 ]
>>>> ## Flattened Device Tree blob at 02000000
>>>>     Booting using the fdt blob at 0x2000000
>>>>     Loading Device Tree to 09ff8000, end 09fffeb1 ... OK
>>>>
>>>> Starting kernel ...
>>>>
>>>> Deasserting all peripheral resets
>>>> [    0.000000] Booting Linux on physical CPU 0x0
>>>> [    0.000000] Linux version 5.17.0-rc3 (dinguyen@linux-builds1) 
>>>> (arm-linux-gnue abihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 
>>>> 7.5.0, GNU ld (GNU Binutils for U buntu) 2.30) #1 SMP Wed Feb 23 
>>>> 08:51:18 CST 2022
>>>> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), 
>>>> cr=10c5387d
>>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT 
>>>> aliasing instructio n cache
>>>> [    0.000000] OF: fdt: Machine model: Altera SOCFPGA Cyclone V SoC 
>>>> Development  Kit
>>>> [    0.000000] Memory policy: Data cache writealloc
>>>
>>> This is weird.
>>>
>>> One more thing, I have two SPI NORs on this CQSPI, one on each chip 
>>> select, do you think that can make any difference ?
>>>
>>> Besides that, I used latest next for my tests, not latest linus tree.
>>
>> Let me test on latest next.
> 
> Thank you
> 
> If you cannot reproduce it there, drop this patch and I'll revisit this 
> on my side.

Hmm...it doesn't look like the same error, but I'm getting this on the 
-next. I disable QSPI and the error still shows up. I'll dig more into it.

[    1.685301] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
5.17.0-rc5-next-20220222 #3
[    1.692771] Hardware name: Altera SOCFPGA
[    1.696771] Backtrace:
[    1.699217]  dump_backtrace from show_stack+0x20/0x24
[    1.704277]  r7:c0d03cc8 r6:c05fb6dc r5:c0b1d644 r4:60000093
[    1.709919]  show_stack from dump_stack_lvl+0x48/0x54
[    1.714965]  dump_stack_lvl from dump_stack+0x18/0x1c
[    1.720009]  r5:c1020600 r4:c0dc0b98
[    1.723573]  dump_stack from check_flush_dependency+0x1d4/0x1d8
[    1.729483]  check_flush_dependency from __flush_work+0x88/0x268
[    1.735481]  r7:c0d03cc8 r6:c0d82520 r5:c1020800 r4:c0dc0b98
[    1.741122]  __flush_work from flush_work+0x1c/0x20
[    1.745996]  r8:c1178000 r7:00000000 r6:c05fbd2c r5:00000001 r4:c0ddb72c
[    1.752674]  flush_work from deferred_probe_initcall+0x58/0xb8
[    1.758508]  deferred_probe_initcall from do_one_initcall+0x58/0x218
[    1.764860]  r5:c0db1ea0 r4:c0d03cc8
[    1.768426]  do_one_initcall from kernel_init_freeable+0x250/0x298
[    1.774602]  r8:c10e0d00 r7:00000008 r6:c0c47838 r5:c0c741a8 r4:c0bd1920
[    1.781281]  kernel_init_freeable from kernel_init+0x24/0x148
[    1.787023]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c0951e84
[    1.794828]  r4:00003cc0
[    1.797356]  kernel_init from ret_from_fork+0x14/0x2c
[    1.802401] Exception stack(0xf0831fb0 to 0xf0831ff8)
[    1.807441] 1fa0:                                     00000000 
00000000 00000000 00000000
[    1.815595] 1fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[    1.823748] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.830342]  r5:c0951e84 r4:00000000
[    1.834751] at24 0-0051: supply vcc not found, using dummy regulator
[    1.842334] at24 0-0051: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
[    1.854814] rtc-ds1307 0-0068: registered as rtc0
[    1.861327] rtc-ds1307 0-0068: setting system clock to 
2018-03-17T07:37:25 UTC (1521272245)
[    1.874183] dma-pl330 ffe01000.pdma: Loaded driver for PL330 DMAC-341330
[    1.880887] dma-pl330 ffe01000.pdma:         DBUFF-512x8bytes 
Num_Chans-8 Num_Peri-32 Num_Events-8
