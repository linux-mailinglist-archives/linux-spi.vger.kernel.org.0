Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93B27A89B
	for <lists+linux-spi@lfdr.de>; Mon, 28 Sep 2020 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgI1H3x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Sep 2020 03:29:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1H3x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Sep 2020 03:29:53 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B25AC2080C;
        Mon, 28 Sep 2020 07:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601278193;
        bh=8BkQajuUSJxuSlFBzQBA1HmxdUg5e2A1nW4k//uNwnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c0+MnIBEkFr8Z52ZVpHCIPZtsF00FXX83yE0KdhPUlAUDZ3X/P33Ql4f2Sy94hP0u
         9c+L3M4vgUx9g1tD7q1Ise2lP01AfEa1PEvZM/ISTpdnDS2Sz6vZJLX2v26aP36HNw
         1sztnm6CwRo1EyLuUOo5m02c4Kgcdr/R66iszaYY=
Received: by mail-ej1-f44.google.com with SMTP id o8so7054288ejb.10;
        Mon, 28 Sep 2020 00:29:52 -0700 (PDT)
X-Gm-Message-State: AOAM533ZkJRUlgw01srJw1RKEQ8MNQfHFnjp3cq5DtnoXlRtoODdUO4h
        +xvSVeokdN4f7Liu6t3ftVrhhtO1uwlzgQ+IYtY=
X-Google-Smtp-Source: ABdhPJzXSDSGFufM7rz0GPMmljlIFfocxAq6LLeJCNlLypOj9fXlQjMln94ZsVUv2ymiIwcfwEe0RIdaOsZXYvJEbhI=
X-Received: by 2002:a17:906:af53:: with SMTP id ly19mr343973ejb.503.1601278191300;
 Mon, 28 Sep 2020 00:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200927224336.705-1-michael@walle.cc> <20200927232747.3jwr6mqql727etyz@skbuf>
