Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54255288781
	for <lists+linux-spi@lfdr.de>; Fri,  9 Oct 2020 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbgJILBj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Oct 2020 07:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbgJILBj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Oct 2020 07:01:39 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF1C0613D2
        for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2020 04:01:37 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t7so7536767ilf.10
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2020 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9FUmsHRdzDX+Vt1bLRUFwJyIe4hAN+MYSGvWLEMwsI=;
        b=cudWCU0sZU57ddFpV/PSzUrGhYl5JLTSNpwa8QMA8kgDELuQa1t04cKEfMHEHOkjfG
         poDU6k0GImOHReYY6ePOYNyW7dPJDtURXDdsQgq/ViDVpI+u3EExYN5FHXDeIoKFc/HC
         ZxTOc4UFWOMkWYn8OZRh3V1e9fWX6bg2KZfp7SlpUOUVfYP3jYcTlr3SNZe0Gcn37s9Z
         O2lNYJ8Iz5wRJfU8hEVmNQuhoIR0eWUtoRmSCVsV2tWuLtWHbla7IjS5r7r1Jn6FF9a0
         ugA0jlRS9eSH3s3aVI1lxhgzr+LPSaZqtvwNOoq0rtxyke+YvkGiWwZlVsJlPlL5Kr2w
         Gu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9FUmsHRdzDX+Vt1bLRUFwJyIe4hAN+MYSGvWLEMwsI=;
        b=VxcA8s+oE6pRTRt9cNBltYDsTcogYCXsgi7ODVxzQFvwytNYk1bdjLT1JyfUImWQ+e
         DGsz37sUXajYrJ1JtVyF01EczpQPicukV+1Qna6PklXpaYPnf9YQSCRiSHTlYLmXYpUa
         3lyL6O39oasYe2EygJbbgvSx2II9PifAEuBzsV/JArXDbEMlLlKDpBnBho1UShIetg9h
         H+562qHKGcBOZSJ5ifD+oXnGbEOStrLoKOzpC7CmqzJs891PZnxY3mhcCZs+jipjI+4n
         ICtyRkpghpPBXpluFrv1/AEQSaSLf6htvoTZ0PJDrk7FHoxwIwSagKV1iHnpmNIMdUBk
         +9lA==
X-Gm-Message-State: AOAM533a4U3RQ2zWRefJUwC5pB6hidnmJLK1icqHj+UdYfQDuwtmwP5Q
        x87oTrU0O6EO+TfDbnfJvIdy22W9unMhlwvds6bcww==
X-Google-Smtp-Source: ABdhPJzedOqZoJ/3WzJR4gewL6ALcz8GryaoNrTlhnxNctP+RMkigRjDdBAvabMuktx9LGFVuG44+TczpyNHlPc8y84=
X-Received: by 2002:a92:c949:: with SMTP id i9mr9704573ilq.252.1602241297028;
 Fri, 09 Oct 2020 04:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200928085500.28254-1-michael@walle.cc>
In-Reply-To: <20200928085500.28254-1-michael@walle.cc>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Oct 2020 16:31:25 +0530
Message-ID: <CA+G9fYsOENcQHvkPvxFh6TnwH7-LF6pweumiFK+S=+5yXVyUaw@mail.gmail.com>
Subject: Re: [PATCH v3] spi: fsl-dspi: fix NULL pointer dereference
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 28 Sep 2020 at 14:26, Michael Walle <michael@walle.cc> wrote:
>
> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove
> path") this driver causes a kernel oops:

FYI,
This reported issue is now happening on Linus's master 5.9.0-rc8 on arm64
nxp-ls2088 devices.

