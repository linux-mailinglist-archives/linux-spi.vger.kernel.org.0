Return-Path: <linux-spi+bounces-4859-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC1B97BD67
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 15:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D381F23CC4
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4618B47B;
	Wed, 18 Sep 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGxWsKLI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349B18991E
	for <linux-spi@vger.kernel.org>; Wed, 18 Sep 2024 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667675; cv=none; b=T9exqLHycDpeXzBetTNOkz92fqJ+dOSnrcUlpdkp85x5ijUnqXlvLWDrlARFd1FIfbEVtkPEXUtcuBnzJMAhYwlIMoPp9/BSZaHjiWLIBBmShBAFyEdW9ut620Vxc1Iu/MwLpnTrknR4FFy7miQ2PHE4cYRtf8lLNZb2LqrvDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667675; c=relaxed/simple;
	bh=PwjhJ6aL25amCFnR6nPwf/YUl8QTgG+wSy1oaJ2bEvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWUdn+F0csJKbAIcbKNGj8EGSzjlb0wbPqIUDjH7bQ190/D8pnd34wF2653nIQ78yOX6FGVNIbO78PdrX3OCUXiNyryJOD5f74s79ey2TmBP56bA9bA8LJLXGgnmnopV2ov+B6HwtpADp0qu52gY9kO/BsC3uE/AR4hJeYqeLxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yGxWsKLI; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-846bc75136eso1457317241.3
        for <linux-spi@vger.kernel.org>; Wed, 18 Sep 2024 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726667670; x=1727272470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hIMeCl4bSafLlQW0rWA6MOrP/WItPaBFD6DWuM4YR94=;
        b=yGxWsKLIhOkgM9OMMmJQouBuQJSbSDepLy0e4Rw/WdGSqDjh8NLBtX/Q1iMyV3cyK0
         bKfVQ1DwOieouxU7UZrLBMFKPWqOOKdBGsmdOKh5GQz4idUk8bXKIbfZTcgdAIk4G58y
         SnpnTlRQBJUZ2U5tOovN4w4Q/MYsRXLDB+dB+IqN6Bj7DFPoB1nf/NrlQEfdp8MZLYrd
         0lCSLwonAcRCSKSh0n7QK0aLHK76+CJxVy5Ok6fTZYJ/fyEBFtOKHtu9GtzXhXlF6I1l
         zrKzj7WQdH5GlyQlfd4hcQLiSBvIw1QOCz7xBpO2vgKdv1qRt/hmDKtg5HzGhC2aHiqG
         WZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726667670; x=1727272470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIMeCl4bSafLlQW0rWA6MOrP/WItPaBFD6DWuM4YR94=;
        b=DcXTl0ZklFyPxlTJra0+1IYCXB/ceE7wQFHN6qmd2M+zsDJN86q511qk5nLgNO1R3b
         Hl9PL5gL1bf55EfAPzIFxGd5aeflT9PncHXPIXNyHo8g81cWQE+zsVNzX+iOOdt1mW7U
         dUNiAdeHAIZFaD0fE48Kydm6aNhYtZF+wADQpcD82axOVl96yZyrW4307RoXLQv/nVIb
         Xv36I0ihZUsPsANOQafQwemA7Bm76yJgb4dvqQ/tnxF/D6keD6s/UCbTxd6rSTr0B7nX
         fedlL69Nms5JFP9EYI/ucCuCrQAXGMpVT2lE66YN0Mikzse1VvT8vbXud0JP7s7eBY4B
         e6lw==
X-Forwarded-Encrypted: i=1; AJvYcCV7OHAb7T+OGsXCrpHFdbD3g86dAYvXq6p/PffwgCh3RaXKgYz4ejoB8p/C3hpUobLlkgRDDoDRr4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KugfcejczALD/aGi/8DVo2YF/BOksrbZjOLuq/hcb5qGUWDx
	4AuFdcmawiKgZS0eVe/LlUHtZ8NVK3esQBrGsvzNhpLnF/KeVTAGNfZq9/7BVjMbYlpJeZ8X08q
	7Poidv0dzlmUK8kz62+DzkKdjDzg4dtTPpK5FqQ==
X-Google-Smtp-Source: AGHT+IHsRvjoxv7oG344mOEKI4OydT5RUPtI6fUUmhF8HAW4FEQ3U0a5TaC332VC2FIUrLc2R6/n6smMBWiKHopXJqU=
X-Received: by 2002:a05:6102:3a0a:b0:49b:c414:8a98 with SMTP id
 ada2fe7eead31-49d4158028fmr16213119137.29.1726667669756; Wed, 18 Sep 2024
 06:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916114221.021192667@linuxfoundation.org> <CA+G9fYtsjFtddG8i+k-SpV8U6okL0p4zpsTiwGfNH5GUA8dWAA@mail.gmail.com>
 <b0dfa622-f4f7-4f76-9d67-621544cb2212@kernel.org>