In-Reply-To: <20200927232747.3jwr6mqql727etyz@skbuf>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 28 Sep 2020 09:29:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeeKyPzx4pnuXT=o7p8hE0SeCuyt9d8uj+Dc9fjjXULMA@mail.gmail.com>
Message-ID: <CAJKOXPeeKyPzx4pnuXT=o7p8hE0SeCuyt9d8uj+Dc9fjjXULMA@mail.gmail.com>
Subject: Re: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, linux-spi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 28 Sep 2020 at 01:28, Vladimir Oltean <olteanv@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 12:43:36AM +0200, Michael Walle wrote:
> > Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove
> > path") this driver causes a kernel oops:
> >
> > [    1.891065] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> > [    1.899889] Mem abort info:
> > [    1.902692]   ESR = 0x96000004
> > [    1.905754]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    1.911089]   SET = 0, FnV = 0
> > [    1.914156]   EA = 0, S1PTW = 0
> > [    1.917303] Data abort info:
> > [    1.920193]   ISV = 0, ISS = 0x00000004
> > [    1.924044]   CM = 0, WnR = 0
> > [    1.927022] [0000000000000080] user address but active_mm is swapper
> > [    1.933403] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [    1.938995] Modules linked in:
> > [    1.942060] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc6-next-20200925-00026-gae556cc74e28-dirty #94
> > [    1.951838] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 2.0 carrier (DT)
> > [    1.960135] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> > [    1.966168] pc : dspi_setup+0xc8/0x2e0
> > [    1.969926] lr : dspi_setup+0xbc/0x2e0
> > [    1.973684] sp : ffff80001139b930
> > [    1.977005] x29: ffff80001139b930 x28: ffff00207a5d2000
> > [    1.982338] x27: 0000000000000006 x26: ffff00207a44d410
> > [    1.987669] x25: ffff002079c08100 x24: ffff00207a5d2400
> > [    1.993000] x23: ffff00207a5d2600 x22: ffff800011169948
> > [    1.998332] x21: ffff800010cbcd20 x20: ffff00207a58a800
> > [    2.003663] x19: ffff00207a76b700 x18: 0000000000000010
> > [    2.008994] x17: 0000000000000001 x16: 0000000000000019
> > [    2.014326] x15: ffffffffffffffff x14: 0720072007200720
> > [    2.019657] x13: 0720072007200720 x12: ffff8000111fc5e0
> > [    2.024989] x11: 0000000000000003 x10: ffff8000111e45a0
> > [    2.030320] x9 : 0000000000000000 x8 : ffff00207a76b780
> > [    2.035651] x7 : 0000000000000000 x6 : 000000000000003f
> > [    2.040982] x5 : 0000000000000040 x4 : ffff80001139b918
> > [    2.046313] x3 : 0000000000000001 x2 : 64b62cc917af5100
> > [    2.051643] x1 : 0000000000000000 x0 : 0000000000000000
> > [    2.056973] Call trace:
> > [    2.059425]  dspi_setup+0xc8/0x2e0
> > [    2.062837]  spi_setup+0xcc/0x248
> > [    2.066160]  spi_add_device+0xb4/0x198
> > [    2.069918]  of_register_spi_device+0x250/0x370
> > [    2.074462]  spi_register_controller+0x4f4/0x770
> > [    2.079094]  dspi_probe+0x5bc/0x7b0
> > [    2.082594]  platform_drv_probe+0x5c/0xb0
> > [    2.086615]  really_probe+0xec/0x3c0
> > [    2.090200]  driver_probe_device+0x60/0xc0
> > [    2.094308]  device_driver_attach+0x7c/0x88
> > [    2.098503]  __driver_attach+0x60/0xe8
> > [    2.102263]  bus_for_each_dev+0x7c/0xd0
> > [    2.106109]  driver_attach+0x2c/0x38
> > [    2.109692]  bus_add_driver+0x194/0x1f8
> > [    2.113538]  driver_register+0x6c/0x128
> > [    2.117385]  __platform_driver_register+0x50/0x60
> > [    2.122105]  fsl_dspi_driver_init+0x24/0x30
> > [    2.126302]  do_one_initcall+0x54/0x2d0
> > [    2.130149]  kernel_init_freeable+0x1ec/0x258
> > [    2.134520]  kernel_init+0x1c/0x120
> > [    2.138018]  ret_from_fork+0x10/0x34
> > [    2.141606] Code: 97e0b11d aa0003f3 b4000680 f94006e0 (f9404000)
> > [    2.147723] ---[ end trace 26cf63e6cbba33a8 ]---
> > [    2.152374] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > [    2.160061] SMP: stopping secondary CPUs
> > [    2.163999] Kernel Offset: disabled
> > [    2.167496] CPU features: 0x0040022,20006008
> > [    2.171777] Memory Limit: none
> > [    2.174840] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> >
> > This is because since this commit, the allocation of the drivers private
> > data is done explicitly and in this case spi_alloc_master() won't set the
> > correct pointer.
> >
> > Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
>
> Sascha, how did you test commit 530b5affc675?

Hi,

I just hit it on my Vybrid systems as well. It fails on every boot, so
I have doubts that it was actually tested. The fix was posted on 23rd
and applied within a few hours... also no time for anyone else to test
it.

>
> >  drivers/spi/spi-fsl-dspi.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> > index a939618f5e47..dd80be987bf9 100644
> > --- a/drivers/spi/spi-fsl-dspi.c
> > +++ b/drivers/spi/spi-fsl-dspi.c
> > @@ -1236,6 +1236,8 @@ static int dspi_probe(struct platform_device *pdev)
> >       if (!ctlr)
> >               return -ENOMEM;
> >
> > +     spi_controller_set_devdata(ctlr, dspi);

Michael,

How about moving here platform_set_drvdata(pdev, dspi) from the end of
the probe to keep them close to each other?

Best regards,
Krzysztof


> > +
> >       dspi->pdev = pdev;
> >       dspi->ctlr = ctlr;
> >
> > --
> > 2.20.1
> >
>
> Thanks,
> -Vladimir
