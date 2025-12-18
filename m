Return-Path: <linux-spi+bounces-12008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1286FCCB338
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E25173092F26
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8643328E7;
	Thu, 18 Dec 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKwYji/f"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48CD3321B9;
	Thu, 18 Dec 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766050369; cv=none; b=Kud7pKPlwt3DH8g6ppeLF/pwdlg49HvNO6FOgaeRq8p9oQmWlBbgHaLe3czmNpNa3LOo6P74UeFI4/O8R0yQPraf9WMDrbqS34GNkh0NK//8TMRtfCWpDPpSHnt7V6770Y1k9lZjiWJsct8jN9OZvoOtJPyCoHxk5/17U23ZXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766050369; c=relaxed/simple;
	bh=81UJb/tDyeaP+qvZ6Zz59Q3gkULX3YPSvT8fk2ia0Pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fcZNy1AXaukOdKtcYrIYuUWttB+lIinMq0Jl53mpiPW0ZO8Eh6iZd726/hdA7hTQ7V1n9Djebb8LB4pfNvpNUrfLvKBglUZG5YiSx/WIvTfo+NNcfClxyu/kxuH1GbFRLbHUngRlEkj2shkW5Y5oP9QpD6E4nw055pA9bYwivGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKwYji/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B31C4CEFB;
	Thu, 18 Dec 2025 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766050369;
	bh=81UJb/tDyeaP+qvZ6Zz59Q3gkULX3YPSvT8fk2ia0Pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aKwYji/f8E+1YmeQiWeg2bkwx1HWEbIxjhnET+XKiEKP4jdCqXokC70raZmnFfEAU
	 Fn936QbztgdaopG6l0bdvRHiPJaPIeYOylJtVwjNR0S/xWy+G9lRTQ9N+J9haW0P6P
	 q3VrmZWidEbQTZaA3wNmY6oX/fYl8si2eANWlxC/7ioY6gyvYmzTBWDldmq7D1vi17
	 GaoxQSt49+pR4GFUxUkZZF/tZbOcW0QOsfj1Gnrbusxsjkp4c6Ek8w/2JdxqO5ARTc
	 cMM6nTSB8OVyOPq5f6R7J5+0WyLfZkK1to9XAcjKbylBC8y9gUUmtCaQeeSg/wzQlo
	 jPQ6JqY/1JfiQ==
From: Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20251216-xspi-v7-0-282525220979@nxp.com>
References: <20251216-xspi-v7-0-282525220979@nxp.com>
Subject: Re: [PATCH v7 0/2] Add support for NXP XSPI
Message-Id: <176605036628.87569.2326741752652519619.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 09:32:46 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 16 Dec 2025 11:20:12 +0800, Haibo Chen wrote:
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

[1/2] spi: dt-bindings: nxp,imx94-xspi: Document imx94 xspi
      commit: 64ba616741bcfc4c7ef1ed856179328300ca0422
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


