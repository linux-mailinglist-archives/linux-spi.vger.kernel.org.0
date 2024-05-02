Return-Path: <linux-spi+bounces-2690-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE68B93B6
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 05:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FA2B2264A
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59B1C6A3;
	Thu,  2 May 2024 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbFEkPeN"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BA1C696;
	Thu,  2 May 2024 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622226; cv=none; b=uslT1EQeqsOc50ADsLTH92OjEY9/7/BMpRdjp2AoRxvrlgI84WPhjp87R3gDiqkR31edRE1PIi24pznjkQ+7H7+6RxE3SvrNCYBhyHi15BFFGAFpNfVgkCpgrmPdH72atMut9yuUv/jMdvlzQaSRAK1vHjoRe24hcGqQoQ7BmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622226; c=relaxed/simple;
	bh=yIoJG+hV/6XEwUMr+7mAYFvRdlG5luW/H6vUjXhxOnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XzB/9VuMiufzW+0FOLyr8qhsGkYrFGSSD550eMY8JT7DWhiIW0KCM24h7I7VX40Na2w2sK35q18KUib17KlkD92h10/AzKxDmYSxwtjQAIkplejkrbax6a5cktWSz/MYJ3J++7airxPwGJ2aQLn7G9p26NhJud8eINAQ/J/IXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbFEkPeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07D3C4AF18;
	Thu,  2 May 2024 03:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714622225;
	bh=yIoJG+hV/6XEwUMr+7mAYFvRdlG5luW/H6vUjXhxOnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JbFEkPeNNF9aHFKc4VdNRKyBtBeXiyGVsNxVXlCqGdF6K8kdiASJ8RnokFtQQPdme
	 MwEErKoTZ+BnUzja93F8gKsiT6K6ygP3UsKK9bQXxPI7EuWJWo3lsWixr7Lu6Qy99M
	 eZKR9WUsa31MVl5PN5rYxO4FZnqbgU/dV4MxVShdXqoNOhjna1je09/M/+9hfZL7/1
	 E0jDyejICyY4/6xd7afpMksqYP3u02zwe9ummQUX+KkQMm1h4wzH9fHSYAm8m5b0N0
	 QiLFX/wofDwYG0Pz8qEcgZR/NvSTFFeoPdyD00bDDTJ/lAhVrUeX7aSJj2GViAV1co
	 2ILnUWkgFGCMg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: conor@kernel.org, lorenzo.bianconi83@gmail.com, 
 linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com, 
 catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com, 
 angelogioacchino.delregno@collabora.com, andy.shevchenko@gmail.com
In-Reply-To: <cover.1714377864.git.lorenzo@kernel.org>
References: <cover.1714377864.git.lorenzo@kernel.org>
Subject: Re: (subset) [PATCH v5 0/3] Add add SPI-NAND Flash controller
 driver for EN7581
Message-Id: <171462222247.1904471.4239751803152625098.b4-ty@kernel.org>
Date: Thu, 02 May 2024 12:57:02 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 29 Apr 2024 10:13:07 +0200, Lorenzo Bianconi wrote:
> Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> found on Airoha ARM EN7581 SoCs.
> 
> Changes since v4:
> - rely on devm_platform_ioremap_resource() routine
> - rework airoha_snand_is_page_ops() routine
> Changes since v3:
> - rely on devm_kzalloc() to allocate airoha_snand_dev buffers
> - rely on dev_err_probe()
> - cosmetic rework
> Changes since v2:
> - Fix compilation warnings
> - Remove interrupt entry in dts since it is not connected so far
> Changes since v1:
> - Introduce spi clock dependency
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
      commit: 8bd0d557aa8394b75f6983b2334aaf1a633e1ce5
[3/3] spi: airoha: add SPI-NAND Flash controller driver
      commit: a403997c12019d0f82a9480207bf85985b8de5e7

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


