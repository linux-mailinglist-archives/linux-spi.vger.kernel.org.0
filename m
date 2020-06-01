Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1311F1EA324
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgFALzB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 07:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALzA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Jun 2020 07:55:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3E520738;
        Mon,  1 Jun 2020 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591012498;
        bh=FKZQiz2IYCDyjB9if7c4tHoiZBV8r/55XVRIYTNAnLw=;
        h=Date:From:To:Cc:Subject:From;
        b=aPrPtnuDYNxHHa3VGchyp3UrL5RpzUYqPL3GendocCQeAjwCKJIlI9tQM924wxef/
         h5HWEnS4IsEUBgsYqDMTU3TqI2O1lfyKGxKGenLWrV6ShdF4HH7ta3TKQnkSEz4qkD
         hyT7vh/D8t1fOBykOL1C08T6oSIyen/gd0n86U0g=
Date:   Mon, 1 Jun 2020 12:54:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL] SPI updates for v5.8
Message-ID: <20200601115456.GA45647@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v5.8

for you to fetch changes up to fb02b9eb4e335f8965badd1e6ee24fdc284cb395:

  Merge remote-tracking branch 'spi/for-5.8' into spi-next (2020-05-30 00:0=
3:53 +0100)

----------------------------------------------------------------
spi: Updates for v5.8

This has been a very active release for the DesignWare driver in
particular - after a long period of inactivity we have had a lot of
people actively working on it for unrelated reasons this cycle with some
of that work still not landed.  Otherwise it's been fairly quiet for the
subsystem.  Highlights include:

 - Lots of performance improvements and fixes for the DesignWare driver
   from Serge Semin, Andy Shevchenko, Wan Ahmad Zainie, Clement Leger,
   Dinh Nguyen and Jarkko Nikula.
 - Support for octal mode transfers in spidev.
 - Slave mode support for the Rockchip drivers.
 - Support for AMD controllers, Broadcom mspi and Raspberry Pi 4,
   and Intel Elkhart Lake.

----------------------------------------------------------------
Aishwarya R (3):
      spi: spi-fsl-lpspi: Fix indentation and open brace should be on the p=
revious line
      spi: spi-fsl-spi: Fix checkpatch error "foo * bar" should be "foo *ba=
r"
      spi: spi-sh-msiof: Fix checkpatch error Complex macros should use ()

Alistair Francis (1):
      spi: sun6i: Add support for GPIO chip select lines

Andy Shevchenko (13):
      spi: Respect DataBitLength field of SpiSerialBusV2() ACPI resource
      spi: dw: Zero DMA Tx and Rx configurations on stack
      spi: dw: Remove unused variable in CR0 configuring hooks
      spi: dw: Move interrupt.h to spi-dw.h who is user of it
      spi: dw: Downgrade interrupt.h to irqreturn.h where appropriate
      spi: dw: Move few headers under #ifdef CONFIG_SPI_DW_MID_DMA
      spi: dw: Add 'mfld' suffix to Intel Medfield related routines
      spi: dw: Propagate struct device pointer to ->dma_init() callback
      spi: dw: Avoid useless assignments in generic DMA setup
      spi: dw: Get rid of dma_inited flag
      spi: dw: Drop duplicate error message when remap resource
      spi: dw: Make DMA request line assignments explicit for Intel Medfield
      spi: dw: Refactor mid_spi_dma_setup() to separate DMA and IRQ config

Angelo Dureghello (1):
      spi: spi-fsl-dspi: fix native data copy

Ashish Kumar (1):
      spi: spi-fsl-qspi: Reduce devm_ioremap size to 4 times AHB buffer size

Baolin Wang (1):
      spi: sprd: adi: Use IS_ENABLED() to validate configs

Chris Ruehl (3):
      spi: spi-rockchip: cleanup use struct spi_controller
      spi: spi-rockchip: add support for spi slave mode
      spi: spi-rockchip: use num-cs property and ctlr->enable_gpiods

Christophe JAILLET (1):
      spi: sc18is602: Fix a typo in MODULE_DESCRIPTION

Christopher Hill (3):
      spi: rb4xx: null pointer bug fix
      spi: rb4xx: update driver to be device tree aware
      spi: rb4xx: add corresponding device tree documentation

Clement Leger (2):
      spi: dw: remove unused dw_spi_chip handling
      spi: dw: remove cs_control and poll_mode members from chip_data

