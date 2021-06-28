Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87A3B648E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jun 2021 17:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhF1PKf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Jun 2021 11:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236075AbhF1PHk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Jun 2021 11:07:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE31F61353;
        Mon, 28 Jun 2021 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624892123;
        bh=Xo2uxg0gdkERHQKdt0tYaND/cr8tkQoG+SSzAQ1lmdM=;
        h=From:To:Cc:Subject:Date:From;
        b=j5Ppfu0fCcwhsWj3jaqC1qywu7Jka+v8nPQKWrXJFvSMYS6Wk4FaNX+6Q/J/z0KIw
         udWrKowLuwAK0wTVQd+eGQFquYjG5y6ZXUFRCejHl2tcjpVegJFSGfoVgTKpuqdMwf
         NrKZhs1KNGa63NzvRV5Vu0tWj+LWPSXsBUKK+9zLvnaVOCdCBWiX//jWwAJF1cUK0g
         qYeMp/GPlZmCwztIYeEDIGW1dh+GPy00IKz2GU93H/OadJMQaziD6NKJw+/ODD9b/f
         CV/0t6CzDRQe40zBIj7DwHeKpAkIv7h995OZvYjW3P/2WIr7k6CMcVjqpCXlZWXylS
         q5/+7nDbLQ1Iw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v5.14
Date:   Mon, 28 Jun 2021 15:54:43 +0100
Message-Id: <20210628145522.BE31F61353@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.14

for you to fetch changes up to 1bee1ecf232cd90ad112d78ab5124850b4e5ea09:

  Merge remote-tracking branch 'spi/for-5.14' into spi-next (2021-06-25 14:08:26 +0100)

----------------------------------------------------------------
spi: Updates for v5.14

The biggest single thing in the diffstat here is a massive overhaul of
the PXA2xx driver from Andy Shevchenko (the IP is still in use on modern
Intel systems), though we also have quite a lot of core work as well:

 - Better support for mixing native and GPIO chip selects also from
   Andy.
 - Support for devices with multiple chip selects from Sebastian
   Reichel.
 - Helper for polling status registers in spi-mem from Patrice Chotard.
 - Support for Renesas RZ/N1 and Rockchip RV1126.

----------------------------------------------------------------
Andy Shevchenko (34):
      spi: Allow to have all native CSs in use along with GPIOs
      spi: Avoid undefined behaviour when counting unused native CSs
      spi: pxa2xx: Use one point of return when ->probe() fails
      spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
      spi: pxa2xx: Utilize struct device from struct ssp_device
      spi: pxa2xx: Replace header inclusions by forward declarations
      spi: pxa2xx: Unify ifdeffery used in the headers
      spi: pxa2xx: Group Intel Quark specific definitions
      spi: pxa2xx: Introduce int_stop_and_reset() helper
      spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
      spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
      spi: pxa2xx: Extract pxa2xx_spi_update() helper
      spi: pxa2xx: Extract clear_SSCR1_bits() helper
      spi: pxa2xx: Extract read_SSSR_bits() helper
      spi: pxa2xx: Constify struct driver_data parameter
      spi: pxa2xx: Introduce special type for Merrifield SPIs
      spi: Convert to use predefined time multipliers
      spi: Use SPI_MODE_X_MASK
      spi: spidev: Use SPI_MODE_X_MASK
      spi: npcm-pspi: Use SPI_MODE_X_MASK
      spi: oc-tiny: Use SPI_MODE_X_MASK
      spi: omap-uwire: Use SPI_MODE_X_MASK
      spi: ppc4xx: Use SPI_MODE_X_MASK
      spi: uniphier: Use SPI_MODE_X_MASK
      spi: pxa2xx: Propagate firmware node to the child SPI controller device
      spi: pxa2xx: Switch to use SPI core GPIO (descriptor) CS handling
      spi: pxa2xx: Switch to use SPI core GPIO (legacy) CS handling
      spi: pxa2xx: Drop duplicate chip_select in struct chip_data
      spi: pxa2xx: Drop unneeded '!= 0' comparisons
      spi: pxa2xx: Fix printf() specifiers
      spi: pxa2xx: Fix style of and typos in the comments and messages
      spi: pxa2xx: Update documentation to point out that it's outdated
      spi: pxa2xx: Use predefined mask when programming FIFO thresholds
      spi: Enable tracing of the SPI setup CS selection

Charles Keepax (1):
      spi: Make of_register_spi_device also set the fwnode

