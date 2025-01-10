Return-Path: <linux-spi+bounces-6317-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA584A09658
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FBBE7A4AA6
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B766B212FB2;
	Fri, 10 Jan 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/Tqf1J0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E81211A11;
	Fri, 10 Jan 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524046; cv=none; b=GEjlYLqpv6DwHMnzMkOq1zqMFmrDiT9/C7GTN4qB3JG4XHlLLYxRTs7jplE3Hx1SaYfR15G1S3RpQqzA1Rbd+GVnpD7RdaVvoSx+F+7wfq6E7xlqAjp+MC8bwhZKFIwzR9gkvEzmDquySBkiJv5NsgiI+tEpw8jf+898Ac7L+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524046; c=relaxed/simple;
	bh=v73Vw62MTNkPdqw8cVZvUOLB+25Ygi2g/dhpqPSNGOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xw1uiXaVK+YdxwopmM/7N2oyt/PIkOL8klJ3+n6oswZUXfV6+XZXL84hRcrktCHZ21FznI6FrZHsIf02Z82x2gHW1+MzyUX0a3IkqWQBnGnyxMf8r4vsCcS7vFSnZGC2uNpNNaXzT1tf/iETigiyhgIPE+a59nMSkg8pHRHQa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/Tqf1J0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF99C4CEE1;
	Fri, 10 Jan 2025 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736524046;
	bh=v73Vw62MTNkPdqw8cVZvUOLB+25Ygi2g/dhpqPSNGOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l/Tqf1J0YeqgmGTlb9OUQ/Wvq+oCw2zgnE8wFFqL59zvdOgp7O+gqxEegYCMlag5B
	 Q6YYo8nE4BAqap4CwWdBHEB5spPiRJAR3xfPANPsrUl8QBsBJkFuY9/mmloDugDn53
	 oTrzlRuyCsQh3Pip0J9mKHKMBRqWqQrHqvRlba7lqg2A2mhrzj5cyWW+hzMCeL8RK0
	 5GclltoKebgtyrLyhSxH8ccfanUNpL8t1yEknIhnlxVvFmJDoCR6QoQO2CNOzLGW18
	 eGfHAbzkQCEt/QvPwSazROLltVeDVxhce+xTw1U85pnahOGx6/HmZUCI7bRjv8s9WC
	 Mv9KDA4WfFk4A==
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
In-Reply-To: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
Subject: Re: (subset) [PATCH v2 00/27] spi-nand/spi-mem DTR support
Message-Id: <173652403824.316821.7989247622292618802.b4-ty@kernel.org>
Date: Fri, 10 Jan 2025 15:47:18 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 24 Dec 2024 18:05:45 +0100, Miquel Raynal wrote:
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

[01/27] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
        commit: 0fefeade90e74bc8f40ab0e460f483565c492e28
[02/27] spi: spi-mem: Add a new controller capability
        commit: 1248c9b8d54120950fda10fbeb98fb8932b4d45c
[03/27] spi: amd: Support per spi-mem operation frequency switches
        commit: d0e5faccb229b1dacc4c9fa11f6df33bb1fdabd8
[04/27] spi: amd: Drop redundant check
        commit: e6204f39fe3a7b4538815a2d778b601bd543649e
[05/27] spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
        commit: 5baa189789e8894c58eacc7803e3c163c1d0fc0a
[06/27] spi: cadence-qspi: Support per spi-mem operation frequency switches
        commit: 06e9f5a1f6ba774d8942a168d3ec5ed5a008fbcb
[07/27] spi: dw: Support per spi-mem operation frequency switches
        commit: eee7bc9e7ade6f7ac17d9ec02887cd5509ba9427
[08/27] spi: fsl-qspi: Support per spi-mem operation frequency switches
        commit: 2438db5253eb17a7c0ccb15aea4252a150dda057
[09/27] spi: microchip-core-qspi: Support per spi-mem operation frequency switches
        commit: 13529647743d906ed3cf991f1d77727e7ff1fb6f
[10/27] spi: mt65xx: Support per spi-mem operation frequency switches
        commit: 13fd04b53053bbfa741a0f2a781837ab80e485f6
[11/27] spi: mxic: Support per spi-mem operation frequency switches
        commit: 67707cb094f134f5b3931eefbedbb9ca7e3209d0
[12/27] spi: nxp-fspi: Support per spi-mem operation frequency switches
        commit: 26851cf65ffca2d3a8d529a125e54cf0084d69e7
[13/27] spi: rockchip-sfc: Support per spi-mem operation frequency switches
        commit: d3f35dd3ad968256ed1080e3ea2022f947861cff
[14/27] spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
        commit: 1a206344218cc15ad8f321e3abab3f3d36ab639f
[15/27] spi: spi-ti-qspi: Support per spi-mem operation frequency switches
        commit: b2fac3192919dd07e7ce30558e34abd7e07dde77
[16/27] spi: zynq-qspi: Support per spi-mem operation frequency switches
        commit: 9a68f6c8d6cfddeac7c5874528ed04e50a1cb579
[17/27] spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
        commit: 30eb2e6e78225f92f04a2325c6fd77fe8f5b4aab
[18/27] spi: spi-mem: Reorder spi-mem macro assignments
        commit: d1f85873d2d62d6980e68d21d3a21f20b0664cc3
[19/27] spi: spi-mem: Create macros for DTR operation
        commit: f0006897a96c736623ddeb9b68c3880eb5cdebe7
[20/27] spi: spi-mem: Estimate the time taken by operations
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


