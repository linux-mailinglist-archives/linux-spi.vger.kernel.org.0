Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB0602A84
	for <lists+linux-spi@lfdr.de>; Tue, 18 Oct 2022 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJRLrh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Oct 2022 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJRLrg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Oct 2022 07:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2828BBF05
        for <linux-spi@vger.kernel.org>; Tue, 18 Oct 2022 04:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4EEF61500
        for <linux-spi@vger.kernel.org>; Tue, 18 Oct 2022 11:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41E81C433C1;
        Tue, 18 Oct 2022 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666093047;
        bh=HiaN4xF272e/oISJcaPBo8y8ZmXAW4spSpVdveF61mM=;
        h=Subject:From:Date:To:From;
        b=hXm9bShOWhlB20QEQf2a6xA8w5a8lQDo3hEvKrwdF9xZdfICvUjERacSPiUyu665U
         Jv9iD9lX0Aw07LikokO/eJObg95Wfh7Y87KcKg2qOz8Kba0Zv3Zvdgtq8NK78WT+VK
         q0RCciZ3LseXK+ys6SutmbLabKrmcDN47hW7FRsAN34pL7o+JKPYmYkCflkQ8op5hu
         TQtaEhEFDrED7f+/V7dhmKyNb/y6Txa+i4IQ/NmXW/4cmx+5EMXCZhxlS51CFdjvIE
         bI67xb9QzmdlS7oCc12kB5QCH85QHRf4gjusaAZY1rBl1eQza1TZ/voHfbyfUP2knM
         4IRkDA2CcwMIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B2ABE21ED4;
        Tue, 18 Oct 2022 11:37:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166609304699.30784.180226285209275940.git-patchwork-summary@kernel.org>
Date:   Tue, 18 Oct 2022 11:37:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Series: Make atmel serial driver aware of GCLK
  Submitter: Sergiu Moga <sergiu.moga@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=679400
  Lore link: https://lore.kernel.org/r/20220922113347.144383-1-sergiu.moga@microchip.com
    Patches: [v5,1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
             [v5,2/9] dt-bindings: serial: atmel,at91-usart: convert to json-schema
             [v5,3/9] dt-bindings: serial: atmel,at91-usart: Add SAM9260 compatibles to SAM9X60
             [v5,5/9] dt-bindings: serial: atmel,at91-usart: Add gclk as a possible USART clock
             [v5,6/9] tty: serial: atmel: Separate mode clearing between UART and USART
             [v5,7/9] tty: serial: atmel: Only divide Clock Divisor if the IP is USART
             [v5,8/9] tty: serial: atmel: Make the driver aware of the existence of GCLK
             [v5,9/9] tty: serial: atmel: Use FIELD_PREP/FIELD_GET

Series: spi: stm32_qspi: use QSPI bus as 8 lines communication channel
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Alexandre Torgue <alexandre.torgue@foss.st.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=670073
  Lore link: https://lore.kernel.org/r/20220823075850.575043-1-patrice.chotard@foss.st.com
    Patches: [v4,1/2] ARM: dts: stm32: Create separate pinmux for qspi cs pin in stm32mp15-pinctrl.dtsi

Series: ACPI: unify _UID handling as integer
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=676641
  Lore link: https://lore.kernel.org/r/20220913163147.24258-1-andriy.shevchenko@linux.intel.com
    Patches: [v3,1/8] ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as integer
             [v3,2/8] ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
             [v3,3/8] ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
             [v3,4/8] i2c: amd-mp2-plat: Refactor _UID handling to use acpi_dev_uid_to_integer()
             [v3,5/8] i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
             [v3,6/8] perf: qcom_l2_pmu: Refactor _UID handling to use acpi_dev_uid_to_integer()
             [v3,7/8] spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
             [v3,8/8] efi/dev-path-parser: Refactor _UID handling to use acpi_dev_uid_to_integer()

Patch: riscv: dts: microchip: add qspi compatible fallback
  Submitter: Conor Dooley <conor.dooley@microchip.com>
  Committer: Conor Dooley <conor.dooley@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=666531
  Lore link: https://lore.kernel.org/r/20220810085914.801170-1-conor.dooley@microchip.com

Series: Add more Rockchip rk3128 compatible strings
  Submitter: Johan Jonker <jbx6244@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=675845
  Lore link: https://lore.kernel.org/r/3ed145c6-f400-ee75-ccac-894b0a0d15d2@gmail.com
    Patches: [v1,11/11] dt-bindings: mtd: rockchip: add rockchip,rk3128-nfc
             [v1,01/11] dt-bindings: serial: rockchip: add rockchip,rk3128-uart
             [v1,10/11] dt-bindings: soc: rockchip: grf: add rockchip,rk3128-grf
             [v1,09/11] dt-bindings: phy: phy-rockchip-inno-usb2: add rockchip,rk3128-usb2phy
             [v1,08/11] dt-bindings: arm: rockchip: pmu: add rockchip,rk3128-pmu
             [v1,07/11] dt-bindings: watchdog: rockchip: add rockchip,rk3128-wdt
             [v1,06/11] dt-bindings: usb: dwc2: rockchip: add rockchip,rk3128-usb
             [v1,04/11] dt-bindings: mmc: rockchip: add rockchip,rk3128-dw-mshc
             [v1,03/11] dt-bindings: pwm: rockchip: add rockchip,rk3128-pwm
             [v1,02/11] dt-bindings: i2c: rockchip: add rockchip,rk3128-i2c

Patch: [-next,v2] Documentation: devres: add missing SPI helper
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Jonathan Corbet <corbet@lwn.net>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=679894
  Lore link: https://lore.kernel.org/r/20220923141803.75734-1-yangyingliang@huawei.com

Patch: MAINTAINERS: Update email of Neil Armstrong
  Submitter: Neil Armstrong <narmstrong@baylibre.com>
  Committer: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=667978
  Lore link: https://lore.kernel.org/r/20220816095617.948678-1-narmstrong@baylibre.com

Series: spi: remove "spidev" nodes from DTs
  Submitter: Wolfram Sang <wsa+renesas@sang-engineering.com>
  Committer: Alexandre Torgue <alexandre.torgue@foss.st.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=670550
  Lore link: https://lore.kernel.org/r/20220824082130.21934-1-wsa+renesas@sang-engineering.com
    Patches: [1/2] ARM: dts: stm32: argon: remove spidev node
             [2/2] powerpc/82xx: remove spidev node from mgcoge


Total patches: 32

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