In-Reply-To: <b0dfa622-f4f7-4f76-9d67-621544cb2212@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Sep 2024 19:24:17 +0530
Message-ID: <CA+G9fYtBHgb5m+yv+0bDH0435BMLnmiEHzXb2QP_TdLn43hwXg@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/63] 6.1.111-rc1 review
To: Georgi Djakov <djakov@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, 
	Jinjie Ruan <ruanjinjie@huawei.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-spi@vger.kernel.org, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 17:38, Georgi Djakov <djakov@kernel.org> wrote:
>
> On 17.09.24 17:43, Naresh Kamboju wrote:
> > On Mon, 16 Sept 2024 at 17:29, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> This is the start of the stable review cycle for the 6.1.111 release.
> >> There are 63 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.111-rc1.gz
> >> or in the git tree and branch at:
> >>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> >> and the diffstat can be found below.
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> >
> > The following kernel warnings have been noticed on a Qualcomm db845c device
> > running stable-rc  6.1.111-rc1, 6.6.52-rc1 and 6.10.11-rc1 at boot time.
> >
> > First seen on 6.1.111-rc1
> >    Good: v6.1.110
> >    BAD:  6.1.111-rc1
> >
>
> Hi Naresh,
>
> Do you see this warning on every boot or only sometimes?

Today I have found that the frequency of occurrence is low.


> I am not able to
> reproduce it on my db845c board even with your binaries.
>
> I see however one geni runtime PM change that very likely triggers this
> warning, so if you are doing a bisect, maybe try reverting that one first.

Since this an intermittent issue and the bisection did not end up smooth.

FYI,
stable-rc /linux-6.10.y:
----------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.10-122-ge9fde6b546b5/testrun/25159698/suite/log-parser-boot/test/check-kernel-exception-warning-cpu-pid-at-driversinterconnectcorec-__icc_enable/details/

stable-rc /linux-6.1.y:
----------
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.110-64-gdc7da8d6f263/testrun/25159001/suite/log-parser-boot/test/check-kernel-exception-warning-cpu-pid-at-driversinterconnectcorec-__icc_enable/details/

stable-rc /linux-6.6.y:
----------
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.51-92-gfd49ddc1e5f8/testrun/25161861/suite/log-parser-boot/test/check-kernel-exception-warning-cpu-pid-at-driversinterconnectcorec-__icc_enable/details/

- Naresh

