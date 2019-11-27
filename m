Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC510ACA4
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfK0JeW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 04:34:22 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:6559 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfK0JeV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 04:34:21 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NFwB54Gsz9tyk7;
        Wed, 27 Nov 2019 10:34:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=MzHWiB4e; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kxtcHzhES2Nc; Wed, 27 Nov 2019 10:34:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NFwB3fd3z9tyk6;
        Wed, 27 Nov 2019 10:34:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574847258; bh=Ijx7EVMd4FP4E4rEqUhlrs1CeZFPTCha5knDxcS+EXA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MzHWiB4eJANudfYaDIrWkL0FwgsHL1vLN8yEoYxhZdsZCZK3bjARXou0v6bysgByj
         ohLQfMfu4c4uB1t8J6IXeGih/H1zz+2Yaw1TszW0QHwOsqez5Djx5db3fS5J6MIZy7
         3f3fjQdmvB5pd6YVE8GiI8vKmV/6LcXgdGPIcLzU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8B64A8B849;
        Wed, 27 Nov 2019 10:34:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bzg9ieKJpP6X; Wed, 27 Nov 2019 10:34:19 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BFEB8B848;
        Wed, 27 Nov 2019 10:34:18 +0100 (CET)
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
 <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr>
 <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr>
 <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr>
 <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr>
Date:   Wed, 27 Nov 2019 10:34:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 27/11/2019 à 10:11, Linus Walleij a écrit :
> On Wed, Nov 27, 2019 at 10:07 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> Le 27/11/2019 à 09:26, Linus Walleij a écrit :
> 
>>>         master->num_chipselect = pdata->max_chipselect;
>>
>> I confirm it can't be that .... here I get ngpios = 9
> 
> Ah yeah you're right.
> 
>>> But the new code in the core has this:
>>>
>>>       nb = gpiod_count(dev, "cs");
>>
>> However the above is likely the issue. The property in the DTS is
>> 'gpios' and not 'cs-gpios'. According to commit e3023bf80639 ("gpio: of:
>> Handle the Freescale SPI CS"), it shouldn't be needed to rename it, and
>> that's also what I understand from commit log of 0f0581b24bd0 ("spi:
>> fsl: Convert to use CS GPIO descriptors")
> 
> Yeah I see it now, the gpio_get* does use the extra quirks to find
> a node just named "gpios" but this gpiod_count doesn't work
> because that does not loop through the same quirk.

In the meantime, I have tried changing "gpios" by "cs-gpios" in the 
device tree, and I get the following warning:

[    3.152279] ------------[ cut here ]------------
[    3.156654] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-fsl-spi.c:716 
fsl_spi_cs_control+0x64/0x7c
[    3.165320] CPU: 0 PID: 1 Comm: swapper Not tainted 
5.4.0-s3k-dev-00898-gd57c00e2472d #2507
[    3.173557] NIP:  c030e8c4 LR: c030e898 CTR: c030e860
[    3.178558] REGS: c60e1bd0 TRAP: 0700   Not tainted 
(5.4.0-s3k-dev-00898-gd57c00e2472d)
[    3.186536] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24004842  XER: 20000000
[    3.193161]
[    3.193161] GPR00: c030f630 c60e1c88 c60d4000 c6211c50 00000000 
00000000 07de2900 c61f2210
[    3.193161] GPR08: 00001208 c61f2210 00001200 000affff 24004848 
00000000 c0003890 00000000
[    3.193161] GPR16: 00000000 00000000 00000000 c7ffd478 c06aabc4 
c06b0000 c06aaae0 c06aaaec
[    3.193161] GPR24: c06aaaf8 c06aab04 00000000 c61f2210 c07bb2dc 
00000000 c6244a40 00000000
[    3.227800] NIP [c030e8c4] fsl_spi_cs_control+0x64/0x7c
[    3.232963] LR [c030e898] fsl_spi_cs_control+0x38/0x7c
[    3.238000] Call Trace:
[    3.240450] [c60e1c98] [c030f630] fsl_spi_setup+0xc4/0x148
[    3.245903] [c60e1cb8] [c030be98] spi_setup+0xd0/0x1c4
[    3.250960] [c60e1cd8] [c030c030] spi_add_device+0xa4/0x190
[    3.256472] [c60e1cf8] [c030cb28] spi_register_controller+0x75c/0xb50
[    3.262840] [c60e1d48] [c030cf5c] devm_spi_register_controller+0x40/0x98
[    3.269452] [c60e1d68] [c030edb0] of_fsl_spi_probe+0x2e0/0x3a0
[    3.275220] [c60e1db8] [c02c4e94] platform_drv_probe+0x44/0xa4
[    3.281010] [c60e1dc8] [c02c3038] really_probe+0x1ac/0x418
[    3.286419] [c60e1df8] [c02c3ab8] device_driver_attach+0x88/0x90
[    3.292355] [c60e1e18] [c02c3b60] __driver_attach+0xa0/0x154
[    3.297947] [c60e1e38] [c02c1098] bus_for_each_dev+0x64/0xb4
[    3.303540] [c60e1e68] [c02c1a74] bus_add_driver+0xe0/0x218
[    3.309052] [c60e1e88] [c02c4318] driver_register+0x84/0x148
[    3.314649] [c60e1e98] [c06d8d30] do_one_initcall+0x8c/0x1cc
[    3.320232] [c60e1ef8] [c06d8fac] kernel_init_freeable+0x13c/0x1ec
[    3.326341] [c60e1f28] [c00038a4] kernel_init+0x14/0x110
[    3.331595] [c60e1f38] [c000e1cc] ret_from_kernel_thread+0x14/0x1c
[    3.337656] Instruction dump:
[    3.340590] 4bfffab1 80830018 2f840000 419e0024 80010014 215f0000 
7c0803a6 83e1000c
[    3.348246] 7c631910 54630000 38210010 4bd00028 <0fe00000> 80010014 
83e1000c 7c0803a6
[    3.356108] ---[ end trace 1b884d70796b2b85 ]---

And SPI doesn't work allthough it seems to get properly registered

Christophe
