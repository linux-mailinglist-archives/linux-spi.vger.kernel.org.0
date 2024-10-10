Return-Path: <linux-spi+bounces-5190-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED27B99849C
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 13:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294201C20C15
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48C1C244A;
	Thu, 10 Oct 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgbwZCW0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1D1C2445;
	Thu, 10 Oct 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558868; cv=none; b=OR07Ku2yLFtLxfVcWDyTQ5pjutdmXE2y4R5r0jTqwI4FYq+PMaaUvl8S/zzzVqb96qx+YTit5Tu37ZPR5RIe+C78Ke1pEnyxIY4DcnCSLgYAMSjAaFsTsSm+hEYRUuJ7euNYLEKapoNnl85Vs8g+N0/YU/y4PicWkymHpFIwiD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558868; c=relaxed/simple;
	bh=IMikOpVZDTkWvRqqmyYXabw2eSCTdsTsi9nsFpVjkws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SJ3Q3vhv1qlXKQ12rtVicO7u4NKWPCMdnQil7Ms3H3rIgvl7G3V5xw2xqov4aaMK5lfykfwySFdcNY9goD1ktvhdtG2ilTUXvTe89d9lBw7QpiUWd/8eDBIGpFiDu6vUHU49lfHzOe1OOokhQhSzqy/LPIAZv6BM0HY80bpdENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgbwZCW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7431C4CEC5;
	Thu, 10 Oct 2024 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728558867;
	bh=IMikOpVZDTkWvRqqmyYXabw2eSCTdsTsi9nsFpVjkws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JgbwZCW0Zh4VPbUeSqNg0rzD27utgz2Vml79tHAQvawnY/WmF2bFRAV740Tc96/Mm
	 M7Uuw2AqqSf8eEyoP86Vooqg3lSndGFmhy24xE0iVg8N0P7E6AlZnF34XuUHJmZ1s/
	 DLuxy8ZANEWQneFoTgLGZ05uWM7vt6teN3x8yqlvWlJU0DGew5goZnAkT639X+GcPE
	 W7IY1gW7HUMCiKwcjlufGs5lJdPLmKLDEy+tYEtIvPPzSjk2S7IRzsUlayPSjebSW/
	 83+jtjQUAwOZOiEcrv2ZUlQ0+5hIsd29GrBwtF5MhNx//dFpihYAZ4ZMzIbOHgrpYz
	 Db5mKb21c2B6Q==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Dragan Simic <dsimic@manjaro.org>
Cc: heiko@sntech.de, gregkh@linuxfoundation.org, rafael@kernel.org, 
 oss@helene.moe, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1727601608.git.dsimic@manjaro.org>
References: <cover.1727601608.git.dsimic@manjaro.org>
Subject: Re: [PATCH v3 0/5] Add dev_warn_probe() and improve error handling
 in Rockchip SPI drivers
Message-Id: <172855886556.3260167.12395956115467736144.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 12:14:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sun, 29 Sep 2024 11:21:12 +0200, Dragan Simic wrote:
> This is a small series that introduces dev_warn_probe() function, which
> produces warnings on failed resource acquisitions, and improves error
> handling in the probe paths of Rockchip SPI drivers, by using functions
> dev_err_probe() and dev_warn_probe() properly in multiple places.
> 
> This series also performs a bunch of small, rather trivial code cleanups,
> to make the code neater and a bit easier to read.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: rockchip: Perform trivial code cleanups
      commit: f7bc15211fc6946203dd7e57c123f1e387d7225b
[2/5] spi: rockchip-sfc: Perform trivial code cleanups
      commit: cb91287b3b6d42e66f948fbc304f771792c2852f
[3/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
      commit: 7d46b8d8d78338a2ad986eec0790ddb22fad23a8
[4/5] driver core: Add device probe log helper dev_warn_probe()
      commit: 36e69b160705b65bf136c2fb6a1194447eeb8478
[5/5] spi: rockchip: Use dev_{err,warn}_probe() in the probe path
      commit: e2fc05873905f2ee96b38a116ae86f45fe7d8e49

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


