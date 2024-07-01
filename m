Return-Path: <linux-spi+bounces-3708-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738191E1DF
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F941C22797
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B87160780;
	Mon,  1 Jul 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9GtIxJU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315415FA9F;
	Mon,  1 Jul 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842900; cv=none; b=GeWphScvmT/9Ua0tBbDjOlW5qjtVXTOdGiI9l0Cler2U4eeSv+3Ck8vV1VVZQOd7HH5r/HkSuJZpaEgBdrXBVCFSuYfhEbQJbl2p0+8Bp4xuBydG+2wD+5Gxf7FjPvDBbEq5IfBShH9CtcAc4s6CXpBDuZIz+L4Lomo9VsAqgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842900; c=relaxed/simple;
	bh=hAgsoXFVSlS+nlM1Rt5xrsMbfo0jlqSO2F7H8f2t/nU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rk3O4QhbZVMLL2gd6jMr3qPxLCR8MxqvpRr7cUEZxxCYdAlSWguHoY3cIFxUEjdl0KGU4JnbQNHwV9CKuI5oDrDRPX+wkOz+4/xykqJu/2dA15HxMv5P3Mnb6dY4aIv8DY0cCgHUHxn2lnQ1aztZT/dBMi022iuD8u248MTb0qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9GtIxJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B0FC116B1;
	Mon,  1 Jul 2024 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842900;
	bh=hAgsoXFVSlS+nlM1Rt5xrsMbfo0jlqSO2F7H8f2t/nU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n9GtIxJUxMSNmZG0rlsZK0wga10th5fuAzDCzCzJ+KKRf6QrCkiQ+PK7qycd4L1Ej
	 SNExirqpK1K54LqcOT1Zedq4WRDEENIMxpn2Cf8DfLRno6pGgDBNb1v54Ii/F/UBdR
	 JqaUqoGqlernyGJBazPQMzcwkgO6nc1QPZrkdWzyBfN7rtOnvBS2lUWi5jDLIZ9+h6
	 R+3Cz5uMq/VvFuN79okPB+w7VC65REpmqTnsCaWHZ6S52KM3/3mFeO82Rqi18zZgu7
	 DvUhEYsCLOI/2yLaMgW8LFdy1WuXZYjiot8NqUA+EUxSfOupG967Mot5k+I6uJwRbr
	 ycgqoKupuaAoA==
From: Mark Brown <broonie@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Christopher Cordahi <christophercordahi@nanometrics.ca>
In-Reply-To: <20240624071745.17409-1-bastien.curutchet@bootlin.com>
References: <20240624071745.17409-1-bastien.curutchet@bootlin.com>
Subject: Re: [PATCH] spi: davinci: Unset POWERDOWN bit when releasing
 resources
Message-Id: <171984289881.58427.5813212295235369528.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 15:08:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 24 Jun 2024 09:17:45 +0200, Bastien Curutchet wrote:
> On the OMAPL138, the SPI reference clock is provided by the Power and
> Sleep Controller (PSC). The PSC's datasheet says that 'some peripherals
> have special programming requirements and additional recommended steps
> you must take before you can invoke the PSC module state transition'. I
> didn't find more details in documentation but it appears that PSC needs
> the SPI to clear the POWERDOWN bit before disabling the clock. Indeed,
> when this bit is set, the PSC gets stuck in transitions from enable to
> disable state.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: davinci: Unset POWERDOWN bit when releasing resources
      commit: 1762dc01fc78ef5f19693e9317eae7491c6c7e1b

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


