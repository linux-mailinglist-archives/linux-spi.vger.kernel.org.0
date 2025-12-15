Return-Path: <linux-spi+bounces-11900-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518BCBE9D2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A0530A2D80
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F245133291C;
	Mon, 15 Dec 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEvPfafc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F55332917;
	Mon, 15 Dec 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807176; cv=none; b=acqSS7f91lG+F+Z47IBfOAHOrw6dQNCDAFTxdyFKyG/8P6Xws8EASqPrFFlEeyEv4eXtz1b6lZeOwHSKRoaHKtETACeaKiec6U1vYvaa6r5WadmnQyjHN19BEKr4bflP+HpeQHaoHiHkqA34JxqvlXxK4A8VuB/oel4fZnXJ7Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807176; c=relaxed/simple;
	bh=o0X2IyCU5xJJncvKbdeohmJq4Nt8o89APee6pHzCAfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=POtejcuoN2ujGfrvSo3aNnyKcaslZFNtBQ017Xp/zSsCT2I3Y7LpgKX1FTfxBJEm2255btOW8nqIOPDVhmfX96r+CNgJBr8J4OND5gaqcyHi+pOiOdB8yV5AwC4e7EZL8O/oDe17O93o8j/5MHMx4kve8pBfBiYzqDSdyoY7REo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEvPfafc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93286C4CEF5;
	Mon, 15 Dec 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807176;
	bh=o0X2IyCU5xJJncvKbdeohmJq4Nt8o89APee6pHzCAfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jEvPfafcH0xiTVOe9LMvWBjQf488lqW7thyhMiVVthpo5/vh+2KdAn8BpLKo9i98v
	 FuBThjuFN8DNEY9PWXJVaWsSJHzwCM1SiU5dmrHAGCIm3efvNPFyHFUxZC1w95DFDm
	 hzN45fijycF81XBy2KM2ilr8ukGrEPoV4s00U2aSANlG5xjKwssk4vJceErAAsqU1u
	 eSKXpPjJiUwvDPOl9No4mQogMnMoFoqMKfw/VUYhnhArR9Hjx4m9v09DI59pqCfwWA
	 tyyNYgDkpPBENE0+lTuGw2Ne2fm2D8PMWJZR7Rz+A4bNiZpRMYt8EtFDPl5iLbBJVR
	 45vCXp0M8calg==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
References: <20251208-upstream_qspi_ospi_updates-v2-0-62526c9467dc@foss.st.com>
Subject: Re: [PATCH v2 0/8] spi: stm32: Update for OSPI and QSPI drivers
Message-Id: <176580717503.161463.8142752344614450653.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:35 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 08 Dec 2025 08:29:07 +0100, Patrice Chotard wrote:
> This serie applies the following updates on the spi-stm32-ospi and
> spi-stm32-qspi dirvers :
> 
>   _ Update FIFO accesses using u16 and u32 when possible instead of u8
>     only to optimize throughput.
>   _ Replace Transmit Complete and Transmit Error interrupt management by
>     usage of read_poll_timeout_atomic() to optimize throughtput.
>   _ Simplify Status Match interrupt check.
>   _ Set DMA burst configuration dynamically.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] spi: stm32-ospi: Set DMA maxburst dynamically
      commit: e35a7607e05d59d35e937b80532ae93d1dd2493f
[2/8] spi: stm32-ospi: Optimize FIFO accesses using u16 or u32
      commit: cfe58ffc95a601988702df6f3462cb54dde467e9
[3/8] spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
      commit: f6ed06926b510f54a0817567ffd458194ed90bd6
[4/8] spi: stm32-ospi: Simplify SMIE interrupt test
      commit: e2f0ea18e560e5fa6180f52dffe434525a0cf86b
[5/8] spi: stm32-qspi: Set DMA maxburst dynamically
      commit: 4ef80c71c62ab841db9b1a9d74ffe043c60f6222
[6/8] spi: stm32-qspi: Optimize FIFO accesses using u16 or u32
      commit: 1ca91281649547efa4be34584a304974c9601df1
[7/8] spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq usage
      commit: c5f76d888810bca2d46297a7b942e10bc8cc69dd
[8/8] spi: stm32-qspi: Simplify SMIE interrupt test
      commit: fee876b2ec75dcc18fdea154eae1f5bf14d82659

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


