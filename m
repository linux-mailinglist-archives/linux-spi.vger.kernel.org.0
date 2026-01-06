Return-Path: <linux-spi+bounces-12198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F5CCFAC23
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 20:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A72D30186A2
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 19:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2082D641C;
	Tue,  6 Jan 2026 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1oloWF2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030F2C11CA;
	Tue,  6 Jan 2026 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728553; cv=none; b=Nfaou/17bO4B5Iapk+uOY2pMUWRhCbS+Iv2XmNhsmBELthxscRC2S786c8F8RARclTw6yvrTaLaOTanAfbxtkt3BFK1vpZSXfJte576+BVegP9F72APqbVi3ldQVOWEW2YrzWVQ1Y8XjePzBZzby8JNm+rcCpN2gUjvvMqGbDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728553; c=relaxed/simple;
	bh=s+1JedlIyWeQqbDvglfgq6oP3kT0MW4kLflc5hfg6E0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qWNBKPGDWKhzUJeQyShL2J8n8B2iwWxeh/OcTAMv8uqiISH4ypClqUGctS/cllazlq3/weQXM8YAyn8FqcOoJ3nZ5dg49HPoe/gp0xsw8SC3+eh/HZZfhnz7lKfG6rcIcNpR7v5zmGHzejKkl78y4MQsJPQK2YNHHvXvaoSPmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1oloWF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E92C19422;
	Tue,  6 Jan 2026 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767728553;
	bh=s+1JedlIyWeQqbDvglfgq6oP3kT0MW4kLflc5hfg6E0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B1oloWF2QRAYBT24LurkPclFX8FBgMjCnDDwa6f/qv+XyNFyULTFn8d5TisBXnXDR
	 HDj5Nds9SgH4a6LWjtt+B+5rR4jpqActkBtTLLEZwvAQHBvMZMO7jEDlDdSRzJhFyu
	 v7g69obHF/EpvjxP/EUhkJYSgK1aBHQvbxw7R+FaW1yvBxLACFPxO0+lEMzROF4V51
	 TBdXG+ag6L1uUsLs1oFtYiKXky5wwIvU/lWg+9cSksZmPb2p0c2j0plNmiAubiSTWN
	 yq3pPlZddZ2uh4spsHBce1u2VV2Kz4C7xVShR3ygXSxfgMPyAKo15mS5gWuqcFw4fi
	 ST/ZY/qOwmLaw==
From: Mark Brown <broonie@kernel.org>
To: cezary.rojewski@intel.com, lgirdwood@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, 
 Oder Chiou <oder_chiou@realtek.com>
Cc: linux-spi@vger.kernel.org, perex@perex.cz, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org, flove@realtek.com, 
 shumingf@realtek.com, jack.yu@realtek.com, derek.fang@realtek.com
In-Reply-To: <cover.1767148150.git.oder_chiou@realtek.com>
References: <cover.1767148150.git.oder_chiou@realtek.com>
Subject: Re: [PATCH v11 0/4] ASoC: rt5575: Add the codec driver for the
 ALC5575
Message-Id: <176772855067.328192.13240221041944953554.b4-ty@kernel.org>
Date: Tue, 06 Jan 2026 19:42:30 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 31 Dec 2025 10:35:01 +0800, Oder Chiou wrote:
> This patch series adds support for the Realtek ALC5575 audio codec.
> 
> Changes in v11:
> - Patch 1/4:
>   - minor fixes
> - Patch 2/4:
>   - change of_find_spi_controller_by_node() gating to CONFIG_OF
> - Patch 3/4:
>   - nothing
> - Patch 4/4:
>   - achieve reverse-christmas-tree notation
>   - remove formal version check
>   - revise check whether the firmware boots from SPI or not
>   - minor fixes
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] spi: export of_find_spi_controller_by_node()
      commit: ee69f55eb183efb43da14cdad72910b1b1cc2932
[2/4] spi: change of_find_spi_controller_by_node() gating to CONFIG_OF
      commit: 037f8d896688bf3384eb6bf34e24e8fbc9f6e02d
[3/4] ASoC: dt-bindings: realtek,rt5575: add support for ALC5575
      commit: af4c0b951b18a8af73fa8541fabf1bf2484bba9b
[4/4] ASoC: rt5575: Add the codec driver for the ALC5575
      commit: c7ac7499ac5bb50ab3e00add121822c5c904bc91

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


