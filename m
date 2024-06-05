Return-Path: <linux-spi+bounces-3315-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA88FD94B
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C801C25652
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B47E15F336;
	Wed,  5 Jun 2024 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKTC+5FH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848D17559
	for <linux-spi@vger.kernel.org>; Wed,  5 Jun 2024 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623665; cv=none; b=ub0cHFzBmZ5d71ZwT2ojcvHeQn2zfH7BB4bELOhBSOIHfD5PYAETfEQYQEqnqP503jzrfqMgANvypOeaq1jLxfhASIffp7SG4KVIjyp1DeuF8x+8aiZ4Vj0N9JOpb1G07ptrSfieAZKCBr06PgG48yLb5xvzOGCYZeerjrY2l2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623665; c=relaxed/simple;
	bh=M7s6zEj/QGYu7H+267KxxM7rIQ5yyImE7kFcAjtWJ78=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YLkUIlScYDNU7M6QGwxQDjn9jQbzlptUHCRPX6Iae2wE0l6SH2axdk4NvqUzP3iKC+6KwcMbHLW7LDsBWkspTrFs5ziUCoy+kAEsHEEol2BmxM8W1r6lbQrHeQkN96erJYhzcZUzkxE+zP9hvrRJ0kcKgVzkYvQXFbv2ryhHi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKTC+5FH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB326C2BD11;
	Wed,  5 Jun 2024 21:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623665;
	bh=M7s6zEj/QGYu7H+267KxxM7rIQ5yyImE7kFcAjtWJ78=;
	h=Subject:From:Date:To:From;
	b=oKTC+5FH/Q5wtI5HCXY/YKZov5dBu/ocAYXoMejG/dl6NTnALaFrcXnwn4pe+6idn
	 vEv03fzl3DBBnPp5eSeJMeOkQflKmBZzOCbjVI1J2fFBdK/4yz1GKelrXYuhxg+vwH
	 MqbOEnyNeEWQUxpzv3eQNETnbp3eNgXPGmLUBbjhMTHpFZaPrxQQMLkCI1bKkWotnp
	 dhK9XpPxzObp+u/H1avtsID9NNg8LpnKA2fNpmaZQiqzI61uMs3FCOXkP1pNJCVdj7
	 xgEtv2lC4VelHqcCxl91JtXIrlpD+uz3Iy/pOVzEf5Calf3O17OL48tqLMLVHyBVoF
	 kz+dzyysk4H2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 988B9C4332C;
	Wed,  5 Jun 2024 21:41:05 +0000 (UTC)
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
 <171762366550.29817.7586483773113314683.git-patchwork-summary@kernel.org>
Date: Wed, 05 Jun 2024 21:41:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add optional reset control for Cadence SPI
  Submitter: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=851434
  Lore link: https://lore.kernel.org/r/20240508054728.1751162-1-jisheng.teoh@starfivetech.com
    Patches: [v3,1/2] spi: spi-cadence: Add optional reset control support
             [v3,2/2] dt-bindings: spi: spi-cadence: Add optional reset control

Series: spi: pxa2xx: Get rid of an additional layer in PCI driver
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=857406
  Lore link: https://lore.kernel.org/r/20240530151117.1130792-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,01/11] spi: pxa2xx: Wrap pxa_ssp_request() to be device managed resource
             [v2,02/11] spi: pxa2xx: Reorganize the SSP type retrieval
             [v2,03/11] spi: pxa2xx: Remove no more needed driver data
             [v2,04/11] spi: pxa2xx: Remove hard coded number of chip select pins
             [v2,05/11] spi: pxa2xx: Utilise temporary variable for struct device
             [v2,06/11] spi: pxa2xx: Print DMA burst size only when DMA is enabled
             [v2,07/11] spi: pxa2xx: Remove duplicate check
             [v2,08/11] spi: pxa2xx: Remove superflous check for Intel Atom SoCs
             [v2,09/11] spi: pxa2xx: Extract pxa2xx_spi_platform_*() callbacks
             [v2,10/11] spi: pxa2xx: Move platform driver to a separate file
             [v2,11/11] spi: pxa2xx: Convert PCI driver to use spi-pxa2xx code directly

