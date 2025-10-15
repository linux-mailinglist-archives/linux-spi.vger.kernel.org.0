Return-Path: <linux-spi+bounces-10673-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC35BDEA90
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98ABB19A6D7B
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7592832A3C0;
	Wed, 15 Oct 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPZ0wdL6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699F3277B8;
	Wed, 15 Oct 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533794; cv=none; b=mryAalcCKOJ0dLLcBvxgh5RWxFusl9Bz4jRp0Mtua8ezRHjpNmCVxkiDkg8TvWyskE6PO/cgEGCH2i0llNKiMB6KWBrl56V9qnUu7dotJq8NuuOPN7KB1SBpzId/WK3/gtTeqQmRahs1v8k84H4Du3IbBiMsmlFkWtMy5z8wjTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533794; c=relaxed/simple;
	bh=+bhMEsRNzI5k98sEPdvbr+UM2MNkljja10YA9aMTHgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JD8dTcouArot54qvxm8idWOU8sOUMdXrSlA/ma8Hoyx8WR1FWCcmp8I+aK8bzxSOhk2s/dXO/dJIXGd6SnCfai7xP/nDg4CHZnv6ugoaf3NuFQbDm5QtEkJ/Kl41oGI950AiAnAI9U4qWTusgg3pLwIBA6NwmHCodh/tdZ3can8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPZ0wdL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BE6C4CEF8;
	Wed, 15 Oct 2025 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533793;
	bh=+bhMEsRNzI5k98sEPdvbr+UM2MNkljja10YA9aMTHgk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gPZ0wdL6Q6/CQsmPbXDdCQZWX7QmdE9n85au73Etq3X9PJyES+DyrNa80cWIAZfAp
	 FvfK2GwUs02UJvsyqgVOJXf7+QqOIBVt4aEk9QCSrII1IvaM6z8BezF/3BQVGVJlhS
	 II4xWEUI/kGezywUjyT1rMHAw1uv8WgM9+ecccCVMmyCUy/VQNWu7B1ctW02YYB15K
	 5FVhBECjE9nrVQsJG+evup+Ne071PS4/chjOTwuV75cIXMoE/ILINaohC8wi4FMm3R
	 1O8ALYXSKIjvsxl9RWRb1dyTFqrdmEzk7wz5vAStFsf6Sl+D0Bn+vqcgamdTbbBRhh
	 dBu0kIEP8dVcQ==
From: Mark Brown <broonie@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013-cadence-quadspi-fix-pm-runtime-v3-1-d65f18dade0d@kernel.org>
References: <20251013-cadence-quadspi-fix-pm-runtime-v3-1-d65f18dade0d@kernel.org>
Subject: Re: [PATCH v3] spi: cadence-quadspi: Fix pm_runtime unbalance on
 dma EPROBE_DEFER
Message-Id: <176053379258.136664.99412845584919237.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 14:09:52 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Mon, 13 Oct 2025 13:44:10 +0200, Mattijs Korpershoek wrote:
> In csqspi_probe(), when cqspi_request_mmap_dma() returns -EPROBE_DEFER,
> we handle the error by jumping to probe_setup_failed.
> In that label, we call pm_runtime_disable(), even if we never called
> pm_runtime_enable() before.
> 
> Because of this, the driver cannot probe:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Fix pm_runtime unbalance on dma EPROBE_DEFER
      commit: 8735696acea24ac1f9d4490992418c71941ca68c

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