Crash log,
-------------
[    1.986452] fsl,ifc-nand 530000000.nand: IFC NAND device at
0x530000000, bank 2
[    1.994751] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000080
[    2.003542] Mem abort info:
[    2.006331]   ESR = 0x96000004
[    2.009380]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.014718]   SET = 0, FnV = 0
[    2.017764]   EA = 0, S1PTW = 0
[    2.020908] Data abort info:
[    2.023787]   ISV = 0, ISS = 0x00000004
[    2.027621]   CM = 0, WnR = 0
[    2.030586] [0000000000000080] user address but active_mm is swapper
[    2.036940] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    2.042505] Modules linked in:
[    2.045553] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc8 #1
[    2.051725] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
[    2.058072] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
[    2.063643] pc : dspi_setup+0x5c/0x2b0
[    2.067383] lr : dspi_setup+0x278/0x2b0
[    2.071209] sp : ffff80001005b900
[    2.074514] x29: ffff80001005b900 x28: ffff0082ccd3f000
[    2.079819] x27: ffffd73de0a704e0 x26: ffff0082edebc100
[    2.085123] x25: 0000000000000001 x24: ffff0082edea6810
[    2.090427] x23: ffffd73de15b6c40 x22: ffff0082ccd3f600
[    2.095731] x21: ffff0082ee6b0000 x20: ffff0082cce51100
[    2.101036] x19: ffff0082ccd3f800 x18: 0000000000000000
[    2.106340] x17: ffffd73de088e6d8 x16: ffffd73de088e6e0
[    2.111644] x15: ffff0082ee6b0480 x14: ffffffffffffffff
[    2.116947] x13: ffff0082cce51087 x12: ffff0082cce51085
[    2.122251] x11: 0000000000000008 x10: 0101010101010101
[    2.127554] x9 : 0000000000000000 x8 : ffff0082cce51180
[    2.132858] x7 : 0000000000000000 x6 : 000000000000003f
[    2.138162] x5 : 0000000000000040 x4 : ffff80001005b8f0
[    2.143466] x3 : 0000000000000001 x2 : 0000000000000dc0
[    2.148770] x1 : e01dcf85cfcc6200 x0 : 0000000000000000
[    2.154074] Call trace:
[    2.156512]  dspi_setup+0x5c/0x2b0
[    2.159906]  spi_setup+0xcc/0x2e0
[    2.163211]  spi_add_device+0xec/0x218
[    2.166951]  of_register_spi_device+0x224/0x370
[    2.171473]  spi_register_controller+0x598/0x830
[    2.176081]  dspi_probe+0x32c/0x798
[    2.179562]  platform_drv_probe+0x5c/0xb0
[    2.183564]  really_probe+0xf0/0x4d8
[    2.187131]  driver_probe_device+0xfc/0x168
[    2.191305]  device_driver_attach+0x7c/0x88
[    2.195478]  __driver_attach+0xac/0x178
[    2.199306]  bus_for_each_dev+0x78/0xc8
[    2.203134]  driver_attach+0x2c/0x38
[    2.206702]  bus_add_driver+0x14c/0x230
[    2.210529]  driver_register+0x6c/0x128
[    2.214355]  __platform_driver_register+0x50/0x60
[    2.219053]  fsl_dspi_driver_init+0x24/0x30
[    2.223229]  do_one_initcall+0x4c/0x2c0
[    2.227058]  kernel_init_freeable+0x214/0x280
[    2.231409]  kernel_init+0x1c/0x128
[    2.234889]  ret_from_fork+0x10/0x30
[    2.238458] Code: 290a7fff f9403c16 b4001094 f94006c0 (f9404000)
[    2.244553] ---[ end trace cec4aea5fb1ac3ec ]---
[    2.249176] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    2.249618] ata1: SATA link down (SStatus 0 SControl 300)
[    2.256828] SMP: stopping secondary CPUs
[    2.256836] Kernel Offset: 0x573dcf080000 from 0xffff800010000000
[    2.256837] PHYS_OFFSET: 0xffff8f0ec0000000
[    2.256839] CPU features: 0x0240022,21806008
[    2.256840] Memory Limit: none

>
> [    1.891065] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> [..]
> [    2.056973] Call trace:
> [    2.059425]  dspi_setup+0xc8/0x2e0
> [    2.062837]  spi_setup+0xcc/0x248
> [    2.066160]  spi_add_device+0xb4/0x198
> [    2.069918]  of_register_spi_device+0x250/0x370
> [    2.074462]  spi_register_controller+0x4f4/0x770
> [    2.079094]  dspi_probe+0x5bc/0x7b0
> [    2.082594]  platform_drv_probe+0x5c/0xb0
> [    2.086615]  really_probe+0xec/0x3c0
> [    2.090200]  driver_probe_device+0x60/0xc0
> [    2.094308]  device_driver_attach+0x7c/0x88
> [    2.098503]  __driver_attach+0x60/0xe8
> [    2.102263]  bus_for_each_dev+0x7c/0xd0
> [    2.106109]  driver_attach+0x2c/0x38
> [    2.109692]  bus_add_driver+0x194/0x1f8
> [    2.113538]  driver_register+0x6c/0x128
> [    2.117385]  __platform_driver_register+0x50/0x60
> [    2.122105]  fsl_dspi_driver_init+0x24/0x30
> [    2.126302]  do_one_initcall+0x54/0x2d0
> [    2.130149]  kernel_init_freeable+0x1ec/0x258
> [    2.134520]  kernel_init+0x1c/0x120
> [    2.138018]  ret_from_fork+0x10/0x34
> [    2.141606] Code: 97e0b11d aa0003f3 b4000680 f94006e0 (f9404000)
> [    2.147723] ---[ end trace 26cf63e6cbba33a8 ]---
>
> This is because since this commit, the allocation of the drivers private
> data is done explicitly and in this case spi_alloc_master() won't set the
> correct pointer.
>
> Also move the platform_set_drvdata() to have both next to each other.
>
> Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
> Signed-off-by: Michael Walle <michael@walle.cc>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> changes since v2:
>  - trimmed the commit message, suggested by Krzysztof.
>
> changes since v1:
>  - moved platform_set_drvdata(), suggested by Krzysztof.
>
>  drivers/spi/spi-fsl-dspi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index a939618f5e47..3967afa465f0 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -1236,6 +1236,9 @@ static int dspi_probe(struct platform_device *pdev)
>         if (!ctlr)
>                 return -ENOMEM;
>
> +       spi_controller_set_devdata(ctlr, dspi);
> +       platform_set_drvdata(pdev, dspi);
> +
>         dspi->pdev = pdev;
>         dspi->ctlr = ctlr;
>
> @@ -1371,8 +1374,6 @@ static int dspi_probe(struct platform_device *pdev)
>         if (dspi->devtype_data->trans_mode != DSPI_DMA_MODE)
>                 ctlr->ptp_sts_supported = true;
>
> -       platform_set_drvdata(pdev, dspi);
> -
>         ret = spi_register_controller(ctlr);
>         if (ret != 0) {
>                 dev_err(&pdev->dev, "Problem registering DSPI ctlr\n");
> --
> 2.20.1
>

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git commit: 583090b1b8232e6eae243a9009699666153a13a9
  git describe: v5.9-rc8-206-g583090b1b823
  make_kernelversion: 5.9.0-rc8
  kernel-config:
https://builds.tuxbuild.com/hkbjxXyQ2-4IiR2Z-6P8vw/kernel.config

full log link,
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.9-rc8-206-g583090b1b823/testrun/3283416/suite/linux-log-parser/test/check-kernel-oops-91954/log


-- 
Linaro LKFT
https://lkft.linaro.org
