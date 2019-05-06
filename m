Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128D814BDC
	for <lists+linux-spi@lfdr.de>; Mon,  6 May 2019 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfEFOdP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 10:33:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58658 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFOdP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 10:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W058nK+QSPPuhBMTAKnmZqxwQYuCwqOACffPxhrFSwY=; b=Q5212ex2RUlj27dhj3Ux19gO0
        ABvUKqMv3cMo3KG9neqt+nO2sLiUHUb536ViOxu08tHCZsnNvVbxPpQrtwI0U5Zgp9ChXns5N4nBc
        MMoWmw84bcwijC+jlVGnjXknAqp/0fLxrLHFng5M/EeQF7nj1nrwWrfUC3zLm3xHkqIj0=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNefx-0001pl-Tr; Mon, 06 May 2019 14:33:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 43A7244000C; Mon,  6 May 2019 15:33:01 +0100 (BST)
Date:   Mon, 6 May 2019 23:33:01 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] spi updates for v5.2
Message-ID: <20190506143301.GU14916@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dZRDC+ooC0woGCz3"
Content-Disposition: inline
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dZRDC+ooC0woGCz3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v5.2

for you to fetch changes up to 2e5f081003f033d37be3faf052aaccc8b6a44aa5:

  Merge branch 'spi-5.2' into spi-next (2019-05-02 11:20:29 +0900)

----------------------------------------------------------------
spi: Updates for v5.2

One small feature was added this release but the bulk of the diffstat
and the changelog comes from the fact that several older drivers got
some fairly hefty reworks and a couple of new drivers were added:

 - Support for detailed control of timing around chip selects from
   Sowjanya Komatineni.
 - A big set of fixes and imrovements for the Tegra114 driver from
   Sowjanya Komatineni.
 - A big simplification of the GPIO driver from Andrey Smirnov.
 - DMA support and fixes for the Freescale LPSPI driver from Clark Wang.
 - Fixes and optimizations for the bcm2835aux from Martin Sparl.
 - New drivers for Mediatek MT7621 (graduated from staging) and Zynq QSPI.

----------------------------------------------------------------
Aditya Pakki (1):
      spi : spi-topcliff-pch: Fix to handle empty DMA buffers

Andrey Smirnov (12):
      spi: gpio: Drop unused spi_to_pdata()
      spi: gpio: Add local struct device pointer in spi_gpio_probe()
      spi: gpio: Add local struct spi_bitbang pointer in spi_gpio_probe()
      spi: gpio: Simplify SPI_MASTER_NO_TX check in spi_gpio_probe()
      spi: gpio: Drop unused pdata copy in struct spi_gpio
      spi: gpio: Don't request CS GPIO in DT use-case
      spi: Don't call spi_get_gpio_descs() before device name is set
      spi: gpio: Drop mflags argument from spi_gpio_request()
      spi: gpio: Drop unused pdev field in struct spi_gpio
      spi: gpio: Make sure spi_master_put() is called in every error path
      spi: bitbang: Introduce spi_bitbang_init()
      spi: gpio: Use devm_spi_register_master()

Andy Shevchenko (3):
      spi: pxa2xx-pci: Drop unused header inclusion
      spi: pxa2xx: Introduce DMA burst size support
      spi: pxa2xx: Debug print DMA burst size

Arnd Bergmann (3):
      spi: work around clang bug in SPI_BPW_RANGE_MASK()
      spi: fix SPI_BPW_RANGE_MASK() regression
      spi: export tracepoint symbols to modules

Axel Lin (4):
      spi: at91-usart: Remove duplicated checking for spi->bits_per_word
      spi: fsl-lpspi: Fix problematic dev_set_drvdata call
      spi: fsl-lpspi: Fix build warning when !CONFIG_PM
      spi: fsl-lpspi: Clean up fsl_lpspi_probe

Cao Van Dong (1):
      spi: sh-msiof: Document r8a77470 bindings

Cezary Gapinski (1):
      spi: pic32: fix dma channels termination

Chris Lesiak (1):
      spi: Fix zero length xfer bug

