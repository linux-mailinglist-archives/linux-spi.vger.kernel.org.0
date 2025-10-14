Return-Path: <linux-spi+bounces-10621-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A77BD915F
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 13:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BED4404308
	for <lists+linux-spi@lfdr.de>; Tue, 14 Oct 2025 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9FE30FC34;
	Tue, 14 Oct 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twOYcKVX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868832FD1A1
	for <linux-spi@vger.kernel.org>; Tue, 14 Oct 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442377; cv=none; b=B44AlXwLmuBasdVGCOWN8tLi0ZK2mNTx+OlwVRdEefCQS9U2V4TuwLSVwbF+Z9yxCqd7/7//fUthrGag2zfILA5hG45jjps7JIbr1oFKg0NVJfxGK9qX4MbflNwKG6yvZ6iD/CRPQXeEoitOlYMRNeCWlzCG8YETGgYz9X9o/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442377; c=relaxed/simple;
	bh=4xPknCQ8O+E8lAfgJ3sTg4DNxoF4xostKyMRMqDwnOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HQPx5BeeOAkjzJrPgFygWc2sA4lu/prYODo/aCJ/30x8g2RZnX3sq5zkO4YClc7C3EC8BUakslo04Km6P8gkI/J2DGFK9AkN0lNOxuryx4e36248DAR7u5l/5xpZkbZjFwte/T+D7uSWUatC4NakiOP5wh/jTZGpaue3eMLKuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twOYcKVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08128C4CEE7;
	Tue, 14 Oct 2025 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760442377;
	bh=4xPknCQ8O+E8lAfgJ3sTg4DNxoF4xostKyMRMqDwnOo=;
	h=Subject:From:Date:To:From;
	b=twOYcKVXm1gGIjdLmzezQ6hHgUDG04OqyKj3l/4ki5sg+pin7KQw8x3PvlNHfVzJD
	 DAuYgcrxSTlt6tKol+JWjfx6tPW22fL0yShnLERhSPoSs4I0JYurZxdaRsJbaLK+9r
	 8Oa7t4ZiKEzZ3edlSWLjzqIaMaVvzh+X0bwv0NKLzw9B2SlTx2LXTU404cdrcdzNGU
	 sOOCEyFK/CuJMLX4dG5ZT8AYnJMKTPGxU3/3F+LqNHbv6pxp6VVuj2H6qPvJIt2RKk
	 0ODGXXxvBntMk72YYsua//jWY60nNuvBbPgXBjNj8ZEU9IQZh3Y/LLalTsuk8NVDsv
	 QsZkgqodVWyvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74CD0380AA4F;
	Tue, 14 Oct 2025 11:46:03 +0000 (UTC)
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
 <176044236204.3633772.12655591508717605986.git-patchwork-summary@kernel.org>
Date: Tue, 14 Oct 2025 11:46:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: arm64: Add initial device trees for Apple M2 Pro/Max/Ultra devices
  Submitter: Janne Grunau <j@jannau.net>
  Committer: Sven Peter <sven@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=996529
  Lore link: https://lore.kernel.org/r/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net
    Patches: [01/37] dt-bindings: arm: apple: Add t6020x compatibles
             [02/37] dt-bindings: arm: apple: apple,pmgr: Add t6020-pmgr compatible
             [03/37] pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"
             [04/37] dt-bindings: power: apple,pmgr-pwrstate: Add t6020 compatible
             [05/37] dt-bindings: cpufreq: apple,cluster-cpufreq: Add t6020 compatible
             [06/37] dt-bindings: interrupt-controller: apple,aic2: Add apple,t6020-aic compatible
             [07/37] dt-bindings: iommu: dart: Add apple,t6020-dart compatible
             [08/37] pinctrl: apple: Add "apple,t8103-pinctrl" as compatible
             [09/37] dt-bindings: pinctrl: apple,pinctrl: Add apple,t6020-pinctrl compatible
             [10/37] dt-bindings: i2c: apple,i2c: Add apple,t6020-i2c compatible
             [11/37] dt-bindings: mailbox: apple,mailbox: Add t6020 compatible
             [12/37] dt-bindings: gpu: apple,agx: Add agx-{g14s,g14c,g14d} compatibles
             [13/37] dt-bindings: iommu: apple,sart: Add apple,t6020-sart compatible
             [16/37] dt-bindings: net: bcm4377-bluetooth: Add BCM4388 compatible
             [17/37] dt-bindings: net: bcm4329-fmac: Add BCM4388 PCI compatible
             [18/37] mfd: macsmc: Add "apple,t8103-smc" compatible
             [19/37] dt-bindings: mfd: apple,smc: Add t6020-smc compatible
             [20/37] dt-bindings: pwm: apple,s5l-fpwm: Add t6020-fpwm compatible
             [22/37] dt-bindings: spmi: apple,spmi: Add t6020-spmi compatible
             [24/37] dt-bindings: watchdog: apple,wdt: Add t6020-wdt compatible
             [26/37] dt-bindings: clock: apple,nco: Add t6020-nco compatible
             [28/37] dt-bindings: dma: apple,admac: Add t6020-admac compatible
             [29/37] ASoC: apple: mca: Add "apple,t8103-mca" compatible
             [30/37] ASoC: dt-bindings: apple,mca: Add t6020-mca compatible

