Return-Path: <linux-spi+bounces-11605-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD5CC8B245
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6D83A7EF3
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9D332917;
	Wed, 26 Nov 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYwt2Hab"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5F79C8;
	Wed, 26 Nov 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177028; cv=none; b=m8LqUU1tbFC1PxA/7A8Zx3ZpVOvoa1Ee8Wd1gureKhMaBn3Cmig8S07+bU/TAHeALrvftd8PibL/ZqalTNatRorvKNiRJ+AkFYjuvqxO+ocxETzT6G/Ju4n5oxesucAsZwwsuiJmafrFeofieRXIOEyZLN3gJZPbJcGf0G11bM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177028; c=relaxed/simple;
	bh=x0LfBtJMXJcHbDXKAPA7jz2nH8YGkiNV9Ro1S3U2UpA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KLCJVUtAdMrMnjwYvHU4i2KJQcrhPVajxsDTH9CKSNukP+xuuJJmOGHqLDh4fkuJ/0JU0tc+Pg97dnbI8/DW6PMhf/t81xHdOFiJKYUznZQ4/Vz86vGc9Y6vp/KR1nuSAULp271h7P8geGSnF6m97mp9q9rPrrkETCrnofw7Sr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYwt2Hab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E00C4CEF7;
	Wed, 26 Nov 2025 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764177028;
	bh=x0LfBtJMXJcHbDXKAPA7jz2nH8YGkiNV9Ro1S3U2UpA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lYwt2HabOKZfVgPXlGDxSyElbD4cErHhISRERmxiM/fYSDQo6gp2r4l5h+BFVjVAO
	 A2uUmJT/LW/hYEW9M1XMIA+2+cP/NtkVd4/yGkm0r7VG0U/dAT+Dq88RxVZIA1YX84
	 gd/viAinNFF+r71tcCuHOajm24Sb9BjGc4eAF1USh6qhyFLP0F6XdGPR4bsEHODSCU
	 IlrbQoYR+AjUn6tG4O3tZk5r1xAM9ACrDtB73rR74QYcw568PW0K95HgAAZvP54h/l
	 Wqm2DFZpY2K/FsnJPe9RvPPTa5At+TvTcmXH3wLhn3DRs9Zz7CkY/DjUsQHpaOXndj
	 PbhNrIRMb/z4g==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <treding@nvidia.com>, 
 Gautham Srinivasan <gauthams@nvidia.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Lavra <flavra@baylibre.com>
In-Reply-To: <20251126095027.4102004-1-flavra@baylibre.com>
References: <20251126095027.4102004-1-flavra@baylibre.com>
Subject: Re: [PATCH] spi: tegra114: remove Kconfig dependency on
 TEGRA20_APB_DMA
Message-Id: <176417702689.85368.17056171248019245384.b4-ty@kernel.org>
Date: Wed, 26 Nov 2025 17:10:26 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 26 Nov 2025 10:50:27 +0100, Francesco Lavra wrote:
> This driver runs also on Tegra SoCs without a Tegra20 APB DMA controller
> (e.g. Tegra234).
> Remove the Kconfig dependency on TEGRA20_APB_DMA; in addition, amend the
> help text to reflect the fact that this driver works on SoCs different from
> Tegra114.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: remove Kconfig dependency on TEGRA20_APB_DMA
      commit: 3dcf44ab56e1d3ca3532083c0d5390b758e45b45

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


