Return-Path: <linux-spi+bounces-11672-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71CC95FFD
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 08:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BD194E047D
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 07:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376172BDC10;
	Mon,  1 Dec 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="s9ONCtd1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FA2147F9;
	Mon,  1 Dec 2025 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574142; cv=none; b=V8tWATgsXEz5WMtJP1PuCjwlBerZSKROFCrjaj7aIqs1N3UdK8AlytH1uxVCAMKN9kb+SZW2kWzl8vQA5cmKi8dZ2JrsKVs0g9yn4ioiwQ7iavP+wMFh7TfNk7zMijeH9O3MZuIGV9cndIgnslspf166Dq5h/0OZYzRHlnsgYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574142; c=relaxed/simple;
	bh=9TyT9agbd5KWDhUI2TWCIfxo5mm55XgIQcGPBNofkvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPHS43YnekIczGcv6DOMZs72+rr2puntMAQ1GoskrkJS1ikHiRaShqFhoiNgFwAQJy11HhpBFek3BS/EfFtiGDRLzSCbWvIChIFrMIbT6C+oiWY4//58NUl6nVNdD9npJtaAEuExSP1s74qS07gBrXR0eIiYxzuVdXAY7eTxJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=s9ONCtd1; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 82ACF1F9FF;
	Mon,  1 Dec 2025 08:28:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1764574128;
	bh=nIRqu9hIeFFQnNUJGwzEnZBWx7bhBU9Lh5U8ZdZII9I=; h=From:To:Subject;
	b=s9ONCtd1wpqIPccix5zixOpHKY7svMfvdEOHCZm+rmLQUyHM7kDDLGWnFEit4oaaw
	 jaj/j0sXebaVv+V1TnC7rWgdBkq3jh6kNQr+WHlCbzo6Xx7H0dpjfs7eRnoLUEysiN
	 OoQoZj5jtsH6Mi8KBncLTXUcm6DMYKPFoBaGwNC7v4G3lITVc9imKZTvX1pwbpF5ph
	 m1EMECvWn9pvIrs1627psrUp7tdzXLPwYevawoe+Uwrwf8MJA63RtuDTv2KcdgtFm3
	 sRqbc0v1v6i+duoADOa3EeUc8h8eUPvUzm5UFFsQDoURTbJouEJ260rpiK9iCkpzoQ
	 oQIc+Cu60TOqg==
Date: Mon, 1 Dec 2025 08:28:44 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, broonie@kernel.org
Cc: a-dutta@ti.com, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] spi: cadence-quadspi: Fix cqspi_probe() error handling
 for runtime pm
Message-ID: <20251201072844.GA6785@francesco-nb>
References: <20251119152545.2591651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119152545.2591651-1-s-vadapalli@ti.com>

Hello Siddharth, Mark,

On Wed, Nov 19, 2025 at 08:53:53PM +0530, Siddharth Vadapalli wrote:
> Commit f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier
> to avoid imbalance") relocated code but missed updating the error handling
> path associated with it.
> 
> Prior to the relocation, runtime pm was enabled after the code-block
> associated with 'cqspi_request_mmap_dma()', due to which, the error
> handling for the same didn't require invoking 'pm_runtime_disable()'.
> 
> Post refactoring, runtime pm has been enabled before the code-block and
> when an error is encountered, jumping to 'probe_dma_failed' doesn't
> invoke 'pm_runtime_disable()'. This leads to a race condition wherein
> 'cqspi_runtime_suspend()' is invoked while the error handling path executes
> in parallel. The resulting error is the following:
> 
>   clk:103:0 already disabled
>   WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x80/0xa0, CPU#1: kworker/u8:0/12
>   [TRIMMED]
>   pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : clk_core_disable+0x80/0xa0
>   lr : clk_core_disable+0x80/0xa0
>   [TRIMMED]
>   Call trace:
>    clk_core_disable+0x80/0xa0 (P)
>    clk_core_disable_lock+0x88/0x10c
>    clk_disable+0x24/0x30
>    cqspi_probe+0xa3c/0xae8
>   [TRIMMED]
> 
> The error is due to the second invocation of 'clk_disable_unprepare()' on
> 'cqspi->clk' in the error handling within 'cqspi_probe()', with the first
> invocation being within 'cqspi_runtime_suspend()'.
> 
> Fix this by correcting the error handling.
> 
> Fixes: f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to avoid imbalance")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Our CI just hit this WARNING with 6.18 kernel, on verdin-am62. To me it's a
regression from v6.18, specifically from spi-fix-v6.18-rc7, we did not
had any such WARNING with the master build we did run last Friday.


