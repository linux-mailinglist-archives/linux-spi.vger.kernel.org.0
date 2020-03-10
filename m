Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB517F1FC
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 09:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCJIee (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 04:34:34 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36797 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJIed (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 04:34:33 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D43A62250D;
        Tue, 10 Mar 2020 09:34:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583829271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgowaNrAOxwomK5gTiZmCbMPjVXrLv/qrl77BGvAIBE=;
        b=pOpPuAYAuk3VaFwt7R7J76lNNIUmXSp/pKp2tNafADDnQEZoZhnwrSNjmXrrABiHMwQ8xe
        x0tAyesUvr+tEm/0c81mWDqqggamr04MMWvwsAHQTqqmcqATNVV3xyxDBKKWrWjDA7jdz7
        FvqaOx3SQokKl6Uh/FKzPZggOxUvI4M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Mar 2020 09:34:30 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, eha@deif.com, angelo@sysam.it,
        andrew.smirnov@gmail.com, gustavo@embeddedor.com, weic@nvidia.com,
        mhosny@nvidia.com, peng.ma@nxp.com
Subject: Re: [PATCH v2 0/6] NXP DSPI bugfixes and support for LS1028A
In-Reply-To: <20200309210755.6759-1-olteanv@gmail.com>
References: <20200309210755.6759-1-olteanv@gmail.com>
Message-ID: <2194d93de3870940148de58606dcb6ef@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: D43A62250D
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.501];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-03-09 22:07, schrieb Vladimir Oltean:
> This series addresses a few issues that were missed during the previous
> series "[PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver", on
> SoCs other than LS1021A and LS1043A. DMA mode has been completely 
> broken
> by that series, and XSPI mode never worked on little-endian 
> controllers.
> 
> Then it introduces support for the LS1028A chip, whose compatible has
> recently been documented here:
> 
> https://lore.kernel.org/linux-devicetree/20200218171418.18297-1-michael@walle.cc/
> 
> The device tree for the LS1028A SoC is extended with DMA channels
> definition, such that even though the default operating mode is XSPI,
> one can simply change DSPI_XSPI_MODE to DSPI_DMA_MODE in the
> devtype_data structure of the driver and use that instead.
> 
> For testing, benchmarking and debugging, the mikroBUS connector on the
> LS1028A-RDB is made available via spidev.



Let me start with the positive things... something is working, both in
XSPI mode and DMA mode ;) At least the SPI flash is detected.

And please note, that I have my patch applied:
   https://lore.kernel.org/lkml/20200310073313.21277-1-michael@walle.cc/

Further note, that the mtd device is either mtd0 in XSPI mode or mtd10
in DMA mode, because the first probe fails due to EPROBE_DEFER.

So starting with XSPI, if you have a big flash and cancel the readout
strange things happen.

# hexdump -C /dev/mtd0
00000000  00 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|.uhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
^C[   35.487948] fsl-dspi 2120000.spi: Waiting for transfer to complete 
failed!
[   35.495038] spi_master spi2: failed to transfer one message from 
queue

