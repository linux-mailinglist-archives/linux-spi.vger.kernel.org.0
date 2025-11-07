Return-Path: <linux-spi+bounces-11117-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE569C40B8B
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 17:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4310E566EFA
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573632E6A3;
	Fri,  7 Nov 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbuDLlAv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95B2BD5B9
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531188; cv=none; b=NmmTidFsJMtw7d70hlD2rsKTvF0m78AG06K3NKuRWx1TCvcRpYkUS+smALDTabwmrRGM5eyIBfAT00Nx2AQm/qe6ol8PuxYDHxgdYi/G7CzqCCmgPvHbfUcPOCjSizdEVGo6TcqPIs4HfTU5FrCR8JuW3PrlKGJPd+BZrD/WoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531188; c=relaxed/simple;
	bh=Nu9pQiWWluOMBcm6b7yiZ0rfNa3MtPokERFvPrmBkQE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dk/ufrC1i2Kmv25r6FerlOApl1PJeZPzRRPu9XsNplh7lAWgBrlWTd0qTagXWaj8RXVAPhuzC+q+D2X3NkwUwoSOycgQdDu62CzwrvFMPAl6Cmv55Z+0rmvbsl6T/oM7YA/uZ+dZ4IK3Oyj7oEmnnUINPxujeB3Vdf32fi4XC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbuDLlAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB028C2BC86;
	Fri,  7 Nov 2025 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531188;
	bh=Nu9pQiWWluOMBcm6b7yiZ0rfNa3MtPokERFvPrmBkQE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CbuDLlAvEMXtciLTAVYx9CfyoLrmE7F8wy2UANIG/DLuQgay/ilE1gfUWR6YKKtBe
	 FXdilUT99O+gousbcHqeQ+N5XtL5Ufn6V3zlRa5Ud1SWhjFHb8EN6FcnPViRvgiTFF
	 3C9vzo0zn1X5SyGkVjqTqvwvft4HjGtPoJWizKH8a2M8+9iGq2e27QXWos5eUjLpML
	 Gdcke/xM2xGq5rFSrzhZalVTVOW6ZNLAE+pm3lYWYeXOr+7dI6DanEUW+UDA5BYiL8
	 D0m8s4JaDIqvp88zqyt4yXn6yk+6LFKGfwuIyGFZWs112WnjOv0qyyLqlJH+zpswds
	 aMDV2faXpVV1A==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 =?utf-8?q?=C3=81lvaro_G=2E_M=2E?= <alvaro.gamez@hazent.com>
Cc: Ricardo Ribalda Delgado <ribalda@kernel.org>, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <40ca72b63d52d2db4d03ed45d17edd1000290c3a.camel@hazent.com>
References: <40ca72b63d52d2db4d03ed45d17edd1000290c3a.camel@hazent.com>
Subject: Re: [PATCH] spi: xilinx: increase number of retries before
 declaring stall
Message-Id: <176253118539.2510994.18162963959461927682.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 15:59:45 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-a6db3

On Thu, 06 Nov 2025 13:14:04 +0100, Álvaro G. M. wrote:
> SPI devices using a (relative) slow frequency need a larger time.
> 
> For instance, microblaze running at 83.25MHz and performing a
> 3 bytes transaction using a 10MHz/16 = 625kHz needed this stall
> value increased to at least 20. The SPI device is quite slow, but
> also is the microblaze, so set this value to 32 to give it even
> more margin.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xilinx: increase number of retries before declaring stall
      commit: 939edfaa10f1d22e6af6a84bf4bd96dc49c67302

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


