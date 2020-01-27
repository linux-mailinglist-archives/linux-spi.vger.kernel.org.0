Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C101314A88E
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jan 2020 18:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgA0RE6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jan 2020 12:04:58 -0500
Received: from foss.arm.com ([217.140.110.172]:47218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgA0RE5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jan 2020 12:04:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFBE831B;
        Mon, 27 Jan 2020 09:04:56 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DDAE3F67D;
        Mon, 27 Jan 2020 09:04:56 -0800 (PST)
Date:   Mon, 27 Jan 2020 17:04:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL] SPI updates for v5.6
Message-ID: <20200127170454.GC3763@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.6

for you to fetch changes up to 754a36a58c29718bf5e28b8789b17bffbb60e8a6:

  Merge branch 'spi-5.6' into spi-next (2020-01-23 12:37:18 +0000)

----------------------------------------------------------------
spi: Updates for v5.6

Not much going on in the core for SPI this time but a reasonable amount
of change in the drivers:

 - Removal of dmal_request_slave_channel() from Peter Ujfalusi.
 - More conversions of drivers to GPIO descriptors from Linus Walleij.
 - A big rework of the sh-msiof driver from Geert Uytterhoeven moving it
   over to the generic native chipselect support.
 - DMA support for the uniphier driver from Kunihiko Hayashi.
 - New driver support for HiSilcon v3xx SPI NOR controllers from John
   Garry.

----------------------------------------------------------------
Aditya Pakki (1):
      spi: dw: Avoid BUG_ON() in case of host failure

Benjamin Gaignard (1):
      dt-bindings: spi: Convert stm32 spi bindings to json-schema

Christophe Leroy (1):
      spi: fsl: simplify error path in of_fsl_spi_probe()

Claudiu Beznea (1):
      dt-bindings: spi_atmel: add microchip,sam9x60-spi

Geert Uytterhoeven (7):
      spi: rspi: Remove obsolete platform_device_id entries
      spi: Add generic support for unused native cs with cs-gpios
      spi: sh-msiof: Convert to generic unused native cs handling.
      spi: rspi: Use dev_warn_once() instead of open-coding
      spi: rspi: Remove set_config_register() macro
      spi: rspi: Add support for multiple native chip selects
      spi: rspi: Add support for GPIO chip selects

Jarkko Nikula (1):
      spi: pxa2xx: Add support for Intel Comet Lake PCH-V

Jean Pihet (4):
      spi: spi-ti-qspi: Remove unused macro for fclk frequency
      spi: spi-ti-qspi: support large flash devices
      spi: spi-ti-qspi: optimize byte-transfers
      spi: spi-ti-qspi: fix warning

Jim Quinlan (1):
      spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER

John Garry (2):
      spi: Add HiSilicon v3xx SPI NOR flash controller driver
      MAINTAINERS: Add a maintainer for the HiSilicon v3xx SFC driver

Krzysztof Kozlowski (1):
      spi: sh-msiof: Do not redefine STR while compile testing

Kunihiko Hayashi (3):
      spi: uniphier: Change argument of irq functions to private structure
      spi: uniphier: Add handle_err callback function
      spi: uniphier: Add DMA transfer mode support

Linus Walleij (4):
      spi: stm32: Switch to use GPIO descriptors for CS
      spi: bitbang: Make chipselect callback optional
      spi: meson-spicc: Use GPIO descriptors
      spi: oc-tiny: Use GPIO descriptors

Lubomir Rintel (1):
      spi: pxa2xx: Avoid touching SSCR0_SSE on MMP2

Lukas Wunner (1):
      spi: bcm2835: Raise maximum number of slaves to 4

Mark Brown (3):
      Merge branch 'for-5.5' of https://git.kernel.org/.../broonie/spi into spi-5.6
      Merge branch 'spi-5.5' into spi-linus
      Merge branch 'spi-5.6' into spi-next

Matthias Kaehlcke (1):
      spi: spi-qcom-qspi: Use device managed memory for clk_bulk_data

Michael Walle (1):
      spi: spi-fsl-qspi: Ensure width is respected in spi-mem operations

Peter Ujfalusi (9):
      spi: atmel: Use dma_request_chan() instead dma_request_slave_channel()
      spi: bcm2835: Release the DMA channel if probe fails after dma_init
      spi: bcm2835: Use dma_request_chan() instead dma_request_slave_channel()
      spi: img-spfi: Use dma_request_chan() instead dma_request_slave_channel()
      spi: mxs: Use dma_request_chan() instead dma_request_slave_channel()
      spi: sirf: Use dma_request_chan() instead dma_request_slave_channel()
      spi: spi-fsl-dspi: Use dma_request_chan() instead dma_request_slave_channel()
      spi: stm32-qspi: Use dma_request_chan() instead dma_request_slave_channel()
      spi: stm32: Use dma_request_chan() instead dma_request_slave_channel()

