Return-Path: <linux-spi+bounces-8391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D139AD1F19
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 642C67A6823
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 13:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF2225CC62;
	Mon,  9 Jun 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbxQAEZ7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729125C83E;
	Mon,  9 Jun 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476447; cv=none; b=TVkr8H2T9DwP05acYH7wRfndu8U7oCPT0TbTaX+8XrglRlj5gAJY43usEr9MsYHqPZu0+Lyddvu419IfQG3muiXZZHCG7ucjaqEawSVnp7b1C59vsVO+GxAV5jK34bTQLxZnfuuXMf7jv9owJN67Z0Ew/maob8bhRrMDiQYh2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476447; c=relaxed/simple;
	bh=LikEvWObK5cLWG5kDOh8WIv3nJ7NrbLjTJ/RRELK4kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gMShugR64qeZaUq1O7wF3YLvHiSCmLLuqI0BCaxAF5R+xx8SbxyWGxMqK3Jqdo2qlmIVirHnZ3tmmT/+0i7EQ6vr0N37TeneBaTdunR6qmRqaVKEtDB1WXAXhMIxCj51blOIIR1a4G1vI3oabibA53w134WG/Km75EEPUZDO39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbxQAEZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2E5C4CEED;
	Mon,  9 Jun 2025 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476446;
	bh=LikEvWObK5cLWG5kDOh8WIv3nJ7NrbLjTJ/RRELK4kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jbxQAEZ7NNI+UWJCL+5wuwHeQk9bhLv9Y7FV2kwU8ZYrBWWkI8Sehiu+z5dX8+/Q7
	 wsYiuGLoJNXHFBsYnbR7+osZJKsO/HVVXu5LNAP+P/EuiUZDQLp8OtEy3nJO1aiCab
	 EunIHl2IMy7xrlV6y3i6cBWmsUCU4DhYaUFFTsvCAHycyYkwXcCvcE9u4ifxJspnWr
	 TKbBPGO9D9ax/aYDJVgp+jkOF9HPRiWuZkUJpvVyeBGgLMoEoUlsyJRy90aEaTf9+f
	 zP9Gc2WQ3JZQ8m4iFRl/rduCREWoI66Y8IlzpcfZG7wBZs+2atmmJjIvk/aiC8Hrro
	 gLDa4/3H4snSQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250528222821.728544-1-Frank.Li@nxp.com>
References: <20250528222821.728544-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] spi: dt-bindings: mxs-spi: allow clocks properpty
Message-Id: <174947644363.127013.4646317883893758390.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 14:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Wed, 28 May 2025 18:28:20 -0400, Frank Li wrote:
> Allow clocks property to fix below CHECK_DTB warnings:
> arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dtb: spi@80014000 (fsl,imx28-spi): Unevaluated properties are not allowed ('clocks' was unexpected)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: mxs-spi: allow clocks properpty
      commit: 6b500757aef0b5b639253508cf93eb8134a2d340

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