Series: Add support to load QUP SE firmware from
  Submitter: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
  Committer: Bjorn Andersson <andersson@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1001188
  Lore link: https://lore.kernel.org/r/20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com
    Patches: [v7,1/6] dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties for I2C, SPI, and SERIAL bus
             [v7,2/6] soc: qcom: geni-se: Cleanup register defines and update copyright
             [v7,3/6] soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem
             [v7,4/6] i2c: qcom-geni: Load i2c qup Firmware from linux side
             [v7,5/6] spi: geni-qcom: Load spi qup Firmware from linux side
             [v7,6/6] serial: qcom-geni: Load UART qup Firmware from linux side

Series: None
  Submitter: Janne Grunau <j@jannau.net>
  Committer: Janne Grunau <j@jannau.net>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=996549
  Lore link: https://lore.kernel.org/r/20250828-dt-apple-t6020-v1-31-bb8e1b87edef@jannau.net
    Patches: [31/37] spi: apple: Add "apple,t8103-spi" compatible
             [32/37] spi: dt-bindings: apple,spi: Add t6020-spi compatible
             [33/37] arm64: dts: apple: Add ethernet0 alias for J375 template
             [35/37] arm64: dts: apple: Add J414 and J416 Macbook Pro device trees
             [36/37] arm64: dts: apple: Add J474s, J475c and J475d device trees
             [37/37] arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra, 2023) device tree

Series: arm64: lan969x: Add support for Microchip LAN969x SoC
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Committer: Nicolas Ferre <nicolas.ferre@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=991164
  Lore link: https://lore.kernel.org/r/20250813174720.540015-1-robert.marko@sartura.hr
    Patches: [v9,1/9] arm64: Add config for Microchip SoC platforms
             [v9,3/9] arm64: lan969x: Add support for Microchip LAN969x SoC
             [v9,4/9] mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
             [v9,5/9] tty: serial: atmel: make it selectable for ARCH_MICROCHIP
             [v9,6/9] spi: atmel: make it selectable for ARCH_MICROCHIP
             [v9,7/9] i2c: at91: make it selectable for ARCH_MICROCHIP
             [v9,8/9] char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
             [v9,9/9] crypto: atmel-aes: make it selectable for ARCH_MICROCHIP

Series: [v2,1/4] mtd: spinand: fix direct mapping creation sizes.
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=989538
  Lore link: https://lore.kernel.org/r/20250808210147.3085391-2-mikhail.kshevetskiy@iopsys.eu
    Patches: [v2,1/4] mtd: spinand: fix direct mapping creation sizes.

Series: mtd: spinand: fix continuous reading mode support
  Submitter: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
  Committer: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=991325
  Lore link: https://lore.kernel.org/r/20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu
    Patches: [RESEND,v2,1/4] mtd: spinand: fix direct mapping creation sizes.


Total patches: 46

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



