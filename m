Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F63F4B9C
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 13:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfKHMd3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 07:33:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:63888 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKHMd3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 Nov 2019 07:33:29 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 478fnd4tsQz9v066;
        Fri,  8 Nov 2019 13:33:25 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sE6Bq2V/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NuYfAD2WPHo5; Fri,  8 Nov 2019 13:33:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 478fnd3Dlgz9v065;
        Fri,  8 Nov 2019 13:33:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1573216405; bh=DUzyDjkNlu6NTTWx3ROxbYSoivv5dwGRo8C9PTMDH9w=;
        h=To:Cc:From:Subject:Date:From;
        b=sE6Bq2V/sx/WbyBH7zsYyUMfWUtHETQ012WH3DgDUp+cWU19haVNse10AbDIhPtrt
         EB33eSz01uoIqisdkqob9GxxnuDEAtNOhMSWKAzk1JelFSXKozOQCMrl9xmwPX+WUr
         Ue+Nf4DYFTaiw352qSQrGrHvHNQ4+9OMRyh+btHY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACAF08B8EB;
        Fri,  8 Nov 2019 13:33:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LIHSOPL0AM77; Fri,  8 Nov 2019 13:33:26 +0100 (CET)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 729538B75E;
        Fri,  8 Nov 2019 13:33:26 +0100 (CET)
To:     Linus Walleij <linus.walleij@linaro.org>, linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, linux-gpio@vger.kernel.org
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
Message-ID: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
Date:   Fri, 8 Nov 2019 13:33:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Linus,

With the above mentionned commit, I get a crash on boot:

