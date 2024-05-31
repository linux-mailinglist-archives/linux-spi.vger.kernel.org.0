Return-Path: <linux-spi+bounces-3177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A348D649F
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 16:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97594B27B48
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003C13EA86;
	Fri, 31 May 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E8c3dBaE"
X-Original-To: linux-spi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F1446DE;
	Fri, 31 May 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166245; cv=none; b=gkYErsVaDHwCmQkJNOHk9PINHvNLOhHAm60avzeMkOeJRhbrVSZhxElmbP0ubojBRe1Yve1VsraU2Qhd0mSfrrXganzbG1pp/Lh7Ygkxrdd09EoCqhXOC3ZFwYeBO1GklrK8U0wNPgOkXdtRGdIDKPcVz+m1LfnJ09EKxwvpzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166245; c=relaxed/simple;
	bh=HPuIe86jQjiJ5qqDcosGRGigQrijcd7zrRDUf7Kgoco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/XNKliqDl/GR3SGQ3LRAgxokkGR3B8roP21Amw6EkogW1/ztDZQuGwPxxrufQdBmA+SsaIQYoDa2iuCGcoPZ56Zkph4UpZXPXjVtOt1uEDEk0y64LBWRt4n6t9Kmm53OEyl/nrjbnnLY4vbsCSMfgKk7A4hSsz+HaE4tCC+hRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E8c3dBaE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717166241;
	bh=HPuIe86jQjiJ5qqDcosGRGigQrijcd7zrRDUf7Kgoco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8c3dBaEHpMwn//0KjD6aQSb96TJBfspgpe6lQHwEdaKifjMyVMhuqdQyW4Jj/rm2
	 wKdGg6trCxck1BgU5GSS1deOnVCuvUny8wlmu6UeHYCHfiFiTBrgV6qNE4NsSjq55i
	 pkhxEYxtHuJ89kEsZWzmLTn0Cwx4Zo2V/OWEp1vVf0K6491yCqaOS0acOXvBeBRXnY
	 NF5TxggBIu3b2wZt7y9fEnuv9F1Trwxjx6uGOy8lqosaBcs7ZJgy4mkOL5KYgbiCYE
	 s02lQ/JNy/CUu/4DsAj/SAkQXE80txmPBn9VHvCH/gwvjRfuhtI0MA+eWmmGwEji0D
	 TrSR7aWLA1TnQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0D5AB3782197;
	Fri, 31 May 2024 14:37:20 +0000 (UTC)
Date: Fri, 31 May 2024 10:37:19 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/2] spi: Make dummy SG handling robust
Message-ID: <1ea41944-a107-4528-8e8d-559c06907e3f@notapiano>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531094658.1598969-1-andy.shevchenko@gmail.com>

On Fri, May 31, 2024 at 12:44:31PM +0300, Andy Shevchenko wrote:
> There's an unreliable code to handle DMA mappings on unidirection transfers.
> This series does two things:
> - it reverts the seemingly unnecessary change
> - it reworks dummy SG list handling
> 
> There is no need to backport that AFAIU, but no harm to apply for v6.10 aka
> the current release cycle. Guys, please test these. 
> 
> Andy Shevchenko (2):
>   spi: Revert "Check if transfer is mapped before calling DMA sync APIs"
>   spi: Do not rely on the SG table and respective API implementations
> 
>  drivers/spi/spi.c | 46 +++++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 29 deletions(-)
> 
> -- 
> 2.45.1
> 

Hi Andy,

applying either of these patches causes issues. See the traces for each one
below. This was tested on top of next-20240531, which works fine.

Thanks,
Nícolas

patch 1, spi: Revert "Check if transfer is mapped before calling DMA sync APIs":

