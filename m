Return-Path: <linux-spi+bounces-5162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2777995BCF
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 01:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50D0B20A11
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 23:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE31218D6E;
	Tue,  8 Oct 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu6ZlGRZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A2218D64;
	Tue,  8 Oct 2024 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431031; cv=none; b=Eh5RMqZhdLiOitez6nIs1Rm7vvUT+JzGfrCELDXIF2mGTD9bteCPHl6FV+w+YcWRY7E3HcP0BbumVT+eSN87Nm2XIWwBd/3D4SlOsns/vy9X+5mjS4/pamc9v0GUiMAdfpntZI2yZSn8ewSNv3EB/7GbWa6h+x/CSXOmCa36B44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431031; c=relaxed/simple;
	bh=wS/KQGu06xIsULfc+tyBjmIuSFQa5icnoCOazAay/SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9IvKOtVl8MoUwOaRUDmk/VP0hYpomFvCDFZZcy7/AYQSnySwxqkMXNK6cTZI/LMJKhSYIX/SGqKxd5189Eg417GeUHbBu0KxwRDKbIVGpCnztmiPwhjDs+PmyxcCGGJAYoKHM2kynSvd+0O9pRz371tNhlZDoSuLQWnQU48iHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu6ZlGRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27208C4CEC7;
	Tue,  8 Oct 2024 23:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728431030;
	bh=wS/KQGu06xIsULfc+tyBjmIuSFQa5icnoCOazAay/SY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bu6ZlGRZcv1SIr39/DFFLmX9TuIX2peAHh5TnROaLtZDW6LsYnQZzh3c3NBfVe+CP
	 /1GDeAixD0szvqctBawLYzNymiu1ZsQn6EBTY+4TgQC3bJa+uyMLOm0VoH7SY4wwax
	 Xr0SkqR3mIl5T/LHwq9oDlbD60lyjZvVtuu+HqR8d1nSgiP0TE9/dI1IXc7A2K85h9
	 qaLHUQI3MO+3yU6suol5vMejvltb3UaIf0CFOueZwCB8G9vQinzICCE4eiirMFo0/3
	 AVdXMObr4OqdF+Dzemx1bpc/EElRNgd5zSd/cCIMJHgspnSSdeMSyT5Tdvmj6CKKP4
	 kZcnVAWfxOUPA==
Message-ID: <779e1e8a-93f3-4f90-a51b-11729ee5f875@kernel.org>
Date: Wed, 9 Oct 2024 02:43:41 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/63] 6.1.111-rc1 review
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, linux-spi@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
References: <20240916114221.021192667@linuxfoundation.org>
 <CA+G9fYtsjFtddG8i+k-SpV8U6okL0p4zpsTiwGfNH5GUA8dWAA@mail.gmail.com>
 <b0dfa622-f4f7-4f76-9d67-621544cb2212@kernel.org>
 <32aa7502-ae52-4119-9e72-6347c32f1f23@stanley.mountain>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <32aa7502-ae52-4119-9e72-6347c32f1f23@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.24 18:42, Dan Carpenter wrote:
