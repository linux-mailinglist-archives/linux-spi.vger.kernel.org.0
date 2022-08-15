Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4159320D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Aug 2022 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiHOPgN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Aug 2022 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiHOPgL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Aug 2022 11:36:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B3312AC1
        for <linux-spi@vger.kernel.org>; Mon, 15 Aug 2022 08:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE301B80EDF
        for <linux-spi@vger.kernel.org>; Mon, 15 Aug 2022 15:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A78ADC433D6;
        Mon, 15 Aug 2022 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660577767;
        bh=aFBDRAuqhMXVWclzv//beI6GsN/bHsQEZBcDQzDTd5k=;
        h=Subject:From:Date:To:From;
        b=cJD65yJY3DF6H8AHrKg2kt1y/Js6JJwj4UScNcnbMGW5DV1Ehcjjc4yAhFQAz/FVT
         9SSYXEpqyANFN4jjNHv0FGJQoKwQemr4T+dZydKsFTOPiMm5uaBRWzuW06vVA2ZYC7
         vYdCKD0dRAuWyKaC5HRUTyRnMPqyCxkdvtWRuYPCl33x6WFQmrkXvEQVbMONL8EIDE
         i1Isj//BuA5aTWQQ7QSLMkNEhW+8qHPNZmaOjpyaVFfusxvFTITHtjt2xy6nplNHI+
         3HaT/lOmUUDUF9c+J3c+FDO+jMLiTMwcgYxg4NKEAIRKQWzNN8DLlAULAS48wQNqqO
         j4g56PEqYGvxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89617C43142;
        Mon, 15 Aug 2022 15:36:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166057776749.2541.12458264437848073218.git-patchwork-summary@kernel.org>
Date:   Mon, 15 Aug 2022 15:36:07 +0000
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

Series: Canaan devicetree fixes
  Submitter: Conor Dooley <mail@conchuod.ie>
  Committer: Palmer Dabbelt <palmer@rivosinc.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=655138
  Lore link: https://lore.kernel.org/r/20220629184343.3438856-1-mail@conchuod.ie
    Patches: [v3,01/15] dt-bindings: display: convert ilitek,ili9341.txt to dt-schema
             [v3,02/15] dt-bindings: display: ili9341: document canaan kd233's lcd
             [v3,03/15] ASoC: dt-bindings: convert designware-i2s to dt-schema
             [v3,07/15] riscv: dts: canaan: fix the k210's memory node
             [v3,08/15] riscv: dts: canaan: fix the k210's timer nodes
             [v3,09/15] riscv: dts: canaan: fix mmc node names
             [v3,10/15] riscv: dts: canaan: fix kd233 display spi frequency
             [v3,11/15] riscv: dts: canaan: use custom compatible for k210 i2s
             [v3,12/15] riscv: dts: canaan: remove spi-max-frequency from controllers
             [v3,14/15] riscv: dts: canaan: add specific compatible for kd233's LCD
             [v3,15/15] riscv: dts: canaan: build all devicetress if SOC_CANAAN

Series: Add support for MT8365 EVK board
  Submitter: Fabien Parent <fparent@baylibre.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=646271
  Lore link: https://lore.kernel.org/r/20220531135026.238475-1-fparent@baylibre.com
    Patches: [01/17] dt-bindings: i2c: i2c-mt65xx: add binding for MT8365 SoC
             [05/17] dt-bindings: dma: mediatek,uart-dma: add MT8365 bindings
             [11/17] dt-bindings: phy: mediatek,dsi-phy: Add MT8365 SoC bindings
             [12/17] dt-bindings: phy: mediatek,tphy: add MT8365 SoC bindings

Patch: dt-bindings: efm32: remove bindings for deleted platform
  Submitter: Wolfram Sang <wsa@kernel.org>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=650757
  Lore link: https://lore.kernel.org/r/20220615210720.6363-1-wsa@kernel.org

Patch: None
  Submitter: William Zhang <william.zhang@broadcom.com>
  Committer: Florian Fainelli <f.fainelli@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=657290
  Lore link: https://lore.kernel.org/r/20220707065800.261269-7-william.zhang@broadcom.com

Series: [v2,1/2] driver core: Introduce device_find_any_child() helper
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=649276
  Lore link: https://lore.kernel.org/r/20220610120219.18988-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/2] driver core: Introduce device_find_any_child() helper
             [v2,2/2] spi: Use device_find_any_child() instead of custom approach

Patch: eeprom: at25: Rework buggy read splitting
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=652377
  Lore link: https://lore.kernel.org/r/7ae260778d2c08986348ea48ce02ef148100e088.1655817534.git.geert+renesas@glider.be


Total patches: 20

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


