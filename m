Return-Path: <linux-spi+bounces-12420-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04814D27DC2
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 19:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF663073E1A
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54BB3BFE27;
	Thu, 15 Jan 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epQ/GH/W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21E3399011;
	Thu, 15 Jan 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502525; cv=none; b=sy0skYwX0jk5eiPljxupo5l9q3fQlEVHlq/eWlRKdsgI5Tk4v4iCFH7sfsUnQ9LVsGFb9KY9ycovECxfGqdzbuiI+22z6Uy4+t1Jd5XF9aNKdGjXt61htYwJrQrnCd2uh+SXxQV4y3QdY6fj/QPGETq7usRY00QQqFj3/k43N8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502525; c=relaxed/simple;
	bh=As+geMpz/z82AIODnSNBNAxX4NNXiKPe7f1jP7D0tGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Piyta4eKrCiMjM6DSsAqEoQLTAZRGPKoFoevHvGFTTewiB13i3cLYI20SpK9v+R3Gvv2pgukhfWpJ/7IPv7O6P3Zfhx2djUmFgaEaOxXI0HrB7pQOOuGKilloo3OykPCqw2L98jBIhP5CkXBkkXSXp7zGz+tnxW3hsujn5GrJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epQ/GH/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4C5C116D0;
	Thu, 15 Jan 2026 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768502525;
	bh=As+geMpz/z82AIODnSNBNAxX4NNXiKPe7f1jP7D0tGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=epQ/GH/WebFI7tDbJD3tbv7m9ZrlX05fOKwjfnt7XasEyuc9INLqHy1t8yL3C4Ytu
	 MAnE67BMjLFbCE023NUYERNfMe6DAKunCgsSqtqG5i0x25w3yjhAxbS3Gko41urLqs
	 59zjLyXfbkLDE97X9NRGA+BtcuK/kCiyxs40PJrBb0L64fTPj/D6+hyKknQj4RD6fr
	 Yj9ejZWbnr2G4Q82WYLnUiTqAlR36v7ydkarv9kTiHNkJ3pRPAiPT5xg1li4KOycUy
	 mH00xtUMB8NK84jW5in83btIPC3sr1PAnYEtf2X/pb55uJ9bEXbpUmg+tuAx6MuD4J
	 RU1JDnTIENutQ==
From: Mark Brown <broonie@kernel.org>
To: peter.chen@cixtech.com, fugang.duan@cixtech.com, 
 Jun Guo <jun.guo@cixtech.com>
Cc: 455.rodrigo.alencar@gmail.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115091924.844179-1-jun.guo@cixtech.com>
References: <20260115091924.844179-1-jun.guo@cixtech.com>
Subject: Re: [PATCH] spi: spi-cadence: enable SPI_CONTROLLER_MUST_TX
Message-Id: <176850252392.1337956.14416489658978740904.b4-ty@kernel.org>
Date: Thu, 15 Jan 2026 18:42:03 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 15 Jan 2026 17:19:24 +0800, Jun Guo wrote:
> During an SPI read operation, even if the xspi->txbuf passed to the
> cdns_spi_writerinterface is empty, it is still necessary to call
> cdns_spi_write(xspi, CDNS_SPI_TXD, txw); otherwise, the read operation
> will fail to obtain data correctly due to a lack of clocks.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence: enable SPI_CONTROLLER_MUST_TX
      commit: f6b625639e39bc384a7bddbf134a698d40258b3b

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


