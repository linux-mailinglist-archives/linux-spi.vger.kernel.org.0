Return-Path: <linux-spi+bounces-10131-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B009B8624C
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C087B4ECE
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6324BC07;
	Thu, 18 Sep 2025 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diFY3vQa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C52246BB8;
	Thu, 18 Sep 2025 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215101; cv=none; b=VruVdiva8PH7MbQzMR7qnLAqT4+DhpHeYo+A4uVKWQTVdsNsPajGbyzx97rnoTy0OI1ci5xhFdSy8ypnu9Cq0CQNzkGrfiUq9giI52jWz/Yc54K7pN7d/DmSbItQsswOjKRBzhZy1AYn7WWSz8Bc8Zw2EhF025g9l+JM8T9cFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215101; c=relaxed/simple;
	bh=a2wSSef3Du0dV802ZRWP0K1ebOZ2r80wa7XHm8uoFPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uvseEB7tB8WdeC4nwN6CwcY6t9yv27piVZqVzgruczfcq39zEnoSIHR4FAfMA4WS1MH396SEB9gVVZO5KjvOkdpD5iEh81BkMVpffLXHBzKw2TeD5CHpySvVBBRitorRHhw08qSvqgGwX74E0q7fSfD9wja2msunn/hj5j+dfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diFY3vQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B169C4CEE7;
	Thu, 18 Sep 2025 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758215101;
	bh=a2wSSef3Du0dV802ZRWP0K1ebOZ2r80wa7XHm8uoFPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=diFY3vQavuiQRrhCNAu6iUYXj9I8H1JqETJeI/Akb9ajERj6Q65o/UpnlZsGB9rkF
	 xcNbC1fXK1H9DtyoaQ8IlQah+TGK4dZJdBJ2SvU7Osr28nWZCyENuaODL9w3Dx3Q5a
	 V1rPRNb67TiuJVEDDyxpFseFt8hrRtj5q+XiGsclBScvr3aHrS1w+egXswXLNwA5AI
	 E7egT7+kNPmFotZGXGVuGLWJ4jCg/U3OCgS/FyGFsFhaMUm7N4xXRstHy9LRuaS3Bt
	 sr2NkAIXGwo7VqkKOe2jeUVAJiW+amPjJqtmkfnqLX70CdkmuI+Y/em8M+pQrR1pme
	 dgjuxyXaA1ITw==
From: Mark Brown <broonie@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Tim Kuo <Tim.Kuo@mediatek.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Steven Liu <Steven.Liu@mediatek.com>, 
 Sky Huang <Skylake.Huang@mediatek.com>
In-Reply-To: <20250917055839.500615-1-Tim.Kuo@mediatek.com>
References: <20250917055839.500615-1-Tim.Kuo@mediatek.com>
Subject: Re: [PATCH v2] spi: mt65xx: add dual and quad mode for standard
 spi device
Message-Id: <175821509922.138184.639016042104046849.b4-ty@kernel.org>
Date: Thu, 18 Sep 2025 18:04:59 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 17 Sep 2025 13:58:39 +0800, Tim Kuo wrote:
> Mediatek SPI hardware natively supports dual and quad modes, and these
> modes are already enabled for SPI flash devices under spi-mem framework
> in MTK SPI controller spi-mt65xx. However, other SPI devices, such as
> touch panels, are limited to single mode because spi-mt65xx lacks SPI
> mode argument parsing from SPI framework for these SPI devices outside
> spi-mem framework.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mt65xx: add dual and quad mode for standard spi device
      commit: ab63e9910d2d3ea4b8e6c08812258a676defcb9c

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


