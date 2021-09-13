Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32DB4089D9
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 13:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbhIMLJ2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 07:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239238AbhIMLJ1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 13 Sep 2021 07:09:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 32BD261029;
        Mon, 13 Sep 2021 11:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631531292;
        bh=+DRa/s15kFiY4WofwXCgapKWJ0f6i2DQAjOaaA11FYY=;
        h=Subject:From:Date:To:From;
        b=sLR59FtJoIxowTMd+QVA3JC3BvZH6J8/eGe9V7kHbdXMwYEeLjnaktwsgLmrqLX/C
         AIGaeLkiGkiYGpcHCW22id7Oja2EMKmBvAAiCfxNCiuOE7eQLVR2vkl7ghpFCNn5z3
         S2fh+noq1icnWDRGv/wiyk6CUSiNXBM4YoR32IAsiYl5Ck//fknmQM6N56AqmGuje4
         slMsoqsl9ekVik6XvhhAX3ijtWwdV8OTKnra0NPs0HcaGr0DNFFl8yw20mwkmJG4R/
         MR46iyVLYIMrAzwEusrkUdDUZOcHXZaEUxkByT3BZnKcGlZgBLHGGMxOhqX/0fFP48
         RaDttsvsrzQvg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2261B60A54;
        Mon, 13 Sep 2021 11:08:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163153129208.23411.13141505533565776605.git-patchwork-summary@kernel.org>
Date:   Mon, 13 Sep 2021 11:08:12 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: add ecspi ERR009165 for i.mx6/7 soc family
  Submitter: Robin Gong <yibin.gong@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=515115
  Lore link: https://lore.kernel.org/r/1626258052-22198-1-git-send-email-yibin.gong@nxp.com
    Patches: [v16,01/12] Revert "ARM: dts: imx6q: Use correct SDMA script for SPI5 core"
             [v16,02/12] Revert "ARM: dts: imx6: Use correct SDMA script for SPI cores"
             [v16,03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
             [v16,04/12] dmaengine: imx-sdma: remove duplicated sdma_load_context
             [v16,05/12] dmaengine: dma: imx-sdma: add fw_loaded and is_ram_script
             [v16,06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
             [v16,07/12] spi: imx: fix ERR009165
             [v16,08/12] spi: imx: remove ERR009165 workaround on i.mx6ul
             [v16,09/12] dmaengine: imx-sdma: remove ERR009165 on i.mx6ul
             [v16,10/12] dma: imx-sdma: add i.mx6ul compatible name
             [v16,11/12] dmaengine: imx-sdma: add uart rom script
             [v16,12/12] dmaengine: imx-sdma: add terminated list for freed descriptor in worker
Series: fpga/spi/hwmon: Initial support for Silicom N5010 PAC
  Submitter: Martin Hundebøll <martin@geanix.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=516701
  Lore link: https://lore.kernel.org/r/20210716135441.3235863-1-martin@geanix.com
    Patches: [v5,1/3] fpga: dfl: expose feature revision from struct dfl_device
             [v5,2/3] spi: spi-altera-dfl: support n5010 feature revision
             [v5,3/3] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
Series: [v2,1/4] spi: amd: Refactor code to use less spi_master_get_devdata
  Submitter: Lucas tanure <tanureal@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=544861
  Lore link: https://lore.kernel.org/r/20210910111529.12539-1-tanureal@opensource.cirrus.com
    Patches: [v2,1/4] spi: amd: Refactor code to use less spi_master_get_devdata
             [v2,2/4] spi: amd: Refactor amd_spi_busy_wait
             [v2,3/4] spi: amd: Remove unneeded variable
             [v2,4/4] spi: amd: Don't wait for a write-only transfer to finish
Patch: dt-bindings: More use 'enum' instead of 'oneOf' plus 'const' entries
  Submitter: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=544985
  Lore link: https://lore.kernel.org/r/20210910165153.2843871-1-robh@kernel.org
Series: GE Healthcare PPD firmware upgrade driver for ACHC
  Submitter: Sebastian Reichel <sebastian.reichel@collabora.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=525109
  Lore link: https://lore.kernel.org/r/20210802172309.164365-1-sebastian.reichel@collabora.com
    Patches: [PATCHv8,1/3] dt-bindings: misc: ge-achc: Convert to DT schema format
             [PATCHv8,2/3] ARM: dts: imx53-ppd: Fix ACHC entry
             [PATCHv8,3/3] misc: gehc-achc: new driver
Patch: [v2] dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=522117
  Lore link: https://lore.kernel.org/r/d81b59a513c2a5204c8378b4a89cd07f97c46797.1627401508.git.geert+renesas@glider.be
Patch: spi: dt-bindings: xilinx: Drop type reference on *-bits properties
  Submitter: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=544993
  Lore link: https://lore.kernel.org/r/20210910165945.2852999-1-robh@kernel.org

Total patches: 25

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


