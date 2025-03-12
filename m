Return-Path: <linux-spi+bounces-7102-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6981FA5E7B4
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 23:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD08E1781BB
	for <lists+linux-spi@lfdr.de>; Wed, 12 Mar 2025 22:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26BA1F12EA;
	Wed, 12 Mar 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJQWMTdN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9F1F0E5D
	for <linux-spi@vger.kernel.org>; Wed, 12 Mar 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820053; cv=none; b=SPqRP6emqPj7R//Nb+KlSi4XLY5xZemhaPEYhMlok41UotQTwSrdrlppnYhEjEqfm+StGMLS27mYqDMRgCsXMAmH2l32eoszMfQe5dHY3gU8eZdOd75p8p+HqzzwNPk/gycRH4dB539T7agLIlKhtLJQmca5jyGawXDSO+DZuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820053; c=relaxed/simple;
	bh=xzjE1mFwplwXw3KogyNxD3cNh8ZkAMgOZsuhMVRkVvk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aNmXJmW1zinpIgWrnD3v5XWT/mPhzKPfRj47LmIxFcnMkDnhdV4oJHTpSUbupL3ZzNpwx16715njpozMqyDAp6jqqgry/65g2znAYal628YGoBL0SHFZKzIU0IF3FzmgyNTt4PQna07Yw3BI7NdBiAT+qpXMvOIE0vsaOrQMoU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJQWMTdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B91C4CEDD;
	Wed, 12 Mar 2025 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741820053;
	bh=xzjE1mFwplwXw3KogyNxD3cNh8ZkAMgOZsuhMVRkVvk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JJQWMTdNl4WZXI70o4Wwg/nGy3160qSlvAEi2GjvSLrCjGktdidB4aoJiUEQ49lO4
	 RPA8VgsiMIy64hcWxbHGr39Bram9X83ZpdJCFVS3WPI+zBnzHl7nhnSkiPUx34ixaY
	 MJlTn8S+KuyfWpEmH8jHdjFl/K2S7Lf8WozJiEZv0Q4/BP50UpeL4KFAleHT6DhK/G
	 VmeERh+Gr5DbnZIc8B3pP9OdKFAbBJP22GKKKM4O5kTpKHcG9X3z8vcCNQYfLANvwv
	 HJVlHj3G3/VFspO1nZKwq/3BTFGDbmJMIKnMbpv5Pd/EF/i9OA2d+Kffbrx9r1A5XQ
	 TPUyU07a5YQCw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20250305200933.2512925-1-miquel.raynal@bootlin.com>
References: <20250305200933.2512925-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH 0/2] spi: cadence-qspi: Make it work on AM62A LP SK
Message-Id: <174182004841.192003.1973465132050742784.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 22:54:08 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 05 Mar 2025 21:09:31 +0100, Miquel Raynal wrote:
> low-power starter kit. I initially could not use the spi controller and
> tried to find a working-while-not-breaking-the-others fix but TBH I am
> not getting all subtleties of this driver so I might very well be in the
> wrong direction.
> 
> I then observed a massive throughput difference when using the DAC mode,
> and disabling it really improved things, so I am proposing to bypass it
> as well on this platform (and some few others which would also be
> impacted by the change).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cadence-qspi: Fix probe on AM62A LP SK
      commit: b8665a1b49f5498edb7b21d730030c06b7348a3c
[2/2] spi: cadence-qspi: Improve spi memory performance
      commit: cce2200dacd6d7e0501c3811f24f5216710968fb

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


