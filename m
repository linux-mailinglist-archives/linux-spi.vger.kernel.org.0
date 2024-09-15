Return-Path: <linux-spi+bounces-4820-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D91979986
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2024 01:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361CE1C21E80
	for <lists+linux-spi@lfdr.de>; Sun, 15 Sep 2024 23:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF8381B1;
	Sun, 15 Sep 2024 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqexBrwE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46E8C13;
	Sun, 15 Sep 2024 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726442815; cv=none; b=ZFveTvUgYGC39D2HYl7pYBNmhcVYqLq8IZa0LlIjSo1h+6Fviafe79lqbNDE30AQMu5O2wtttjzjuT5rs5HJ2Q45th2f0m7GrkHmSKndXMBsPlZ5eqrEDE3Gm72vnTGdPTwIeBv8sBM6Jwf9Mk8z81H8LK3FcWuY5hNzJToZ6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726442815; c=relaxed/simple;
	bh=50IN3Xr4Ur/iTpTH0O7rgXqAOWhWx8FS1pxMXESFGLU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Ik/QT78SSUSRj/wImkd3etr4bAsLhKPy0OH1o6Uxt3K0uACYeL0vMRqBoO8tEyjZCJtD5b5I7uoLNl8CNdcBTMe3U4OOptuXRyQNEaHh29kHb1LjZn4XC+824ybDdJz5cfR3vyogf0UAULNjzfQD/K8eWFwnn3InGp/litVNpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqexBrwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6F3C4CEC3;
	Sun, 15 Sep 2024 23:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726442814;
	bh=50IN3Xr4Ur/iTpTH0O7rgXqAOWhWx8FS1pxMXESFGLU=;
	h=From:To:Cc:Subject:Date:From;
	b=qqexBrwENZcS/CYo28cSx33xGTFSxsn9daGj+cN4BrkgC2k75rOEvZI/irJF2bjAO
	 Nts19EmWu2BM26lpifpxnSr/nhC7f7jnVx+nM+1EOHQOQ2TsviEiFFtKDYkDgEnbxH
	 OIhMnG+drasGEVabRgGhiSGq+4c2sN0aZTMLsz072eWEQ2h8dlJue108xDUwm2omnt
	 /d5P3aufvvQMng+cZFHIGlOaUMuOeLOBKoxb734sQTNAy4hJ+W9fPqKHjceaSik8HU
	 Ehzja+qlsCdSeiLmUA3Zzc3IiLp5PgRVwu+LQYdgm9wtyDP+Cbllz9RuNkzqc/3/Z1
	 1pwV8G+XOeK1w==
