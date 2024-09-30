Return-Path: <linux-spi+bounces-5067-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039F98B130
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 01:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508FB281FD9
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7BB185B54;
	Mon, 30 Sep 2024 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3+jqqhX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A44183CD6;
	Mon, 30 Sep 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740283; cv=none; b=iwwAmZ2v+KEy5B+qzZFHR/bAySFBZXPzox63VcZZb79MT3GHthQ7WDV9S6dVM37p1qPWorV47ZS4YGqJO5JOL0D/LUMvu4elPmCKGcb/3xDeclIVbW6NeIY97XjgqlcSf+mePx9H6VtyHKh3OnKg7IlgIVxxe1F+YryGG2liM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740283; c=relaxed/simple;
	bh=/z6/vTUxGv2idn0QRnGoZ90yGBpJH5IpaGe65gUH+pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iUzs7veUw5ljIxRJOYQXhLJilyEzccu1wPur9IS5+vkymeDwcr//ggF69a8natGtsOUohonW4kHpzXUUew1ZuAigM1doepvsOqOWEYGjIsjub+sZw8arK06KvM3bZgyRrlOdmN2a9MeUFkBWbSV0AfkRgP63iJtoP0QrbdeSkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3+jqqhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54603C4CEC7;
	Mon, 30 Sep 2024 23:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727740282;
	bh=/z6/vTUxGv2idn0QRnGoZ90yGBpJH5IpaGe65gUH+pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I3+jqqhXnUtqVoHJQG8oxvHcWujxHbufE823gWacYOv+i8y6ODk8Srarv/QBMqLtd
	 3F/d/lH5SPH+EqcI+bAKPBqk5ax1Z3tC+pqD+NEcgLr/Ni9p0MXxhPpipML0jnU5Qo
	 Xn/5fM7cYIrDKaPn2klpa6o9Fa1c8lgSl2YuxeviC4k1cYFpf10KwZTOldUKXuNA3E
	 gzhrgw30s8wTD3YYz2K+bVaIkskHbvosQRCYi/QqBFGC5C3z53cJRFGHcWFQNTmfEx
	 apWXRJC7dQwEsLjaeF90Qb/5aurvl0K99syGMOQDj6OTzsFrOi060bVmg6bAbY0sWS
	 QONJm0TqAs5vg==
From: Mark Brown <broonie@kernel.org>
To: mchehab@kernel.org, Jonathan.Cameron@huawei.com, rmfrfs@gmail.com, 
 vireshk@kernel.org, gregkh@linuxfoundation.org, deller@gmx.de, 
 corbet@lwn.net, yangyingliang@huawei.com, liwei391@huawei.com, 
 Yang Yingliang <yangyingliang@huaweicloud.com>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
References: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
Subject: Re: [PATCH -next 0/7] spi: replace and remove
 {devm_}spi_alloc_master/slave()
Message-Id: <172774028009.2264837.5647279590529762644.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 00:51:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 02 Sep 2024 20:59:40 +0800, Yang Yingliang wrote:
> Switch to use {devm_}spi_alloc_host/target() in drivers and remove
> {devm_}spi_alloc_master/slave() in spi driver.
> 
> Yang Yingliang (7):
>   media: usb/msi2500: switch to use spi_alloc_host()
>   media: netup_unidvb: switch to use devm_spi_alloc_host()
>   spi: ch341: switch to use devm_spi_alloc_host()
>   spi: slave-mt27xx: switch to use spi_alloc_target()
>   video: fbdev: mmp: switch to use spi_alloc_host()
>   staging: greybus: spi: switch to use spi_alloc_host()
>   spi: remove {devm_}spi_alloc_master/slave()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] media: usb/msi2500: switch to use spi_alloc_host()
      commit: 5ba92299badc4e71670269877262c8cc3b6c806f
[2/7] media: netup_unidvb: switch to use devm_spi_alloc_host()
      commit: ac2f5bbe80e143509cf24527a7ae021f356f8977
[3/7] spi: ch341: switch to use devm_spi_alloc_host()
      commit: 0191e98ae6e22bebae4e9a487ba70f90d2f8714c
[4/7] spi: slave-mt27xx: switch to use spi_alloc_target()
      commit: 4bca15a56edd7b1c8c8573ddd3dd67424ec15e11
[5/7] video: fbdev: mmp: switch to use spi_alloc_host()
      commit: 5c303090e1d8426c721709d50f0120f66bae6919
[6/7] staging: greybus: spi: switch to use spi_alloc_host()
      (no commit info)
[7/7] spi: remove {devm_}spi_alloc_master/slave()
      commit: 0809a9ccac4a2ffdfd1561bb551aec6099775545

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


