Return-Path: <linux-spi+bounces-11072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC629C3A98B
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 12:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1857C4FD83D
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC5A304BB8;
	Thu,  6 Nov 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHW0P00F"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FF2FB0A4;
	Thu,  6 Nov 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428858; cv=none; b=GA+GhHQsgSHEbIUbd2WAKm6Y9YLI8z2Ni9BvynNu1KiZlrlUTq/45/GAcMBp2hKiHYon9g+VCwAiUTE61vi3TtvMajDxl1FlO0ZedNbpgDLueRkSUhpEnqRSJ93YYgLY+RGzefeRjKfVqCCbg1FiatfmmEZkOQ9H1fiouXu7MPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428858; c=relaxed/simple;
	bh=pr09tiToCggAS4rc6VIFUgWhCE0RzwnFLARZtUM8uL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PjMe9DmB20EuTDW834VySds4bX/zByoWiqr9BZ4jEHqUli9SJax5y1hnBAoH9NcDah+MWWEnt5KhKsoUEl19uH9vsitiKfbDtr5//IqmKKsK3RqaBv3bnbztPVl6boce9zYRpMrAn2RnkCwcSR6jXA4Y1d+Ywslj8Q7bdlm2eEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHW0P00F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452E7C4CEFB;
	Thu,  6 Nov 2025 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762428858;
	bh=pr09tiToCggAS4rc6VIFUgWhCE0RzwnFLARZtUM8uL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JHW0P00FpqcmGfKFEFO+H99XwMiaI8qsQ93gcgQ9FsxBiXamV2fblJxbb4sI2NSMn
	 zKoGy0q6/UkMp2SzTUn+6rN4cslFiISfn278Tjt71f/ttw17NPWDQhE2U7thevpHBq
	 qxFzgqpXB3TyP5bAIqktTHX+Wrh1LNTF4mVR/s8/5+WMbYuHrwL63z8PQy2g+otV4T
	 43HGrJRfbeEZqpWfQLMiLGxQlgJB8sbaHN4Y4NhgPuCJWbNcnDdkg7nMgi4/rdigia
	 2NuIKOjD2mgeDOqtPLih/n7oJdPQQauTQCJxOA9RAxCa5fPtdoTZBacbPNcAvSxV3M
	 /4hwps0OnpkEw==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com, 
 kyarlagadda@nvidia.com, Vishwaroop A <va@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251028155703.4151791-1-va@nvidia.com>
References: <20251028155703.4151791-1-va@nvidia.com>
Subject: Re: [PATCH v5 0/3] spi: tegra210-quad: Improve timeout handling
 under high system load
Message-Id: <176242885536.2357454.17489976412691473280.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 11:34:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Tue, 28 Oct 2025 15:57:00 +0000, Vishwaroop A wrote:
> This patch series addresses timeout handling issues in the Tegra QSPI driver
> that occur under high system load conditions. We've observed that when CPUs
> are saturated (due to error injection, RAS firmware activity, or general CPU
> contention), QSPI interrupt handlers can be delayed, causing spurious transfer
> failures even though the hardware completed the operation successfully.
> 
> Patch 1 fixes a stale pointer issue by ensuring curr_xfer is cleared on timeout
> and checked when the IRQ thread finally runs. It also ensures interrupts are
> properly cleared on failure paths.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: tegra210-quad: Fix timeout handling
      commit: b4e002d8a7cee3b1d70efad0e222567f92a73000
[2/3] spi: tegra210-quad: Refactor error handling into helper functions
      commit: 6022eacdda8b0b06a2e1d4122e5268099b62ff5d
[3/3] spi: tegra210-quad: Check hardware status on timeout
      commit: 380fd29d57abe6679d87ec56babe65ddc5873a37

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


