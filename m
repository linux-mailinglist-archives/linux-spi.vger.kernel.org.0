Return-Path: <linux-spi+bounces-8892-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9496AEDB63
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27BA189B66E
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF026562D;
	Mon, 30 Jun 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta5VRcZq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990DA26560D;
	Mon, 30 Jun 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283652; cv=none; b=Cr1MaifkomV5sUd0sOquOOxapyuUGdm4gccN3KP9sZus1w/l5ZzwKW5JPrepEhdglzGW+eJQpyRun58sMjzpmN3M3NlQIKJYNX2CUTPsq8rpKVBaDtx+zwQTwz54W/7sWsmo1s8iJCWBcEqJcNgrcO7ebCE+ziiLt9sL9OgTBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283652; c=relaxed/simple;
	bh=zPOhc/KELxKgSfy1G+NzpgTe6vDr2341CUf1qfmotxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LP2j983W9j0dJ3T0zNKGblYzLFthXfXH7LCUA2yIZfYDMH1VEjLsNhmOFnRNgMCvjv5dy4Nujg6qPqDnFWNkQrVbgGWC2UufpLiz7uQusl82snlj98fG/2urfhvUbIf87VSCAzWPxTz0cNWpbxZ/PhCcHaVR7ZWBeVjHXoD4bDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta5VRcZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0054FC4CEF0;
	Mon, 30 Jun 2025 11:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751283652;
	bh=zPOhc/KELxKgSfy1G+NzpgTe6vDr2341CUf1qfmotxk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ta5VRcZqQqZj/Xz0XXvjS6DmyvQI45fgkqeVYLq9eHkGODBN/CTxPMt7bns+ZfBYY
	 6/+mLGhr+8YuK8sM83RzYTm3uMjfSUpKHUo19V/96yN2paN2ybS9IHSAvqcGIlV+Ph
	 qPwQxxQYXTUPMc7r/dGy5Y8Y+ZGgTnMpB9I34wkADPFtDoSCvZNzCEOkMyhgTJs8IS
	 RPmyA6vbUojCzCKXvSKfC0pUEb3LRSIWkp2v3JzPyZ4G1kOujjxoAM1i3MgSmqoz5a
	 31Fhpi6V5NuEGwxqFCEl5xIwDY0pM/XPp7fIwuO0LPbJCUnxCDweZ9nSCWZxB2xYoI
	 WRhOrHmdOYUiA==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, 
 James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>
In-Reply-To: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
Subject: Re: [PATCH 0/4] spi: spi-fsl-dspi: Target mode improvements
Message-Id: <175128365072.28911.16806664823646528710.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 12:40:50 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 09 Jun 2025 16:32:37 +0100, James Clark wrote:
> Improve usability of target mode by reporting FIFO errors and increasing
> the buffer size when DMA is used. While we're touching DMA stuff also
> switch to non-coherent memory, although this is unrelated to target
> mode.
> 
> The first commit is marked as a fix because it can fix intermittent
> issues with existing transfers, rather than the later fixes which
> improve larger than FIFO target mode transfers which would have never
> worked.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
      commit: fa60c094c19b97e103d653f528f8d9c178b6a5f5
[2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
      (no commit info)
[3/4] spi: spi-fsl-dspi: Increase DMA buffer size
      (no commit info)
[4/4] spi: spi-fsl-dspi: Report FIFO overflows as errors
      (no commit info)

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