Message-ID: <ed8725667a2a9b9a1ca8fc371c792772.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.12
Date: Mon, 16 Sep 2024 00:26:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit b787a33864121a565aeb0e88561bf6062a19f99c:

  spi: geni-qcom: Fix incorrect free_irq() sequence (2024-09-09 12:57:33 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.12

for you to fetch changes up to 07f1eb718db281c3e0cdb068ea7d73c30921a81c:

  spi: geni-qcom: Use devm functions to simplify code (2024-09-12 12:39:04 +0100)

----------------------------------------------------------------
spi: Updates for v6.12

This is quite a quiet release for sPI.  The one new core feature here is
support for configuring the state of the MOSI pin when the bus is idle,
there are some devices which are very fragile in this regard even when
the chip select signal is not asserted.  Otherwise we have some new
driver support, a bunch of small fixes and some general cleanup work.

 - Support for configuring the state of the MOSI pin when the the bus is
   idle.
 - Add the Elgin JG0309-01 in spidev.
 - Support for Marvell xSPI, Mediatek MTK7981, Microchip PIC64GX,
   NXP i.MX8ULP, and Rockchip RK3576 controllers.

I also accidentally pulled in an IIO DT bindings update due to a typo
when applying the MOSI idle state patches.

----------------------------------------------------------------
Andy Shevchenko (3):
      spi: ppc4xx: Avoid returning 0 when failed to parse and map IRQ
      spi: ppc4xx: Revert "handle irq_of_parse_and_map() errors"
      spi: ppc4xx: Sort headers

AngeloGioacchino Del Regno (1):
      spi: spi-mt65xx: Use threaded interrupt for non-SPIMEM transfer

Bastien Curutchet (1):
      spi: davinci: Adapt transfer's timeout to transfer's length

Biju Das (1):
      spi: rpc-if: Add missing MODULE_DEVICE_TABLE

Chen Ni (1):
      spi: meson-spicc: convert comma to semicolon

David Lechner (1):
      spi: axi-spi-engine: don't emit XFER_BITS for empty xfer

Detlev Casanova (1):
      spi: dt-bindings: Add rockchip,rk3576-spi compatible

Fabio Estevam (3):
      dt-bindings: trivial-devices: Document elgin,jg10309-01
      spi: spidev: Add an entry for elgin,jg10309-01
      spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()

Frank Li (1):
      spi: dt-bindings: convert spi-sc18is602.txt to yaml format

Haibo Chen (3):
      dt-bindings: spi: nxp-fspi: add imx8ulp support
      spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
      spi: fspi: add support for imx8ulp

Hongbo Li (1):
      spi: spi-ppc4xx: Remove duplicate included header file linux/platform_device.h

Jinjie Ruan (16):
      spi: cadence: Make cdns_mrvl_xspi_clk_div_list static
      spi: s3c64xx: Fix module autoloading
      spi: bcm63xx: Fix module autoloading
      spi: bcm63xx: Fix missing pm_runtime_disable()
      spi: wpcm-fiu: Use devm_platform_ioremap_resource_byname()
      spi: atmel-quadspi: Simpify resource lookup
      spi: bcmbca-hsspi: Simpify resource lookup
      spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
      spi: bcmbca-hsspi: Use devm_spi_alloc_host()
      spi: atmel-quadspi: Fix uninitialized res
      spi: atmel-quadspi: Simplify with dev_err_probe()
      spi: wpcm-fiu: Fix uninitialized res
      spi: wpcm-fiu: Simplify with dev_err_probe()
      spi: zynqmp-gqspi: Use devm_spi_alloc_host()
      spi: zynqmp-gqspi: Simplify with dev_err_probe()
      spi: geni-qcom: Use devm functions to simplify code

Krzysztof Kozlowski (1):
      spi: cadence-quadspi: Simplify with scoped for each OF child loop

Kuan-Wei Chiu (1):
      spi: zynq-qspi: Replace kzalloc with kmalloc for buffer allocation

Ma Ke (2):
      spi: ppc4xx: handle irq_of_parse_and_map() errors
      spi: ppc4xx: handle irq_of_parse_and_map() errors

Marcelo Schmitt (5):
      spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
      spi: bitbang: Implement support for MOSI idle state configuration
      spi: spi-gpio: Add support for MOSI idle state configuration
      spi: spi-axi-spi-engine: Add support for MOSI idle configuration
      dt-bindings: iio: adc: Add AD4000

Mark Brown (9):
      Add support for AD4000 series of ADCs
      Marvell HW overlay support for Cadence xSPI
      spi: Add dummy definitions for ACPI lookup functions
      spi: bcm63xx: Fix two bugs
      spi: wpcm-fiu: Fix uninitialized res
      spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
      spi: atmel-quadspi: Fix uninitialized res
      Add device tree for ArmSoM Sige 5 board
      spi: Merge up fixes

Nathan Chancellor (1):
      spi: Revert "spi: Insert the missing pci_dev_put()before return"

Pierre-Henry Moussay (1):
      dt-bindings: spi: add PIC64GX SPI/QSPI compatibility to MPFS SPI/QSPI bindings

Rafał Miłecki (1):
      spi: dt-bindings: mediatek,spi-mt65xx: add compatible for MT7981

Witold Sadowski (10):
      spi: dt-bindings: cadence: Add Marvell overlay bindings documentation for Cadence XSPI
      spi: cadence: Add static PHY configuration in Marvell overlay
      spi: cadence: Add clock configuration for Marvell xSPI overlay
      spi: cadence: Add Marvell SDMA operations
      spi: cadence: Add Marvell xSPI interrupt changes
      spi: cadence: Add Marvell xfer operation support
      spi: cadence: Change resource mapping
      spi: cadence: Change cs property reading.
      spi: cadence: Try to read spi-tx/rx-bus width property using ACPI
      spi: cadence: Add 64BIT Kconfig dependency

Yan Zhen (1):
      spi: nxp-fspi: Use max macro

Yang Ruibin (1):
      spi: Insert the missing pci_dev_put()before return

Yang Yingliang (7):
      spi: switch to use spi_controller_is_target()
      spi: slave-time: switch to use spi_target_abort()
      spi: slave-system-control: switch to use spi_target_abort()
      spi: spidev: switch to use spi_target_abort()
      spi: slave-mt27xx: switch to use target_abort
      platform/olpc: olpc-xo175-ec: switch to use spi_target_abort().
      spi: remove spi_controller_is_slave() and spi_slave_abort()

zhang jiao (1):
      spi: spidev_fdx: Fix the wrong format specifier

 .../devicetree/bindings/iio/adc/adi,ad4000.yaml    | 197 ++++++
 .../devicetree/bindings/spi/cdns,xspi.yaml         |  32 +-
 .../bindings/spi/mediatek,spi-mt65xx.yaml          |   1 +
 .../bindings/spi/microchip,mpfs-spi.yaml           |   7 +-
 .../devicetree/bindings/spi/nxp,sc18is.yaml        |  51 ++
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml      |   1 +
 .../devicetree/bindings/spi/spi-rockchip.yaml      |   1 +
 .../devicetree/bindings/spi/spi-sc18is602.txt      |  23 -
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/spi/spi-summary.rst                  |  83 +++
 MAINTAINERS                                        |   7 +
 drivers/platform/olpc/olpc-xo175-ec.c              |   4 +-
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/atmel-quadspi.c                        |  31 +-
 drivers/spi/spi-axi-spi-engine.c                   |  17 +-
 drivers/spi/spi-bcm63xx.c                          |   9 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |  25 +-
 drivers/spi/spi-bitbang.c                          |  24 +
 drivers/spi/spi-cadence-quadspi.c                  |   9 +-
 drivers/spi/spi-cadence-xspi.c                     | 692 ++++++++++++++++++++-
 drivers/spi/spi-davinci.c                          |   8 +-
 drivers/spi/spi-geni-qcom.c                        |  63 +-
 drivers/spi/spi-gpio.c                             |  12 +-
 drivers/spi/spi-meson-spicc.c                      |  22 +-
 drivers/spi/spi-mt65xx.c                           |  40 +-
 drivers/spi/spi-mxs.c                              |  11 +-
 drivers/spi/spi-nxp-fspi.c                         |  57 +-
 drivers/spi/spi-ppc4xx.c                           |  22 +-
 drivers/spi/spi-rpc-if.c                           |   7 +
 drivers/spi/spi-s3c64xx.c                          |   1 +
 drivers/spi/spi-slave-mt27xx.c                     |  12 +-
 drivers/spi/spi-slave-system-control.c             |   2 +-
 drivers/spi/spi-slave-time.c                       |   2 +-
 drivers/spi/spi-wpcm-fiu.c                         |  17 +-
 drivers/spi/spi-zynq-qspi.c                        |   2 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  32 +-
 drivers/spi/spi.c                                  |  27 +-
 drivers/spi/spidev.c                               |   2 +-
 include/linux/spi/spi.h                            |  12 +-
 include/linux/spi/spi_bitbang.h                    |   1 +
 include/uapi/linux/spi/spi.h                       |   5 +-
 tools/spi/spidev_fdx.c                             |   2 +-
 42 files changed, 1305 insertions(+), 272 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,sc18is.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sc18is602.txt

