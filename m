Return-Path: <linux-spi+bounces-5057-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9898AEEE
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFF11C20B58
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908C17C7B6;
	Mon, 30 Sep 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDndvVTO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BF91A0B0E
	for <linux-spi@vger.kernel.org>; Mon, 30 Sep 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727731173; cv=none; b=RoW0l8P2rqkQ1cDJT1shsS20Gj4m+4SbtzPrgA1qqJ4qxFu9iDshIqp/2A7ya1LB3HxJSugbYR9iBzrPWzK0u75Usfn+eeiD+6lCgWI+YG8lP3AjHAqOEKZ2Srq7lYcTced6AKKyNyQKv0mjTTUXk06oS/olnX3xUKHkHw3vIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727731173; c=relaxed/simple;
	bh=yt8pE2br/hRT+KEaLgUqBQeR4D2CdyMNKP01Yhqp9Og=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oC56fgh1Of0j/PD4pTVYm376EVDP7HuaF0qr0SbE6KKg2mOnPne4HlF1WQgwZ2cwq6hx5SGhFjuOpLEniJkwhi7pgYfCfn1iIu7YbgaZOF93RipVB3iWolTBYEltrtg6AawujnZm9jO9rytBfo3VYswejU72D1h1EEUWuVHaxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDndvVTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649D5C4CEC7;
	Mon, 30 Sep 2024 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727731170;
	bh=yt8pE2br/hRT+KEaLgUqBQeR4D2CdyMNKP01Yhqp9Og=;
	h=Subject:From:Date:To:From;
	b=qDndvVTOBDse4hujS6buv0a31J+1CcLYPM4HNwuQ9E5DlaFHHVqDs7NpPl0Kj5QgC
	 klqVAvtfOYXEhgyBBgG2z/7tQt/9HuPuG3y4WGAlUL479boYLpkTuECyMGZxyJrn6q
	 POU2AifcjggaODtlshKVUERNC1DN8DBDj26AvYaachKqKmRT/GgDNLNAhi+ApM+Ba/
	 Lvu/bTf83/CnrEDDUY2QQkqM22pf9L+1p5MZi0hRb2S45QXjp0ppDYVBwCBC5bxmIZ
	 afZXYfX0m963sAzbhK/Ijyl7cXHPtpLPh/6DuABTiTSwSStmZKKhRrUJuBEuEGeVSa
	 Fx8WeeSrosXtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 779723804CB9;
	Mon, 30 Sep 2024 21:19:34 +0000 (UTC)
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
 <172773117297.3924256.8396416356099476839.git-patchwork-summary@kernel.org>
Date: Mon, 30 Sep 2024 21:19:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add device tree for ArmSoM Sige 5 board
  Submitter: Detlev Casanova <detlev.casanova@collabora.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=886371
  Lore link: https://lore.kernel.org/r/20240903152308.13565-1-detlev.casanova@collabora.com
    Patches: [v4,1/9] dt-bindings: arm: rockchip: Add ArmSoM Sige 5
             [v4,2/9] dt-bindings: arm: rockchip: Add rk3576 compatible string to pmu.yaml
             [v4,3/9] dt-bindings: i2c: i2c-rk3x: Add rk3576 compatible
             [v4,6/9] dt-bindings: watchdog: Add rockchip,rk3576-wdt compatible

Series: [v2,01/21] dt-bindings: arm: qcom: add the SoC ID for SA8255P
  Submitter: Nikunj Kela <quic_nkela@quicinc.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=886493
  Lore link: https://lore.kernel.org/r/20240903220240.2594102-2-quic_nkela@quicinc.com
    Patches: [v2,01/21] dt-bindings: arm: qcom: add the SoC ID for SA8255P
             [v2,05/21] dt-bindings: mailbox: qcom-ipcc: document the support for SA8255p
             [v2,06/21] dt-bindings: watchdog: qcom-wdt: document support on SA8255p
             [v2,07/21] dt-bindings: crypto: qcom,prng: document support for SA8255p
             [v2,08/21] dt-bindings: interrupt-controller: qcom-pdc: document support for SA8255p
             [v2,10/21] dt-bindings: arm-smmu: document the support on SA8255p
             [v2,12/21] dt-bindings: thermal: tsens: document support on SA8255p
             [v2,20/21] dt-bindings: arm: GIC: add ESPI and EPPI specifiers

