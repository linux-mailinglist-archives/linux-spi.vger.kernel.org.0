Return-Path: <linux-spi+bounces-11905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF19CBE6D1
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F22B3015030
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A0334374;
	Mon, 15 Dec 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQku6Xcw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A245B33436A;
	Mon, 15 Dec 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807184; cv=none; b=PF0hkBJSFfECOgCg8xpKs0nKK9EQoaDrn8HZ3kol2r6kh5YEcp7OHIyeGMtRXdeQaYutsbXMh5lhR52LshYPGt/NtR1BdVwPuT2jKVCQchE9H404MHC78Y2h49Uqf71Y+XhlhGmomsS+mOBOR5RzxNAJ7scXPmCQSf/yqEdB5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807184; c=relaxed/simple;
	bh=Rerg6CRIESKX0MqYmdy4582EGZX3A+sak14/yCthaD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wy4i1/q+2GxSHI8eS9c2bpxy+MB33ohHjfW9knivRULVwJPadLNxCbieUUmx11fJgDTDCqb6K2Q9cGG6khkeyKeeksTI8NkVgi2Qz3FDeVPyO0zbXiTHz4UcILMIwwC1UMRq4QQ+onEHVwgrOAR/pMcK1vgDq/KgZdHvmH4gWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQku6Xcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB71C16AAE;
	Mon, 15 Dec 2025 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807184;
	bh=Rerg6CRIESKX0MqYmdy4582EGZX3A+sak14/yCthaD0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CQku6Xcw9vnV3WJdsGFfsvrmUtaSqVtZsl+G4JK6zcdTLtdbKZQ349pc4StJbF6sv
	 R5qJf86ekKaXeToulmiecdS4CkWZPBAy5Jvd5PfiV0SbSC1Me/R8YQ+T6cCZZUrQz+
	 l0wdbK5UYedAWOBDNGHg+zniZpSZ6Wcq8Cxacu2StxAHTOzejw2vPYS6zRQ9alNrtE
	 mAkc3S6nXu37vhC/n6kSupPA4ow/2XptxgoDZtsfGNGjead9KeldFTwG8QQewSnpj8
	 4aj+m1wvu32LT+8frWHHGX09euev+Ho2nkSMTcnAZm7UyBlfraCiazpY4FSwHVn7kS
	 TeROKFBjjUc9Q==
From: Mark Brown <broonie@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
References: <20251204-spi-cadence-qspi-runtime-pm-imbalance-v2-1-10af9115d531@kernel.org>
Subject: Re: [PATCH v2] spi: cadence-quadspi: Parse DT for flashes with the
 rest of the DT parsing
Message-Id: <176580718260.161463.4539075429059025833.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:42 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 04 Dec 2025 19:13:35 +0000, Mark Brown wrote:
> The recent refactoring of where runtime PM is enabled done in commit
> f1eb4e792bb1 ("spi: spi-cadence-quadspi: Enable pm runtime earlier to
> avoid imbalance") made the fact that when we do a pm_runtime_disable()
> in the error paths of probe() we can trigger a runtime disable which in
> turn results in duplicate clock disables.  This is particularly likely
> to happen when there is missing or broken DT description for the flashes
> attached to the controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Parse DT for flashes with the rest of the DT parsing
      commit: 9f0736a4e136a6eb61e0cf530ddc18ab6d816ba3

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


