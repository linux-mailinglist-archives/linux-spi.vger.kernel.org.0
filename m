Return-Path: <linux-spi+bounces-12007-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 252B4CCB2F0
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3736630194C7
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D993314DB;
	Thu, 18 Dec 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWkJWrxl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E7330312;
	Thu, 18 Dec 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050367; cv=none; b=CpAXWZCpCbtGET3CO2KodcHR7RAeK1YZ1HpxrwXPxpFd9UibuS37Rp5KK7gxH6xbYbyrZdTRUfIsqu596eN/4p+bt3AAzl3dzf4MILLUKZEyV8p8SO2XSaew1LGLFPrl802nt3g2cCz2IphY6H5A27FwUhNKZHMScmfWPacYta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050367; c=relaxed/simple;
	bh=EmiIbPa6X4DKatbuQDc7tsWvsXgaT+/yE9dmtiGJ3Dw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K3ZjRUWVYxO6+KRv/U44z394Rl+TMYODe0qUygDz/H/lpUtYDCbzYWUqn84IRquIeimDQryPT2RjOggO8k1zaH4Dfat12KNFkU+46WRmYpMJ/yUSek7nb5Rss8FmzY601eI5gteXBNgyAFQ95I8X99E+UQi7sj4MD1wz1TKG/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWkJWrxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BFAC113D0;
	Thu, 18 Dec 2025 09:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766050366;
	bh=EmiIbPa6X4DKatbuQDc7tsWvsXgaT+/yE9dmtiGJ3Dw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TWkJWrxlS6+eZz8tR51NzAkqsdx9IBHze2yvHWtdT45Gayl7mzY7jh+qDjk/CKXRU
	 IrWlXMD0h66Zp1DNe1ym9/pQBhcDkSbyO8Ob+w3pLLjDA994xCiOoX3VvInhOLs4+t
	 P6SGS2ZFxDx6E5NiEZnvvr6XnQytZlvrH4fz7M0II9VE3PqSiBZ7W8mBzjSKWGzY2Z
	 +4DrdlBxuB0ZNCZ9NQqWu8Q7exEj/8TNfZg+ltEiHG8tsotNASr9QZ0JpmHpzUF2tm
	 OgtpLEJ8FjWORGPGQvVLU4klRWNWKcLnI8QPczlUy7cC8kaUo58b44s0qRtyDftBBb
	 9FwnOgG1frKMQ==
From: Mark Brown <broonie@kernel.org>
To: Anurag Dutta <a-dutta@ti.com>
Cc: grmoore@opensource.altera.com, nm@ti.com, francesco@dolcini.it, 
 s-vadapalli@ti.com, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gehariprasath@ti.com, u-kumar1@ti.com
In-Reply-To: <20251212072312.2711806-1-a-dutta@ti.com>
References: <20251212072312.2711806-1-a-dutta@ti.com>
Subject: Re: [PATCH 0/2] spi: cadence-quadspi: Fix probe error path and
 logging
Message-Id: <176605036414.87569.10391818297150077809.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 09:32:44 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 12 Dec 2025 12:53:10 +0530, Anurag Dutta wrote:
> This series addresses issues in the cadence-quadspi driver's probe
> error path:
> 
> Patch 1 fixes a clock disable imbalance that occurs when probe fails
> after runtime PM is enabled, particularly when DMA request returns
> -EPROBE_DEFER.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cadence-quadspi: Add error logging for DMA request failure
      commit: b1f54d7143e0f527cca1091857a786e278d72184
[2/2] spi: cadence-quadspi: Fix clock disable on probe failure path
      commit: 1889dd2081975ce1f6275b06cdebaa8d154847a9

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


