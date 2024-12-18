Return-Path: <linux-spi+bounces-6111-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A4B9F6CF2
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 19:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35828169AAE
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 18:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8900F1FA82E;
	Wed, 18 Dec 2024 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFigwBAq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED4314883C;
	Wed, 18 Dec 2024 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545660; cv=none; b=a30v/TESUChFe62V2c90F5NNVO4WcdSemJhQmFd1SYX7P9K5HGp6a2iKgdUUWGC9oL/MaxzaNCbQRuDV0lNTuKR3UvwoSWZpIIPml9Uukzmre5AcSNmGfLZyjRp3aL/Esnaw91qfW49yvD7jzoxEnnXTAep5SjPVbdz3o9PaShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545660; c=relaxed/simple;
	bh=oLjRNaXefOfbuwuGz/n65DpsF3Fb5uurQPkAN2a0Nrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ulaQwB/H1CZTK0iumTe1ykeTo1s8xht8mtDLFt5Iiu85QM1iqJdem0vQm8qZ5BGCxDeYT3ELHdif0HwTWTZPc9cbAz4rJ+l4uzuiIPHH9d1pXGKZh5luKfSwvx50RSrnN13KN8wZxmRs8U5hMpSmOVoJDKU30p1FFYArt+yc7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFigwBAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0E8C4CECD;
	Wed, 18 Dec 2024 18:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734545656;
	bh=oLjRNaXefOfbuwuGz/n65DpsF3Fb5uurQPkAN2a0Nrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RFigwBAqLIxWG023Fhlwq7Ot86RHEKJKM/tCBsnaPO8XAoVjv8DwFdHgh6r7sp6/M
	 UR7+jQXvsJkAYEid+oVGhFVpyC14xJ4Nul2q8O2dK8FJLAsXnjMLF2bA0SPvDqnhJI
	 QC+1onguhqBRBQya7dfZ1JFcA8pv4ONJIRnMZ8n/yLN8E5GhgPvciBRsU68HlYkcEl
	 G453VSFamRisQhgQNrERr78dTxyCml61ZNM17lk7k3pp4kdkDTWRriWdsIm8hu5dPw
	 46Io3XhpdV+7kXa0fPCHs4X7mc/HoYquyOTwdcBaN3N/wsyV6CJ2gqd3rjBP8nLO6F
	 mGpQqV2aM//4g==
From: Mark Brown <broonie@kernel.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241218154741.901591-1-jon.lin@rock-chips.com>
References: <20241218154741.901591-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Fix error in remove progress
Message-Id: <173454565468.177553.7095093662126161024.b4-ty@kernel.org>
Date: Wed, 18 Dec 2024 18:14:14 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 18 Dec 2024 23:47:41 +0800, Jon Lin wrote:
> Fix error in remove progress:
> 	[   43.026148] Call trace:
> 	[   43.026370]  klist_next+0x1c/0x1d4
> 	[   43.026671]  device_for_each_child+0x48/0xac
> 	[   43.027049]  spi_unregister_controller+0x30/0x130
> 	[   43.027469]  rockchip_sfc_remove+0x48/0x80 [spi_rockchip_sfc]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Fix error in remove progress
      commit: 7f9a1eed1ad8b274ed9163a02cef891a90427237

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