[    3.114283] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
[    3.123323] Mem abort info:
[    3.126200]   ESR = 0x0000000096000004
[    3.130053]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.135523]   SET = 0, FnV = 0
[    3.138667]   EA = 0, S1PTW = 0
[    3.141902]   FSC = 0x04: level 0 translation fault
[    3.146913] Data abort info:
[    3.149884]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    3.155521]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    3.160717]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    3.166173] [000000000000001c] user address but active_mm is swapper
[    3.169640] input: cros_ec as /devices/platform/soc@0/ac0000.geniqup/a80000.spi/spi_master/spi6/spi6.0/a80000.spi:ec@0:keyboard-controller/input/input0
[    3.172698] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    3.172703] Modules linked in:
[    3.172708] CPU: 6 PID: 58 Comm: kworker/u32:1 Not tainted 6.10.0-rc1-next-20240531-00003-g60f06088bdb0 #452
[    3.172716] Hardware name: Google Lazor Limozeen without Touchscreen (rev5 - rev8) (DT)
[    3.172720] Workqueue: events_unbound deferred_probe_work_func
[    3.172735] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.172743] pc : iommu_dma_sync_sg_for_device+0x28/0x100
[    3.172755] lr : __dma_sync_sg_for_device+0x28/0x4c
[    3.172764] sp : ffff80008036adc0
[    3.172767] x29: ffff80008036adc0 x28: ffff646682dd4000 x27: ffff646680feb810
[    3.172777] x26: ffff80008036b008 x25: ffff646682dd4480 x24: ffffbf8f359d40e8
[    3.172784] x23: ffff646680feb810 x22: 0000000000000001 x21: 0000000000000000
[    3.172792] x20: ffffbf8f35d3da18 x19: 0000000000000000 x18: ffffbf8f36a1a390
[    3.172799] x17: 0000000000010108 x16: 0000000000000000 x15: 0000000000000002
[    3.172806] x14: 0000000000000001 x13: 0000000000067dc0 x12: 0000000000000001
[    3.172813] x11: ffff80008036acd0 x10: ffff64668370eff8 x9 : ffff646682dd4469
[    3.172821] x8 : ffff646683629704 x7 : 00000000ffffffff x6 : 0000000000000001
[    3.172828] x5 : ffffbf8f3513bdb0 x4 : ffffbf8f34308ccc x3 : 0000000000000001
[    3.172835] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff646680feb810
[    3.172842] Call trace:
[    3.172845]  iommu_dma_sync_sg_for_device+0x28/0x100
[    3.172851]  __dma_sync_sg_for_device+0x28/0x4c
[    3.172856]  spi_transfer_one_message+0x378/0x6e4
[    3.172866]  __spi_pump_transfer_message+0x1e0/0x504
[    3.172875]  __spi_sync+0x2a0/0x3c4
[    3.172882]  spi_sync+0x30/0x54
[    3.172889]  spi_mem_exec_op+0x26c/0x41c
[    3.172898]  spi_nor_spimem_read_data+0x148/0x158
[    3.172906]  spi_nor_read_data+0x30/0x3c
[    3.172913]  spi_nor_read_sfdp+0x74/0xe4
[    3.172922]  spi_nor_parse_sfdp+0x120/0x11d0
[    3.172930]  spi_nor_sfdp_init_params_deprecated+0x3c/0x8c
[    3.172938]  spi_nor_scan+0x5d8/0xe6c
[    3.172946]  spi_nor_probe+0x94/0x2f0
[    3.172954]  spi_mem_probe+0x6c/0xac
[    3.172962]  spi_probe+0x84/0xe4
[    3.172966]  really_probe+0xbc/0x2a0
[    3.172973]  __driver_probe_device+0x78/0x12c
[    3.172980]  driver_probe_device+0x40/0x160
[    3.172986]  __device_attach_driver+0xb8/0x134
[    3.172992]  bus_for_each_drv+0x84/0xe0
[    3.172997]  __device_attach+0xa8/0x1b0
[    3.173004]  device_initial_probe+0x14/0x20
[    3.173010]  bus_probe_device+0xa8/0xac
[    3.173015]  device_add+0x590/0x750
[    3.173026]  __spi_add_device+0x138/0x208
[    3.173033]  of_register_spi_device+0x394/0x57c
[    3.173041]  spi_register_controller+0x394/0x760
[    3.173048]  qcom_qspi_probe+0x328/0x390
[    3.173058]  platform_probe+0x68/0xd8
[    3.173066]  really_probe+0xbc/0x2a0
[    3.173072]  __driver_probe_device+0x78/0x12c
[    3.173078]  driver_probe_device+0x40/0x160
[    3.173084]  __device_attach_driver+0xb8/0x134
[    3.173090]  bus_for_each_drv+0x84/0xe0
[    3.173095]  __device_attach+0xa8/0x1b0
[    3.173101]  device_initial_probe+0x14/0x20
[    3.173108]  bus_probe_device+0xa8/0xac
[    3.173113]  deferred_probe_work_func+0x88/0xc0
[    3.173119]  process_one_work+0x154/0x298
[    3.173131]  worker_thread+0x2f0/0x3f8
[    3.173140]  kthread+0x118/0x11c
[    3.173148]  ret_from_fork+0x10/0x20
[    3.173158] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c20)
[    3.173163] ---[ end trace 0000000000000000 ]---

patch 2, spi: Do not rely on the SG table and respective API implementations:

