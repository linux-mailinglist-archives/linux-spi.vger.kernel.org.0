Return-Path: <linux-spi+bounces-8297-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA9AC3DE3
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2D71897B55
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874841F561D;
	Mon, 26 May 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8F/oB0/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC201F5617;
	Mon, 26 May 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255427; cv=none; b=EU93bJw3UVXns/cOe6l7kRJHqeB4TTunB8KqYy3TEOH3l470uyN/rZTkA+aoJo1sUeJduqTqFRxofqBHYnJxWMj9+UCgArwKhxcV+/wkBxnlkjQy01UtrrGH2lKha/NieN138A1Xj6u9TWClJrJTjXi7Wf0aYvxePerixPS/htc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255427; c=relaxed/simple;
	bh=m/RXC0tnxsKx+i68EQW5cKjFDLVpt+8xAr1HVxEWajU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=cYgSFYAFvKwo9X+jmBpHRYEiUXpXa4et9AtayuCOBoupoOzcqqK5jmxwTFe08RBM3MPoSa0KCABcN88X9lfer7d/DaZX77NtFAlQGL8RuMtqklNBW4iveZaT2OyeJRLSIqNAM/LFEWlypLnRVT4B1t8kyvkXwF0EpDjUaLXinAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8F/oB0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1144C4CEEE;
	Mon, 26 May 2025 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748255427;
	bh=m/RXC0tnxsKx+i68EQW5cKjFDLVpt+8xAr1HVxEWajU=;
	h=From:To:Cc:Subject:Date:From;
	b=o8F/oB0/0hsj0mOWoaSlpCFyxhKGXgIxmyAonf3OyZAz2d4s2VM3pyyRyxDXNI088
	 zL+Lt0Pb2eG7N19wrABYeSAZ3KKrJHLbtnCmeVQWmS4am+8lRF/YNBPxhZbj5RqaBx
	 9nPk5J3t4M6As0LxNNOlXv474I2mCh8HUuQXQYvkBg6UP3ENZhhUkU1gse496FNGUU
	 1ADHgwqcyWfHpX3JUhNTuawWe9O8s90Mwj5H94IYBw8V1mZ9Ddpu2jEFL0fgtlb7hq
	 X2js6XwcOA3wpolWsJbl3vhXIC6hcIgcXsRZLzmLRC6m379jyMiLPgvRZ3yyM816GC
	 yztw128s8FNGg==
Message-ID: <4a1559fc9c5d1fec91f1ac5d425871b5.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.16
Date: Mon, 26 May 2025 11:30:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.16

for you to fetch changes up to b00d6864a4c948529dc6ddd2df76bf175bf27c63:

  spi: spi-qpic-snand: extend bitmasks usage (2025-05-23 16:51:35 +0100)

----------------------------------------------------------------
spi: Updates for v6.16

This bulk of the changes in this release are driver work, as well as
new device support we have some important work on performance over
several drivers, and big overhauls for maintainability on a couple too.
Highlights include:

 - Big cleanups of the sh-msiof driver from Geert Uytterhoeven, and of
   the NXP FSPI driver from Haibo Chen.
 - Performance improvements for the AXI SPI engine.
 - Support for writes to memory mapped flashes on Renesas devices.
 - Integrated DMA support for Tegra210 QSPI, used by the Tegra234.
 - DMA support for Amlogic SPI controllers.
 - Support for AMD HID2, Qualcomm IPQ5018, Renesas RZ/G3E, Rockchip
   RK3528 and Samsung Exynos Autov920.

An update to fix some issues with the Atmel QSPI driver runtime PM
pulled in a new API from the PM core, and the Renesas memory mapped
write changes pull in some code that's shared in drivers/memory.

----------------------------------------------------------------
Andres Urian Florez (2):
      spi: offload: check for match callback when a trigger is being registered
      spi: offload: remove unnecessary check on trigger->ops

Andy Shevchenko (4):
      spi: Group CS related fields in struct spi_device
      spi: Simplify conditionals in spi_set_cs()
      spi: Add spi_bpw_to_bytes() helper and use it
      spi: dw: Use spi_bpw_to_bytes() helper

Arnd Bergmann (1):
      spi: amd: add CONFIG_PCI dependency

Bartosz Golaszewski (1):
      spi: xcomm: use new GPIO line value setter callbacks

Bence Csókás (2):
      PM: runtime: Add new devm functions
      spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API

Biju Das (10):
      memory: renesas-rpc-if: Fix RPCIF_DRENR_CDB macro error
      memory: renesas-rpc-if: Move rpcif_info definitions near to the user
      dt-bindings: memory: Document RZ/G3E support
      memory: renesas-rpc-if: Move rpc-if reg definitions
      memory: renesas-rpc-if: Use devm_reset_control_array_get_exclusive()
      memory: renesas-rpc-if: Add regmap to struct rpcif_info
      memory: renesas-rpc-if: Add wrapper functions
      memory: renesas-rpc-if: Add RZ/G3E xSPI support
      memory: renesas-rpc-if: Add missing static keyword
      spi: rpc-if: Add write support for memory-mapped area

