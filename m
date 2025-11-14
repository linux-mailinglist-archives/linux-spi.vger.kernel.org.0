Return-Path: <linux-spi+bounces-11219-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A89BC5EB26
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CA62365EC3
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70A1342146;
	Fri, 14 Nov 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKyK6ruW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF2341ACA;
	Fri, 14 Nov 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140032; cv=none; b=fONz6/iRiJ9mfKOYqIPy7fUe1BbyVR1WddJX0wnUyKSdqQWBJ2ANJG6TiGhEIJgp/p0YGEKkJAcVQjibaO065LLu31sC1qjL0RU5FMCLaKRRw9wL0iZ1iuB4sYNEHBYs3E07xXyht9DDECMZeaFvhHi1a1FnJx4Ve6gPkAbHSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140032; c=relaxed/simple;
	bh=igsruaZJbdtmGdaC7B3AS7+DHvBZvaCaPggr5B93CGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H/Tq0AjCw9mWQek2scBK/oecdpwL4FSO9H99mcNE7jUjxWtMEj8DRT03MK51JBk47Sy3WWFxppMWYlQwdAfNQcpd565maUmcdFmjs118KPlw4jOPp/UJRcineniWgvFPU2UQkBJZbQ1abCPW5vHqY5XA7nk7H5Hs+5fmF+64Ks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKyK6ruW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB94C4CEF5;
	Fri, 14 Nov 2025 17:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140032;
	bh=igsruaZJbdtmGdaC7B3AS7+DHvBZvaCaPggr5B93CGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UKyK6ruWPWv9yGMBCnINyDrnhMy42aw/EMiYMNaQxh6ockNFFts/0YsAYtXJhav1X
	 D3ZtvvGusUVZl9tWcAHlp32bUnPxx3JZMETxkAsI2F2KgX56YJSKYulbsKi4WcCCN4
	 OuCHNm8MDkeIMEW4qKgeF5qVafuJ/2FwclXcvQ/6LJ6u1egDzZwzD7P30c4WYtK/+C
	 aXOXZQ5ViMcgOUlU6xVJum1LQZnocf0xTHZX7w8Gvb2Q6SezhmsgJ6IgPzB6yF1SCK
	 HyTc6Gw1FiWRkjF7rgPigiWoIuDS8u0dqPK/9YUADf+OjgNagcyOmwoNRAbAZrt3fC
	 ixeTgM2HVSJWw==
From: Mark Brown <broonie@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>, 
 Cyril Jean <cyril.jean@microchip.com>
In-Reply-To: <20251114104545.284765-1-prajna.rajendrakumar@microchip.com>
References: <20251114104545.284765-1-prajna.rajendrakumar@microchip.com>
Subject: Re: [PATCH v4 0/3] Add support for Microchip CoreSPI Controller
Message-Id: <176314002988.180192.12322068947585326018.b4-ty@kernel.org>
Date: Fri, 14 Nov 2025 17:07:09 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Fri, 14 Nov 2025 10:45:42 +0000, Prajna Rajendra Kumar wrote:
> This patch series adds support for the Microchip FPGA CoreSPI "soft" IP
> and documents its device tree bindings.
> 
> As preparation, the existing Microchip SPI driver is renamed to clearly
> indicate that it supports only the Microchip PolarFire SoC "hard" controller.
> Although it was originally named with the expectation that it might also
> cover the FPGA CoreSPI "soft" IP, the register layouts differ significantly,
> so separate drivers are required.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: microchip: rename driver file and internal identifiers
      commit: 71c814e98696f2cd53e9e6cef7501c2d667d4c5a
[2/3] spi: dt-binding: document Microchip CoreSPI
      commit: 8ce9a2ed153bcaa750aa494e91ce2e70c3b0cdc5
[3/3] spi: add support for microchip "soft" spi controller
      commit: 059f545832be85d29ac9ccc416a16f647aa78485

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


