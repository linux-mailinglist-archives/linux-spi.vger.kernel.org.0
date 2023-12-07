Return-Path: <linux-spi+bounces-175-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7E809575
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 23:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034921C20B6B
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A305646A;
	Thu,  7 Dec 2023 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM7G8omP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C457302;
	Thu,  7 Dec 2023 22:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8BDC433CA;
	Thu,  7 Dec 2023 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701988505;
	bh=NT7BHAqFBOhaRtrY/szkX/r9R8b3Zw9S8V4qsNXM+rg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fM7G8omPRZ7ZWXJv3Rg5R2B74Wc7o7Kd0E7svQfW9jKfF2c9SyQMkDDpP2fwOg2PS
	 TKO6qZXBPmoGXWGrJAefouIWYDB8ffo870ddOmQLfgZp38GIQ2vwXuC+0oI7iBOh5A
	 Dmzh3SXRzNyYbWZvBRERx2CaEge5kWXD5un3ta2VoAnw3dOgT54u79sJmF7LZRjAi4
	 wAyE+jsMQiEYPkN4VoQz3jAoz/AqgbXL0XVNVTtIB0JtpatC8cCnYqQ03ZaxLmbyKD
	 a6Mknh/f6Fz9KzrfxlGNr9kf9sZWMTVB1KDV+sBR/xTblGk3eIJE8dITgwEoK8w1zX
	 AsY+ipMKgV9Qw==
From: Mark Brown <broonie@kernel.org>
To: tudor.ambarus@linaro.org, pratyush@kernel.org, 
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
 sbinding@opensource.cirrus.com, lee@kernel.org, james.schulman@cirrus.com, 
 david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz, 
 tiwai@suse.com, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 michael@walle.cc, linux-mtd@lists.infradead.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, michal.simek@amd.com, 
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, git@amd.com, 
 amitrkcian2002@gmail.com
In-Reply-To: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
Subject: Re: (subset) [PATCH v11 00/10] spi: Add support for
 stacked/parallel memories
Message-Id: <170198850030.340565.15742297562436442635.b4-ty@kernel.org>
Date: Thu, 07 Dec 2023 22:35:00 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Sat, 25 Nov 2023 14:51:27 +0530, Amit Kumar Mahapatra wrote:
> This patch series updated the spi-nor, spi core and the AMD-Xilinx GQSPI
> driver to add stacked and parallel memories support.
> 
> The first nine patches
> https://lore.kernel.org/all/20230119185342.2093323-1-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-2-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-3-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-4-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-5-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-6-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-7-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-8-amit.kumar-mahapatra@amd.com/
> https://lore.kernel.org/all/20230310173217.3429788-9-amit.kumar-mahapatra@amd.com/
> of the previous series got applied to
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> for-next But the rest of the patches in the series did not get applied as
> failure was reported for spi driver with GPIO CS, so send the remaining
> patches in the series after rebasing it on top of for-next branch and
> fixing the issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[02/10] ALSA: hda/cs35l56: Use set/get APIs to access spi->chip_select
        commit: f05e2f61fe88092e0d341ea27644a84e3386358d
[03/10] spi: Add multi-cs memories support in SPI core
        commit: 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9b

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


