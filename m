Return-Path: <linux-spi+bounces-3365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C397902AC7
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 23:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5CB285034
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2024 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8814659A;
	Mon, 10 Jun 2024 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaF4Nkay"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970714B963;
	Mon, 10 Jun 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055899; cv=none; b=lNH+/tNgjQtLM0+EjMpB0zCpf205gQnD3x19TVvWsKm9g/HU0EFiJ4B/oqFA9w5iss7z6ZDfxQgrE7sx7H7zudnWwV4dNztcyWVoW+8bI5dZAnDqq0UxonBQ+xtunxorpdg4SKbQD+YJQ/PzWqETPSoAH5EmCbaJ+4eM/qg4GEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055899; c=relaxed/simple;
	bh=Sd8suPdpp5RbZfeLYPbJ0VqHNENaSDraEfVm1uGPQLM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ye/gdctdwLw2v6yv53TOyRAUitFjZLW3qonVN3aUpfNF9FBFUfiPOg5wZGATN3xtewWshMRdfBVYyf/gCHDZs7D07q0u/9jkEnaNSo/X0T1E/Hc+VbKL7j15XVpyUJd6Ak7DLpx9LvNX1Y5BvJ89KFaoSMRxGfzBQPKs3aAtOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaF4Nkay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D995AC4AF1C;
	Mon, 10 Jun 2024 21:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055898;
	bh=Sd8suPdpp5RbZfeLYPbJ0VqHNENaSDraEfVm1uGPQLM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZaF4NkayO0+crSFWB39jRCKqxDMNZI4nh/3xTJlJq6EfFpBPkaBYZHuvVaNyMfmmX
	 AEoXgQchJvq01AvOVQ6tzx18AJDT0HsPyqL/+yUoILX6kzvDTSkHaMVnHZoZNrBV1R
	 kLoJNLdZiDhXpJUUnkSYOzsGCteN9uvXjphxgPOcR7piemosC4CQwixhAgslUAprmJ
	 FUsKmZA2M/V0Xk9HBLHFyXqUV6CCKamnf6L3t5JhbHlHU/gUXBsDw/vuKrsqxKt/sN
	 RHRnOrnDFxDGQVt5c9hIkkrkkambgC9kTonpxf5IEEsqQaT0XAuI8NQ62dTzwvd5lU
	 B9huPe1ORzg8Q==
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sunny Luo <sunny.luo@amlogic.com>
In-Reply-To: <20240524-spi_pclk_setparent-v1-1-99e0ce70b66f@amlogic.com>
References: <20240524-spi_pclk_setparent-v1-1-99e0ce70b66f@amlogic.com>
Subject: Re: [PATCH] spi: meson-spicc: set SPI clock flag
 CLK_SET_RATE_PARENT
Message-Id: <171805589269.166358.18171996919240702689.b4-ty@kernel.org>
Date: Mon, 10 Jun 2024 22:44:52 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Fri, 24 May 2024 14:35:09 +0800, Xianwei Zhao wrote:
> Add SPI clock flag CLK_SET_RATE_PARENT for using pclk as parent clock.
> This gives SPI more flexibility in frequency selection.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: set SPI clock flag CLK_SET_RATE_PARENT
      commit: 022bd9c520d8f9dd51f29326eb369b8ec958f687

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


