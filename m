Return-Path: <linux-spi+bounces-2756-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2383B8BD0EB
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71E51F22367
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2024 14:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716D155389;
	Mon,  6 May 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVm40A1S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8B1552F5;
	Mon,  6 May 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007569; cv=none; b=J5CpIMd7cA5CpR7lYJwwp26FvGHWC7A37yzTfJ/AJstWRRDYvBrre1WZ8oJdBah47CjBAcg/XR1uHh6sAoF2QH+x2uPSgaoZJA+ntt4+ovSGLb2QXQmQtBi3xR996m24aD/3REern2BGT2Y/HNr9OcClK6bUPK7ZNQ69IhYBuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007569; c=relaxed/simple;
	bh=SI/rG95pg8rmcHY12z/tvpJ70tvdw/Xpd9q9m12ZR4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F5ywQatYCdnDA0291uUciOPFrmpsbDP6aRCQsMxODX9p6b5vGeGqvjoLyylLtYvYsV4fxF8DPzOOjZwO1F43djbGqHDhhxAl5pDzk2blLZN2upfiVM4xsJAXWN9wJ/zFO6a9cpaQP+y7M2ZWej98EMcFjj7wXI3PZkoKiJqdppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVm40A1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8707BC4DDE2;
	Mon,  6 May 2024 14:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715007569;
	bh=SI/rG95pg8rmcHY12z/tvpJ70tvdw/Xpd9q9m12ZR4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fVm40A1SscZOR1EGBMn6HXdcgIydMp7twNhiH+38DF4G4t3lQOfgKHsx9AC9f4U37
	 N2v1jVuHZIlQv54xBlmeur4IHy/QIuqJYH45VfpiPJOx9eQ1eE9WD7Ah1cjFHp4e4A
	 zNMbbKbw9Q7vpQg8cVi1C6boBrMLX9vnC9PSbyxaKvqiQnm2EEmKvltFyVD45v7Nyr
	 o1o03EUYC3WlhBhraVGfK7x2fDTUpvkkZMU17cdFuN14pf29uPHAzvxva2hKPAiGiQ
	 dbjD/1bbBWHYZTluXcOnwXamUHsF6Y/wwpFnu5nSlgQa8HiWhRVzQ7QSpLas69HbGw
	 DIofkWsFnWa7Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-Id: <171500756707.1968436.11360972536558468970.b4-ty@kernel.org>
Date: Mon, 06 May 2024 23:59:27 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 17 Apr 2024 13:54:27 +0300, Andy Shevchenko wrote:
> As Arnd suggested we may drop linux/spi/pxa2xx_spi.h as most of
> its content is being used solely internally to SPI subsystem
> (PXA2xx drivers). Hence this refactoring series with the additional
> win of getting rid of legacy documentation.
> 
> Note, that we have the only user of a single plain integer field
> in the entire kernel for that. Switching to software nodes does not
> diminish any of type checking as we only pass an integer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/9] spi: pxa2xx: Allow number of chip select pins to be read from property
      commit: 2c547549ac69380bb03b495c5ef3dbc03c9c7a48
[2/9] spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
      commit: 11346db50616698b04da44a62d4fac17d9227a62
[3/9] spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
      commit: 2a45166938f145294b73445b0af997b3100f02b4
[4/9] spi: pxa2xx: Remove outdated documentation
      commit: 2d069c11e8229e9f380af0c3bffe4b95cd2cf9ec
[5/9] spi: pxa2xx: Don't use "proxy" headers
      commit: 4091770969bffba9dcb071b81d4010331d4dbee7
[6/9] spi: pxa2xx: Drop struct pxa2xx_spi_chip
      commit: 513525e99898a722b365ceda6c5a2e4c83adda89
[7/9] spi: pxa2xx: Remove DMA parameters from struct chip_data
      commit: 5c5de36d04cd848587f21c0c872682476d5df8e5
[8/9] spi: pxa2xx: Remove timeout field from struct chip_data
      commit: 35bf074b1d4b252d04540acc7256e4ebee5b2dd5
[9/9] spi: pxa2xx: Don't provide struct chip_data for others
      commit: b5ec3986da5d928e4fd9ed24b5d367c4b420f1d4

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


