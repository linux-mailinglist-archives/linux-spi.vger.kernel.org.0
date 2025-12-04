Return-Path: <linux-spi+bounces-11755-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D96CA2F50
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 10:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B0A0302D6EF
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7733C1BE;
	Thu,  4 Dec 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="b/1v/zaS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732D33C1B9;
	Thu,  4 Dec 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839628; cv=none; b=j6+/UHfl2pnMkbRIrsLcoR+bS40uKLP6JoJMQPM86wSeYdIIBEW3d6dp9Ehtov974nAcK1T6g/gQk6Kve+ePID7x16MxlMTpERJRLdIF5M8dHfVVY25vzMDglW2YGHVzYxDG3dKLW7miNK6wH1Dz5hQluaPoxaOHdvw18b7ceGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839628; c=relaxed/simple;
	bh=wfbSbaWyFFBGRDhQAIbjUUHVQuhqP/UeP0JJDwjJiWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br2CM/I4Aydo/OE1RssHidEaKfr5DKjWOm+OoFbRRPvcChpFhirwzyvsQd+kVpTCALH5wW9TxOclEbPfmGdyGn/NfZD5y/Yca8DWlIRBi6ta9+3oJ/6gYUgIPEUxULQQlyK8Qi4LqQBONmvddsXj907l730n+e7v0KshRBEYkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=b/1v/zaS; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 920C21FB70;
	Thu,  4 Dec 2025 10:13:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1764839615;
	bh=FCvm8NB2mjkwoFh/137wbYHLyhq16Db2hwU6duYeg6U=;
	h=Received:From:To:Subject;
	b=b/1v/zaSyY7KoLQLKkAH0+IJLeyvgCUfoQiQlRxcxtmE/CFrU2pN7kjdadk2oZL8G
	 arjyIJvhCrchmb/3ON1ObO1ovvJWzbjH7ZAKPVNM84xNDUSOtI7uKRPeR820JaPfiK
	 ij4j++PZRqHgwF/PCCvMaN87YhXPfyq7mXeTZFfr7ln+od18T+rFsUM6GTM33yFsWp
	 OMSP881uRV8+f0iP4rE9+1LoAYgzUf0/4U/ecRkFf9BYl4hLIkA/fhk0j8bjN7QuTI
	 vB5XGO5XPreTUWTFhjQ6yH8NuadknYvfn3F358Lf8QXW3JU3AjFPopJEDbPp0CiV/b
	 hG6mBVOFB2gIQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 4C9507FA27; Thu,  4 Dec 2025 10:13:35 +0100 (CET)
Date: Thu, 4 Dec 2025 10:13:35 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Anurag Dutta <a-dutta@ti.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Fix clock enable underflows due to
 runtime PM
Message-ID: <aTFQv157O-wJjVrZ@gaggiata.pivistrello.it>
References: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-spi-cadence-qspi-runtime-pm-imbalance-v1-1-aee8c7fa21f2@kernel.org>

Hello Mark,

On Tue, Dec 02, 2025 at 10:53:44PM +0000, Mark Brown wrote:
> The recent refactoring of where runtime PM is enabled done in commit
> f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
> avoid imbalance") made the fact that when we do a pm_runtime_disable()
> in the error paths of probe() we can trigger a runtime disable which in
> turn results in duplicate clock disables. Early on in the probe function
> we do a pm_runtime_get_noresume() since the probe function leaves the
> device in a powered up state but in the error path we can't assume that PM
> is enabled so we also manually disable everything, including clocks. This
> means that when runtime PM is active both it and the probe function release
> the same reference to the main clock for the IP, triggering warnings from
> the clock subsystem:
> 
> [    8.693719] clk:75:7 already disabled
> [    8.693791] WARNING: CPU: 1 PID: 185 at /usr/src/kernel/drivers/clk/clk.c:1188 clk_core_disable+0xa0/0xb
> ...
> [    8.694261]  clk_core_disable+0xa0/0xb4 (P)
> [    8.694272]  clk_disable+0x38/0x60
> [    8.694283]  cqspi_probe+0x7c8/0xc5c [spi_cadence_quadspi]
> [    8.694309]  platform_probe+0x5c/0xa4
> 
> Avoid this confused ownership by moving the pm_runtime_get_noresume() to
> after the last point at which the probe() function can fail.
> 
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/r/20251201072844.GA6785@francesco-nb
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Cc: stable@vger.kernel.org

Unless I did some stupid mistake testing the patch, it does not fix the issue.
Here the log with v6.18 + this patch


