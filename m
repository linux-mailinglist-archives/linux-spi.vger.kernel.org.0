Return-Path: <linux-spi+bounces-12019-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B25CCBB9F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 13:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC8A300CBB3
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B83932D7D5;
	Thu, 18 Dec 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN/GdjDv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D132D435;
	Thu, 18 Dec 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059606; cv=none; b=AlKns5Kz9+AuV8XtanoaHbyRKMw9RFWTG486xAOmhdozJ3dSJM5t1dGYx4pgF5DiFaj1U2rwz/2JqDaH4ws+68qXF6veKG3Q3cRp7Kgc+d7Zn4ke9LDMlAFMLM0z7+G27rBMO6IDhonjYQfzFlwhcY5A5FJcApeUHQXA8d/mBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059606; c=relaxed/simple;
	bh=bIS8SgthP2KA0pEwsz7+MUMLc906fScIDQ3gYS+ROsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZF+gSceBhNadJCTgOspzggx/lGPU57m6qIYD4dKnv9a6MDxE5jdxfcD+NVEYc8KqCV8qSzLkCemzwO6PanTwV5HuBd53qVxJFv4ZaZQy7sKRrtU2455RfDp2UDb46uLwH3abxEr60f2lIFWKuDI+Io6dMcSoyiKnT9yCuhbCs54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN/GdjDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D444C4CEFB;
	Thu, 18 Dec 2025 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766059605;
	bh=bIS8SgthP2KA0pEwsz7+MUMLc906fScIDQ3gYS+ROsQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sN/GdjDvlaPokF5izBJKze2G1TyB1DPDpMHb2gHgtOS4qVsLoE/uzU/pi5YPG60gY
	 jzaTJNT+TIhTKVimemhcsC62P8IYj7sTMVtwye4/6i32a4B4s/iIudtWwamMygRXxL
	 V+KEXUte5php9VbN64JuVfjoNW1wGfJ2gY0GPSz1hLrwIHkDB5zkdNXWzDPPi6x+iE
	 HcErBMZtx0iztpnJOdx0+b96Q45jFJbSO2z4vJxNbjccK2ofUfGmoJPsQqCiEakfgF
	 +fSUezMhSKGTSUq1XD3CHsD3gxa0XKaULaBn/w7eXZ8+4gDYNGRrflAhEDsz91pkWf
	 /8c3JyYHA/89A==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, CL Wang <cl634@andestech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tim609@andestech.com
In-Reply-To: <20251215132349.513843-1-cl634@andestech.com>
References: <20251215132349.513843-1-cl634@andestech.com>
Subject: Re: [PATCH V3 0/3] spi: atcspi200: Add support for Andes ATCSPI200
 SPI controller
Message-Id: <176605960378.141857.4623173953165594324.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 12:06:43 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 15 Dec 2025 21:23:46 +0800, CL Wang wrote:
> This series adds support for the Andes ATCSPI200 SPI controller.
> 
> Changes in v3:
>   - Reworked the DT binding to properly describe the compatible fallback
>     relationship, defining "andestech,qilai-spi" as a platform-specific
>     compatible that falls back to the generic "andestech,ae350-spi".
>   - Renamed the DT binding file from 'andestech,qilai-spi.yaml' to
>     'andestech,ae350-spi.yaml' to match the generic fallback compatible.
>   - Updated the 'compatible' property to use a 'oneOf' schema, enforcing
>     the fallback requirement for the specific compatible string.
>   - Updated the MAINTAINERS entry to reflect the renamed DT binding file.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: Add support for ATCSPI200 SPI controller
      commit: b2f06783081859b200a853f9682d831b6fc9982d
[2/3] spi: atcspi200: Add ATCSPI200 SPI controller driver
      commit: 34e3815ea4597131d4324a4aa243d2201e672005
[3/3] MAINTAINERS: Add MAINTAINERS entry for the ATCSPI200 SPI controller driver
      commit: 1303c2903889b01d581083ed92e439e7544dd3e5

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


