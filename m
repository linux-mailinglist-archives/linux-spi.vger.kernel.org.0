Return-Path: <linux-spi+bounces-7324-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380BCA71BB0
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A4D84025A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CBD1F5826;
	Wed, 26 Mar 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htEos10u"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262511F7069
	for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006086; cv=none; b=qndbxnHXQzkwynQw+VdHg3YzwTN+PSrlQJvft2BXFKFcUb0Ss3GXVH57b4YG7b85738JiaP5Vuvq3RYtuB4u+m88pbZDLvb7pScE9E0MteG5vbtYdzlFxVyYttYRwTbM8Vs/svPgXmz2jmkZ2sITFNwJOPXtJV0pBqHjMbYPNZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006086; c=relaxed/simple;
	bh=sPx3Y91Z7tpwBuskM40VRn2kEtPE/y6Xzm7p+NjzGa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZRIZS4Oela/Onb8CiWk/T3SZNraepYkoF++fDysgwPErt+lXqFXP/oxFk6J0MWe1j2+bWkEjWqTi377RkaPHiwQeh+DqGMn1AVrb89r/wZLrNkIbvmjIwDW9dfl9az6mTpA0elcIP6iauUkgvh70DGnHGcyOmWLZna2k3DebwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htEos10u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84220C4CEE2;
	Wed, 26 Mar 2025 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743006085;
	bh=sPx3Y91Z7tpwBuskM40VRn2kEtPE/y6Xzm7p+NjzGa8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=htEos10urfSV+X8uX5tWSc4HUqZgPAK8FzVoZ3PmYCKoDW1YLttGbPWRlBl+a6eRT
	 L+AXESZ5QjgUFAwqR408S8811iedaRK1q5NKu8bSPhcGEXk5su6gDmVsMwWFCjP1Su
	 pvZFnUnVp+zadg9NLIrMneAoq6Agxxgu6hOV5RP7EFuxP82H6rnVGs0lhnudLgEHSQ
	 8FLs/U6/VltSWsVuQ5PJiPew7e6F2AXDd8Sos+t9LFbdlLcFXUeVTLiq3R1SDCVU7J
	 o7bYqXG2+wq+pXfEdkbSXqv1jZrdw5cc5ArL/lVPHZrSXjliqX1JvZTTEGAJEWqB8c
	 +sLtAVbORcNSA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Luis de Arquer <ldearquer@gmail.com>
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 Robin Murphy <robin.murphy@arm.com>, luis.dearquer@inertim.com
In-Reply-To: <365ccddfba110549202b3520f4401a6a936e82a8.camel@gmail.com>
References: <365ccddfba110549202b3520f4401a6a936e82a8.camel@gmail.com>
Subject: Re: [PATCH] spi-rockchip: Fix register out of bounds access
Message-Id: <174300608311.118781.4443874956794238056.b4-ty@kernel.org>
Date: Wed, 26 Mar 2025 16:21:23 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 21 Mar 2025 13:57:53 +0100, Luis de Arquer wrote:
> Do not write native chip select stuff for GPIO chip selects.
> GPIOs can be numbered much higher than native CS.
> Also, it makes no sense.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi-rockchip: Fix register out of bounds access
      commit: 7a874e8b54ea21094f7fd2d428b164394c6cb316

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


