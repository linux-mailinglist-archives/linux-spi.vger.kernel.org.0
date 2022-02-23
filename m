Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D755C4C18E9
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiBWQnt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiBWQns (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 11:43:48 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F141D6E79E
        for <linux-spi@vger.kernel.org>; Wed, 23 Feb 2022 08:43:19 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5161783C36;
        Wed, 23 Feb 2022 17:43:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1645634597;
        bh=MawM/4e8iSzEE+0rNgqNyzrs1x3MY2eqQmxHCRdrFvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pdR63KUJ9lejaWECow3xEicjDRq5mlrnFAlgChUoEB+wlTZPs5sUCb5CLhhlHjM6j
         3J+vYlPUsDL50Q+b4hbOsx1NWlyNM+Yuac4uELQQPYlQpnNhPEr5X9L0n0sEA+Uesm
         2x6UzU3NoVIDW3vvhZx3V4GPA4ckCDotQ6RDjNQjU3Gi7kuJG897aPNEn1OpmWtJbd
         TikjrtBZdUlfd8fACVJ5wzILP90gnMsHhQe7+lexCdt01YbFDLvklZ1Q8D5Sg81Ib/
         /L/AQvMLSKYdCOQ4OCxm8lnGmHUzxGGu07G4GB9tUsmn6fpVuiSRHkBVn+6z66PSuT
         /RME2qwAQ6QnQ==
Message-ID: <861ec3ba-65c5-d4e9-d1f4-9f7e5408f7cf@denx.de>
Date:   Wed, 23 Feb 2022 17:43:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] [RFC] spi: cadence-quadspi: Disable DAC on SoCFPGA
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-spi@vger.kernel.org
Cc:     Pratyush Yadav <p.yadav@ti.com>
References: <20220221043238.295369-1-marex@denx.de>
 <79280984-e71d-e767-bb67-bd2a2fe31858@kernel.org>
 <ccdc4738-0fb0-d3f6-5c56-d61eb8e8bf33@denx.de>
 <04e70d1a-c07b-e1dc-aea6-36fe9b7ce667@kernel.org>
 <8060ae0e-700e-3b72-3ab9-e7ca8e19ad9e@denx.de>
 <8dc7a7d6-d24f-b3a6-32b9-64cdb8c6f3be@kernel.org>
 <bbc84e6b-68ce-84cb-7bc2-3ac844ec3710@denx.de>
 <cd1e80f1-b12e-d8c4-e7f2-bfbc21ebf57c@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <cd1e80f1-b12e-d8c4-e7f2-bfbc21ebf57c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2/23/22 17:28, Dinh Nguyen wrote:
> 
> 
> On 2/22/22 18:54, Marek Vasut wrote:
>> On 2/22/22 22:32, Dinh Nguyen wrote:
>>>
>>>
>>> On 2/22/22 12:30, Marek Vasut wrote:
>>>> On 2/22/22 16:49, Dinh Nguyen wrote:
>>>>>
>>>>>
>>>>> On 2/21/22 11:05, Marek Vasut wrote:
>>>>>> On 2/21/22 17:38, Dinh Nguyen wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/20/22 22:32, Marek Vasut wrote:
>>>>>>>> On SoCFPGA Gen5, DAC memcpy_fromio() in cqspi_direct_read_execute()
>>>>>>>> leads to data abort, disable DAC to avoid triggering it:
>>>>>>>>
>>>>>>>> Unhandled fault: imprecise external abort (0x1406) at 0x0400d3e9
>>>>>>>> [0400d3e9] *pgd=00000000
>>>>>>>>
>>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>>>>>>>> Cc: Pratyush Yadav <p.yadav@ti.com>
>>>>>>>> ---
>>>>>>>>   drivers/spi/spi-cadence-quadspi.c | 2 +-
>>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/spi/spi-cadence-quadspi.c 
>>>>>>>> b/drivers/spi/spi-cadence-quadspi.c
>>>>>>>> index b808c94641fa6..65f2c2449be09 100644
>>>>>>>> --- a/drivers/spi/spi-cadence-quadspi.c
>>>>>>>> +++ b/drivers/spi/spi-cadence-quadspi.c
>>>>>>>> @@ -1870,7 +1870,7 @@ static const struct cqspi_driver_platdata 
>>>>>>>> intel_lgm_qspi = {
>>>>>>>>   };
>>>>>>>>   static const struct cqspi_driver_platdata socfpga_qspi = {
>>>>>>>> -    .quirks = CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>>>>> +    .quirks = CQSPI_DISABLE_DAC_MODE | 
>>>>>>>> CQSPI_NO_SUPPORT_WR_COMPLETION,
>>>>>>>>   };
>>>>>>>>   static const struct cqspi_driver_platdata versal_ospi = {
>>>>>>>
>>>>>>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>>>>>>
>>>>>> Is this DAC really not working on socfpga gen5 or is there some 
>>>>>> other issue ?
>>>>>
>>>>> I don't know the answer to this question. What is the DAC in the 
>>>>> QSPI module and how do I go about testing it?
>>>>
>>>> DAC = direct access.
>>>>
>>>> How do you go about testing this -- compile kernel with/without this 
>>>> patch, boot on SoCFPGA Gen5 with QSPI NOR attached, the kernel 
>>>> crashes without this patch on imprecise external abort.
>>>
>>> Hmm...I just tested v5.17-rc3 on a C5 board and QSPI looks to be 
>>> working fine:
>>>
>>> [    1.744489] spi-nor spi1.0: found n25q512ax3, expected mt25qu02g
>>> [    1.750534] dma-pl330 ffe01000.pdma: Reset Channel-0  CS-f FTC-40000
>>> [    1.756941] spi-nor spi1.0: n25q512ax3 (65536 Kbytes)
>>> [    1.762369] 2 fixed-partitions partitions found on MTD device 
>>> ff705000.spi.0
>>> [    1.769425] Creating 2 MTD partitions on "ff705000.spi.0":
>>> [    1.774925] 0x000000000000-0x000000800000 : "Flash 0 Raw Data"
>>> [    1.781942] 0x000000800000-0x000008000000 : "Flash 0 jffs2 
>>> Filesystem"
>>> [    1.788468] mtd: partition "Flash 0 jffs2 Filesystem" extends 
>>> beyond the end of device "ff705000.spi.0" -- size truncated to 0x3800000
>>
>> I wonder if we might be missing some clock enable somewhere.
>>
>> Can you mail me the whole boot log ? (I'm using u-boot 2022.01 btw.)
> 
> I tested with U-Boot 2022.01 as well:
> 
> 
> => run nfsboot_dinh
> Kernel image @ 0x1000000 [ 0x000000 - 0x54edd0 ]
> ## Flattened Device Tree blob at 02000000
>     Booting using the fdt blob at 0x2000000
>     Loading Device Tree to 09ff8000, end 09fffeb1 ... OK
> 
> Starting kernel ...
> 
> Deasserting all peripheral resets
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.17.0-rc3 (dinguyen@linux-builds1) 
> (arm-linux-gnue abihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0, 
> GNU ld (GNU Binutils for U buntu) 2.30) #1 SMP Wed Feb 23 08:51:18 CST 2022
> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), 
> cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
> instructio n cache
> [    0.000000] OF: fdt: Machine model: Altera SOCFPGA Cyclone V SoC 
> Development  Kit
> [    0.000000] Memory policy: Data cache writealloc

This is weird.

One more thing, I have two SPI NORs on this CQSPI, one on each chip 
select, do you think that can make any difference ?

Besides that, I used latest next for my tests, not latest linus tree.

Maybe I should try and find the CV devkit too and test on that.
