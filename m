Return-Path: <linux-spi+bounces-8403-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F20AD229E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 17:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D5116813E
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A046519F461;
	Mon,  9 Jun 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO3OTTOS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE57CA5A;
	Mon,  9 Jun 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483598; cv=none; b=kHGZ9EeWDL2RMgNlMbjALjORA72B/aXoomCeYyA9qfnb/isVK9g++krw17MRhyGgc3fjHmYJe7aVjCOmCMvZd21cS+U6R/n7AgEhlOOu22eeQmtD+ub5Uj8My+FeXu3V1nEcxUisUL98/sLx703RFjnZbL47/t16z3baGRqjTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483598; c=relaxed/simple;
	bh=EqC/uvkRrrh4ubAMjbTCQuOMddZGul995t0PkHwoBco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CqI7xqbaHI5+1gfp9k3kZRNdIUSNMiFUBUxrafI47ib2b7jmum/wbbDm1/sECgTh1Oj1E+n5F3Fte+wZkVpLRhBGIyASLyMLnaso2wcypTdNahjIpRir2sMLIf88An/RZzrOBl5c4I5weyjHEumFGu5wEdfRVtMqvhxrZTMKbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO3OTTOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B442C4CEEB;
	Mon,  9 Jun 2025 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749483598;
	bh=EqC/uvkRrrh4ubAMjbTCQuOMddZGul995t0PkHwoBco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sO3OTTOSLyxGQMnoZ3sceHt3YjgWfYP3wYTWdYSF0LajblcI6aLzDs7E+PB30/+Jz
	 xUF/yhk5uw6kVtwLcf7QABf/KFS0Y71CHHJ3U4Phjf9Tpc1bCRO4E9DBhe4VrU4hnq
	 WKLySNzDhRb/uKtxMUy87je9kye8YXNLcOK0EcQa/lIPBvywffo5spd0VdyJTbbEFc
	 sJ+TzWeKy5OO1UlELS4VPmiXYw2lEVdi/3mhSpkvWxIacixDcf5WhOcpgBQk7g3mD9
	 C7KXuInur2HeKwWpn53VRhd+05hlBaDunpBiU0s7MwoTQ2enqhKvG7TCPJQwEKYjUt
	 qT+BOJPGgKzDg==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <cover.1747401908.git.geert+renesas@glider.be>
References: <cover.1747401908.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH v2 00/22] spi: sh-msiof: Transfer size
 improvements and I2S reuse
Message-Id: <174948359584.187608.4441619994832648508.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 16:39:55 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 16 May 2025 15:32:03 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series (A) improves single transfer sizes in the MSIOF
> driver, using two methods:
>   - By increasing the assumed FIFO sizes, impacting both PIO and DMA
>     transfers,
>   - By using two groups, impacting DMA transfers,
> and (B) lets the recently-introduced MSIOF I2S drive reuse the SPI
> driver's register definitions.  All of this is covered with a thick
> sauce of fixes for (harmless) bugs, cleanups, and refactorings.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[22/22] ASoC: renesas: msiof: Convert to <linux/spi/sh_msiof.h>
        commit: 6ba68e5aa9d5d15c8877a655db279fcfc0b38b04

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


