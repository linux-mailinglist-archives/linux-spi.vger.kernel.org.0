Return-Path: <linux-spi+bounces-12075-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D703CD6CAB
	for <lists+linux-spi@lfdr.de>; Mon, 22 Dec 2025 18:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 584F730039FB
	for <lists+linux-spi@lfdr.de>; Mon, 22 Dec 2025 17:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448323093AC;
	Mon, 22 Dec 2025 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFINYE8K"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136572C08C2;
	Mon, 22 Dec 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423875; cv=none; b=p4abmRdWM6Z0v7L5hbpliqv5+I1QLzR6Pf4ntO4YlSqWYn7e/wOvhhZG0ITRvxyEU+U4l6T4deW/jbEF229H30GQUX4RkISCrO08nhFzetd118bb0tzKQCBDkOrVw+8sJsi4j7jFQOpW0lcvAJEOc3KXbYYF+XNksCToeQIwHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423875; c=relaxed/simple;
	bh=QOPog1YfYI90StUev6z08ROZmYBb9PrYSSSaMZnFZ+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ko6kRtMPYJyb5LPWS8HKirE+LAjyAq1hisdbjlZao7EDgW+11S2zvBWxljI3nzsC4GgSwU4EmgBJFiZQtIBHhVWDM7B5AA16iKA2uOOVkwouvg0qzozgDHUainJJhpyrSSmog8FC9bZl4lYVbsY6CFcpIh10dyKjmHZUQF14RmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFINYE8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828EBC4CEF1;
	Mon, 22 Dec 2025 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766423874;
	bh=QOPog1YfYI90StUev6z08ROZmYBb9PrYSSSaMZnFZ+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jFINYE8KYwvcfYuyjdl/b6hv5LyI8pyAHMGb7wjXwv/a2jN45PELDtVbvB+cO2/7S
	 bZ3eP+b2YeSUFs0Jt3pHgrnbsxAbPLcIxN0hh+z0lKoDRAKdz2a+ogept/fiSnrRsO
	 FU46Wxei7kFvFOTLekv0h1NP1yg4zb5PfSZLRCqR7xk8dWRWuv586n/ghKB0pTHT/z
	 du8d+kNpLy7MrrwML6FCqqsXp0rpSEg12CzmeED88cUyA9Go2WbQfNWg3MPqB6M9Mn
	 mjSvThDqbi1sXGadFMVVy0RE+nOJQuRI04lkj3+9EAqSG4UAVfa3aKdnvr19fYKw//
	 BYGUtY+EDFOag==
From: Mark Brown <broonie@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251221110513.1850535-1-wens@kernel.org>
References: <20251221110513.1850535-1-wens@kernel.org>
Subject: Re: (subset) [PATCH 0/4] arm64: allwinner: a523: Support SPI
 controllers
Message-Id: <176642387228.913099.2681822678465821683.b4-ty@kernel.org>
Date: Mon, 22 Dec 2025 17:17:52 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Sun, 21 Dec 2025 19:05:07 +0800, Chen-Yu Tsai wrote:
> This series adds support for the SPI controllers found in the Allwinner
> A523 SoC family. The SPI controller is almost the same as the ones in
> previous generations, except that it moved the "RX buffer count"
> register field to a separate register, and that register now reports
> the total count for RX buffer and FIFO.
> 
> In practice the driver has never cared about the buffer count, but if
> any implementation were to use it, this counts as a non-backward
> compatible change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: dt-bindings: sun6i: Add compatibles for A523's SPI controllers
      commit: e0c8755d44eb85afd40100586076c3dc4b62ee3b
[2/4] spi: sun6i: Support A523's SPI controllers
      commit: c81f30bde5b0449d9d82d31a66f0ffd608e610b5

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


