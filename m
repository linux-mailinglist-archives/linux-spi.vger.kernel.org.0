Return-Path: <linux-spi+bounces-9198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACBB13A73
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6973B7A5820
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FEB263F34;
	Mon, 28 Jul 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E26ONR4P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDD1C8606;
	Mon, 28 Jul 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705487; cv=none; b=FIpHJSR9r0uzSzaaOClGzfOC2RqsSXQpPftWRgdW3xJ31b2x8nNSBEFxdBz1Z9BmzgUW8Hth75uf7Cw3dvNuE4rh0pjIasFASZKcVZWKucYHA05aMgQstsG7TmfuriV7g28qpZnaGoihg2ZQx6wN0SGTlve8N4eJ/0XyXipUhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705487; c=relaxed/simple;
	bh=GnbJTTc9uc5u8yqjxhZ3d9PZFrYsgp3uI8ziD/c0gYQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=RAv5vi0G6kHz/CR+BFriI4lLNjB1fwTi9wTxX2MtfLQi+HDYukSOPIvWBrQ5+AM0XC4nE6IzFQTZ87CwBbJhaZeFTXA+LcIiMvPNmTlrMKVPu46w8L/ZQVqwmpFa1pjRUm9Czm7R9b3qFHgGymYElYi/lwkobx3M3gxefSkggLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E26ONR4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93B9C4CEE7;
	Mon, 28 Jul 2025 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753705487;
	bh=GnbJTTc9uc5u8yqjxhZ3d9PZFrYsgp3uI8ziD/c0gYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=E26ONR4Pm8x1XYff5eyMxsXgvk+uZSuHCkWRYke1s0XQL+zY9AYJlzlSYAT0+krZX
	 a6MV2duqJrGUz0exjMpcAaovUAd7jGsErlY5/4Rq7m+w5Qnm/txyFOsd2GbNY3WTw/
	 qGzNInZzSB2SmYJO0yzM9wERWTC2OnwWNfa2RBocdn2RFEdd9+VwV3jC0ybeYkF6FS
	 eGiepXYJ0g3Y97tl34DATJWkF78dCP5KWx9emPHKtcAyA+8SEJxqh3AMe8eQELRcIh
	 ErykXzac5W91IMVBq9x1Ztz+OGAF/gk8nfAVku4cBg5vQmGQ3ljlHldKm9uuEzW+x2
	 SQU7c2Bq+agUA==
Message-ID: <ead4b31b9f656b8a7ac9280d368fd210.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.17
Date: Mon, 28 Jul 2025 13:24:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.17

for you to fetch changes up to 2d442a0c781403702de27ccfbc4bb233721585f5:

  spi: SPISG: Fix less than zero comparison on a u32 variable (2025-07-25 18:46:31 +0100)

----------------------------------------------------------------
spi: Updates for v6.17

This release is almost entirely driver work, mostly new drivers with the
usual smattering of per driver updates anf fixes, with only trivial
changes in the core.  Highlights include:

 - Quite a bit of maintainence work on the STM32 and Qualcomm drivers.
 - Usage of the newly added devm_dma_request_chan() in the ateml driver,
   pulling in the relevant dmaengine change.
 - Cleanups of our usage of the PM autosuspend functions, this pulls in
   some PM core changes on a shared tag.
 - Support for ADI sigma-delta triggers, Amlogic SPISG, Mediatek MT6991
   and MT8196, Renesas RZ/V2H(P) and SOPHGO SG2042.

----------------------------------------------------------------
Andra-Teodora Ilie (1):
      spi: spi-fsl-dspi: Enable modified transfer protocol on S32G

AngeloGioacchino Del Regno (2):
      spi: dt-bindings: mediatek,spi-mt65xx: Add support for MT6991/MT8196 SPI
      spi: spi-mt65xx: Add support for MT6991 Dimensity 9400 SPI IPM

Antonio Quartulli (1):
      spi: stm32: fix pointer-to-pointer variables usage

Bence Csókás (2):
      dmaengine: Add devm_dma_request_chan()
      spi: atmel-quadspi: Use `devm_dma_request_chan()`

Ciprian Marian Costea (2):
      dt-bindings: spi: dspi: Add S32G support
      spi: spi-fsl-dspi: Enable support for S32G platforms

