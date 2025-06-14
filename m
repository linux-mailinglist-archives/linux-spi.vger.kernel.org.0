Return-Path: <linux-spi+bounces-8554-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD66AD9C4D
	for <lists+linux-spi@lfdr.de>; Sat, 14 Jun 2025 13:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277563B58FF
	for <lists+linux-spi@lfdr.de>; Sat, 14 Jun 2025 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7251118A6DF;
	Sat, 14 Jun 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLRhGuDi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D1156677;
	Sat, 14 Jun 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749898882; cv=none; b=Zuz2y1BvQ3im8jzWWfRvVvt73S/DzYzzon2eqbrmfBvMgPuE2FE8MA6+dqRBPO2fY+k3jyY5Y+mPaec/pBHx6PhnFKlddPJZxlXJUYEMINoD2gU5EXRAyb95zTLyOf8Qq7HQm5dN1xDcM3DsQkLa7QfCbGq0XzcvucW5ukyfEmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749898882; c=relaxed/simple;
	bh=enuUPhuo/JbUI2DEWJ66kHzZbT1qSJXbA8n8jA4y4G8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bDaF7T1f4jvEXBL8lJVLTVU9XMJfU2TOQ3HFVdXPcjt7OKaBTvWRhawplsCgxPtoscbIcKHyUI3NHazuj4BR8VpG61FjEwj9lDP1tR4f29PXhnK32j7/Qx6hkphn+b0ay6EsivOnY79VAv5c4pCqLt3df+aFCDAk8gDDRBlsHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLRhGuDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C3AC4CEEB;
	Sat, 14 Jun 2025 11:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749898881;
	bh=enuUPhuo/JbUI2DEWJ66kHzZbT1qSJXbA8n8jA4y4G8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mLRhGuDiVXRgnTfNUD7AJZeY32CydG9ouk/nymwpctEhhVXWQR63gw9hCqNV6UK2x
	 Pgh7NWBZ6/oZMciwg/5WShhamWuRJHL5djCXHMCXhyFT3b4SZxg1MvmxjM9VGB8tFj
	 ugdohn7JTP3T6HD4ha9gCz7dZblGR70bhW0UNXUYE5GkwStV7VyCuH/7LR8Ihh1sGK
	 jzi3WN0ifyiyFAsWvk5sP/jG11F7bslzQUo+tHtyb4q7LWu4soMaslFGJYFHUJC49w
	 f8fqGYb7IlvfVEbVgTFZQjI2BrM69CVbOkGZ8MvoudQaCJqwfgOqD4SEVPNgQf3Z//
	 RxmzYOjamxyYg==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Vishwaroop A <va@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Brad Griffis <bgriffis@nvidia.com>
In-Reply-To: <20250613123037.2082788-1-thierry.reding@gmail.com>
References: <20250613123037.2082788-1-thierry.reding@gmail.com>
Subject: Re: [PATCH] spi: tegra210-qspi: Remove cache operations
Message-Id: <174989888039.16810.4266283693498371215.b4-ty@kernel.org>
Date: Sat, 14 Jun 2025 12:01:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 13 Jun 2025 14:30:37 +0200, Thierry Reding wrote:
> The DMA memory for this driver is allocated using dma_alloc_coherent(),
> which ends up mapping the allocated memory as uncached. Performing the
> various dma_sync_*() operations on this memory causes issues during SPI
> flashing:
> 
> [    7.818017] pc : dcache_inval_poc+0x40/0x58
> [    7.822128] lr : arch_sync_dma_for_cpu+0x2c/0x4c
> [    7.826854] sp : ffff80008193bcf0
> [    7.830267] x29: ffff80008193bcf0 x28: ffffa3fe5ff1e908 x27: ffffa3fe627bb130
> [    7.837528] x26: ffff000086952180 x25: ffff00008015c8ac x24: ffff000086c9b480
> [    7.844878] x23: ffff00008015c800 x22: 0000000000000002 x21: 0000000000010000
> [    7.852229] x20: 0000000106dae000 x19: ffff000080112410 x18: 0000000000000001
> [    7.859580] x17: ffff000080159400 x16: ffffa3fe607a9bd8 x15: ffff0000eac1b180
> [    7.866753] x14: 000000000000000c x13: 0000000000000001 x12: 000000000000025a
> [    7.874104] x11: 0000000000000000 x10: 7f73e96357f6a07f x9 : db1fc8072a7f5e3a
> [    7.881365] x8 : ffff000086c9c588 x7 : ffffa3fe607a9bd8 x6 : ffff80008193bc28
> [    7.888630] x5 : 000000000000ffff x4 : 0000000000000009 x3 : 000000000000003f
> [    7.895892] x2 : 0000000000000040 x1 : ffff000086dbe000 x0 : ffff000086db0000
> [    7.903155] Call trace:
> [    7.905606]  dcache_inval_poc+0x40/0x58 (P)
> [    7.909804]  iommu_dma_sync_single_for_cpu+0xb4/0xb8
> [    7.914617]  __dma_sync_single_for_cpu+0x158/0x194
> [    7.919428]  __this_module+0x5b020/0x5baf8 [spi_tegra210_quad]
> [    7.925291]  irq_thread_fn+0x2c/0xc0
> [    7.928966]  irq_thread+0x16c/0x318
> [    7.932467]  kthread+0x12c/0x214
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-qspi: Remove cache operations
      commit: d57e92dd660014ccac884eda616cafc7b04601e0

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