[    3.085653] Unable to handle kernel paging request at virtual address ffff801000000000
[    3.093815] Mem abort info:
[    3.109892]   ESR = 0x0000000096000145
[    3.109896]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.126955]   SET = 0, FnV = 0
[    3.134900] Unable to handle kernel paging request at virtual address ffff801000000000
[    3.138038]   EA = 0, S1PTW = 0
[    3.138041]   FSC = 0x05: level 1 translation fault
[    3.141183] Mem abort info:
[    3.141185]   ESR = 0x0000000096000145
[    3.149305] Data abort info:
[    3.149308]   ISV = 0, ISS = 0x00000145, ISS2 = 0x00000000
[    3.152530]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.157552]   CM = 1, WnR = 1, TnD = 0, TagAccess = 0
[    3.160417]   SET = 0, FnV = 0
[    3.164276]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    3.167237]   EA = 0, S1PTW = 0
[    3.167240]   FSC = 0x05: level 1 translation fault
[    3.172880] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082d2d000
[    3.178323] Data abort info:
[    3.178325]   ISV = 0, ISS = 0x00000145, ISS2 = 0x00000000
[    3.178330]   CM = 1, WnR = 1, TnD = 0, TagAccess = 0
[    3.183519] [ffff801000000000] pgd=0000000000000000
[    3.186653]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    3.192114] , p4d=1000000100039003
[    3.195339] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082d2d000
[    3.195344] [ffff801000000000] pgd=0000000000000000
[    3.200367] , pud=0000000000000000
[    3.207249] , p4d=1000000100039003, pud=0000000000000000
[    3.207257] Internal error: Oops: 0000000096000145 [#1] PREEMPT SMP
[    3.207262] Modules linked in:
[    3.207267] CPU: 7 PID: 70 Comm: kworker/u32:4 Not tainted 6.10.0-rc1-next-20240531-00003-ge34bac32ec36 #453
[    3.207275] Hardware name: Google Lazor Limozeen without Touchscreen (rev5 - rev8) (DT)
[    3.207278] Workqueue: events_unbound deferred_probe_work_func
[    3.207292] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.207299] pc : dcache_clean_poc+0x20/0x38
[    3.207315] lr : arch_sync_dma_for_device+0x24/0x30
[    3.207323] sp : ffff8000807d2db0
[    3.207325] x29: ffff8000807d2db0 x28: ffff0cc6c0feb810 x27: ffff0cc6c0feb810
[    3.207334] x26: ffff0cc6c339b800 x25: ffff0cc6c339bc80 x24: ffffb9dc0508af48
[    3.207341] x23: 0000000000000001 x22: 0000000000000001 x21: 0000000000000001
[    3.207348] x20: ffffc1ffc0000000 x19: ffff0cc6c32b6d20 x18: ffffb9dc0601a390
[    3.207355] x17: 0000000000010108 x16: 0000000000000000 x15: ffff0cc73b5dd580
[    3.207363] x14: ffff0cc6c09591c0 x13: 0000000000000400 x12: ffffb9dc05c0d000
[    3.207370] x11: 071c71c71c71c71c x10: 0000000000000aa0 x9 : ffff8000807d2c80
[    3.207378] x8 : ffff0cc73b5ec800 x7 : 0000000000000400 x6 : ffff0cc73b5ec828
[    3.207385] x5 : ffffb9dc0473bdb0 x4 : fffffe32d7000000 x3 : 000000000000003f
[    3.207392] x2 : 0000000000000040 x1 : ffff801000000000 x0 : ffff801000000000
[    3.207399] Call trace:
[    3.207402]  dcache_clean_poc+0x20/0x38
[    3.207410]  iommu_dma_sync_sg_for_device+0xd4/0x100
[    3.207420]  __dma_sync_sg_for_device+0x28/0x4c
[    3.207427]  spi_transfer_one_message+0x3a8/0x700
[    3.207436]  __spi_pump_transfer_message+0x1f0/0x504
[    3.207444]  __spi_sync+0x2a0/0x3c4
[    3.207452]  spi_sync+0x30/0x54
[    3.207459]  spi_mem_exec_op+0x26c/0x41c
[    3.207468]  spi_nor_spimem_read_data+0x148/0x158
[    3.207476]  spi_nor_read_data+0x30/0x3c
[    3.207482]  spi_nor_read_sfdp+0x74/0xe4
[    3.207490]  spi_nor_parse_sfdp+0x120/0x11d0
[    3.207499]  spi_nor_sfdp_init_params_deprecated+0x3c/0x8c
[    3.207507]  spi_nor_scan+0x5d8/0xe6c
[    3.207515]  spi_nor_probe+0x94/0x2f0
[    3.207523]  spi_mem_probe+0x6c/0xac
[    3.207531]  spi_probe+0x84/0xe4
[    3.207536]  really_probe+0xbc/0x2a0
[    3.207542]  __driver_probe_device+0x78/0x12c
[    3.207549]  driver_probe_device+0x40/0x160
[    3.207555]  __device_attach_driver+0xb8/0x134
[    3.207562]  bus_for_each_drv+0x84/0xe0
[    3.207567]  __device_attach+0xa8/0x1b0
[    3.207573]  device_initial_probe+0x14/0x20
[    3.207580]  bus_probe_device+0xa8/0xac
[    3.207586]  device_add+0x590/0x750
[    3.207596]  __spi_add_device+0x138/0x208
[    3.207603]  of_register_spi_device+0x394/0x57c
[    3.207611]  spi_register_controller+0x394/0x760
[    3.207619]  qcom_qspi_probe+0x328/0x390
[    3.207628]  platform_probe+0x68/0xd8
[    3.207636]  really_probe+0xbc/0x2a0
[    3.207642]  __driver_probe_device+0x78/0x12c
[    3.207649]  driver_probe_device+0x40/0x160
[    3.207655]  __device_attach_driver+0xb8/0x134
[    3.207660]  bus_for_each_drv+0x84/0xe0
[    3.207666]  __device_attach+0xa8/0x1b0
[    3.207672]  device_initial_probe+0x14/0x20
[    3.207679]  bus_probe_device+0xa8/0xac
[    3.207684]  deferred_probe_work_func+0x88/0xc0
[    3.207690]  process_one_work+0x154/0x298
[    3.207701]  worker_thread+0x2f0/0x3f8
[    3.207711]  kthread+0x118/0x11c
[    3.207719]  ret_from_fork+0x10/0x20
[    3.207729] Code: d2800082 9ac32042 d1000443 8a230000 (d50b7a20)
[    3.207733] ---[ end trace 0000000000000000 ]---
[    3.579215]
[    3.580760] Internal error: Oops: 0000000096000145 [#2] PREEMPT SMP
[    3.580767] Modules linked in:
[    3.580774] CPU: 4 PID: 121 Comm: cros_ec_spi_hig Tainted: G      D            6.10.0-rc1-next-20240531-00003-ge34bac32ec36 #453
[    3.580781] Hardware name: Google Lazor Limozeen without Touchscreen (rev5 - rev8) (DT)
[    3.580785] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.580792] pc : dcache_clean_poc+0x20/0x38
[    3.580806] lr : arch_sync_dma_for_device+0x24/0x30
[    3.580813] sp : ffff800080e7b970
[    3.580815] x29: ffff800080e7b970 x28: ffff0cc6c0fd0010 x27: ffff0cc6c0fd0010
[    3.580823] x26: ffff0cc6c25d1000 x25: ffff0cc6c25d1480 x24: ffffb9dc0508af48
[    3.580830] x23: 0000000000000001 x22: 0000000000000001 x21: 0000000000000001
[    3.580837] x20: ffffc1ffc0000000 x19: ffff0cc6c03a9520 x18: ffffb9dc0601a958
[    3.580845] x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000002
[    3.580852] x14: 0000000000000001 x13: 000000000006931f x12: 0000000000000001
[    3.580859] x11: ffff800080e7b890 x10: ffff0cc6c03bdff8 x9 : ffff0cc6c25d1469
[    3.580867] x8 : ffff0cc6c002b704 x7 : 0000000000000000 x6 : 0000000000000001
[    3.580873] x5 : ffffb9dc0473bdb0 x4 : fffffe32d7000000 x3 : 000000000000003f
[    3.580880] x2 : 0000000000000040 x1 : ffff801000000000 x0 : ffff801000000000
[    3.580889] Call trace:
[    3.580891]  dcache_clean_poc+0x20/0x38
[    3.580897]  iommu_dma_sync_sg_for_device+0xd4/0x100
[    3.580906]  __dma_sync_sg_for_device+0x28/0x4c
[    3.580913]  spi_transfer_one_message+0x3a8/0x700
[    3.580921]  __spi_pump_transfer_message+0x1f0/0x504
[    3.580928]  __spi_sync+0x2a0/0x3c4
[    3.580933]  spi_sync_locked+0x10/0x1c
[    3.580939]  receive_n_bytes+0xc0/0x118
[    3.580947]  do_cros_ec_pkt_xfer_spi+0x3c0/0x530
[    3.580951]  cros_ec_xfer_high_pri_work+0x20/0x34
[    3.580956]  kthread_worker_fn+0xcc/0x184
[    3.580964]  kthread+0x118/0x11c
[    3.580970]  ret_from_fork+0x10/0x20
[    3.580980] Code: d2800082 9ac32042 d1000443 8a230000 (d50b7a20)
[    3.580983] ---[ end trace 0000000000000000 ]---

