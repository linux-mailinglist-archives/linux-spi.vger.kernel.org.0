Return-Path: <linux-spi+bounces-11308-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7DC6E425
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF91C4ECE57
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F6C34575A;
	Wed, 19 Nov 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq0aZQis"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363A126B2D3;
	Wed, 19 Nov 2025 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551770; cv=none; b=JUrhdLVWe0DJjPKqfBgiyZCtKek34jL+OjfoLuf6Y5q5H9eVC7HPCiynMNfMmmvzCBY0HPE/2EQwkWRHZXjbX/YAosiv0TaFX1zWhU3IlDVhIZP0vVN9U/trTDandoaWiMVkMmq98MIQWMQKeP/svHDfv3O2ZIlV4z2JsjMCskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551770; c=relaxed/simple;
	bh=XBnDVEqfMXjNli1nS3N7yLk+SnIk7BTCbKS34iN3tJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jtzNrd/DjJs7ROrPX/B2TDFDnxxdRdqE4sukZgS8N+J6VPzbMI/vwxlevJlQjA9twQf63vWF6Z2RV9kacr5mPxnFK0y+9AY6FMJEgHRb52Q1hiTUB8ydsjJMdvCvnBLDvRiJqFcc6gC6ZUlWRsPlOzIadDnYW9rfMd2f6t2n3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq0aZQis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A85BC2BCB8;
	Wed, 19 Nov 2025 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763551768;
	bh=XBnDVEqfMXjNli1nS3N7yLk+SnIk7BTCbKS34iN3tJc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Hq0aZQisDxA/1XOPMyfCmy+BjDM/UFO3Nl0Z7bwNVWFS6zrJU2eSKcCfuK5NfB4gO
	 VkC+1Nep+qJg4xUeHhTFfiUecHU93v6yZw0mrBPW0qFv3d5VTalXgi95scTaRTUhb2
	 7JOhB3RFCRfs0wDN243euVZRwj9Blq8g4jtxAmGtXSpjpUE5nGt/NaNK4Ez09FXSNe
	 kKOH3YJZXH6cwsXBDRHvvDjNFOpK0U38qEvr+i3QmL4jqIYvZa6+gaveRv3U5iZtw3
	 CiKcbjIDacH7sNWVlciWfYO4vedUVupCkySZEdMzAK9/v27FLzpP6RtecVJXA72/av
	 +h9+suDQ4k4yg==
From: Mark Brown <broonie@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, Longbin Li <looong.bin@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sophgo@lists.linux.dev
In-Reply-To: <20251117090559.78288-1-looong.bin@gmail.com>
References: <20251117090559.78288-1-looong.bin@gmail.com>
Subject: Re: [PATCH] spi: sophgo: Fix incorrect use of bus width value
 macros
Message-Id: <176355176717.1842480.2581189762580750444.b4-ty@kernel.org>
Date: Wed, 19 Nov 2025 11:29:27 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 17 Nov 2025 17:05:39 +0800, Longbin Li wrote:
> The previous code initialized the 'reg' value with specific bus-width
> values (BUS_WIDTH_2_BIT and BUS_WIDTH_4_BIT), which introduces ambiguity.
> Replace them with BUS_WIDTH_MASK to express the intention clearly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sophgo: Fix incorrect use of bus width value macros
      commit: d9813cd23d5a7b254cc1b1c1ea042634d8da62e6

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


