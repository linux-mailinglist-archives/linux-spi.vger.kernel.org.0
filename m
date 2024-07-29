Return-Path: <linux-spi+bounces-4062-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D5493FACD
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8F92880DA
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19E718C353;
	Mon, 29 Jul 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJirTyCb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED518C350
	for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270095; cv=none; b=XmWLKNEZQjCcHxzQiN53xIQWjyEV2UK9vgty/5NAk3Oz0m58BiGAxVXECmn4uJ839PEfzFJk14r4TtLyPfjcSCPhajLKSDdsRhuJfyRP30a1hm0dvb9+zF1Ine37PYDleOi2VRkIea0ciH6cDRWtc3nzdv6Vfa14bCN9miYZwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270095; c=relaxed/simple;
	bh=nWwl05WMZXtwKMj9OkgNnr2vWOt63UuHvtU+ImQWV8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LoqDvIU6ZNXC5eXrM0H/PSnfGqngnH9B3lQ04IG3SPwx911cJTu6OXuLTZ9gQ0xll8reTpLOJoqEE+3PU4Nf6+lKD0x5jsmC09nIs2IrLuJQdhgIWoiXis69DoHDh1/EkW/HpTes1dIvHl7lrUyeRMw/Y2C4ap/gD7mPhkObgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJirTyCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F19B5C4AF09;
	Mon, 29 Jul 2024 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722270095;
	bh=nWwl05WMZXtwKMj9OkgNnr2vWOt63UuHvtU+ImQWV8I=;
	h=Subject:From:Date:To:From;
	b=BJirTyCbpYD4z8SAhq0oLqzypAhDi73R+aw9VR+xUXANpjJu/xN1kWew1OcJhXs0r
	 GPqx/LwPUGHahESIKkmmtCRow6C7bONNWxRwG0UI5IFTfalgx+NfdgBm3XcX2TKwRV
	 xaThDg6gJ8qnNEgLa107WbqxhdgI2bQkbFLr2Ai0YlY4W6Tjs0gV3PqOn+gP5vYiVo
	 YX7IEImSYXisKkxzOksmkznMB62Re7whsBcaq1A2Mqh6WkSGUO4WJadkn2Y7baVXi0
	 oLSSbJTU6AmsdvW+jRImI8TBRM2bmzfpiGUJer8/gtsjibt+w6YPiWjjhIMBleRUWa
	 2aTXUggj5KIqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB403C43445;
	Mon, 29 Jul 2024 16:21:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <172227009482.3603.6798727426826334490.git-patchwork-summary@kernel.org>
Date: Mon, 29 Jul 2024 16:21:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: add devm_spi_optimize_message() helper
  Submitter: David Lechner <dlechner@baylibre.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=865059
  Lore link: https://lore.kernel.org/r/20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com
    Patches: [v3,1/2] spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
             [v3,2/2] iio: adc: ad7944: use devm_spi_optimize_message()

Patch: [v4] spi: ppc4xx: handle irq_of_parse_and_map() errors
  Submitter: Ma Ke <make24@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=873470
  Lore link: https://lore.kernel.org/r/20240724084047.1506084-1-make24@iscas.ac.cn

Series: ARM: dts: aspeed: Add IBM P11 BMC systems
  Submitter: Eddie James <eajames@linux.ibm.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=855116
  Lore link: https://lore.kernel.org/r/20240522192524.3286237-1-eajames@linux.ibm.com
    Patches: [v6,01/20] spi: dt-bindings: Document the IBM FSI-attached SPI controller
             [v6,02/20] dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
             [v6,03/20] dt-bindings: fsi: Document the IBM SCOM engine
             [v6,04/20] dt-bindings: fsi: p9-occ: Convert to json-schema
             [v6,05/20] dt-bindings: fsi: Document the IBM SBEFIFO engine
             [v6,06/20] dt-bindings: fsi: Document the FSI controller common properties
             [v6,07/20] dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
             [v6,08/20] dt-bindings: fsi: ast2600-fsi-master: Convert to json-schema
             [v6,09/20] dt-bindings: fsi: Document the AST2700 FSI controller
             [v6,10/20] dt-bindings: fsi: Document the FSI Hub Controller
             [v6,11/20] dt-bindings: i2c: i2c-fsi: Convert to json-schema

Patch: spi: meson-spicc: convert comma to semicolon
  Submitter: Chen Ni <nichen@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=871627
  Lore link: https://lore.kernel.org/r/20240716091151.1434450-1-nichen@iscas.ac.cn

Series: [1/2] dt-bindings: spi: mediatek,spi-mt65xx: add compatible for MT7981
  Submitter: Rafał Miłecki <zajec5@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=874245
  Lore link: https://lore.kernel.org/r/20240727114828.29558-1-zajec5@gmail.com
    Patches: [1/2] dt-bindings: spi: mediatek,spi-mt65xx: add compatible for MT7981

Series: spi: fsl-dspi: Convert to yaml format and use common SPI property
  Submitter: Frank Li <Frank.Li@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=865031
  Lore link: https://lore.kernel.org/r/20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com
    Patches: [v4,1/3] spi: fsl-dspi: use common proptery 'spi-cs-setup(hold)-delay-ns'
             [v4,3/3] arm64: dts: fsl-ls1043a-rdb: use common spi-cs-setup(hold)-delay-ns

Series: amlogic SoC's power-domains fixes
  Submitter: George Stark <gnstark@salutedevices.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=869411
  Lore link: https://lore.kernel.org/r/20240708194808.1819185-1-gnstark@salutedevices.com
    Patches: [1/4] dt-bindings: spi: amlogic,a1-spifc: make power-domains required
             [2/4] dt-bindings: i2c: amlogic,meson6-i2c: add optional power-domains

Patch: [v2] dt-bindings: drop stale Anson Huang from maintainers
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Rob Herring (Arm) <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=862482
  Lore link: https://lore.kernel.org/r/20240617065828.9531-1-krzysztof.kozlowski@linaro.org

Series: mmc-spi - support controllers incapable of getting as low as 400KHz
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Ulf Hansson <ulf.hansson@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=861262
  Lore link: https://lore.kernel.org/r/20240612-brigade-shell-1f626e7e592f@spud
    Patches: [RFC,v1,1/3] mmc: mmc_spi: allow for spi controllers incapable of getting as low as 400k

Patch: spi: axi-spi-engine: don't emit XFER_BITS for empty xfer
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=873341
  Lore link: https://lore.kernel.org/r/20240723-spi-axi-spi-engine-opt-bpw-v1-1-2625ba4c4387@baylibre.com

Patch: spi: spi-mt65xx: Use threaded interrupt for non-SPIMEM transfer
  Submitter: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=874072
  Lore link: https://lore.kernel.org/r/20240726114721.142196-1-angelogioacchino.delregno@collabora.com


Total patches: 24

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



