Return-Path: <linux-spi+bounces-5294-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 989599AB9B2
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 00:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80711C22958
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2024 22:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91C1CDFB9;
	Tue, 22 Oct 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFrdho52"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C81CCEE9;
	Tue, 22 Oct 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637553; cv=none; b=GNQ0GYjeI78Gbc0KS5f+bmMUY4X6HaQ14xbK6AYe5du0B8MJjujj5snniR34RCfe9HgOo8cY1NeDm8POCdyQ6g5flG7F9ixk9ZP/udOyltQnvN86/f9f8X8PKWJAYxU0vfeSwP/UQsp4XRrmi5xXDo0S7YNA1uTBKMoL0byNVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637553; c=relaxed/simple;
	bh=i/0ucoJtSqM3wkZDrFshvTpgmRsNladqxEEUJ92EY6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rs8ujcehaq8lyNGxHwqT3zlQdnLjfAtgHMfkjVNjK/kGwvlUXL4MxCNngwE99pnMiJK3AaaTb6hDux/sHM7FrykxjUe93MaasZ8SEKkf+rnimDPClEpMa0BtYx0mS/Uo58RwvIlntjPG3xyGBRAsota5AOvhh1MyK65rPN3d0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFrdho52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1809BC4CEC3;
	Tue, 22 Oct 2024 22:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729637552;
	bh=i/0ucoJtSqM3wkZDrFshvTpgmRsNladqxEEUJ92EY6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cFrdho52ux6O+BBpbpypFQp0vrZEminlSJMIw2i2wjQZpzwLQyzLcyEDziKjZ8h/T
	 aBeY9sx0MoABj8wjf0r+e0sVLqTCJ7UnKeQVqSH7Q9qDqYp+sw0RBCkeyrOUN+XtwA
	 /gWO3uEUjQ/v+kQQ7okUsa30vVQ1pMM3cuXC8AD0lVw1XKPaziXc3uRQkcwWL+I4Fu
	 XeQtC5Uxa1Nuyz1vGBsWTYcRSMh9xMf+Pm2ZG1mQr/WP5iLZxc5FMXVkG6majiDqbY
	 YEAaTn5/KUSv3/oseW7XPmjZLvtIWdTV7ujDb1WIhDqddUDh+pTbQl1Y5NGgI8GFPD
	 edwNRNEUs8QWQ==
From: Mark Brown <broonie@kernel.org>
To: djakov@kernel.org
Cc: ruanjinjie@huawei.com, dmitry.baryshkov@linaro.org, 
 dan.carpenter@linaro.org, naresh.kamboju@linaro.org, 
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Linux Kernel Functional Testing <lkft@linaro.org>
In-Reply-To: <20241008231615.430073-1-djakov@kernel.org>
References: <20241008231615.430073-1-djakov@kernel.org>
Subject: Re: [PATCH] spi: geni-qcom: Fix boot warning related to pm_runtime
 and devres
Message-Id: <172963755080.323092.17496886890952668285.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 23:52:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 09 Oct 2024 02:16:15 +0300, djakov@kernel.org wrote:
> During boot, users sometimes observe the following warning:
> 
> [7.841431] WARNING: CPU: 4 PID: 492 at
> drivers/interconnect/core.c:685 __icc_enable
> (drivers/interconnect/core.c:685 (discriminator 7))
> [..]
> [7.841494] CPU: 4 PID: 492 Comm: (udev-worker) Not tainted 6.1.111-rc1 #1
> [7.841497] Hardware name: Thundercomm Dragonboard 845c (DT)
> [7.841499] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [7.841502] pc : __icc_enable (drivers/interconnect/core.c:685
> (discriminator 7))
> [7.841505] lr : icc_disable (drivers/interconnect/core.c:708)
> [..]
> [7.841541] Call trace:
> [7.841542] __icc_enable (drivers/interconnect/core.c:685 (discriminator 7))
> [7.841545] icc_disable (drivers/interconnect/core.c:708)
> [7.841547] geni_icc_disable (drivers/soc/qcom/qcom-geni-se.c:862)
> [7.841553] spi_geni_runtime_suspend+0x3c/0x4c spi_geni_qcom
> [7.841561] pm_generic_runtime_suspend (drivers/base/power/generic_ops.c:28)
> [7.841565] __rpm_callback (drivers/base/power/runtime.c:395)
> [7.841568] rpm_callback (drivers/base/power/runtime.c:532)
> [7.841570] rpm_suspend (drivers/base/power/runtime.c:672)
> [7.841572] rpm_idle (drivers/base/power/runtime.c:504 (discriminator 1))
> [7.841574] update_autosuspend (drivers/base/power/runtime.c:1662)
> [7.841576] pm_runtime_disable_action (include/linux/spinlock.h:401
> drivers/base/power/runtime.c:1703 include/linux/pm_runtime.h:599
> drivers/base/power/runtime.c:1517)
> [7.841579] devm_action_release (drivers/base/devres.c:720)
> [7.841581] release_nodes (drivers/base/devres.c:503)
> [7.841583] devres_release_all (drivers/base/devres.c:532)
> [7.841585] device_unbind_cleanup (drivers/base/dd.c:531)
> [7.841589] really_probe (drivers/base/dd.c:710)
> [7.841592] __driver_probe_device (drivers/base/dd.c:785)
> [7.841594] driver_probe_device (drivers/base/dd.c:815)
> [7.841596] __driver_attach (drivers/base/dd.c:1202)
> [7.841598] bus_for_each_dev (drivers/base/bus.c:301)
> [7.841600] driver_attach (drivers/base/dd.c:1219)
> [7.841602] bus_add_driver (drivers/base/bus.c:618)
> [7.841604] driver_register (drivers/base/driver.c:246)
> [7.841607] __platform_driver_register (drivers/base/platform.c:868)
> [7.841609] spi_geni_driver_init+0x28/0x1000 spi_geni_qcom
> [7.841615] do_one_initcall (init/main.c:1298)
> [7.841619] do_init_module (kernel/module/main.c:2469)
> [7.841623] load_module (kernel/module/main.c:2878)
> [..]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: geni-qcom: Fix boot warning related to pm_runtime and devres
      commit: d0ccf760a405d243a49485be0a43bd5b66ed17e2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