Philippe Schenker (1):
      spi: fsl-lpspi: fix only one cs-gpio working

Rayagonda Kokatanur (1):
      spi: bcm-qspi: Use platform_get_irq_byname_optional() to avoid error message

Tomer Maimon (4):
      spi: npcm-pspi: fix 16 bit send and receive support
      spi: npcm-pspi: improve spi transfer performance
      spi: npcm-pspi: modify reset support
      dt-binding: spi: add NPCM PSPI reset binding

Vladimir Oltean (1):
      spi: Catch improper use of PTP system timestamping API

Xinwei Kong (1):
      spi: dw: use "smp_mb()" to avoid sending spi data error

zhengbin (4):
      spi/topcliff-pch: Remove unneeded semicolon
      spi: fsl-lpspi: use true,false for bool variable
      spi: imx: use true,false for bool variable
      spi: tegra114: use true,false for bool variable

 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt  |  12 +-
 .../devicetree/bindings/spi/spi-stm32.txt          |  62 ---
 .../devicetree/bindings/spi/spi_atmel.txt          |   2 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      | 105 +++++
 MAINTAINERS                                        |   6 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-atmel.c                            |  29 +-
 drivers/spi/spi-bcm-qspi.c                         |   2 +-
 drivers/spi/spi-bcm2835.c                          |  47 +-
 drivers/spi/spi-bitbang.c                          |  21 +-
 drivers/spi/spi-dw.c                               |   6 +-
 drivers/spi/spi-fsl-dspi.c                         |  12 +-
 drivers/spi/spi-fsl-lpspi.c                        |  36 +-
 drivers/spi/spi-fsl-qspi.c                         |   2 +-
 drivers/spi/spi-fsl-spi.c                          |  27 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    | 284 +++++++++++++
 drivers/spi/spi-img-spfi.c                         |  18 +-
 drivers/spi/spi-imx.c                              |   4 +-
 drivers/spi/spi-meson-spicc.c                      |  25 +-
 drivers/spi/spi-mxs.c                              |   6 +-
 drivers/spi/spi-npcm-pspi.c                        |  57 ++-
 drivers/spi/spi-oc-tiny.c                          |  50 +--
 drivers/spi/spi-pxa2xx.c                           |  31 +-
 drivers/spi/spi-qcom-qspi.c                        |   9 +-
 drivers/spi/spi-rspi.c                             |  23 +-
 drivers/spi/spi-sh-msiof.c                         | 471 ++++++++++-----------
 drivers/spi/spi-sirf.c                             |  12 +-
 drivers/spi/spi-stm32-qspi.c                       |  30 +-
 drivers/spi/spi-stm32.c                            |  79 ++--
 drivers/spi/spi-tegra114.c                         |   4 +-
 drivers/spi/spi-ti-qspi.c                          |  87 +++-
 drivers/spi/spi-topcliff-pch.c                     |   4 +-
 drivers/spi/spi-uniphier.c                         | 227 +++++++++-
 drivers/spi/spi.c                                  |  24 ++
 include/linux/spi/spi.h                            |   8 +
 include/linux/spi/spi_oc_tiny.h                    |   4 -
 37 files changed, 1208 insertions(+), 628 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
 create mode 100644 drivers/spi/spi-hisi-sfc-v3xx.c

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4vGDYACgkQJNaLcl1U
h9BqGQf/X9o4/mxdgsGoXbmtOruw1BOjFBX3sPUgKpPks/N5r8t02dCCiG4PrrAo
8Xew7YngMNjMXWsncomrmkG+8kd3C+Vd8jJlycyFLcjI6QFNL2a680DThqA+EuTx
L0zTihx9tyjmCTNnx9ZLrZu9cWW4WyMVzHIMt5CHJ6fqWT/2aa6wSW/JJxpJmXbI
eqE1qjM3xNSd+0SEKOgEKMOQsqhvrWFDcTQJdq2YaFbr/RlS7de2KEkRqH+MWNxR
FE25VehUI6ARvcOS0LLiGgWzF0eAytsX9O/sLFDJTlcBVl1EZTKDFwX6im3P/1/U
z5S+5Kh7pEjSHMJFvFId3M9AVDq9Sg==
=C88g
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
