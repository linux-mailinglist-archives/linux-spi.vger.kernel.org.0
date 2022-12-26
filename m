Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228D65662D
	for <lists+linux-spi@lfdr.de>; Tue, 27 Dec 2022 00:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiLZX7h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Dec 2022 18:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLZX7h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Dec 2022 18:59:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475C5F5B
        for <linux-spi@vger.kernel.org>; Mon, 26 Dec 2022 15:59:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA3B60B3A
        for <linux-spi@vger.kernel.org>; Mon, 26 Dec 2022 23:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34752C433D2;
        Mon, 26 Dec 2022 23:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672099175;
        bh=dUtKyTlkEKDHKpz5Z2rK3deJ8fWQUUnCv9mLEHY8iz0=;
        h=Subject:From:Date:To:From;
        b=jtZRsQiMouoRbo7G2U5aes5paSYnjFeBctQ5j/94qsG0/tsO30i01iokFlClQWCoh
         ySGeMm0BMIglfgx+1K20W20oryCWaMdDYDQiLR/wwSKDiOVzWaewzdZ6BGNF4fjPeH
         lpfKuX8guHyMzKg/Md/FK8yl+libjKzO1LtY2BHAfxry/zS30BeyfFGknKtSSKvB1t
         K+U0LboHfG2jnh2J/hHY1UkseZYCrQL/Yt0gWvSHVxN9TjF32MT8sY5x+6LuAOoFhY
         evR/jpSzRqCpOhxs1U1ugxO8yzUQZ6epzQcAIQ1AfUKeii8cZiNQjdmpcOz/n4AXv1
         7YcvydElw2JPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13117C197B4;
        Mon, 26 Dec 2022 23:59:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167209917502.31878.17773409054986545616.git-patchwork-summary@kernel.org>
Date:   Mon, 26 Dec 2022 23:59:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: mtd: spi-nor: Fix the number of bytes for the dummy cycles
  Submitter: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
  Committer: Tudor Ambarus <tudor.ambarus@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=690481
  Lore link: https://lore.kernel.org/r/20221031124633.13189-1-allen-kh.cheng@mediatek.com

Series: [1/3] ACPI: scan: substitute empty_zero_page with helper ZERO_PAGE(0)
  Submitter: Giulio Benetti <giulio.benetti@benettiengineering.com>
  Committer: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=686470
  Lore link: https://lore.kernel.org/r/20221018215755.33566-1-giulio.benetti@benettiengineering.com
    Patches: [1/3] ACPI: scan: substitute empty_zero_page with helper ZERO_PAGE(0)

Series: dt-bindings: cleanup titles
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=705156
  Lore link: https://lore.kernel.org/r/20221216163815.522628-1-krzysztof.kozlowski@linaro.org
    Patches: [v3,1/9] dt-bindings: drop redundant part of title of shared bindings
             [v3,2/9] dt-bindings: memory-controllers: ti,gpmc-child: drop redundant part of title
             [v3,3/9] dt-bindings: clock: st,stm32mp1-rcc: add proper title
             [v3,4/9] dt-bindings: drop redundant part of title (end)
             [v3,5/9] dt-bindings: drop redundant part of title (end, part two)
             [v3,6/9] dt-bindings: drop redundant part of title (end, part three)
             [v3,7/9] dt-bindings: drop redundant part of title (beginning)
             [v3,8/9] dt-bindings: clock: drop redundant part of title
             [v3,9/9] dt-bindings: drop redundant part of title (manual)

Series: imx8mp: spi: update binding and compatible
  Submitter: Peng Fan (OSS) <peng.fan@oss.nxp.com>
  Committer: Shawn Guo <shawnguo@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=687082
  Lore link: https://lore.kernel.org/r/20221020103158.2273874-1-peng.fan@oss.nxp.com
    Patches: [1/2] dt-bindings: spi: fsl-imx-cspi: update i.MX8MP binding
             [2/2] arm64: dts: imx8mp: update ecspi compatible and clk

Series: spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle
  Submitter: Amjad Ouled-Ameur <aouledameur@baylibre.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=687529
  Lore link: https://lore.kernel.org/r/20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com
    Patches: [v4,1/4] spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
             [v4,3/4] arm64: dts: meson-gxl: add SPI pinctrl nodes for CLK
             [v4,4/4] arm64: dts: meson-gxbb: add SPI pinctrl nodes for CLK

Patch: dt-bindings: Add missing start and/or end of line regex anchors
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=697135
  Lore link: https://lore.kernel.org/r/20221118223728.1721589-1-robh@kernel.org


Total patches: 17

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


