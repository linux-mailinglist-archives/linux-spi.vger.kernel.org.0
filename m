Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1336231C32D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 21:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBOUq2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 15:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBOUqO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 15 Feb 2021 15:46:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC35B64DF0;
        Mon, 15 Feb 2021 20:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613421933;
        bh=wau8Ed2DmmRd12M9HZuBtrzDRBepMcAbXGtWcZONCxs=;
        h=From:To:Cc:Subject:Date:From;
        b=D75YW44F9p9q3NH6eg04eO8/JTwnv6mm6IQx6t/hpY6b1VNQoDckhMy7R2Ro3epCp
         X+sHd9fVD5GmeR9LhV6YpKm7XS8GZr6r7cN7qAAuiA/OfWqmnsza7pqLDCvmsrCaLy
         EyI2yEhWAYgLKAEyjfgSmd9cOOnzPmtSRQ3Z7I6kxtT9dFEyARwOU/mRPw2PnVtZfh
         VD2WSvBF8nGljbXQmWwMJE9QsodsQ9B7x89U4sbCyIGNDtshKaDOz4Su8SYfE45TRn
         MhBRb1QzDE2bioD42RwRgr0kUrBkmS5xfU2uVG07vsZCKCe385Y7Hy4ZvA8ZlbjpZ9
         6jNfIHRpE4kjg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v5.12
Date:   Mon, 15 Feb 2021 20:44:23 +0000
Message-Id: <20210215204532.AC35B64DF0@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.12

for you to fetch changes up to eec262d179ff60e8d12298ab2f118661040e0bf5:

  Merge remote-tracking branch 'spi/for-5.12' into spi-next (2021-02-12 14:00:22 +0000)

----------------------------------------------------------------
spi: Updates for v5.12

The main focus of this release from a framework point of view has been
spi-mem where we've acquired support for a few new hardware features
which enable better performance on suitable hardware.  Otherwise mostly
thanks to Arnd's cleanup efforts on old platforms we've removed several
obsolete drivers which just about balance out the newer drivers we've
added this cycle.

 - Allow drivers to flag if they are unidirectional.
 - Support for DTR mode and hardware acceleration of dummy cycles in spi-mem.
 - Support for Allwinder H616, Intel Lightning Mountain, nVidia Tegra
   QuadSPI, Realtek RTL838x and RTL839x.
 - Removal of obsolute EFM32, Txx9 and SIRF Prima and Atlas drivers.

----------------------------------------------------------------
Adam Ford (1):
      spi: renesas rpc-if: Update Add RZ/G2 to Kconfig description

Alain Volmat (5):
      spi: stm32: properly handle 0 byte transfer
      spi: stm32: do not mandate cs_gpio
      spi: stm32h7: ensure message are smaller than max size
      spi: stm32: defer probe for reset
      spi: stm32: make spurious and overrun interrupts visible

Alexandru Ardelean (3):
      spi: uapi: unify SPI modes into a single spi.h header
      spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties
      spi: stm32: update dev_dbg() print format for SPI params

Amelie Delaunay (2):
      spi: stm32: use bitfield macros
      spi: stm32h7: replace private SPI_1HZ_NS with NSEC_PER_SEC

Andre Przywara (1):
      dt-bindings: spi: sunxi: Add H616 compatible string

Andy Shevchenko (2):
      spi: pxa2xx: Fix the controller numbering for Wildcat Point
      spi: pxa2xx: Add IDs for the controllers found on Intel Lynxpoint

Arnd Bergmann (1):
      spi: remove sirf prima/atlas driver

Bert Vermeulen (2):
      spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SPI controllers
      spi: Realtek RTL838x/RTL839x SPI controller

Bhaskar Chowdhury (1):
      spi: Change provied to provided in the file spi.h

Dragos Bogdan (1):
      spi: Add SPI_NO_TX/RX support

Etienne Carriere (1):
      spi: stm32: driver uses reset controller only at init

Geert Uytterhoeven (2):
      spi: sh-msiof: Fill in spi_transfer.effective_speed_hz
      spi: sh-msiof: Fill in controller speed limits

Guido Günther (1):
      spi: imx: Don't print error on -EPROBEDEFER

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Alder Lake PCH-P

