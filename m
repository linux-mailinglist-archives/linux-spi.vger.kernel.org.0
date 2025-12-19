Return-Path: <linux-spi+bounces-12027-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A64CCFF7F
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 14:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 022CA30792B5
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565033246F9;
	Fri, 19 Dec 2025 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGE3TLtD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631382FCBE3;
	Fri, 19 Dec 2025 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149321; cv=none; b=AARXPSt0YBTxHFqM8TC7hfuKJ2LSCIZmQyLB9VBYF3/pELxsWScKwTk8DiWRv4xMviWgEYrAOFpcI/g7awv7C1m/xv3UatMNIDCyVCq28z0x/V4/E/bJwiXcFXKY7HnM/lrgQ8K9nUzv/2L1Be6zWNGyg+H44qHR0gA2w7QDojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149321; c=relaxed/simple;
	bh=IcOQ2q6331x/sFy9lNcJP8nlM9e3AYGl939jb8gmCmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=olFIjn02D8Tzy0V57shGzaZecwzaef828qcn9GXchq+im3/ObNxwyDrEeXZqY0GeKENTujKHGqoyYnLBKlYgxgexmY9jROu0uVF5GMzZ1rRH59IsIbeSQN6CVuw9JpSe5B7HtRPsmET1beTFxWCvVuw8s4q4GApgxtqZAuAyho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGE3TLtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4FAC4CEF1;
	Fri, 19 Dec 2025 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766149318;
	bh=IcOQ2q6331x/sFy9lNcJP8nlM9e3AYGl939jb8gmCmE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sGE3TLtDns0o46iHdyt2yvjTYf+qmBLsez2FBT/V+f8PcdkRmfkKQuoytOLGJwQsx
	 JrU/G2tXYBvJeDh6wdUdhhv6mggP/NFZ/SiOoLImEh/cE0652FHY+bIiBzN65UnbXb
	 nWswUlTNCLY2fahu2y9WyWPfibt0zgL7D+OQ/hzsfcnsihTSGmcf6otErRikPD03w6
	 V85TY33eKYxD5t2N5dS8jBy4GwVBJhP3EGdrSXT7qajTwaiD/NLQi5uuZ33TEk5odc
	 vh/ZM3vqGCiCUNui6megm0KqlkbTHV8F0AqkGWPOP9CPUOVSX200Kh94nDwtGhHZPH
	 RFOguO2yd9DhA==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Deepak Kumar <deepak.kumar01@st.com>
In-Reply-To: <20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com>
References: <20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com>
Subject: Re: (subset) [PATCH v2 0/4] spi: stm32: stability & performance
 enhancements
Message-Id: <176614931636.368879.12913941748381812149.b4-ty@kernel.org>
Date: Fri, 19 Dec 2025 13:01:56 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 18 Dec 2025 11:48:26 +0100, Alain Volmat wrote:
> The series fixes a stability issue when dealing with <8bpw
> transfers, as well as enforce an error if the DMA information
> provided within the DT are incorrect.
> 
> Performance enhancement is also provided by allowing a polling
> mode which is triggered when the transfer is so short that
> polling mode transfer would lead to faster transfer than
> if it was done in a interrupt driven manner.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: stm32: properly fail on dma_request_chan error
      commit: c266d19b7d4e5ed993ed9fca25ab9d11789c41ee
[2/4] spi: stm32: fix Overrun issue at < 8bpw
      commit: 1ac3be217c01d5df55ec5052f81e4f1708f46552
[3/4] spi: stm32: perform small transfer in polling mode
      commit: b39ef93a2e5b5f4289a3486d8a94a09a1e6a4c67

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


