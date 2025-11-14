Return-Path: <linux-spi+bounces-11218-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2876C5E91B
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 685814FB38A
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDA340A69;
	Fri, 14 Nov 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ys1Tv+xl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550B340A46;
	Fri, 14 Nov 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140030; cv=none; b=ZANVEOJqE2PEIaQrO0YESyeRmeSAPMCapESp6WI9tCtL4gmDOtKgzKM9NeKTkG3XCiqeaLWvljbwdFMQERCrBkcrv4a9chOPOtt73kCKGDap2zkIUnJh5eWJSXD8oSO4h4l6akiQzDm0KSaYSsiXbjny9gxl9zDLlMCR9woTETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140030; c=relaxed/simple;
	bh=CmRiev1jpdffxZw/zxPg5cVSvwXm3OIigSidm0tBhi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h5tceKHsPgKsXyS2curgIXI5sIzySsI9HuhKamq6Wb5AreRUY4PHRFMtkBxutDTrH7oNMHDuwKnBQEnVqL12UhHLfjw4pTG9MItcS88I/2v4mMEfY0aaQpBlZrucOjdBQBN3ceBUWH2h+gChlTpMctTS37AyPUgmUQh3Um6pmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ys1Tv+xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DCAC4CEF8;
	Fri, 14 Nov 2025 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140029;
	bh=CmRiev1jpdffxZw/zxPg5cVSvwXm3OIigSidm0tBhi0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ys1Tv+xlo8I7lq5rRkJ/URGPHIUOu+ZzI1qovH6NLRCpHiJlR9b7sRS+beuEZ5f2i
	 Q9v3AwBX65ow5jw+qqmfUJhV5tGgYbIS6K7pny/UnPvJx6gmV6wFnt2qbOc+EV8lww
	 5B/K08cSE8aCqSnZgMLuOM7+RfMABlyzZ4Ry61YVGNBxA+h/sYOgkrUMWmaPuduHD8
	 25pkySDyQm6+bI4oEN9opnSzqsfi7crDVWYeS3UBlFK+c81+AV8bEXg0gBhCA4z0J9
	 hFPNrGqlGwgUtHFg9BkDH7I2ItNa5q68hMFS5EGPZVifmf1Pwpp+1/z/uR1uFgXrM0
	 YIlVP8xH4e+zQ==
From: Mark Brown <broonie@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, 
 Cyril Jean <cyril.jean@microchip.com>
In-Reply-To: <20251107122104.1389301-1-prajna.rajendrakumar@microchip.com>
References: <20251107122104.1389301-1-prajna.rajendrakumar@microchip.com>
Subject: Re: [PATCH v3 0/3] Add support for Microchip CoreSPI Controller
Message-Id: <176314002747.180192.13977683844281536815.b4-ty@kernel.org>
Date: Fri, 14 Nov 2025 17:07:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Fri, 07 Nov 2025 12:21:01 +0000, Prajna Rajendra Kumar wrote:
> This patch series adds support for the Microchip FPGA CoreSPI "soft" IP
> and documents its device tree bindings.
> 
> As preparation, the existing Microchip SPI driver is renamed to clearly
> indicate that it supports only the Microchip PolarFire SoC "hard" controller.
> Although it was originally named with the expectation that it might also
> cover the FPGA CoreSPI "soft" IP, the register layouts differ significantly,
> so separate drivers are required.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: microchip: rename driver file and internal identifiers
      commit: 71c814e98696f2cd53e9e6cef7501c2d667d4c5a
[2/3] spi: dt-binding: document Microchip CoreSPI
      commit: 8ce9a2ed153bcaa750aa494e91ce2e70c3b0cdc5
[3/3] spi: add support for microchip "soft" spi controller
      commit: 059f545832be85d29ac9ccc416a16f647aa78485

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


