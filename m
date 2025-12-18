Return-Path: <linux-spi+bounces-12006-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8DBCCB39C
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CA0F3020C1D
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10173314D9;
	Thu, 18 Dec 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLIEAvyP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE842EC0B4;
	Thu, 18 Dec 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050364; cv=none; b=CuEWL0sVAP/w0Vglq8xgxRzj4b4Rv2YF3QrforMraZsDwC3UwumUrQOtoRRcbDj2wEuXcrBTMq8GQOGT/QKBeoeBS2aYB+oV7ngDtF26RtMNmxpS/HZvPWN13adZtPba0kBwpjKj+LR+qpKgzb9iP0yAlviIvqmMCIVnuHjN3Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050364; c=relaxed/simple;
	bh=TvHwwQh6QW4aMRcWQ0xejXsyZkwHJK10UZAYUX2ZWVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s93yyTS9dLEw3eutnCfXnIc+py3cK0wqMu4g+6H97iOzWppLvkFY2xo2uXNt6d+X/yFpGqHPfl52CFAMxEM7wb4qEoIH7k+eyjmUVscHn6/OZj5d1vP5j6521bywRIUpkCJ+b7ZeS2fHjXUMo4yphTLlmNk2xTvghOiBoK8J5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLIEAvyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0578FC4CEFB;
	Thu, 18 Dec 2025 09:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766050363;
	bh=TvHwwQh6QW4aMRcWQ0xejXsyZkwHJK10UZAYUX2ZWVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZLIEAvyPipdJbsBGy8cdMYXrr+LjCydIMGF+AMTjoGbum7dacm37sXvo0MiE0x3Z3
	 PBIlaWia7FRplfd3b5HxBmewAdyFUzXy8AWbkl+4W7twqaPpvjEmZ29TbAZilzjdtC
	 YOSeb7v6uBbZPf5bV5FYctGUc1awZIGNbf4yRT6wY/FrNPvj3yKprzwIZPQdOFzbss
	 9JDjzAy0xQA/lUPScQ7p09LgHPAoJBP5iGCexexKYmjKftsz0W+3Olkkx9322L6M46
	 xmCRPp783WICs2aGFINFPH6AadisFLEEEYbB1DmcMtOKHUin0Eo0tflH6su3VK2WlM
	 qclOYFuoZeeig==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
References: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
Subject: Re: [PATCH v6 0/2] Add support for NXP XSPI
Message-Id: <176605036072.87569.17728068603081639345.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 09:32:40 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 25 Nov 2025 15:42:17 +0800, Haibo Chen wrote:
> XSPI is a flexible SPI host controller which supports up to
> 2 external devices (2 CS). It support Single/Dual/Quad/Octal
> mode data transfer.
> 
> The difference between XSPI and Flexspi is XSPI support
> multiple independent execution environments (EENVs) for HW
> virtualization with some limitations. Each EENV has its own
> interrupt and its own set of programming registers that exists
> in a specific offset range in the XSPI memory map.
> The main environment (EENV0) address space contains all of the
> registers for controlling EENV0 plus all of the general XSPI
> control and programming registers. The register mnemonics for
> the user environments (EENV1 to EENV4) have "_SUB_n" appended
> to the mnemonic for the corresponding main-environment register.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] dt-bindings: spi: Document imx94 xspi
      (no commit info)
[2/2] spi: add driver for NXP XSPI controller
      commit: 29c8c00d9f9db5fb659b6f05f9e8964afc13f3e2

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


