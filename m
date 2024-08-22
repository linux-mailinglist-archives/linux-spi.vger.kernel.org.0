Return-Path: <linux-spi+bounces-4268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D726895BB9A
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B78289DC0
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2024 16:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B421CDA1B;
	Thu, 22 Aug 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h246QKT8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE113C9CB;
	Thu, 22 Aug 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343472; cv=none; b=i+zDPDnXydFwipniLRwsum+IMal33EQZ1oowAMghV7tHJ6IbRqXh0LWNdsOkED9f8WpNrl/54cADDb0fFMuxj44xrCvNUORCQpwWd67gADD/Js7HHeRpaEZaTQwLR3Tfq5zkhlysH19IY+BLTOlWxrjBu7LVXG8FI1LwE+xbdqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343472; c=relaxed/simple;
	bh=dXZvI3bRBtpbTE/A7MgmByR0nd5PgJEZrn+L/Q+vApE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UOw1pjWWHo3J32gDszCY9sILJTx1IXkVEyJO7picXyAE/2uBiS6lM5xJXrxcJpnQSMlYrZr4cuSqg9FQ5c1w5NKD6uffT2BPUcBnsP2/iHzGLdwPKUNZ9REYHUsqVfqxAtpCf1mLQWKiFbm6LHFKnPA0CDmNmFN6QMrNYy4lnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h246QKT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86AEC4AF10;
	Thu, 22 Aug 2024 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724343471;
	bh=dXZvI3bRBtpbTE/A7MgmByR0nd5PgJEZrn+L/Q+vApE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h246QKT8gb83O9zCxvrQeejWHfLG+5H96djC8CSDViigDuKMJwom7UZBRLqarRdnz
	 qVPJl7sODCR7GZ2zDCKhLh93/SMOHZSfVEGZhlmt1sgpSDgHYdJFfqzMMpxIAtCsvG
	 GIMZO3QS25EcXGwgbnACVB+NTRH7761otUW7jeTFeMrnreEGydlU7Fp/sylu+hQvEY
	 nDQMXMJY2LhraHPkHgyKWfiH3SFlaqua0TRfqPODvuPsrZV9porUTquPqgFgnYAf0g
	 AovnO702W3VEykTQpAOXytotva1LRToxvU9riBK4EN7iygcMQVsCUn/ApymGSdyM7p
	 opxb8Z4Gvvttg==
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
In-Reply-To: <20240822113408.750831-1-andriy.shevchenko@linux.intel.com>
References: <20240822113408.750831-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] spi: pxa2xx: Fix module reloading failure
Message-Id: <172434346939.724581.4660359175947229932.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 17:17:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 22 Aug 2024 14:30:52 +0300, Andy Shevchenko wrote:
> After splitting platform and reworking PCI drivers the module
> reloading became broken as reported by Hao. Here is the patch
> to fix that along with another one that fixes PM runtime workflow
> differences between the busses (PCI vs. platform).
> 
> This is material for v6.11 as the initial work landed there and we still
> have time to fix it before the release.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: pxa2xx: Do not override dev->platform_data on probe
      commit: 9a8fc292dd93b93db30e01c94c0da4c944852f28
[2/2] spi: pxa2xx: Move PM runtime handling to the glue drivers
      commit: e17465f78eb92ebb4be17e35d6c0584406f643a0

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