Clément Le Goffic (7):
      spi: stm32: Add SPI_READY mode to spi controller
      spi: stm32: Check for cfg availability in stm32_spi_probe
      spi: stm32: use STM32 DMA with STM32 MDMA to enhance DDR use
      spi: stm32: deprecate `st,spi-midi-ns` property
      spi: dt-bindings: stm32: update bindings with SPI Rx DMA-MDMA chaining
      spi: dt-bindings: stm32: deprecate `st,spi-midi-ns` property
      spi: stm32: fix sram pool free in probe error path

Colin Ian King (1):
      spi: SPISG: Fix less than zero comparison on a u32 variable

Conor Dooley (2):
      spi: microchip-core-qspi: set min_speed_hz during probe
      spi: microchip-core-qspi: remove unused param from mchp_coreqspi_write_op()

Cyril Jean (1):
      spi: microchip-core-qspi: Add regular transfers

Dan Carpenter (2):
      spi: stm32: delete stray tabs in stm32h7_spi_data_idleness()
      spi: stm32-ospi: Fix NULL vs IS_ERR() bug in stm32_ospi_get_resources()

Darshan Rathod (2):
      spi: xilinx: Fix block comment style and minor cleanups
      spi: gpio: Use explicit 'unsigned int' for parameter types

David Lechner (2):
      dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI
      spi: offload trigger: add ADI Util Sigma-Delta SPI driver

Fabrizio Castro (2):
      spi: dt-bindings: Document the RZ/V2H(P) RSPI
      spi: Add driver for the RZ/V2H(P) RSPI IP

Frank Li (2):
      spi: dt-bindings: mxs-spi: allow clocks properpty
      spi: dt-bindings: add nxp,lpc3220-spi.yaml

Gabor Juhos (5):
      spi: spi-qpic-snand: use NANDC_STEP_SIZE consistently
      spi: spi-qpic-snand: remove 'qpic_snand_op' structure
      mtd: nand: qpic-common: add defines for ECC_MODE values
      spi: spi-qpic-snand: add support for 8 bits ECC strength
      spi: spi-qpic-snand: simplify bad block marker duplication

Geert Uytterhoeven (2):
      spi: sh-msiof: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      spi: rspi: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Heiko Schocher (2):
      dt-bindings: trivial-devices: Document ABB sensors
      spi: spidev: Add an entry for the ABB spi sensors

Jakub Czapiga (1):
      spi: intel: Allow writeable MTD partition with module param

James Clark (2):
      spi: spi-fsl-dspi: Re-use one volatile regmap for both device types
      spi: spi-fsl-dspi: Define regmaps per device

Larisa Grigore (4):
      spi: spi-fsl-dspi: Add config and regmaps for S32G platforms
      spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers
      spi: spi-fsl-dspi: Use DMA for S32G controller in target mode
      spi: spi-fsl-dspi: Reinitialize DSPI regs after resuming for S32G

Lukas Bulwahn (1):
      spi: spi-fsl-dspi: Revert unintended dependency change in config SPI_FSL_DSPI

Marius Trifu (1):
      spi: spi-fsl-dspi: Use spi_alloc_target for target

Mark Brown (12):
      spi: spi-fsl-dspi: DSPI support for NXP S32G
      spi: Merge up fixes
      spi: microchip-core-qspi: Add regular transfers
      Add few updates to the STM32 SPI driver
      Add `devm_dma_request_chan()` to simplify probe
      iio: adc: ad7173: add SPI offload support
      spi: spi-qpic-snand: enable 8 bits ECC strength
      treewide: Remove redundant
      spidev: introduce trivial abb sensor device
      support for amlogic the new SPI IP
      Add RSPI support for RZ/V2H
      spi: sophgo: Add SPI NOR controller for SG2042

Raphael Gallais-Pou (1):
      spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()

Rob Herring (Arm) (3):
      spi: dt-bindings: Convert marvell,orion-spi to DT schema
      spi: stm32-ospi: Use of_reserved_mem_region_to_resource() for "memory-region"
      spi: dt-bindings: spi-mux: Drop "spi-max-frequency" as required

Sakari Ailus (7):
      PM: runtime: Document return values of suspend-related API functions
      PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_autosuspend()
      PM: runtime: Mark last busy stamp in pm_request_autosuspend()
      Documentation: PM: *_autosuspend() functions update last busy time
      spi: Remove redundant pm_runtime_mark_last_busy() calls

Shiji Yang (1):
      spi: falcon: mark falcon_sflash_xfer() as static

Sunny Luo (2):
      spi: dt-bindings: Add binding document of Amlogic SPISG controller
      spi: Add Amlogic SPISG driver