[    8.648915] cadence-qspi fc40000.spi: No flash device declared
[    8.675671] cadence-qspi fc40000.spi: failed to setup flash parameters -19
[    8.693691] ------------[ cut here ]------------
[    8.693719] clk:75:7 already disabled
[    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/clk.c:1188 clk_core_disable+0xa0/0xb4
[    8.693822] Modules linked in: gf128mul(+) snd_soc_simple_card(+) snd_soc_simple_card_utils spi_cadence_quadspi(+) optee tee usb_conn_gpio gpio_keys display_connector roles dwc3_am62 rtc_ti_k3 ti_k3_r5_remoteproc k3_j72xx_bandgap ti_k3_m4_remoteproc ti_k3_common tidss sa2ul sha512 snd_soc_davinci_mcasp drm_display_helper libsha512 snd_soc_ti_udma sha256 sha1 cec snd_soc_ti_edma pruss omap_mailbox snd_soc_ti_sdma omap_hwspinlock authenc bluetooth ecdh_generic ecc ina2xx tpm_tis_i2c rfkill snd_soc_wm8904 libaes lm75 lontium_lt8912b crc_ccitt i3c ti_ads1015 tpm_tis_core industrialio_triggered_buffer kfifo_buf tps65219_pwrbutton tpm rng_core m_can_platform m_can tc358768 can_dev spi_omap2_mcspi pwm_tiehrpwm loop fuse ipv6 libsha1 autofs4
[    8.694064] CPU: 1 UID: 0 PID: 185 Comm: (udev-worker) Not tainted 6.18.0-0.0.0-devel #1 PREEMPT
[    8.694076] Hardware name: Toradex Verdin AM62 on Dahlia Board (DT)
[    8.694083] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.694091] pc : clk_core_disable+0xa0/0xb4
[    8.694100] lr : clk_core_disable+0xa0/0xb4
[    8.694108] sp : ffff800081023800
[    8.694112] x29: ffff800081023800 x28: ffffd3298dc06158 x27: ffff00000189d410
[    8.694127] x26: ffff00000189d410 x25: ffffd3298dc2e428 x24: ffff00000189d400
[    8.694141] x23: 0000000000000000 x22: ffff000006202000 x21: 0000000000000000
[    8.694156] x20: 0000000000000000 x19: ffff000001ad2200 x18: fffffffffffe7988
[    8.694169] x17: 0000000000000000 x16: 0000000000000006 x15: ffffd329953fe4b0
[    8.694183] x14: 0000000000000000 x13: 64656c6261736964 x12: 2079646165726c61
[    8.694197] x11: 0000000000000058 x10: 0000000000000018 x9 : ffffd329953fe538
[    8.694211] x8 : 0000000000057fa8 x7 : 00000000000001ad x6 : 0000000000000001
[    8.694225] x5 : ffff00003fda46c8 x4 : 0000000000000000 x3 : 0000000000000027
[    8.694239] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003670000
[    8.694255] Call trace:
[    8.694261]  clk_core_disable+0xa0/0xb4 (P)
[    8.694272]  clk_disable+0x38/0x60
[    8.694283]  cqspi_probe+0x7c8/0xc5c [spi_cadence_quadspi]
[    8.694309]  platform_probe+0x5c/0xa4
[    8.694324]  really_probe+0xc0/0x38c
[    8.694334]  __driver_probe_device+0x7c/0x150
[    8.694344]  driver_probe_device+0x40/0x120
[    8.694353]  __driver_attach+0xc8/0x1e0
[    8.694362]  bus_for_each_dev+0x7c/0xdc
[    8.694371]  driver_attach+0x24/0x30
[    8.694380]  bus_add_driver+0x110/0x230
[    8.694389]  driver_register+0x68/0x130
[    8.694400]  __platform_driver_register+0x20/0x2c
[    8.694410]  cqspi_platform_driver_init+0x20/0x1000 [spi_cadence_quadspi]
[    8.694424]  do_one_initcall+0x60/0x1e0
[    8.694439]  do_init_module+0x54/0x240
[    8.694455]  load_module+0x17c0/0x1e60
[    8.694465]  init_module_from_file+0x88/0xc8
[    8.694477]  __arm64_sys_finit_module+0x268/0x360
[    8.694488]  invoke_syscall.constprop.0+0x48/0xc8
[    8.694501]  do_el0_svc+0x9c/0xd8
[    8.694510]  el0_svc+0x3c/0x140
[    8.694524]  el0t_64_sync_handler+0xa0/0xe4
[    8.694533]  el0t_64_sync+0x198/0x19c
[    8.694545] ---[ end trace 0000000000000000 ]---
[    8.694555] ------------[ cut here ]------------


Francesco


