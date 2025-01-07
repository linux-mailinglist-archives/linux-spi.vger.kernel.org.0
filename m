Return-Path: <linux-spi+bounces-6239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848DA03E5F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 12:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A415161A23
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF61EC016;
	Tue,  7 Jan 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUhRTCCb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309C1EBFFD;
	Tue,  7 Jan 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251103; cv=none; b=HqP/2BPsikjczsWZt2xUWcsvfsy5fyyG8H5G9EC8fQLr0mEVab11RAOQN9E+I7RgQcVCg785IHbZpmLmB+8sPyNS04xba09M3Q9H1eD6+mM/tkIILk34+G98DBt1JIwGULkxqiogAoCsuTcWuopCMw8JZNc9hYSaMQ6tFbuz2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251103; c=relaxed/simple;
	bh=8b/xr2q46e+APxvnC56zVcaG7myWN4n1kBuGonTWras=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f5bEQHNM7siHOnxH7XUfERO002BaBdMP3C4X1YL/BA2D2NiC0UgNTpq5s731tfpJGLuOehLda0lSN3z19Nkl6w3ecTKYLJY6dcinN3yOQ4BVFc0mdwMloVzf/Nbe6/wzkH1o6/eq4vZ8cCEE2XS+8CUFXWAgOUbIjHWOeGNBkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUhRTCCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B616C4CEDD;
	Tue,  7 Jan 2025 11:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251102;
	bh=8b/xr2q46e+APxvnC56zVcaG7myWN4n1kBuGonTWras=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WUhRTCCbFFGBx51yNADAjPDWxXXmXV9dMCTd2hTqr43+dnx/EeYXsxgKClC8tJbP7
	 aaTRjEn+4zp4/danzFGGEClt1AYINZHmbzAFoe0xkxoAIZQEhRu+k6XCKxqZYbyAd8
	 QFUSV0u14sIN4zKMQRFta1cEqFPFIwSGDPE8HLYSXW1WRtC9Y02SeXWCM48XVe4yow
	 i7KYaMEXNv0hyg0mJDprbGpkuiA8azKLOzfpopXFZpo8a8nDSZ+GYbALs1+nUYZIvH
	 FEtJ/rlPXvR+TL9UoZF1ONewK958lMd5nlD4YRFLWTpUHS5LBmlC6xy6mlqRU75aOy
	 7b4ZK/2W67cKg==
From: Mark Brown <broonie@kernel.org>
To: Piotr Bugalski <bugalski.piotr@gmail.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: Hari.PrasathGE@microchip.com, Mahesh.Abotula@microchip.com, 
 Marco.Cardellini@microchip.com, stable@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241219091258.395187-1-csokas.bence@prolan.hu>
References: <20241219091258.395187-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH v2] spi: atmel-qspi: Memory barriers after
 memory-mapped I/O
Message-Id: <173625110018.23847.7363192643987703594.b4-ty@kernel.org>
Date: Tue, 07 Jan 2025 11:58:20 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 19 Dec 2024 10:12:58 +0100, Bence Csókás wrote:
> The QSPI peripheral control and status registers are
> accessible via the SoC's APB bus, whereas MMIO transactions'
> data travels on the AHB bus.
> 
> Microchip documentation and even sample code from Atmel
> emphasises the need for a memory barrier before the first
> MMIO transaction to the AHB-connected QSPI, and before the
> last write to its registers via APB. This is achieved by
> the following lines in `atmel_qspi_transfer()`:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-qspi: Memory barriers after memory-mapped I/O
      commit: be92ab2de0ee1a13291c3b47b2d7eb24d80c0a2c

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


