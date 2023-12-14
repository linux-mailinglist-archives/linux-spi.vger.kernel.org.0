Return-Path: <linux-spi+bounces-278-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A028131BD
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 14:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37BB1C21A75
	for <lists+linux-spi@lfdr.de>; Thu, 14 Dec 2023 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258AE56B6B;
	Thu, 14 Dec 2023 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjxROe/s"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C256B63;
	Thu, 14 Dec 2023 13:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3450AC433C7;
	Thu, 14 Dec 2023 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702561053;
	bh=eymAWZlO9JPHMLfxP6Diuxd61Do848nh1zutAJya4/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TjxROe/siCd9MJtwUu0sYWjyW+7XSYlZtnXyyRYhToZIIabcQPILgQsFmMVQoQOHr
	 OfpYkdLEFUtuVbzrswYTwR/f8H1+Gez2LnCeC7z0xKMDaJp/dwummdlDqd27F2YSAv
	 XQPiY1dNJgAkWBD0JbMxLGnix5hv1yEddt2+KTCK5PU4wywvuh1JqK6Df/bm/Fdf0e
	 5oLjoq448SOcdL6CrAFK4rshOeSzU6hlIttiPbREX8V/tsr5aSm+gJH4G/3PUGogyK
	 votvonORf2pOogZeDDT+UzF1XFvLs/zKknYZffcbkVEerjzkhTUEZctt1iuhkb649H
	 ssw4DJkxGoUVg==
From: Mark Brown <broonie@kernel.org>
To: ryan.wanner@microchip.com, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: thomas.petazzoni@bootlin.com, nicolas.ferre@microchip.com, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
 haavard.skinnemoen@atmel.com, akpm@linux-foundation.org, 
 dbrownell@users.sourceforge.net, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
In-Reply-To: <20231204154903.11607-1-louis.chauvet@bootlin.com>
References: <20231204154903.11607-1-louis.chauvet@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Fix clock issue when using devices with
 different polarities
Message-Id: <170256105093.58838.9858114740206767634.b4-ty@kernel.org>
Date: Thu, 14 Dec 2023 13:37:30 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 04 Dec 2023 16:49:03 +0100, Louis Chauvet wrote:
> The current Atmel SPI controller driver (v2) behaves incorrectly when
> using two SPI devices with different clock polarities and GPIO CS.
> 
> When switching from one device to another, the controller driver first
> enables the CS and then applies whatever configuration suits the targeted
> device (typically, the polarities). The side effect of such order is the
> apparition of a spurious clock edge after enabling the CS when the clock
> polarity needs to be inverted wrt. the previous configuration of the
> controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Fix clock issue when using devices with different polarities
      commit: fc70d643a2f6678cbe0f5c86433c1aeb4d613fcc

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


