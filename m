Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D210AF3C
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 13:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfK0MFG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 07:05:06 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4293 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfK0MFG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 07:05:06 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NKG71c7jz9tyv7;
        Wed, 27 Nov 2019 13:05:03 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=kMFsqVvn; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xJiDQkskHK5t; Wed, 27 Nov 2019 13:05:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NKG665dhz9tyfW;
        Wed, 27 Nov 2019 13:05:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574856302; bh=cNEO3AfbCBZ1k3I1cXMeAMr7IKJaF85SNYuNfFqaRdw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kMFsqVvnpixSht9Cmvn4ch/stxRgdBREwUAEQkUDAq4XFwcOBI6gG2YVpR+LiEqyn
         06iMBduHn9EYidEhtrm7xgkZdnwU+Z77IQzOKbhjKB0MV3XGT6pbL/O2rzDBfyPEgQ
         T+8lppSh8O3v1EokIiFCtxEcdtqMR8WO2VqYvGRU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D2218B857;
        Wed, 27 Nov 2019 13:05:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Lxt68zDd1QW8; Wed, 27 Nov 2019 13:05:03 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 89FD08B856;
        Wed, 27 Nov 2019 13:05:03 +0100 (CET)
Subject: Re: [PATCH] gpio: Handle counting of Freescale chipselects
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <20191127094031.140736-1-linus.walleij@linaro.org>
 <bcfa8e29-7adf-8a14-43e8-8e1d73df33bc@c-s.fr>
 <4eed765b-57af-87a0-f713-de1e6bee3d4b@c-s.fr>
 <9c202a84-16c9-1293-a6a8-674de674d31d@c-s.fr>
 <CACRpkdYVwV8F0-pp2S4CcSQnDZ00KBvZx2zuTmsFMPUP4cT+yA@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d7bde5a5-fdb6-5b31-7a7a-d4e515962aad@c-s.fr>
Date:   Wed, 27 Nov 2019 13:05:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdYVwV8F0-pp2S4CcSQnDZ00KBvZx2zuTmsFMPUP4cT+yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 27/11/2019 à 11:59, Linus Walleij a écrit :
> On Wed, Nov 27, 2019 at 11:25 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> Le 27/11/2019 à 11:15, Christophe Leroy a écrit :
>>> Le 27/11/2019 à 11:07, Christophe Leroy a écrit :
>>>> Le 27/11/2019 à 10:40, Linus Walleij a écrit :
>>>>> We have a special quirk to handle the Freescale
>>>>> nonstandard SPI chipselect GPIOs in the gpiolib-of.c
>>>>> file, but it currently only handles the case where
>>>>> the GPIOs are actually requested (gpiod_*get()).
>>>>>
>>>>> We also need to handle that the SPI core attempts
>>>>> to count the GPIOs before use, and that needs a
>>>>> similar quirk in the OF part of the library.
>>>>>
>>>>> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>> Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
>>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>>
>>>> Still getting:
>>>>
>>>> [    3.374867] fsl_spi: probe of ff000a80.spi failed with error -22
>>>
>>> Indeed,  of_spi_get_gpio_numbers() uses of_gpio_named_count(np,
>>> "cs-gpios") which still returns 0;
>>
>> Replacing by of_gpio_named_count(np, "gpios"); , I get further down to
>> the same spi_fsl_setup() warning as when renaming the property in the DTS.
> 
> Ah, I got bitten by recursion, sorry.
> 
> OK I changed to to "gpios" in my patch too, it's the right way.
> 
> Now we need to find the final culprit that makes it not even work when
> renaming to "cs-gpios"...
> 

Now that I have added master->use_gpio_descriptors = true; to the fsl 
driver, this patch crashes:

[    3.156848] BUG: Kernel NULL pointer dereference on read at 0x00000000
[    3.163062] Faulting instruction address: 0xc058aadc
[    3.167982] Oops: Kernel access of bad area, sig: 11 [#1]
[    3.173322] BE PAGE_SIZE=16K PREEMPT CMPC885
[    3.177559] CPU: 0 PID: 1 Comm: swapper Not tainted 
5.4.0-s3k-dev-00899-g749f15aba2c9-dirty #2515
[    3.186306] NIP:  c058aadc LR: c028973c CTR: 00000000
[    3.191308] REGS: c60e1b70 TRAP: 0300   Not tainted 
(5.4.0-s3k-dev-00899-g749f15aba2c9-dirty)
[    3.199801] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 24000224  XER: 20000000
[    3.206433] DAR: 00000000 DSISR: c0000000
[    3.206433] GPR00: c028963c c60e1c28 c60d4000 ffffffff c06b512b 
00000000 00000020 c0facf33
[    3.206433] GPR08: c0609438 00000000 00000000 000affff 24000224 
00000000 c0003890 00000000
[    3.206433] GPR16: 00000000 00000000 00000000 00000000 00000000 
00000000 c0800000 0000009e
[    3.206433] GPR24: c0856778 c06b512c c61f2210 c624fc00 c0857380 
00000000 00000000 c624fc00
[    3.243756] NIP [c058aadc] strcmp+0x10/0x40
[    3.247867] LR [c028973c] of_gpio_spi_cs_get_count+0x28/0x98
[    3.253416] Call Trace:
[    3.255881] [c60e1c28] [c034b920] 
__of_device_is_compatible+0xe4/0x14c (unreliable)
[    3.263437] [c60e1c38] [c028963c] of_gpio_get_count+0x24/0xfc
[    3.269116] [c60e1c88] [c028963c] of_gpio_get_count+0x24/0xfc
[    3.274831] [c60e1cd8] [c0286c1c] gpiod_count+0x34/0x100
[    3.280089] [c60e1cf8] [c030c5c0] spi_register_controller+0x14c/0xb50
[    3.286432] [c60e1d48] [c030d004] devm_spi_register_controller+0x40/0x98
[    3.293047] [c60e1d68] [c030ee60] of_fsl_spi_probe+0x2e8/0x3a8
[    3.298813] [c60e1db8] [c02c4f3c] platform_drv_probe+0x44/0xa4
[    3.304598] [c60e1dc8] [c02c30e0] really_probe+0x1ac/0x418
[    3.310012] [c60e1df8] [c02c3b60] device_driver_attach+0x88/0x90
[    3.315948] [c60e1e18] [c02c3c08] __driver_attach+0xa0/0x154
[    3.321540] [c60e1e38] [c02c1140] bus_for_each_dev+0x64/0xb4
[    3.327134] [c60e1e68] [c02c1b1c] bus_add_driver+0xe0/0x218
[    3.332646] [c60e1e88] [c02c43c0] driver_register+0x84/0x148
[    3.338239] [c60e1e98] [c06d8d30] do_one_initcall+0x8c/0x1cc
[    3.343824] [c60e1ef8] [c06d8fac] kernel_init_freeable+0x13c/0x1ec
[    3.349932] [c60e1f28] [c00038a4] kernel_init+0x14/0x110
[    3.355187] [c60e1f38] [c000e1cc] ret_from_kernel_thread+0x14/0x1c
[    3.361249] Instruction dump:
[    3.364183] 39200000 7d3fe9ae 7f43d378 80010024 bb410008 7c0803a6 
38210020 4e800020
[    3.371841] 3863ffff 3884ffff 48000008 41960024 <8d230001> 8d440001 
2e890000 7f895040
[    3.379710] ---[ end trace 795d948bc094d09f ]---

Christophe