Colin Ian King (1):
      spi: remove redundant assignment to variable ms

Dinghao Liu (4):
      spi: spi-fsl-lpspi: Fix runtime PM imbalance on error
      spi: tegra114: Fix runtime PM imbalance on error
      spi: tegra20-slink: Fix runtime PM imbalance on error
      spi: tegra20-sflash: Fix runtime PM imbalance on error

Dinh Nguyen (2):
      spi: dw: add reset control
      dt-bindings: snps,dw-apb-ssi: add optional reset property

Evan Green (1):
      spi: pxa2xx: Apply CS clk quirk to BXT

Florian Fainelli (3):
      spi: bcm-qspi: Handle clock probe deferral
      spi: bcm-qspi: Handle lack of MSPI_REV offset
      spi: bcm2835: Implement shutdown callback

Geert Uytterhoeven (4):
      spi: dt-bindings: rspi: Convert to json-schema
      spi: spidev: Add support for Octal mode data transfers
      spi: spidev_test: Add support for Octal mode data transfers
      spi: spi-mem: Fix Dual/Quad modes on Octal-capable devices

Jacko Dirks (1):
      spi: bcm2835: Fixes bare use of unsigned

Jarkko Nikula (1):
      spi: dw: Add Elkhart Lake PSE DMA support

Jason Yan (2):
      spi: spi-mtk-nor: make mtk_nor_exec_op() statuc
      spi: a3700: make a3700_spi_init() return void

Jay Fang (1):
      spi: dw-mmio: Do not add acpi modalias when CONFIG_ACPI is not enabled

Jules Irenge (1):
      spi: atmel: Add missing annotation for atmel_spi_next_xfer_dma_submit=
()

Jungseung Lee (1):
      spi: spi-ep93xx: fix wrong SPI mode selection

Justin Chen (1):
      spi: bcm-qspi: when tx/rx buffer is NULL set to 0

Kamal Dasu (6):
      spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
      spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
      spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
      spi: bcm-qspi: add support for MSPI sys clk 108Mhz
      spi: Add support for mspi on brcmstb SoCs
      spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controll=
ers

Kangmin Park (1):
      spi: ti_qspi: fix unit address

Kunihiko Hayashi (3):
      spi: uniphier: Depend on HAS_IOMEM
      spi: uniphier: Use devm_platform_get_and_ioremap_resource() to simpli=
fy code
      spi: Convert UniPhier SPI controller to json-schema

Linus Walleij (1):
      spi: orion: Convert to use GPIO descriptors

Lukas Wunner (12):
      spi: amd: Fix duplicate iounmap in error path
      spi: amd: Pass probe errors back to driver core
      spi: amd: Drop duplicate driver data assignments
      spi: amd: Fix refcount underflow on remove
      spi: amd: Drop superfluous member from struct amd_spi
      spi: Fix controller unregister order
      spi: bcm2835: Fix controller unregister order
      spi: bcm2835aux: Fix controller unregister order
      spi: bcm2835: Tear down DMA before turning off SPI controller
      spi: dw: Fix controller unregister order
      spi: pxa2xx: Fix controller unregister order
      spi: pxa2xx: Fix runtime PM ref imbalance on probe error

Mark Brown (14):
      Merge series "Cleanup chip info in spi-dw driver" from Clement Leger =
<cleger@kalray.eu>:
      Merge tag 'v5.7-rc3' into spi-5.8
      Merge branch 'for-5.7' of https://git.kernel.org/.../broonie/spi into=
 spi-5.8
      Merge series "Grab bag with AMD SPI fixes" from Lukas Wunner <lukas@w=
unner.de>:
      Merge series "spi: dw: Add generic DW DMA controller support" from Se=
rge Semin <Sergey.Semin@baikalelectronics.ru>:
      Merge branch 'for-5.7' of https://git.kernel.org/.../broonie/spi into=
 spi-5.8
      Merge series "spi: dw: Add generic DW DMA controller support" from Se=
rge Semin <Sergey.Semin@baikalelectronics.ru>:
      spi: Make spi_delay_exec() warn if called from atomic context
      spi: Remove note about transfer limit for spi_write_then_read()
      Merge series "add ecspi ERR009165 for i.mx6/7 soc family" from Robin =
Gong <yibin.gong@nxp.com>:
      Merge series "spi: dw: Add generic DW DMA controller support" from Se=
