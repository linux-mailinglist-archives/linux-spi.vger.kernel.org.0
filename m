Return-Path: <linux-spi+bounces-4233-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036579573D6
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A8D2854A3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6A3189916;
	Mon, 19 Aug 2024 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXWainZe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382E189912;
	Mon, 19 Aug 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093134; cv=none; b=bGJyWL3C3cZuKoToDNkVLTJEg4I3uqdw3aB6Ad9QA6BN3RKgOurZmkzHDfZKZTjXl7mKSYsGpofb4qQyklggvjztzAwmmvXVKcf3GccjtuoiQkmvmcl4NKK9IOX8/HzcgAEJlIGMXmf9V/hgbb7iUN6cWkUwMJt++jo5gZcf904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093134; c=relaxed/simple;
	bh=Dju1hU3meUf3SHdPc2mDiQDH/DpCksv492g60xyqXm4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k0qCBPySgmM2e/YEFwtjPiY+LE4tTHWR/PoiTje8xI1oaHZy24rOpw0EA2xUOGp1Vg5vM7kLsnqQB7Ra6/rx7JK1ViSWfQaLoX646i8jgmJcr6tq2veGDtF+97xwHwNWiZlNmq7lsCtRdwRHl96ueRXJrC7OvYnxOVzQLyNsvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXWainZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA9BC32782;
	Mon, 19 Aug 2024 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724093133;
	bh=Dju1hU3meUf3SHdPc2mDiQDH/DpCksv492g60xyqXm4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=rXWainZe4EwlHcgT0yCozZe/1/lh7d5uzfbRjqfMYMx9tSAJnylYfxmUnNRiLiPHx
	 FKZdTNBpEFZD6SIg66mgUPAplLE9bkFXtPWeGL9i2UCWVBgSCf1Nuyvd1Wg7TKf3DR
	 he5UDG8mQaGQBwiABVPGKfjwJZpJvrwcUXvhdBTmDVafEt/p94iHUpsCot9aH2KZgI
	 NFU3gIUPlR3D2WONk3CLdNAVDw0VqP/jDc07+h9bohjkuVTCczvEwho6jClruo+pme
	 k2lD3xqzAPezV5i9L0vDviLvulaImCR5WgZY4WGJ/DZJSsVDi6c9aFfc7YlGwfy/S7
	 gOI89RH065peQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240819120031.3884913-1-ruanjinjie@huawei.com>
References: <20240819120031.3884913-1-ruanjinjie@huawei.com>
Subject: Re: (subset) [PATCH -next 5/8] spi: cadence: Make
 cdns_mrvl_xspi_clk_div_list static
Message-Id: <172409313277.107460.12813863900843438878.b4-ty@kernel.org>
Date: Mon, 19 Aug 2024 19:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 19 Aug 2024 20:00:31 +0800, Jinjie Ruan wrote:
> The sparse tool complains as follows:
> 
> drivers/spi/spi-cadence-xspi.c:334:11: warning:
> 	symbol 'cdns_mrvl_xspi_clk_div_list' was not declared. Should it be static?
> 
> This symbol is not used outside spi-cadence-xspi.c, so marks it static.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[5/8] spi: cadence: Make cdns_mrvl_xspi_clk_div_list static
      commit: 802df33076cabfcb32b2c5b066c3af07f68e40fa

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


