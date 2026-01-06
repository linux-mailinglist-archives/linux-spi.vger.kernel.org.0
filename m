Return-Path: <linux-spi+bounces-12196-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BED0CFA865
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 20:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA12530900C6
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 18:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AD0362142;
	Tue,  6 Jan 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq/W70gk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5933A70E;
	Tue,  6 Jan 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723947; cv=none; b=SpILJHhq/H5F7TiNy1xjns5fmx1i5icolg71uFHiWCOc/TjwHz0ZN68ZOPVJcV/XktOfYWX9Oc6wjjOyxvzn+TtP9fRkqkB5LM9Hp1bdhYL9e0sUhjpS/xcnxFiEhzUnYso1W0FGd23My0N7aN9AOJYnsbv6upUemgM88FZpnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723947; c=relaxed/simple;
	bh=slrVtXqGp2rp8qqJMjz0DpynF+Z6Or1Xuns3k46Q1B8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bvWrTEVqQz3lfbaAQKTeW0Wb7z6sd6Zk4bCjVO+xv2DpQZVwlkSpkWHaFWe0MCeJ5ududleolRGt+ozLzduOpf5A0KUlGEZaml3oC6ihZBnVMXKzAUoEiF7On5nMGHTmiwWsLYiqDrtmVjfnF+mUQgd0h6x+7F+XA+Wxdt2RODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq/W70gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36CEC116C6;
	Tue,  6 Jan 2026 18:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767723947;
	bh=slrVtXqGp2rp8qqJMjz0DpynF+Z6Or1Xuns3k46Q1B8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rq/W70gkO2HuPi2yJnnK1gFp7NtCie2ZrAlZQ37kEFnObCPHO69ZHUXn7r9VfI+5x
	 9f0UdgZCrPIYV0/or6CkdnLp0AHqGatHy6Jcjt1z1okYaNQsg5vQUX8iJHfNEK4rje
	 An7i1I3Z0Gay4gmzHrrxviHMf/XB70zmVfQw7Dgodz2WL4jmCLB+ZMEuaM9N3p2scy
	 y3/F7Ne8pjcv1A4YF2NM30mC4RNyDbMPeTpbyXRHDD6WQnz1oeAGV17tmge2XC/gmw
	 VB4yZE/VP/Qap7eqiLDx//H1ajk+74Z7ERkTORw93N8iO3a7pC5F9pGkXpabZfPhZ1
	 nHQ2mY3eYNFgw==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
References: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
Subject: Re: [PATCH 0/4] drivers: spi: st: use pm_ptr and remove
 __maybe_unused
Message-Id: <176772394559.309686.18171199857083341971.b4-ty@kernel.org>
Date: Tue, 06 Jan 2026 18:25:45 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 06 Jan 2026 13:14:16 +0100, Alain Volmat wrote:
> Update ST related SPI drivers in order to remove the __maybe_unused
> statements on pm related functions thanks to the usage of pm_ptr.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] drivers: spi: st: remove __maybe_unused for suspend/resume
      commit: d4469e4ee5da0a93eabfcb89a8c6ecdf7cf1e9be
[2/4] drivers: spi: stm32-ospi: avoid __maybe_unused and use pm_ptr
      commit: 2a2d7187f5a7238582c2bbd4a6da7595c20e55a9
[3/4] drivers: spi: stm32-qspi: avoid __maybe_unused and use pm_ptr
      commit: 10a6d7507791a667fe1d327056ac3f72934cc7de
[4/4] drivers: spi: stm32: avoid __maybe_unused and use pm_ptr
      commit: 75d208bddcca55ec31481420fbb4d6c9703ba195

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