rge Semin <Sergey.Semin@baikalelectronics.ru>:
      spi: bcm2835: Remove shared interrupt support
      Merge remote-tracking branch 'spi/for-5.7' into spi-linus
      Merge remote-tracking branch 'spi/for-5.8' into spi-next

Martin Sperl (1):
      spi: bcm2835: Enable shared interrupt support

Patrice Chotard (2):
      spi: stm32-qspi: Add pm_runtime support
      spi: stm32-qspi: Fix unbalanced pm_runtime_enable issue

Peng Ma (1):
      spi: spi-fsl-dspi: Adding shutdown hook

Peter Rosin (1):
      spi: mux: repair mux usage

Rafa=C5=82 Hibner (1):
      spi: spi-axi-spi-engine: Access register after clock initialization

Robin Gong (1):
      spi: imx: fallback to PIO if dma setup failure

Sanjay R Mehta (2):
      spi: spi-amd: Add AMD SPI controller driver support
      spi: spi-amd: fix warning

Serge Semin (24):
      spi: dw: Fix native CS being unset
      spi: dw: Initialize paddr in DW SPI MMIO private data
      spi: dw: Clear DMAC register when done or stopped
      spi: dw: Add Tx/Rx DMA properties
      spi: dw: Enable interrupts in accordance with DMA xfer mode
      spi: dw: Discard static DW DMA slave structures
      spi: dw: Discard unused void priv pointer
      spi: dw: Discard dma_width member of the dw_spi structure
      spi: dw: Set xfer effective_speed_hz
      spi: dw: Return any value retrieved from the dma_transfer callback
      spi: dw: Locally wait for the DMA transfers completion
      spi: dw: Add SPI Tx-done wait method to DMA-based transfer
      spi: dw: Add SPI Rx-done wait method to DMA-based transfer
      spi: dw: Parameterize the DMA Rx/Tx burst length
      spi: dw: Use DMA max burst to set the request thresholds
      spi: dw: Fix Rx-only DMA transfers
      spi: dw: Add core suffix to the DW APB SSI core source file
      spi: dw: Move Non-DMA code to the DW PCIe-SPI driver
      spi: dw: Remove DW DMA code dependency from DW_DMAC_PCI
      spi: dw: Add DW SPI DMA/PCI/MMIO dependency on the DW SPI core
      spi: dw: Cleanup generic DW DMA code namings
      spi: dw: Add DMA support to the DW SPI MMIO driver
      spi: dw: Use regset32 DebugFS method to create regdump file
      spi: Convert DW SPI binding to DT schema

Tiezhu Yang (1):
      spi: spidev_test: Remove hidden temporary file when make clean

Wan Ahmad Zainie (6):
      spi: dw: Fix typo in few registers name
      spi: dw: Add update_cr0() callback to update CTRLR0
      spi: dw: Add support for DesignWare DWC_ssi
      spi: dw: Add support for Intel Keem Bay SPI
      spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
      spi: dw-apb-ssi: Add Intel Keem Bay support

Wei Yongjun (4):
      spi: spi-fsl-qspi: Fix return value check of devm_ioremap() in probe
      spi: spi-amd: Fix a NULL vs IS_ERR() check in amd_spi_probe()
      spi: uniphier: fix error return code in uniphier_spi_probe()
      spi: bcm2835: Fix error return code in bcm2835_dma_init()

Yicong Yang (1):
      spi: hisi-sfc-v3xx: add error check after per operation

dillon min (2):
      spi: stm32: Add 'SPI_SIMPLEX_RX', 'SPI_3WIRE_RX' support for stm32f4
      spi: flags 'SPI_CONTROLLER_MUST_RX' and 'SPI_CONTROLLER_MUST_TX' can'=