Chukun Pan (1):
      spi: dt-bindings: Add rk3528-spi compatible

Dan Carpenter (1):
      spi: spi_amd: Fix an IS_ERR() vs NULL check in probe

David Lechner (4):
      spi: axi-spi-engine: wait for completion in setup
      spi: axi-spi-engine: don't repeat mode config for offload
      spi: axi-spi-engine: optimize bits_per_word for offload
      spi: axi-spi-engine: omit SYNC from offload instructions

Faraz Ata (1):
      dt-bindings: spi: samsung: add exynosautov920-spi compatible

Gabor Juhos (8):
      spi: spi-qpic-snand: use kmalloc() for OOB buffer allocation
      spi: spi-qpic-snand: remove unused 'wlen' member of 'struct qpic_spi_nand'
      spi: spi-qpic-snand: validate user/chip specific ECC properties
      spi: spi-qpic-snand: use CW_PER_PAGE_MASK bitmask
      spi: spi-qpic-snand: extend FIELD_PREP() macro usage
      spi: spi-qpic-snand: reuse qcom_spi_check_raw_flash_errors()
      spi: spi-qpic-snand: remove superfluous parameters of qcom_spi_check_error()
      spi: spi-qpic-snand: return early on error from qcom_spi_io_op()

Geert Uytterhoeven (22):
      spi: loopback-test: Simplify strange loopback value check
      spi: sh-msiof: Drop comma after OF match table sentinel
      spi: sh-msiof: Remove unneeded compatible values
      spi: sh-msiof: Fix maximum DMA transfer size
      spi: sh-msiof: Complete using dev in sh_msiof_spi_probe()
      spi: sh-msiof: Use bool for boolean flags
      spi: sh-msiof: Make words/bits unsigned in sh_msiof_spi_txrx_once()
      spi: sh-msiof: Make words/fs unsigned in FIFO helpers
      spi: sh-msiof: SITMDR1/SIRMDR1 bitfield conversion
      spi: sh-msiof: SITMDR2 and SIRMDR2 bitfield conversion
      spi: sh-msiof: SITSCR/SIRSCR bitfield conversion
      spi: sh-msiof: SICTR bitfield conversion
      spi: sh-msiof: SIFCTR bitfield conversion
      spi: sh-msiof: Correct SIMDR2_GRPMASK
      spi: sh-msiof: Add core support for dual-group transfers
      spi: sh-msiof: Correct RX FIFO size for R-Car Gen2
      spi: sh-msiof: Correct RX FIFO size for R-Car Gen3
      spi: sh-msiof: Increase TX FIFO size for R-Car V4H/V4M
      spi: sh-msiof: Simplify BRG's Division Ratio
      spi: sh-msiof: Double maximum DMA transfer size using two groups
      spi: sh-msiof: Document frame start sync pulse mode
      spi: sh-msiof: Move register definitions to <linux/spi/sh_msiof.h>

George Moussalem (1):
      spi: dt-bindings: spi-qpic-snand: Add IPQ5018 compatible

Greg Kroah-Hartman (2):
      spi: gpio: fix const issue in spi_to_spi_gpio()
      spi: loopback-test: fix up const pointer issue in rx_ranges_cmp()

Haibo Chen (4):
      spi: spi-nxp-fspi: remove the goto in probe
      spi: spi-nxp-fspi: enable runtime pm for fspi
      spi: spi-nxp-fspi: use guard(mutex) to simplify the code
      spi: spi-nxp-fspi: remove the unchecked return value for nxp_fspi_clk_disable_unprep

Han Xu (1):
      spi: nxp-fspi: use devm instead of remove for driver detach

Heiner Kallweit (1):
      spi: intel: Improve resource mapping

Kevin Hao (2):
      spi: fsl-qspi: Simplify probe error handling using managed API
      spi: fsl-qspi: Optimize fsl_qspi struct

Krzysztof Kozlowski (5):
      spi: atmel-quadspi: Fix printed error code during DMA setup
      spi: cs42l43: Make handling missing spk-id GPIOs explicit
      spi: cadence-quadspi: Assume device could match via platform
      spi: dt-bindings: fsl,dspi: Fix example indentation
      spi: dt-bindings: nuvoton,wpcm450-fiu: Drop unrelated nodes from DTS example

Kuninori Morimoto (2):
      spi: sh-msiof: use dev in sh_msiof_spi_probe()
      spi: sh-msiof: ignore driver probing if it was MSIOF Sound

Mark Brown (11):
      spi: spi-stm32-ospi: dt-bindings fixes
      spi: fsl-qspi: Fix double cleanup in probe error path
      spi: Introduce and use spi_bpw_to_bytes()
      ASoC: add Renesas MSIOF sound driver
      Configure Clocks, Add Internal DMA support
      spi: axi-spi-engine: offload instruction optimization
      This patch set did some clean up and add runtime pm
      Add RZ/G3E xSPI support
      Add more devm_ functions to fix PM imbalance in
      spi: sh-msiof: Transfer size improvements and I2S
      spi: spi-qpic-snand: extend bitmasks usage

