Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E80B661EC4
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2019 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfGHMtn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Jul 2019 08:49:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfGHMtn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jul 2019 08:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aUlU+gyUQkTOUs4PkdVAQCupgV5AYc5NR3332WZM+WQ=; b=m9XcWm1yVZzZ3T99729g4YKLV
        s8S1RgleD29KF0U4gCe49Oj/9nau4TAFXs0V1JoY4LUjAF8Hw9LoGu9pVTTeXssRqTqRfbL6YJdfy
        uf8s+Ez4LoMnxDrAWx+8HAO4GLueYRhKYPeOKlKpTc9UqZNvFBY88AVXxCIsgyAn/lv/w=;
Received: from [217.140.106.54] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hkT5Q-0000SW-Pt; Mon, 08 Jul 2019 12:49:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5E501D02C61; Mon,  8 Jul 2019 13:49:40 +0100 (BST)
Date:   Mon, 8 Jul 2019 13:49:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] SPI updates for v5.3
Message-ID: <20190708124940.GB12731@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
X-Cookie: If anything can go wrong, it will.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
v5.3

for you to fetch changes up to 26ac56506b0ea598bd0b52dcbd2d697282af98ed:

  Merge remote-tracking branch 'spi/topic/pump-rt' into spi-next (2019-07-0=
4 17:35:11 +0100)

----------------------------------------------------------------
spi: Updates for v5.3

For the most part this is a quiet release for SPI, though there's
several of the more widely used drivers that have had some fairly
substantial development done on them, mainly improving
performance and adding support for some more obscure use cases.

 - Support for configuring a minimum time for chip select to be
   deasserted between transfers from Martin Sperl.
 - A rework of the ACPI device instantiation code from Ard
   Biesheuvel.
 - Fairly substantial development on the AT91 USART, BCM2835 and
   Tegra114 drivers.
 - New driver for Socionext SynQuacer.

----------------------------------------------------------------
Andy Shevchenko (2):
      spi: Add a prototype for exported spi_set_cs_timing()
      spi: No need to assign dummy value in spi_unregister_controller()

Ard Biesheuvel (3):
      spi/acpi: enumerate all SPI slaves in the namespace
      spi/acpi: fix incorrect ACPI parent check
      spi/acpi: avoid spurious matches during slave enumeration

Christoph Niedermaier (1):
      spi: spidev: Add dhcom-board to compatibility list

Douglas Anderson (1):
      spi: Allow SPI devices to request the pumping thread be realtime

Emil Renner Berthing (1):
      spi: rockchip: turn down tx dma bursts

Florian Fainelli (1):
      spi: Allow selecting BCM2835 SPI controllers on ARCH_BRCMSTB

Geert Uytterhoeven (1):
      spi: sh-msiof: Reduce delays in sh_msiof_modify_ctr_wait()

Gustavo A. R. Silva (1):
      spi: Use struct_size() helper

Hoan Nguyen An (2):
      spi: bcm2835aux: Remove spi_alloc_master() error printing
      spi: bcm2835: Remove spi_alloc_master() error printing

Jarkko Nikula (2):
      spi: pxa2xx: Set minimum transfer speed
      spi: pxa2xx: Add support for Intel Elkhart Lake

Jorge Ramirez-Ortiz (2):
      spi: qup: remove unnecessary goto
      spi: qup: fix PIO/DMA transfers.

Keiji Hayashibara (2):
      spi: uniphier: fix timeout error
      spi: uniphier: fix zero-length transfer

Leilk Liu (1):
      spi: mediatek: add SPI_LSB_FIRST support

Linus Walleij (1):
      spi: ep93xx: Drop unused variable

Ludovic Barre (2):
      dt-bindings: spi: stm32-qspi: add dma properties
      spi: stm32-qspi: remove signal sensitive on completion

Lukas Wunner (2):
      spi: bcm2835: Replace spi_master by spi_controller
      spi: bcm2835: Drop assignment of dma_slave_config direction

Marek Vasut (1):
      spidev: Add M53Menlo CPLD compatible

Mark Brown (7):
      Merge tag 'spi-bpw-is-supported' of https://git.kernel.org/.../brooni=
e/spi into spi-5.3
      Merge tag 'v5.2-rc1' into spi-5.3
      Merge branch 'spi-5.2' into spi-5.3
      Merge tag 'v5.2-rc4' into spi-5.3
      Merge branch 'spi-5.2' into spi-linus
      Merge branch 'spi-5.3' into spi-next
      Merge remote-tracking branch 'spi/topic/pump-rt' into spi-next

Martin Sperl (8):
      spi: bcm2835: bcm2835_spi_transfer_one_poll remove unnecessary argume=
nt
      spi: bcm2835: Avoid 64-bit arithmetic in xfer len calc
      spi: bcm2835: added comment about different bus behaviour of DMA mode
      spi: bcm2835: make the polling duration limits configurable
      spi: bcm2835: add driver stats to debugfs
      spi: core: allow defining time that cs is deasserted
      spi: core: allow defining time that cs is deasserted as a multiple of=
 SCK
      spi: core: allow reporting the effectivly used speed_hz for a transfer

