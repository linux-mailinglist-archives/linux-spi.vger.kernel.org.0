Return-Path: <linux-spi+bounces-11516-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D24C85CCB
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65413B2CBF
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD153271E7;
	Tue, 25 Nov 2025 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0Py0L+7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1743F218ADD;
	Tue, 25 Nov 2025 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085106; cv=none; b=MJXbmfBhwRU1+S8i9VRVcoF+xVljqhnybHJKyY6Wpoist8oeFZzCW67bEWew4JSemc8K2uhCA+g7DXQQ2Aodd2abmTveLBH7aC1IsuPA/yilztOMafjs+0u+w6eUEyoEelS8Sy29BSMZ42eq5kXo0joinkpYmp7YZoWPxGRz/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085106; c=relaxed/simple;
	bh=l1hHx/WQnpmqCzaOMp9ys9wsVHXuHU5zhwDzoXQAt4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UQttZRsiiDoOFSN8c8qklaT2c+BmIBz68tSUGRyOYJ2QW30Cfem3I1LyiYbTjpNmgjm94T9vjyMYp5/Vt03GsczhRTYzwvQjZmm1jwcgMJM4iMk2WTxXuU7LTexN7wudQIPp/MszVsRKODNAbPI1UyS7MFpJwiHIRWW2J7jEGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0Py0L+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78666C4CEF1;
	Tue, 25 Nov 2025 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764085105;
	bh=l1hHx/WQnpmqCzaOMp9ys9wsVHXuHU5zhwDzoXQAt4s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o0Py0L+7Gu1+D50nVrg/21eAL9UAutIrrw/r13Z/5b3uSisqYBF323a1xX5MO8iCd
	 xOL+bFc8ZSUKIzqJTgR7XbbsVLUmlvw+ANVckZ/n9i181wI1VfEhifg1xdFmBgqxdN
	 Rz1ImnDXqVJM9wAPNKNNRxFAANxNaxTZYmXsrSNUuzM+17reWB4+ETE3lW2Id/5g45
	 fMUOfNKYWgRd+Ik5u34Da8TJIKjhhXsv5mbtvU5lStNMcbw4qbhK+QZ0MuZby3ooFk
	 u9hO3/dh0LC9slJMk0lpbOyRGHZPJMc0u6yx5sTEyAAWwh2NEFKX/+MV13LdSfu7g1
	 OP9AL+C3X90MQ==
From: Mark Brown <broonie@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
Subject: Re: (subset) [PATCH v4 00/13] Add RSPI support for RZ/T2H and
 RZ/N2H
Message-Id: <176408510323.37451.14852315229869698536.b4-ty@kernel.org>
Date: Tue, 25 Nov 2025 15:38:23 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 19 Nov 2025 18:14:21 +0200, Cosmin Tanislav wrote:
> V4:
>  * remove conditional minItems: 2 and maxItems: 3 for clocks property
>    since it is already set to that
>  * remove renesas,r9a09g087-rspi check since it implies
>    renesas,r9a09g077-rspi
>  * replace contains: enum: with contains: const: since there's only one
>    compatible to be checked against
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/13] spi: rzv2h-rspi: make resets optional
        commit: aead5ae91e4cbadac817d15737eca3b531237448
[02/13] spi: rzv2h-rspi: make FIFO size chip-specific
        commit: 8e89ee6cd2b928a8431bef61e8b851ce5df1ecb0
[03/13] spi: rzv2h-rspi: make clocks chip-specific
        commit: ebd7d6ae0dc7d65e21460c928519f40ccf95f3b9
[04/13] spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
        commit: 1b7ce968ab2579702ea9dbc2fb599e540bbd8c88
[05/13] spi: rzv2h-rspi: avoid recomputing transfer frequency
        commit: 88782493204512fcf4e020e2385bca3e3c5bd4c0
[06/13] spi: rzv2h-rspi: make transfer clock rate finding chip-specific
        commit: 77d931584dd38916b66c65320c80a65cbef4b122
[07/13] spi: rzv2h-rspi: add support for using PCLK for transfer clock
        commit: 1ce3e8adc7d0038e59a7c9f5c9e5f399ba0db5d6
[08/13] spi: rzv2h-rspi: add support for variable transfer clock
        commit: 9c9bf4fdc5e5d09d5f4280ed2c582df6e1f837d9
[09/13] spi: rzv2h-rspi: add support for loopback mode
        commit: bc4f0b1e39035b9bb3d5d9692074702110f5e2b1
[10/13] dt-bindings: spi: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
        commit: e93d7b2d8b349f659fa9456048ee86e10eb422f9
[11/13] spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
        commit: 0cc8cd824b9fb7fb087a2ec6b0c80d812cc4fde7

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


