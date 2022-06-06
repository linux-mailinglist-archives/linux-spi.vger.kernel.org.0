Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75E53ECF8
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jun 2022 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiFFRUy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jun 2022 13:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFFRTG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jun 2022 13:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB40BE35
        for <linux-spi@vger.kernel.org>; Mon,  6 Jun 2022 10:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313CE611B8
        for <linux-spi@vger.kernel.org>; Mon,  6 Jun 2022 17:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CB9AC3411E;
        Mon,  6 Jun 2022 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654535930;
        bh=nrfkDDRSkP0HX7zEauYoc91I09JId13EGP/48CBugec=;
        h=Subject:From:Date:To:From;
        b=cAslViW0tNL30FEzXdAZ739r5ZSgwh69sulYsY7ig3NDspUuTcXXI/fqL/d9uu+a3
         G+Cf3U5vZhla8vTHZdFF30KpNbTSf2D99jvy9BPlD/TTO4C7n1GIa5qHtmi7uCbQZl
         lG/Hm7yi82boS20qQ6RFOXqK9B7rUILLcAPzO0hbyI2W291GL7lXg6fCaSU74In8b7
         +0lXPkVb6flcuw5AD9MDyF63v5AhWQ9dGnT5FNuyfPI/C9IFfZw1H1+KqgXT0jMv1D
         s3YedtSl/LhcMv8dx4Odb73z1+IRRj44mc7hGdh10ITjOC+UjhLXNDQ02HfijkIQMU
         PMxK7SUoKzyhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54D39E737ED;
        Mon,  6 Jun 2022 17:18:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165453593019.18682.6739990342385709978.git-patchwork-summary@kernel.org>
Date:   Mon, 06 Jun 2022 17:18:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: spi: spi-mem: Convert Aspeed SMC driver to spi-mem
  Submitter: Cédric Le Goater <clg@kaod.org>
  Committer: Joel Stanley <joel@jms.id.au>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=639867
  Lore link: https://lore.kernel.org/r/20220509175616.1089346-1-clg@kaod.org
    Patches: [v7,01/11] ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
             [v7,09/11] ARM: dts: aspeed: Enable Dual SPI RX transfers
             [v7,10/11] ARM: dts: aspeed-g4: Set spi-max-frequency for all flashes

Series: Fix broken usage of driver_override (and kfree of static memory)
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=633333
  Lore link: https://lore.kernel.org/r/20220419113435.246203-1-krzysztof.kozlowski@linaro.org
    Patches: [v7,01/12] driver: platform: Add helper for safer setting of driver_override
             [v7,02/12] amba: Use driver_set_override() instead of open-coding
             [v7,03/12] fsl-mc: Use driver_set_override() instead of open-coding
             [v7,04/12] hv: Use driver_set_override() instead of open-coding
             [v7,05/12] PCI: Use driver_set_override() instead of open-coding
             [v7,06/12] s390/cio: Use driver_set_override() instead of open-coding
             [v7,07/12] spi: Use helper for safer setting of driver_override
             [v7,08/12] vdpa: Use helper for safer setting of driver_override
             [v7,09/12] clk: imx: scu: Fix kfree() of static memory on setting driver_override
             [v7,10/12] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
             [v7,11/12] rpmsg: Constify local variable in field store macro
             [v7,12/12] rpmsg: Fix kfree() of static memory on setting driver_override

Series: None
  Submitter: Andre Przywara <andre.przywara@arm.com>
  Committer: Jernej Skrabec <jernej.skrabec@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=624316
  Lore link: https://lore.kernel.org/r/20220317162349.739636-11-andre.przywara@arm.com
    Patches: [v2,10/12] dt-bindings: spi: sunxi: document F1C100 controllers
             [v2,11/12] ARM: dts: suniv: F1C100: add SPI support
             [v2,12/12] ARM: dts: suniv: licheepi-nano: add SPI flash

