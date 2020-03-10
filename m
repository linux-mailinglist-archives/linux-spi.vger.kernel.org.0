Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1F17F987
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 13:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgCJM5f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 08:57:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42262 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729786AbgCJM5d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 08:57:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id n18so16170066edw.9;
        Tue, 10 Mar 2020 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edQJln2rlXXTVaF0edNz+jpvLZz39ARiGdZQH1VyL3A=;
        b=tX7FpqZn4vcdHsw7/gPw4be/CH1i69YxNWoX+VaKlYdu+N1TaZS9JEpkxaKBCRZfXe
         lPBaa+cUyw1cI3lvhXDl6AC02Ff2Hpfv9zbJajBF4ObzjKyYn44s8JK6fOSpxZviwOKl
         56vCJfuRXwtqskm+tzOb4lusi4CFZJBpbHgX4CzN/48x0kQVp2Nej7Re/n7ZiAXRhXFg
         RZ39XjoyF9W82PGWE+yew0XZ1vfHm/kdou/+0z+wDh/qCq+OtKRV28Sz0y8vA5U3DFkk
         agLjUSTDn48VpwozT0fz1vc+mt3TE1AhLyp+IsZnbOsNUSV0OAdc3gWsMr1pYlLQnB3N
         gLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edQJln2rlXXTVaF0edNz+jpvLZz39ARiGdZQH1VyL3A=;
        b=O9p5B0hTZKEduGTryCc7t/EJLw1we8L393Eb9XDX+2n1CnWdlr2Tyyc5KEJv/BdknW
         g/goEKefZsLs01zFPZBnws7YrLcxSPx+cBHJOuPmQB5bTe3IbbzZ1zxMTQOczvDT+f8W
         O7CzQf3YDPI8FbJR7Z7AHV0qmteaKUpfA3P3aHNQXtPJVHO9OHB+0IJ6i30VoLJrj9vh
         oqt85Gpm1LsayX6h9w+7VaW9oDZm6/5L32jlGSQMN/DF+3Igpd1Hqe70QMhQn21x+bNV
         okN/WLPlDWVb/enHP2nr8zRmhh63cLt8R0iQZ9lVbqtz/nGHF+MY8RSQxtbY7XeVlAqX
         BocA==
X-Gm-Message-State: ANhLgQ3aUdsSmBbTuPo6BjN24CzuGjUQU0ZMK2KXu4VfReCRGRuc1jq1
        lR8Kgt7nUbII3SXkjUtigaBTAkqcv8BBlZqefI4=
X-Google-Smtp-Source: ADFU+vvt6/8dxoDvoUnJueDCr2CAv+Z/cDlKicdhjM8koqHYSI9OIJmArUmr4sa6jKpw1ts3JCaLJX4wqkSZihRcGpw=
X-Received: by 2002:a50:ed12:: with SMTP id j18mr22045966eds.337.1583845049835;
 Tue, 10 Mar 2020 05:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200309210755.6759-1-olteanv@gmail.com> <2194d93de3870940148de58606dcb6ef@walle.cc>
In-Reply-To: <2194d93de3870940148de58606dcb6ef@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Tue, 10 Mar 2020 14:57:18 +0200
Message-ID: <CA+h21ho8XhXbonUwBahv63-RrbDOLw2UStfFyWZv5oJME2Ndgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] NXP DSPI bugfixes and support for LS1028A
To:     Michael Walle <michael@walle.cc>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Mar 2020 at 10:34, Michael Walle <michael@walle.cc> wrote:
>

> So starting with XSPI, if you have a big flash and cancel the readout
> strange things happen.
>
> # hexdump -C /dev/mtd0
> 00000000  00 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |.uhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> ^C[   35.487948] fsl-dspi 2120000.spi: Waiting for transfer to complete
> failed!
> [   35.495038] spi_master spi2: failed to transfer one message from
> queue
>

This, I think, is expected.

