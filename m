Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2861A79D040
	for <lists+linux-spi@lfdr.de>; Tue, 12 Sep 2023 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjILLlJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Sep 2023 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjILLk5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Sep 2023 07:40:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D422A10E6
        for <linux-spi@vger.kernel.org>; Tue, 12 Sep 2023 04:40:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73B64C433C8;
        Tue, 12 Sep 2023 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518839;
        bh=gANHdKwdy4eHAXqPHvQHok5Bu4iupr3g3yipDfBtsgo=;
        h=Subject:From:Date:To:From;
        b=ejA2jxoBhgx5vcJcmztbxhoZ5U9Gf4PpexNtAPmUto48W9v+s138imtvzgsAz47Nj
         Tkxd8J3FOHiWB9oQiFlLEQVZLRguLInBdzsEJmmtmNgKrYYJoafcSD3RcTxyujmukm
         C1AytF55kyEmKJr1oBxpouJKKVRhyAUiU+mnI2mLuqx0qDeTtgrhjCSUYCSfPOVZYc
         yTTn0v/hzEW2MzF4hyamg052eLNWx4XCZiuenRn9zH0oAuMCtSRUz5fjnArhAVmrdJ
         5QdedyprqvPdvunxVUru9tkbHGppzVDxc6kObiIS3dZ+ffjF6K2t4gPFtrxrwvK+Vd
         yoD8yxZ/DeG/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52C58E1C280;
        Tue, 12 Sep 2023 11:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169451883927.9423.6441610490976973021.git-patchwork-summary@kernel.org>
Date:   Tue, 12 Sep 2023 11:40:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: switch to use modern name (part3)
  Submitter: Yang Yingliang <yangyingliang@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=778415
  Lore link: https://lore.kernel.org/r/20230823033003.3407403-1-yangyingliang@huawei.com
    Patches: [-next,v2,01/21] spi: lm70llp: switch to use modern name
             [-next,v2,02/21] spi: lp-8841: switch to use modern name
             [-next,v2,03/21] spi: meson-spicc: switch to use modern name
             [-next,v2,04/21] spi: meson-spifc: switch to use modern name
             [-next,v2,05/21] spi: microchip-core-qspi: switch to use modern name
             [-next,v2,06/21] spi: microchip-core: switch to use modern name
             [-next,v2,07/21] spi: mpc512x-psc: switch to use modern name
             [-next,v2,08/21] spi: mpc52xx-psc: switch to use modern name
             [-next,v2,09/21] spi: mpc52xx: switch to use modern name
             [-next,v2,10/21] spi: mt65xx: switch to use modern name
             [-next,v2,11/21] spi: mt7621: switch to use modern name
             [-next,v2,12/21] spi: mtk-nor: switch to use modern name
             [-next,v2,13/21] spi: mtk-snfi: switch to use modern name
             [-next,v2,14/21] spi: mux: switch to use spi_alloc_host()
             [-next,v2,15/21] spi: mxic: switch to use modern name
             [-next,v2,16/21] spi: mxs: switch to use modern name
             [-next,v2,17/21] spi: npcm-pspi: switch to use modern name
             [-next,v2,18/21] spi: nxp-fspi: switch to use modern name
             [-next,v2,19/21] spi: oc-tiny: switch to use modern name
             [-next,v2,20/21] spi: omap-uwire: switch to use modern name
             [-next,v2,21/21] spi: omap2-mcspi: switch to use modern name

Patch: spi: nxp-fspi: reset the FLSHxCR1 registers
  Submitter: Han Xu <han.xu@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=782067
  Lore link: https://lore.kernel.org/r/20230906183254.235847-1-han.xu@nxp.com

Series: spidev: A few cleanups
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=779066
  Lore link: https://lore.kernel.org/r/20230824162209.2890440-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/3] spidev: Decrease indentation level in spidev_ioctl() SPI_IOC_RD_MODE*
             [v1,2/3] spidev: Switch to use spi_get_csgpiod()
             [v1,3/3] spidev: Simplify SPI_IOC_RD_MODE* cases in spidev_ioctl()