Junhao He (1):
      spi: clps711xx: remove redundant white-space

Kees Cook (1):
      spi: dw: Avoid stack content exposure

Lad Prabhakar (2):
      spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
      spi: rpc-if: Gaurd .pm assignment with CONFIG_PM_SLEEP #ifdef check

Marcin Wojtas (2):
      spi: orion: enable clocks before spi_setup
      spi: orion: enable support for switching CS every transferred byte

Marek Vasut (1):
      spi: stm32: Simplify stm32h7_spi_prepare_fthlv()

Mark Brown (10):
      Merge existing fixes from spi/for-5.11
      Merge series "Add Tegra Quad SPI driver" from Sowjanya Komatineni <skomatineni@nvidia.com>:
      Merge series "spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC" from "Ramuthevar, Vadivel MuruganX" <vadivel.muruganx.ramuthevar@linux.intel.com>:
      Merge series "spi: sh-msiof: Advertize bit rate limits and actual speed" from Geert Uytterhoeven <geert+renesas@glider.be>:
      Merge v5.11-rc3
      Merge series "Remove ARM platform efm32" from Uwe Kleine-König <u.kleine-koenig@pengutronix.de> Uwe Kleine-König <uwe.kleine-koenig@pengutronix.de>:
      Merge series "spi: Add support for Realtek RTL838x/RTL839x SoC SPI" from Bert Vermeulen <bert@biot.com>:
      Merge series "spi: add set_cs_timing support for HW/SW CS mode" from Leilk Liu <leilk.liu@mediatek.com>:
      Merge remote-tracking branch 'spi/for-5.11' into spi-linus
      Merge remote-tracking branch 'spi/for-5.12' into spi-next

Masahisa Kojima (1):
      spi: spi-synquacer: fix set_cs handling

Nicolas Saenz Julienne (1):
      spi: Skip zero-length transfers in spi_transfer_one_message()

Pan Bian (1):
      spi: atmel: Put allocated master before return

Pratyush Yadav (10):
      spi: cadence-quadspi: Set master max_speed_hz
      spi: cadence-quadspi: Abort read if dummy cycles required are too many
      spi: cadence-quadspi: Set dummy cycles from STIG commands
      spi: cadence-quadspi: Fix dummy cycle calculation when buswidth > 1
      spi: cadence-quadspi: Implement a simple supports_op hook
      spi: cadence-quadspi: Wait at least 500 ms for direct reads
      spi: cadence-quadspi: Add DTR support
      spi: cadence-quadspi: Fix build warning on 32-bit platforms
      spi: spi-mem: add spi_mem_dtr_supports_op()
      spi: cadence-quadspi: Use spi_mem_dtr_supports_op()

Ramuthevar Vadivel Murugan (5):
      spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
      spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
      spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
      spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
      dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi

Rasmus Villemoes (1):
      spi: fsl: invert spisel_boot signal on MPC8309

Richard Fitzgerald (1):
      spi: bcm2835: Set controller max_speed_hz

Sergiu Cuciurean (1):
      spi: spi-mpc52xx: Use new structure for SPI transfer delays

Sowjanya Komatineni (6):
      dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
      dt-bindings: spi: Add Tegra Quad SPI device tree binding
      MAINTAINERS: Add Tegra Quad SPI driver section
      spi: tegra210-quad: Add support for Tegra210 QSPI controller
      spi: spi-mem: Mark dummy transfers by setting dummy_data bit
      spi: tegra210-quad: Add support for hardware dummy cycles transfer

Stephen Boyd (1):
      spi: spi-qcom-qspi: Use irq trigger flags from firmware

Thomas Bogendoerfer (1):
      spi: txx9: Remove driver

Tudor Ambarus (1):
      spi: atmel-quadspi: Disable the QSPI IP at suspend()

Uwe Kleine-König (1):
      spi: Drop unused efm32 bus driver

Vincent Pelletier (3):
      spi: bcm2835: Call the dedicated transfer completion function.
      spi: rockchip: Call the dedicated transfer completion function.
      spi: bcm2835aux: Call the dedicated transfer completion function.

Wolfram Sang (1):
      spi: renesas,sh-msiof: Add r8a779a0 support

