Return-Path: <linux-spi+bounces-8216-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA71ABD5DB
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 13:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FEA3A5408
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B62750E5;
	Tue, 20 May 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMKGvJ+Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1426FA55;
	Tue, 20 May 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739135; cv=none; b=Nu85Fgnj621P+RwzwhYABAQ8lE9ECg8y9+aVIhLZEZAG2VgZ5qZ4o2OnOPWfVpLP80mwhcYnOQOHH1eF2zpW94LvGLXfS/adII+ofURfmEZZn+nQeF05UQSV27F2w1bZ2WU//uPmPAsAnZLSX2ShPpxTE7et2dK0DrPI9FkawZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739135; c=relaxed/simple;
	bh=BzM5eezg+Jq4uHv+EFiCbNDAznLjHKhPfidi6xdRYHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d/Y9WycTt7UuwrourIjTCujSNP48rPH+Y1MPJoVEBZmAb4nkDKqnUdbqSMtIzSV75gFuwPiMjJML3embUBKj6L1HGsEgaO6soccPTJiIMN/5eN+MtgCIah/HfTr/dcBEzrBD5wZVkyPKUM/N3fPdv4txl95AGrNce7MRlEHvuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMKGvJ+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E77CC4CEE9;
	Tue, 20 May 2025 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747739135;
	bh=BzM5eezg+Jq4uHv+EFiCbNDAznLjHKhPfidi6xdRYHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sMKGvJ+ZOLtUHq2C+k1UKRtGk1FjqXG1he9Tp0IvdYqP5bSPWZ5DKmuDlDma4ezzt
	 vz789zlMsbzbQCfRcNdhoA8X74Nknxdaj9kRWb9mT0cbsK7Ow7+pTbFizppiPHJAlV
	 DxCS0UpZwhSSFYRgqciZ0sk8I2fpfvQodw/j2Zzf3cITxHB1fYTzqwseRibL5U3oZ3
	 KqbS/p6Fk5oA4OQBoUL+q4eW0ePZPDKec2fTGTeI8cCAZBmYXJK1tKRdc/U2xQHGK9
	 o4qm7UuvbD5Xf98Vn/1DCraSE2UxDu4R2Myn+SO6xHSCtLYXnWoTKY1QwezngI34kF
	 7MNZSisu8h1tQ==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <cover.1747401908.git.geert+renesas@glider.be>
References: <cover.1747401908.git.geert+renesas@glider.be>
Subject: Re: [PATCH v2 00/22] spi: sh-msiof: Transfer size improvements and
 I2S reuse
Message-Id: <174773913326.45044.17561258385571481956.b4-ty@kernel.org>
Date: Tue, 20 May 2025 12:05:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 16 May 2025 15:32:03 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series (A) improves single transfer sizes in the MSIOF
> driver, using two methods:
>   - By increasing the assumed FIFO sizes, impacting both PIO and DMA
>     transfers,
>   - By using two groups, impacting DMA transfers,
> and (B) lets the recently-introduced MSIOF I2S drive reuse the SPI
> driver's register definitions.  All of this is covered with a thick
> sauce of fixes for (harmless) bugs, cleanups, and refactorings.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/22] spi: sh-msiof: Drop comma after OF match table sentinel
        commit: 0e1c7d0591ac4054c67529e200a9edfaf5344f4a
[02/22] spi: sh-msiof: Remove unneeded compatible values
        commit: ee44d3fc9d8b882cbc98acf2d3c773aba971aa67
[03/22] spi: sh-msiof: Fix maximum DMA transfer size
        commit: 0941d5166629cb766000530945e54b4e49680c68
[04/22] spi: sh-msiof: Complete using dev in sh_msiof_spi_probe()
        commit: 74df74ee83acfea4e9a6b47386c7907379c9295f
[05/22] spi: sh-msiof: Use bool for boolean flags
        commit: 3dd5ed19a2e8283f9ead5f2fd09b267a337ab86d
[06/22] spi: sh-msiof: Make words/bits unsigned in sh_msiof_spi_txrx_once()
        commit: b4eec5cdf112e3a4e286fb79fe507b09e2fca66f
[07/22] spi: sh-msiof: Make words/fs unsigned in FIFO helpers
        commit: 74cb19c943ddb46f3d06323c3d0469f14282c8ca
[08/22] spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
        commit: 6bae252a9452ca8496670230a7821c34450763a2
[09/22] spi: sh-msiof: SITMDR2 and SIRMDR2 bitfield conversion
        commit: 386cc5207ba2b68a4672cb68810c44412531e74e
[10/22] spi: sh-msiof: SITSCR/SIRSCR bitfield conversion
        commit: c2cc4b72fc14c84fdb1bc49ec98af252ed64fbf3
[11/22] spi: sh-msiof: SICTR bitfield conversion
        commit: bd8d6658e7084ff9e78da9623633e79c9d31ad68
[12/22] spi: sh-msiof: SIFCTR bitfield conversion
        commit: 8f3903b382f73eb5c36d342dea838d991e4bbe08
[13/22] spi: sh-msiof: Correct SIMDR2_GRPMASK
        commit: acedbff0f0de1c116a0f8d943c4cf005f61f6143
[14/22] spi: sh-msiof: Add core support for dual-group transfers
        commit: 955f7ce6680564963765e5fc1c3e71027a39a806
[15/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen2
        commit: 1ab2c8c45f5c5df6707cc848686e674f4ec5c3d9
[16/22] spi: sh-msiof: Correct RX FIFO size for R-Car Gen3
        commit: f669c2827dd691b10fcf4e4c5546869a51d0a46e
[17/22] spi: sh-msiof: Increase TX FIFO size for R-Car V4H/V4M
        commit: 5b91dc7e3e371e7263b95c0d31151c645d6652a6
[18/22] spi: sh-msiof: Simplify BRG's Division Ratio
        commit: 39d0856f4102b6b61fdc650f90a1d9231e2bab17
[19/22] spi: sh-msiof: Double maximum DMA transfer size using two groups
        commit: acb47aa9b1e2f47121cf2233fcaf998151ab5410
[20/22] spi: sh-msiof: Document frame start sync pulse mode
        commit: 8f836868d848a9b84c38ae1f8e7366e01927c024
[21/22] spi: sh-msiof: Move register definitions to <linux/spi/sh_msiof.h>
        commit: ec23a899d96f9ee3389abe6c516d09cae2fde5e3
[22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>
        (no commit info)

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


