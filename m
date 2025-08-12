Return-Path: <linux-spi+bounces-9374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EAEB22895
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FBC7A0844
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97F1281352;
	Tue, 12 Aug 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBIfoE5O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344C27FD43;
	Tue, 12 Aug 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005490; cv=none; b=OlHAPge7tB4uh+P5Vdayc+W/0pq3VAdO6Y0BKwUlJQvfgPZgWt1XpwHxXHfeTVPL9FR3zkqMsbElsxlBsztnL2oLUYvWuSUYAO0t4TByCH8vaSwlaaWuF+IMdBTWLR5y7kdfGQ9pbhplhHQmNubM7YrjJfKi2CXTRds2Ld54T5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005490; c=relaxed/simple;
	bh=mtIf9n0RiahvN1JrDv6AJ6rqVdWwwZ75c42vATqfcgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pJmRoWDflUhoxb0u6RA8+rmkmXw13khSzx9qZUsYVoifUKn8Uq1BBId94db0FGkSx8UP0Ypaayi348jXjA5oPGLupam9/nnPtTkyJWvd1R7Znat54Taj2L2xOvNL2JCNmlWfuWKmUIKvZV/eXAhWhIxdKnb6PZAC55QDjMPUBzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBIfoE5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BF2C4CEF5;
	Tue, 12 Aug 2025 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755005490;
	bh=mtIf9n0RiahvN1JrDv6AJ6rqVdWwwZ75c42vATqfcgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SBIfoE5OZ9AM9hvXJ2nsYwuJW+urmpQDQNy1HxsAE65hMdiIcprTgjZOeCXBLnf/w
	 hkx6VCedE01HY7qNc6fINcx07QZuzc+72XoPM6mXWWbUUnqpIcydItwrpfZmW9jcWH
	 GWGyUpkXt2N+I9uvP1aeMO0fpqyby90X9KM/ZPTkZvXGfQZCI1Iyf82XLZCnBNufnT
	 QARPrMqq6h+4tw+x/gCB0ajsquEFoGovvxu/Z7QSpVhsdHx2pa+5fqCirCt8GG8bUx
	 srmyIqQiJ0ZFH/sYLsRUb/nKCTRquXWUq8Z1KluwNL7Q5ZT35QUgCLTM8J3XmoHrFn
	 Rmky6onMPHg4A==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250811-restricted-pointers-spi-v1-1-32c47f954e4d@linutronix.de>
References: <20250811-restricted-pointers-spi-v1-1-32c47f954e4d@linutronix.de>
Subject: Re: [PATCH] spi: loopback-test: Don't use %pK through printk
Message-Id: <175500548927.70594.3224068513229852904.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 14:31:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 11 Aug 2025 14:10:21 +0200, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: loopback-test: Don't use %pK through printk
      commit: b832b19318534bb4f1673b24d78037fee339c679

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


