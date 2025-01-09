Return-Path: <linux-spi+bounces-6268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEEA077EE
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 14:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F6D188AE77
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jan 2025 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31580219A8F;
	Thu,  9 Jan 2025 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeZMDyg7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E07219A74;
	Thu,  9 Jan 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430040; cv=none; b=WHdmPmjSSuZyb/nMM850DJ1kkdR50e8pkWOMAA3Nso6WEogLSLCCiClJRn25Pq2sIT1Ccoiq2O61LapR+P244kD3VXPObZpe1acjkSWrJSh9iQIuauNXiw0fsHTDVsrRGcYpjngWKyaZguxtV8nIOJqgnnhUCMCmoBCswOYdJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430040; c=relaxed/simple;
	bh=8QXQuS3ZxeiaLM1ayescKH0xKuOZEihfBJNtlXKWO0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mjs1fRTx5Ls18cCMbo2KgTvwu32rx2QYInIYnOKDAa9qhla5LrK8Y5coqKH5bDwzguCWOJzp/lZjfPHoeeyDLPXwfZmVxb9Y4mcg7SVl9oq52e11UAhBe+l2PL2qg7kIBggLQo2D8Yp4msVK/hVkp10WTQTvnqybyvHLG9OndL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeZMDyg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE310C4CED2;
	Thu,  9 Jan 2025 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736430039;
	bh=8QXQuS3ZxeiaLM1ayescKH0xKuOZEihfBJNtlXKWO0E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jeZMDyg7iYijJrgWNjuiS07kcUghLzq+Pfm8rKwdJZfjNgH4+Fvdo2u6/sCAx9gYt
	 XoRQTe6i2pmhY7SSDO3s9N9EuzttjPQrQfbkfdMrpUNCzDJ6pp0DjozrC0eeZlN3ds
	 dN/9f4dKX/0wyOVfVbArGuzDMoy9Flx5EnkZ5mrVxHooww5U4y/nfLPPmpM0AhQtbP
	 eeRQCoDvsla4kYn1mhzgf661MHpcjOCpz7i8jnBLVeuIaztxsEWcZgabFNqGDW9Nv0
	 UKZ4g3fpJbQtPO3QuYHk1+MAvr+O6roFMYnPAGXTN+U9flykKzddlFsvYZ9mSNTLbM
	 ePMrerHh9bz/A==
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <8a37a960ff084dfdb9233849c00714e9317ae6a5.1736405336.git.christophe.leroy@csgroup.eu>
References: <8a37a960ff084dfdb9233849c00714e9317ae6a5.1736405336.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] spi: fsl-spi: Remove display of virtual address
Message-Id: <173643003851.53058.4009453720979125010.b4-ty@kernel.org>
Date: Thu, 09 Jan 2025 13:40:38 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 09 Jan 2025 07:51:45 +0100, Christophe Leroy wrote:
> The following appears in kernel log at boot:
> 
> 	fsl_spi b01004c0.spi: at 0x(ptrval) (irq = 51), QE mode
> 
> This is useless, so remove the display of that virtual address and
> display the MMIO address instead, just like serial core does.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-spi: Remove display of virtual address
      commit: 636ee5781d259258dc9425a5552be1ffa458633c

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


