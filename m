Return-Path: <linux-spi+bounces-9148-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C2B0C849
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268186C469C
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284452E0415;
	Mon, 21 Jul 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzesJ5k8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6072E03FA;
	Mon, 21 Jul 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113376; cv=none; b=k+Tj3/w35dYai5ibkHmx9Mbrv5TFUgfQeQ9GLXLTmzLXeVY++8udMPaYSmSXODMeZzjmLIPlDR5l71fsZuX7pdcMGxz4OW6wRA/OYwcJMov2WXJEpyqK/XJGnYnbWx/34RupjwbAo9BgBrlDpmkTS19maxKR5zjbnMsYZSjuLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113376; c=relaxed/simple;
	bh=RmvVp8Cc5s3PNQobge2CUWiM9uh0u33UicVxKxhwc00=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gyy3+xesZaGNd5ccBU6rwYv/c0XCxs9BtRTm/DEPtADCkalXmWeSYCau2+f9EllxXbQnRbLoNvgvqcRzprgLmYpyMOKuvM/otKR4uZUD6rudh7PTYlqC5IMA5I5WXXGXagH04STBj60CcYqfgN5mwScHbtPpixn0z9CuPdMaVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzesJ5k8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D872C4CEED;
	Mon, 21 Jul 2025 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753113375;
	bh=RmvVp8Cc5s3PNQobge2CUWiM9uh0u33UicVxKxhwc00=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mzesJ5k8af1yqWf95XwEexGnQdlboi/uiIG5R/a5H2hgmcMzJqbwL3o3LTzr9PtHi
	 n+I2d/MMeEqRRGxuoM+ZL/D/lgxAodi9PnUZQcq5J+e2c1hcHvJxDtlE6MC7K36ZN/
	 MDVgMqXN5nS6Dsh38Q4AjUZcFB970DMHP8iNkmhyad2Wna6kdYHbgh22I3Ms1hl14x
	 kPC93tv+L4Rfp3nTqjM3CP7ubRvOll5FU144rkE3RT1AumWpSyYLm8/u4Kmp//zugD
	 f6B55wu4pf3Bp0tkrPFZk+KvH0aoWZ4OCmt0urScl8JFZdN4NLDHdr/oYzozquZfq5
	 q7SBhclNl6j9Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 Chanh Nguyen <chanh@os.amperecomputing.com>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Grant Peltier <grantpeltier93@gmail.com>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Naresh Solanki <naresh.solanki@9elements.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250719063355.73111-1-hs@denx.de>
References: <20250719063355.73111-1-hs@denx.de>
Subject: Re: (subset) [PATCH v1 0/3] spidev: introduce trivial abb sensor
 device
Message-Id: <175311337130.327079.7374455187420344577.b4-ty@kernel.org>
Date: Mon, 21 Jul 2025 16:56:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Sat, 19 Jul 2025 08:33:51 +0200, Heiko Schocher wrote:
> This series introduces the changes needed for trivial spi
> based sensors from ABB, currently operated from userspace.
> 
> The last patch adds the spidevices to the DTS files, already
> in mainline.
> 
> make dtbs_check showed no errors/warnings for the dts files
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: trivial-devices: Document ABB sensors
      commit: aad2f87cbcab56b322109d26d7b11842a09df91f
[2/3] spi: spidev: Add an entry for the ABB spi sensors
      commit: d60f7cab7c04944a79af16caa43c141e780a59c6

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


