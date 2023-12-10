Return-Path: <linux-spi+bounces-195-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B0380BD4D
	for <lists+linux-spi@lfdr.de>; Sun, 10 Dec 2023 22:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA27B203E3
	for <lists+linux-spi@lfdr.de>; Sun, 10 Dec 2023 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FD1CF82;
	Sun, 10 Dec 2023 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psVGIfGK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8891CA8A;
	Sun, 10 Dec 2023 21:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A29C433C8;
	Sun, 10 Dec 2023 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702242665;
	bh=sZzRKked3xzptSRcvGavSHnu3Ea2iAGznJRk26/aisA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=psVGIfGKE7xcK5fz2EYbnxEbzRLbw27mCwwYYD8VHyMEVImoE+VK9fBCa4IHx96Fn
	 iirLi5y+9aoX5he6RwF7HxipvkkbNPb6VeSFaVrec1aTY9SShRkyECd13uXslHbNLE
	 dzk83nSDz/+Rzx2nigbcQncdQkLxs0fn6GNsj2LHDH8TVOropyNJXLMFoVAX4E7vEF
	 5fE2NOD4badSy9lElwBE8Oh7ZbCpg6l/EZ/g+T21WSOiqW6QW5K8nFzcEqL0k7/WcA
	 WrghPA7N8iR1KHOsG/FO6zqS2O6BLBefRZDGTLufPEjFzF3uy3sacqBbyTaK5zi0sa
	 hLHU/VZLM1qUA==
From: Mark Brown <broonie@kernel.org>
To: linux@bigler.io, francesco@dolcini.it, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, regressions@lists.linux.dev, 
 stefan.moring@technolution.nl, regressions@leemhuis.info, 
 Benjamin Bigler <benjamin@bigler.one>
In-Reply-To: <20231209222338.5564-1-benjamin@bigler.one>
References: <20231209222338.5564-1-benjamin@bigler.one>
Subject: Re: [PATCH] spi: spi-imx: correctly configure burst length when
 using dma
Message-Id: <170224266337.2977325.7724283128894856611.b4-ty@kernel.org>
Date: Sun, 10 Dec 2023 21:11:03 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sat, 09 Dec 2023 23:23:26 +0100, Benjamin Bigler wrote:
> If DMA is used, burst length should be set to the bus width of the DMA.
> Otherwise, the SPI hardware will transmit/receive one word per DMA
> request.
> Since this issue affects both transmission and reception, it cannot be
> detected with a loopback test.
> Replace magic numbers 512 and 0xfff with MX51_ECSPI_CTRL_MAX_BURST.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: correctly configure burst length when using dma
      commit: e9b220aeacf109684cce36a94fc24ed37be92b05

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


