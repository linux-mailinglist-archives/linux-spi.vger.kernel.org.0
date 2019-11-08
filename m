Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B49F4D4B
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 14:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfKHNfB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 08:35:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:62510 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfKHNfA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 Nov 2019 08:35:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 478h8d1Q4Hz9v0HG;
        Fri,  8 Nov 2019 14:34:57 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jSapM+t+; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iNayJmT6xcjq; Fri,  8 Nov 2019 14:34:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 478h8d0JGqz9v0H9;
        Fri,  8 Nov 2019 14:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1573220097; bh=gEhaMrjVRUM0LGtHQgacv5Ojnz6Y8PuZSHEk3kMCGlw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jSapM+t+RYApYF/4dTpmEo4AIpk/hfe8kSSMQWKvZspZMBoPmBF/ne8JKPY3d0zmZ
         LiRt8nqfa1Gu9L6iXS/Nuk3FWy0afpkj6xbgSDMS+QQWqj2p4vXBMQ88y+MYqMCy6N
         aT9kSBXYi/Z+Kbryg7Igjfv4tGMRjQc7N2MpJMmo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D1ED8B8EE;
        Fri,  8 Nov 2019 14:34:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nnNL3EAkWa2M; Fri,  8 Nov 2019 14:34:58 +0100 (CET)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42A548B75E;
        Fri,  8 Nov 2019 14:34:58 +0100 (CET)
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
 <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr>
Date:   Fri, 8 Nov 2019 14:34:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 08/11/2019 à 14:09, Linus Walleij a écrit :
> On Fri, Nov 8, 2019 at 1:33 PM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> [    3.227053] NIP [c0249054] gen_pool_free_owner+0xfc/0x100
>> [    3.232377] LR [c0249054] gen_pool_free_owner+0xfc/0x100
>> [    3.237588] Call Trace:
>> [    3.240037] [c60e1d08] [c0249054] gen_pool_free_owner+0xfc/0x100
>> (unreliable)
>> [    3.247113] [c60e1d38] [c0299020] cpm_muram_free+0x84/0xf4
>> [    3.252517] [c60e1d58] [c030e7a4] fsl_spi_cpm_free+0x94/0x100
>> [    3.258198] [c60e1d68] [c030f2d4] of_fsl_spi_probe+0x260/0x3a0
> 
> Since fsl_spi_cpm_free() is called from of_fsl_spi_probe() and doesn't
> even exist on the errorpath of this function I suppose it is some kind
> inlining of_fsl_spi_probe() which goes on the errorpath and
> crashes there. I suspect EPROBE_DEFER (-517) to be behind this
> but it is just a guess.
> 
> What happens if you add this:
> 
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index 4b80ace1d137..a26b5e542006 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -678,6 +678,7 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
>          return master;
> 
>   err_probe:
> +       dev_info(dev, "bail out with error code %d\n", ret);
>          fsl_spi_cpm_free(mpc8xxx_spi);
>   err_cpm_init:
>          spi_master_put(master);
> 
> I am assuming that the errorpath inside spi-fsl-cpm.c is crashing,
> as cpm_muram_free() is called under the wrong conditions,
> or simply not really working.
> 
> So fixing the errorpath is a separate problem in itself.
> 
> By just looking at the code and not understanding any more than
> that the error path on fsl_spi_cpm_free() should probably
> equal that of fsl_spi_cpm_init() I guess maybe this could
> fix it, could you test?
> 
> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
> index 858f0544289e..54ad0ac121e5 100644
> --- a/drivers/spi/spi-fsl-cpm.c
> +++ b/drivers/spi/spi-fsl-cpm.c
> @@ -392,7 +392,8 @@ void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi)
>          dma_unmap_single(dev, mspi->dma_dummy_rx, SPI_MRBLR, DMA_FROM_DEVICE);
>          dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
>          cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
> -       cpm_muram_free(cpm_muram_offset(mspi->pram));
> +       if (!(mspi->flags & SPI_CPM1))
> +               cpm_muram_free(cpm_muram_offset(mspi->pram));
>          fsl_spi_free_dummy_rx();
>   }
>   EXPORT_SYMBOL_GPL(fsl_spi_cpm_free);
> 
>> Reverting 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
>> solves the issue.
> 
> I hope we can fix the errorpath so we can see what the real problem
> is with this patch.

