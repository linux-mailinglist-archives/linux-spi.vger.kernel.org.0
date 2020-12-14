Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DDE2D9A4B
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407685AbgLNOtY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 09:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408255AbgLNOtQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Dec 2020 09:49:16 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v5.11
Date:   Mon, 14 Dec 2020 14:48:10 +0000
Message-Id: <20201214144830.39E172253A@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.11

for you to fetch changes up to 3e98a021cc85e7d52acdd1eae8a988e975ec5bf9:

  Merge remote-tracking branch 'spi/for-5.11' into spi-next (2020-12-11 17:49:01 +0000)

----------------------------------------------------------------
spi: Updates for v5.11

The big change this release has been some excellent work from Lukas
Wunner which closes a bunch of holes in the cleanup paths for drivers,
mainly introduced as a result of devm conversions causing bad
interactions with the support SPI has for allocating the bus and driver
data together.  Together with some of the other work done it feels like
we've turned the corner on several long standing pain points with the
API.

 - Many cleanups around probe/remove and error handling from Lukas
   Wunner and Uwe Kleine-König, and further fixes around PM from Zhang
   Qilong.
 - Provide a mask for which bits of the mode can safely be configured by
   drivers and use that to fix an issue with the ADS7846 driver.
 - Documentation of the expected interactions between SPI and GPIO level
   chip select polarity configuration from H. Nikolaus Schaller,
   hopefully we're pretty much at the end of sorting out the
   interactions there.  Thanks to Nikolaus, Sven Van Asbroeck and Linus
   Walleij for this.
 - DMA support for Allwinner sun6i controllers.
 - Support for Canaan K210 Designware implementations and Intel Adler Lake.

----------------------------------------------------------------
Alexander Kochetkov (3):
      spi: spi-sun6i: implement DMA-based transfer mode
      spi: rockchip: enable autosuspend feature
      spi: spi-sun6i: enable autosuspend feature

Damien Le Moal (3):
      dt-bindings: spi: dw-apb-ssi: Add Canaan K210 SPI controller
      spi: dw: Add support for 32-bits max xfer size
      spi: dw: Add support for the Canaan K210 SoC SPI

Fabio Estevam (1):
      spi: imx: Remove unused .id_table support

H. Nikolaus Schaller (1):
      spi: dt-bindings: clarify CS behavior for spi-cs-high and gpio descriptors

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Alder Lake PCH-S

Lukas Wunner (21):
      spi: atmel-quadspi: Disable clock in probe error path
      spi: synquacer: Disable clock in probe error path
      spi: pic32: Don't leak DMA channels in probe error path
      spi: st-ssc4: Fix unbalanced pm_runtime_disable() in probe error path
      spi: davinci: Fix use-after-free on unbind
      spi: spi-geni-qcom: Fix use-after-free on unbind
      spi: spi-qcom-qspi: Fix use-after-free on unbind
      spi: spi-sh: Fix use-after-free on unbind
      spi: pxa2xx: Fix use-after-free on unbind
      spi: rpc-if: Fix use-after-free on unbind
      spi: mxic: Don't leak SPI master in probe error path
      spi: spi-mtk-nor: Don't leak SPI master in probe error path
      spi: gpio: Don't leak SPI master in probe error path
      spi: rb4xx: Don't leak SPI master in probe error path
      spi: sc18is602: Don't leak SPI master in probe error path
      media: netup_unidvb: Don't leak SPI master in probe error path
      spi: mt7621: Disable clock in probe error path
      spi: mt7621: Don't leak SPI master in probe error path
      spi: ar934x: Don't leak SPI master in probe error path
      spi: npcm-fiu: Disable clock in probe error path
      spi: atmel-quadspi: Fix use-after-free on unbind

Marek Szyprowski (1):
      spi: Fix potential NULL pointer dereference in spi_shutdown()

Mark Brown (9):
      Merge existing fixes from spi/for-5.10
      Merge series "SPI/ Input: ads7846: properly handle spi->mode flags" from Oleksij Rempel <o.rempel@pengutronix.de>:
      Merge series "add axi clock control for MT8192 spi-nor" from Bayi Cheng <bayi.cheng@mediatek.com>:
      Merge branch 'for-5.10' of https://git.kernel.org/.../broonie/spi into spi-5.11
      Merge series "spi: atmel-quadspi: Fix AHB memory accesses" from Tudor Ambarus <tudor.ambarus@microchip.com>:
      Merge series "spi: spi-geni-qcom: Use gpio descriptors for CS" from Stephen Boyd <swboyd@chromium.org>:
      Merge remote-tracking branch 'spi/for-5.9' into spi-linus
      Merge remote-tracking branch 'spi/for-5.10' into spi-linus
      Merge remote-tracking branch 'spi/for-5.11' into spi-next

Mauro Carvalho Chehab (1):
      spi: fix a typo inside a kernel-doc markup

Maxim Kochetkov (1):
      spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR

Oleksij Rempel (2):
      spi: introduce SPI_MODE_X_MASK macro
      Input: ads7846: do not overwrite spi->mode flags set by spi framework

Qing Zhang (1):
      spi: amd: Use devm_platform_ioremap_resource() in amd_spi_probe

Qinglang Miao (2):
      spi: mt7621: fix missing clk_disable_unprepare() on error in mt7621_spi_probe
      spi: bcm63xx-hsspi: fix missing clk_disable_unprepare() on error in bcm63xx_hsspi_resume

Randy Dunlap (1):
      spi: dw: fix build error by selecting MULTIPLEXER

