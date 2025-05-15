Return-Path: <linux-spi+bounces-8137-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFCAAB84D2
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C871BC15CD
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CBA298CB8;
	Thu, 15 May 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCAoqxMF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A9298CAB;
	Thu, 15 May 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308475; cv=none; b=GaqJiLPB8+f/1geJYy8K7WcoZ1HLW/sBXj57Z4LEOnsfm11BYfRBaswjV1Asq9+tIuiXDJRVYL+iiEL4A8JWr9o/ZfjEb75zlsnFt/xSRuGRLfOa6UqhEFdMAPnPZHCy9i2i7wNbARsIDGC/g1jt99FhX7Js6w9bisskwiKrHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308475; c=relaxed/simple;
	bh=hEdn/KMFnQYxoJkipPDpMMQgvm9AX3Cj0DehCIJCKdU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XORt4Kgy5m/HPNUCfyzVyH2Mc/MJqdbsWA8o8+AXEb4ltz0JpNbKxfqJ9uFSbi8K3OxqTBwUJPsSalN6TtujOqTp+9LdMWk2fyWMH8c6CKjfDjkX72BI78Clh+OeCFG0/3OLls+MBENHbMfBw/d881blk7QjiL37x+JDevJRHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCAoqxMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1596C4CEE7;
	Thu, 15 May 2025 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747308474;
	bh=hEdn/KMFnQYxoJkipPDpMMQgvm9AX3Cj0DehCIJCKdU=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=oCAoqxMFxd3Bx0asZewMNTXIS25QhnO6ODsfMvFLIsmjndLHZ7bdSw4BcsK5RsZut
	 2sekFmetTmFFinIZgtukwnC2uuDACqJbdvglxitv/sXMGz1mhduwLxXRZBjfAM7l7n
	 UQCAxHkAyBRBYkURCkBxKAtIWU7iZe72b62NQAGOP9eSie6PB9y7iE/xcze8OKWmgT
	 GNELujMQ/fr41mmdOGVMhbCSM8ZPWhIi7R7K523m8qtGd3yhiECpYSSUgRCufLAirA
	 j4Oh6jAR62jNmPgmLLkhq3lNJZQQJwnd5C1oc8EbN8CwiAT28aMmI15y3BcIT6F6ml
	 iDEx4J4OXR7dA==
From: Mark Brown <broonie@kernel.org>
To: krzk@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com, 
 skomatineni@nvidia.com, ldewangan@nvidia.com, kyarlagadda@nvidia.com, 
 smangipudi@nvidia.com, bgriffis@nvidia.com, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishwaroop A <va@nvidia.com>
In-Reply-To: <20250513200043.608292-1-va@nvidia.com>
References: <20250513200043.608292-1-va@nvidia.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: spi: tegra: Document IOMMU
 property for Tegra234 QSPI
Message-Id: <174730846801.345421.6379001926087017421.b4-ty@kernel.org>
Date: Thu, 15 May 2025 13:27:48 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 13 May 2025 20:00:42 +0000, Vishwaroop A wrote:
> Add the 'iommus' property to the Tegra QSPI device tree binding.
> The property is needed for Tegra234 when using the internal DMA
> controller, and is not supported on other Tegra chips, as DMA is
> handled by an external controller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: tegra: Document IOMMU property for Tegra234 QSPI
      commit: 4614fd6342ab69feebb067d5db84a9bfb9aada9f
[2/2] spi: tegra210-quad: Add support for internal DMA
      commit: 017f1b0bae08e8b456cf35cbdaae93ec19b50f0a

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


