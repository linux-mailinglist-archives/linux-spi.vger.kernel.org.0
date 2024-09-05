Return-Path: <linux-spi+bounces-4692-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC34096E54C
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 23:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FC31F24A3F
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 21:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892081A724A;
	Thu,  5 Sep 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS4mkPUn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5631A19409A;
	Thu,  5 Sep 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573086; cv=none; b=CK333kZpMavmxuB9ciWFMPTaz9ESFkz1bSJXO3msk7g3V/2Jzs1tg/f+qCGUNx/Ubogt0bZEQCFfxqMSTGPDglY9+LzGcv9vev28bT9mxTAWlt1JisVUcZoHcnjSwlBCWmhzYrWsmGVXNryim6aRESaZgQ5aDB9ni+2+8z2uJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573086; c=relaxed/simple;
	bh=qC/j76b+R8nl4FvGF+wfVAUMRsOLUWok+1+ITyjyOyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t/+AW5TJ8K0Uuz2cYi3oZjAylBqBtofFO0EB/fwRU+BZe1i+CTcv+VNpZAHtcfbxugOze9bK/cjSfG8LvvSyHbyeZWJym0IlGIlafRCxGlqD9z9EPMmJtVudP/M5+l5+i40sviBngm4uY1Pj/h4XDUzWFI+6T2U+AIsvWjXzMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS4mkPUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBD1C4CEC3;
	Thu,  5 Sep 2024 21:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725573086;
	bh=qC/j76b+R8nl4FvGF+wfVAUMRsOLUWok+1+ITyjyOyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bS4mkPUnFgcQZg4athcccUMGNGlA1lyJQPoF24ov48v7+RtyEhDgCCBPOmGvaswPX
	 V4i0BM5DSP+dZWc61T+1pCoeYwbv3Y2kfGyrrsQ4FVkQJhafnAMlSbQz+Kf0ouChpH
	 Y+mDzT7uW6aLGWsmAGQkKoRoRVq/m8ymjq5CRwGjCdaO6fD6dXTUhHIlQ/TA+RxkA0
	 ixqWOtq+st5+z71/nfgy3Mz7mFtBWPVjiMEDeAA309qul49DjRpvcxkiQ0BT9VQ5Xf
	 6jU9RW2WepOLrzkCIT3COoR7EnsOrxdbW5wD4s6ViS4fQgZkYSqMrzLRRPpb5+Fmy3
	 JV19ijdjtCZ9g==
From: Mark Brown <broonie@kernel.org>
To: wahrenst@gmx.net, Frank Li <Frank.Li@nxp.com>
Cc: carlos.song@nxp.com, festevam@gmail.com, imx@lists.linux.dev, 
 kernel@pengutronix.de, linux-spi@vger.kernel.org, s.hauer@pengutronix.de, 
 shawnguo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240905154124.1901311-1-Frank.Li@nxp.com>
References: <20240905154124.1901311-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: SPI: Add freescale lpspi maintainer
 information
Message-Id: <172557308391.131770.11874502570887851555.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 22:51:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 05 Sep 2024 11:41:24 -0400, Frank Li wrote:
> Add imx@lists.linux.dev and NXP maintainer information for lpspi driver
> (drivers/spi/spi-fsl-lpspi.c).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: SPI: Add freescale lpspi maintainer information
      commit: fb9820c550cfc58684b612471cc50e4b5c305404

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


