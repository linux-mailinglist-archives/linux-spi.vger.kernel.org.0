Return-Path: <linux-spi+bounces-7599-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ED6A8A8F4
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 22:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B666188E0B1
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079FB2522A9;
	Tue, 15 Apr 2025 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsSnOwDI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD1528E3F;
	Tue, 15 Apr 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747946; cv=none; b=l5zq+oLWyJkPxZyJPfhO6OYBsxvo2rzZb+b0ReSva5hzLiWpE36bY32SZlhaYIsqhZayWoFPBbbWTfay9qHomh7HiAIYwzOI3GUrjN+mbYgKa7k7zE94/QIBz83mS569k+1qkw6SkBPAp8XTlwuYWCDtAUKBpNKEbFeI/ksMUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747946; c=relaxed/simple;
	bh=CRMG8Zo6ps4IacifJ4+/Vz/sac8EDxbZzPUiT/AZtfI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hNZO4PZsZrscYtrzGzvyjWB1/TU+aw1/PDPZIYzLipAZ7V6kLCKaPeJESqdG+Vygct7kM7CccavgCNL58yoN/6WCtBdaX5Xw1LMcEt96B+hIVWoc/XaaFIVLkNi33Tf277tdcGNOW7XDdgP5myWKJb8FX0cTYFZz8yJ5VyGKED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsSnOwDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A88C4CEE7;
	Tue, 15 Apr 2025 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744747946;
	bh=CRMG8Zo6ps4IacifJ4+/Vz/sac8EDxbZzPUiT/AZtfI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nsSnOwDIglcMO65HoUItvURy0yMGsR+RO4D1XCsFYzJOCxsYxxgxqcqYEwTAxGTBJ
	 gTreP+lqa1LCvBssGXg2Wyo1uJ/AELu0llj4hosvjuYvs9Rmny/cfuA7aYw+Etb9/5
	 rA1/JdGAe5BVvJyGh/9S8RcCAHn2JnEjvJ7LLmUvaoIjyeiqxZlqFw4v5HfZsFXUhS
	 br1YY8xeyKeeyadZdfX5okG8aYmeLZNtjSCn71cMKqZjvvXeyWYrDLf+outvqDSpxV
	 5Pw0JeecFPkVW+kuoTLumD0J6Ya81dgmTQPPYFGaJpYBSRYecvcpAUqYDjquy0htQg
	 q2H+UJOAjPSDg==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com
In-Reply-To: <20250401-tegra-v2-0-126c293ec047@debian.org>
References: <20250401-tegra-v2-0-126c293ec047@debian.org>
Subject: Re: [PATCH v2 0/2] spi: tegra210-quad: Improve messages on
 pathological case
Message-Id: <174474794125.1085405.1696078775184536618.b4-ty@kernel.org>
Date: Tue, 15 Apr 2025 21:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 01 Apr 2025 06:47:48 -0700, Breno Leitao wrote:
> I maintain several hosts with tegra210-quad controllers, some of which
> experience data transmission failures. Debugging these issues has been
> challenging due to excessive log messages from the driver.
> 
> Since these devices do not have a way to reset[1], then we want to avoid
> warning and printing a bunch of messages, otherwise the host will
> overflow the serial. Fix it by:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
      commit: 41c721fc093938745d116c3a21326a0ee03bb491
[2/2] spi: tegra210-quad: add rate limiting and simplify timeout error message
      commit: 21f4314e66ed8d40b2ee24185d1a06a07a512eb1

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


