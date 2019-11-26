Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4238F10A45F
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 20:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZTOH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 14:14:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:18143 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZTOG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 Nov 2019 14:14:06 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Mtqc4nDHz9tyXs;
        Tue, 26 Nov 2019 20:14:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=MiKDi6ZV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YX6lbbh28dRE; Tue, 26 Nov 2019 20:14:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Mtqc3jlHz9tyXr;
        Tue, 26 Nov 2019 20:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574795644; bh=Ijcw3pvg5psK0rGxWduWlimvVdapFLVf3vHTDOptaCc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MiKDi6ZVATMvVqnzNHjF7xupc/tnARgdDhcQ+4yiJIP6lJ5EGhxoHWEwAFm0MDHQr
         LVvkgIoNTXPH81Hb3bHW49LiLt0yOQjoux4k4nqoVQa24GUQy7UwhNCj7vKTBLQQ8A
         6+0945AilY30fwWYrKhk6yQ7zXlYIs7Ai/ccOu8c=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C5538B825;
        Tue, 26 Nov 2019 20:14:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iuhUsIswUO4F; Tue, 26 Nov 2019 20:14:04 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9CEC8B81A;
        Tue, 26 Nov 2019 20:14:03 +0100 (CET)
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
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
Date:   Tue, 26 Nov 2019 20:14:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 26/11/2019 à 20:08, Christophe Leroy a écrit :
> 
> 
> Le 26/11/2019 à 16:48, Linus Walleij a écrit :
>> Hi Christophe,
>>
>> sorry for forgetting about this :(
>>
>> On Fri, Nov 8, 2019 at 2:34 PM Christophe Leroy 
>> <christophe.leroy@c-s.fr> wrote:
>>
>>> With the two above changes, I get:
>>> [    3.143014] fsl_spi ff000a80.spi: bail out with error code -22
>>> [    3.148879] ------------[ cut here ]------------
>>> [    3.153261] remove_proc_entry: removing non-empty directory 'irq/43',
>>> leaking at least 'fsl_spi'
>>> [    3.162473] WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:684
>>> remove_proc_entry+0x1a0/0x1c8
>>
>> So that is another bug again. (Tearing down IRQs is erroneous
>> in some way.)
>>
>> The problem is the first -22 (-EINVAL)
>>
>> Which comes from of_fsl_spi_probe() IIUC.
>>
>> Can you try the following? I'm sorry if gmail mangles the
>> patches, I put a copy here:
>> https://dflund.se/~triad/fsldebug.diff
> 
> I get the following
> 
> [    3.159953] fsl_spi ff000a80.spi: devm_spi_register_master() failed
> [    3.166154] fsl_spi ff000a80.spi: exiting fsl_spi_probe() with error
> [    3.172194] fsl_spi ff000a80.spi: fsl_spi_probe() failed
> [    3.177670] ------------[ cut here ]------------
> [    3.181991] remove_proc_entry: removing non-empty directory 'irq/43', 
> leaking at least 'fsl_spi'
> [    3.191209] WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:684 
> remove_proc_entry+0x1a0/0x1c8
> [    3.199139] CPU: 0 PID: 1 Comm: swapper Not tainted 
> 5.4.0-s3k-dev-00898-gd57c00e2472d-dirty #2499
> [    3.207890] NIP:  c017eb74 LR: c017eb74 CTR: c0047584
> [    3.212892] REGS: c60e1c20 TRAP: 0700   Not tainted 
> (5.4.0-s3k-dev-00898-gd57c00e2472d-dirty)
> [    3.221385] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22008222  XER: 00000000
> [    3.228011]
> [    3.228011] GPR00: c017eb74 c60e1cd8 c60d4000 00000054 00000000 
> 00000000 0000cf08 00000010
> [    3.228011] GPR08: c0779030 00000800 00000000 00001032 22000408 
> 00000000 c0003890 00000000
> [    3.228011] GPR16: 00000000 00000000 00000000 00000000 00000000 
> 00000000 c0800000 0000009e
> [    3.228011] GPR24: c0856778 c6211c50 ffffffea c077d3b8 00000001 
> c60d3863 c60d08e3 c60d3800
> [    3.262659] NIP [c017eb74] remove_proc_entry+0x1a0/0x1c8
> [    3.267905] LR [c017eb74] remove_proc_entry+0x1a0/0x1c8
> [    3.273021] Call Trace:
> [    3.275478] [c60e1cd8] [c017eb74] remove_proc_entry+0x1a0/0x1c8 
> (unreliable)
> [    3.282466] [c60e1d08] [c005d17c] unregister_irq_proc+0x5c/0x70
> [    3.288292] [c60e1d28] [c00551f0] free_desc+0x4c/0x90
> [    3.293285] [c60e1d48] [c0055458] irq_free_descs+0x70/0xa8
> [    3.298709] [c60e1d68] [c030eb90] of_fsl_spi_probe+0xc0/0x418
> [    3.304388] [c60e1db8] [c02c4e94] platform_drv_probe+0x44/0xa4
> [    3.310181] [c60e1dc8] [c02c3038] really_probe+0x1ac/0x418
> [    3.315588] [c60e1df8] [c02c3ab8] device_driver_attach+0x88/0x90
> [    3.321524] [c60e1e18] [c02c3b60] __driver_attach+0xa0/0x154
> [    3.327115] [c60e1e38] [c02c1098] bus_for_each_dev+0x64/0xb4
> [    3.332709] [c60e1e68] [c02c1a74] bus_add_driver+0xe0/0x218
> [    3.338222] [c60e1e88] [c02c4318] driver_register+0x84/0x148
> [    3.343815] [c60e1e98] [c06d8d30] do_one_initcall+0x8c/0x1cc
> [    3.349401] [c60e1ef8] [c06d8fac] kernel_init_freeable+0x13c/0x1ec
> [    3.355509] [c60e1f28] [c00038a4] kernel_init+0x14/0x110
> [    3.360763] [c60e1f38] [c000e1cc] ret_from_kernel_thread+0x14/0x1c
> [    3.366825] Instruction dump:
> [    3.369760] 2c030000 4182004c 3863ffb0 3c80c05a 80e3005c 388477d0 
> 3c60c068 7fa6eb78
> [    3.377417] 7fc5f378 38840280 386336d4 4be9e5a9 <0fe00000> 4bffff7c 
> 3c60c06c 7fc4f378
> [    3.385277] ---[ end trace 25f4e57540579d18 ]---
> [    3.390369] fsl_spi: probe of ff000a80.spi failed with error -22
> 
> Digging a bit further, I see that devm_spi_register_master() fails in 
> spi_register_controler() because ctlr->num_chipselect is 0

Note that I still have the following definition in the device tree:
				gpios = <&CPM1_PIO_C 4 1	/* SICOFI 1 */
					 &CPM1_PIO_B 23 1	/* TEMP MCR */
					 &CPM1_PIO_C 8 1	/* SICOFI 2 */
					 &CPM1_PIO_C 12 1	/* EEPROM MIAE */
					 &CPM1_PIO_D 6 1	/* SICOFI 3 */
					 &CPM1_PIO_B 14 1	/* TEMP MPC885 */
					 &CPM1_PIO_B 21 1	/* EEPROM CMPC885 */
					 &FAV_CS_SPI 0 1	/* FAV SPI */
					 &FAV_CS_SPI 2 1>;	/* FAV POSTE FPGA */

I understood from the commit log that it's not needed to change it to 
cs-gpios.

Christophe
