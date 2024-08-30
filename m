Return-Path: <linux-spi+bounces-4463-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A089662E0
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9311C23383
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483041AF4EB;
	Fri, 30 Aug 2024 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2Zpe57D"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEB1AF4DA;
	Fri, 30 Aug 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024375; cv=none; b=nyZeuX3f5VSthRTwMwV3BtmcARrwBpKtTTh4IF3STnG4lahAcsBW1QLFBd7/dPu7p24zaoNS7zUAWFJaqdmD6KWlB7SPVtmavHF22G7Su2De9Sta/yAanorOwkX2XNd2ydbZdjQG+oDgnpN1fr6mRu+C2+gFj549NqaraSnuOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024375; c=relaxed/simple;
	bh=opmxZALe6MJxD3g/uFPGVChnU9jKvX+bVrQYJoBibo8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dH0nnmhEzzRPxSbrrEQSs6n2go1iu0+iHSRi4uGorzLdYCabO37U8X0updPXdEmv8ckE7QWzMO5ValvIbUVH5v2gA2GO4gMey4cVtD4jykJbmPOc8gPTaipukGCMHqZ+s148UkVIA0ek7LgVVZQHhusctAIB1/2qvbg2nNJLUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2Zpe57D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B7CC4CECD;
	Fri, 30 Aug 2024 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024374;
	bh=opmxZALe6MJxD3g/uFPGVChnU9jKvX+bVrQYJoBibo8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=s2Zpe57DMILot7DO4weooaHlW1tFoJq67StQ++DDAn+9h/OxVnUafi3PJ3kKvfF5e
	 5vC0YLoBWynN1Zcpi7kp8PDjterZ18O1alo2WnEM0TieKSimDyIh9uw4xuFzELWumb
	 Q2Dd4LUFuWCANZRUU5nrzJIE2d+6wcMPOqtgho7XwMVs9TVIedmOnnu8YzL3/FaJj8
	 aqQwh26isw+c50NQPCMUTMHbwqjNRIcRLCbcvJ400f1z6xhJ7DXSrGplBFmh7qHX3F
	 ycTckqUjp3E3Kl5lu3E9ULMCSA1g1Wk/4yNU95WETl4z/2eQM99I5A64iM1mfq+OLp
	 Bj4fH1ZS7FD0Q==
From: Mark Brown <broonie@kernel.org>
To: j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240826132544.3463616-1-ruanjinjie@huawei.com>
References: <20240826132544.3463616-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next 0/2] spi: wpcm-fiu: Fix uninitialized res
Message-Id: <172502437325.145364.4287067442185618996.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 14:26:13 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 26 Aug 2024 21:25:42 +0800, Jinjie Ruan wrote:
> Fix uninitialized res in probe function.
> 
> Jinjie Ruan (2):
>   spi: wpcm-fiu: Fix uninitialized res
>   spi: wpcm-fiu: Simplify with dev_err_probe()
> 
> drivers/spi/spi-wpcm-fiu.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: wpcm-fiu: Fix uninitialized res
      commit: 1db86650b978bf4bf70267556f6bf7bc8b2253da
[2/2] spi: wpcm-fiu: Simplify with dev_err_probe()
      commit: 196d34e2c8cfec7b94e44e75d0b1bc9176acf6f8

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


