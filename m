Return-Path: <linux-spi+bounces-3314-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FBC8FD949
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D041F25037
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE515FD1E;
	Wed,  5 Jun 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbRgPVz3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B515FD1D;
	Wed,  5 Jun 2024 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623528; cv=none; b=VkQG58//fkSH69PBjlBFdC+Qoq8cjVt3J7v/fSRQwaNZpw1LF4i7764fj9yCaAdbzD9lxFFlgd3EbJ4Z69Z8P2KGyTUkr2LavdPDOGjNSN/C8cbVbUaBI4Jk/BCS32jPdCxL9MQT5MNMOwIdBWrDo6x+nSaiiszsCtjL27KvMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623528; c=relaxed/simple;
	bh=CNxFneNBPrNP1nET8F9qHyjS2o3ddD0DMIOXFNfAuH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rGQ/uoYIo1kXdHgCAAMauOOLV4Oz0EDuOJz5Bh4IqisrMMdw/q7AX1pZGcV5RJOIVxcmDLQsK+IQu2KNrrSpt76oiPFV3SkUrrqzx5hGv3EgbOFsTPBivVDcobaDSi7PrP/ycYIAUDEvvvk6AwiefW1L19N5KIyU335b1ozIcJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbRgPVz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB2BC2BD11;
	Wed,  5 Jun 2024 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623527;
	bh=CNxFneNBPrNP1nET8F9qHyjS2o3ddD0DMIOXFNfAuH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gbRgPVz31SEFeEME1bDGWX7frKr1qO7XvXkbR2vJvHLWil/+UZ3EdftrhuTyDKAS2
	 AT4UDtcVsARkaROa+FdTkRCmGplASgbdInf4Cpyn1k+7tCDd+MZ9BROIo21qUad2xy
	 tQHUKKGWPQgutKXnUZnUdOJzq+l5i6b3GTiplRJhOBedjtzT3Y05eYnU+x0ZuHtvfZ
	 99Qq42yhRiOk6eAfXeD2Pa/LV/Nt7NbCjwt3Im9y0RJmxU2OVVMdvVuCIL7zTO9npC
	 iBuZd0TJht1RWM8kjTqgdNzE3o2YXW+oFa/fM7jTgWuK5Q1qWHvHjfeptkIpurAi+X
	 yLqntnFFJz/Yg==
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
References: <20240530151117.1130792-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 00/11] spi: pxa2xx: Get rid of an additional layer
 in PCI driver
Message-Id: <171762352584.566005.7179285192492328101.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 30 May 2024 18:09:56 +0300, Andy Shevchenko wrote:
> SPI PXA2xx main driver is a compound of a core library and
> a platform driver code. Decoupling that allows to eventually
> get rid of an additional layer of devices hierarchy in PCI driver.
> There are also precursor cleanups.
> 
> In v2:
> - made better handling of pxa_ssp_free() calls
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/11] spi: pxa2xx: Wrap pxa_ssp_request() to be device managed resource
        commit: a2fca8f2e242b3cdfed2a15084e733348ef68509
[02/11] spi: pxa2xx: Reorganize the SSP type retrieval
        commit: 8aa5062e26054b8c081d5bba930baac4faadd1b0
[03/11] spi: pxa2xx: Remove no more needed driver data
        commit: 7b0f2c1050643c4793e6eae0246a8de3b22c950a
[04/11] spi: pxa2xx: Remove hard coded number of chip select pins
        commit: c1b93986dfb2a31b0528fe929d574843801089f5
[05/11] spi: pxa2xx: Utilise temporary variable for struct device
        commit: c65174fdb2f7fe83ee515966c08de9a990e722f9
[06/11] spi: pxa2xx: Print DMA burst size only when DMA is enabled
        commit: 9b328f5f5c921ec83e1765075b82e6cc05e576b9
[07/11] spi: pxa2xx: Remove duplicate check
        commit: 560fb06df2fd250004a1cac079717dbe7f863ff2
[08/11] spi: pxa2xx: Remove superflous check for Intel Atom SoCs
        commit: 75bfdccaecf96189318b29100b880c416d89ed46
[09/11] spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks
        commit: 20ade9b9771c80eb58eb42ccd0a48ba24bdc3c4f
[10/11] spi: pxa2xx: Move platform driver to a separate file
        commit: 3d8f037fbcab53e03ab2ef18a66f202be3653d50
[11/11] spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly
        commit: cc160697a576150975280a4b5394fe9c70700503

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