Clark Wang (9):
      spi: lpspi: Add i.MX8 boards support for lpspi
      doc: lpspi: Document DT bindings for LPSPI clocks
      spi: lpspi: add the error info of transfer speed setting
      spi: lpspi: use the core way to implement cs-gpio function
      spi: lpspi: add dma mode support
      spi: lpspi: Add the missing NULL check
      spi: lpspi: Code cleanup
      spi: lpspi: fix dataloss when SS is inactivated between every words
      spi: lpspi: add missing complete in abort func at dma mode

Claudiu Beznea (1):
      spi: atmel-quadspi: fix crash while suspending

Daniel Gomez (1):
      spi: AD ASoC: declare missing of table

Evan Green (1):
      spi: pxa2xx: Add support for Intel Comet Lake

Fabien Dessenne (2):
      spi: stm32-qspi: manage the get_irq error case
      spi: stm32: return the get_irq error

Flavio Suligoi (3):
      spi: pxa2xxx: change "no DMA channels..." msg from debug to warning
      spi: pxa2xx: use a module softdep for dw_dmac
      spi: pxa2xx: fix SCR (divisor) calculation

Gareth Williams (1):
      dt-bindings: snps,dw-apb-ssi: Add optional clock bindings documentati=
on

Geert Uytterhoeven (8):
      spi: rspi: Fix register initialization while runtime-suspended
      spi: rspi: Fix sequencer reset during initialization
      spi: sh-msiof: Use BIT() and GENMASK()
      spi: sh-msiof: Use readl_poll_timeout_atomic() instead of open-coding
      spi: sh-msiof: Add reset of registers before starting transfer
      spi: spi-gpio: Remove spi->controller_data comment
      spi: Add missing error handling for CS GPIOs
      spi: sh-msiof: Convert to use GPIO descriptors

Han Xu (1):
      spi: lpspi: enable runtime pm for lpspi

Hoan Nguyen An (1):
      spi: rspi: Fix handling of QSPI code when transmit and receive

Jan Kundr=E1t (2):
      spi: spidev: Enable control of inter-word delays
      spi: orion: Support spi_xfer->word_delay_usecs

Jarkko Nikula (3):
      spi: pxa2xx: Use struct spi_device directly in pxa2xx_spi_transfer_on=
e()
      spi: pxa2xx: Unify remaing prints in pxa2xx_spi_transfer_one()
      spi: Remove one needless transfer speed fall back case

Leilk Liu (1):
      dt-bindings: spi: spi-mt65xx: add support for MT8516

Linus Walleij (1):
      spi: ep93xx: Convert to use CS GPIO descriptors

Ludovic Barre (4):
      spi: spi-mem: stm32-qspi: avoid memory corruption at low frequency
      spi: spi-mem: stm32-qspi: add suspend/resume support
      spi: stm32-qspi: add spi_master_put in release function
      spi: stm32-qspi: add dma support

Mark Brown (5):
      Merge branch 'spi-5.1' into spi-5.2 for stm32
      Merge tag 'v5.1-rc1' into spi-5.2
      Merge branch 'spi-5.1' into spi-5.2
      Merge branch 'spi-5.1' into spi-linus
      Merge branch 'spi-5.2' into spi-next

Martin Sperl (9):
      spi: bcm2835aux: unifying code between polling and interrupt driven c=
ode
      spi: bcm2835aux: remove dangerous uncontrolled read of fifo
      spi: bcm2835aux: fix corruptions for longer spi transfers
      spi: bcm2835aux: remove dead code
      spi: bcm2835aux: fix driver to not allow 65535 (=3D-1) cs-gpios
      spi: bcm2835aux: warn in dmesg that native cs is not really supported
      spi: bcm2835aux: setup gpio-cs to output and correct level during set=
up
      spi: bcm2835aux: make the polling duration limits configurable
      spi: bcm2835aux: add driver stats to debugfs

Meghana Madhyastha (1):
      spi/spi-bcm2835: Split transfers that exceed DLEN

Naga Sureshkumar Relli (4):
      spi: spi-mem: export spi_mem_default_supports_op()
      dt-bindings: spi: Add device tree binding documentation for Zynq QSPI=
 controller
      spi: spi-mem: Add support for Zynq QSPI controller
      spi: spi-mem: zynq-qspi: Fix build error on architectures missing rea=
