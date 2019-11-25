Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF96108EDD
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2019 14:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfKYN3j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Nov 2019 08:29:39 -0500
Received: from foss.arm.com ([217.140.110.172]:50454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfKYN3i (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Nov 2019 08:29:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D867F31B;
        Mon, 25 Nov 2019 05:29:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53C423F68E;
        Mon, 25 Nov 2019 05:29:37 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:29:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL] SPI updates for v5.5
Message-ID: <20191125132935.GD4535@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
X-Cookie: -- Owen Meredith
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.5

for you to fetch changes up to e2ce328b282d0c7660576c25af6b9be34a6d2614:

  Merge remote-tracking branch 'spi/topic/ptp' into spi-next (2019-11-22 19:56:37 +0000)

----------------------------------------------------------------
spi: Updates for v5.5

Lots of stuff going on in the core for SPI this time around, the two big
changes both being around time in different forms:

 - A rework of delay times from Alexandru Ardelean which makes the ways
   in which they are specified more consistent between drivers so that
   what's available to clients is less dependent on the hardware
   implementation.
 - Support for PTP timestamping of transfers from Vladimir Oltean,
   useful for use with precision clocks with SPI control interfaces.
 - Big cleanups for the Atmel, PXA2xx and Zynq QSPI drivers.

----------------------------------------------------------------
Alexandru Ardelean (20):
      spi: move `cs_change_delay` backwards compat logic outside switch
      spi: introduce spi_delay struct as "value + unit" & spi_delay_exec()
      spi: make `cs_change_delay` the first user of the `spi_delay` logic
      spi: sprd: convert transfer word delay to spi_delay struct
      spi: orion: use new `word_delay` field for SPI transfers
      spi: spidev: use new `word_delay` field for spi transfers
      spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for spi_device
      spi: introduce `delay` field for `spi_transfer` + spi_transfer_delay_exec()
      spi: tegra114: use `spi_transfer_delay_exec` helper
      spi: tegra20-sflash: use to new `spi_transfer_delay_exec`
      spi: spi-loopback-test: use new `delay` field
      spi: spidev: use new `delay` field for spi transfers
      spi: tegra114: change format for `spi_set_cs_timing()` function
      spi: implement SW control for CS times
      spi: spi-fsl-espi: convert transfer delay to `spi_delay` format
      spi: spi-falcon: extend warning to `delay` as well
      spi: bcm63xx: extend error condition to `delay` as well
      spi: spi-axi: extend support for the `delay` field
      spi: use new `spi_transfer_delay_exec` helper where straightforward
      spi: document CS setup, hold & inactive times in header

Alvaro Gamez Machado (2):
      spi: xilinx: add description of new property xlnx,num-transfer-bits
      spi: xilinx: Add DT support for selecting transfer word width

Andy Shevchenko (8):
      spi: pxa2xx: No need to keep pointer to platform device
      spi: pxa2xx: Sort headers
      spi: pxa2xx: Convert pxa2xx_spi_get_port_id() to take struct device
      spi: pxa2xx: Convert to use device_get_match_data()
      spi: pxa2xx: Replace of_device.h with mod_devicetable.h and of.h
      spi: Fix spelling in the comments
      spi: pxa2xx: Drop extra check of platform_get_resource() returned value
      spi: pxa2xx: Introduce temporary variables to increase readability

Benjamin Gaignard (1):
      dt-bindings: spi: Convert stm32 QSPI bindings to json-schema

Chris Packham (3):
      spi: bcm2835: fix typo in comment
      spi: bcm-qspi: Convert to use CS GPIO descriptors
      spi: spi-mem: fallback to using transfers when CS gpios are used

Chuhong Yuan (5):
      spi: sifive: disable clk when probe fails and remove
      spi: nxp-fspi: Use devm API to fix missed unregistration of controller
      spi: pxa2xx: Add missed security checks
      spi: tegra20-slink: add missed clk_unprepare
      spi: st-ssc4: add missed pm_runtime_disable

Colin Ian King (1):
      spi: fsl-lpspi: clean up indentation issue

Daniel Vetter (1):
      spi: pxa2xx: Set controller->max_transfer_size in dma mode

Fabrizio Castro (1):
      dt-bindings: spi: sh-msiof: Add r8a774b1 support

Felipe Balbi (1):
      SPI: designware: pci: Switch over to MSI interrupts

Frieder Schrempf (1):
      spi: spi-fsl-qspi: Clear TDH bits in FLSHCR register

Gareth Williams (1):
      dt-bindings: snps,dw-apb-ssi: Add optional clock domain information

Geert Uytterhoeven (1):
      spi: rspi: Use platform_get_irq_byname_optional() for optional irqs

Gregory CLEMENT (10):
      spi: atmel: Remove AVR32 leftover
      spi: Fix SPI_CS_HIGH setting when using native and GPIO CS
      spi: atmel: Remove and fix erroneous comments
      spi: atmel: Fix CS high support
      spi: atmel: Configure GPIO per CS instead of by controller
      spi: atmel: Remove useless private field
      spi: atmel: Remove platform data support
      spi: atmel: Improve and fix GPIO CS usage
      spi: atmel: Improve CS0 case support on AT91RM9200
      spi: Fix NULL pointer when setting SPI_CS_HIGH for GPIO CS

Jarkko Nikula (4):
      spi: dw: Move runtime PM enable/disable from common to platform driver part
      spi: dw-pci: Fix Chip Select amount on Intel Elkhart Lake PSE SPI
      spi: pxa2xx: Add support for Intel Comet Lake-H
      spi: dw: Remove runtime PM enable/disable from common part of the driver

Krzysztof Kozlowski (1):
      spi: Fix Kconfig indentation

Kuldeep Singh (1):
      spi: spi-fsl-qspi: Introduce variable to fix different invalid master Id

Lingling Xu (2):
      spi: sprd: adi: Add missing lock protection when rebooting
      spi: sprd: adi: Set BIT_WDG_NEW bit when rebooting

Linus Walleij (4):
      spi: txx9: Convert to use GPIO descriptors
      spi: dw: Drop GPIO header
      spi: zynq-qspi: Drop GPIO header
      spi: fsl-cpm: Correct the free:ing

Luhua Xu (2):
      spi: add power control when set_cs
      spi: mediatek: add SPI_CS_HIGH support

Lukasz Majewski (2):
      spi: Add call to spi_slave_abort() function when spidev driver is released
      spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver

Mans Rullgard (1):
      spi: atmel: fix handling of cs_change set on non-last xfer

Mark Brown (5):
      Merge branch 'for-5.4' of https://git.kernel.org/.../broonie/spi into spi-5.5
      Merge tag 'v5.4-rc3' into spi-5.4
      Merge branch 'spi-5.4' into spi-linus
      Merge branch 'spi-5.5' into spi-next
      Merge remote-tracking branch 'spi/topic/ptp' into spi-next

Markus Elfring (4):
      spi: lantiq-ssc: Use devm_platform_ioremap_resource() in lantiq_ssc_probe()
      spi: mediatek: Use devm_platform_ioremap_resource() in mtk_spi_probe()
      spi: mediatek: Use devm_platform_ioremap_resource() in mtk_spi_slave_probe()
      spi: xtensa-xtfpga: Use devm_platform_ioremap_resource() in xtfpga_spi_probe()

Miquel Raynal (10):
      spi: mxic: Select SPI_NOR type by default
      spi: mxic: Fix DMAS_CTRL register layout
      spi: mxic: Ensure width is respected in spi-mem operations
      spi: zynq-qspi: Keep the naming consistent across the driver
      spi: zynq-qspi: Anything else than CS0 is not supported yet
      spi: zynq-qspi: Keep the bitfields naming consistent
      spi: zynq-qspi: Enhance the Linear CFG bit definitions
      spi: zynq-qspi: Clarify the select chip function
      spi: zynq-qspi: Do the actual hardware initialization later in the probe
      spi: zynq-qspi: Support two chip selects

Navid Emamdoost (2):
      spi: gpio: prevent memory leak in spi_gpio_probe
      spi: lpspi: fix memory leak in fsl_lpspi_probe

Pan Bian (1):
      spi: img-spfi: fix potential double release

Patrice Chotard (1):
      spi: stm32-qspi: Fix kernel oops when unbinding driver

Peter Ujfalusi (10):
      spi: at91-usart: Use dma_request_chan() directly for channel request
      spi: atmel: Use dma_request_chan() directly for channel request
      spi: fsl-lpspi: Use dma_request_chan() directly for channel request
      spi: imx: Use dma_request_chan() directly for channel request
      spi: pl022: Use dma_request_chan() directly for channel request
      spi: qup: Use dma_request_chan() directly for channel request
      spi: s3c64xx: Use dma_request_chan() directly for channel request
      spi: tegra114: Use dma_request_chan() directly for channel request
      spi: tegra20-slink: Use dma_request_chan() directly for channel request
      spi: pic32: Retire dma_request_slave_channel_compat()

Phil Edworthy (3):
      dt: spi: Add Renesas RZ/N1 binding documentation
      spi: dw: Add basic runtime PM support
      spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller

Pragnesh Patel (1):
      spi: dt-bindings: Convert spi-sifive binding to json-schema

Raymond Tan (1):
      spi: dw-pci: Add runtime power management support

Simon Horman (2):
      dt-bindings: hspi: Convert bindings to json-schema
      dt-bindings: spi: sh-msiof: Convert bindings to json-schema

Stephen Boyd (1):
      spi: gpio: Look for a device node instead of match

Thor Thayer (1):
      spi: dw: Fix Designware SPI loopback

Tony Lindgren (1):
      spi: Fix regression to return zero on success instead of positive value

Vignesh Raghavendra (1):
      spi: omap2-mcspi: Remove redundant checks

Vladimir Oltean (5):
      spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode
      spi: Add a PTP system timestamp to the transfer structure
      spi: spi-fsl-dspi: Implement the PTP system timestamping for TCFQ mode
      spi: spi-fsl-dspi: Always use the TCFQ devices in poll mode
      spi: Add a PTP system timestamp to the transfer structure

tomaspaukrt@email.cz (1):
      spi: orion: fix runtime PM initialization

zhengbin (2):
      spi: omap-100k: Remove set but not used variable 'dataH'
      spi: npcm: Remove set but not used variable 'val'

 .../devicetree/bindings/spi/renesas,hspi.yaml      |  57 ++++
 .../devicetree/bindings/spi/renesas,rzn1-spi.txt   |  11 +
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  | 159 ++++++++++
 Documentation/devicetree/bindings/spi/sh-hspi.txt  |  26 --
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 105 -------
 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    |   3 +-
 .../devicetree/bindings/spi/spi-sifive.txt         |  37 ---
 .../devicetree/bindings/spi/spi-sifive.yaml        |  86 ++++++
 .../devicetree/bindings/spi/spi-stm32-qspi.txt     |  47 ---
 .../devicetree/bindings/spi/spi-xilinx.txt         |   4 +-
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |  83 ++++++
 arch/arm/plat-pxa/ssp.c                            |   4 +-
 drivers/iio/imu/adis.c                             |  24 +-
 drivers/spi/Kconfig                                |  19 +-
 drivers/spi/spi-at91-usart.c                       |   4 +-
 drivers/spi/spi-atmel.c                            | 219 ++++++++------
 drivers/spi/spi-axi-spi-engine.c                   |  16 +-
 drivers/spi/spi-bcm-qspi.c                         |   7 +-
 drivers/spi/spi-bcm2835.c                          |   2 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |   3 +-
 drivers/spi/spi-bcm63xx.c                          |   2 +-
 drivers/spi/spi-cavium.c                           |   3 +-
 drivers/spi/spi-dw-mmio.c                          |   6 +
 drivers/spi/spi-dw-pci.c                           |  24 +-
 drivers/spi/spi-dw.c                               |   4 +-
 drivers/spi/spi-dw.h                               |   1 -
 drivers/spi/spi-falcon.c                           |   2 +-
 drivers/spi/spi-fsl-cpm.c                          |   3 +-
 drivers/spi/spi-fsl-dspi.c                         |  43 ++-
 drivers/spi/spi-fsl-espi.c                         |  19 +-
 drivers/spi/spi-fsl-lpspi.c                        |   8 +-
 drivers/spi/spi-fsl-qspi.c                         |  55 +++-
 drivers/spi/spi-fsl-spi.c                          |   3 +-
 drivers/spi/spi-gpio.c                             |   9 +-
 drivers/spi/spi-img-spfi.c                         |   2 +
 drivers/spi/spi-imx.c                              |   4 +-
 drivers/spi/spi-lantiq-ssc.c                       |  10 +-
 drivers/spi/spi-loopback-test.c                    |  12 +-
 drivers/spi/spi-mem.c                              |   2 +-
 drivers/spi/spi-mpc512x-psc.c                      |   3 +-
 drivers/spi/spi-mpc52xx-psc.c                      |   3 +-
 drivers/spi/spi-mt65xx.c                           |  23 +-
 drivers/spi/spi-mxic.c                             |   8 +-
 drivers/spi/spi-npcm-pspi.c                        |   3 +-
 drivers/spi/spi-nxp-fspi.c                         |   2 +-
 drivers/spi/spi-omap-100k.c                        |   7 +-
 drivers/spi/spi-omap2-mcspi.c                      | 105 +++----
 drivers/spi/spi-orion.c                            |   9 +-
 drivers/spi/spi-pic32.c                            |  46 ++-
 drivers/spi/spi-pl022.c                            |  29 +-
 drivers/spi/spi-pxa2xx.c                           |  95 +++---
 drivers/spi/spi-qup.c                              |   4 +-
 drivers/spi/spi-rspi.c                             |   8 +-
 drivers/spi/spi-s3c64xx.c                          |   6 +-
 drivers/spi/spi-sc18is602.c                        |   3 +-
 drivers/spi/spi-sh-hspi.c                          |   3 +-
 drivers/spi/spi-sifive.c                           |  11 +-
 drivers/spi/spi-slave-mt27xx.c                     |  12 +-
 drivers/spi/spi-sprd-adi.c                         |   8 +
 drivers/spi/spi-sprd.c                             |  15 +-
 drivers/spi/spi-st-ssc4.c                          |   3 +
 drivers/spi/spi-stm32-qspi.c                       |   3 +-
 drivers/spi/spi-tegra114.c                         |  42 +--
 drivers/spi/spi-tegra20-sflash.c                   |   5 +-
 drivers/spi/spi-tegra20-slink.c                    |   8 +-
 drivers/spi/spi-topcliff-pch.c                     |   7 +-
 drivers/spi/spi-txx9.c                             |  78 +++--
 drivers/spi/spi-xcomm.c                            |   3 +-
 drivers/spi/spi-xilinx.c                           |   7 +-
 drivers/spi/spi-xtensa-xtfpga.c                    |  10 +-
 drivers/spi/spi-zynq-qspi.c                        |  84 +++---
 drivers/spi/spi.c                                  | 332 ++++++++++++++++++---
 drivers/spi/spidev.c                               |   9 +-
 include/linux/platform_data/spi-mt65xx.h           |   1 -
 include/linux/pxa2xx_ssp.h                         |   2 +-
 include/linux/spi/spi.h                            | 132 +++++++-
 sound/soc/pxa/mmp-sspa.c                           |   2 +-
 sound/soc/pxa/pxa-ssp.c                            |  10 +-
 78 files changed, 1509 insertions(+), 760 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,hspi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/sh-hspi.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/sh-msiof.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3b1z8ACgkQJNaLcl1U
h9BV/Af/e1fAmmB4oGRvLEyDUvYS+wZyf/Ao2UateyqFmf0D+YOzkWaCACbr1eKD
BKouCID3G/0KSOgq4IBXmhSEYQlUyNetkR3+/GmniPBi06wL63XPfIytjB29YUa0
80AGWjitjScuYGXpZzfxYLNvbLMJBNpnpIXYDBm2gRp6GTtOAAD8ZCbne30Xks6Z
rcQqv1hJPqOLfnar27yDqwoNm+Bhhx1xyJNbPxBrNu8X4/sYVr/f5Yg8z+wumqrb
Agi5yyDAS4dtGNoimg42ukDE9sTHfd/7MrJI2lzNvNQrdIwoEbZlcoPTnxCLzycQ
jjQSyW3lRdAvoT0karM1oLdGs13vSQ==
=SJ7M
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
