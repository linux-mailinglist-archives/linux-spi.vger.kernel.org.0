Return-Path: <linux-spi+bounces-4800-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189F5976EF0
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D37A1C23B29
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043481AB6CA;
	Thu, 12 Sep 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKz/8Nxj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4431865E6;
	Thu, 12 Sep 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159391; cv=none; b=BhOwD/REIZofSLHZqLGS2tk97ez6rxlODk27ab2hsubFvhQeX09aG4gJBSQooW6JgFlpNbYYt7Xg0LdYu95yYqmBIFOfMlEbOdvPTcc/7xVsREXsx998stKvDM1Us88UP5ihDN2emNE4knww1fh9Gug39sPLo8uI6isIZ9kTKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159391; c=relaxed/simple;
	bh=n+QV9j1Ge5Ea/KwCCvA6nCHhIuLYtuF4jbktTu4YuQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tVuYIG9eul5V5pmYkxgKNRtKkm0zbHYar685ZQorAt6/qSvj0o++xku8VbUQfl54r29pVBonN3TwwD0J8gYSeviSU/5fg+s7bjfxVEYe4r3DgEQ9X1fzPnWJAwdufXzqnDxOFL1tXpS+KETGtAvIMGiww3fu7QqGmlxKgfG39dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKz/8Nxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8112BC4CEC4;
	Thu, 12 Sep 2024 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726159391;
	bh=n+QV9j1Ge5Ea/KwCCvA6nCHhIuLYtuF4jbktTu4YuQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sKz/8NxjKRsYURXuA4G5xnYe/IrWf6VyneykXNjnDDNA5QesG/zTbw1+RNFFoysba
	 NWLSCoHPwL1dt2mopnv2WYL7bKBkxWwUtD/11rVfYkjbnSKXe+iU3LmawIMq+feFNb
	 Q5OaKQ0Ky5xPbJD7OeGdtbQcCPZuGAH3xrBeqeAtjv27QfROCr54G2J3l4WE5/Iqjb
	 xobz2Xrme0gTxY1YtF1MvvSENC5/dpvFYCT+b6IXBWAgrNVFWkbxBY+xjFo0ltXeSR
	 8TvK5LokZmNvMdT5yCoxY8S+u0x0yV7wRT8RwP8igeq52q52VHvP6KHbjWxG48mFoO
	 beEeQ50FzTIXQ==