Thangaraj Samynathan (3):
      spi: spi-pci1xxxx: Add support for 25MHz Clock frequency in C0
      spi: spi-pci1xxxx: Add support for per-instance DMA interrupt vectors
      spi: spi-pci1xxxx: enable concurrent DMA read/write across SPI transfers

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spi driver

Zixian Zeng (3):
      spi: dt-bindings: spi-sg2044-nor: Change SOPHGO SG2042
      spi: spi-sg2044-nor: Add configurable chip_info
      spi: spi-sg2044-nor: Add SPI-NOR controller for SG2042

 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  |  59 ++
 .../devicetree/bindings/spi/fsl,dspi.yaml          |  18 +
 .../devicetree/bindings/spi/marvell,orion-spi.yaml | 102 +++
 .../bindings/spi/mediatek,spi-mt65xx.yaml          |   5 +
 Documentation/devicetree/bindings/spi/mxs-spi.yaml |   3 +
 .../devicetree/bindings/spi/nxp,lpc3220-spi.yaml   |  44 +
 .../bindings/spi/renesas,rzv2h-rspi.yaml           |  96 +++
 Documentation/devicetree/bindings/spi/spi-mux.yaml |   1 -
 .../devicetree/bindings/spi/spi-orion.txt          |  79 --
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../devicetree/bindings/spi/spi-sg2044-nor.yaml    |   9 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |  48 +-
 .../trigger-source/adi,util-sigma-delta-spi.yaml   |  49 ++
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 Documentation/power/runtime_pm.rst                 |  50 +-
 MAINTAINERS                                        |  16 +-
 drivers/dma/dmaengine.c                            |  30 +
 drivers/mtd/nand/raw/qcom_nandc.c                  |   6 +-
 drivers/spi/Kconfig                                |  26 +-
 drivers/spi/Makefile                               |   3 +
 drivers/spi/atmel-quadspi.c                        |  53 +-
 drivers/spi/spi-amlogic-spisg.c                    | 888 +++++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.c                  |   2 -
 drivers/spi/spi-cadence.c                          |   1 -
 drivers/spi/spi-falcon.c                           |   5 +-
 drivers/spi/spi-fsl-dspi.c                         | 356 ++++++---
 drivers/spi/spi-fsl-espi.c                         |   2 -
 drivers/spi/spi-fsl-lpspi.c                        |   2 -
 drivers/spi/spi-gpio.c                             |  16 +-
 drivers/spi/spi-imx.c                              |   3 -
 drivers/spi/spi-intel.c                            |  13 +-
 drivers/spi/spi-microchip-core-qspi.c              | 226 +++++-
 drivers/spi/spi-mt65xx.c                           |  11 +
 drivers/spi/spi-mtk-nor.c                          |   1 -
 drivers/spi/spi-nxp-fspi.c                         |   1 -
 .../spi/spi-offload-trigger-adi-util-sigma-delta.c |  59 ++
 drivers/spi/spi-omap2-mcspi.c                      |   3 -
 drivers/spi/spi-pci1xxxx.c                         | 285 ++++---
 drivers/spi/spi-qpic-snand.c                       |  72 +-
 drivers/spi/spi-rockchip-sfc.c                     |   3 -
 drivers/spi/spi-rspi.c                             |   9 +-
 drivers/spi/spi-rzv2h-rspi.c                       | 466 +++++++++++
 drivers/spi/spi-s3c64xx.c                          |   3 -
 drivers/spi/spi-sg2044-nor.c                       |  29 +-
 drivers/spi/spi-sh-msiof.c                         |  11 +-
 drivers/spi/spi-sprd.c                             |   1 -
 drivers/spi/spi-st-ssc4.c                          |  14 +-
 drivers/spi/spi-stm32-ospi.c                       |  31 +-
 drivers/spi/spi-stm32-qspi.c                       |   7 -
 drivers/spi/spi-stm32.c                            | 318 +++++++-
 drivers/spi/spi-ti-qspi.c                          |   2 -
 drivers/spi/spi-xilinx.c                           |   5 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   1 -
 drivers/spi/spi.c                                  |   3 -
 drivers/spi/spidev.c                               |   2 +
 include/linux/dmaengine.h                          |   7 +
 include/linux/mtd/nand-qpic-common.h               |   2 +
 include/linux/pm_runtime.h                         | 187 ++++-
 58 files changed, 3150 insertions(+), 597 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/marvell,orion-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,lpc3220-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt
 create mode 100644 Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
 create mode 100644 drivers/spi/spi-amlogic-spisg.c
 create mode 100644 drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
 create mode 100644 drivers/spi/spi-rzv2h-rspi.c