dsl/writesl

Noralf Tr=F8nnes (3):
      spi: Remove warning in spi_split_transfers_maxsize()
      spi: Release spi_res after finalizing message
      spi/trace: Cap buffer contents at 64 bytes

Phil Edworthy (2):
      dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings documentat=
ion
      spi: dw: Add support for an optional interface clock

Randolph Maa=DFen (1):
      spi: tegra20-slink: change chip select action order

Rasmus Villemoes (5):
      spi: spi-fsl-spi: support use of the SPISEL_BOOT signal on MPC8309
      spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg
      spi: spi-fsl-spi: relax message sanity checking a little
      spi: spi-fsl-spi: allow changing bits_per_word while CS is still acti=
ve
      spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode

Serge Semin (1):
      spi: Clear SPI_CS_HIGH flag from bad_bits for GPIO chip-select

Sergei Shtylyov (2):
      spi: kill useless initializer in spi_register_controller()
      spi-mem: fix kernel-doc for spi_mem_dirmap_{read|write}()

Sowjanya Komatineni (22):
      spi: tegra114: clear packed bit for unpacked mode
      spi: tegra114: fix for unpacked mode transfers
      spi: tegra114: terminate dma and reset on transfer timeout
      spi: tegra114: flush fifos
      spi: tegra114: configure dma burst size to fifo trig level
      spi: tegra114: reset controller on probe
      spi: tegra114: use packed mode for 32 bits per word
      spi: tegra114: add SPI_LSB_FIRST support
      spi: tegra114: de-assert CS before SPI mode change
      spi: tegra114: avoid reset call in atomic context
      spi: tegra114: dump SPI registers during timeout
      spi: tegra114: set supported bits per word
      spi: tegra114: use unpacked mode for below 4 bytes
      spi: tegra114: set bus number based on id
      spi: tegra114: add dual mode support
      spi: tegra114: add 3 wire transfer mode support
      spi: tegra114: add support for interrupt mask
      spi-summary: document set_cs_timing
      spi: add a method for configuring CS timing
      spi: document tx/rx clock delay properties
      spi: expand mode support
      spi: tegra114: fix PIO transfer

Stefan Roese (1):
      spi: mt7621: Move SPI driver out of staging

Trent Piepho (2):
      spi: imx: add module parameter to control DMA use
      spi: imx: stop buffer overflow in RX FIFO flush

Volker Haspel (1):
      spi: spi-fsl-qspi: use devm_spi_register_controller

Wolfram Sang (1):
      spi: mxic: simplify getting .driver_data

YueHaibing (4):
      spi: atmel-quadspi: Make atmel_qspi_get_name static
      spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS
      spi: spi-mem: Fix build error without CONFIG_SPI_MEM
      spi: spi-mem: Make spi_mem_default_supports_op() static inline

