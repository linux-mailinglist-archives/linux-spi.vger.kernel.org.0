Return-Path: <linux-spi+bounces-5063-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9D98AF54
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736DCB22A9A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF9188911;
	Mon, 30 Sep 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFAcjuCo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AF188906
	for <linux-spi@vger.kernel.org>; Mon, 30 Sep 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732528; cv=none; b=l/MGNau7WMCwiKuloEoI9Faeuwu0NLbzvtKQzun/IsImXn3llS7Ua3pXeQFehL1qF6Pg+xnwXFiN0G0Ws1AEWh1oIJgQInjCD6xry5i4R+K6ODzLp02yYit3Sna1VKbxJSPPn+jMdJ0RB63nqSUEXXiuEhtG74lXFAK7O9H38SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732528; c=relaxed/simple;
	bh=zXtYpftF7+iAet5/mQ/2sstc4mZB6IdM6vS/4wHVTrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cav9dIs7tPNJe7ovPExTHKhoNLzORQt0U/ogNt0w78E0CZHYZhJLY4LP4usxG6u+4nmsTxkBPnHOKPjl9xoaed/JqZ5i8kChDXJ5PaVCGQFpogc8VThxfU52LrBSOJ7klGWtNWqDE6H2ATLhXmTftWnzoEILg49Enep2JXYhoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFAcjuCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE31C4CECD;
	Mon, 30 Sep 2024 21:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732528;
	bh=zXtYpftF7+iAet5/mQ/2sstc4mZB6IdM6vS/4wHVTrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DFAcjuCoJSbpfJOfP9FJBn1OvYpsWwz0xaQaQeXfOLaubefXg3XsPSF+9t6wXOYXr
	 ioO907K/ZF+/CRLlERhA0HDtSCPpm7VQ+Wy+xfKJ6+vfcIJUfcirPogb+B4ULNa6fc
	 k7Wj/5iO6BkmMndKibmQrZVHwl4PzmdW7BDlDAKH/p8F1J+zU4lamB78mB2iN7rsz8
	 cspVzzruJNFWUPyG5WD9DwqVUNnmQ1XxrAvSnDcNyByt0cMah1dM2K2SARrz2Tlwvx
	 rzol8LxF/YHRPIp/bDWihMshtGp0vqWo5zoKEunHlH4XFJjX/c4BbCmFFOtjUE2FbS
	 wXcKPtiMTPG9g==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20240925113501.25208-2-u.kleine-koenig@baylibre.com>
References: <20240925113501.25208-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] usb: Switch back to struct platform_driver::remove()
Message-Id: <172773252710.2210210.16049963643059937141.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:42:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 25 Sep 2024 13:35:00 +0200, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/spi to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] usb: Switch back to struct platform_driver::remove()
      commit: 494c3dc467768782f93f1433650c56b08feb54ea

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


