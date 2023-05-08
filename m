Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA286FB2C7
	for <lists+linux-spi@lfdr.de>; Mon,  8 May 2023 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjEHO2c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 May 2023 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjEHO2b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 May 2023 10:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63D18B
        for <linux-spi@vger.kernel.org>; Mon,  8 May 2023 07:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8E9B6130B
        for <linux-spi@vger.kernel.org>; Mon,  8 May 2023 14:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 387BFC433EF;
        Mon,  8 May 2023 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683556109;
        bh=Fqi9DsOZnwmI94rEvUTcVUdhVbystu7V8ejEhDa2d+0=;
        h=Subject:From:Date:To:From;
        b=FOd2818yhDqy79LRC5rGWvjuwbWNZYhJ8ZZWvYMSIZNxSiTpTn3ND7P+VUogxpBzv
         KMOIYKZkPuGi/OuV0kuK5A2FDHxRwNJ4g+r7AHIS+E++M16Q7xqAZ0fh6fxy0UU98Z
         Z1nSNyT9j7ekbJjp+Ye6rmYRrKUQzwaFyxKkw9LOgypchcv7XyDRMA+o1C+W08T3XV
         6wwYB55UAczUTnHX9j4GcqbeaCDDjkRg4Y60erRsX5iEYrmHR26eauXz+DqP6RZ1U3
         AWq+ahvXHKkH0yY3yieCZt3u4d9dCYxkBNUXPzVSaO0B3N1fEqqgRtIV6OWIdyQKde
         fkSDL4D58+ZrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1605AE26D26;
        Mon,  8 May 2023 14:28:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168355610900.25692.10012885556068274045.git-patchwork-summary@kernel.org>
Date:   Mon, 08 May 2023 14:28:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v3,1/3] spi: s3c64xx: change polling mode to optional
  Submitter: Jaewon Kim <jaewon02.kim@samsung.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=744312
  Lore link: https://lore.kernel.org/r/20230502062813.112434-2-jaewon02.kim@samsung.com
    Patches: [v3,1/3] spi: s3c64xx: change polling mode to optional
             [v3,2/3] spi: s3c64xx: add sleep during transfer
             [v3,3/3] spi: s3c64xx: support interrupt based pio mode

Series: Control Quad SPI pinctrl better on Qualcomm Chromebooks
  Submitter: Doug Anderson <dianders@chromium.org>
  Committer: Bjorn Andersson <andersson@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=733261
  Lore link: https://lore.kernel.org/r/20230323173019.3706069-1-dianders@chromium.org
    Patches: [01/14] arm64: dts: sc7180: Rename qspi data12 as data23
             [02/14] arm64: dts: sc7280: Rename qspi data12 as data23
             [03/14] arm64: dts: sdm845: Rename qspi data12 as data23
             [04/14] arm64: dts: qcom: sc7180: Annotate l13a on trogdor to always-on
             [06/14] dt-bindings: pinctrl: qcom: tlmm should use output-disable, not input-enable
             [07/14] dt-bindings: pinctrl: qcom: Add output-enable
             [08/14] pinctrl: qcom: Support OUTPUT_ENABLE; deprecate INPUT_ENABLE
             [09/14] arm64: dts: qcom: sc7180: Remove superfluous "input-enable"s from trogdor
             [10/14] arm64: dts: qcom: sc7280: Remove superfluous "input-enable"s from idp-ec-h1
             [11/14] arm64: dts: qcom: sdm845: Remove superfluous "input-enable"s from cheza
             [12/14] arm64: dts: qcom: sc7180: Fix trogdor qspi pin config
             [13/14] arm64: dts: qcom: sc7280: Fix qspi pin config
             [14/14] arm64: dts: qcom: sdm845: Fix cheza qspi pin config

Series: spi: Add DMA mode support to spi-qcom-qspi
  Submitter: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=742649
  Lore link: https://lore.kernel.org/r/1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com
    Patches: [v5,1/5] spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus
             [v5,5/5] spi: spi-qcom-qspi: Add DMA mode support

Patch: spi: lpspi: run transfer speed_hz sanity check
  Submitter: Clark Wang <xiaoning.wang@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=745183
  Lore link: https://lore.kernel.org/r/20230505064159.3964473-1-xiaoning.wang@nxp.com

Patch: spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG
  Submitter: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=742981
  Lore link: https://lore.kernel.org/r/1682412128-1913-1-git-send-email-quic_vnivarth@quicinc.com

Series: spi: dw: DW SPI DMA Driver updates
  Submitter: Joy Chakraborty <joychakr@google.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=743589
  Lore link: https://lore.kernel.org/r/20230427123314.1997152-1-joychakr@google.com
    Patches: [v9,1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
             [v9,2/5] spi: dw: Move dw_spi_can_dma()

Series: Support AMD Pensando Elba SoC
  Submitter: Brad Larson <blarson@amd.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=738525
  Lore link: https://lore.kernel.org/r/20230410184526.15990-1-blarson@amd.com
    Patches: [v13,01/15] dt-bindings: arm: add AMD Pensando boards
             [v13,02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
             [v13,11/15] mmc: sdhci-cadence: Enable device specific override of writel()
             [v13,12/15] mmc: sdhci-cadence: Support device specific init during probe
             [v13,13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
             [v13,14/15] mmc: sdhci-cadence: Support mmc hardware reset

Series: [01/16] spi: armada-3700: Drop of_match_ptr for ID table
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=728934
  Lore link: https://lore.kernel.org/r/20230310222857.315629-1-krzysztof.kozlowski@linaro.org
    Patches: [01/16] spi: armada-3700: Drop of_match_ptr for ID table
             [02/16] spi: mtk-pmif: Drop of_match_ptr for ID table

Series: spi: struct spi_device constification
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Lee Jones <lee@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=729398
  Lore link: https://lore.kernel.org/r/cover.1678704562.git.geert+renesas@glider.be
    Patches: [1/6] mfd: rsmu_spi: Remove unneeded casts of void *

Series: spi: bcm63xx-hsspi: driver and doc updates
  Submitter: William Zhang <william.zhang@broadcom.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=720455
  Lore link: https://lore.kernel.org/r/20230209200246.141520-1-william.zhang@broadcom.com
    Patches: [v4,01/15] dt-bindings: spi: Convert bcm63xx-hsspi bindings to json-schema
             [v4,03/15] ARM: dts: broadcom: bcmbca: Add spi controller node
             [v4,04/15] arm64: dts: broadcom: bcmbca: Add spi controller node

Patch: dt-bindings: yamllint: Require a space after a comment '#'
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=726556
  Lore link: https://lore.kernel.org/r/20230303214223.49451-1-robh@kernel.org

Patch: [v2] dt-bindings: spi: zynqmp-qspi: Add power-domains and iommus properties
  Submitter: Michal Simek <michal.simek@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=744610
  Lore link: https://lore.kernel.org/r/2afed7285061abbb5d9ad3b1e795b737dcff9693.1683102032.git.michal.simek@amd.com

Patch: [v3] treewide: Fix probing of devices in DT overlays
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=735412
  Lore link: https://lore.kernel.org/r/e1fa546682ea4c8474ff997ab6244c5e11b6f8bc.1680182615.git.geert+renesas@glider.be


Total patches: 37

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