kbuild test robot (3):
      spi: lpspi: fsl_lpspi_runtime_resume() can be static
      spi: spi-mem: stm32-qspi: stm32_qspi_pm_ops can be static
      spi: bcm2835aux: polling_limit_us can be static

 Documentation/devicetree/bindings/spi/fsl-spi.txt  |   4 +
 .../bindings/spi/nvidia,tegra114-spi.txt           |  20 +
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   1 +
 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    |  10 +-
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      |  10 +-
 .../devicetree/bindings/spi/spi-mt65xx.txt         |   1 +
 .../devicetree/bindings/spi/spi-mt7621.txt         |  26 +
 .../devicetree/bindings/spi/spi-zynq-qspi.txt      |  25 +
 Documentation/spi/spi-summary                      |   6 +
 arch/arm/mach-ep93xx/edb93xx.c                     |  13 +-
 arch/arm/mach-ep93xx/simone.c                      |  11 +-
 arch/arm/mach-ep93xx/ts72xx.c                      |  25 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |  15 +-
 arch/sh/boards/mach-ecovec24/setup.c               |  12 +-
 drivers/spi/Kconfig                                |  16 +-
 drivers/spi/Makefile                               |   2 +
 drivers/spi/atmel-quadspi.c                        |   8 +-
 drivers/spi/spi-at91-usart.c                       |   8 +-
 drivers/spi/spi-bcm2835.c                          |  39 +-
 drivers/spi/spi-bcm2835aux.c                       | 205 ++++--
 drivers/spi/spi-bitbang.c                          |  66 +-
 drivers/spi/spi-dw-mmio.c                          |  12 +
 drivers/spi/spi-ep93xx.c                           |  32 +-
 drivers/spi/spi-fsl-lib.h                          |   2 +
 drivers/spi/spi-fsl-lpspi.c                        | 573 ++++++++++++++--
 drivers/spi/spi-fsl-qspi.c                         |   2 +-
 drivers/spi/spi-fsl-spi.c                          |  81 ++-
 drivers/spi/spi-gpio.c                             | 227 +++---
 drivers/spi/spi-imx.c                              |   9 +-
 drivers/spi/spi-mem.c                              |   8 +-
 drivers/{staging/mt7621-spi =3D> spi}/spi-mt7621.c   |  83 ++-
 drivers/spi/spi-mxic.c                             |   6 +-
 drivers/spi/spi-orion.c                            |   4 +
 drivers/spi/spi-pic32.c                            |   2 +-
 drivers/spi/spi-pxa2xx-dma.c                       |   4 +-
 drivers/spi/spi-pxa2xx-pci.c                       |   5 +-
 drivers/spi/spi-pxa2xx.c                           |  38 +-
 drivers/spi/spi-rspi.c                             | 119 ++--
 drivers/spi/spi-sh-msiof.c                         | 224 +++---
 drivers/spi/spi-stm32-qspi.c                       | 229 ++++++-
 drivers/spi/spi-stm32.c                            |   5 +-
 drivers/spi/spi-tegra114.c                         | 310 +++++++--
 drivers/spi/spi-tegra20-slink.c                    |  12 +-
 drivers/spi/spi-topcliff-pch.c                     |  15 +-
 drivers/spi/spi-zynq-qspi.c                        | 761 +++++++++++++++++=
++++
 drivers/spi/spi.c                                  |  76 +-
 drivers/spi/spidev.c                               |   4 +-
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/mt7621-spi/Kconfig                 |   6 -
 drivers/staging/mt7621-spi/Makefile                |   1 -
 drivers/staging/mt7621-spi/TODO                    |   5 -
 include/linux/platform_data/spi-ep93xx.h           |   4 -
 include/linux/spi/pxa2xx_spi.h                     |   1 +
 include/linux/spi/spi-mem.h                        |  12 +
 include/linux/spi/spi.h                            |  24 +-
 include/linux/spi/spi_bitbang.h                    |   1 +
 include/trace/events/spi.h                         |  10 +-
 include/uapi/linux/spi/spidev.h                    |   6 +-
 sound/soc/codecs/adau1977-spi.c                    |  11 +
 60 files changed, 2650 insertions(+), 800 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt7621.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
 rename drivers/{staging/mt7621-spi =3D> spi}/spi-mt7621.c (88%)
 create mode 100644 drivers/spi/spi-zynq-qspi.c
 delete mode 100644 drivers/staging/mt7621-spi/Kconfig
 delete mode 100644 drivers/staging/mt7621-spi/Makefile
 delete mode 100644 drivers/staging/mt7621-spi/TODO

--dZRDC+ooC0woGCz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQRZwACgkQJNaLcl1U
h9DXUQf9HVDOINJUKCshzWvx+Ye/ahWUxyJM7Mkn6Jhysa/Hxxc9WyFPrZEeQt7e
jFQWtxvE16viEP7QidccLfWpKwC176KebbelmGUFLtqqN5fFhhGARIQI8q8gmjXL
+IwmUx/c4vbQAE0CTRdIAN0XDAFO+fvhVx8W80fh3+7DKk15ttp9cPmaa/VPjLip
OO+f8isPOjtgctBFpViwK+1mDrlYyWkRfaDW60F6utUt/xMX90f0i0S87otmHs59
JhwuAemqGPkqvqkG2juECXikluJotYzgYTbf4AjVlNO84s159xkqEq6OBY/qA3WM
Ot17PvuMOjKGvKok5D0VSW6zNT3Qyg==
=3+yX
-----END PGP SIGNATURE-----

--dZRDC+ooC0woGCz3--
