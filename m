Return-Path: <linux-spi+bounces-12350-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF1D1A9FA
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 632D630090E2
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68137350D6B;
	Tue, 13 Jan 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIrk4+LJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42955350A25;
	Tue, 13 Jan 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325379; cv=none; b=CQPg4gtlTV98nOfp+2gMxOM3ENVXD8IyxMkXWJkrdlqB0aQDjHwu8WXyiV+eZR9dHcSi91Ikl3cNWuaJj0XNuSm3YwUXWf6E5uSvh66I8MkdOp2RCWKlfOfHV5NiMte2ZPiCMx8Z401jSkHPEJiTYVhMXzXm1bhSDnsWv8VF5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325379; c=relaxed/simple;
	bh=KeZ8i+3e33/4xT361p0bNijNsA80PiU6Xd5CSu/FXes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TrHWlGYCy7ci1JAmlCdjMUyQyMo3PjgrvvGXbVrySkJAI62gW9EPMudcbqEHxat/6NQBz5E7Yl0LwzwolSqSAoegZ2GAkhUeaV9v7NJ2iSi6pN2+CuLMj+uKX3+q9OwRg9QMc/d2kQsm/5UuppUmPNrLz94ZXUVIpxSPTtOeNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIrk4+LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B67C116C6;
	Tue, 13 Jan 2026 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768325378;
	bh=KeZ8i+3e33/4xT361p0bNijNsA80PiU6Xd5CSu/FXes=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rIrk4+LJ9f4lBj0+ocKmJUujOZEgKECs7HlcWLW+kXj3KRWjcWyewQuirzvTBTGb1
	 b9g9vSEJmrx52JKgVbANkAd/vA38z1vfEr8lytCwLy17Hkg27My4vpDwpMhVKZV81A
	 pkZTWCP2vPPXR1776zmmAoaFk8jFWEWTsaRddPM98LEedxwQQ4YgOJ+W36QRiGD+Gz
	 4wkRbmxmR0IPy/LbvF0NfK7fNOHitIFAU/ziiznqLJaalznqTfHPailHoM3mcPa7vK
	 Kq5uaEDmFFA2K5EqsMFl97WzlXm7LUuzaymjc44yzFYiEtEaBDBx0uCcU0Oc55KY/r
	 XelZQlWxSw9BQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
In-Reply-To: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
References: <20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com>
Subject: Re: (subset) [PATCH v2 00/27] mtd: spinand: Octal DTR support
Message-Id: <176832537652.1101946.8916189938388408130.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 17:29:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Fri, 09 Jan 2026 18:17:58 +0100, Miquel Raynal wrote:
> This series adds support for 8D-8D-8D in SPI NAND, which can already be
> leveraged without any SPI changes as controllers already have this
> support for some SPI NOR devices.
> 
> The series is a bit long because many preparation patches were needed
> in order to have a clean 8D-8D-8D introduction (one of the last
> patches), but I believe the split is worth it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/27] spi: spi-mem: Make the DTR command operation macro more suitable
        commit: 0196932f539e306e122b6edf24c9f5e30d1f73ee
[02/27] spi: spi-mem: Create a repeated address operation
        commit: af4b2dc4810380a469dcd7508923b70892c2996a
[03/27] spi: spi-mem: Limit octal DTR constraints to octal DTR situations
        commit: 8618271887ca10ac5108fe7e1d82ba8f1b152cf9

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


