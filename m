Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860EE197C0B
	for <lists+linux-spi@lfdr.de>; Mon, 30 Mar 2020 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgC3Mhf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Mar 2020 08:37:35 -0400
Received: from foss.arm.com ([217.140.110.172]:52570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbgC3Mhe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30D7230E;
        Mon, 30 Mar 2020 05:37:34 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A510B3F68F;
        Mon, 30 Mar 2020 05:37:33 -0700 (PDT)
Date:   Mon, 30 Mar 2020 13:37:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator and spi updates for v5.7
Message-ID: <20200330123732.GH4792@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
X-Cookie: Ahead warp factor one, Mr. Sulu.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git tags/regulator-spi-v5.7

for you to fetch changes up to 6dfae59d37aec535db5e462db1a1ff76c5e3fa25:

  Merge remote-tracking branch 'regulator/for-next' into tmp (2020-03-30 12:57:26 +0100)

----------------------------------------------------------------
spi/regulator: Updates for v5.7

At one point in the release cycle I managed to fat finger things and
apply some SPI fixes onto a regulator branch and merge that into the SPI
tree, then pull in a change shared with the MTD tree moving the Mediatek
quadspi driver over to become the Mediatek spi-nor driver in the SPI
tree.  This has made a mess which I only just noticed while preparing
this and I can't see a sensible way to unpick things due to other
subsequent merge commits especially the pull from MTD so it looks like
the most sensible thing to do is give up and combine the two pull
requests - I hope this is OK.  Sorry about this, I've changed some bits
of workflow which should hopefully help me spot such issues earlier in
future.

Fortunately both subsystems were fairly quiet this cycle, the highlights
are:

regulator:

 - Support for Monoloithic Power Systems MP5416, MP8867 and MPS8869 and
   Qualcomm PMI8994 and SMB208.

SPI:

 - Lots of enhancements for spi-fsl-dspi, including XSPI mode support,
   from Vladimir Oltean.
 - Support for amlogic Meson G12A, IBM FSI, Mediatek spi-nor (moved from
   MTD), NXP i.MX8Mx, Rockchip PX30, RK3308 and RK3328, and Qualcomm
   Atheros AR934x/QCA95xx.

----------------------------------------------------------------
Adam Ford (1):
      spi: spi-nxp-fspi: Add support for imx8mm, imx8qxp

Adam Thomson (1):
      regulator: da9063: Fix get_mode() functions to read sleep field

Alain Volmat (1):
      spi: stm32: Fix comments compilation warnings

Andy Shevchenko (4):
      spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()
      spi: pxa2xx: drv_data can't be NULL in ->remove()
      spi: pxa2xx: Introduce is_mmp2_ssp() helper
      regulator: core: Avoid device name duplication in NORMAL_GET

Anson Huang (3):
      dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible
      regulator: anatop: Improve Kconfig dependency
      regulator: anatop: Lower error message level for -EPROBE_DEFER

Ansuel Smith (1):
      regulator: add smb208 support

Axel Lin (1):
      regulator: mp5416: Fix output discharge enable bit for LDOs

Bjorn Andersson (1):
      regulator: qcom_smd: Add pmi8994 regulator support

Chris Packham (2):
      dt-bindings: spi: Document binding for generic SPI multiplexer
      spi: Add generic SPI multiplexer

Chuanhong Guo (6):
      spi: add driver for ar934x spi controller
      dt-binding: spi: add bindings for spi-ar934x
      spi: make spi-max-frequency optional
      spi: add support for mediatek spi-nor controller
      dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
      mtd: spi-nor: remove mtk-quadspi driver

Dan Carpenter (1):
      spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe

Eddie James (2):
      dt-bindings: fsi: Add FSI2SPI bindings
      spi: Add FSI-attached SPI controller driver

Etienne Carriere (1):
      spi: stm32-qspi: defer probe for reset controller

Geert Uytterhoeven (5):
      spi: rspi: Factor out handling of common mode bits
      spi: rspi: Add support for LSB-first word order
      spi: rspi: Add support for active-high chip selects
      spi: dt-bindings: spi-controller: Fix #address-cells for slave mode
      spi: dt-bindings: spi-controller: Fix spi-[rt]x-bus-width for slave mode

Gustavo A. R. Silva (4):
      regulator: da9063: Replace zero-length array with flexible-array member
      regulator: da9062: Replace zero-length array with flexible-array member
      spi: spi-s3c24xx: Replace zero-length array with flexible-array member
      spi: spi-fsl-lpspi: Replace zero-length array with flexible-array member

Han Xu (3):
      spi: fspi: enable fspi on imx8qxp and imx8mm
      spi: fspi: dynamically alloc AHB memory
      spi: spi-nxp-fspi: Enable the Octal Mode in MCR0

Jisheng Zhang (4):
      regulator: bindings: add MPS mp8869 voltage regulator
      regulator: add support for MP8869 regulator
      regulator: mp886x: add MP8867 support
      regulator: mp886x: Document MP8867 support

Joe Perches (1):
      spi: Remove CONFIG_ prefix from Kconfig select

Johan Jonker (4):
      dt-bindings: spi: convert rockchip spi bindings to yaml
      dt-bindings: spi: spi-rockchip: add description for rk3308
      dt-bindings: spi: spi-rockchip: add description for rk3328
      spi: rockchip: add compatible string for px30 rk3308 rk3328

John Garry (4):
      spi: Allow SPI controller override device buswidth
      spi: HiSilicon v3xx: Properly set CMD_CONFIG for Dual/Quad modes
      spi: HiSilicon v3xx: Use DMI quirk to set controller buswidth override bits
      spi: Stop selecting MTD_SPI_NOR for SPI_HISI_SFC_V3XX

Jon Hunter (1):
      regulator: pwm: Don't warn on probe deferral

Linus Walleij (2):
      spi: mxs: Drop GPIO includes
      spi: efm32: Convert to use GPIO descriptors

Lionel Debieve (1):
      spi: stm32-qspi: properly manage probe errors

Mark Brown (12):
      Merge series "spi/HiSilicon v3xx: Support dual and quad mode through DMI quirks" from John Garry <john.garry@huawei.com>:
      Merge series "spi: spidev: Fix messages in spidev" from Oleksandr Suvorov <oleksandr.suvorov@toradex.com>:
      Merge series "trivial fixes for fsl-spi and spidev" from Oleksandr Suvorov <oleksandr.suvorov@toradex.com>:
      Merge series "Compatible string consolidation for NXP DSPI driver" from Vladimir Oltean <olteanv@gmail.com>:
      Merge series "TCFQ to XSPI migration for NXP DSPI driver" from Vladimir Oltean <olteanv@gmail.com> Vladimir Oltean <vladimir.oltean@nxp.com>:
      Merge series "spi: Add FSI-attached SPI controller driver" from Eddie James <eajames@linux.ibm.com>:
      Merge tag 'mtk-mtd-spi-move' of https://git.kernel.org/.../broonie/spi into spi-5.7
      Merge series "spi: meson-spicc: add support for AXG and G12A variants" from Neil Armstrong <narmstrong@baylibre.com>:
      Merge branch 'regulator-5.6' into regulator-linus
      Merge branch 'regulator-5.7' into regulator-next
      Merge branch 'spi-5.7' into spi-next
      Merge remote-tracking branch 'regulator/for-next' into tmp

Markus Reichl (1):
      regulator: mp8859: add supply entry

Martin Fuzzey (1):
      regulator: da9063: fix suspend

Mauro Carvalho Chehab (1):
      regulator: driver.h: fix regulator_map_* function names

Michael Walle (1):
      spi: spi-fsl-dspi: fix DMA mapping

Neil Armstrong (7):
      spi: meson-spicc: remove unused variables
      spi: meson-spicc: support max 80MHz clock
      spi: meson-spicc: add min sclk for each compatible
      spi: meson-spicc: setup IO line delay
      spi: meson-spicc: adapt burst handling for G12A support
      spi: meson-spicc: add support for Amlogic G12A
      spi: dt-bindings: amlogic, meson-gx-spicc: add Amlogic G12A compatible

Oleksandr Suvorov (3):
      spi: spidev: fix a debug message value
      spi: spidev: fix speed setting message
      spi: fsl-lpspi: remove unneeded array

Ondrej Jirman (1):
      regulator: axp20x: Fix misleading use of negation

Qiujun Huang (1):
      spi: update the structure documentation

Rishi Gupta (2):
      regulator: da9063: fix code formatting warnings and errors
      regulator: da9063: remove redundant return statement

Robert Marko (1):
      regulator: vqmmc-ipq4019-regulator: add binding document

Saravanan Sekar (3):
      dt-bindings: regulator: add document bindings for mp5416
      regulator: mp5416: add mp5416 regulator driver
      MAINTAINERS: Add entry for mp5416 PMIC driver

Sascha Hauer (1):
      spi: spi-fsl-dspi: Make bus-num property optional

Stephen Boyd (3):
      spi: spi-geni-qcom: Let firmware specify irq trigger flags
      spi: spi-geni-qcom: Grow a dev pointer to simplify code
      spi: spi-geni-qcom: Drop of.h include

Sunny Luo (2):
      spi: meson-spicc: enhance output enable feature
      spi: meson-spicc: add a linear clock divider support

Tiezhu Yang (4):
      spi: spidev_test: Remove break after exit statement
      spi: spidev_test: Check input_tx and input_file first after parse options
      spi: spidev_test: Use perror() only if errno is not 0
      spi: spidev_test: Remove the whole "include" directory when make clean

Tudor Ambarus (3):
      spi: spi-mem: Fix typo, s/fallback/falls back
      spi: spi-mem: Compute length only when needed
      spi: atmel-quadspi: Add verbose debug facilities to monitor register accesses

Vladimir Oltean (28):
      spi: spi-fsl-dspi: Use specific compatible strings for all SoC instantiations
      spi: spi-fsl-dspi: Parameterize the FIFO size and DMA buffer size
      spi: spi-fsl-dspi: LS2080A and LX2160A support XSPI mode
      spi: spi-fsl-dspi: Support SPI software timestamping in all non-DMA modes
      spi: spi-fsl-dspi: Convert the instantiations that support it to DMA
      spi: spi-fsl-dspi: Add specific compatibles for all Layerscape SoCs
      spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics
      spi: spi-fsl-dspi: Remove unused chip->void_write_data
      spi: spi-fsl-dspi: Don't mask off undefined bits
      spi: spi-fsl-dspi: Add comments around dspi_pop_tx and dspi_push_rx functions
      spi: spi-fsl-dspi: Rename fifo_{read,write} and {tx,cmd}_fifo_write
      spi: spi-fsl-dspi: Implement .max_message_size method for EOQ mode
      spi: Do spi_take_timestamp_pre for as many times as necessary
      spi: spi-fsl-dspi: Convert TCFQ users to XSPI FIFO mode
      spi: spi-fsl-dspi: Accelerate transfers using larger word size if possible
      spi: spi-fsl-dspi: Optimize dspi_setup_accel for lowest interrupt count
      spi: spi-fsl-dspi: Use EOQ for last word in buffer even for XSPI mode
      spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write
      spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
      spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
      spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
      spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
      spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
      spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion
      spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA mode
      spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path
      spi: spi-fsl-dspi: Move invariant configs out of dspi_transfer_one_message
      spi: spi-fsl-dspi: Add support for LS1028A

Wolfram Sang (1):
      spi: acpi: remove superfluous parameter check

 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml       |  36 +
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |   4 +
 .../devicetree/bindings/regulator/mp886x.txt       |  27 +
 .../devicetree/bindings/regulator/mps,mp5416.yaml  |  78 +++
 .../bindings/regulator/qcom,smd-rpm-regulator.txt  |  13 +
 .../regulator/vqmmc-ipq4019-regulator.yaml         |  42 ++
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |  22 +
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   5 +-
 .../devicetree/bindings/spi/qca,ar934x-spi.yaml    |  41 ++
 .../devicetree/bindings/spi/spi-controller.yaml    |  10 +-
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  19 +-
 .../{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt}   |  15 +-
 Documentation/devicetree/bindings/spi/spi-mux.yaml |  89 +++
 .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   3 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |  58 --
 .../devicetree/bindings/spi/spi-rockchip.yaml      | 107 +++
 MAINTAINERS                                        |  11 +-
 drivers/mtd/spi-nor/Kconfig                        |   8 -
 drivers/mtd/spi-nor/Makefile                       |   1 -
 drivers/mtd/spi-nor/mtk-quadspi.c                  | 565 ----------------
 drivers/regulator/Kconfig                          |  18 +
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/anatop-regulator.c               |  10 +-
 drivers/regulator/axp20x-regulator.c               |   6 +-
 drivers/regulator/core.c                           |   5 +-
 drivers/regulator/da9062-regulator.c               |   2 +-
 drivers/regulator/da9063-regulator.c               | 114 ++--
 drivers/regulator/mp5416.c                         | 245 +++++++
 drivers/regulator/mp8859.c                         |   1 +
 drivers/regulator/mp886x.c                         | 290 ++++++++
 drivers/regulator/pwm-regulator.c                  |   6 +-
 drivers/regulator/qcom_rpm-regulator.c             |   9 +
 drivers/regulator/qcom_smd-regulator.c             |  47 ++
 drivers/spi/Kconfig                                |  37 +-
 drivers/spi/Makefile                               |   4 +
 drivers/spi/atmel-quadspi.c                        | 119 +++-
 drivers/spi/spi-ar934x.c                           | 235 +++++++
 drivers/spi/spi-efm32.c                            |  44 +-
 drivers/spi/spi-fsi.c                              | 558 ++++++++++++++++
 drivers/spi/spi-fsl-dspi.c                         | 732 +++++++++++++--------
 drivers/spi/spi-fsl-lpspi.c                        |   9 +-
 drivers/spi/spi-geni-qcom.c                        |  26 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |  99 ++-
 drivers/spi/spi-mem.c                              |   7 +-
 drivers/spi/spi-meson-spicc.c                      | 496 ++++++++++----
 drivers/spi/spi-mtk-nor.c                          | 689 +++++++++++++++++++
 drivers/spi/spi-mux.c                              | 187 ++++++
 drivers/spi/spi-mxs.c                              |   3 +-
 drivers/spi/spi-nxp-fspi.c                         |  63 +-
 drivers/spi/spi-pxa2xx.c                           |  33 +-
 drivers/spi/spi-rockchip.c                         |   5 +-
 drivers/spi/spi-rspi.c                             |  44 +-
 drivers/spi/spi-s3c24xx.c                          |   2 +-
 drivers/spi/spi-stm32-qspi.c                       |  31 +-
 drivers/spi/spi-stm32.c                            |  62 +-
 drivers/spi/spi.c                                  |  34 +-
 drivers/spi/spidev.c                               |  23 +-
 include/linux/regulator/driver.h                   |   4 +-
 include/linux/soc/qcom/smd-rpm.h                   |   1 +
 include/linux/spi/spi.h                            |   9 +-
 tools/spi/Makefile                                 |   2 +-
 tools/spi/spidev_test.c                            |  14 +-
 62 files changed, 4159 insertions(+), 1322 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (75%)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.yaml
 delete mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c
 create mode 100644 drivers/regulator/mp5416.c
 create mode 100644 drivers/regulator/mp886x.c
 create mode 100644 drivers/spi/spi-ar934x.c
 create mode 100644 drivers/spi/spi-fsi.c
 create mode 100644 drivers/spi/spi-mtk-nor.c
 create mode 100644 drivers/spi/spi-mux.c

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6B6AsACgkQJNaLcl1U
h9Azggf+JQKCH6X/0YgsbJS5WCr7ytoXKrwKGHQyQksiYfqNb18XsG9YtmdqsaEa
72N6VUmMv2LSOL2vRsiZhKuRyEI85+jYjnqSfWZso1qphLzy5MC4Gf04tbX0u9m7
etT2nC6qoAs9eSSDkeaKp/bHV8vF4SSsntgS8i+mIiXdMVq+Dp3ksyaz3GqwDsrh
J4iOkj0bU8F88qTZ1fTdU4dy+nFXAaH9ugUU7WfGU4R+dqfXQH8Y0iuetUZacXJo
g8KRpVcysYQ2FticAddsnnM392lqj9vwpoCvwGE1fET+7/ZIDy4O6ZPkNDYcZLD/
py/FkS8wHwr8Q4LNrCkaMqy7zQOLYA==
=VJqS
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
