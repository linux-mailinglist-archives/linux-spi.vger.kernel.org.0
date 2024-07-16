Return-Path: <linux-spi+bounces-3871-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F9932768
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 15:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624EB1F21A72
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jul 2024 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFEA19AD68;
	Tue, 16 Jul 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzFN1jdB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9103619645E;
	Tue, 16 Jul 2024 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136387; cv=none; b=Q5p4CzOsaal8PDepGKgQiSNfg1BIwtjF0tPMj2gPVQRzbCMS6ChHMlIzLMMOXAaD4fMnmNQ4awhKoNDAVrz9MvDlB/Xm2eEc+bRaF322+dOcVb3/Eh/ZocNzgULxjubCNQcGf9NbbR7Twg4Gk7Q9PIs62d2pgAZhxwAZr4SzjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136387; c=relaxed/simple;
	bh=kOsg1x77Zf5LFAljAA7Gj9lK27D8oOFLL9u/hzXlnPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CKrcL825XZLWTBd/t8azPXy3SyffyLUw53ik6/msRLAWpsREFPwEzUpfZYaI5y5W0NhcwDKREhV0tAgUXfGag+8eJENSlEsNPpV9BKsYLeLimEWfUe0u/fZ4dW098rpigG5+F4shf3C7p0FfFlBcNgDPqHN9lzNOofF9VfVPeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzFN1jdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C15C116B1;
	Tue, 16 Jul 2024 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721136387;
	bh=kOsg1x77Zf5LFAljAA7Gj9lK27D8oOFLL9u/hzXlnPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mzFN1jdBCbrMQfRjsCpov09aVP9RM10LLRixWnCk/eU/XJGc/dKnNZkilfkD3mvXI
	 zgqN88x5/ccxc6JkUC4/TP/tXYg8+lX3noADaUGdukQIy2FXjFjp6R2vKWrpkZ4ZOt
	 KGBFHfwkRc2I+R7e3StcSSapBUagUdItZJPc3gqx6UEufXeGUrCvN4gspWzg2v0xKE
	 CyrLE7d/Xs+Unp313fS+mykQ5qyp0PrtIRCLbH7RrmHB7KzJ7N02XRcmGc/mfPA99Q
	 7mu9N7pkaWs2M6hoRr9LnClx0xONSwBo3ER8vMOoH1ov0VBpZ5mbfw1lOC9QBqYKg0
	 iJltPtcagVFvw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Cc: conor@kernel.org, Steve Wilkins <steve.wilkins@raymarine.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240715-retail-magnolia-bbd49a657a89@wendy>
References: <20240715-retail-magnolia-bbd49a657a89@wendy>
Subject: Re: [PATCH v1 0/6] spi-microchip-core fixes & variable word size
 support
Message-Id: <172113638564.45824.9404725217000849736.b4-ty@kernel.org>
Date: Tue, 16 Jul 2024 14:26:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 15 Jul 2024 12:13:51 +0100, Conor Dooley wrote:
> Hey Mark,
> 
> Got some fixes here for the spi-microchip-core driver, that I am passing
> on.. The author of the first patch is no longer at Microchip, so there's
> probably gonna be some bounces on the series. The remainder of the
> patches got sent in by a user, and, other than one patch, I just wrote
> commit messages for those that were missing them and rebased the series
> on top of mainline.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/6] spi: microchip-core: fix the issues in the isr
      commit: 502a582b8dd897d9282db47c0911d5320ef2e6b9
[2/6] spi: microchip-core: defer asserting chip select until just before write to TX FIFO
      commit: 22fd98c107c792e35db7abe45298bc3a29bf4723
[3/6] spi: microchip-core: only disable SPI controller when register value change requires it
      commit: de9850b5c606b754dd7861678d6e2874b96b04f8
[4/6] spi: microchip-core: fix init function not setting the master and motorola modes
      commit: 3a5e76283672efddf47cea39ccfe9f5735cc91d5
[5/6] spi: microchip-core: ensure TX and RX FIFOs are empty at start of a transfer
      commit: 9cf71eb0faef4bff01df4264841b8465382d7927
[6/6] spi: microchip-core: add support for word sizes of 1 to 32 bits
      commit: 87232ea8a5caf8d050f8ea7acd210a2cfcbe6309

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