t be coexit with 'SPI_3WIRE' mode

 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.txt  |  10 +
 .../bindings/spi/mikrotik,rb4xx-spi.yaml           |  36 ++
 .../devicetree/bindings/spi/renesas,rspi.yaml      | 144 +++++++
 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    |  41 --
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 133 ++++++
 .../bindings/spi/socionext,uniphier-spi.yaml       |  57 +++
 Documentation/devicetree/bindings/spi/spi-dw.txt   |  24 --
 Documentation/devicetree/bindings/spi/spi-rspi.txt |  73 ----
 .../devicetree/bindings/spi/spi-uniphier.txt       |  28 --
 Documentation/devicetree/bindings/spi/ti_qspi.txt  |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   5 +
 drivers/spi/Kconfig                                |  22 +-
 drivers/spi/Makefile                               |   6 +-
 drivers/spi/spi-amd.c                              | 315 ++++++++++++++
 drivers/spi/spi-armada-3700.c                      |  10 +-
 drivers/spi/spi-atmel.c                            |   1 +
 drivers/spi/spi-axi-spi-engine.c                   |  32 +-
 drivers/spi/spi-bcm-qspi.c                         | 181 ++++++--
 drivers/spi/spi-bcm2835.c                          |  26 +-
 drivers/spi/spi-bcm2835aux.c                       |   4 +-
 drivers/spi/{spi-dw.c =3D> spi-dw-core.c}            | 233 +++++-----
 drivers/spi/spi-dw-dma.c                           | 480 +++++++++++++++++=
++++
 drivers/spi/spi-dw-mid.c                           | 322 --------------
 drivers/spi/spi-dw-mmio.c                          |  86 +++-
 drivers/spi/spi-dw-pci.c                           |  50 ++-
 drivers/spi/spi-dw.h                               |  66 +--
 drivers/spi/spi-ep93xx.c                           |   8 +-
 drivers/spi/spi-fsl-dspi.c                         |  47 +-
 drivers/spi/spi-fsl-lpspi.c                        |  21 +-
 drivers/spi/spi-fsl-qspi.c                         |  11 +-
 drivers/spi/spi-fsl-spi.c                          |   2 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |  26 +-
 drivers/spi/spi-imx.c                              |  31 +-
 drivers/spi/spi-mem.c                              |  10 +-
 drivers/spi/spi-mtk-nor.c                          |   2 +-
 drivers/spi/spi-mux.c                              |   8 +-
 drivers/spi/spi-orion.c                            |  70 +--
 drivers/spi/spi-pxa2xx.c                           |   6 +-
 drivers/spi/spi-rb4xx.c                            |  19 +-
 drivers/spi/spi-rockchip.c                         | 229 ++++++----
 drivers/spi/spi-sc18is602.c                        |   2 +-
 drivers/spi/spi-sh-msiof.c                         |   2 +-
 drivers/spi/spi-sprd-adi.c                         |   2 +-
 drivers/spi/spi-stm32-qspi.c                       |  62 ++-
 drivers/spi/spi-stm32.c                            |  19 +-
 drivers/spi/spi-sun6i.c                            |   1 +
 drivers/spi/spi-tegra114.c                         |   1 +
 drivers/spi/spi-tegra20-sflash.c                   |   1 +
 drivers/spi/spi-tegra20-slink.c                    |   1 +
 drivers/spi/spi-uniphier.c                         |  11 +-
 drivers/spi/spi.c                                  |  14 +-
 drivers/spi/spidev.c                               |   3 +-
 tools/spi/Makefile                                 |   4 +-
 tools/spi/spidev_test.c                            |  21 +-
 55 files changed, 2082 insertions(+), 941 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mikrotik,rb4xx-sp=
i.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.t=
xt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.y=
aml
 create mode 100644 Documentation/devicetree/bindings/spi/socionext,uniphie=
r-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-rspi.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
 create mode 100644 drivers/spi/spi-amd.c
 rename drivers/spi/{spi-dw.c =3D> spi-dw-core.c} (70%)
 create mode 100644 drivers/spi/spi-dw-dma.c
 delete mode 100644 drivers/spi/spi-dw-mid.c

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7U7I8ACgkQJNaLcl1U
h9CvEAf+IZ21ruc9WPD/EmsRLT3HvWXC4rN9KU+QhoANL+CgVC1qs62hLR5oCmv4
oSbisg8EmoGd8W1D2z+vn70/tRGZtgapH4kHq0jRnb+I5W9lM89Kd7QQuxbh0MXj
3xf77fcfTM0z8QYkJ76ZPXPUuHFy0XQjzxDmB8K1neAZhuKn3w+MqnX/O4IXQKkB
R36RXGmTiVv7o/F9fk6E42JLMz+mJzgmi8BnQqdnuPT9fOl9D5k1BSSIxARio1Q/
9E8BFExHixeJQw34G9qQeNrlKOBF45GmLc7GYuA1h8DW3zFdljmHYCgiG9QaYP6B
1WfS9gTMBjakxfKwPVtVj5TTEJk7Fw==
=zoUT
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