[    6.347380] ------------[ cut here ]------------
[    6.352025] clk:75:7 already disabled
[    6.355727] WARNING: CPU: 2 PID: 180 at drivers/clk/clk.c:1188 clk_core_disable+0xa4/0xac
[    6.363921] Modules linked in: aes_ce_blk aes_ce_cipher ghash_ce gf128mul snd_soc_simple_card(+) 
snd_soc_simple_card_utils spi_cadence_quadspi(+) optee(+) display_connector tee tps65219_pwrbutton u
sb_conn_gpio gpio_keys dwc3_am62 roles k3_j72xx_bandgap ti_ads1015 industrialio_triggered_buffer kfi
fo_buf sa2ul hci_uart sha512 bluetooth rtc_ti_k3 ecdh_generic libsha512 sha256 ecc snd_soc_davinci_m
casp snd_soc_ti_udma rfkill sha1 authenc snd_soc_ti_edma wave5 libaes snd_soc_ti_sdma cdns_dsi cdns_
dphy omap_hwspinlock lm75 omap_mailbox snd_soc_nau8822 i3c ina2xx lontium_lt8912b m_can_platform m_c
an can_dev pwm_tiehrpwm spi_omap2_mcspi fuse ipv6 libsha1 autofs4
[    6.421984] CPU: 2 UID: 0 PID: 180 Comm: (udev-worker) Not tainted 6.18.0+ #2 PREEMPT 
[    6.429902] Hardware name: Toradex Verdin AM62P WB on Verdin Development Board (DT)
[    6.437555] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.444515] pc : clk_core_disable+0xa4/0xac
[    6.448708] lr : clk_core_disable+0xa4/0xac
[    6.452896] sp : ffff800080bd37f0
[    6.456234] x29: ffff800080bd37f0 x28: 0000000000000000 x27: ffff000001924810
[    6.463406] x26: ffff000001924810 x25: ffffd9bd273e0408 x24: ffff000001924800
[    6.470554] x23: 0000000000000000 x22: ffff000001439800 x21: 00000000ffffffed
[    6.477693] x20: ffff000002476c00 x19: ffff000002476c00 x18: 0000000000000006
[    6.484831] x17: 0000000000000000 x16: ffffd9bd3f665260 x15: 0720072007200720
[    6.491970] x14: 0720072007200720 x13: 0720072007200720 x12: ffffd9bd401ee538
[    6.499108] x11: 0000000000000058 x10: 0000000000000018 x9 : ffffd9bd401ee538
[    6.506242] x8 : 0000000000000194 x7 : ffffd9bd40246538 x6 : ffffd9bd40246538
[    6.513380] x5 : ffff00007fb886c8 x4 : 0000000000000000 x3 : 0000000000000027
[    6.520518] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000005504300
[    6.527656] Call trace:
[    6.530104]  clk_core_disable+0xa4/0xac (P)
[    6.534296]  clk_disable+0x30/0x4c
[    6.537706]  cqspi_probe+0x7c0/0xc64 [spi_cadence_quadspi]
[    6.543209]  platform_probe+0x5c/0xa4
[    6.546885]  really_probe+0xc0/0x39c
[    6.550467]  __driver_probe_device+0x7c/0x14c
[    6.554831]  driver_probe_device+0x3c/0x120
[    6.559022]  __driver_attach+0xc4/0x200
[    6.559387] lt8912 1-0048: supply vccmipirx not found, using dummy regulator
[    6.562855]  bus_for_each_dev+0x7c/0xdc
[    6.573734]  driver_attach+0x24/0x30
[    6.577315]  bus_add_driver+0x110/0x240
[    6.581158]  driver_register+0x68/0x130
[    6.585001]  __platform_driver_register+0x24/0x30
[    6.589714]  cqspi_platform_driver_init+0x20/0x1000 [spi_cadence_quadspi]
[    6.596516]  do_one_initcall+0x60/0x1e0
[    6.600363]  do_init_module+0x54/0x23c
[    6.604126]  load_module+0x1810/0x1f14
[    6.607886]  init_module_from_file+0x88/0xcc
[    6.612168]  __arm64_sys_finit_module+0x264/0x358
[    6.616883]  invoke_syscall.constprop.0+0x50/0xe0
[    6.619334] lt8912 1-0048: supply vccsysclk not found, using dummy regulator
[    6.621583]  do_el0_svc+0xa8/0xe0
[    6.631945]  el0_svc+0x3c/0x148
[    6.635095]  el0t_64_sync_handler+0xa0/0xf0
[    6.639285]  el0t_64_sync+0x198/0x19c
[    6.642955] ---[ end trace 0000000000000000 ]---
[    6.655277] ------------[ cut here ]------------
[    6.659991] clk:75:7 already unprepared
[    6.667941] WARNING: CPU: 2 PID: 180 at drivers/clk/clk.c:1047 clk_core_unprepare+0xe4/0x104
[    6.668689] lt8912 1-0048: supply vcclvdstx not found, using dummy regulator
[    6.676411] Modules linked in: spidev evdev(+) rng_core aes_ce_blk aes_ce_cipher ghash_ce gf128mu
l snd_soc_simple_card snd_soc_simple_card_utils spi_cadence_quadspi(+) optee display_connector tee t
ps65219_pwrbutton usb_conn_gpio gpio_keys dwc3_am62 roles k3_j72xx_bandgap ti_ads1015 industrialio_t
riggered_buffer kfifo_buf sa2ul hci_uart sha512 bluetooth rtc_ti_k3 ecdh_generic libsha512 sha256 ec
c snd_soc_davinci_mcasp snd_soc_ti_udma rfkill sha1 authenc snd_soc_ti_edma wave5 libaes snd_soc_ti_
sdma cdns_dsi cdns_dphy omap_hwspinlock lm75 omap_mailbox snd_soc_nau8822 i3c ina2xx lontium_lt8912b
 m_can_platform m_can can_dev pwm_tiehrpwm spi_omap2_mcspi fuse ipv6 libsha1 autofs4
