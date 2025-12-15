Return-Path: <linux-spi+bounces-11899-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E5CBE9C1
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F7F306EF6A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF233328F8;
	Mon, 15 Dec 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp/pMdAs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73F3328F0;
	Mon, 15 Dec 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807175; cv=none; b=KLiqmjha3/bDs7OZMEkRbMrJ4gvofHnMUuYaq+obf9dBJ9U3UL+CnU+tFWJca5QglRgKqBogT+ac/JoSDJ9/4HNmCAYwDSvkf+9O6vi+RMYB1Wq3zCDpzWtP1llWXot6/On597ox9dI7ShyX1xs8y5hJQl/x2tyCT/1rw36ctnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807175; c=relaxed/simple;
	bh=F/G/9D/MfKM0tJrztBRflOEn1hJgcQ9gnt2LlbM8maA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iXcmyszp/Uavl39j/aT06jwr7c+0WUelAfz27GU2rgu5FO6gi9tCVc49Pa2dGmXPjJvyLBrdYvAam7WIOWAmUvVZkteStYnrM1ZQa+HiyK+MMb0svVJrVI8OHP2XhrrnWSJY4Qe82S5jvGRJ0atT0wOPJxyeofw0UQvSjZpzyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp/pMdAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C7EC4CEFB;
	Mon, 15 Dec 2025 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807175;
	bh=F/G/9D/MfKM0tJrztBRflOEn1hJgcQ9gnt2LlbM8maA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Yp/pMdAs8qpvfkWrpXzDYmo4xrzmz+SzLR2HCgK05ukKvTVlrpAecmEhbUr0krhPD
	 Y9+arISqYmJw4nv32BN5dzwtpNjGaE7XVQ6+yWKvA4A+NjqZ2SetCZL2gBCrscz9vh
	 wDo7ZNi7crnMHJQZkQaidxnI1EhbtcsXTIKOjN+G37QD/tKG4VJMQaKf1mmuxeCDN9
	 alUv0X19Vat8lf7wJysqHicI4jXwBrX0tqa8ZQjxAYYNi+l0WvEZ7+9E5h6whD5MhG
	 REjRy7a2lKXT2L06Z5tKtQh963WgaTYXNXDYJf9XCLD5lfh9bMGnqnRCY+UqyWmxdU
	 wFLhnZL+Fyyfw==
From: Mark Brown <broonie@kernel.org>
To: Haixu Cui <quic_haixcui@quicinc.com>, virtualization@lists.linux.dev, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20251208020830.5225-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251208020830.5225-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] spi: virtio: Fix confusing cleanup.h syntax
Message-Id: <176580717392.161463.3784278976785359258.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:33 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 08 Dec 2025 03:08:31 +0100, Krzysztof Kozlowski wrote:
> Initializing automatic __free variables to NULL without need (e.g.
> branches with different allocations), followed by actual allocation is
> in contrary to explicit coding rules guiding cleanup.h:
> 
> "Given that the "__free(...) = NULL" pattern for variables defined at
> the top of the function poses this potential interdependency problem the
> recommendation is to always define and assign variables in one statement
> and not group variable definitions at the top of the function when
> __free() is used."
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: virtio: Fix confusing cleanup.h syntax
      commit: e6268db46c173b18e5b2f4fc0c8a5c0aaaee61ea

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


