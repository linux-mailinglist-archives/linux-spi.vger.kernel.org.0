Return-Path: <linux-spi+bounces-9538-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA87B2CC78
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 20:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095AE5C11AC
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717DB31CA6A;
	Tue, 19 Aug 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+iA9dLm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB130C345;
	Tue, 19 Aug 2025 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629547; cv=none; b=IQWtikLXSc6t1Iv2g2/ZTvxn9j2X6DWWPEB+UBVSltom9yJjljZW9vwPUN9cf0ClheQDhFOvjLurR/gkEJhr7wf2dRLql5s22I2+7RfmU4+ExF/WEJdPQNPkP3eRI1E/R+hXocH7+Az79RrmfOeCizCrIo2hN1nF0dtrdVmDp2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629547; c=relaxed/simple;
	bh=UtpGsqXUkldWGa3nJKuOrHaS+PduZ9qTMdBlN9e+xOY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=juzm/lpgnE2mRVBdK0CKRUGwVEXJQtT6lRPm+ZI6X977q06ta1+xlWzx64UB0ErUQ/44EX2QfIJ3iAeSYMxTg8EHV6mMiydfSlXemDckz/YQD+Xi3Z6dA/uKog7Knf1h0cCbGG5EMrdaJ0+p2D1CeAcbEMNdLGYoXUyGkbBSTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+iA9dLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AB7C4CEF1;
	Tue, 19 Aug 2025 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755629547;
	bh=UtpGsqXUkldWGa3nJKuOrHaS+PduZ9qTMdBlN9e+xOY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=r+iA9dLmj6cVcyob6HLoSTvGYGcB4vNpyq5nDs1dLlAuYwxuYvdz2dIxJMRTFnDbB
	 ngKZot3gY1gBpWm8qEElguO95+95Fjhx2qo3EZPCTtBiDhFkwUQ15WTT4omOLWdUDJ
	 fb+seFWe7JcwLS5EAT3BuLplKV9J0hp6BHU/FYieC0RXGHRK2ga4wFag12a87a3nHa
	 2GASII1kgQFzWdB6huGdUs9exYHIfvPOv8+lS4Iq9FE3+UIN1jfGtUsA/tg/48dPex
	 jS2H5rn2P2+aHxmw6t7sbD4Ciod6k7kqfB1MW3Oa8aiRgVAJt0VFLBnC/5K9tkH9RX
	 xy6zNeW7U8SUg==
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>, Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Andi Shyti <andi.shyti@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Xichao Zhao <zhao.xichao@vivo.com>
In-Reply-To: <20250819092044.549464-1-zhao.xichao@vivo.com>
References: <20250819092044.549464-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH v1 0/6] spi: Remove the use of dev_err_probe()
Message-Id: <175562954316.246851.7964895006967945147.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 19:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 19 Aug 2025 17:20:37 +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value instead.
> 
> Xichao Zhao (6):
>   spi: spi_amd: Remove the use of dev_err_probe()
>   spi: SPISG: Remove the use of dev_err_probe()
>   spi: Remove the use of dev_err_probe()
>   spi: mt65xx: Remove the use of dev_err_probe()
>   spi: pxa2xx: Remove the use of dev_err_probe()
>   spi: s3c64xx: Remove the use of dev_err_probe()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: spi_amd: Remove the use of dev_err_probe()
      commit: 2a5d410916d3a8dcac06f72494f252314e933cfb
[2/6] spi: SPISG: Remove the use of dev_err_probe()
      commit: 0d00ebc6b869f4df67c05522bc1e8d01d1c7daa7
[3/6] spi: Remove the use of dev_err_probe()
      commit: b875b97017050b92c64273178a0b0d282ea67874
[4/6] spi: mt65xx: Remove the use of dev_err_probe()
      commit: 2bee48c9d1cd1749922d0e2df54330c924e14a0e
[5/6] spi: pxa2xx: Remove the use of dev_err_probe()
      commit: 67259af78219bdbdea00491f32b1c0971a33401e
[6/6] spi: s3c64xx: Remove the use of dev_err_probe()
      commit: 27848c082ba0b22850fd9fb7b185c015423dcdc7

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


