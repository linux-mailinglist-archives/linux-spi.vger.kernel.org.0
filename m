Return-Path: <linux-spi+bounces-4854-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648897BBEB
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15C9B24B94
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF6188A13;
	Wed, 18 Sep 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZywdXSN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3E188CD9;
	Wed, 18 Sep 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661305; cv=none; b=UsnvGwmTV+cKJCvder+8x7V/CgX6g+7iRc7sIqE/epgN4BA49/7gnG5tdtfMXKtVWOqNjwTJK8L69FDBcje7CgWCS4NTxaEXSC/Jy8s79TnZm6drEHfHLhOEr2PVmsxG9Jo3LpfA3QQz6o88sXCMvfGuFZzTOdlbZKXYTWbzqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661305; c=relaxed/simple;
	bh=s6ujqAZl6yNgAHcXaqe0dNoBS10wZ1WN6q3IJZNOUns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAxKj0AzlgjFRAQPncZ2mMeeVMwvMh/d6gDnUmxMOW95BeCOyNGpwVokWL/GAgB+oju3PPsa+ol9FqFjUHqCJzLLMDYtn8C8l5Rt28z5np7/sXO/QxzL9PC2wKrAX4aACQ4jfnjqsIDtgYC1yZkW2jrPTWAZAPUfYH6WBDJpuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZywdXSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350CAC4CEC3;
	Wed, 18 Sep 2024 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726661303;
	bh=s6ujqAZl6yNgAHcXaqe0dNoBS10wZ1WN6q3IJZNOUns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aZywdXSNWTIfX/1yh7km9McsZgz4f0DT7EG9cBNARKFjSWi08nFOFWc9WMHzWF+Fx
	 f4q/8kMcQCLGdaK+6zTatsKlLNWhMdAJ/JCmlYfRmhoKdArt9t+8rxeWWbFtoKi+EI
	 PWpINcE+o0zLcRJ7EqbHCiF87hhzA8CRKsqXpJgzUhM2GtJ9AOf0fg3SvbaRQ8EIf8
	 6VYMJ82hmncoKCgv9D0nMSMay+CWK+GaBbyQrRJBzJ6X9ZYjz7iYVghsszSXxtKH/K
	 hh7C12v81u9djY7OXZPwoh5JyBThspiJDy99w8H0FntzMIyMubHnOs0YqnMejyUiKO
	 xqFoaiYc3wPFA==
Message-ID: <b0dfa622-f4f7-4f76-9d67-621544cb2212@kernel.org>
Date: Wed, 18 Sep 2024 15:08:13 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/63] 6.1.111-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org, Jinjie Ruan
 <ruanjinjie@huawei.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-spi@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
References: <20240916114221.021192667@linuxfoundation.org>
 <CA+G9fYtsjFtddG8i+k-SpV8U6okL0p4zpsTiwGfNH5GUA8dWAA@mail.gmail.com>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <CA+G9fYtsjFtddG8i+k-SpV8U6okL0p4zpsTiwGfNH5GUA8dWAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.24 17:43, Naresh Kamboju wrote:
> On Mon, 16 Sept 2024 at 17:29, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 6.1.111 release.
>> There are 63 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.111-rc1.gz
>> or in the git tree and branch at:
>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> 
> The following kernel warnings have been noticed on a Qualcomm db845c device
> running stable-rc  6.1.111-rc1, 6.6.52-rc1 and 6.10.11-rc1 at boot time.
> 
> First seen on 6.1.111-rc1
>    Good: v6.1.110
>    BAD:  6.1.111-rc1
> 

Hi Naresh,

Do you see this warning on every boot or only sometimes? I am not able to
reproduce it on my db845c board even with your binaries.

I see however one geni runtime PM change that very likely triggers this
warning, so if you are doing a bisect, maybe try reverting that one first.

