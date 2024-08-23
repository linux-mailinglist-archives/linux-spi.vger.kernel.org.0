Return-Path: <linux-spi+bounces-4291-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEB95D968
	for <lists+linux-spi@lfdr.de>; Sat, 24 Aug 2024 00:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC631C22287
	for <lists+linux-spi@lfdr.de>; Fri, 23 Aug 2024 22:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689801C9DF7;
	Fri, 23 Aug 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saywYe/L"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432271C945D;
	Fri, 23 Aug 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453839; cv=none; b=og5LO9phATcVTVR0cNOZIFHrDaslgTvqZJSpDnmCu7s2lrfvMEIaMHjP4K5LSnqAqBhfkxaL3MMyiJFh299uagNKkzmSlYoL8dzMMbZolw4x2q94vamWgEXpSH7+D4/VfnjzRbiqt1RRBR1t+GOWwbm65D8wroK6TZ4OSmJ2yX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453839; c=relaxed/simple;
	bh=xhFVOqIW65sp/skeKJ1o0QIrrGJq6aArIu6jiWEAppU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f1PnqioUnvkuGc2z29CKBZAIjjUrx1hfJom8e//NEC77Kx8miIuAnAALJ2U3o6KNDuRNPOATE4ZNvOXzUpA/tBim8U7MF5UZEdpHFyG0eEBkA6/Cl77/kYwHfgc93psf+GhgymvazSeyEwliC1yDC6HwzieqZh7iVzgrImTGUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saywYe/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B5EC4AF11;
	Fri, 23 Aug 2024 22:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724453839;
	bh=xhFVOqIW65sp/skeKJ1o0QIrrGJq6aArIu6jiWEAppU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=saywYe/Lh+RYKUTAJr3DphbvrpvJDgDyBU3oDIEkXrQSw36UPfBc6hqfl095KJTf1
	 jzELfYYjlyvs4khyaF8nui7h4QOv97axTYHtk/bVH9KZ94mQPEls6DEds2qtnYYfSG
	 vfFfxEy2snf+b8wTMuohqmhB1y8EaQtcwFJTD7IXIvzVZvCLLXN1gEiYxn2sLopgTM
	 M50vcad1NF2rmUvHnMkOGzYpZU79w//jMqssBUDvn1AUk+mmSAbxZF2rrzpkzJ6e9d
	 QqOy5p0gdgpdKBG++ZmBGRUhctOAZ/4tZ1TXWnNSaM9qWQZe58ukhKNuQRxZxmY7AH
	 q52yVyJfIo0Xw==
From: Mark Brown <broonie@kernel.org>
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240820123818.1788432-1-ruanjinjie@huawei.com>
References: <20240820123818.1788432-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] spi: atmel-quadspi: Simpify resource lookup
Message-Id: <172445383695.842317.5045580668999638806.b4-ty@kernel.org>
Date: Fri, 23 Aug 2024 23:57:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 20 Aug 2024 20:38:18 +0800, Jinjie Ruan wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Simpify resource lookup
      commit: 3ccea1dedef39b8fc1adb13dd38c6e0b69e728af

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


