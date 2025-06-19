Return-Path: <linux-spi+bounces-8677-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C563AE0C43
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 20:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E334A4DCD
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE02E28D8F7;
	Thu, 19 Jun 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5I0A1/a"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B124290B;
	Thu, 19 Jun 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356049; cv=none; b=vGFWM/dqI5uQkPPLsmmsfDCajWsSnb2oSim5ae9dp4qSegCuc+C9AeUFDHF45dkZv+r/LPBLlkHdrmr729XaPNGXmel+phnLD+gU4gHPU/zD2kGngeHatVnJBBhzXHgtijLsqAq+CK/IKVdUuRPWgL02bAkswAxR6l+r+1H3iHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356049; c=relaxed/simple;
	bh=Srwp2iLw4QM9QiJcm+XyF2ewuN6J1w1QzFgVha1WoaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ton16bxfSIkeaJreQjiCddTOQbsdVEmBcQDZpdknVE/mpp7P1V0XlZJ7nGZ3P1xcZCYF6D1W/iv1im2vk5936P/6HbIMx2sccdsPwhKamqqk+qpHLX6Zq1MWjUyRJjWrh5vVU/SHusb59rTsZqLogl5pscl/MwNyrml4g+Rz07g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5I0A1/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0524C4CEF0;
	Thu, 19 Jun 2025 18:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750356049;
	bh=Srwp2iLw4QM9QiJcm+XyF2ewuN6J1w1QzFgVha1WoaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M5I0A1/aUJtATUyvDp6wFYVlrNghgCcIX6X08SPbxlg9C4rwi77I7Erp39cEWFBXT
	 48k2Cz1swL6iCoQo0bL2Rpmdq0NX8w7oPTucWpbVo5doSwdvR5zzyOhqj50L9ssIbV
	 3XtLd0wlYHITA7lj/M7QPYAsGGDftAzdhUTak6Rwqv5pejFVrT9SOlOduvFCNqkBB2
	 dQXwcAJ2BdX4hXm5wN9iSN3KmfSkmvXd5iz35qs2LV1/gomSeRmbnLibBP6gWBw6cg
	 fbjEU/dT6aKDAy24cnOTDiNv/UNJ59IGgY3g81+yAcjjIVG1ic9pDeJQ6WDqHbNpAO
	 eyI+G3yf++aCg==
From: Mark Brown <broonie@kernel.org>
To: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-spi@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 John Crispin <john@phrozen.org>, Linus Walleij <linus.walleij@linaro.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Subject: Re: (subset) [PATCH 00/16] MIPS: some compilation fixes for the
 Lantiq platform
Message-Id: <175035604752.283409.17816680036110051430.b4-ty@kernel.org>
Date: Thu, 19 Jun 2025 19:00:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49

On Wed, 18 Jun 2025 22:53:13 +0800, Shiji Yang wrote:
> This patch series fixes some MIPS Lantiq platform compilation issues
> found on the 6.12 kernel[1].
> 
> [1] https://github.com/openwrt/openwrt/pull/18751
> 
> Shiji Yang (16):
>   MIPS: lantiq: xway: mark ltq_ar9_sys_hz() as static
>   MIPS: lantiq: xway: mark dma_init() as static
>   MIPS: lantiq: xway: mark dcdc_init() as static
>   MIPS: lantiq: irq: fix misc missing-prototypes warnings
>   MIPS: lantiq: xway: add prototype for ltq_get_cp1_base()
>   MIPS: pci: lantiq: marks pcibios_init() as static
>   MIPS: lantiq: falcon: fix misc missing-prototypes warnings
>   MIPS: lantiq: falcon: sysctrl: remove unused falcon_trigger_hrst()
>   MIPS: lantiq: falcon: sysctrl: add missing header prom.h
>   MIPS: lantiq: falcon: sysctrl: fix request memory check logic
>   MIPS: lantiq: xway: gptu: mark gptu_init() as static
>   MIPS: vpe-mt: mark vpe_free() and vpe_stop() as static
>   MIPS: vpe-mt: drop unused functions vpe_alloc() and vpe_start()
>   pinctrl: xway: mark xway_pinconf_group_set() as static
>   pinctrl: falcon: mark pinctrl_falcon_init() as static
>   spi: falcon: mark falcon_sflash_xfer() as static
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[16/16] spi: falcon: mark falcon_sflash_xfer() as static
        commit: 5fc2c383125c2b4b6037e02ad8796b776b25e6d0

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


