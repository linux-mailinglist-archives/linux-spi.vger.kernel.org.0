Return-Path: <linux-spi+bounces-8977-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0C8AF066D
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 00:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E09F3BC040
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ED2302CBC;
	Tue,  1 Jul 2025 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFSHhob6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220A302CBA;
	Tue,  1 Jul 2025 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408146; cv=none; b=LGkH+DyHaeOhQv0ElYef2Pr4jPomDSLTKGdWzR3z/hvWegJBZfvMiVQ/qR+CKN/OwT2zu9hcqvHxoBlKf1nBGeZ0ioHriWBSYJCEucMvKeSSMtg9FE18SSh46NaRbkjl9km3/PuoLu6hYolheAFwN3BT8rqJ1smSuxLep7aEOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408146; c=relaxed/simple;
	bh=4/b8oqiRmO+b+wUXBPdUv0i7HKBQMbmTAdJGmIM73J0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I5ed59kunHN0rhWqJhRtnpv/2YbCyzP1EfGo87sbTeE7YXp+tuPPoAqG6cOR+y5FKA8MUMwdYXid+ksoOaZjHYqmR9YS0pmmzJbX98rFM4gblfdYwzqajIUF1o1KosmWy0xxO7qSYXAAOLtYByzEGR/c79BYYun9Hkcbt8YzckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFSHhob6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05D7C4CEEE;
	Tue,  1 Jul 2025 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408145;
	bh=4/b8oqiRmO+b+wUXBPdUv0i7HKBQMbmTAdJGmIM73J0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iFSHhob6VYlotEQFMnbn6Z/8/9kI+kAVa2ZTO38a/6avAy4RiCDdgRfKJI5XblMCF
	 pYML2+zZlmGPQoP771B1+10lkm2+n4zASUeKtIIgpXk1N9PsRrowtfWiQxhMa3zwF0
	 Nek4iXElagCPjfQzmQFV28fSUNXzkIN3ebbm+0R+4+/QnhkMXf1utFpJ2/6aA2oEVh
	 gVFzRx5DtM5DhuCCp0AdBD2Cemhpn5WdPUAd71691epNKvg8Ohjyk2810C7ImljUlb
	 rH1F9xu3fMctiylEoddORPaM//OSWMcPyiwcwvGESxdJZHyFqWRlAqbih+0h8yY+8R
	 +PhiOjMvPgaIQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Antonio Quartulli <antonio@mandelbit.com>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
In-Reply-To: <20250630081253.17294-1-antonio@mandelbit.com>
References: <20250630081253.17294-1-antonio@mandelbit.com>
Subject: Re: [PATCH v2] spi: stm32: fix pointer-to-pointer variables usage
Message-Id: <175140814365.710092.16438205627985189965.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 23:15:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 30 Jun 2025 10:12:53 +0200, Antonio Quartulli wrote:
> In stm32_spi_prepare_rx_dma_mdma_chaining() both rx_dma_desc
> and rx_mdma_desc are passed as pointer-to-pointer arguments.
> 
> The goal is to pass back to the caller the value returned
> by dmaengine_prep_slave_sg(), when it is not NULL.
> 
> However, these variables are wrongly handled as simple pointers
> during later assignments and checks.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix pointer-to-pointer variables usage
      commit: c4f2c05ab02952c9a56067aeb700ded95b183570

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