# hexdump -C /dev/mtd0
00000000  00 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff  
|.uhu............|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
^C[   38.495955] fsl-dspi 2120000.spi: Waiting for transfer to complete 
failed!
[   38.503097] spi_master spi2: failed to transfer one message from 
queue
[   38.509729] Unable to handle kernel paging request at virtual address 
ffff800095ab3377
[   38.517676] Mem abort info:
[   38.520474]   ESR = 0x96000045
[   38.523533]   EC = 0x25: DABT (current EL), IL = 32 bits
[   38.528861]   SET = 0, FnV = 0
[   38.531921]   EA = 0, S1PTW = 0
[   38.535067] Data abort info:
[   38.537952]   ISV = 0, ISS = 0x00000045
[   38.541797]   CM = 0, WnR = 1
[   38.544771] swapper pgtable: 4k pages, 48-bit VAs, 
pgdp=0000000082621000
[   38.551494] [ffff800095ab3377] pgd=00000020fffff003, 
p4d=00000020fffff003, pud=0000000000000000
[   38.560229] Internal error: Oops: 96000045 [#1] PREEMPT SMP
[   38.565819] Modules linked in:
[   38.568882] CPU: 0 PID: 2729 Comm: hexdump Not tainted 
5.6.0-rc4-next-20200306-00052-gd8730cdc8a0b-dirty #193
[   38.578834] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC 
Eval 2.0 carrier (DT)
[   38.587129] pstate: 20000085 (nzCv daIf -PAN -UAO)
[   38.591941] pc : ktime_get_real_ts64+0x3c/0x110
[   38.596487] lr : spi_take_timestamp_pre+0x40/0x90
[   38.601203] sp : ffff800010003d90
[   38.604525] x29: ffff800010003d90 x28: ffff80001200e000
[   38.609854] x27: ffff800011da9000 x26: ffff002079c40400
[   38.615184] x25: ffff8000117fe018 x24: ffff800011daa1a0
[   38.620513] x23: ffff800015ab3860 x22: ffff800095ab3377
[   38.625841] x21: 000000000000146e x20: ffff8000120c3000
[   38.631170] x19: ffff0020795f6e80 x18: ffff800011da9948
[   38.636498] x17: 0000000000000000 x16: 0000000000000000
[   38.641826] x15: ffff800095ab3377 x14: 0720072007200720
[   38.647155] x13: 0720072007200765 x12: 0775076507750771
[   38.652483] x11: 0720076d076f0772 x10: 0000000000000040
[   38.657812] x9 : ffff8000108e2100 x8 : ffff800011dcabe8
[   38.663139] x7 : 0000000000000000 x6 : ffff800015ab3a60
[   38.668468] x5 : 0000000007200720 x4 : ffff800095ab3377
[   38.673796] x3 : 0000000000000000 x2 : 0000000000000ab0
[   38.679125] x1 : ffff800011daa000 x0 : 0000000000000026
[   38.684454] Call trace:
[   38.686905]  ktime_get_real_ts64+0x3c/0x110
[   38.691100]  spi_take_timestamp_pre+0x40/0x90
[   38.695470]  dspi_fifo_write+0x58/0x2c0
[   38.699315]  dspi_interrupt+0xbc/0xd0
[   38.702987]  __handle_irq_event_percpu+0x78/0x2c0
[   38.707706]  handle_irq_event_percpu+0x3c/0x90
[   38.712161]  handle_irq_event+0x4c/0xd0
[   38.716008]  handle_fasteoi_irq+0xbc/0x170
[   38.720115]  generic_handle_irq+0x2c/0x40
[   38.724135]  __handle_domain_irq+0x68/0xc0
[   38.728243]  gic_handle_irq+0xc8/0x160
[   38.732000]  el1_irq+0xb8/0x180
[   38.735149]  spi_nor_spimem_read_data+0xe0/0x140
[   38.739779]  spi_nor_read+0xc4/0x120
[   38.743364]  mtd_read_oob+0xa8/0xc0
[   38.746860]  mtd_read+0x4c/0x80
[   38.750007]  mtdchar_read+0x108/0x2a0
[   38.753679]  __vfs_read+0x20/0x50
[   38.757002]  vfs_read+0xa4/0x190
[   38.760237]  ksys_read+0x6c/0xf0
[   38.763471]  __arm64_sys_read+0x20/0x30
[   38.767319]  el0_svc_common.constprop.3+0x90/0x160
[   38.772125]  do_el0_svc+0x28/0x90
[   38.775449]  el0_sync_handler+0x118/0x190
[   38.779468]  el0_sync+0x140/0x180
[   38.782793] Code: 91000294 1400000f d50339bf f9405e80 (f90002c0)
[   38.788910] ---[ end trace 55da560db4d6bef7 ]---
[   38.793540] Kernel panic - not syncing: Fatal exception in interrupt
[   38.799914] SMP: stopping secondary CPUs
[   38.803849] Kernel Offset: disabled
[   38.807344] CPU features: 0x10002,20006008
[   38.811451] Memory Limit: none
[   38.814513] ---[ end Kernel panic - not syncing: Fatal exception in 
interrupt ]---



In DMA mode one byte writes seem to work. But at least 5 byte writes do 
not:

# echo -ne '\x00' > /dev/mtd10
# echo 'huhu' > /dev/mtd10
[   34.275383] fsl-dspi 2120000.spi: DMA tx timeout
[   34.280035] fsl-dspi 2120000.spi: DMA transfer failed
[   34.285116] fsl-dspi 2120000.spi: Waiting for transfer to complete 
failed!
[   34.292029] spi_master spi2: failed to transfer one message from 
queue
sh: write error: Connection timed out
#

Vladimir, what kind of SPI device do you have to test?

-michael



> 
> Vladimir Oltean (6):
>   spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
>   spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
>   spi: spi-fsl-dspi: Fix oper_word_size of zero for DMA mode
>   spi: spi-fsl-dspi: Add support for LS1028A
>   arm64: dts: ls1028a: Specify the DMA channels for the DSPI 
> controllers
>   arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS
> 
>  .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 14 ++++++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  6 +++
>  drivers/spi/spi-fsl-dspi.c                    | 50 +++++++++++++++----
>  3 files changed, 60 insertions(+), 10 deletions(-)
