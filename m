Return-Path: <linux-spi+bounces-9314-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77128B1DD5A
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 21:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A2518C74F2
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 19:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1153925DB1C;
	Thu,  7 Aug 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoSn5UIl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA87256C6F;
	Thu,  7 Aug 2025 19:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593748; cv=none; b=Z2317sS8LBoErMU5g++LJ0P4k46t/M5ZeKoBrVWZ5Ub4QytMUIUZK8hSeQY0vaItbRmwv4Qm5LT6Z/BVCVKDvB5CH96zu1e1Li3plGGdZk4fr58LoH/2R+TJwE3ycYUkqvX4VfD9ACksQXSgr2wE0zwpYhYSqV5kEGClrvC7yTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593748; c=relaxed/simple;
	bh=8imx6wVOsRR9QqBAU1K+vLxoVDn3qj25QOkvyaNjn5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uoE4TlQJmxtQ0isxUrXthkcisXQk0x/Qj07snjCzoGMwXOggnNwT/z9CJA/xECvJzdY2gZYPmxFDWDsN1hkx0vrhMoLohEl0S3aiWn4+Ky/ghW88+6XN7Fy5ml3mlFSKHX5YGxA3RX5P8wUynXgt3tdwunLhZcpfIEjNXYbRzss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoSn5UIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB43C4CEEB;
	Thu,  7 Aug 2025 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754593747;
	bh=8imx6wVOsRR9QqBAU1K+vLxoVDn3qj25QOkvyaNjn5I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EoSn5UIlQzkuzMZqejHE9gOuwmJr2Jxxh8vAC+6a/2i7W6ghc7W77pdcMSeNBKUMl
	 v6gMqcQ2FPhH+3f74lXawftn2X993N1x7aRqBUZ8YTxTPeNh8wnSvMzB5rpZyB/yn2
	 2N59rOYEiwD9F64jPIf1Y2SU1vqSCuhFDeXeboOkN0QeU67VLTAZCN9CR0ztxORWrl
	 R98CmwqkxteU8pWM0gbbpHiJRiDEPjZ0rdIMSgn2K1DQ+VDPoYsdItXzdUXnKcJ3L5
	 L6Z0rDUUvC5pQnUWfr8uYZMeAhp2/qqeQRZZh/hLkfq8O3SUgOzK9s57Nh/uTz6p5w
	 +S79G9CN5+AcA==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20250807100742.9917-1-wahrenst@gmx.net>
References: <20250807100742.9917-1-wahrenst@gmx.net>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Clamp too high speed_hz
Message-Id: <175459374603.106952.5886117499907652645.b4-ty@kernel.org>
Date: Thu, 07 Aug 2025 20:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 07 Aug 2025 12:07:42 +0200, Stefan Wahren wrote:
> Currently the driver is not able to handle the case that a SPI device
> specifies a higher spi-max-frequency than half of per-clk:
> 
>     per-clk should be at least two times of transfer speed
> 
> Fix this by clamping to the max possible value and use the minimum SCK
> period of 2 cycles.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: Clamp too high speed_hz
      commit: af357a6a3b7d685e7aa621c6fb1d4ed6c349ec9e

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


