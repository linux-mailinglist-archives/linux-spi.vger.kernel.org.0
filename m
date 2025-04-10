Return-Path: <linux-spi+bounces-7529-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF533A8472E
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730327A926A
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383C192D66;
	Thu, 10 Apr 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5WexpPY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BF143748;
	Thu, 10 Apr 2025 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297218; cv=none; b=X2CVz5YNZ+f/rqb1rGfHeiDqtIzUL1hGKmK7CvBocOHrw0gu+KxmPNojI5RsE+eLvA5wDDexRBWJRqIGJ/smNoFsGs1vAQSki5/aGf5I6zPc2n42p9lqAF+LWe8OLE47GfPK7pE31a3iT/kBG3HwbeSf2WRazb6mUxWEuVdaKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297218; c=relaxed/simple;
	bh=XTcrN412u48sA6bOMNBn/24GrMQPAtxdq5NiRiG6ZE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EiTYqEPD0Q5RVW/HhVcaDvv0hYEyV8R3DvsaeTXI3A4N857twHHaCXGcnO2cGNieRs0RIqMWVYoVPOGJ3HLBwb93L8Mday+V+oDfFiXry9JiQaHw5beV521CEd+IDMefizARSsjYBpBz508AZa4+xbQN+b9KMAPHX8tqYxNyGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5WexpPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C9CC4CEDD;
	Thu, 10 Apr 2025 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744297217;
	bh=XTcrN412u48sA6bOMNBn/24GrMQPAtxdq5NiRiG6ZE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H5WexpPYcB8b3tp3v/MC5atVM3Lrt9lFVN2voQ3sKi6KLPmY/N9CmiKOJFznx1/K2
	 CWeP/chn4ynEzLMCWFMmHJuQv+oLgAa1fqc6abvzN83AlE4Z1erkclDlTh6bbsdh/p
	 a4vKbafhn7wVftuPE5w87IJFBg4/W2Q8tovItQBY06NSrX8AwnzRiK2Hb3HlRwQ4NT
	 Gq8kXV7C85VsGmWQQREszCE6dsDrkM5mPvxUMnQ5BWatch83lBV8FgzcYn2hbiwM36
	 lzXdxEAYllJAhzkWEtbxbbsRo5fxF6FqG0MOU6aYd5Y9NLKOTmmiKdMgItXMg0I1EY
	 0lg3w+PLWZW3g==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
Cc: Han Xu <han.xu@nxp.com>, imx@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
References: <20250410-spi-v1-0-56e867cc19cf@gmail.com>
Subject: Re: [PATCH 0/3] spi: fsl-qspi: Fix double cleanup in probe error
 path
Message-Id: <174429721620.106200.5015477489588388962.b4-ty@kernel.org>
Date: Thu, 10 Apr 2025 16:00:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 10 Apr 2025 14:56:08 +0800, Kevin Hao wrote:
> This patch series fixes double cleanup issues in the fsl-qspi probe
> error path and also simplifies the probe error handling using managed APIs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: fsl-qspi: Fix double cleanup in probe error path
      commit: ed4db69169121ffd9d5a4bcf4d7acd5856cb20cd
[2/3] spi: fsl-spi: Remove redundant probe error message
      commit: 82bedbfedd2fc7cd1287732879e515ceb94f8963
[3/3] spi: fsl-qspi: Simplify probe error handling using managed API
      commit: 3f7b48efb79d91883d98dd7e33dc2a0abfa9f923

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


