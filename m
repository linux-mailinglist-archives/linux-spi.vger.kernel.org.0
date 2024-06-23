Return-Path: <linux-spi+bounces-3540-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB67913A5F
	for <lists+linux-spi@lfdr.de>; Sun, 23 Jun 2024 14:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5231C20A62
	for <lists+linux-spi@lfdr.de>; Sun, 23 Jun 2024 12:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4613180A7D;
	Sun, 23 Jun 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLhknbsX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D7148825;
	Sun, 23 Jun 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144472; cv=none; b=EHHaFo/M/KTnanv83h35kqt5NwEZSvltp1ydYoXxCC0EdONPU5na7fInHAZNZwQgAXrha6/oSZuh/Vuc5OFp5Y7W4FVTMnkBaz4inj/QpqJ+7DwAuCZN7VZJAIIoGPANthF1KUB8MiRniOFB2P67LNyi73TsQR0BQn+pl4gXXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144472; c=relaxed/simple;
	bh=Wmb/86jM43BcTSOVaNxvxMISlaSiZK/r2i4qLz3CQvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KQv59RFb2KqiZdQAEKu0SBuelYubJUfy+p0uPNYns90IU3tXSEiTM744X4J7P9wSQ0xVAbs/zECD1p60PQQj+nmK5Y66AQ80Z89Q6236EPLO6x1/6hHfIM1dqDPkDsnM7m3JspXTQamltV22qRHvlRly/V4Te4MVV2ZjxYsAj4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLhknbsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02540C32782;
	Sun, 23 Jun 2024 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719144472;
	bh=Wmb/86jM43BcTSOVaNxvxMISlaSiZK/r2i4qLz3CQvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hLhknbsXKZdSFAXCje0sl4Yoh2NcwTuNnnujBXIVlT6J/edLJ/0HH3VMF8R9NEN/3
	 aKO7Ndy6xczDVP8p6yENufRjLjl0ETRb+FAEMioxhhfQATWR7/221yBlh3nknqtD49
	 WCPWrFPPvifpBg9qnfKX2PupLuHZLYd2suP1m/AJhZ02BN8IyvKOnlE7PJvNVYLm3L
	 B90A1WVG3PVx8T8IEc9mhLnGJB5EO492PlCuUrem2xnAVJ8Rapd+168Ch4Xv5mf+AS
	 lx+ZrqbZMQJrw9QI0OKY0mokyzEzBsHftU61N0Ly81HYAlCHSlPQrOMVhrlT/A39c5
	 W3gMWGEp9+AEw==
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Martin Kaiser <martin@kaiser.cx>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
References: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53}
 cspi devices
Message-Id: <171914446971.325901.17325396077527564535.b4-ty@kernel.org>
Date: Sun, 23 Jun 2024 13:07:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 08 May 2024 11:56:10 +0200, Uwe Kleine-König wrote:
> While in commit 2dd33f9cec90 ("spi: imx: support DMA for imx35") it was
> claimed that DMA works on i.MX25, i.MX31 and i.MX35 the respective
> device trees don't add DMA channels. The Reference manuals of i.MX31 and
> i.MX25 also don't mention the CSPI core being DMA capable. (I didn't
> check the others.)
> 
> Since commit e267a5b3ec59 ("spi: spi-imx: Use dev_err_probe for failed
> DMA channel requests") this results in an error message
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices
      commit: 5d0c35feea339e4a3a9c9e99731e4d49ad5ee329

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