Series: Fix broken usage of driver_override (and kfree of static memory)
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=623930
  Lore link: https://lore.kernel.org/r/20220316150533.421349-1-krzysztof.kozlowski@canonical.com
    Patches: [v5,01/11] driver: platform: Add helper for safer setting of driver_override
             [v5,02/11] amba: Use driver_set_override() instead of open-coding
             [v5,03/11] fsl-mc: Use driver_set_override() instead of open-coding
             [v5,04/11] hv: Use driver_set_override() instead of open-coding
             [v5,05/11] PCI: Use driver_set_override() instead of open-coding
             [v5,06/11] s390/cio: Use driver_set_override() instead of open-coding
             [v5,07/11] spi: Use helper for safer setting of driver_override
             [v5,08/11] vdpa: Use helper for safer setting of driver_override
             [v5,09/11] clk: imx: scu: Fix kfree() of static memory on setting driver_override
             [v5,10/11] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override

Series: spi: add support for Mediatek SPI-NAND controller
  Submitter: Chuanhong Guo <gch981213@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=634989
  Lore link: https://lore.kernel.org/r/20220424032527.673605-1-gch981213@gmail.com
    Patches: [v6,1/5] mtd: nand: make mtk_ecc.c a separated module
             [v6,5/5] arm64: dts: mediatek: add mtk-snfi for mt7622

Patch: [v2] dt-bindings: qcom: update maintainers (drop Akash and Mukesh)
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=628992
  Lore link: https://lore.kernel.org/r/20220405063724.12850-1-krzysztof.kozlowski@linaro.org

Series: dt-bindings: qcom: convert entire GSBI (QUP I2C/SPI/UART) to DT schema
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Bjorn Andersson <bjorn.andersson@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=628991
  Lore link: https://lore.kernel.org/r/20220405063451.12011-1-krzysztof.kozlowski@linaro.org
    Patches: [v4,1/9] arm64: dts: qcom: align dmas in I2C/SPI/UART with DT schema
             [v4,2/9] arm64: dts: qcom: align clocks in I2C/SPI with DT schema
             [v4,3/9] ARM: dts: qcom: ipq4019: align dmas in SPI/UART with DT schema
             [v4,4/9] ARM: dts: qcom: ipq4019: align clocks in I2C with DT schema
             [v4,5/9] ARM: dts: qcom: msm8660: disable GSBI8
             [v4,6/9] spi: dt-bindings: qcom,spi-qup: convert to dtschema
             [v4,7/9] dt-bindings: serial: qcom,msm-uartdm: convert to dtschema
             [v4,8/9] dt-bindings: i2c: qcom,i2c-qup: convert to dtschema
             [v4,9/9] dt-bindings: qcom: qcom,gsbi: convert to dtschema

Series: [v3,1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Bjorn Andersson <bjorn.andersson@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=628657
  Lore link: https://lore.kernel.org/r/20220404064017.68634-1-krzysztof.kozlowski@linaro.org
    Patches: [v3,1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
             [v3,2/2] dt-bindings: qcom: qcom,geni-se: refer to dtschema for SPI

Patch: [v4] arm64: tegra: Add QSPI controllers on Tegra234
  Submitter: Krishna Yarlagadda <kyarlagadda@nvidia.com>
  Committer: Thierry Reding <treding@nvidia.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=621616
  Lore link: https://lore.kernel.org/r/20220308183026.66394-1-kyarlagadda@nvidia.com

Patch: dt-bindings: align SPI NOR node name with dtschema
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=630056
  Lore link: https://lore.kernel.org/r/20220407143405.295907-1-krzysztof.kozlowski@linaro.org

Patch: dt-bindings: Fix array constraints on scalar properties
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=631907
  Lore link: https://lore.kernel.org/r/20220413140121.3132837-1-robh@kernel.org

Patch: dt-bindings: trivial-devices: Document CPLD on DH electronics boards
  Submitter: Marek Vasut <marex@denx.de>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=630179
  Lore link: https://lore.kernel.org/r/20220407210106.256027-1-marex@denx.de

Patch: dt-bindings: trivial-devices: Document CPLD on Menlo boards
  Submitter: Marek Vasut <marex@denx.de>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=630180
  Lore link: https://lore.kernel.org/r/20220407210131.256045-1-marex@denx.de


Total patches: 47

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