Masahisa Kojima (4):
      MAINTAINERS: Add entry for Synquacer SPI driver
      spi: Add DT bindings for Synquacer
      spi: Add spi driver for Socionext SynQuacer platform
      spi: spi-synquacer: Fixed build on architectures missing readsl/write=
sl series

Maxime Ripard (3):
      spi: Add YAML schemas for the generic SPI options
      spi: sun4i: Add YAML schemas
      spi: sun6i: Add YAML schemas

Neil Armstrong (1):
      spi: spi-meson-spifc: update with SPDX Licence identifier

Nicolas Saenz Julienne (1):
      spi: bcm2835: only split transfers that exceed DLEN if DMA available

Noralf Tr=F8nnes (1):
      spi: Add spi_is_bpw_supported()

Patrice Chotard (1):
      spi: spi-stm32-qspi: Remove CR_FTHRES_MASK usage

Radu Pirea (2):
      dt-bindings: mfd: atmel-usart: add DMA bindings for USART in SPI mode
      spi: at91-usart: add DMA support

Rob Herring (2):
      spi: dt-bindings: Convert spi-gpio binding to json-schema
      spi: dt-bindings: Convert Arm pl022 to json-schema

Sowjanya Komatineni (5):
      spi: tegra114: add support for gpio based CS
      spi: tegra114: add support for hw based cs
      spi: tegra114: add support for HW CS timing
      spi: tegra114: add support for TX and RX trimmers
      spi: tegra114: set master cleanup and also invoke it on probe error

Tudor Ambarus (3):
      spi: fix ctrl->num_chipselect constraint
      spi: atmel-quadspi: void return type for atmel_qspi_init()
      spi: atmel-quadspi: fix resume call

Vladimir Zapolskiy (1):
      spi: don't open code list_for_each_entry_safe_reverse()

 .../devicetree/bindings/mfd/atmel-usart.txt        |  20 +-
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |  86 +++
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      | 106 +++
 Documentation/devicetree/bindings/spi/spi-bus.txt  | 112 +--
 .../devicetree/bindings/spi/spi-controller.yaml    | 161 ++++
 Documentation/devicetree/bindings/spi/spi-gpio.txt |  43 --
 .../devicetree/bindings/spi/spi-gpio.yaml          |  72 ++
 .../devicetree/bindings/spi/spi-pl022.yaml         | 165 ++++
 .../devicetree/bindings/spi/spi-stm32-qspi.txt     |   5 +-
 .../devicetree/bindings/spi/spi-sun4i.txt          |  23 -
 .../devicetree/bindings/spi/spi-sun6i.txt          |  44 --
 .../devicetree/bindings/spi/spi-synquacer.txt      |  27 +
 .../devicetree/bindings/spi/spi_pl022.txt          |  70 --
 MAINTAINERS                                        |   8 +
 drivers/spi/Kconfig                                |  14 +-
 drivers/spi/Makefile                               |   1 +
 drivers/spi/atmel-quadspi.c                        |  21 +-
 drivers/spi/spi-at91-usart.c                       | 221 +++++-
 drivers/spi/spi-bcm2835.c                          | 328 +++++---
 drivers/spi/spi-bcm2835aux.c                       |   4 +-
 drivers/spi/spi-meson-spifc.c                      |  12 +-
 drivers/spi/spi-mt65xx.c                           |  15 +-
 drivers/spi/spi-pxa2xx.c                           |  14 +
 drivers/spi/spi-qup.c                              |  55 +-
 drivers/spi/spi-rockchip.c                         |   4 +-
 drivers/spi/spi-sh-msiof.c                         |   2 +-
 drivers/spi/spi-stm32-qspi.c                       |  14 +-
 drivers/spi/spi-synquacer.c                        | 828 +++++++++++++++++=
++++
 drivers/spi/spi-tegra114.c                         | 170 ++++-
 drivers/spi/spi-uniphier.c                         |  17 +-
 drivers/spi/spi.c                                  | 230 ++++--
 drivers/spi/spidev.c                               |   2 +
 include/linux/platform_data/spi-mt65xx.h           |   2 -
 include/linux/spi/spi.h                            |  37 +
 34 files changed, 2374 insertions(+), 559 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun4i-a=
10-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun6i-a=
31-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/spi-controller.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/spi-pl022.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun4i.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt
 delete mode 100644 Documentation/devicetree/bi:wq
ndings/spi/spi_pl022.txt
 create mode 100644 drivers/spi/spi-synquacer.c

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0jO+MACgkQJNaLcl1U
h9BYnAf/V62cq83Vb80UgS9O89KPxruj4S0REAlxW9B5TzDT86EeGmzfvtDkZ2DL
+inqJrBFXzcB87ickicxuJqgudfxt/jZMYuEkaNsyR6h6WVa2p9MVj0Isrm33aXJ
I9eGwqd7WSaOE+GTfXvZtTlbjtkjId7fjBuqsU4s1rrmuHlwlDDF9+3MzUOiNSDt
fJ3z2E4hKgfkd2o/rRiM8dAj4Xh46gK1gFRIm/+B6WUYw1sGO+OyVSZ7zWj7nKtD
93ZciG17RZe2rW9h2/Wy4WbBDCyBpUgYDCfMj0Dcf2DTD++wAFxxk7dcx9fu1a+5
sEsSkNj01wl9GXGNPuPw+XGQJuR3CA==
=sFCK
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
