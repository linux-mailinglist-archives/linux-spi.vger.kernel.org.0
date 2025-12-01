Return-Path: <linux-spi+bounces-11673-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1917FC960A5
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 08:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D06034373C
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 07:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42682BEC5E;
	Mon,  1 Dec 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wYaZVVxU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED5A2BDC29;
	Mon,  1 Dec 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575008; cv=none; b=k4i/PX07CbA/A4TLLrSyyDp+iJVTCHTKyZHYsKS6GWyWYlK4hIg9+pyenhMxDillGsQiO7rE2Czi77P7LbB3FUFiopwY7quIyFOfXxwsODW4rOwAdKnG1fBDxeZfYxPmf2Nk3oJv1d3kqLoyY3p6QlnwXyLkTT80aWIxGg5KygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575008; c=relaxed/simple;
	bh=Chi8aNYL8HSOpejwNaovG1FfHywIidMrOtw5OpVy0S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy6ahNA5r3TCkvg773tWY+9ekQwfoGFBCpEAOpkfMxR/8K/lK7pLkk2A42P055mB6tynnQ/xROizXf7m/aPlCgLgBBLC0ccXnXj7ETQd3VMIh8HryjRyjnwcaVZnkMKE6jJoek3I0e/D8ge5jfMQsxluodrZAjSz1K9mXsbwb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wYaZVVxU; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 9BF571F93F;
	Mon,  1 Dec 2025 08:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1764575003;
	bh=W1+tRgohmrySfxeaL08TV4mevxKX8AT45dmkFNwnyn4=; h=From:To:Subject;
	b=wYaZVVxUVRNLaphyylSIC1wC010cHJ6MPRCtjkhg8Uqjo0MH9aHju9985hNUzCTr0
	 JAFMKZktbRmaxy+/iUf3Ahl1XExlSFlylfYZsm4aPr4vg2NnGI5P+jruN+kjj+YrNZ
	 fv0myzOEA7bEevA0rK65T4gVs+ANsd6iWoHxstsV6i5sNcU9y9kj/q0IVvl99ckrmn
	 NkDcNxVZ+S9euomEr13/4Cf34AWgKa+PSMwxs30vDhHRaY71ZRqv7W+D8de2U/Bh4/
	 F2BPJcAvUed43WvyWRg3cC4kcwpRsRJGoj0CXunGdSB+3FuP9Ac7EZ11EafiMcny4T
	 ZKr0Wj/cC6MwA==
Date: Mon, 1 Dec 2025 08:43:20 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, broonie@kernel.org,
	a-dutta@ti.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] spi: cadence-quadspi: Fix cqspi_probe() error handling
 for runtime pm
Message-ID: <20251201074320.GA8737@francesco-nb>
References: <20251119152545.2591651-1-s-vadapalli@ti.com>
 <20251201072844.GA6785@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201072844.GA6785@francesco-nb>

