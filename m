Return-Path: <linux-spi+bounces-5607-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A49BB728
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 15:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B3F1F223FE
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9EB1AF0AB;
	Mon,  4 Nov 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR0BwDzx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12518E359;
	Mon,  4 Nov 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729221; cv=none; b=FgOVaMxfxYFmlLrwAqdmBvupFH1anF5AkVHIZYYJUx/xxUrsHPh0SjkFVJWlfdchCNajHtihgUMwjxpKDWoMR/lYfPw5O7plVLGzPnoEeHOx9vvOup3RnkLBXQnXN8mZ7ka9ee/4Kzsl3qcJHyGroGRNusCeqcelpPJYcKmTtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729221; c=relaxed/simple;
	bh=/lGvOk2uNR5QCbKQ2pR0LrRLenxQ7dFMFLqqojh29pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mTnoOswTZb08CT/3hkB/E8u+27PcyU7gNgqUNuxChsF1Aztq7DfHQ41Z3IMul6lMJo2JvZansXZge8AguOjV8fphCuwL5IiY9MfmHqaw27dsta3JSHpqsoaRc5cADz3xN9ww1yVdHyxAK42YcCUax8tKC27F31yvBaiflMmrO3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR0BwDzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559D3C4CED1;
	Mon,  4 Nov 2024 14:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729221;
	bh=/lGvOk2uNR5QCbKQ2pR0LrRLenxQ7dFMFLqqojh29pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oR0BwDzxB8f7XXzSfFCJPIqCS21fAssuB/7IaJUoeahWQXpz08sKbpmmn+cttos0l
	 IQPI7eFRlesH8Chhe2sZ/cAsiUJ3r5wcZsYyWTK4+3diiII+zsWFuGeKujLS2RCOSA
	 PM99GERbSNEx0BLWyv6HyEB2//tF5no+afb3X0qYxndBPLkdgZ4XQ9tA4mY8ve8pCj
	 k3zufr1Q7B8xegdgEG0bO3ihYnXarNJLdlwh2Bd/+RNgo002SUr3ira+1G7x2We9b7
	 jnCHHvqlDjq+QvqLDASMGQpts55G0KZisw2Lj3mO3tJBRqWLxfb7YA/VOxVLbDdjOb
	 5FXIZsjdy6FQA==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>
Cc: rmikey@meta.com, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241004125400.1791089-1-leitao@debian.org>
References: <20241004125400.1791089-1-leitao@debian.org>
Subject: Re: [PATCH] spi: tegra210-quad: Avoid shift-out-of-bounds
Message-Id: <173072921908.32316.9323478432792803800.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 14:06:59 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 04 Oct 2024 05:53:59 -0700, Breno Leitao wrote:
> A shift-out-of-bounds issue was identified by UBSAN in the
> tegra_qspi_fill_tx_fifo_from_client_txbuf() function.
> 
> 	 UBSAN: shift-out-of-bounds in drivers/spi/spi-tegra210-quad.c:345:27
> 	 shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
> 	 Call trace:
> 	  tegra_qspi_start_cpu_based_transfer
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Avoid shift-out-of-bounds
      commit: f399051ec1ff02e74ae5c2517aed2cc486fd005b

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