Thanks,
Georgi

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Warning log:
> --------
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
> [    0.000000] Linux version 6.1.111-rc1 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils
> for Debian) 2.43) #1 SMP PREEMPT @1726489583
> [    0.000000] Machine model: Thundercomm Dragonboard 845c
> ...
> [    7.841428] ------------[ cut here ]------------
> [    7.841431] WARNING: CPU: 4 PID: 492 at
> drivers/interconnect/core.c:685 __icc_enable
> (drivers/interconnect/core.c:685 (discriminator 7))
> [    7.841442] Modules linked in: soundwire_bus(+) venus_core(+)
> qcom_camss(+) drm_dp_aux_bus bluetooth(+) qcom_stats mac80211(+)
> videobuf2_dma_sg drm_display_helper i2c_qcom_geni(+) i2c_qcom_cci
> camcc_sdm845(+) v4l2_mem2mem qcom_q6v5_mss(+) videobuf2_memops
> reset_qcom_pdc spi_geni_qcom(+) videobuf2_v4l2 phy_qcom_qmp_usb(+)
> videobuf2_common gpi(+) qcom_rng cfg80211 phy_qcom_qmp_ufs ufs_qcom(+)
> coresight_stm phy_qcom_qmp_pcie stm_core rfkill slim_qcom_ngd_ctrl
> qrtr pdr_interface lmh qcom_wdt slimbus icc_osm_l3 qcom_q6v5_pas(+)
> icc_bwmon llcc_qcom qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common
> qcom_glink_smem qmi_helpers mdt_loader display_connector
> drm_kms_helper drm socinfo rmtfs_mem
> [    7.841494] CPU: 4 PID: 492 Comm: (udev-worker) Not tainted 6.1.111-rc1 #1
> [    7.841497] Hardware name: Thundercomm Dragonboard 845c (DT)
> [    7.841499] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    7.841502] pc : __icc_enable (drivers/interconnect/core.c:685
> (discriminator 7))
> [    7.841505] lr : icc_disable (drivers/interconnect/core.c:708)
> [    7.841508] sp : ffff800008b23660
> [    7.841509] x29: ffff800008b23660 x28: ffff800008b23c20 x27: 0000000000000000
> [    7.841513] x26: ffffdd85da6ea1c0 x25: 0000000000000008 x24: 00000000000f4240
> [    7.841516] x23: 0000000000000000 x22: ffff46a58b7ca580 x21: 0000000000000001
> [    7.841519] x20: ffff46a58b7ca5c0 x19: ffff46a58b54a800 x18: 0000000000000000
> [    7.841522] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [    7.841525] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [    7.841528] x11: fefefefefefefeff x10: 0000000000000bf0 x9 : ffffdd85d8c9b0bc
> [    7.841531] x8 : ffff800008b22f58 x7 : 0000000000000000 x6 : 0000000000024404
> [    7.841535] x5 : 0000000000000000 x4 : ffff46a58b64b180 x3 : ffffdd85daa5e810
> [    7.841537] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    7.841541] Call trace:
> [    7.841542] __icc_enable (drivers/interconnect/core.c:685 (discriminator 7))
> [    7.841545] icc_disable (drivers/interconnect/core.c:708)
> [    7.841547] geni_icc_disable (drivers/soc/qcom/qcom-geni-se.c:862)
> [    7.841553] spi_geni_runtime_suspend+0x3c/0x4c spi_geni_qcom
> [    7.841561] pm_generic_runtime_suspend (drivers/base/power/generic_ops.c:28)
> [    7.841565] __rpm_callback (drivers/base/power/runtime.c:395)
> [    7.841568] rpm_callback (drivers/base/power/runtime.c:532)
> [    7.841570] rpm_suspend (drivers/base/power/runtime.c:672)
> [    7.841572] rpm_idle (drivers/base/power/runtime.c:504 (discriminator 1))
> [    7.841574] update_autosuspend (drivers/base/power/runtime.c:1662)
> [    7.841576] pm_runtime_disable_action (include/linux/spinlock.h:401
> drivers/base/power/runtime.c:1703 include/linux/pm_runtime.h:599
> drivers/base/power/runtime.c:1517)
> [    7.841579] devm_action_release (drivers/base/devres.c:720)
> [    7.841581] release_nodes (drivers/base/devres.c:503)
> [    7.841583] devres_release_all (drivers/base/devres.c:532)
> [    7.841585] device_unbind_cleanup (drivers/base/dd.c:531)
> [    7.841589] really_probe (drivers/base/dd.c:710)
> [    7.841592] __driver_probe_device (drivers/base/dd.c:785)
> [    7.841594] driver_probe_device (drivers/base/dd.c:815)
> [    7.841596] __driver_attach (drivers/base/dd.c:1202)
> [    7.841598] bus_for_each_dev (drivers/base/bus.c:301)
> [    7.841600] driver_attach (drivers/base/dd.c:1219)
> [    7.841602] bus_add_driver (drivers/base/bus.c:618)
> [    7.841604] driver_register (drivers/base/driver.c:246)
> [    7.841607] __platform_driver_register (drivers/base/platform.c:868)
> [    7.841609] spi_geni_driver_init+0x28/0x1000 spi_geni_qcom
> [    7.841615] do_one_initcall (init/main.c:1298)
> [    7.841619] do_init_module (kernel/module/main.c:2469)
> [    7.841623] load_module (kernel/module/main.c:2878)
> [    7.841625] __do_sys_finit_module (kernel/module/main.c:2978
> (discriminator 1))
> [    7.841627] __arm64_sys_finit_module (kernel/module/main.c:2945)
> [    7.841630] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:57)
> [    7.841633] el0_svc_common.constprop.0
> (arch/arm64/include/asm/daifflags.h:28
> arch/arm64/kernel/syscall.c:148)
> [    7.841637] do_el0_svc (arch/arm64/kernel/syscall.c:205)
> [    7.841639] el0_svc (arch/arm64/include/asm/daifflags.h:28
> arch/arm64/kernel/entry-common.c:133
> arch/arm64/kernel/entry-common.c:142
> arch/arm64/kernel/entry-common.c:638)
> [    7.841644] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:656)
> [    7.841647] el0t_64_sync (arch/arm64/kernel/entry.S:585)
> [    7.841649] ---[ end trace 0000000000000000 ]---