Series: spi: Use devm_clk_get_*() helper function to simplify the drivers.
  Submitter: Li Zetao <lizetao1@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=778225
  Lore link: https://lore.kernel.org/r/20230822131237.1022815-1-lizetao1@huawei.com
    Patches: [-next,01/25] spi: ar934x: Use helper function devm_clk_get_enabled()
             [-next,03/25] spi: aspeed: Use helper function devm_clk_get_enabled()
             [-next,04/25] spi: ath79: Use helper function devm_clk_get_enabled()
             [-next,05/25] spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
             [-next,06/25] spi: bcm2835: Use helper function devm_clk_get_enabled()
             [-next,07/25] spi: bcm2835aux: Use helper function devm_clk_get_enabled()
             [-next,08/25] spi: spi-cadence: Use helper function devm_clk_get_enabled()
             [-next,09/25] spi: spi-cavium-thunderx: Use helper function devm_clk_get_enabled()
             [-next,10/25] spi: davinci: Use helper function devm_clk_get_enabled()
             [-next,11/25] spi: dw-bt1: Use helper function devm_clk_get_enabled()
             [-next,13/25] spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
             [-next,14/25] spi: lantiq-ssc: Use helper function devm_clk_get_enabled()
             [-next,15/25] spi: meson-spicc: Use helper function devm_clk_get_enabled()
             [-next,16/25] spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
             [-next,17/25] spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
             [-next,18/25] spi: microchip-core: Use helper function devm_clk_get_enabled()
             [-next,19/25] spi: mtk-snfi: Use helper function devm_clk_get_enabled()
             [-next,20/25] spi: npcm-fiu: Use helper function devm_clk_get_enabled()
             [-next,25/25] spi: rockchip: Use helper function devm_clk_get_enabled()

Series: [-next,v2,01/25] spi: ar934x: Use helper function devm_clk_get_enabled()
  Submitter: Li Zetao <lizetao1@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=778625
  Lore link: https://lore.kernel.org/r/20230823133938.1359106-2-lizetao1@huawei.com
    Patches: [-next,v2,01/25] spi: ar934x: Use helper function devm_clk_get_enabled()
             [-next,v2,02/25] spi: armada-3700: Use helper function devm_clk_get_prepared()
             [-next,v2,03/25] spi: aspeed: Use helper function devm_clk_get_enabled()
             [-next,v2,04/25] spi: ath79: Use helper function devm_clk_get_enabled()
             [-next,v2,05/25] spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
             [-next,v2,06/25] spi: bcm2835: Use helper function devm_clk_get_enabled()
             [-next,v2,07/25] spi: bcm2835aux: Use helper function devm_clk_get_enabled()
             [-next,v2,08/25] spi: spi-cadence: Use helper function devm_clk_get_enabled()
             [-next,v2,09/25] spi: spi-cavium-thunderx: Use helper function devm_clk_get_enabled()
             [-next,v2,10/25] spi: davinci: Use helper function devm_clk_get_enabled()
             [-next,v2,11/25] spi: dw-bt1: Use helper function devm_clk_get_enabled()
             [-next,v2,12/25] spi: dw-mmio: Use helper function devm_clk_get_*()
             [-next,v2,13/25] spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
             [-next,v2,14/25] spi: lantiq-ssc: Use helper function devm_clk_get_enabled()
             [-next,v2,15/25] spi: meson-spicc: Use helper function devm_clk_get_enabled()
             [-next,v2,16/25] spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
             [-next,v2,17/25] spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
             [-next,v2,18/25] spi: microchip-core: Use helper function devm_clk_get_enabled()
             [-next,v2,19/25] spi: mtk-snfi: Use helper function devm_clk_get_enabled()
             [-next,v2,20/25] spi: npcm-fiu: Use helper function devm_clk_get_enabled()
             [-next,v2,21/25] spi: orion: Use helper function devm_clk_get_enabled()
             [-next,v2,22/25] spi: pic32-sqi: Use helper function devm_clk_get_enabled()
             [-next,v2,23/25] spi: pic32: Use helper function devm_clk_get_enabled()
             [-next,v2,24/25] spi: spl022: Use helper function devm_clk_get_enabled()
             [-next,v2,25/25] spi: rockchip: Use helper function devm_clk_get_enabled()

Patch: spi: tegra: Fix missing IRQ check in tegra_slink_probe()
  Submitter: Zhang Shurong <zhang_shurong@foxmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=779590
  Lore link: https://lore.kernel.org/r/tencent_73FCC06A3D1C14EE5175253C6FB46A07B709@qq.com

Patch: spi: intel-pci: Add support for Granite Rapids SPI serial flash
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=782832
  Lore link: https://lore.kernel.org/r/20230911074616.3473347-1-mika.westerberg@linux.intel.com

Patch: [V2] spi: spi-cadence-quadspi: add runtime pm support
  Submitter: Dhruva Gole <d-gole@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=780117
  Lore link: https://lore.kernel.org/r/20230829062706.786637-1-d-gole@ti.com

Patch: spi: stm32: add a delay before SPI disable
  Submitter: Valentin Caron <valentin.caron@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=782003
  Lore link: https://lore.kernel.org/r/20230906132735.748174-1-valentin.caron@foss.st.com


Total patches: 73

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