>
> Thanks,
> Georgi
>
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Warning log:
> > --------
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
> > [    0.000000] Linux version 6.1.111-rc1 (tuxmake@tuxmake)
> > (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils
> > for Debian) 2.43) #1 SMP PREEMPT @1726489583
> > [    0.000000] Machine model: Thundercomm Dragonboard 845c
> > ...
> > [    7.841428] ------------[ cut here ]------------
> > [    7.841431] WARNING: CPU: 4 PID: 492 at
> > drivers/interconnect/core.c:685 __icc_enable
> > (drivers/interconnect/core.c:685 (discriminator 7))
> > [    7.841442] Modules linked in: soundwire_bus(+) venus_core(+)
> > qcom_camss(+) drm_dp_aux_bus bluetooth(+) qcom_stats mac80211(+)
> > videobuf2_dma_sg drm_display_helper i2c_qcom_geni(+) i2c_qcom_cci
> > camcc_sdm845(+) v4l2_mem2mem qcom_q6v5_mss(+) videobuf2_memops
> > reset_qcom_pdc spi_geni_qcom(+) videobuf2_v4l2 phy_qcom_qmp_usb(+)
> > videobuf2_common gpi(+) qcom_rng cfg80211 phy_qcom_qmp_ufs ufs_qcom(+)
> > coresight_stm phy_qcom_qmp_pcie stm_core rfkill slim_qcom_ngd_ctrl
> > qrtr pdr_interface lmh qcom_wdt slimbus icc_osm_l3 qcom_q6v5_pas(+)
> > icc_bwmon llcc_qcom qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common
> > qcom_glink_smem qmi_helpers mdt_loader display_connector
> > drm_kms_helper drm socinfo rmtfs_mem
> > [    7.841494] CPU: 4 PID: 492 Comm: (udev-worker) Not tainted 6.1.111-rc1 #1
> > [    7.841497] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [    7.841499] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    7.841502] pc : __icc_enable (drivers/interconnect/core.c:685
> > (discriminator 7))
> > [    7.841505] lr : icc_disable (drivers/interconnect/core.c:708)
> > [    7.841508] sp : ffff800008b23660
> > [    7.841509] x29: ffff800008b23660 x28: ffff800008b23c20 x27: 0000000000000000
> > [    7.841513] x26: ffffdd85da6ea1c0 x25: 0000000000000008 x24: 00000000000f4240
> > [    7.841516] x23: 0000000000000000 x22: ffff46a58b7ca580 x21: 0000000000000001
> > [    7.841519] x20: ffff46a58b7ca5c0 x19: ffff46a58b54a800 x18: 0000000000000000
> > [    7.841522] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [    7.841525] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > [    7.841528] x11: fefefefefefefeff x10: 0000000000000bf0 x9 : ffffdd85d8c9b0bc
> > [    7.841531] x8 : ffff800008b22f58 x7 : 0000000000000000 x6 : 0000000000024404
> > [    7.841535] x5 : 0000000000000000 x4 : ffff46a58b64b180 x3 : ffffdd85daa5e810
> > [    7.841537] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > [    7.841541] Call trace:
> > [    7.841542] __icc_enable (drivers/interconnect/core.c:685 (discriminator 7))
> > [    7.841545] icc_disable (drivers/interconnect/core.c:708)
> > [    7.841547] geni_icc_disable (drivers/soc/qcom/qcom-geni-se.c:862)
> > [    7.841553] spi_geni_runtime_suspend+0x3c/0x4c spi_geni_qcom
> > [    7.841561] pm_generic_runtime_suspend (drivers/base/power/generic_ops.c:28)
> > [    7.841565] __rpm_callback (drivers/base/power/runtime.c:395)
> > [    7.841568] rpm_callback (drivers/base/power/runtime.c:532)
> > [    7.841570] rpm_suspend (drivers/base/power/runtime.c:672)
> > [    7.841572] rpm_idle (drivers/base/power/runtime.c:504 (discriminator 1))
> > [    7.841574] update_autosuspend (drivers/base/power/runtime.c:1662)
> > [    7.841576] pm_runtime_disable_action (include/linux/spinlock.h:401
> > drivers/base/power/runtime.c:1703 include/linux/pm_runtime.h:599
> > drivers/base/power/runtime.c:1517)
> > [    7.841579] devm_action_release (drivers/base/devres.c:720)
> > [    7.841581] release_nodes (drivers/base/devres.c:503)
> > [    7.841583] devres_release_all (drivers/base/devres.c:532)
> > [    7.841585] device_unbind_cleanup (drivers/base/dd.c:531)
> > [    7.841589] really_probe (drivers/base/dd.c:710)
> > [    7.841592] __driver_probe_device (drivers/base/dd.c:785)
> > [    7.841594] driver_probe_device (drivers/base/dd.c:815)
> > [    7.841596] __driver_attach (drivers/base/dd.c:1202)
> > [    7.841598] bus_for_each_dev (drivers/base/bus.c:301)
> > [    7.841600] driver_attach (drivers/base/dd.c:1219)
> > [    7.841602] bus_add_driver (drivers/base/bus.c:618)
> > [    7.841604] driver_register (drivers/base/driver.c:246)
> > [    7.841607] __platform_driver_register (drivers/base/platform.c:868)
> > [    7.841609] spi_geni_driver_init+0x28/0x1000 spi_geni_qcom
> > [    7.841615] do_one_initcall (init/main.c:1298)
> > [    7.841619] do_init_module (kernel/module/main.c:2469)
> > [    7.841623] load_module (kernel/module/main.c:2878)
> > [    7.841625] __do_sys_finit_module (kernel/module/main.c:2978
> > (discriminator 1))
> > [    7.841627] __arm64_sys_finit_module (kernel/module/main.c:2945)
> > [    7.841630] invoke_syscall (arch/arm64/include/asm/current.h:19
> > arch/arm64/kernel/syscall.c:57)
> > [    7.841633] el0_svc_common.constprop.0
> > (arch/arm64/include/asm/daifflags.h:28
> > arch/arm64/kernel/syscall.c:148)
> > [    7.841637] do_el0_svc (arch/arm64/kernel/syscall.c:205)
> > [    7.841639] el0_svc (arch/arm64/include/asm/daifflags.h:28
> > arch/arm64/kernel/entry-common.c:133
> > arch/arm64/kernel/entry-common.c:142
> > arch/arm64/kernel/entry-common.c:638)
> > [    7.841644] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
> > [    7.841647] el0t_64_sync (arch/arm64/kernel/entry.S:585)
> > [    7.841649] ---[ end trace 0000000000000000 ]---
>
>

