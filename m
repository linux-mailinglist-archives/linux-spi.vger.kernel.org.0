Return-Path: <linux-spi+bounces-9368-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BFFB2256B
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB4C3B116D
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5A2F0C45;
	Tue, 12 Aug 2025 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcO3FcJv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02EC2EFDBE;
	Tue, 12 Aug 2025 11:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996751; cv=none; b=lva8eJMWyz5OxTMB84IvCsB7def3WbcVtVPa+zy4mN5/gN8vT1xoGR1HIKTXm39BXVzIGrIJac0OBzvEkiovuLfOsbz+iud/rFoYZJ8l8L4niIPUgIhNfKv7aBNra7/8UBCyO2sMdR9iI+slXps4FKbxgD2G/MTYPgl6wtcShUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996751; c=relaxed/simple;
	bh=DKWZGx+TMzDh4nT8KSomqllRYPxezHT+9s2or2Azo4o=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=raDXv5sp8/+7qEBc0Nqg8PsS+u9Rv9sBWEu5AaxBXnWKbp1QJwi+s5Q0p6GHEI6bC+TVOb2ubaZqoMmhA3esFHr5kvgLkqs0yKXhPeBL15gJlAu+REANR0OYtFE0PNucwVYWcWWXYAYTOgo9FzPHFIJLs8CQnDORg96C3YrrAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcO3FcJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550B7C4CEF4;
	Tue, 12 Aug 2025 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996751;
	bh=DKWZGx+TMzDh4nT8KSomqllRYPxezHT+9s2or2Azo4o=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LcO3FcJvz5AwH1cMfQyjoxycSL/+ZSWHplSedZ4GF/AWmha9nJKsLfJ+FT6LM4Meo
	 m1vyLEO934nZCX2rJ7pJ4PNzXXPYGOJkRlPVShdty5aZHDCCDpWwpTA/D+9jNSuTa3
	 7mssVQbM85pFyfKWIvqwfcdFpx734grqTUefo5Cd7Z+nAXQf4B53+jBVQ2gmJ2Aar3
	 sbi6qp6jzNJs6DU2Ksywc9RRlBtViKUr0xsxXvfWtSAElMiJ/9KUjnTB2g7JuHjS/M
	 MM3n0H+Lw8ycrVzKQ/uAhM4SF5UiiQmpT2LN5IqxOWNXRlp3+NtKYiuDXe5YrDMxVi
	 LGou2IuoDY23g==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, ryan.wanner@microchip.com, 
 tudor.ambarus@linaro.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Manikandan Muralidharan <manikandan.m@microchip.com>
In-Reply-To: <20250730101015.323964-1-manikandan.m@microchip.com>
References: <20250730101015.323964-1-manikandan.m@microchip.com>
Subject: Re: [PATCH v2 1/3] spi: atmel: simplify MR register update in
 cs_activate()
Message-Id: <175499674908.16293.5097516304989126078.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 30 Jul 2025 15:40:13 +0530, Manikandan Muralidharan wrote:
> simplified the MR register configuration by updating only the PCS field
> using SPI_BFINS() instead of rewriting the entire register.
> Avoids code duplication.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: atmel: simplify MR register update in cs_activate()
      commit: 379f819733f28b5aa1802f3ede442f08b7275f4e
[2/3] spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional 'spi_gclk' clock
      commit: a673ebd0a2a587f3d6b923d59d363fc9e8a9f920
[3/3] spi: atmel: Add support for handling GCLK as a clock source
      commit: 91e5722baaea06c1f1b105e9e3fd6645dbdd938b

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