From: Mark Brown <broonie@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Boris Brezillon <bbrezillon@kernel.org>, Han Xu <han.xu@nxp.com>
Cc: stable@kernel.org, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240911211146.3337068-1-han.xu@nxp.com>
References: <20240911211146.3337068-1-han.xu@nxp.com>
Subject: Re: [PATCH] spi: nxp-fspi: fix the KASAN report out-of-bounds bug
Message-Id: <172615938925.65102.8851660910253859623.b4-ty@kernel.org>
Date: Thu, 12 Sep 2024 17:43:09 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 16:11:45 -0500, Han Xu wrote:
> Change the memcpy length to fix the out-of-bounds issue when writing the
> data that is not 4 byte aligned to TX FIFO.
> 
> To reproduce the issue, write 3 bytes data to NOR chip.
> 
> dd if=3b of=/dev/mtd0
> [   36.926103] ==================================================================
> [   36.933409] BUG: KASAN: slab-out-of-bounds in nxp_fspi_exec_op+0x26ec/0x2838
> [   36.940514] Read of size 4 at addr ffff00081037c2a0 by task dd/455
> [   36.946721]
> [   36.948235] CPU: 3 UID: 0 PID: 455 Comm: dd Not tainted 6.11.0-rc5-gc7b0e37c8434 #1070
> [   36.956185] Hardware name: Freescale i.MX8QM MEK (DT)
> [   36.961260] Call trace:
> [   36.963723]  dump_backtrace+0x90/0xe8
> [   36.967414]  show_stack+0x18/0x24
> [   36.970749]  dump_stack_lvl+0x78/0x90
> [   36.974451]  print_report+0x114/0x5cc
> [   36.978151]  kasan_report+0xa4/0xf0
> [   36.981670]  __asan_report_load_n_noabort+0x1c/0x28
> [   36.986587]  nxp_fspi_exec_op+0x26ec/0x2838
> [   36.990800]  spi_mem_exec_op+0x8ec/0xd30
> [   36.994762]  spi_mem_no_dirmap_read+0x190/0x1e0
> [   36.999323]  spi_mem_dirmap_write+0x238/0x32c
> [   37.003710]  spi_nor_write_data+0x220/0x374
> [   37.007932]  spi_nor_write+0x110/0x2e8
> [   37.011711]  mtd_write_oob_std+0x154/0x1f0
> [   37.015838]  mtd_write_oob+0x104/0x1d0
> [   37.019617]  mtd_write+0xb8/0x12c
> [   37.022953]  mtdchar_write+0x224/0x47c
> [   37.026732]  vfs_write+0x1e4/0x8c8
> [   37.030163]  ksys_write+0xec/0x1d0
> [   37.033586]  __arm64_sys_write+0x6c/0x9c
> [   37.037539]  invoke_syscall+0x6c/0x258
> [   37.041327]  el0_svc_common.constprop.0+0x160/0x22c
> [   37.046244]  do_el0_svc+0x44/0x5c
> [   37.049589]  el0_svc+0x38/0x78
> [   37.052681]  el0t_64_sync_handler+0x13c/0x158
> [   37.057077]  el0t_64_sync+0x190/0x194
> [   37.060775]
> [   37.062274] Allocated by task 455:
> [   37.065701]  kasan_save_stack+0x2c/0x54
> [   37.069570]  kasan_save_track+0x20/0x3c
> [   37.073438]  kasan_save_alloc_info+0x40/0x54
> [   37.077736]  __kasan_kmalloc+0xa0/0xb8
> [   37.081515]  __kmalloc_noprof+0x158/0x2f8
> [   37.085563]  mtd_kmalloc_up_to+0x120/0x154
> [   37.089690]  mtdchar_write+0x130/0x47c
> [   37.093469]  vfs_write+0x1e4/0x8c8
> [   37.096901]  ksys_write+0xec/0x1d0
> [   37.100332]  __arm64_sys_write+0x6c/0x9c
> [   37.104287]  invoke_syscall+0x6c/0x258
> [   37.108064]  el0_svc_common.constprop.0+0x160/0x22c
> [   37.112972]  do_el0_svc+0x44/0x5c
> [   37.116319]  el0_svc+0x38/0x78
> [   37.119401]  el0t_64_sync_handler+0x13c/0x158
> [   37.123788]  el0t_64_sync+0x190/0x194
> [   37.127474]
> [   37.128977] The buggy address belongs to the object at ffff00081037c2a0
> [   37.128977]  which belongs to the cache kmalloc-8 of size 8
> [   37.141177] The buggy address is located 0 bytes inside of
> [   37.141177]  allocated 3-byte region [ffff00081037c2a0, ffff00081037c2a3)
> [   37.153465]
> [   37.154971] The buggy address belongs to the physical page:
> [   37.160559] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x89037c
> [   37.168596] flags: 0xbfffe0000000000(node=0|zone=2|lastcpupid=0x1ffff)
> [   37.175149] page_type: 0xfdffffff(slab)
> [   37.179021] raw: 0bfffe0000000000 ffff000800002500 dead000000000122 0000000000000000
> [   37.186788] raw: 0000000000000000 0000000080800080 00000001fdffffff 0000000000000000
> [   37.194553] page dumped because: kasan: bad access detected
> [   37.200144]
> [   37.201647] Memory state around the buggy address:
> [   37.206460]  ffff00081037c180: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
> [   37.213701]  ffff00081037c200: fa fc fc fc 05 fc fc fc 03 fc fc fc 02 fc fc fc
> [   37.220946] >ffff00081037c280: 06 fc fc fc 03 fc fc fc fc fc fc fc fc fc fc fc
> [   37.228186]                                ^
> [   37.232473]  ffff00081037c300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   37.239718]  ffff00081037c380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   37.246962] ==================================================================
> [   37.254394] Disabling lock debugging due to kernel taint
> 0+1 records in
> 0+1 records out
> 3 bytes copied, 0.335911 s, 0.0 kB/s
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: fix the KASAN report out-of-bounds bug
      commit: 2a8787c1cdc7be24fdd8953ecd1a8743a1006235

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