[    6.699332] lt8912 1-0048: supply vcchdmitx not found, using dummy regulator
[    6.743120] CPU: 2 UID: 0 PID: 180 Comm: (udev-worker) Tainted: G        W           6.18.0+ #2 P
REEMPT 
[    6.743139] Tainted: [W]=WARN
[    6.743142] Hardware name: Toradex Verdin AM62P WB on Verdin Development Board (DT)
[    6.743147] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.743153] pc : clk_core_unprepare+0xe4/0x104
[    6.743168] lr : clk_core_unprepare+0xe4/0x104
[    6.743175] sp : ffff800080bd37f0
[    6.743178] x29: ffff800080bd37f0 x28: 0000000000000000 x27: ffff000001924810
[    6.796577] x26: ffff000001924810 x25: ffffd9bd273e0408 x24: ffff000001924800
[    6.799311] lt8912 1-0048: supply vcclvdspll not found, using dummy regulator
[    6.803704] x23: 0000000000000000 x22: ffff000001439800 x21: 00000000ffffffed
[    6.803713] x20: 0000000000000000 x19: ffff000002476c00 x18: 0000000000000000
[    6.803723] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    6.803731] x14: 000000000000008f x13: 00000000efe4b99a x12: 00009b471872c248
[    6.803740] x11: 00000000000000c0 x10: 00000000000009e0 x9 : ffff800080bd3660
[    6.803749] x8 : ffff000005504d40 x7 : 000000000000b67e x6 : 000000000000ba61
[    6.803758] x5 : 0000000078b6e217 x4 : 0000000000000818 x3 : 0000000000800000
[    6.803767] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000005504300
[    6.803777] Call trace:
[    6.803781]  clk_core_unprepare+0xe4/0x104 (P)
[    6.825908] lt8912 1-0048: supply vcchdmipll not found, using dummy regulator
[    6.832255]  clk_unprepare+0x2c/0x44
[    6.832266]  cqspi_probe+0x7c8/0xc64 [spi_cadence_quadspi]
[    6.832286]  platform_probe+0x5c/0xa4
[    6.894596]  really_probe+0xc0/0x39c
[    6.898176]  __driver_probe_device+0x7c/0x14c
[    6.902534]  driver_probe_device+0x3c/0x120
[    6.906715]  __driver_attach+0xc4/0x200
[    6.910548]  bus_for_each_dev+0x7c/0xdc
[    6.914380]  driver_attach+0x24/0x30
[    6.917954]  bus_add_driver+0x110/0x240
[    6.921789]  driver_register+0x68/0x130
[    6.925627]  __platform_driver_register+0x24/0x30
[    6.930333]  cqspi_platform_driver_init+0x20/0x1000 [spi_cadence_quadspi]
[    6.937128]  do_one_initcall+0x60/0x1e0
[    6.940968]  do_init_module+0x54/0x23c
[    6.944720]  load_module+0x1810/0x1f14
[    6.948471]  init_module_from_file+0x88/0xcc
[    6.952740]  __arm64_sys_finit_module+0x264/0x358
[    6.957445]  invoke_syscall.constprop.0+0x50/0xe0
[    6.962149]  do_el0_svc+0xa8/0xe0
[    6.965463]  el0_svc+0x3c/0x148
[    6.968605]  el0t_64_sync_handler+0xa0/0xf0
[    6.972785]  el0t_64_sync+0x198/0x19c
[    6.976447] ---[ end trace 0000000000000000 ]---



