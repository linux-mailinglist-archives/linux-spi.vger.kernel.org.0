Return-Path: <linux-spi+bounces-7536-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1CEA850C9
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 02:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A7719E8A46
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 00:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F526F462;
	Fri, 11 Apr 2025 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tp+lf7ne"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54F215162;
	Fri, 11 Apr 2025 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332880; cv=none; b=N1fuFvy5/YDHsq/wEQ59/1a1eZ9D+z7YpiXalSnilIbjwoge84KySaZRI5qVdkskj2F/urawuIyk2Ea8pcu1SnCrLFk+J8rwdly06U956nqgY+Fb2hFXDZ9mYthJCwnm2ENoxvZGfAtV/OV5vv66JtP3TsdEiW83+MSEYcaqyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332880; c=relaxed/simple;
	bh=N61v1cA39Er8rTmMuIlNgGc/DeyX2umbC+GBxBdzvls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NTSBn7aRC+7ITGzjZsUs6FmIISfM6AeoM37/Nac52zr5ff60m96CMsNHY1x5s8Fb0EcABRcttFNfX138iNsGlE3C+WgtNy/WFS2h+yKiXjGTWMMFd/TznosgsuTOhZjAecZduTLAkB8xmTNTLygLxBOgNBbU1Mr2pKVpWN81lRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tp+lf7ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A11C4CEDD;
	Fri, 11 Apr 2025 00:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744332880;
	bh=N61v1cA39Er8rTmMuIlNgGc/DeyX2umbC+GBxBdzvls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tp+lf7neuDbgNzVTUo4LirSW1RWVeZ+lqpExKMSUgLyfBOosEDq4oObE7Zc+H8d6Y
	 u2ml5NAroU+TkEkVNh/iTBcXjOGcoh0QKjKdm0L3T11+KfHEuHseVNzaggr6oAnObD
	 v/aaEb8xEDipun1GQqVcp9bSQQGRUhMoXq/CCoFAsB2xar3gH4kL8S44wPH6yOYksB
	 lAIzG5Cgfy3fjrKz4uytC4njmKMHx3D9y6PixFvEFDdhYc0ZD4+1zDBH74wgVmS7GP
	 jdOrz3vOZOpJmkYKkS0+HHfUt7kizadRCjX+lI7mx8z6jcC+Ob6KtsQrR9GrQujYg4
	 zHA20T5kAu5+g==
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Akshata MukundShetty <akshata.mukundshetty@amd.com>, 
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Nuno Sa <nuno.sa@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250410140809.812863-1-arnd@kernel.org>
References: <20250410140809.812863-1-arnd@kernel.org>
Subject: Re: [PATCH] spi: amd: add CONFIG_PCI dependency
Message-Id: <174433287766.1192997.16298015747413468540.b4-ty@kernel.org>
Date: Fri, 11 Apr 2025 01:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 10 Apr 2025 16:07:49 +0200, Arnd Bergmann wrote:
> Without CONFIG_PCI, the module_pci_driver() macro is not defined:
> 
> drivers/spi/spi-amd-pci.c:67:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
>    67 | module_pci_driver(amd_spi_pci_driver);
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amd: add CONFIG_PCI dependency
      commit: 7a978d8fcf57b283cb8c88dd4c9431502bd36ea8

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


