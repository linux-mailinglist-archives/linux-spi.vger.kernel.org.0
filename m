Return-Path: <linux-spi+bounces-8456-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44766AD5ADE
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834043A61FD
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ACD1D79A5;
	Wed, 11 Jun 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enV/F8tX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745513CA97;
	Wed, 11 Jun 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656617; cv=none; b=j1t1x83tUXRyeRnB/znTFrM8juVDYhr/rtyedfK8lHHwN3x4oRe5Q55NEHTrDyJkX7kk0f9ggL+VckBaewh9RhcPvBjQVf+qrIQmQPpqvcCszW7MDSrt0806OFSmoj9e3kOcIF18HdbtahnKt4PEhunS6jjfzcSK71WEXBuT+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656617; c=relaxed/simple;
	bh=sgp9slAuf4XRQ8V2KqZqIsqojt3ZXLZ/Kwvr+u2zlHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k/FjFzUVNRgm/PHv4hoNdfsBtSqYIvUGArQeAMHSRC0cOdlDzWJCjbRIahwPwldrC9OF1pwcOO6Eob0tF60muMhU82TYqOgCOkzkVTll3IIoJKiHan+CvwYbKNkV06onyWgSi2jrD1jb8N3xpNl7czTuPqS2Xz2+Rmsbua9vLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enV/F8tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFA9C4CEE3;
	Wed, 11 Jun 2025 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656616;
	bh=sgp9slAuf4XRQ8V2KqZqIsqojt3ZXLZ/Kwvr+u2zlHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=enV/F8tXSRwKxJ7diJ2TyFIS6lH9xYlMrJGIjhbEmUdOq10ypB+7OzqrINdteaO6Y
	 mwLJnXN0wXqZ8GivHnGVAjTk8yyowSGm/I8TboRcTptfXygFhprCpHz3h9i7RZWnyu
	 fAMz1/2xbdPUBg8Mo3Cgc1uAg1gNGQ/wix4+gWvzBDckqwBlAveO3TgzIYaplJRwyg
	 z1fX4tFz3xfF05JiJYiqH+7xokt12hGoT/54qsbY0boKSjxDVhgoXBsubr9aIOnAbo
	 w8JVJkmhfbkvt0bzBncwaHsab/ock9eMO3UPgagPfkt2A+uWNi7A/KZP0gGLWHzM19
	 DAIrDi8sduHrw==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, leilk.liu@mediatek.com, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com
In-Reply-To: <20250611110747.458090-1-angelogioacchino.delregno@collabora.com>
References: <20250611110747.458090-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: mediatek,spi-mt65xx: Add support
 for MT6991/MT8196 SPI
Message-Id: <174965661418.52462.1962051636237778809.b4-ty@kernel.org>
Date: Wed, 11 Jun 2025 16:43:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 11 Jun 2025 13:07:46 +0200, AngeloGioacchino Del Regno wrote:
> Add support for the SPI IPM controller found on MediaTek's MT6991
> (Dimensity) and MT8196 (Kompanio) SoCs, with both having the same
> controller IP, hence being fully compatible with each other.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: mediatek,spi-mt65xx: Add support for MT6991/MT8196 SPI
      commit: 414145b4cf6c64831aa497f0ec6cc1ca2d76c1d2
[2/2] spi: spi-mt65xx: Add support for MT6991 Dimensity 9400 SPI IPM
      commit: 6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3

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