With the two above changes, I get:
[    3.143014] fsl_spi ff000a80.spi: bail out with error code -22
[    3.148879] ------------[ cut here ]------------
[    3.153261] remove_proc_entry: removing non-empty directory 'irq/43', 
leaking at least 'fsl_spi'
[    3.162473] WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:684 
remove_proc_entry+0x1a0/0x1c8
[    3.170324] CPU: 0 PID: 1 Comm: swapper Not tainted 
5.4.0-rc5-s3k-dev-00785-gab26ba2f2775-dirty #2475
[    3.179420] NIP:  c017f138 LR: c017f138 CTR: c0047d24
[    3.184421] REGS: c60e1c20 TRAP: 0700   Not tainted 
(5.4.0-rc5-s3k-dev-00785-gab26ba2f2775-dirty)
[    3.193259] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22008222  XER: 00000000
[    3.199885]
[    3.199885] GPR00: c017f138 c60e1cd8 c60d4000 00000054 00000000 
00000000 0000c350 00000010
[    3.199885] GPR08: c0775030 00000800 00000000 00001032 22000408 
00000000 c0003890 00000000
[    3.199885] GPR16: 00000000 00000000 00000000 00000000 00000000 
00000000 c0800000 0000009e
[    3.199885] GPR24: c0852778 c6211c50 c61f2210 c07793b8 00000001 
c60d3863 c60d08e3 c60d3800
[    3.234623] NIP [c017f138] remove_proc_entry+0x1a0/0x1c8
[    3.239861] LR [c017f138] remove_proc_entry+0x1a0/0x1c8
[    3.244979] Call Trace:
[    3.247435] [c60e1cd8] [c017f138] remove_proc_entry+0x1a0/0x1c8 
(unreliable)
[    3.254425] [c60e1d08] [c005d904] unregister_irq_proc+0x5c/0x70
[    3.260252] [c60e1d28] [c0055978] free_desc+0x4c/0x90
[    3.265245] [c60e1d48] [c0055be0] irq_free_descs+0x70/0xa8
[    3.270670] [c60e1d68] [c030f154] of_fsl_spi_probe+0xc0/0x3b4
[    3.276349] [c60e1db8] [c02c5458] platform_drv_probe+0x44/0xa4
[    3.282141] [c60e1dc8] [c02c35fc] really_probe+0x1ac/0x418
[    3.287547] [c60e1df8] [c02c407c] device_driver_attach+0x88/0x90
[    3.293484] [c60e1e18] [c02c4124] __driver_attach+0xa0/0x154
[    3.299076] [c60e1e38] [c02c165c] bus_for_each_dev+0x64/0xb4
[    3.304670] [c60e1e68] [c02c2038] bus_add_driver+0xe0/0x218
[    3.310166] [c60e1e88] [c02c48dc] driver_register+0x84/0x148
[    3.315776] [c60e1e98] [c06d8d30] do_one_initcall+0x8c/0x1cc
[    3.321362] [c60e1ef8] [c06d8fac] kernel_init_freeable+0x13c/0x1ec
[    3.327469] [c60e1f28] [c00038a4] kernel_init+0x14/0x110
[    3.332726] [c60e1f38] [c000e1cc] ret_from_kernel_thread+0x14/0x1c
[    3.338784] Instruction dump:
[    3.341720] 2c030000 4182004c 3863ffb0 3c80c05a 80e3005c 388477d0 
3c60c068 7fa6eb78
[    3.349377] 7fc5f378 38840280 386333e4 4be9e7a1 <0fe00000> 4bffff7c 
3c60c06c 7fc4f378
[    3.357237] ---[ end trace 722649f68cd7c34e ]---
[    3.362333] fsl_spi: probe of ff000a80.spi failed with error -22


Christophe

> 
>> Renaming the gpios item to cs-gpios in the devicetree fixes the crash on
>> boot but the following warning appears during boot and SPI doesn't work
>> (can't read board temperature on LM74 chip):
> 
> That's annoying. I hope we can get the code to work though,
> let's hammer on it a bit and see if we can fix it!
> 
> Yours,
> Linus Walleij
> 
