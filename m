Return-Path: <linux-spi+bounces-5876-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C639E0413
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 14:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F11F281E01
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D73201261;
	Mon,  2 Dec 2024 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKuG7Dax"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2239AD5E
	for <linux-spi@vger.kernel.org>; Mon,  2 Dec 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147703; cv=none; b=i9tiBwI0laPYEOGV+5p2KFyjtRjC7gA7ZV/o13kAODQTThvMmvqhHB4C4HeUwdfKtmfAxP3e0k6CYElpz9Ksot0B2a7Vyz4QaUWswrEjZdwZul7AHXCamGPdGyDMLsOF2aH4weykS90seU5rHW3dogMBm2+e8v7Qlg8HmYa3Xhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147703; c=relaxed/simple;
	bh=PRLSxjdo4N0IUPm9o4lhV5Sg/ABiC7er5dXPTSgG95E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=p1wVmehovEGAC/oPF8IPfWkShvoqJXDHjHlFkWs6BA2MkP6TCn4clanThJX2BdRqeONNRqtLXPSip/UAqBaq1bPF0NNz2hQitLkMW7/q27vlYj8DuxNn3GR21sjsqPCOhYzp8oHS9kvnl7VYGpyjCrgGZmH2cMj7XSpJGZhoGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKuG7Dax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EFFC4CED1;
	Mon,  2 Dec 2024 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733147703;
	bh=PRLSxjdo4N0IUPm9o4lhV5Sg/ABiC7er5dXPTSgG95E=;
	h=Subject:From:Date:To:From;
	b=HKuG7Dax7g54GYPAzj6aPBSROkoFeZ9ZL4SZPzRYYk86PecfzLOtOyCdsr1/L7GuJ
	 mNxhVw2bA9zFcBuYZ+FgSKZTa+eSnPABNmt0dgDYBbwCErA0QLW7CcNwMIGxGLRO9y
	 ButhYHjLvpQuOFo0B1bToBhxHCZUMU4jBpd9LYg0AWYugnCbqeJbKovgVdgGG0OBJ1
	 rFA0g/hW+joelKcdORkLxfVVbvP4pLgV6PLjhwzHHJ7NjDUOKRnUokYdvcaTvSNz7b
	 jDPJR4CopWhtPrtwI4X4SoPu0ncWNbipkUBMbQv9v59zygBWEXzqBT8lXK+MCpFiwl
	 Pm3j0SeIeUbUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B31EA3806656;
	Mon,  2 Dec 2024 13:55:18 +0000 (UTC)
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
 <173314771737.3602614.13153410902451799245.git-patchwork-summary@kernel.org>
Date: Mon, 02 Dec 2024 13:55:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add device tree for ArmSoM Sige 5 board
  Submitter: Detlev Casanova <detlev.casanova@collabora.com>
  Committer: Heiko Stuebner <heiko@sntech.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=886371
  Lore link: https://lore.kernel.org/r/20240903152308.13565-1-detlev.casanova@collabora.com
    Patches: [v4,1/9] dt-bindings: arm: rockchip: Add ArmSoM Sige 5
             [v4,4/9] dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3576
             [v4,5/9] dt-bindings: gpu: Add rockchip,rk3576-mali compatible
             [v4,8/9] arm64: dts: rockchip: Add rk3576 SoC base DT
             [v4,9/9] arm64: dts: rockchip: Add rk3576-armsom-sige5 board

Patch: mtd: spinand: Constify struct nand_ecc_engine_ops
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=900869
  Lore link: https://lore.kernel.org/r/72597e9de2320a4109be2112e696399592edacd4.1729271136.git.christophe.jaillet@wanadoo.fr

Patch: [GIT,PULL] mtd: spi-nor: changes for v6.13
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=908774
  Lore link: https://lore.kernel.org/r/2d182f21-9766-4c05-8b97-786af69666a0@linaro.org

Series: Add octal DTR support for Macronix flash
  Submitter: Alvin Zhou <alvinzhou.tw@gmail.com>
  Committer: Tudor Ambarus <tudor.ambarus@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=893170
  Lore link: https://lore.kernel.org/r/20240926141956.2386374-1-alvinzhou.tw@gmail.com
    Patches: [v10,1/6] mtd: spi-nor: add Octal DTR support for Macronix flash
             [v10,2/6] spi: spi-mem: Allow specifying the byte order in Octal DTR mode
             [v10,3/6] mtd: spi-nor: core: Allow specifying the byte order in Octal DTR mode
             [v10,4/6] mtd: spi-nor: sfdp: Get the 8D-8D-8D byte order from BFPT
             [v10,5/6] spi: mxic: Add support for swapping byte
             [v10,6/6] mtd: spi-nor: add support for Macronix Octal flash

Patch: spi: apple: Set use_gpio_descriptors to true
  Submitter: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=912932
  Lore link: https://lore.kernel.org/r/20241127-gpio-descs-v1-1-c586b518a7d5@gmail.com

Series: arm64: dts: exynos8895: Add cmu, mct, serial_0/1 and spi_0/1
  Submitter: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
  Committer: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=901145
  Lore link: https://lore.kernel.org/r/20241020182121.377969-1-ivo.ivanov.ivanov1@gmail.com
    Patches: [v1,1/6] dt-bindings: timer: exynos4210-mct: Add samsung,exynos8895-mct compatible
             [v1,4/6] arm64: dts: exynos8895: Add Multi Core Timer (MCT) node
             [v1,6/6] arm64: dts: exynos8895: Add spi_0/1 nodes

Series: few clean up for flexspi driver on imx8ulp and imx8mp
  Submitter: Bough Chen <haibo.chen@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=886758
  Lore link: https://lore.kernel.org/r/20240904111727.1834935-1-haibo.chen@nxp.com
    Patches: [1/6] dt-bindings: spi: nxp-fspi: adjust imx8mp to compatible with imx8mm
             [6/6] arm64: dts: imx8ulp: correct the flexspi compatible string

Series: fix the flexspi error on imx8ulp
  Submitter: Bough Chen <haibo.chen@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=887164
  Lore link: https://lore.kernel.org/r/20240905094338.1986871-1-haibo.chen@nxp.com
    Patches: [v3,1/4] dt-bindings: spi: nxp-fspi: add imx8ulp support
             [v3,4/4] arm64: dts: imx8ulp: correct the flexspi compatible string

Patch: spi: mpc52xx: Add cancel_work_sync before module remove
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=913018
  Lore link: https://lore.kernel.org/r/1f16f8ae0e50ca9adb1dc849bf2ac65a40c9ceb9.1732783000.git.xiaopei01@kylinos.cn

Series: Realtek SPI-NAND controller
  Submitter: Chris Packham <chris.packham@alliedtelesis.co.nz>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=899533
  Lore link: https://lore.kernel.org/r/20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz
    Patches: [v5,1/3] dt-bindings: spi: Add realtek,rtl9301-snand
             [v5,2/3] mips: dts: realtek: Add SPI NAND controller

Patch: [1/1] MAINTAINERS: Add an entry for the LJCA drivers
  Submitter: Sakari Ailus <sakari.ailus@linux.intel.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=898100
  Lore link: https://lore.kernel.org/r/20241011070414.3124-1-sakari.ailus@linux.intel.com


Total patches: 25

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