Mukesh Kumar Savaliya (1):
      spi: Add support for Double Transfer Rate (DTR) mode

Patrice Chotard (2):
      spi: dt-bindings: st,stm32mp25-ospi: Make "resets" a required property
      spi: spi-stm32-ospi: Make "resets" a required property

Philipp Stanner (2):
      spi: spi-cavium-thunderx: Use non-hybrid PCI devres API
      spi: pci1xxxx: Use non-hybrid PCI devres API

Raju Rangoju (4):
      spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller
      spi: spi_amd: Remove read{q,b} usage on DMA buffer
      spi: spi_amd: Add HIDDMA basic write support
      spi: spi_amd: Update Kconfig dependencies

Vishwaroop A (6):
      spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
      spi: tegra210-quad: remove redundant error handling code
      spi: tegra210-quad: modify chip select (CS) deactivation
      spi: tegra210-quad: Update dummy sequence configuration
      spi: tegra210-quad: Add support for internal DMA
      spi: dt-bindings: tegra: Document IOMMU property for Tegra234 QSPI

Wolfram Sang (1):
      spi: dt-bindings: Fix description mentioning a removed property

Xianwei Zhao (1):
      spi: meson-spicc: add DMA support

 .../memory-controllers/renesas,rzg3e-xspi.yaml     | 135 ++++
 .../devicetree/bindings/spi/fsl,dspi.yaml          |  14 +-
 .../bindings/spi/nuvoton,wpcm450-fiu.yaml          |   5 -
 .../bindings/spi/nvidia,tegra210-quad.yaml         |  18 +-
 .../bindings/spi/qcom,spi-qpic-snand.yaml          |   8 +-
 .../devicetree/bindings/spi/samsung,spi.yaml       |   1 +
 .../bindings/spi/spi-peripheral-props.yaml         |  13 +-
 .../devicetree/bindings/spi/spi-rockchip.yaml      |   1 +
 .../devicetree/bindings/spi/st,stm32mp25-ospi.yaml |   1 +
 MAINTAINERS                                        |   2 +
 drivers/base/power/runtime.c                       |  44 ++
 drivers/memory/renesas-rpc-if-regs.h               | 147 +++++
 drivers/memory/renesas-rpc-if.c                    | 714 +++++++++++++++------
 drivers/memory/renesas-xspi-if-regs.h              | 105 +++
 drivers/spi/Kconfig                                |   4 +-
 drivers/spi/Makefile                               |   2 +-
 drivers/spi/atmel-quadspi.c                        |  26 +-
 drivers/spi/spi-amd-pci.c                          |  70 ++
 drivers/spi/spi-amd.c                              | 227 ++++---
 drivers/spi/spi-amd.h                              |  44 ++
 drivers/spi/spi-axi-spi-engine.c                   |  91 ++-
 drivers/spi/spi-cadence-quadspi.c                  |   2 +-
 drivers/spi/spi-cavium-thunderx.c                  |   4 +-
 drivers/spi/spi-cs42l43.c                          |   4 +-
 drivers/spi/spi-dw-core.c                          |   2 +-
 drivers/spi/spi-fsl-qspi.c                         |  81 +--
 drivers/spi/spi-gpio.c                             |   2 +-
 drivers/spi/spi-intel-pci.c                        |   8 +-
 drivers/spi/spi-intel-platform.c                   |   9 +-
 drivers/spi/spi-intel.c                            |   9 +-
 drivers/spi/spi-intel.h                            |   4 +-
 drivers/spi/spi-loopback-test.c                    |   8 +-
 drivers/spi/spi-meson-spicc.c                      | 241 ++++++-
 drivers/spi/spi-nxp-fspi.c                         | 189 +++---
 drivers/spi/spi-offload.c                          |   5 +-
 drivers/spi/spi-pci1xxxx.c                         |  24 +-
 drivers/spi/spi-qpic-snand.c                       | 166 ++---
 drivers/spi/spi-rpc-if.c                           |  16 +-
 drivers/spi/spi-sh-msiof.c                         | 397 +++++-------
 drivers/spi/spi-stm32-ospi.c                       |   2 +-
 drivers/spi/spi-tegra210-quad.c                    | 280 ++++----
 drivers/spi/spi-xcomm.c                            |   8 +-
 drivers/spi/spi.c                                  |  19 +-
 include/linux/pm_runtime.h                         |   4 +
 include/linux/spi/sh_msiof.h                       | 125 ++++
 include/linux/spi/spi.h                            |  73 ++-
 include/memory/renesas-rpc-if.h                    |   4 +
 47 files changed, 2390 insertions(+), 968 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rzg3e-xspi.yaml
 create mode 100644 drivers/memory/renesas-rpc-if-regs.h
 create mode 100644 drivers/memory/renesas-xspi-if-regs.h
 create mode 100644 drivers/spi/spi-amd-pci.c
 create mode 100644 drivers/spi/spi-amd.h

