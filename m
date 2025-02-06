Return-Path: <linux-spi+bounces-6642-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AE9A2AAB7
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 15:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC01E1654C0
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B281C701B;
	Thu,  6 Feb 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXcI7XlE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC491C7010;
	Thu,  6 Feb 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850825; cv=none; b=OYY/eSHh2HgY0Ob8JGnK75fZBtNi5kcZ7zYesETd9RoTBRoaCWDqw85dNDATt2Nuzc3SY3cl452x45HErtOloEkjY4cWke3MioIJfmWhcYMMsFp/MasG8/7ULBn1lb/wQ9uMyrVSZbdik1CYRioSXRE11saVW/GftT8u4CQDT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850825; c=relaxed/simple;
	bh=HjJsCFF4Z8JMVOxvKEDsz//MuJbkSdyVMVXPIBrO2Yc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nb2APdeSnyyiRJZlaBPqSDy+z51LD++fltLnCEfdvc/pcwmGNFEf6EQdIzE7yNxapMqVRQ0Sl4rePb4Wk3sjhbFoHmVzYRgOSPaqSsqpdhkwjO7OVJkOr+dBx+gW/Ns4AiJ2jTNcM7ZQjk/xrAlK62BOXmU16gLNa0l9AB+BtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXcI7XlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BF2C4CEDD;
	Thu,  6 Feb 2025 14:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738850825;
	bh=HjJsCFF4Z8JMVOxvKEDsz//MuJbkSdyVMVXPIBrO2Yc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PXcI7XlECaw/tn6AZG8aeQ2J4+bkRhiLeZD4VLygcrI2daJ9+HV0u0orXmYPcIiC2
	 AJit9YCznVhpkZrkQif1IpjuMXklrYp/6ImvgMj/I1n8xx0OcmfGMigkmOKx06WOiq
	 xMnF8ghlHl0CBpKPNPrS2Xa77aAdFsyA7QebcRTaexbXlkLKXg4TL+PG2EAdNhHUIj
	 g3eehSlUmUnYLtycc9tDoL0IG9rkztN5/BPUrikBzGhQ7UtV1NsW8TAk02gf4mwKNH
	 DrJbmuqgS8igjayoUXBYTohYC1BFzleSWjCS2UJ6z4ZQApNI9nfjdiqf+VLSciPkQD
	 GAgsLEsis5M9A==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250205132127.742750-1-andriy.shevchenko@linux.intel.com>
References: <20250205132127.742750-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] spi: gpio: Enable a single always-selected
 device
Message-Id: <173885082455.182134.9954142937219034850.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 14:07:04 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 05 Feb 2025 15:19:18 +0200, Andy Shevchenko wrote:
> Enable a single always-selected device hardware setup for SPI GPIO driver,
> so some custom SPI bitbang code may be replaced with the generic implementation
> in the future (e.g. Up Board FPGA driver).
> 
> Andy Shevchenko (2):
>   spi: gpio: Remove stale documentation part
>   spi: gpio: Support a single always-selected device
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: gpio: Remove stale documentation part
      commit: c108905a7423d44237d17374f845fc5bb9cb9728
[2/2] spi: gpio: Support a single always-selected device
      commit: 25fac20edd09b60651eabcc57c187b1277f43d08

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


