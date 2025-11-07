Return-Path: <linux-spi+bounces-11118-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E5C40B88
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9751188AF38
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD22D4A0C;
	Fri,  7 Nov 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7HXgas2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD43271EF
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531190; cv=none; b=YhFQW0NQlfjZAFFd3XBAbaI99V0vuYjIni+1zHJ+wtq/9+iclUixRD1GLLtJYnVK+3NWqoTAPi/c9Zj2vcD1gplmJI8gUjHvo7xd0pVNCQ5/CHSHcpXA2DBGPCdYwo2Y3Mw1ofXaJv/wqYcaJU/4akrPGU7VvA8npDZ7qDaUY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531190; c=relaxed/simple;
	bh=9XBixKpudMKS9X+G368gYi8QFmMR66JCJBKM859S46Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qGGAMUe5MUCInPNvyyUhwEiuav+Prv9mszjdoIZ68AwGBQCwd/7TMk7n9bJ04D8i+O2bmZuZR19LMC/RdcFZz69v/ArR4CIdUgYuzmOFJTzo1whoCVeYk6pB4DcJ7YF09NCZKDPuebBRbOaS3uAT3aa0wdDKBlTW6L7jWprVKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7HXgas2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86BAC4CEF8;
	Fri,  7 Nov 2025 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531190;
	bh=9XBixKpudMKS9X+G368gYi8QFmMR66JCJBKM859S46Q=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=i7HXgas2XYPu6FQC6jW2JW+J+hEZfXCUoRfF+fpbmyAaNP9fU7uX9PPhMkV1gPp5f
	 YYFw0p5cuH3N++ZD0JTlO3qQuck/YdsTnYu910ErTDEYB9S+LuRnZo1AIkvnFKU67t
	 4BwpT2vJSl/xzovY1eNoZdKp2kV9+sNVovBPaAeGpfe+neQv8Pj4gcBLdlzpqT37CV
	 idp3S7GSInqMHzCEx5YTo2F4QfqVxL/Gtn0uA2qVCfTeztERLV8WaURHHH95Ep51fa
	 44fS76Knj8FDokbwCj4uX4kbiyitM1z7QLNou9CRwUl2hJexr/5xeYlN3tFo5bv8EK
	 ggccfAr8/6oZw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Ricardo Ribalda Delgado <ribalda@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Alvaro Gamez Machado <alvaro.gamez@hazent.com>
In-Reply-To: <20251106134545.31942-1-alvaro.gamez@hazent.com>
References: <20251106134545.31942-1-alvaro.gamez@hazent.com>
Subject: Re: [PATCH v2] spi: xilinx: increase number of retries before
 declaring stall
Message-Id: <176253118842.2510994.10326465708576986156.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 15:59:48 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Thu, 06 Nov 2025 14:45:35 +0100, Alvaro Gamez Machado wrote:
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


