Return-Path: <linux-spi+bounces-10169-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D739B8A7B7
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7FB5A0DAE
	for <lists+linux-spi@lfdr.de>; Fri, 19 Sep 2025 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6773254B18;
	Fri, 19 Sep 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMlb4A8E"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77991F4C8C;
	Fri, 19 Sep 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297810; cv=none; b=j/WHB7kljhThuVKAdbX+mMr+tIQWkwyBFdctMhWYIY5TcLpS9vz/VAUg/M5AdZ8ITS4lu3mR+0agEset77TzvK4kFEMKyaKsWscjQ4A84kABoAjF8Po4svFC+iFvt+qDXzPhV6qjfNcAq3z6umDOZA6khwLP0pODjR4l7P48Z4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297810; c=relaxed/simple;
	bh=lpomwfxtk9a4+r9bgZHNE22kfKHJ+s60q4CwLekgFe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RxT9HtE0rXc/0M2y+dan6SilHp2T5CpwohSahodkBW1pnincvjaO0hFepPCzatGzT7spuMhDnf1lAZyg53ZjLTiodzLXAg6g6s4rTYPPuWWpVyBfKL79MoQWqfyCgHgvXKDmdpDLw7mbZjN36/UwOFik6KSpIMngZx7FnJzrj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMlb4A8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36CEC4CEF1;
	Fri, 19 Sep 2025 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758297810;
	bh=lpomwfxtk9a4+r9bgZHNE22kfKHJ+s60q4CwLekgFe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gMlb4A8Egcyts/MtR5Mw8qBFv4iE/79CmfDyT5HtS+MBA+CAqAnbRrwuwchTk843f
	 MP2A/1u4QocVvOjuTfBnW5FGSoxChq53xYw4ywv5Vy92rxHo+Ogl2oADs3ienzA0Cv
	 TMYsYTeQ5GCj4ieQNAMhxKtUZmst7zb2APbrUAe5CzaddCPa4kQskDQEQue5EmpFal
	 xAgytAAzSl9cxDudQLo3FJhVxOA4Sg3t0QAnea3RIklRNn7Q4D5QMHuPQIHQIEWXF1
	 bUbDMF7tzwf7tHsIpQjCzfWexQi4O6rs9R0DQZchNfteXsShL47JjMIsbBNeIRxxGs
	 9vaGXDMsLQtEw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Dharma Balasubiramani <dharma.b@microchip.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
References: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
Subject: Re: [PATCH v2 0/5] Add QSPI support for sam9x7 and sama7d65 SoCs
Message-Id: <175829780315.161854.16031631803406215563.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 17:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Mon, 08 Sep 2025 09:44:15 +0530, Dharma Balasubiramani wrote:
> This patch series adds support for SAM9X7 and sama7d65 QSPI controller
> along with the SoC-specific capabilities.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] dt-bindings: spi: Document sam9x7 QSPI
      commit: 68f6b403ee90293b6fa4eb094dcee79138b692b2
[2/5] dt-bindings: spi: Define sama7d65 QSPI
      commit: f3837edc05c66de0104041d3f300524773b46526
[3/5] spi: atmel-quadspi: add padcalib, 2xgclk, and dllon capabilities
      commit: 86d074921e34db6daaa7ea2976b1dfe7d507309b
[4/5] spi: atmel-quadspi: add support for SAM9X7 QSPI controller
      commit: 65a977d752d72a53d16ce32b85ef9db9b0747df6
[5/5] spi: atmel-quadspi: Add support for sama7d65 QSPI
      commit: 20253f806818e9a1657a832ebcf4141d0a08c02a

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


