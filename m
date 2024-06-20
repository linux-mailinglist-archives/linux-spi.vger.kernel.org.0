Return-Path: <linux-spi+bounces-3496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8054910245
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79841C20F8F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452301AB347;
	Thu, 20 Jun 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+ciX+7/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1614B1AAE31;
	Thu, 20 Jun 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882022; cv=none; b=U+6VqxsXGUHB5m/L0gm1mXyfJSmCP7v39rKUygsi0iimHamFGHs4olHEa/dZfe4PBvdpk2a4s8/vWiLR1Li7uhMmcHb7hOmVwRepkIXQpApDCuC1ZFrk/D42KbstanADsAwwQzgnw7iw207ngjk2poElQxh8XcQaxapvz3rF12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882022; c=relaxed/simple;
	bh=9lU9SCunukbwJTvWp/V2/Hw3p5re4G5qwe5VJ2ixKo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tfPu314A8mI/DXFVNYHT+bs5qlcCxP1ZbfHaYdG0Oy1OYdsGq7d/WFdooZO1Kjk0CGubSqAUjP681KYvG3Trr9A6GTf19FulOoezWdCt/b1UB1cdWsSlvatHHRzdtaRWLsgbqnHsoBGSRHu8Jhkezpw3G63pSvd26mCT0+e/wVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+ciX+7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6370DC2BD10;
	Thu, 20 Jun 2024 11:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718882020;
	bh=9lU9SCunukbwJTvWp/V2/Hw3p5re4G5qwe5VJ2ixKo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N+ciX+7/62Ppc/6qb11rUK2HBI+bxOV869WxqmRv6ilaF9c9POk/+qy/uGDUevwoG
	 y0GPYyDxvLKn1oUOLfZmeHP+fFITOWGmT5B7GcpKVHiHH9wpH+T1gIbmlM7Ccx6bgT
	 wnwxgR4BPBGKkDSZQGNnKIo6vA9QlJ9Uut203XlhHXtbpHrEdFCFYNi2HW2qZ7pj3F
	 8wd+lIBccGY4aA4BADwEKRjBmQ5v5ALGhjNy6Bvd911Ll4GPlE0Fb5s2h2/M22hdxg
	 v5R0ingTg1sYFIY8ZQh7Uh7LTqITEyx1o+/O09o+YN8JxV20pSUr797ahcR6ITFdmW
	 i3vNMzy+ll6EQ==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Stefan Moring <stefan.moring@technolution.nl>, 
 Benjamin Bigler <benjamin@bigler.one>, Carlos Song <carlos.song@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Adam Butcher <adam@jessamine.co.uk>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stefan Bigler <linux@bigler.io>, Sebastian Reichel <sre@kernel.org>, 
 Thorsten Scherer <T.Scherer@eckelmann.de>
In-Reply-To: <20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de>
References: <20240618-spi-imx-fix-bustlength-v1-1-2053dd5fdf87@pengutronix.de>
Subject: Re: [PATCH] spi: spi-imx: imx51: revert burst length calculation
 back to bits_per_word
Message-Id: <171888201712.41294.3998570181399309379.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 12:13:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 18 Jun 2024 19:34:18 +0200, Marc Kleine-Budde wrote:
> The patch 15a6af94a277 ("spi: Increase imx51 ecspi burst length based
> on transfer length") increased the burst length calculation in
> mx51_ecspi_prepare_transfer() to be based on the transfer length.
> 
> This breaks HW CS + SPI_CS_WORD support which was added in
> 6e95b23a5b2d ("spi: imx: Implement support for CS_WORD") and transfers
> with bits-per-word != 8, 16, 32.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-imx: imx51: revert burst length calculation back to bits_per_word
      commit: df75470b317b46affbe1f5f8f006b34175be9789

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


