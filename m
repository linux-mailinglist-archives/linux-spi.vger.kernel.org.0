Return-Path: <linux-spi+bounces-8239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED4AC0CF2
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4049E14DE
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 13:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B28628C010;
	Thu, 22 May 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4/5bUbk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F054274FD3;
	Thu, 22 May 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921082; cv=none; b=oP2R5u8bdBRErRZDGCn1KBRrRpQTF/UxhItla91Dn5CDGRy9qVUchkToLHjIUxmHNHAvobDAJMxiksgpS3xZwBRDrLUS+AprvwZUEaGxzOu3JbzSuCIhm3QAirsI4knFbgumC2bjnXVq8+ZrZGBS5SXfCT1IKn+NhuPwsnYyXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921082; c=relaxed/simple;
	bh=i0zCLDEorMpihVbLEn/vRMO+410NHtKppIyVbVEV7u8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YxWf52Rf8Hz8eQ19bYt/7MUhMrDVtGz4b8SEXNtPyuY0mu0p5FebyZF6/rNNHEr+37meX08pQ20NiHFMZOLRvyJjJ8XNFM5NE7VjkHVaaSjvqZ3EDJooirL7zlOIpLafR0GYvP9hVrdhizUzVHkTvrPfiygmux9uplAaU7sOVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4/5bUbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A2C4CEE4;
	Thu, 22 May 2025 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921081;
	bh=i0zCLDEorMpihVbLEn/vRMO+410NHtKppIyVbVEV7u8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U4/5bUbkxft8uaoJllAghhICE7Dbv82AEXDNWzLlohMY6bRnETCj2yGoU50ltP5r2
	 mV1lBWobvTdWclCS7xo9nGomYTKCy1iBLBbQI3x16GTC2S80B9D6VrHmrvWf8fc0yY
	 fcZ4Oc1I6HAGTtQKnfkfW2g5+FQEcPDkcVgcRRnNHllYC3kaNnAN/AMT7CfuBzHSth
	 lvd8WYgoYxMjVz6DBVvTbwBJ9GXls/Jz+sIl9vaxOSK/QeQwHn2dUkFe9bPp10tY2a
	 wM50toyRPEomJdSjYgmCmCfqXbvVa6+cLQNG4iGh5YEVva2rO3NW6ghmamZKjm7ieC
	 n0Ks+bX3OlR2w==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2025052225-scallion-ritzy-dbbd@gregkh>
References: <2025052225-scallion-ritzy-dbbd@gregkh>
Subject: Re: [PATCH] spi: gpio: fix const issue in spi_to_spi_gpio()
Message-Id: <174792108102.84499.9131453777647011628.b4-ty@kernel.org>
Date: Thu, 22 May 2025 14:38:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 22 May 2025 12:57:26 +0200, Greg Kroah-Hartman wrote:
> While the struct spi_device * passed into spi_to_spi_gpio() is a const
> one, the struct spi_bitbang * that is retrieved from the controller
> field in the spi_device is NOT a const pointer, as it is coming from the
> spi_controller_get_devdata() call, and then passed to container_of()
> which would strip off the const attribute for no good reason (i.e. if a
> const pointer is passed to container_of() it still is const coming out).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: gpio: fix const issue in spi_to_spi_gpio()
      commit: 2712a7d362904d0c4283ae91fac8cea6ecd6f9c2

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