Series: arm64: qcom: Introduce SA8255p Ride platform
  Submitter: Nikunj Kela <quic_nkela@quicinc.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=884459
  Lore link: https://lore.kernel.org/r/20240828203721.2751904-1-quic_nkela@quicinc.com
    Patches: [01/22] dt-bindings: arm: qcom: add the SoC ID for SA8255P
             [05/22] dt-bindings: mailbox: qcom-ipcc: document the support for SA8255p
             [06/22] dt-bindings: watchdog: qcom-wdt: document support on SA8255p
             [07/22] dt-bindings: crypto: qcom,prng: document support for SA8255p
             [08/22] dt-bindings: interrupt-controller: qcom-pdc: document support for SA8255p
             [13/22] dt-bindings: thermal: tsens: document support on SA8255p
             [14/22] dt-bindings: arm-smmu: document the support on SA8255p

Series: ep93xx device tree conversion
  Submitter: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
  Committer: Arnd Bergmann <arnd@arndb.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=871270
  Lore link: https://lore.kernel.org/r/20240715-ep93xx-v11-0-4e924efda795@maquefel.me
    Patches: [v11,14/38] dt-bindings: spi: Add Cirrus EP93xx
             [v11,15/38] spi: ep93xx: add DT support for Cirrus EP93xx

Series: ep93xx device tree conversion
  Submitter: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
  Committer: Arnd Bergmann <arnd@arndb.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=888306
  Lore link: https://lore.kernel.org/r/20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me
    Patches: [v12,14/38] dt-bindings: spi: Add Cirrus EP93xx
             [v12,15/38] spi: ep93xx: add DT support for Cirrus EP93xx

Series: [1/2] dt-bindings: spi: mediatek,spi-mt65xx: add compatible for MT7981
  Submitter: Rafał Miłecki <zajec5@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=874245
  Lore link: https://lore.kernel.org/r/20240727114828.29558-1-zajec5@gmail.com
    Patches: [1/2] dt-bindings: spi: mediatek,spi-mt65xx: add compatible for MT7981
             [2/2] arm64: dts: mediatek: mt7981: add SPI controllers

Series: spi: replace and remove {devm_}spi_alloc_master/slave()
  Submitter: Yang Yingliang <yangyingliang@huaweicloud.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=885878
  Lore link: https://lore.kernel.org/r/20240902125947.1368-1-yangyingliang@huaweicloud.com
    Patches: [-next,1/7] media: usb/msi2500: switch to use spi_alloc_host()
             [-next,6/7] staging: greybus: spi: switch to use spi_alloc_host()

Series: [v4,1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
  Submitter: Fabio Estevam <festevam@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=884719
  Lore link: https://lore.kernel.org/r/20240829113158.3324928-1-festevam@gmail.com
    Patches: [v4,1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
             [v4,3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe unexisting DAC device

Patch: Add support for sam9x7 SoC family
  Submitter: Varshini Rajendran <varshini.rajendran@microchip.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=867939
  Lore link: https://lore.kernel.org/r/20240703102011.193343-1-varshini.rajendran@microchip.com

Patch: Add support for sam9x7 SoC family
  Submitter: Varshini Rajendran <varshini.rajendran@microchip.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=874431
  Lore link: https://lore.kernel.org/r/20240729065603.1986074-1-varshini.rajendran@microchip.com

Patch: spi: ep93xx: update kerneldoc comments for ep93xx_spi
  Submitter: Arnd Bergmann <arnd@kernel.org>
  Committer: Arnd Bergmann <arnd@arndb.de>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=889781
  Lore link: https://lore.kernel.org/r/20240912132126.2991851-1-arnd@kernel.org


Total patches: 32

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



