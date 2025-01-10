Return-Path: <linux-spi+bounces-6320-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28494A098F0
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 18:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6CB3A2E8A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865121421F;
	Fri, 10 Jan 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ9bZT9t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F4214201;
	Fri, 10 Jan 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531572; cv=none; b=m4+u7QBOqbHJ3AdvSxsbLWaboo0ifxUvrKwWhEf4ze/F/Pz/uOcJgwpv6rJ1M6L0NM2g2gfxrh6ZcZpMEgbLMY0fkGbubgrl5GqRnng4PPYfM3UdEksQCoxX3k1epuCySPKcP+yAMVOWOWhl/JUPNY/hUBdov8xdLzowaKv8MkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531572; c=relaxed/simple;
	bh=SFidNPCEzzdhqDMHpT0ZBS1qDa7/zS3vqT1bcr65LnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iyT0oPbfK9TQvBmQsMyKMSENLynmg+6OiImYIbTIRuq6uP6hc8A+FJzw6VAYPVF09ToR2s61C4+BtBULRhdSSVUZqNU6oOd6gStf3d4d2wQpTrASAukOVXSJtAitHSgcP/5x7c9VFTdqxaLhqELD0i2W4f34YPRK7lgILjahNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ9bZT9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAD3C4CED6;
	Fri, 10 Jan 2025 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736531571;
	bh=SFidNPCEzzdhqDMHpT0ZBS1qDa7/zS3vqT1bcr65LnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hJ9bZT9tczqg36KU4u6eeqTb1soNKUi4jFKxz0hhNEszVpwr9k9zEWBeBj7Mv9EED
	 WkgOWH7Sb6St0SIyCxaPqkDmrETi94j9+2Ii3LVSi50No2Tk9CRK/+4lP24fibBK+C
	 4Xi60yQOKPXklaK9wG0OHqz+GL9IWOfAfGvWL/mx95640061C2vJ9JNQWZHjp8e1SJ
	 tk2Au3qdBiIO8/j+Vhg+Mn2ElcAgfycx4KvLzJfuqwmIlZUJCgL8rgJG0ixc4veeVD
	 5jxTUrrLRJ50EQtM2lNw2rOhAolT6/GzU0UpbvdfSKClNKd26SMe3dm35W60OL39tW
	 +EFtowt4redjg==
From: Mark Brown <broonie@kernel.org>
To: Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mtd@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, stable+noautosel@kernel.org
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com>
Subject: Re: (subset) [PATCH v3 00/27] spi-nand/spi-mem DTR support
Message-Id: <173653156367.340868.12224888423783635897.b4-ty@kernel.org>
Date: Fri, 10 Jan 2025 17:52:43 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 10 Jan 2025 15:45:02 +0100, Miquel Raynal wrote:
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

[20/27] spi: spi-mem: Estimate the time taken by operations
        commit: 226d6cb3cb799aae46d0dd19a521133997d9db11

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


