Return-Path: <linux-spi+bounces-8749-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B0AE6EBE
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478461658F9
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24C239E84;
	Tue, 24 Jun 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiAK+Vh9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5C566A;
	Tue, 24 Jun 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790392; cv=none; b=RpOee2ClNumA1hjiydXeeyC2W9ZBniFmyHHq6NdLnlEh+WlhqXcvNi7zIsDax0OfB+VEJrLogh+9ZK2kQ0ycWMjAAPDbMhgq6RhxMJMy4zGT9I8rj8x7m8sP0QJZTonsfyUMmD9G2jBKG0a8wIbPkhhfosLTXugDGBPcysdvYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790392; c=relaxed/simple;
	bh=rkkAw0rgggC/S1XCaWN2yu50izCptwi1Amszzv33gCg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JfBKEG+FHLKyAtyvTFMXAPgkf9sGICuZ3lTKnq6sBr/q0A2zRYMogzSqA7/TXObS2wVxVMDIoo44B0RiraNyx6zRzl9rxPzb4T7HX+JxmkHvlPbrKiRC0JBAUMq3RgQK1vKl4GUzD0mPbejTkhXJD2C17d+850sKq9au+g6CGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiAK+Vh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BADC4CEE3;
	Tue, 24 Jun 2025 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750790392;
	bh=rkkAw0rgggC/S1XCaWN2yu50izCptwi1Amszzv33gCg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JiAK+Vh96OJdFWTXzMHr/R3oO/Ixzx2szCkFrMePCLqKJ6+Ua/GENeJDTZabPiJox
	 /bGsESm+6vZ/syTTeFVzk78r5E0T7HWPKM0mn5NTa2AcLQPlFV+sNvz/RIvOcoKiqu
	 98SSbYKFKRbwqVTZo7TxXAPxRxgycWVHIBBU3nhDU649hVsd24ZeLrR9kgqvxebK4U
	 YLri0l/83bjNqC/VlzJhgTpIuNJEpfumnIXkAW2k3l9QmuhpEdbN3jG6bRQzp+92jX
	 +0MZQ6dTiBeUS7AkABMHtNCCHDDy+lrMElr/77Iv4O7URiWrAGiUaLoZoiectP2GWT
	 KrpxxgMZ03Rkg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthew Gerlach <matthew.gerlach@altera.com>, 
 Khairul Anuar Romli <khairulanuar.romli@altera.com>, 
 khairul.anuar.romli@altera.com
In-Reply-To: <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com>
References: <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com>
Subject: Re: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime
 unbalance
Message-Id: <175079039096.261551.863281864888122610.b4-ty@kernel.org>
Date: Tue, 24 Jun 2025 19:39:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49

On Mon, 16 Jun 2025 09:13:53 +0800, khairul.anuar.romli@altera.com wrote:
> Having PM put sync in remove function is causing PM underflow during
> remove operation. This is caused by the function, runtime_pm_get_sync,
> not being called anywhere during the op. Ensure that calls to
> pm_runtime_enable()/pm_runtime_disable() and
> pm_runtime_get_sync()/pm_runtime_put_sync() match.
> 
> echo 108d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
> [   49.644256] Deleting MTD partitions on "108d2000.spi.0":
> [   49.649575] Deleting u-boot MTD partition
> [   49.684087] Deleting root MTD partition
> [   49.724188] cadence-qspi 108d2000.spi: Runtime PM usage count underflow!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
      commit: b07f349d1864abe29436f45e3047da2bdd476462

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


