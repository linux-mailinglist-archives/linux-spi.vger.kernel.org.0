Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272A52A6F1B
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 21:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgKDUoJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 15:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730347AbgKDUoJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Nov 2020 15:44:09 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA4B20825;
        Wed,  4 Nov 2020 20:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604522648;
        bh=o0QfSMczmLnJsCOVHz/PGb8+Vm1UfQlMxw1Aki4kxtU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EQOQQ/g98gnWCiFIkLLDHI8qDZB75K2ty9pLDmYDttBvNd9DFjFCubURZd+VK0N7U
         rBrAW/SaPknRuUBCfhzg5JUNE1QLO7HrDkl2j0tH5dlv01/D8G9XLaubodysi50FqA
         mQ0XEsBEQpzXqQz8HVnoJ+wYPnz0doPaQwso6WXE=
Date:   Wed, 04 Nov 2020 20:43:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qiang Zhao <qiang.zhao@nxp.com>, olteanv@gmail.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201029084035.19604-1-qiang.zhao@nxp.com>
References: <20201029084035.19604-1-qiang.zhao@nxp.com>
Subject: Re: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Message-Id: <160452263224.7406.18149040308248180970.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 29 Oct 2020 16:40:35 +0800, Qiang Zhao wrote:
> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in
> remove path"), this driver causes a kernel oops:
> 
> [   64.587431] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000020
> [..]
> [   64.756080] Call trace:
> [   64.758526]  dspi_suspend+0x30/0x78
> [   64.762012]  platform_pm_suspend+0x28/0x70
> [   64.766107]  dpm_run_callback.isra.19+0x24/0x70
> [   64.770635]  __device_suspend+0xf4/0x2f0
> [   64.774553]  dpm_suspend+0xec/0x1e0
> [   64.778036]  dpm_suspend_start+0x80/0xa0
> [   64.781957]  suspend_devices_and_enter+0x118/0x4f0
> [   64.786743]  pm_suspend+0x1e0/0x260
> [   64.790227]  state_store+0x8c/0x118
> [   64.793712]  kobj_attr_store+0x18/0x30
> [   64.797459]  sysfs_kf_write+0x40/0x58
> [   64.801118]  kernfs_fop_write+0x148/0x240
> [   64.805126]  vfs_write+0xc0/0x230
> [   64.808436]  ksys_write+0x6c/0x100
> [   64.811833]  __arm64_sys_write+0x1c/0x28
> [   64.815753]  el0_svc_common.constprop.3+0x68/0x170
> [   64.820541]  do_el0_svc+0x24/0x90
> [   64.823853]  el0_sync_handler+0x118/0x168
> [   64.827858]  el0_sync+0x158/0x180
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-dspi: fix wrong pointer in suspend/resume
      commit: 9bd77a9ce31dd242fece27219d14fbee5068dd85

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