> On Wed, Sep 18, 2024 at 03:08:13PM +0300, Georgi Djakov wrote:
>>> Warning log:
>>> --------
>>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
>>> [    0.000000] Linux version 6.1.111-rc1 (tuxmake@tuxmake)
>>> (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils
>>> for Debian) 2.43) #1 SMP PREEMPT @1726489583
>>> [    0.000000] Machine model: Thundercomm Dragonboard 845c
>>> ...
>>> [    7.841428] ------------[ cut here ]------------
>>> [    7.841431] WARNING: CPU: 4 PID: 492 at
>>> drivers/interconnect/core.c:685 __icc_enable
>>> (drivers/interconnect/core.c:685 (discriminator 7))
>>> [    7.841442] Modules linked in: soundwire_bus(+) venus_core(+)
>>> qcom_camss(+) drm_dp_aux_bus bluetooth(+) qcom_stats mac80211(+)
>>> videobuf2_dma_sg drm_display_helper i2c_qcom_geni(+) i2c_qcom_cci
>>> camcc_sdm845(+) v4l2_mem2mem qcom_q6v5_mss(+) videobuf2_memops
>>> reset_qcom_pdc spi_geni_qcom(+) videobuf2_v4l2 phy_qcom_qmp_usb(+)
>>> videobuf2_common gpi(+) qcom_rng cfg80211 phy_qcom_qmp_ufs ufs_qcom(+)
>>> coresight_stm phy_qcom_qmp_pcie stm_core rfkill slim_qcom_ngd_ctrl
>>> qrtr pdr_interface lmh qcom_wdt slimbus icc_osm_l3 qcom_q6v5_pas(+)
>>> icc_bwmon llcc_qcom qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common
>>> qcom_glink_smem qmi_helpers mdt_loader display_connector
>>> drm_kms_helper drm socinfo rmtfs_mem
>>> [    7.841494] CPU: 4 PID: 492 Comm: (udev-worker) Not tainted 6.1.111-rc1 #1
>>> [    7.841497] Hardware name: Thundercomm Dragonboard 845c (DT)
>>> [    7.841499] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [    7.841502] pc : __icc_enable (drivers/interconnect/core.c:685
>>> (discriminator 7))
>>> [    7.841505] lr : icc_disable (drivers/interconnect/core.c:708)
>>> [    7.841508] sp : ffff800008b23660
>>> [    7.841509] x29: ffff800008b23660 x28: ffff800008b23c20 x27: 0000000000000000
>>> [    7.841513] x26: ffffdd85da6ea1c0 x25: 0000000000000008 x24: 00000000000f4240
>>> [    7.841516] x23: 0000000000000000 x22: ffff46a58b7ca580 x21: 0000000000000001
>>> [    7.841519] x20: ffff46a58b7ca5c0 x19: ffff46a58b54a800 x18: 0000000000000000
>>> [    7.841522] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>> [    7.841525] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>> [    7.841528] x11: fefefefefefefeff x10: 0000000000000bf0 x9 : ffffdd85d8c9b0bc
>>> [    7.841531] x8 : ffff800008b22f58 x7 : 0000000000000000 x6 : 0000000000024404
>>> [    7.841535] x5 : 0000000000000000 x4 : ffff46a58b64b180 x3 : ffffdd85daa5e810
>>> [    7.841537] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>>> [    7.841541] Call trace:
>>> [    7.841542] __icc_enable (drivers/interconnect/core.c:685 (discriminator 7))
>>> [    7.841545] icc_disable (drivers/interconnect/core.c:708)
>>> [    7.841547] geni_icc_disable (drivers/soc/qcom/qcom-geni-se.c:862)
>>> [    7.841553] spi_geni_runtime_suspend+0x3c/0x4c spi_geni_qcom
>>> [    7.841561] pm_generic_runtime_suspend (drivers/base/power/generic_ops.c:28)
>>> [    7.841565] __rpm_callback (drivers/base/power/runtime.c:395)
>>> [    7.841568] rpm_callback (drivers/base/power/runtime.c:532)
>>> [    7.841570] rpm_suspend (drivers/base/power/runtime.c:672)
>>> [    7.841572] rpm_idle (drivers/base/power/runtime.c:504 (discriminator 1))
>>> [    7.841574] update_autosuspend (drivers/base/power/runtime.c:1662)
>>> [    7.841576] pm_runtime_disable_action (include/linux/spinlock.h:401
>>> drivers/base/power/runtime.c:1703 include/linux/pm_runtime.h:599
>>> drivers/base/power/runtime.c:1517)
>>> [    7.841579] devm_action_release (drivers/base/devres.c:720)
>>> [    7.841581] release_nodes (drivers/base/devres.c:503)
>>> [    7.841583] devres_release_all (drivers/base/devres.c:532)
>>> [    7.841585] device_unbind_cleanup (drivers/base/dd.c:531)
>>> [    7.841589] really_probe (drivers/base/dd.c:710)
>>> [    7.841592] __driver_probe_device (drivers/base/dd.c:785)
>>> [    7.841594] driver_probe_device (drivers/base/dd.c:815)
>>> [    7.841596] __driver_attach (drivers/base/dd.c:1202)
>>> [    7.841598] bus_for_each_dev (drivers/base/bus.c:301)
>>> [    7.841600] driver_attach (drivers/base/dd.c:1219)
>>> [    7.841602] bus_add_driver (drivers/base/bus.c:618)
>>> [    7.841604] driver_register (drivers/base/driver.c:246)
>>> [    7.841607] __platform_driver_register (drivers/base/platform.c:868)
>>> [    7.841609] spi_geni_driver_init+0x28/0x1000 spi_geni_qcom
> 
> 
> So it looks like spi_geni_probe() calls geni_icc_get() which fails.  It must
> be with -EPROBE_DEFER otherwise we would get a printk.  This could happen if
> of_icc_get_from_provider() fails for example.  There are two callers.  These
> were the only possibilities that I saw which didn't lead to a warning message.

