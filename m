Return-Path: <linux-spi+bounces-8907-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF8AEDD2F
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93711189C66D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564AB28B40E;
	Mon, 30 Jun 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVd4TYtV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC228A3FC;
	Mon, 30 Jun 2025 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287072; cv=none; b=AxOKFmHdn8usMjuVNuNT+p2VZkchR4eVS99Od5E66R7xWMjkaY62Kz1XkSoh/r7d7xQGHIOnlhKPlLhMr9ePHFQUf2w6pSJ1Y8m9S/WgDXy69w5CiB7d2xNUoHT7XPbslnM1v+T0Wovyg6sIc6M55+7dSCmChY6FNV/tBTXXp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287072; c=relaxed/simple;
	bh=MgteINiIKUQxM+bP/XS1w/Exa/rjYBe6TpvG+0r5tHc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Db2HBtumSueIIP1oBlIcF5THHzBQ2RnHbo9KL1DUfJGg3cKOSqu2oaDghm/CvVRZHjyeAnucfBTEEHbfa+Z458loscMCGd0Tt4JHFiFDLYcstRL9EZo3kWQg8B3FQKTVw9K86KmP/y6qk1ORvPjPhvfEEQaev5MXbuY7CZSgYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVd4TYtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B7BC4CEEF;
	Mon, 30 Jun 2025 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287071;
	bh=MgteINiIKUQxM+bP/XS1w/Exa/rjYBe6TpvG+0r5tHc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cVd4TYtVqTETn+Jn4o6QczGXELg7AdEF4TxhCrZ3a7C8RtfZFZTR+Nz/2dv33RhBq
	 9oSb4XxIjI4P3Tsah3SMIxBe4NvvjKm1ia/xWQ8uns3a7Ju/Ymph1qGxkpsH8f/HOl
	 qoX/VpIf8Qzz7b6YpMvGKMW1AG6tJdTkaGt9370dBjGKk5BNlF3LLDrOA+lpy9zHWg
	 vU43e1ouMJe+2adJHFJSPCJVHZ7V0FVtmTIXfSXPXziUK98IbgFz/nIgEHXlDMT5Vd
	 Mt7g9FR8PGkOafqN/gSs/UIUPvgPdQmJFRtA3LROK/gE1FqSQwnSMI0j5U1wda8RP/
	 x4oVZCYG+KUEw==
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lakshmi Sowjanya D <quic_laksd@quicinc.com>
In-Reply-To: <20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com>
References: <20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com>
Subject: Re: [PATCH v3 0/2] spi: spi-qpic-snand: avoid memory corruption
Message-Id: <175128706885.37861.8770064610677476494.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 13:37:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 18 Jun 2025 22:22:48 +0200, Gabor Juhos wrote:
> The 'spi-qpic-nand' driver may cause memory corruption under some
> circumstances. The first patch in the series changes the driver to
> avoid that, whereas the second adds some sanity checks to the common
> QPIC code in order to make detecting such errors easier in the future.
> 
> Preferably, the two patches should go along in via the SPI tree.
> It is not a strict requirement though, in the case the second patch
> gets included separately through the MTD tree it reveals the bug
> which is fixed in the first patch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-qpic-snand: reallocate BAM transactions
      commit: d85d0380292a7e618915069c3579ae23c7c80339
[2/2] mtd: nand: qpic_common: prevent out of bounds access of BAM arrays
      commit: ddaad4ad774d4ae02047ef873a8e38f62a4b7b01

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


