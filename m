Return-Path: <linux-spi+bounces-4060-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BD493F9BE
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5541F23370
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7BA18130D;
	Mon, 29 Jul 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1z3qdDq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767C1802A8;
	Mon, 29 Jul 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267610; cv=none; b=XCXgUQyVzoG/kLDrxuyNkvEzuSjJsYAsOjCFOUtM/TwUWfdarSBcs1N0oreIb4LMVtens7ZOe5gn9/q2VQSOFiA34dloSI3o+1EyymvejbUO+1nLZk4+PjtbLjqbE27dsq6WKGSln3wA4bt7epng43czhn5drBYJpi9FtgRCsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267610; c=relaxed/simple;
	bh=JEegVRRD+pSt7qGlqVbwF7CSj7IRWY9dFncZB1HxU+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YQwf3WBPWwMJgniSy3B7HuNvyBy3NxrQcOOwSu8rAJL7P78nkzETPLjgNjaiS/LF8gseDU2b+llRLzduh3nVxZRQsPgubydSreIzN8FY/Dj7x9fi4pQ/wf7PujcT/lPmJPvV+ag2hEkfea30wd8mTvPBdy6uNrTSYoz0q14vvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1z3qdDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B646C4AF09;
	Mon, 29 Jul 2024 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267610;
	bh=JEegVRRD+pSt7qGlqVbwF7CSj7IRWY9dFncZB1HxU+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i1z3qdDqX7bHCVzcbpEBOe+1BD/vE5ZKwrbZLk9xrH4LZzJB010JxbsYFEwA3NjPk
	 c/zcL2BdUMeuY+wnrRvAxhWKcOBom83DdHrE0clcr3f8VMTIX0Dmq7ubVybmMWXU37
	 sf+ANqsR7KYdG/1GuSd7MHhq/A01tW436In2zkqa2TuZ7ebqZsAYeOtj1P0PMgDzmh
	 F4ovZENBH5W+tPy9lDn5SlEdnI12vLgOcd3VTR0xbTNNj5UsNjkIxbgsR9vPKaBYzo
	 CQvsQbQMiITeIAWrHZA/9mRca5pi4Mur7xvag5U+6roSEVWLf+WxclTscjafrbYBbL
	 K5c9JSVdhFYVw==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: matthias.bgg@gmail.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com
In-Reply-To: <20240726114721.142196-1-angelogioacchino.delregno@collabora.com>
References: <20240726114721.142196-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] spi: spi-mt65xx: Use threaded interrupt for non-SPIMEM
 transfer
Message-Id: <172226760809.71144.14726035193284084228.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 16:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 26 Jul 2024 13:47:21 +0200, AngeloGioacchino Del Regno wrote:
> In order to avoid blocking for an excessive amount of time, eventually
> impacting on system responsiveness, interrupt handlers should finish
> executing in as little time as possible.
> 
> Use threaded interrupt and move the SPI transfer handling (both
> CPU and DMA) for the non-spimem case to an interrupt thread instead.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mt65xx: Use threaded interrupt for non-SPIMEM transfer
      commit: 5972eb05ca322bb1efe44d32808bc7a331e7aee4

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