Apologies that it took me some time to get the board and reproduce it.
The case is slightly different - geni_icc_get() is not failing, but it's
the spi_geni_grab_gpi_chan() that sometimes returns -EPROBE_DEFER and then
devres starts freeing the driver resources and it does it in reverse order,
so for this driver the order is:

[    7.138679] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_icc_release (8 bytes)
[    7.138751] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_icc_release (8 bytes)
[    7.138827] geni_spi 880000.spi: DEVRES REL ffff800081443800 pm_runtime_disable_action (16 bytes)
[    7.139494] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_pm_opp_config_release (16 bytes)
[    7.139512] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_spi_release_controller (8 bytes)
[    7.139516] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_clk_release (16 bytes)
[    7.139519] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_ioremap_release (8 bytes)
[    7.139524] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_region_release (24 bytes)
[    7.139527] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_kzalloc_release (22 bytes)
[    7.139530] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_pinctrl_release (8 bytes)
[    7.139539] geni_spi 880000.spi: DEVRES REL ffff800081443800 devm_kzalloc_release (40 bytes)

The issue here is that pm_runtime_disable_action() results in a call to
spi_geni_runtime_suspend(), which attempts to suspend the device and
disable an interconnect path that devm_icc_release() has just released.

This could be easily reproduced by adding a sleep in the beginning of the
probe function of the GPI DMA driver to make the SPI driver probe defer.

The first commit that introduced this issue seems to be:
89e362c883c6 ("spi: geni-qcom: Undo runtime PM changes at driver exit time")

Here is a link to the patch i submitted to enable runtime_pm after the
driver gets all resources (including the interconnects). This approach
ensures that when devres releases resources in reverse order, it will
start with pm_runtime_disable_action(), suspending the device, and then
proceed to free the remaining resources:

https://lore.kernel.org/r/20241008231615.430073-1-djakov@kernel.org/


> The automatic cleanup tries to suspend and triggers the warning IS_ERR() warning
> in __icc_enable().
> 
> 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
> 
> The best option is probably to disable the warning for EPROBE_DEFER.  Another
> two options would be to disable the warning entirely.  A third option would be
> to do a work-around for EPROBE_DEFER in geni_icc_get().
> 
> Please, could you take a look and give the Reported-by tag to Naresh?  Or I
> could send this patch if you want.

> regards,
> dan carpenter
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 4526ff2e1bd5..0caf8ead6573 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -682,6 +682,8 @@ static int __icc_enable(struct icc_path *path, bool enable)
>   	if (!path)
>   		return 0;
>   
> +	if (IS_ERR(path) && (PTR_ERR(path) == -EPROBE_DEFER))
> +		return 0;
>   	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
>   		return -EINVAL;

This change will not help as it's the !path->num_nodes that triggered the warning.

Thanks,
Georgi