On Mon, Dec 01, 2025 at 08:28:44AM +0100, Francesco Dolcini wrote:
> Hello Siddharth, Mark,
> 
> On Wed, Nov 19, 2025 at 08:53:53PM +0530, Siddharth Vadapalli wrote:
> > Commit f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier
> > to avoid imbalance") relocated code but missed updating the error handling
> > path associated with it.
> > 
> > Prior to the relocation, runtime pm was enabled after the code-block
> > associated with 'cqspi_request_mmap_dma()', due to which, the error
> > handling for the same didn't require invoking 'pm_runtime_disable()'.
> > 
> > Post refactoring, runtime pm has been enabled before the code-block and
> > when an error is encountered, jumping to 'probe_dma_failed' doesn't
> > invoke 'pm_runtime_disable()'. This leads to a race condition wherein
> > 'cqspi_runtime_suspend()' is invoked while the error handling path executes
> > in parallel. The resulting error is the following:
> > 
> >   clk:103:0 already disabled
> >   WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x80/0xa0, CPU#1: kworker/u8:0/12
> >   [TRIMMED]
> >   pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >   pc : clk_core_disable+0x80/0xa0
> >   lr : clk_core_disable+0x80/0xa0
> >   [TRIMMED]
> >   Call trace:
> >    clk_core_disable+0x80/0xa0 (P)
> >    clk_core_disable_lock+0x88/0x10c
> >    clk_disable+0x24/0x30
> >    cqspi_probe+0xa3c/0xae8
> >   [TRIMMED]
> > 
> > The error is due to the second invocation of 'clk_disable_unprepare()' on
> > 'cqspi->clk' in the error handling within 'cqspi_probe()', with the first
> > invocation being within 'cqspi_runtime_suspend()'.
> > 
> > Fix this by correcting the error handling.
> > 
> > Fixes: f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Our CI just hit this WARNING with 6.18 kernel, on verdin-am62. To me it's a
> regression from v6.18, specifically from spi-fix-v6.18-rc7, we did not
> had any such WARNING with the master build we did run last Friday.
> 
> 
> [    8.648915] cadence-qspi fc40000.spi: No flash device declared
> [    8.675671] cadence-qspi fc40000.spi: failed to setup flash parameters -19
> [    8.693691] ------------[ cut here ]------------
> [    8.693719] clk:75:7 already disabled
> [    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/clk.c:1188 clk_core_disable+0xa0/0xb4
> [    8.693822] Modules linked in: gf128mul(+) snd_soc_simple_card(+) snd_soc_simple_card_utils spi_cadence_quadspi(+) optee tee usb_conn_gpio gpio_keys display_connector roles dwc3_am62 rtc_ti_k3 ti_k3_r5_remoteproc k3_j72xx_bandgap ti_k3_m4_remoteproc ti_k3_common tidss sa2ul sha512 snd_soc_davinci_mcasp drm_display_helper libsha512 snd_soc_ti_udma sha256 sha1 cec snd_soc_ti_edma pruss omap_mailbox snd_soc_ti_sdma omap_hwspinlock authenc bluetooth ecdh_generic ecc ina2xx tpm_tis_i2c rfkill snd_soc_wm8904 libaes lm75 lontium_lt8912b crc_ccitt i3c ti_ads1015 tpm_tis_core industrialio_triggered_buffer kfifo_buf tps65219_pwrbutton tpm rng_core m_can_platform m_can tc358768 can_dev spi_omap2_mcspi pwm_tiehrpwm loop fuse ipv6 libsha1 autofs4
> [    8.694064] CPU: 1 UID: 0 PID: 185 Comm: (udev-worker) Not tainted 6.18.0-0.0.0-devel #1 PREEMPT
> [    8.694076] Hardware name: Toradex Verdin AM62 on Dahlia Board (DT)

Same on verdin-am62p

[    4.554803] cadence-qspi fc40000.spi: No flash device declared
[    4.565690] optee: dynamic shared memory is enabled
[    4.566240] optee: initialized driver
[    4.566620] cadence-qspi fc40000.spi: failed to setup flash parameters -19
[    4.573982] ------------[ cut here ]------------
[    4.573999] clk:75:7 already disabled
[    4.574045] WARNING: CPU: 2 PID: 187 at /usr/src/kernel/drivers/clk/clk.c:1188 clk_core_disable+0xa0/0xb4
[    4.574068] Modules linked in: gf128mul(+) optee spi_cadence_quadspi(+) tee gpio_keys usb_conn_gpio roles dwc3_am62 ti_ads1015 tps65219_pwrbutton industrialio_triggered_buffer kfifo_buf btnxpuart hci_uart bluetooth k3_j72xx_bandgap sa2ul ti_k3_r5_remoteproc rtc_ti_k3 ecdh_generic ti_k3_common ecc sha512 libsha512 rfkill sha256 wave5 sha1 authenc libaes snd_soc_davinci_mcasp snd_soc_ti_udma snd_soc_ti_edma omap_hwspinlock snd_soc_ti_sdma lm75 i3c ina2xx snd_soc_wm8904 omap_mailbox m_can_platform m_can can_dev spi_omap2_mcspi pwm_tiehrpwm loop fuse ipv6 libsha1 autofs4
[    4.574248] CPU: 2 UID: 0 PID: 187 Comm: (udev-worker) Not tainted 6.18.0-0.0.0-devel #1 PREEMPT
[    4.574261] Hardware name: Toradex Verdin AM62P WB on Dahlia Board (DT)
[    4.574268] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.574276] pc : clk_core_disable+0xa0/0xb4
[    4.574287] lr : clk_core_disable+0xa0/0xb4
[    4.574294] sp : ffff8000810b3800
[    4.574298] x29: ffff8000810b3800 x28: ffffb19e583d3158 x27: ffff000001922c10
[    4.574313] x26: ffff000001922c10 x25: ffffb19e583d6428 x24: ffff000001922c00
[    4.574327] x23: 0000000000000000 x22: ffff000005c7f800 x21: 0000000000000000
[    4.574342] x20: 0000000000000000 x19: ffff00000296de00 x18: fffffffffffe77a0
[    4.574356] x17: 000000000004b000 x16: 0000000000001000 x15: ffffb19e581fe4b0
[    4.574369] x14: 0000000000000000 x13: 64656c6261736964 x12: 2079646165726c61
[    4.574383] x11: 0000000000000058 x10: 0000000000000018 x9 : ffffb19e581fe538
[    4.574397] x8 : 0000000000057fa8 x7 : 00000000000001b0 x6 : 0000000000000001
[    4.574410] x5 : ffff00007fb976c8 x4 : 0000000000000000 x3 : 0000000000000027
[    4.574424] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000048b90c0
[    4.574439] Call trace:
[    4.574445]  clk_core_disable+0xa0/0xb4 (P)
[    4.574459]  clk_disable+0x38/0x60
[    4.574471]  cqspi_probe+0x7c8/0xc5c [spi_cadence_quadspi]
[    4.574493]  platform_probe+0x5c/0xa4
[    4.574507]  really_probe+0xc0/0x38c
[    4.574517]  __driver_probe_device+0x7c/0x150
[    4.574526]  driver_probe_device+0x40/0x120
[    4.574536]  __driver_attach+0xc8/0x1e0
[    4.574545]  bus_for_each_dev+0x7c/0xdc
[    4.574554]  driver_attach+0x24/0x30
[    4.574566]  bus_add_driver+0x110/0x230
[    4.574575]  driver_register+0x68/0x130
[    4.574585]  __platform_driver_register+0x20/0x2c
[    4.574596]  cqspi_platform_driver_init+0x20/0x1000 [spi_cadence_quadspi]
[    4.574612]  do_one_initcall+0x60/0x1e0
[    4.574626]  do_init_module+0x54/0x240
[    4.574640]  load_module+0x17c0/0x1e60
[    4.574652]  init_module_from_file+0x88/0xc8
[    4.574664]  __arm64_sys_finit_module+0x268/0x360
[    4.574675]  invoke_syscall.constprop.0+0x48/0xc8
[    4.574687]  do_el0_svc+0x9c/0xd8
[    4.574696]  el0_svc+0x3c/0x140
[    4.574708]  el0t_64_sync_handler+0xa0/0xe4
[    4.574718]  el0t_64_sync+0x198/0x19c
[    4.574731] ---[ end trace 0000000000000000 ]---
[    4.576566] ------------[ cut here ]------------