Patch: spi: axi-spi-engine: Add SPI_CS_HIGH support
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=851638
  Lore link: https://lore.kernel.org/r/20240508-spi-axi-spi-engine-add-spi_cs_high-support-v1-1-695dd8e45f00@baylibre.com

Series: spi: gpio: Convert to be used outside of OF
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=854094
  Lore link: https://lore.kernel.org/r/20240517194246.747427-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/3] spi: gpio: Make use of device properties
             [v1,2/3] spi: gpio: Use traditional pattern when checking error codes

Patch: spi: atmel-quadspi: Add missing check for clk_prepare
  Submitter: Chen Ni <nichen@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=853336
  Lore link: https://lore.kernel.org/r/20240515084028.3210406-1-nichen@iscas.ac.cn

Series: spi: differentiate between unsupported and invalid requests
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=855071
  Lore link: https://lore.kernel.org/r/20240522145255.995778-1-miquel.raynal@bootlin.com
    Patches: [1/4] spi: dw: differentiate between unsupported and invalid requests
             [2/4] spi: mxic: differentiate between unsupported and invalid requests
             [3/4] spi: rpc-if: differentiate between unsupported and invalid requests
             [4/4] spi: wpcm-fiu: differentiate between unsupported and invalid requests

Series: spi: bitbang: Clean up the driver
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=854093
  Lore link: https://lore.kernel.org/r/20240517194104.747328-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/3] spi: bitbang: Use typedef for txrx_*() callbacks
             [v1,2/3] spi: bitbang: Convert unsigned to unsigned int
             [v1,3/3] spi: bitbang: Replace hard coded number of SPI modes

Patch: spi: dt-bindings: marvell,mmp2-ssp: Merge PXA SSP into schema
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=855048
  Lore link: https://lore.kernel.org/r/20240522132859.3146335-1-robh@kernel.org

Patch: [v1,1/1] spi: Refactor spi_stop_queue()
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=852405
  Lore link: https://lore.kernel.org/r/20240510204945.2581944-1-andriy.shevchenko@linux.intel.com

Series: Add support for GPIO based CS
  Submitter: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=853081
  Lore link: https://lore.kernel.org/r/20240514104508.938448-1-prajna.rajendrakumar@microchip.com
    Patches: [v2,1/3] spi: dt-bindings: Add num-cs property for mpfs-spi
             [v2,2/3] spi: spi-microchip-core: Fix the number of chip selects supported
             [v2,3/3] spi: spi-microchip-core: Add support for GPIO based CS

Patch: [v1,1/1] spi: Replace custom code with device_match_acpi_handle()
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=852406
  Lore link: https://lore.kernel.org/r/20240510204952.2582093-1-andriy.shevchenko@linux.intel.com

Patch: spi: imx: remove empty cleanup function
  Submitter: Martin Kaiser <martin@kaiser.cx>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=854462
  Lore link: https://lore.kernel.org/r/20240520165906.164906-1-martin@kaiser.cx

Series: ARM: dts: aspeed: Add IBM P11 BMC Boards
  Submitter: Eddie James <eajames@linux.ibm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=849047
  Lore link: https://lore.kernel.org/r/20240429210131.373487-1-eajames@linux.ibm.com
    Patches: [v4,01/17] spi: dt-bindings: Document the IBM FSI-attached SPI controller

Patch: [v5] spi: dt-bindings: Document the IBM FSI-attached SPI controller
  Submitter: Eddie James <eajames@linux.ibm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=853212
  Lore link: https://lore.kernel.org/r/20240514192630.152747-1-eajames@linux.ibm.com

Series: ARM: dts: aspeed: Add IBM P11 BMC systems
  Submitter: Eddie James <eajames@linux.ibm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=855116
  Lore link: https://lore.kernel.org/r/20240522192524.3286237-1-eajames@linux.ibm.com
    Patches: [v6,01/20] spi: dt-bindings: Document the IBM FSI-attached SPI controller

Patch: [RESEND,v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema
  Submitter: Kanak Shilledar <kanakshilledar@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=858360
  Lore link: https://lore.kernel.org/r/20240603173028.2787-1-kanakshilledar111@protonmail.com


Total patches: 35

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



