Return-Path: <linux-spi+bounces-7024-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F35A4DF6E
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 14:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE8C3B26CC
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD9204096;
	Tue,  4 Mar 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ua8SHcs2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457726ACD;
	Tue,  4 Mar 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095555; cv=none; b=OB7vNyStTfoGrYP5gd5HOZLpYgavKtgN9yQJX3levXWJvPPTec+gcsMKP3Ffe9Ophv6VOO4vojiFLR4YWJa/obgMG+iLlCd7wD9ieArWd5h+B23G4bvP3JX2PeOh2EP6ej2qZK8p6Nr4PfTzskgUrgG7aKwLNEMrBfhaBWQxZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095555; c=relaxed/simple;
	bh=pGtzFJx1ZV7VYljEhRmiQEQlXe0gsXcMJU8mlXh5y94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mj4J4SD3zkIpf1wcKafCJGV8pLMPOSeZkl9TMw3+wgwi5V5exOdn7zKQ+tgzecNHrMBSiPKsR0xd5ylDAmNcXQunpf3OP4vtfxG2PDxJijC64XYI6FYu7U+r44qIt8Z7HwTWst4HX0d+ZJhBp2ciPLDnPY/yVCJ4nldgjfiQzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ua8SHcs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF77C4CEE5;
	Tue,  4 Mar 2025 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095554;
	bh=pGtzFJx1ZV7VYljEhRmiQEQlXe0gsXcMJU8mlXh5y94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ua8SHcs2SV+iodmZpHr+I2lQNiL7Q8nx/hQsIFpPEkKsI+ThVMPFCwdcB9dXNAXZG
	 uDap1cIyhLgPtqblVuCjxNze/7l9dmvSqwi/YH+JrW5GDyBdS8w05gmF8oM9eH81nN
	 q9agxYpZqTqHX39z63T5Rut22F0blaOW2rDVTjm12934Wpx5LmmEbVvP6DqbvBL992
	 Glb4vhxmvUsYQzGUkdFCvs//6EkFyZ28dIJeEec9HsE/IuuHkCpC22loh/gwmGk1tY
	 SKzG5n0zQhOoAftlwossYjeDu/mrz2X451FvKhwgfWrXP7AzxbfX6WExThpjAnakjD
	 5NlRxTA3zPalQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, patrice.chotard@foss.st.com
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 christophe.kerello@foss.st.com
In-Reply-To: <20250219080059.367045-1-patrice.chotard@foss.st.com>
References: <20250219080059.367045-1-patrice.chotard@foss.st.com>
Subject: Re: (subset) [PATCH v5 0/8] Add STM32MP25 SPI NOR support
Message-Id: <174109554967.53872.7193131885074327926.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 13:39:09 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 19 Feb 2025 09:00:51 +0100, patrice.chotard@foss.st.com wrote:
> This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics.
> 
> On STM32MP25 SoCs family, an Octo Memory Manager block manages the muxing,
> the memory area split, the chip select override and the time constraint
> between its 2 Octo SPI children.
> 
> Due to these depedencies, this series adds support for:
>   - Octo Memory Manager driver.
>   - Octo SPI driver.
>   - yaml schema for Octo Memory Manager and Octo SPI drivers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/8] dt-bindings: spi: Add STM32 OSPI controller
      commit: bed97e35786a7d0141d1ecaaace03c46b5435d75
[2/8] spi: stm32: Add OSPI driver
      commit: 79b8a705e26c08f8f09dd55f1dd56f2375973d2d

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


