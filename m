Return-Path: <linux-spi+bounces-9585-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0076B30204
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 20:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0189416D060
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BDA341AA5;
	Thu, 21 Aug 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxpcJ4JW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B602FB60E;
	Thu, 21 Aug 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800719; cv=none; b=jbDeqfcJGzqMIDG+lzWM488hRF41oPA3vaQuyo/slkutUx4Hio86V34xv3qS8zJSLdti77K1jNil+qeTpwRfou1kA6DZr8HCUV78fOACH652tjwThULJ5CN6e48ZU/++mms/MjkthGfkCpAZMEGGCzUg2yttw+kJ+r8XcEQlc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800719; c=relaxed/simple;
	bh=8cr0SYLPEP4VoqjLun8Gnfo82XDDx2pS2t0gPxUGeQg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a/NgpVMMwHkQC72/Ghg0lUpHLECBAQXCfkGYDDOs59blAYGW4wSG9UgWDUXZfNlXfLV5T+auHD9XA2S5eMrl7Dh/jlN9HY9dyTAV9HocEheRTyAdEVHHxE7D/xwmvVttfjmQ+ueeQ2R94VJoplSMwRaz/wFeMtvvOk2km9DLQEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxpcJ4JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D94CC4CEEB;
	Thu, 21 Aug 2025 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755800717;
	bh=8cr0SYLPEP4VoqjLun8Gnfo82XDDx2pS2t0gPxUGeQg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FxpcJ4JWljjOcMYlqybZChIzc/eNKzPNe4lQITHWHwPEdtdKQn9g1GGwgpvKSrCvg
	 x+9v+RUaYbipRsCujrHHnwRcHMn6Q1F0F+sS0H7/+hPXdAWhF2ibd5jTN5T/JNyNgu
	 dVWGz+WlHncYc/Cny9T089HYy/YSo1kr+hIPpsvbQzklzdK9tfSp8R4E04IdfzlWuj
	 RoYsWWWZEENpmnwlQP5oqvgS1f5evIiXYVCIHSWYB7ogp7pf7Sr5JdwdBa4EmsXLl9
	 xvkdCawPri0o3QRNmPpjI/jb/qoJaA2m6bNJuBfhXnrGOlk5OVSSbuVnSNFWN2nLjA
	 fpN38vsd+KcIg==
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250820180310.9605-1-rgallaispou@gmail.com>
References: <20250820180310.9605-1-rgallaispou@gmail.com>
Subject: Re: [PATCH] spi: st: fix PM macros to use CONFIG_PM instead of
 CONFIG_PM_SLEEP
Message-Id: <175580071592.121070.12973016680658012702.b4-ty@kernel.org>
Date: Thu, 21 Aug 2025 19:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 20 Aug 2025 20:03:10 +0200, Raphael Gallais-Pou wrote:
> pm_sleep_ptr() depends on CONFIG_PM_SLEEP while pm_ptr() depends on
> CONFIG_PM.  Since ST SSC4 implements runtime PM it makes sense using
> pm_ptr() here.
> 
> For the same reason replace PM macros that use CONFIG_PM.  Doing so
> prevents from using __maybe_unused attribute of runtime PM functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: st: fix PM macros to use CONFIG_PM instead of CONFIG_PM_SLEEP
      commit: 7c7cda81159b1abe7d50bcef2ccc6f662e225c8b

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


