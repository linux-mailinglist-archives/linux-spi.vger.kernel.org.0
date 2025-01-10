Return-Path: <linux-spi+bounces-6316-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45531A0964F
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF323A3C7D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C472116E7;
	Fri, 10 Jan 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7wMvdgt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5E2116E5
	for <linux-spi@vger.kernel.org>; Fri, 10 Jan 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524039; cv=none; b=h9ilLpqTZIrgGS23FTJGYOwkhxTGrabgGqgoCEPgZ9xDHh488ddd6hVjtNkZaQcADI0UOYsKgZTV839o/7jDMYn4Dj7sAvV+tZD6f4kFfCIzm6u27Hsc7wsc/w7mlvylXLjx0WiOMbA0/qS8osdvrkVGfOJpROfhKhs+xlFNeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524039; c=relaxed/simple;
	bh=/Zqa3AGoeCGvcpQ4MTJUuWZlZU37bLafB7PYbUoChBg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T/SSmMJ35r1S9TxOJwK0LNWEzZjeBKzBIuFzdDRjpsYXUMVnvuk8uOUcrhWowSAAq45QUm2RQZChLj3qvWLDip0U8gwpTglMxMRH6wYtlJxphISvRI8q9/2CHF6FCKUGBl+DNsL2AFOGK7wButbWTNCUlkrzUGOd1SE+BCifA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7wMvdgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B812C4CEE8;
	Fri, 10 Jan 2025 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736524037;
	bh=/Zqa3AGoeCGvcpQ4MTJUuWZlZU37bLafB7PYbUoChBg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M7wMvdgttdCb7/93cfVX7j5gkXY20wTJ85SywmRo8BgGnTSgQFPICzl5Yrw5IMKOr
	 4qA8gIoJPg/Dhvq2KYA/8wp9eKBz55TQSRnVzH3iTpLRjjGE+2Y6B7ZcVZgkaOnril
	 o+WBmXmV/mTAKAQRjQJ+hRHAFB5b884LqonLtWH4rTIrWwWyJIE4Lg7WV2TdhzM2/N
	 FVcPFQBR5bJ1AGoUWHyYi4S7dbSM3vP8n31pa/RuEMe5fgPnsBV/AjJZZh+xQ3WOGY
	 M4NzG6IDEPRroVcpVwZgoVpeDe8mkwdnQ/YSzXBV9ROjU5cbnpBpRJWkDpIaf7x9JZ
	 8zIC2VzlUjupA==
From: Mark Brown <broonie@kernel.org>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-spi@vger.kernel.org, Steam Lin <stlin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
In-Reply-To: <20241025161501.485684-1-miquel.raynal@bootlin.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
Subject: Re: (subset) [PATCH 00/24] spi-nand/spi-mem DTR support
Message-Id: <173652403383.316821.3574872566967987721.b4-ty@kernel.org>
Date: Fri, 10 Jan 2025 15:47:13 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 25 Oct 2024 18:14:37 +0200, Miquel Raynal wrote:
> Here is a (big) series supposed to bring DTR support in SPI-NAND.
> 
> I could have split this into two but I eventually preferred showing the
> big picture. Once v1 will be over, I can make it two. However when we'll
> discuss merging, we'll have to share an immutable tag among the two
> subsystems.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/24] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
        commit: 0fefeade90e74bc8f40ab0e460f483565c492e28
[02/24] spi: spi-mem: Add a new controller capability
        commit: 1248c9b8d54120950fda10fbeb98fb8932b4d45c
[03/24] spi: amd: Support per spi-mem operation frequency switches
        commit: d0e5faccb229b1dacc4c9fa11f6df33bb1fdabd8
[04/24] spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
        commit: 5baa189789e8894c58eacc7803e3c163c1d0fc0a
[05/24] spi: cadence-qspi: Support per spi-mem operation frequency switches
        commit: 06e9f5a1f6ba774d8942a168d3ec5ed5a008fbcb
[06/24] spi: dw: Support per spi-mem operation frequency switches
        commit: eee7bc9e7ade6f7ac17d9ec02887cd5509ba9427
[07/24] spi: fsl-qspi: Support per spi-mem operation frequency switches
        commit: 2438db5253eb17a7c0ccb15aea4252a150dda057
[08/24] spi: microchip-core-qspi: Support per spi-mem operation frequency switches
        commit: 13529647743d906ed3cf991f1d77727e7ff1fb6f
[09/24] spi: mt65xx: Support per spi-mem operation frequency switches
        commit: 13fd04b53053bbfa741a0f2a781837ab80e485f6
[10/24] spi: mxic: Support per spi-mem operation frequency switches
        commit: 67707cb094f134f5b3931eefbedbb9ca7e3209d0
[11/24] spi: nxp-fspi: Support per spi-mem operation frequency switches
        commit: 26851cf65ffca2d3a8d529a125e54cf0084d69e7
[12/24] spi: rockchip-sfc: Support per spi-mem operation frequency switches
        commit: d3f35dd3ad968256ed1080e3ea2022f947861cff
[13/24] spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
        commit: 1a206344218cc15ad8f321e3abab3f3d36ab639f
[14/24] spi: spi-ti-qspi: Support per spi-mem operation frequency switches
        commit: b2fac3192919dd07e7ce30558e34abd7e07dde77
[15/24] spi: zynq-qspi: Support per spi-mem operation frequency switches
        commit: 9a68f6c8d6cfddeac7c5874528ed04e50a1cb579
[16/24] spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
        commit: 30eb2e6e78225f92f04a2325c6fd77fe8f5b4aab
[20/24] spi: spi-mem: Reorder SPI_MEM_OP_CMD internals
        (no commit info)
[21/24] spi: spi-mem: Create macros for DTR operation
        commit: f0006897a96c736623ddeb9b68c3880eb5cdebe7

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


