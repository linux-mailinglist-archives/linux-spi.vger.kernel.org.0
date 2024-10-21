Return-Path: <linux-spi+bounces-5288-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276489A925B
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 23:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3955B22909
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 21:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF071E25F3;
	Mon, 21 Oct 2024 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUWeuid6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EE1990C8;
	Mon, 21 Oct 2024 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547459; cv=none; b=rIbRaQzlPwY3bBliChHybz6UKJZaYp4vTGQgbYeL8fbO8E9yrdbJIZw/bAsBCFYhs3nMfzTB+2t0W3nUDjRW4K5C0yeUCrfsRs23mLAFXBM8xL8aSEINzq+DFua6y6wTbsmniTZLMIhb/LoEkc3ubeTjEqjMWLY/fKLRxN+ClT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547459; c=relaxed/simple;
	bh=MEFAmhWYCYIUO6J5UjvEp2P8ExLk7R2JFK8tfioHqe0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jaS/nay9ICTpTFwXitIUuyhCU0Apj4mRtOvSUmRGSWE686yonOFswuoE86r3FqXOU17AthfVDx1VjxmXdIcNdZpV6fy89tny1PaP5IexRRPbG64MPvvGs65w+oSzZdtHFQpx/0h6uKI6FRqGbTuxXetY1AAicRYUWCMUrW5fN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUWeuid6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C160C4CEC3;
	Mon, 21 Oct 2024 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729547459;
	bh=MEFAmhWYCYIUO6J5UjvEp2P8ExLk7R2JFK8tfioHqe0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SUWeuid60jUMJhiqaF3iJPOOCxV0OHU020fbpYoPhzRH8h7fa7gWejBB1gsXHspok
	 OeQdi8O4v6XY/VSS9ac7ONVNhEI1mxEdyVOsR0uTdolMb9vFKQdQeA+PIQfkkNzASc
	 sC4c4WBME708FZyt+ni9tI2+j3G2fkZ3I4SPezOOBKaeFOkxtrlcu9I9wQn930RilS
	 uZ1stw/dB+i5xtdZ/QXKvuCTKxDdwLLW3w6+ZWwCcS1MGREJA1S1c/uT4nSq+ZbsQs
	 ZKgFZ8sLTUudQ/Cj3NlwDngUBy+8ot3V7cQIvUMm4k0FpxY0oXEcFcj6HseSV6Yjne
	 Tr/ixRy/O8J3g==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: (subset) [PATCH v1 0/6] arm64: dts: exynos8895: Add cmu, mct,
 serial_0/1 and spi_0/1
Message-Id: <172954745600.159374.15357037324380412409.b4-ty@kernel.org>
Date: Mon, 21 Oct 2024 22:50:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sun, 20 Oct 2024 21:21:15 +0300, Ivaylo Ivanov wrote:
> Hey folks,
> 
> This patchset adds device tree nodes for multiple clock management unit
> blocks, MCT, SPI and UART for Exynos8895.
> 
> Exynos8895 uses USIv1 for most of its serial buses, except a few that
> have been implemented in this series. Support for USIv1 and HSI2C will
> be added in the future.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/6] spi: dt-bindings: samsung: Add a compatible for samsung,exynos8895-spi
      commit: f45a4399c1b582c6ddc179cc940aed73907b9453

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


