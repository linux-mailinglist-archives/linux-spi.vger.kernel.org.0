Return-Path: <linux-spi+bounces-8227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C865ABFC8E
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EA74E7319
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3214028B7F1;
	Wed, 21 May 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbnxd02T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E47482EB;
	Wed, 21 May 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747850166; cv=none; b=nOtq4bKHOVITXuzNA/4aMcKNXWUrYbj/GjHDZPwZwzVSbn7bEDgjBZbqHk1wfX0w9QNWhbbPOppkZyzmJQGtUUG6DqoMB6DIkYm7ez66rProBRjMgBewrZGplnAsJm4yfMM9rYayUgoKIKuLsirfr94oXON7NT9y3JawX039Df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747850166; c=relaxed/simple;
	bh=SH3v7r/YeP+ILksXxAq4H6i/5FdXirbGQTMwOfTFny0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=COIOsr0K/hQJPzLhxyGOqlCS6ow8aDhMWVroXdSl7Vn8qn/iXRqqPwynG2avEBW2Ycnmb6c73TJGwcEjoCtjPeY4OIryWE0AASQj4nwZyCfc11aA94vEeGpaQS0TFP6l6rR68+HOi7GqnGxNzDr3mLv42ZqxiLp7d8jl1bKABrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbnxd02T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D6CC4CEE4;
	Wed, 21 May 2025 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747850164;
	bh=SH3v7r/YeP+ILksXxAq4H6i/5FdXirbGQTMwOfTFny0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pbnxd02T3gFqUPMywHByGWNqP4yHJv049nk0XpF8GLIt6EkzkEVJp3Mq0lDhrCpLV
	 nDe3S5GGj1AbfQcnTfI6EhFgN8zEI+yeXzhI6EYBQdTOKU1aICAOrvBl1fPsp4yDzw
	 26GdpAQisHmuBYM/aItT8RbInXIZVISglDGWrWtd4RAZ51y5hH5FuFQjJNCOqg2QAi
	 u8MvnleyLUJh2SvrJjSG8WbHUCre3t+6aCKOCdsrsMJFop0RnD92g0cms9fyvKxGs3
	 XXGOb70FeRtmlnuDMOw16h0nv6xnQGhti9PhX8rLu/8aGcnmzAEClsa6jrjP4qfdxa
	 pTer5+zRybQQg==
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
References: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
Subject: Re: (subset) [PATCH 0/2] arm64: dts: rockchip: Add spi nodes for
 RK3528
Message-Id: <174785016195.188147.3036453631222636236.b4-ty@kernel.org>
Date: Wed, 21 May 2025 18:56:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 20 May 2025 18:01:00 +0800, Chukun Pan wrote:
> There are 2 SPI controllers on the RK3528 SoC, describe it.
> Tested using st7789v chip with spi-cpha and spi-cpol properties.
> 
> [   10.831306] fb_st7789v spi0.0: fbtft_property_value: buswidth = 8
> [   11.042915] graphics fb0: fb_st7789v frame buffer, 240x320, 150 KiB
>  video memory, 4 KiB buffer memory, fps=20, spi0.0 at 15 MHz
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: Add rk3528-spi compatible
      commit: 70e5f38e734572ca5a56cff48cf01a0f31917099

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