[    3.146041] ------------[ cut here ]------------
[    3.150340] kernel BUG at lib/genalloc.c:516!
[    3.154649] Oops: Exception in kernel mode, sig: 5 [#1]
[    3.159821] BE PAGE_SIZE=16K PREEMPT CMPC885
[    3.164053] CPU: 0 PID: 1 Comm: swapper Not tainted 
5.4.0-rc5-s3k-dev-00785-gab26ba2f2775 #2471
[    3.172630] NIP:  c0249054 LR: c0249054 CTR: 00000000
[    3.177631] REGS: c60e1c50 TRAP: 0700   Not tainted 
(5.4.0-rc5-s3k-dev-00785-gab26ba2f2775)
[    3.185953] MSR:  00021032 <ME,IR,DR,RI>  CR: 24002422 XER: 20000000
[    3.192322]
[    3.192322] GPR00: c0249054 c60e1d08 c60d4000 c600c200 00009d80 
00000000 00000000 00000000
[    3.192322] GPR08: 00000000 00000000 00009bbf 000affff 24000422 
00000000 c0003890 00000000
[    3.192322] GPR16: 00000000 00000000 00000000 00000000 00000000 
00000000 c0800000 0000009e
[    3.192322] GPR24: c0852778 00000000 00000000 00000000 00000000 
c600c200 00009d80 c600c200
[    3.227053] NIP [c0249054] gen_pool_free_owner+0xfc/0x100
[    3.232377] LR [c0249054] gen_pool_free_owner+0xfc/0x100
[    3.237588] Call Trace:
[    3.240037] [c60e1d08] [c0249054] gen_pool_free_owner+0xfc/0x100 
(unreliable)
[    3.247113] [c60e1d38] [c0299020] cpm_muram_free+0x84/0xf4
[    3.252517] [c60e1d58] [c030e7a4] fsl_spi_cpm_free+0x94/0x100
[    3.258198] [c60e1d68] [c030f2d4] of_fsl_spi_probe+0x260/0x3a0
[    3.263965] [c60e1db8] [c02c5458] platform_drv_probe+0x44/0xa4
[    3.269754] [c60e1dc8] [c02c35fc] really_probe+0x1ac/0x418
[    3.275164] [c60e1df8] [c02c407c] device_driver_attach+0x88/0x90
[    3.281099] [c60e1e18] [c02c4124] __driver_attach+0xa0/0x154
[    3.286691] [c60e1e38] [c02c165c] bus_for_each_dev+0x64/0xb4
[    3.292284] [c60e1e68] [c02c2038] bus_add_driver+0xe0/0x218
[    3.297783] [c60e1e88] [c02c48dc] driver_register+0x84/0x148
[    3.303394] [c60e1e98] [c06d8d30] do_one_initcall+0x8c/0x1cc
[    3.308978] [c60e1ef8] [c06d8fac] kernel_init_freeable+0x13c/0x1ec
[    3.315087] [c60e1f28] [c00038a4] kernel_init+0x14/0x110
[    3.320342] [c60e1f38] [c000e1cc] ret_from_kernel_thread+0x14/0x1c
[    3.326401] Instruction dump:
[    3.329337] 40a2fff4 4192000c 813f0010 913a0000 80010034 81810010 
7c0803a6 bb210014
[    3.336994] 7d808120 38210030 4be1d7a8 4be1d7a5 <0fe00000> 7c0802a6 
9421ffe0 bf810010
[    3.344864] ---[ end trace 2200b36c5d6384b0 ]---
[    3.349380]
[    4.320994] note: swapper[1] exited with preempt_count 1
[    4.326187] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x00000005
[    4.333602] Rebooting in 180 seconds..

Reverting 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors") 
solves the issue.

Renaming the gpios item to cs-gpios in the devicetree fixes the crash on 
boot but the following warning appears during boot and SPI doesn't work 
(can't read board temperature on LM74 chip):

[    3.145635] ------------[ cut here ]------------
[    3.150048] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-fsl-spi.c:716 
fsl_spi_cs_control+0x64/0x7c
[    3.158715] CPU: 0 PID: 1 Comm: swapper Not tainted 
5.4.0-rc5-s3k-dev-00785-gab26ba2f2775 #2473
[    3.167296] NIP:  c030ee68 LR: c030ee3c CTR: c030ee04
[    3.172295] REGS: c60e1bd0 TRAP: 0700   Not tainted 
(5.4.0-rc5-s3k-dev-00785-gab26ba2f2775)
[    3.180618] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24004842  XER: 20000000
[    3.187246]
[    3.187246] GPR00: c030fbd4 c60e1c88 c60d4000 c6211c50 00000000 
00000000 07de2900 c61f2210
[    3.187246] GPR08: 00001208 c61f2210 00001200 000affff 24004848 
00000000 c0003890 00000000
[    3.187246] GPR16: 00000000 00000000 00000000 c7fdd478 c06aa8dc 
c06b0000 c06aa7f8 c06aa804
[    3.187246] GPR24: c06aa810 c06aa81c 00000000 c61f2210 c07b72fc 
00000000 c6244a40 00000000
[    3.221966] NIP [c030ee68] fsl_spi_cs_control+0x64/0x7c
[    3.227126] LR [c030ee3c] fsl_spi_cs_control+0x38/0x7c
[    3.232167] Call Trace:
[    3.234616] [c60e1c98] [c030fbd4] fsl_spi_setup+0xc4/0x148
[    3.240070] [c60e1cb8] [c030c45c] spi_setup+0xd0/0x1c4
[    3.245129] [c60e1cd8] [c030c5f4] spi_add_device+0xa4/0x190
[    3.250640] [c60e1cf8] [c030d0ec] spi_register_controller+0x75c/0xb50
[    3.257009] [c60e1d48] [c030d520] devm_spi_register_controller+0x40/0x98
[    3.263619] [c60e1d68] [c030f354] of_fsl_spi_probe+0x2e0/0x3a0
[    3.269388] [c60e1db8] [c02c5458] platform_drv_probe+0x44/0xa4
[    3.275178] [c60e1dc8] [c02c35fc] really_probe+0x1ac/0x418
[    3.280587] [c60e1df8] [c02c407c] device_driver_attach+0x88/0x90
[    3.286523] [c60e1e18] [c02c4124] __driver_attach+0xa0/0x154
[    3.292115] [c60e1e38] [c02c165c] bus_for_each_dev+0x64/0xb4
[    3.297708] [c60e1e68] [c02c2038] bus_add_driver+0xe0/0x218
[    3.303205] [c60e1e88] [c02c48dc] driver_register+0x84/0x148
[    3.308815] [c60e1e98] [c06d8d30] do_one_initcall+0x8c/0x1cc
[    3.314400] [c60e1ef8] [c06d8fac] kernel_init_freeable+0x13c/0x1ec
[    3.320508] [c60e1f28] [c00038a4] kernel_init+0x14/0x110
[    3.325762] [c60e1f38] [c000e1cc] ret_from_kernel_thread+0x14/0x1c
[    3.331824] Instruction dump:
[    3.334759] 4bfffab1 80830018 2f840000 419e0024 80010014 215f0000 
7c0803a6 83e1000c
[    3.342416] 7c631910 54630000 38210010 4bcffa84 <0fe00000> 80010014 
83e1000c 7c0803a6
[    3.350277] ---[ end trace 15d6993a62672e78 ]---


Any idea ?

Thanks,
Christophe