> # hexdump -C /dev/mtd0
> 00000000  00 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
> |.uhu............|
> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> |................|
> *
> ^C[   38.495955] fsl-dspi 2120000.spi: Waiting for transfer to complete
> failed!
> [   38.503097] spi_master spi2: failed to transfer one message from
> queue
> [   38.509729] Unable to handle kernel paging request at virtual address
> ffff800095ab3377
> [   38.517676] Mem abort info:
> [   38.520474]   ESR = 0x96000045
> [   38.523533]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   38.528861]   SET = 0, FnV = 0
> [   38.531921]   EA = 0, S1PTW = 0
> [   38.535067] Data abort info:
> [   38.537952]   ISV = 0, ISS = 0x00000045
> [   38.541797]   CM = 0, WnR = 1
> [   38.544771] swapper pgtable: 4k pages, 48-bit VAs,
> pgdp=0000000082621000
> [   38.551494] [ffff800095ab3377] pgd=00000020fffff003,
> p4d=00000020fffff003, pud=0000000000000000
> [   38.560229] Internal error: Oops: 96000045 [#1] PREEMPT SMP
> [   38.565819] Modules linked in:
> [   38.568882] CPU: 0 PID: 2729 Comm: hexdump Not tainted
> 5.6.0-rc4-next-20200306-00052-gd8730cdc8a0b-dirty #193
> [   38.578834] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC
> Eval 2.0 carrier (DT)
> [   38.587129] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [   38.591941] pc : ktime_get_real_ts64+0x3c/0x110
> [   38.596487] lr : spi_take_timestamp_pre+0x40/0x90
> [   38.601203] sp : ffff800010003d90
> [   38.604525] x29: ffff800010003d90 x28: ffff80001200e000
> [   38.609854] x27: ffff800011da9000 x26: ffff002079c40400
> [   38.615184] x25: ffff8000117fe018 x24: ffff800011daa1a0
> [   38.620513] x23: ffff800015ab3860 x22: ffff800095ab3377
> [   38.625841] x21: 000000000000146e x20: ffff8000120c3000
> [   38.631170] x19: ffff0020795f6e80 x18: ffff800011da9948
> [   38.636498] x17: 0000000000000000 x16: 0000000000000000
> [   38.641826] x15: ffff800095ab3377 x14: 0720072007200720
> [   38.647155] x13: 0720072007200765 x12: 0775076507750771
> [   38.652483] x11: 0720076d076f0772 x10: 0000000000000040
> [   38.657812] x9 : ffff8000108e2100 x8 : ffff800011dcabe8
> [   38.663139] x7 : 0000000000000000 x6 : ffff800015ab3a60
> [   38.668468] x5 : 0000000007200720 x4 : ffff800095ab3377
> [   38.673796] x3 : 0000000000000000 x2 : 0000000000000ab0
> [   38.679125] x1 : ffff800011daa000 x0 : 0000000000000026
> [   38.684454] Call trace:
> [   38.686905]  ktime_get_real_ts64+0x3c/0x110
> [   38.691100]  spi_take_timestamp_pre+0x40/0x90
> [   38.695470]  dspi_fifo_write+0x58/0x2c0
> [   38.699315]  dspi_interrupt+0xbc/0xd0
> [   38.702987]  __handle_irq_event_percpu+0x78/0x2c0
> [   38.707706]  handle_irq_event_percpu+0x3c/0x90
> [   38.712161]  handle_irq_event+0x4c/0xd0
> [   38.716008]  handle_fasteoi_irq+0xbc/0x170
> [   38.720115]  generic_handle_irq+0x2c/0x40
> [   38.724135]  __handle_domain_irq+0x68/0xc0
> [   38.728243]  gic_handle_irq+0xc8/0x160
> [   38.732000]  el1_irq+0xb8/0x180
> [   38.735149]  spi_nor_spimem_read_data+0xe0/0x140
> [   38.739779]  spi_nor_read+0xc4/0x120
> [   38.743364]  mtd_read_oob+0xa8/0xc0
> [   38.746860]  mtd_read+0x4c/0x80
> [   38.750007]  mtdchar_read+0x108/0x2a0
> [   38.753679]  __vfs_read+0x20/0x50
> [   38.757002]  vfs_read+0xa4/0x190
> [   38.760237]  ksys_read+0x6c/0xf0
> [   38.763471]  __arm64_sys_read+0x20/0x30
> [   38.767319]  el0_svc_common.constprop.3+0x90/0x160
> [   38.772125]  do_el0_svc+0x28/0x90
> [   38.775449]  el0_sync_handler+0x118/0x190
> [   38.779468]  el0_sync+0x140/0x180
> [   38.782793] Code: 91000294 1400000f d50339bf f9405e80 (f90002c0)
> [   38.788910] ---[ end trace 55da560db4d6bef7 ]---
> [   38.793540] Kernel panic - not syncing: Fatal exception in interrupt
> [   38.799914] SMP: stopping secondary CPUs
> [   38.803849] Kernel Offset: disabled
> [   38.807344] CPU features: 0x10002,20006008
> [   38.811451] Memory Limit: none
> [   38.814513] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
>

And this, I think, isn't. I've sent a new patch that addresses this in
v3, although it's always been like this as far as I can tell.

>
>
> In DMA mode one byte writes seem to work. But at least 5 byte writes do
> not:
>
> # echo -ne '\x00' > /dev/mtd10
> # echo 'huhu' > /dev/mtd10
> [   34.275383] fsl-dspi 2120000.spi: DMA tx timeout
> [   34.280035] fsl-dspi 2120000.spi: DMA transfer failed
> [   34.285116] fsl-dspi 2120000.spi: Waiting for transfer to complete
> failed!
> [   34.292029] spi_master spi2: failed to transfer one message from
> queue
> sh: write error: Connection timed out
> #
>

Correct, thanks for pointing out. Fixed this in v3.

> Vladimir, what kind of SPI device do you have to test?
>
> -michael
>

spidev_test --input <file-generated-with-hex-editor>
and watch the output with a protocol analyzer.

Thanks,
-Vladimir
