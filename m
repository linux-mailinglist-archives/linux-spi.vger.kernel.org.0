Return-Path: <linux-spi+bounces-11729-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC90C9CEE2
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 21:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F9013416F6
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 20:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75A2D6639;
	Tue,  2 Dec 2025 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/9nPZUS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BA248F64;
	Tue,  2 Dec 2025 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764707718; cv=none; b=s6s+mQpfSCeJInutUV20RCQrZZ1xkIiaLlO0uimS+/QIyKQZi5r8CkdylnRU7kpQgj2DCCeenqvHCO70UNZymkM2iP3xuHtTwwBj3rUXgoD/AdieIXfxdcXFkMo46IScrsXmVRzAPtgaCcBcbO/vscW1uX5UfB0RMLUYwZIRKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764707718; c=relaxed/simple;
	bh=66we+d1XKq/Gmo2Noy3MmMN6N4BhMnY0GydR2fDe7FE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V9Kk21AzwbgDDmvC+ANoc1IZShVtCaQUBrZvPBVisGCzyr+Q/VL5KOLW7DuMPloiFr2HPD6rqqd/iaOAEUhSg9OFBRq+VSJ+3SGFnwvXXF99iAfMKxBkjfpvQ3+lQlzeaBvjakZyJxzq19vxGigLjp/FsUxmXYgQ9soiBqA80VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/9nPZUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3D4C4CEF1;
	Tue,  2 Dec 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764707717;
	bh=66we+d1XKq/Gmo2Noy3MmMN6N4BhMnY0GydR2fDe7FE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E/9nPZUShTqto66Nlyy4CfbpYvH84dbjKQGHD53TWjmx/AEtOlnUjx6TQT/XHwi3O
	 xLZFvnyh82bI1BL437NWOrZ7+VDVFBAZ3buG75E2bSzgcVjuQ78PDsYqSGEOWVFDA3
	 A3YNGutiLdRg+HA3tWrM41Tu1qVw1KV7vZEG3EmxmEhMHAIkR3eUAVkiyElkZUIV22
	 s2giehmXZzEDYw4wHzXlrty6joktPAItg7lEQaZ0c06Pxmm2Cd44wZEOOhLk9bmuLI
	 Fj9KwCWLQaLMivPErVTSrJGjzX7+9mq5NjGw/whKsyA+7Kh50JEuVK78wuP+cSt9Ly
	 3LpehyVG/5Ikg==
From: Mark Brown <broonie@kernel.org>
To: Ali Tariq <alitariq45892@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 khairul.anuar.romli@altera.com, adrianhoyin.ng@altera.com, 
 nirav.rabara@altera.com, matthew.gerlach@altera.com
In-Reply-To: <20251130091251.12120-1-alitariq45892@gmail.com>
References: <20251130091251.12120-1-alitariq45892@gmail.com>
Subject: Re: [PATCH] spi: cadence-qspi: Fix runtime PM imbalance in probe
Message-Id: <176470771570.76978.15655951679502590234.b4-ty@kernel.org>
Date: Tue, 02 Dec 2025 20:35:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Sun, 30 Nov 2025 09:12:51 +0000, Ali Tariq wrote:
> The probe function incorrectly calls pm_runtime_put_autosuspend()
> twice in succession at the end of successful probe, dropping two
> runtime PM references while only one was acquired earlier with
> pm_runtime_get_sync(). This causes a usage count underflow:
> 
>     cadence-qspi 13010000.spi: Runtime PM usage count underflow!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-qspi: Fix runtime PM imbalance in probe
      commit: e1f2e77624dbc35f317efd7e092aa91f7136f3f9

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