Christophe JAILLET (2):
      spi: tegra114: Fix an error message
      spi: tegra210-quad: Fix an error message

Colin Ian King (1):
      spi: Fix self assignment issue with ancillary->mode

Dan Sneddon (2):
      spi: atmel: Switch to transfer_one transfer method
      spi: atmel: Reduce spin lock usage

David Bauer (2):
      spi: ath79: drop platform data
      spi: ath79: set number of chipselect lines

Geert Uytterhoeven (1):
      spi: dw-apb-ssi: Integrate Renesas RZ/N1 SPI controller

Greg Kroah-Hartman (1):
      spi: remove spi_set_cs_timing()

Jay Fang (6):
      spi: ppc4xx: include <linux/io.h> instead of <asm/io.h>
      spi: omap-100k: Clean the value of 'status' is not used
      spi: delete repeated words in comments
      spi: spi-loopback-test: Fix 'tx_buf' might be 'rx_buf'
      spi: spi-topcliff-pch: Fix potential double free in pch_spi_process_messages()
      spi: hisi-kunpeng: Add debugfs support

Jiapeng Chong (1):
      spi: pxa2xx: Fix inconsistent indenting

Jon Lin (6):
      spi: rockchip: add compatible string for rv1126
      spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
      spi: rockchip: Wait for STB status in slave mode tx_xfer
      spi: rockchip: Support cs-gpio
      spi: rockchip: Support SPI_CS_HIGH
      spi: spi-rockchip: add description for rv1126

Lukas Wunner (1):
      spi: bcm2835: Allow arbitrary number of slaves

Marco Felsch (1):
      spi: add of_device_uevent_modalias support

Mark Brown (11):
      Merge existing fixes from spi/for-5.13
      Merge series "spi: pxa2xx: Set of cleanups" from Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
      Merge series "spi: Set of cleanups" from Jay Fang <f.fangjian@huawei.com>:
      Merge series "spi: pxa2xx: Set of cleanups" from Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
      Merge series "drivers: spi - add parenthesis for sizeof" from Zhiqi Song <songzhiqi1@huawei.com>:
      Merge branch 'for-5.13' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi into spi-5.14
      Merge series "MTD: spinand: Add spi_mem_poll_status() support" from <patrice.chotard@foss.st.com> Patrice Chotard <patrice.chotard@foss.st.com>:
      Merge series "Support ROCKCHIP SPI new feature" from Jon Lin <jon.lin@rock-chips.com>:
      Merge remote-tracking branch 'spi/for-5.12' into spi-linus
      Merge remote-tracking branch 'spi/for-5.13' into spi-linus
      Merge remote-tracking branch 'spi/for-5.14' into spi-next

Mauro Carvalho Chehab (1):
      spi: fix some invalid char occurrences

Mirko Vogt (1):
      spi: spi-sun6i: Fix chipselect/clock bug

Nobuhiro Iwamatsu (3):
      spi: convert Cadence SPI bindings to YAML
      spi: xilinx: convert to yaml
      spi: convert Xilinx Zynq UltraScale+ MPSoC GQSPI bindings to YAML

Patrice Chotard (5):
      spi: spi-mem: add automatic poll status functions
      mtd: spinand: use the spi-mem poll status APIs
      spi: stm32-qspi: add automatic poll status feature
      spi: stm32-qspi: Fix W=1 build warning
      spi: stm32-qspi: Remove unused qspi field of struct stm32_qspi_flash

Sebastian Reichel (2):
      spi: add ancillary device support
      spi: dt-bindings: support devices with multiple chipselects

Tian Tao (1):
      spi: omap-100k: Fix the length judgment problem

Vinod Koul (1):
      spi: core: add dma_map_dev for dma device

Wolfram Sang (2):
      spi: spi-rspi: : use proper DMAENGINE API for termination
      spi: spi-sh-msiof: : use proper DMAENGINE API for termination

Yang Yingliang (1):
      spi: spi-mem: fix doc warning in spi-mem.c

Zhiqi Song (7):
      spi: lm70llp: add parenthesis for sizeof
      spi: mpc512x-psc: add parenthesis for sizeof
      spi: mpc52xx: add parenthesis for sizeof
      spi: mpc52xx-psc: add parenthesis for sizeof
      spi: omap2-mcspi: add parenthesis for sizeof
      spi: omap-uwire: add parenthesis for sizeof
      spi: ppc4xx: add parenthesis for sizeof