Rasmus Villemoes (1):
      spi: fsl: fix use of spisel_boot signal on MPC8309

Serge Semin (1):
      spi: dw-bt1: Fix undefined devm_mux_control_get symbol

Stephen Boyd (3):
      platform/chrome: cros_ec_spi: Don't overwrite spi::mode
      platform/chrome: cros_ec_spi: Drop bits_per_word assignment
      spi: spi-geni-qcom: Use the new method of gpio CS control

Tian Tao (1):
      spi: dw: fixed missing resource_size

Tudor Ambarus (6):
      spi: atmel: Downgrade to dev_dbg when dma_request_chan() fails
      spi: atmel-quadspi: Fix AHB memory accesses
      spi: atmel-quadspi: Drop superfluous set of QSPI_IFR_APBTFRTYP_READ
      spi: atmel-quadspi: Write QSPI_IAR only when needed
      spi: atmel-quadspi: Move common code outside of if else
      spi: Limit the spi device max speed to controller's max speed

Uwe Kleine-König (3):
      spi: fix resource leak for drivers without .remove callback
      spi: Use bus_type functions for probe, remove and shutdown
      spi: Warn when a driver's remove callback returns an error

Yash Shah (1):
      spi: Update DT binding docs to support SiFive FU740 SoC

YueHaibing (1):
      spi: spi-mem: Fix passing zero to 'PTR_ERR' warning

Zhang Changzhong (1):
      spi: dw: Fix error return code in dw_spi_bt1_probe()

Zhang Qilong (11):
      spi: img-spfi: fix reference leak in img_spfi_resume
      spi: spi-mem: fix reference leak in spi_mem_access_start
      spi: stm32: fix reference leak in stm32_spi_resume
      spi: stm32-qspi: fix reference leak in stm32 qspi operations
      spi: spi-ti-qspi: fix reference leak in ti_qspi_setup
      spi: tegra20-slink: fix reference leak in slink ops of tegra20
      spi: tegra20-sflash: fix reference leak in tegra_sflash_resume
      spi: tegra114: fix reference leak in tegra spi ops
      spi: imx: fix reference leak in two imx operations
      spi: sprd: fix reference leak in sprd_spi_remove
      spi: mxs: fix reference leak in mxs_spi_probe

bayi cheng (1):
      spi: spi-mtk-nor: add axi clock control for MT8192 spi-nor

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   2 +
 .../devicetree/bindings/spi/spi-controller.yaml    |  27 +++
 .../devicetree/bindings/spi/spi-sifive.yaml        |  10 +-
 drivers/input/touchscreen/ads7846.c                |   3 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_spi.c  |   5 +-
 drivers/platform/chrome/cros_ec_spi.c              |   2 -
 drivers/spi/Kconfig                                |   4 +-
 drivers/spi/atmel-quadspi.c                        |  42 ++---
 drivers/spi/spi-amd.c                              |   5 +-
 drivers/spi/spi-ar934x.c                           |  14 +-
 drivers/spi/spi-atmel.c                            |   6 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |   4 +-
 drivers/spi/spi-davinci.c                          |   2 +-
 drivers/spi/spi-dw-bt1.c                           |   6 +-
 drivers/spi/spi-dw-core.c                          |  44 ++++-
 drivers/spi/spi-dw-mmio.c                          |  16 ++
 drivers/spi/spi-dw.h                               |   5 +
 drivers/spi/spi-fsl-dspi.c                         |   6 +-
 drivers/spi/spi-fsl-spi.c                          |  11 +-
 drivers/spi/spi-geni-qcom.c                        |   4 +-
 drivers/spi/spi-gpio.c                             |  15 +-
 drivers/spi/spi-img-spfi.c                         |   4 +-
 drivers/spi/spi-imx.c                              |  33 +---
 drivers/spi/spi-mem.c                              |   3 +-
 drivers/spi/spi-mt7621.c                           |  11 +-
 drivers/spi/spi-mtk-nor.c                          |  18 +-
 drivers/spi/spi-mxic.c                             |  10 +-
 drivers/spi/spi-mxs.c                              |   1 +
 drivers/spi/spi-npcm-fiu.c                         |   8 +-
 drivers/spi/spi-pic32.c                            |   1 +
 drivers/spi/spi-pxa2xx.c                           |  10 +-
 drivers/spi/spi-qcom-qspi.c                        |  42 ++---
 drivers/spi/spi-rb4xx.c                            |   2 +-
 drivers/spi/spi-rockchip.c                         |   4 +
 drivers/spi/spi-rpc-if.c                           |   9 +-
 drivers/spi/spi-sc18is602.c                        |  13 +-
 drivers/spi/spi-sh.c                               |  13 +-
 drivers/spi/spi-sprd.c                             |   1 +
 drivers/spi/spi-st-ssc4.c                          |   5 +-
 drivers/spi/spi-stm32-qspi.c                       |   8 +-
 drivers/spi/spi-stm32.c                            |   1 +
 drivers/spi/spi-sun6i.c                            | 199 +++++++++++++++++++--
 drivers/spi/spi-synquacer.c                        |  15 +-
 drivers/spi/spi-tegra114.c                         |   2 +
 drivers/spi/spi-tegra20-sflash.c                   |   1 +
 drivers/spi/spi-tegra20-slink.c                    |   2 +
 drivers/spi/spi-ti-qspi.c                          |   1 +
 drivers/spi/spi.c                                  |  70 ++++----
 include/linux/spi/spi.h                            |   1 +
 49 files changed, 482 insertions(+), 239 deletions(-)
