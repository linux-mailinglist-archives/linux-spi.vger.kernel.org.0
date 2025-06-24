Return-Path: <linux-spi+bounces-8747-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE91AAE6DA4
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1695A4500
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71552E613A;
	Tue, 24 Jun 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVGV72AA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA692E612C;
	Tue, 24 Jun 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786424; cv=none; b=GBd489MlO/2em4Ycw2WBCpFkbQk6so4+a3Fv3FmAVoya5GbeWwpzFVZXfVIBj7MJiiQInI5to1gmshRCFJIM19khVOUKYP+bI1dO7YzTg6McPYPUXOiKn9Us61oae5ydyuI8XPqHE3rDjSXX30CaCDGzdp4AwvdYSaZiwzG28f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786424; c=relaxed/simple;
	bh=Cmix75u5AdlxAc65xH0CoxFE7U9aH1lHC+yRRGN/iEk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LVF5+J15E7Yv9tV5NxOBPVdAz9Xn0EsDrS/+wWM/FWYu0g/tEdLqJnOOsz38UCeEbqsw6uMGXunxoEASyFLF4tkDqIUhuCbghaB1n+ajgrJsb94KPb2ldcMqjBA7KesNQfFLpdFTFzEBKZ+R/pzjiGLcRUGcwzyCfEQGQBHHZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVGV72AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0BCC4CEF2;
	Tue, 24 Jun 2025 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750786424;
	bh=Cmix75u5AdlxAc65xH0CoxFE7U9aH1lHC+yRRGN/iEk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=pVGV72AAzL7+uO+6a6FctZEV5pQdEuzREnR7PShQHPQkKqiK7srVD+W5Pm7sk6dlB
	 EGRvLWuTvQpvkAoHKbGdXlMJELUx2axkwZ9fnZottJkpRg/WsjkgAdzSM06PRqWSNp
	 tGAPlZONWmcwHBq8MR6MHiMpmhzJWa7WTsvej/ZccLFVk0xhAE1kwN6j6kQuhPVcPD
	 bybULrK4i4OB3PUHwyn/UbALk75xg7sOaFqh3K6LI9Ol1jr0aGKAPAqqcLq4kYZXOl
	 Qkq//dfkjXT5xZABqaqaYyd6Tis2nmEIurXQEnrXKVQSTi1xOp9k5jUr7JGI2xLEH7
	 cLzL7vU4lKQ0w==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thangaraj Samynathan <thangaraj.s@microchip.com>
In-Reply-To: <20250624033028.74389-1-thangaraj.s@microchip.com>
References: <20250624033028.74389-1-thangaraj.s@microchip.com>
Subject: Re: [PATCH v2 for-next] spi: spi-pci1xxxx: Add support for
 per-instance DMA interrupt vectors
Message-Id: <175078642312.219793.13260288534994177625.b4-ty@kernel.org>
Date: Tue, 24 Jun 2025 18:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-08c49

On Tue, 24 Jun 2025 09:00:28 +0530, Thangaraj Samynathan wrote:
> Add support for dedicated DMA interrupt vectors for each SPI hardware
> instance in the pci1xxxx driver. This improves scalability and interrupt
> handling for systems using multiple SPI instances with DMA.
> 
> Introduce a constant `NUM_VEC_PER_INST` to define the number of IRQ
> vectors per instance (main, DMA write, DMA read). Update the
> `pci1xxxx_spi_internal` structure to use an IRQ array.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-pci1xxxx: Add support for per-instance DMA interrupt vectors
      commit: 3e36c822506d924894ff7de549b9377d3114c2d7

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


