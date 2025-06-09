Return-Path: <linux-spi+bounces-8408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA10AD26CF
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 21:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE716166F9F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 19:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E321D5B5;
	Mon,  9 Jun 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzVTCF4+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C92F4A;
	Mon,  9 Jun 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497629; cv=none; b=gQ7Yo97k9dUw5JvOqX1KpmnH5NIXDalYXn4l9cu9OXsCL2lHC9bDRbPHmrtkczJovDc9c4oYhvSio/kCxvqr0EejzfMraibZiEMTX8nK7Bvt6vepK50meSPXoSnmhh+UrvStg0uefufmBqgD9d+WzvgdB1GAJ7Qn0/sy76ZypWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497629; c=relaxed/simple;
	bh=29yRo6RPxQh+/QZzJP1u/4ErdaOrzZjMU+NJw20l2bM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mky6sAWAWSpfU9q5/Q8mdZUJ5nSBv6Eps9cph1rsMRmctac4kBpfgx+zipTiUMRnE+3q9srjZhZYctxxwKYX2X0NE6CdlxO7zDoRSANHfUHFYjDD3uW+01fNmmEc6Rz1+1FFY8Wus2jd+V8A4+fCgn4EKRVABVCu3KxIPVHpZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzVTCF4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0987EC4CEEB;
	Mon,  9 Jun 2025 19:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749497629;
	bh=29yRo6RPxQh+/QZzJP1u/4ErdaOrzZjMU+NJw20l2bM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dzVTCF4+/WNoSRjQTdz/EC0sZ2J9OWquqckraAJ7DfINQKYMiCidAOb31pzazIBye
	 7+Jl7XqdzWN3IvEFOyKaDVoFVVt8nCM+cor+PDaZBh7PPR8PYdNEMkYoIzhMiISc2T
	 PIdZ7YB4lvbACiu0cgWmHX7MJZBsen0F0rHqWtr7iMyfF17zXHhEMxqq0xM/3RSKp0
	 7gU3z4Z0bJJVZdvhkem7evpK2qte2ftg1D9R+sMnPnXXiuP2RuPEl3gjcBvjcOansB
	 KfKMHLHWtkKBi943JXaUEtRWbNq/OwrhTWCAiOaDIuA6PJkFhBzkgsj7tyATWuU6O3
	 gaEKv/+wsjNpQ==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 James Clark <james.clark@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chao Fu <B44548@freescale.com>, 
 Xiubo Li <Li.Xiubo@freescale.com>, Lukasz Majewski <lukma@denx.de>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Xulin Sun <xulin.sun@windriver.com>, 
 Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>, 
 Marius Trifu <marius.trifu@nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 Andra-Teodora Ilie <andra.ilie@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>, Dan Nica <dan.nica@nxp.com>, 
 Larisa Grigore <Larisa.Grigore@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
References: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
Subject: Re: (subset) [PATCH v2 00/14] spi: spi-fsl-dspi: DSPI support for
 NXP S32G platforms
Message-Id: <174949762279.256775.5072206138424672774.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 20:33:42 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 22 May 2025 15:51:29 +0100, James Clark wrote:
> DT and driver changes for DSPI on S32G platforms. First 3 commits are
> fixes for various edge cases which also apply to other platforms.
> Remaining commits add new S32G registers and device settings, some S32G
> specific fixes and then finally add the DT compatibles and binding docs.
> 
> Tested in both host and target mode on S32G-VNP-RDB3 by transferring to
> an external device over spi1 using spidev_test.c
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[04/14] spi: spi-fsl-dspi: Re-use one volatile regmap for both device types
        commit: 87a14a96bc323aff824fad8cdbe61b78eff22255
[05/14] spi: spi-fsl-dspi: Define regmaps per device
        commit: 1672b0653212cecf11be9ef55bc2a2fabe0fa2ca
[06/14] spi: spi-fsl-dspi: Add config and regmaps for S32G platforms
        commit: 70c0b17ee344b0c14b88e6b5b1db6abe2fa84218
[07/14] spi: spi-fsl-dspi: Use spi_alloc_target for target
        commit: e7397e4d3b161ed8a57648a9ac03df7902958682
[08/14] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
        commit: cac7e5054115fcc41b1cb050af8e8971f7c9b22b
[09/14] spi: spi-fsl-dspi: Use DMA for S32G controller in target mode
        commit: 870d6fda18d590df88beac9b0504f810807a5ed6
[10/14] spi: spi-fsl-dspi: Reinitialize DSPI regs after resuming for S32G
        commit: c5412ec5f687732f9722bd0f94f9632ad78f4c52
[11/14] spi: spi-fsl-dspi: Enable modified transfer protocol on S32G
        commit: 0cb9ca1187b311db21288a79ec7b98121f730354
[12/14] dt-bindings: spi: dspi: Add S32G support
        commit: be47ecfecf5a6f16d028fd572410251b502692bf
[13/14] spi: spi-fsl-dspi: Enable support for S32G platforms
        commit: 9a30e332c36c52e92e5316b4a012d45284dedeb5

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