YANG LI (1):
      spi: spi-bcm-qspi: style: Simplify bool comparison

Yanteng Si (1):
      spi: Fix distinct pointer types warning for ARCH=mips

Yicong Yang (2):
      spi: hisi-sfc-v3xx: extend version checking compatibility
      spi: hisi-sfc-v3xx: add address mode check

corentin (3):
      spi: spi-au1550: Add suffix "int" to all "unsigned"
      spi: spi-au1550: quoted string break
      spi: spi-au1550: Fix various whitespace warnings

leilk.liu (3):
      spi: add power control when set_cs_timing
      spi: support CS timing for HW & SW mode
      spi: mediatek: add set_cs_timing support

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |    1 +
 .../bindings/{mtd => spi}/cadence-quadspi.txt      |    1 +
 .../bindings/spi/nvidia,tegra210-quad.yaml         |  117 ++
 .../devicetree/bindings/spi/realtek,rtl-spi.yaml   |   41 +
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |    1 +
 .../devicetree/bindings/spi/spi-controller.yaml    |    6 +-
 Documentation/devicetree/bindings/spi/spi-sirf.txt |   42 -
 MAINTAINERS                                        |    8 +
 drivers/spi/Kconfig                                |   33 +-
 drivers/spi/Makefile                               |    5 +-
 drivers/spi/atmel-quadspi.c                        |    1 +
 drivers/spi/spi-atmel.c                            |    2 +-
 drivers/spi/spi-au1550.c                           |   53 +-
 drivers/spi/spi-bcm-qspi.c                         |    2 +-
 drivers/spi/spi-bcm2835.c                          |    8 +-
 drivers/spi/spi-bcm2835aux.c                       |    2 +-
 drivers/spi/spi-cadence-quadspi.c                  |  333 ++++-
 drivers/spi/spi-clps711x.c                         |    2 +-
 drivers/spi/spi-dw-bt1.c                           |    2 +-
 drivers/spi/spi-efm32.c                            |  462 -------
 drivers/spi/spi-fsl-spi.c                          |    2 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |   33 +-
 drivers/spi/spi-imx.c                              |    2 +-
 drivers/spi/spi-mem.c                              |   23 +-
 drivers/spi/spi-mpc52xx.c                          |    4 +-
 drivers/spi/spi-mt65xx.c                           |   72 +-
 drivers/spi/spi-orion.c                            |   55 +-
 drivers/spi/spi-pxa2xx-pci.c                       |   29 +-
 drivers/spi/spi-pxa2xx.c                           |    4 +
 drivers/spi/spi-qcom-qspi.c                        |    3 +-
 drivers/spi/spi-realtek-rtl.c                      |  209 +++
 drivers/spi/spi-rockchip.c                         |    2 +-
 drivers/spi/spi-rpc-if.c                           |   13 +-
 drivers/spi/spi-sh-msiof.c                         |   14 +-
 drivers/spi/spi-sirf.c                             | 1236 -----------------
 drivers/spi/spi-stm32.c                            |  150 +--
 drivers/spi/spi-synquacer.c                        |    4 +
 drivers/spi/spi-tegra210-quad.c                    | 1410 ++++++++++++++++++++
 drivers/spi/spi-txx9.c                             |  477 -------
 drivers/spi/spi.c                                  |   59 +-
 include/dt-bindings/clock/tegra210-car.h           |    2 +-
 include/linux/platform_data/efm32-spi.h            |   15 -
 include/linux/spi/spi-mem.h                        |    9 +
 include/linux/spi/spi.h                            |   44 +-
 include/uapi/linux/spi/spi.h                       |   41 +
 include/uapi/linux/spi/spidev.h                    |   30 +-
 46 files changed, 2519 insertions(+), 2545 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/cadence-quadspi.txt (97%)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sirf.txt
 delete mode 100644 drivers/spi/spi-efm32.c
 create mode 100644 drivers/spi/spi-realtek-rtl.c
 delete mode 100644 drivers/spi/spi-sirf.c
 create mode 100644 drivers/spi/spi-tegra210-quad.c
 delete mode 100644 drivers/spi/spi-txx9.c
 delete mode 100644 include/linux/platform_data/efm32-spi.h
 create mode 100644 include/uapi/linux/spi/spi.h
