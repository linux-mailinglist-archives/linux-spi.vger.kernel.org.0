Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8048874FA25
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jul 2023 23:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGKVx1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jul 2023 17:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGKVx1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jul 2023 17:53:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7ED170C
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 14:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6349C6133D
        for <linux-spi@vger.kernel.org>; Tue, 11 Jul 2023 21:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9C36C433C7;
        Tue, 11 Jul 2023 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689112403;
        bh=KKKQ94mviUF/5Kkaepcyj/Fgm3jTPCwvKkPuzKop3IA=;
        h=Subject:From:Date:To:From;
        b=c8j4b50sroJ6HFHSNJZu7Hx9HKbak+qx2WhhafTXPlYGU1Pi0mztmu9Q9Yys8mVpS
         tjbFZtSZwRfmsyigva9M+Sn5oOFOS299vdk9cuMzX4QqbTtgE80pk6jhV5mk7KCHaT
         0o+rCf+Dq1/umwD5pzORIGWuhshRwba+pxGhYFTVzuOdVKIsZfC8ZUQf16Hd8okAVE
         2RTlfgJUER4w2SpTIKUxaRzTsDu/pd8bXfcTUmHoSTkq5tSwyQAypL4R4dzDpXirB1
         KkaGLiDw2fqvrzelGtJajtuUH7ugs5msvTDfZSCqCovKSQOd+Up3UJrZ3KlIbj3Su2
         2ick6+Ygo9PNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C4B0C4167B;
        Tue, 11 Jul 2023 21:53:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168911240353.27662.11849849555893127970.git-patchwork-summary@kernel.org>
Date:   Tue, 11 Jul 2023 21:53:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: dt-bindings: restrict node name suffixes
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Vinod Koul <vkoul@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=752283
  Lore link: https://lore.kernel.org/r/20230530144851.92059-1-krzysztof.kozlowski@linaro.org
    Patches: [1/7] dt-bindings: phy: intel,combo-phy: restrict node name suffixes
             [2/7] dt-bindings: pwm: restrict node name suffixes
             [3/7] dt-bindings: rtc: restrict node name suffixes
             [4/7] dt-bindings: slimbus: restrict node name suffixes
             [6/7] dt-bindings: timestamp: restrict node name suffixes
             [7/7] dt-bindings: watchdog: restrict node name suffixes

Series: spi: Add DMA mode support to spi-qcom-qspi
  Submitter: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=742649
  Lore link: https://lore.kernel.org/r/1682328761-17517-1-git-send-email-quic_vnivarth@quicinc.com
    Patches: [v5,1/5] spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus
             [v5,2/5] arm64: dts: qcom: sc7180: Add stream-id of qspi to iommus
             [v5,3/5] arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
             [v5,4/5] arm64: dts: qcom: sdm845: Add stream-id of qspi to iommus

Series: Fix up Nokia 770 regression
  Submitter: Linus Walleij <linus.walleij@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=745924
  Lore link: https://lore.kernel.org/r/20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org
    Patches: [v4,1/4] Input: ads7846 - Convert to use software nodes
             [v4,4/4] ARM: dts: Fix erroneous ADS touchscreen polarities

Patch: arm64: defconfig: Enable UBIFS
  Submitter: Dhruva Gole <d-gole@ti.com>
  Committer: Vignesh Raghavendra <vigneshr@ti.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=740401
  Lore link: https://lore.kernel.org/r/20230417092243.967871-1-d-gole@ti.com

Series: spi-geni-qcom: Add new interfaces and utilise them to do map/unmap in framework for SE DMA
  Submitter: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=748416
  Lore link: https://lore.kernel.org/r/1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com
    Patches: [v2,1/2] soc: qcom: geni-se: Add interfaces geni_se_tx_init_dma() and geni_se_rx_init_dma()
             [v2,2/2] spi: spi-geni-qcom: Do not do DMA map/unmap inside driver, use framework instead

Series: Allwinner R329/D1/R528/T113s SPI support
  Submitter: Maksim Kiselev <bigunclemax@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=746344
  Lore link: https://lore.kernel.org/r/20230510081121.3463710-1-bigunclemax@gmail.com
    Patches: [v5,1/5] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329/D1/R528/T113s SPI
             [v5,5/5] riscv: dts: allwinner: d1: Add SPI controllers node

Patch: dt-bindings: xilinx: Switch xilinx.com emails to amd.com
  Submitter: Michal Simek <michal.simek@amd.com>
  Committer: Michal Simek <michal.simek@amd.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=748030
  Lore link: https://lore.kernel.org/r/f5b2bd1e78407e4128fc8f0b5874ba723e710a88.1684245058.git.michal.simek@amd.com


Total patches: 18

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


