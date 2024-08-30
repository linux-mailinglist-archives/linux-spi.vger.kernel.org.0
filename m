Return-Path: <linux-spi+bounces-4482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810196691A
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 20:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09621F22B71
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 18:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542571BC099;
	Fri, 30 Aug 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PngnbpXf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881A1BBBF3;
	Fri, 30 Aug 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043501; cv=none; b=BRUjMEs2sirbc9x/K4EGJTsV+zFed75OgeQEsKI1iDKg1s4ttF0EPl4F4rV/+e/ga6TxLYnGsgRiOUHkGepI2ok+EelAehQpHss8c+KsVsEZlGOFVG+KzYR1GPKSYv8io7TrHjptCGYMrK90ntjbKZX5Zu8HnrJ+cWL+5iWRTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043501; c=relaxed/simple;
	bh=xk0U0pDUOEZMO/XuTRxkNUzFUoOQB6HAZwa7anhPfG4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cJjJwtlLu7sRAK1rd30oZu5qTgTVp0Rosq/q9sXYjKGH1Ci8nxk5KEm6weGdC7IBXcE/tdF0yZ5yT2qMlRymjo2kHccr252HHzOxswXNArtYyYAgBxY/D1tXY/EQXXaHfUUyu9ORTVib+cMZea/zmnh4bmd5GPJvtL2Zw2Rb/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PngnbpXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606F8C4CEC2;
	Fri, 30 Aug 2024 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043500;
	bh=xk0U0pDUOEZMO/XuTRxkNUzFUoOQB6HAZwa7anhPfG4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PngnbpXfl9KPgZzn+mZ3Ei68DiWTYOiUHCMJwamWWuESO3wXjfrg5+jg3inD9kV4q
	 g73pP5yNTWi2GixQUp1iKPVW72yUXrKoQFcogZHktBWL9+dKWyaFbySSEwOltQpWsW
	 d5hV5LvwFi9deGvhf3k1PFBO1Vgyf/yof+Ao4+wqQdaCF//9HQIx46iyN5ilNrn085
	 D4nS4J+VOfRlq88Llbd/1QSJPktxaqk/fL5w0gRZV9DDHkzGAhD8iYbhoBYT2jy5zK
	 JqQzQJGR9nI6e8Y7FzpDx/Wly4G1a0yoyKaYb7fB9dqVulRjlpGmg4uQXWdfmLCwef
	 2R0/DL3uBQZSQ==
From: Mark Brown <broonie@kernel.org>
To: michal.simek@amd.com, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240826121421.3384792-1-ruanjinjie@huawei.com>
References: <20240826121421.3384792-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next 0/2] Use devm_spi_alloc_host() to simplfy code
Message-Id: <172504349904.219384.2456103489348384777.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 19:44:59 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 26 Aug 2024 20:14:19 +0800, Jinjie Ruan wrote:
> Use devm_spi_alloc_host() and dev_err_probe() to simplfy code.
> 
> Jinjie Ruan (2):
>   spi: zynqmp-gqspi: Use devm_spi_alloc_host()
>   spi: zynqmp-gqspi: Simplify with dev_err_probe()
> 
> drivers/spi/spi-zynqmp-gqspi.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: zynqmp-gqspi: Use devm_spi_alloc_host()
      commit: 64640f6c972e80f52196416a8d4dc3c0ffcbc82d
[2/2] spi: zynqmp-gqspi: Simplify with dev_err_probe()
      commit: d814fd0f046c2a6b1a919e1a529550bdfe9f9f9b

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