Zou Wei (1):
      spi: altera: Remove redundant dev_err call in dfl_spi_altera_probe()

zpershuai (2):
      spi: meson-spicc: fix a wrong goto jump for avoiding memory leak.
      spi: meson-spicc: fix memory leak in meson_spicc_probe

 .../devicetree/bindings/spi/renesas,rzn1-spi.txt   |  11 -
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   6 +
 .../devicetree/bindings/spi/spi-cadence.txt        |  30 --
 .../devicetree/bindings/spi/spi-cadence.yaml       |  66 ++++
 .../devicetree/bindings/spi/spi-controller.yaml    |   7 +-
 .../devicetree/bindings/spi/spi-rockchip.yaml      |   1 +
 .../devicetree/bindings/spi/spi-xilinx.txt         |  23 --
 .../devicetree/bindings/spi/spi-xilinx.yaml        |  57 +++
 .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    |  25 --
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |  51 +++
 Documentation/spi/pxa2xx.rst                       |  58 +--
 drivers/mtd/nand/spi/core.c                        |  45 ++-
 drivers/spi/Kconfig                                |   1 +
 drivers/spi/spi-altera-dfl.c                       |   4 +-
 drivers/spi/spi-ath79.c                            |   9 +-
 drivers/spi/spi-atmel.c                            | 139 ++------
 drivers/spi/spi-bcm2835.c                          | 204 ++++++-----
 drivers/spi/spi-bcm2835aux.c                       |   2 +-
 drivers/spi/spi-dw-mmio.c                          |   2 +-
 drivers/spi/spi-geni-qcom.c                        |   4 +-
 drivers/spi/spi-hisi-kunpeng.c                     |  51 ++-
 drivers/spi/spi-lm70llp.c                          |   2 +-
 drivers/spi/spi-loopback-test.c                    |   2 +-
 drivers/spi/spi-mem.c                              |  88 ++++-
 drivers/spi/spi-meson-spicc.c                      |   8 +-
 drivers/spi/spi-mpc512x-psc.c                      |   4 +-
 drivers/spi/spi-mpc52xx-psc.c                      |   4 +-
 drivers/spi/spi-mpc52xx.c                          |   2 +-
 drivers/spi/spi-npcm-pspi.c                        |   2 +-
 drivers/spi/spi-nxp-fspi.c                         |  11 +-
 drivers/spi/spi-oc-tiny.c                          |   2 +-
 drivers/spi/spi-omap-100k.c                        |   6 +-
 drivers/spi/spi-omap-uwire.c                       |   4 +-
 drivers/spi/spi-omap2-mcspi.c                      |   4 +-
 drivers/spi/spi-pl022.c                            |   4 +-
 drivers/spi/spi-ppc4xx.c                           |  10 +-
 drivers/spi/spi-pxa2xx-dma.c                       |  41 +--
 drivers/spi/spi-pxa2xx-pci.c                       |  11 +-
 drivers/spi/spi-pxa2xx.c                           | 387 +++++++++------------
 drivers/spi/spi-pxa2xx.h                           |  68 ++--
 drivers/spi/spi-rockchip.c                         |  55 ++-
 drivers/spi/spi-rspi.c                             |   6 +-
 drivers/spi/spi-sh-msiof.c                         |   4 +-
 drivers/spi/spi-stm32-qspi.c                       |  88 ++++-
 drivers/spi/spi-sun6i.c                            |   6 +-
 drivers/spi/spi-tegra114.c                         |   3 +-
 drivers/spi/spi-tegra20-slink.c                    |   5 +
 drivers/spi/spi-tegra210-quad.c                    |   2 +-
 drivers/spi/spi-topcliff-pch.c                     |   4 +-
 drivers/spi/spi-uniphier.c                         |   2 +-
 drivers/spi/spi.c                                  | 275 ++++++++-------
 drivers/spi/spidev.c                               |   2 +-
 include/linux/mtd/spinand.h                        |  22 ++
 include/linux/platform_data/spi-ath79.h            |  16 -
 include/linux/pxa2xx_ssp.h                         |  51 ++-
 include/linux/spi/pxa2xx_spi.h                     |  21 +-
 include/linux/spi/spi-mem.h                        |  16 +
 include/linux/spi/spi.h                            |   8 +-
 include/trace/events/spi.h                         |  57 +++
 sound/soc/pxa/pxa-ssp.c                            |  16 -
 60 files changed, 1256 insertions(+), 859 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
 delete mode 100644 include/linux/platform_data/spi-ath79.h
