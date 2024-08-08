Return-Path: <linux-spi+bounces-4151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C394B8B1
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 10:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7981287572
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2024 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD281898EC;
	Thu,  8 Aug 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdDMFrzp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB61898E5;
	Thu,  8 Aug 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104771; cv=none; b=OIl+Uip5R48XzaBPbg2XXxpmGy37UL7TwuU/bmk6w2WQDISORJdZ46Gy7/Ri2keBmQWiNyxlybX/QPfMgeR2xHHzf19QjQTSDdV8B2YwoSS+nEClKUqa+NxGZld1nlspIGelkGmYz5822PNwbgyQByAaRpHfphnIhMKXd6rnbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104771; c=relaxed/simple;
	bh=prAGj4813QpEAOsf6gD91d3mcmqSmg7tAFqjim6zVpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GkFilCo3dXyxrsbms+T9uEbW2ZJrEvkuYTv6QpMVIhrdjuw+vZZYkoy+QjP/JTbS6Ykj2c1wPr7oXaXBIUzHP8tGPGEYmYjqDYtBFPV3ofDlcC+ubx3UY4evSPFdHjyVQScUEjFCmxpoTKQ0cPcSUrjaQfINCA46RSTZfhrgTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdDMFrzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1316C32782;
	Thu,  8 Aug 2024 08:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723104771;
	bh=prAGj4813QpEAOsf6gD91d3mcmqSmg7tAFqjim6zVpA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AdDMFrzpah5tTOaS/TyDUAHcXYD0QsxKspdM8f2JzPuzbWnveN6ggwhNn8HGh5hBP
	 Ek5DgdxfVBv68qstTDJ1mYg4OkqoxDhZQvz4NGq5pxdOSxeSJapk5ZeZ1jttEY23QX
	 u4+jlRoWxW6+OSRsP63mfUzkmBi2zoFpB1OSTgSyPUGOZgmg9K14hKSQfXJEYDX14f
	 qEt6E2rD+7GwnIlRe1FDj0//GguORaLsUKWVFce60EfvW0fc/dWibPdROd4Nsvk/E3
	 jh+cw6zXpHNbLm18L/O/g3xZwdkxGz+AuRmrzYAJPaLOdePoukhxkhmjGdWK6cBAkl
	 3sqGAdt3E222A==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>, Gao Pan <pandy.gao@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Stefan Wahren <wahrenst@gmx.net>
Cc: imx@lists.linux.dev, kernel@pengutronix.de, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240804113611.83613-1-wahrenst@gmx.net>
References: <20240804113611.83613-1-wahrenst@gmx.net>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Fix scldiv calculation
Message-Id: <172310476855.457638.7210419373217650212.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 09:12:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sun, 04 Aug 2024 13:36:11 +0200, Stefan Wahren wrote:
> The effective SPI clock frequency should never exceed speed_hz
> otherwise this might result in undefined behavior of the SPI device.
> 
> Currently the scldiv calculation could violate this constraint.
> For the example parameters perclk_rate = 24 MHz and speed_hz = 7 MHz,
> the function fsl_lpspi_set_bitrate will determine perscale = 0 and
> scldiv = 1, which is a effective SPI clock of 8 MHz.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: Fix scldiv calculation
      commit: 730bbfaf7d4890bd99e637db7767dc68cfeb24e7

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


