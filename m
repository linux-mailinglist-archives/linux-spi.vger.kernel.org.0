Return-Path: <linux-spi+bounces-2831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5628C3E42
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77FBB21D5F
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB271487E5;
	Mon, 13 May 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS5ag6Py"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725551474B1;
	Mon, 13 May 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593174; cv=none; b=haOEa5l2yRR/b3RqpjCgv0odcSVlemwOJWcmDRK/CfiDWMeAMxd2uY/MwF/4TnU/9+tlBodYBQYMQFk1+zPNNeftNpbhJUGqtqkkRXl+T765RkkqTXgmAlMNjqYMdtgs0lUBnxAZ5Sw6TTuFTrNYIA6G2FHS/Tvb33/kLDSgQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593174; c=relaxed/simple;
	bh=yVN/UqsJMWWHeYKneTtrXuNjgMvI6poAggN0wIU2Z7Q=;
	h=Message-ID:From:To:Cc:Subject:Date; b=lwk7pfI0DqigESf46FyIxLpM2EZkzxUOJOOF/ebRUiMFxWaOXR07wkxdwYHekZeZ7JaYXICIlttcblklEYVz/amt/F1nkPjIkCpaPjyyWHqtfwzJIFeVOrSH5swzT0tXfr3s+bxDqTufqQC/uul20qeqifc6u/GBYQHBJp+bc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS5ag6Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7748AC113CC;
	Mon, 13 May 2024 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715593174;
	bh=yVN/UqsJMWWHeYKneTtrXuNjgMvI6poAggN0wIU2Z7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ZS5ag6PyBNAWcJc1QzhZF9gqYVoqhlnXWF6FkgIPzfKb6j1972vjE7N9XsgidijHN
	 FltUrO3P8seDsSLQWLbjGnlesDzh2fC1MAn+afJISdB1f7V9ugstuNxfx6u8UXpBr1
	 TAGiXL4lR5sbS6XSYn9frxLzDrGRCCHgGV2JgwfcAIbM/yiQ1KH7cWBYIddve8ECwu
	 vGRp2S2RC66SWgykNUFh3YIqFDf8S7gAaClNL+XbR9YfbJHTQpNbCr7Kvy7vynig08
	 cVmhuPbpQa1Hj00Re6m62LJafxh2/1mPhjrJO9SNDljYmy6/G5qBGVw2rgPoEbSCkJ
	 XsQwErnBpFP5Q==
Message-ID: <9e996db977142fec01e9cbbbfb79c07d.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.10
Date: Mon, 13 May 2024 10:39:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.10

for you to fetch changes up to d6e7ffd4820f8894eb865890c96852085d3640e1:

  spi: dw: Bail out early on unsupported target mode (2024-05-09 17:48:06 +0200)

----------------------------------------------------------------
spi: Updates for v6.10

The diffstat for this release is dominated by the new Airoha driver,
mainly as a result of this being a generally quite quiet release.  There
were a couple of cleanups in the core but nothing substantial, the
updates here are almost all driver specific ones.

 - Support for multi-word mode in the OMAP2 McSPI driver.
 - Overhaul of the PXA2xx driver, mostly API updates.
 - A number of DT binding conversions.
 - Support for Airoha NAND controllers, Cirrus Logic CS35L56, Mobileye
   EYEQ5 and Renesas R8A779H0.

----------------------------------------------------------------
Andy Shevchenko (32):
      spi: xilinx: Fix kernel documentation in the xilinx_spi.h
      spi: xilinx: Add necessary inclusion and forward declaration
      spi: xilinx: Make num_chipselect 8-bit in the struct xspi_platform_data
      spi: pxa2xx: Kill pxa2xx_set_spi_info()
      spi: pxa2xx: Make num_chipselect 8-bit in the struct pxa2xx_spi_controller
      spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c
      spi: rspi: Get rid of unused struct rspi_plat_data
      spi: pxa2xx: Keep PXA*_SSP types together
      spi: pxa2xx: Switch to use dev_err_probe()
      spi: pxa2xx: Narrow the Kconfig option visibility
      spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
      spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
      spi: pxa2xx: Skip SSP initialization if it's done elsewhere
      spi: pxa2xx: Call pxa_ssp_free() after getting the SSP type
      spi: pxa2xx: Move number of CS pins validation out of condition
      spi: Extract spi_toggle_csgpiod() helper for better maintanance
      spi: Introduce spi_for_each_valid_cs() in order of deduplication
      spi: Consistently use BIT for cs_index_mask (part 2)
      spi: oc-tiny: Remove unused of_gpio.h
      spi: bitbang: Use NSEC_PER_*SEC rather than hard coding
      spi: bitbang: Add missing MODULE_DESCRIPTION()
      spi: pxa2xx: Allow number of chip select pins to be read from property
      spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
      spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
      spi: pxa2xx: Remove outdated documentation
      spi: pxa2xx: Don't use "proxy" headers
      spi: pxa2xx: Drop struct pxa2xx_spi_chip
      spi: pxa2xx: Remove DMA parameters from struct chip_data
      spi: pxa2xx: Remove timeout field from struct chip_data
      spi: pxa2xx: Don't provide struct chip_data for others
      spi: pxa2xx: Drop the stale entry in documentation TOC
      spi: Remove unneded check for orig_nents

Charles Keepax (4):
      gpio: swnode: Add ability to specify native chip selects for SPI
      spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
      spi: Update swnode based SPI devices to use the fwnode name
      spi: cs42l43: Use devm_add_action_or_reset()

David Lechner (4):
      spi: remove struct spi_message::is_dma_mapped
      spi: au1550: t->{tx,rx}_dma checks
      spi: fsl: remove is_dma_mapped checks
      spi: use spi_valid_{tx,rx}buf() in stats function

Fei Shao (1):
      spi: spi-mt65xx: Rename a variable in interrupt handler

Geert Uytterhoeven (2):
      spi: renesas,sh-msiof: Add r8a779h0 support
      spi: dw: Bail out early on unsupported target mode

Heikki Keranen (1):
      spi: mux: Fix master controller settings after mux select

Justin Swartz (1):
      spi: mt7621: allow GPIO chip select lines

Kousik Sanagavarapu (3):
      spi: cadence-xspi: use for_each_available_child_of_node_scoped()
      spi: dt-bindings: armada-3700: convert to dtschema
      spi: dt-bindings: ti,qspi: convert to dtschema

Krzysztof Kozlowski (5):
      spi: loopback-test: drop driver owner assignment
      spi: coldfire-qspi: drop driver owner assignment
      spi: fsl-dspi: drop driver owner assignment
      spi: docs: drop driver owner initialization
      spi: altera: Drop unneeded MODULE_ALIAS

Lorenzo Bianconi (2):
      spi: airoha: add SPI-NAND Flash controller driver
      spi: dt-bindings: airoha: Add YAML schema for SNFI controller

Louis Chauvet (3):
      spi: spi-omap2-mcspi.c: revert "Toggle CS after each word"
      spi: omap2-mcspi: Add support for MULTI-mode
      spi: omap2-mcpsi: Enable MULTI-mode in more situations

Lukas Bulwahn (2):
      MAINTAINERS: adjust file entry in TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
      MAINTAINERS: repair file entry in AIROHA SPI SNFI DRIVER

Maciej Strozek (2):
      spi: cs42l43: Add bridged cs35l56 amplifiers
      spi: cs42l43: Correct name of ACPI property

Mark Brown (11):
      spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h
      spi: xilinx: Massage xilinx_spi.h
      Add multi mode support for omap-mcspi
      spi: more tx_buf/rx_buf removal
      spi: cadence-qspi: Prepare to add Mobileye EyeQ5 support
      spi: More refacroings after multi-CS support
      Add bridged amplifiers to cs42l43
      Add add SPI-NAND Flash controller driver for EN7581
      spi: use 'time_left' instead of 'timeout' with
      spi: dw: Auto-detect number of native CS
      spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h

Raju Rangoju (1):
      spi: spi_amd: Add support for SPI MEM framework

Randy Dunlap (1):
      spi: spi.h: add missing kernel-doc for @last_cs_index_mask

Serge Semin (4):
      spi: dw: Convert to using BITS_TO_BYTES() macro
      spi: dw: Add a number of native CS auto-detection
      spi: dw: Convert dw_spi::num_cs to u32
      spi: dw: Drop default number of CS setting

Shivani Gupta (1):
      spi: spi-s3c64xx.c: Remove of_node_put for auto cleanup

Théo Lebrun (10):
      spi: cadence-qspi: allow building for MIPS
      spi: cadence-qspi: store device data pointer in private struct
      spi: cadence-qspi: minimise register accesses on each op if !DTR
      spi: dt-bindings: cdns,qspi-nor: sort compatibles alphabetically
      spi: dt-bindings: cdns,qspi-nor: add mobileye,eyeq5-ospi compatible
      spi: dt-bindings: cdns,qspi-nor: make cdns,fifo-depth optional
      spi: cadence-qspi: allow FIFO depth detection
      spi: cadence-qspi: add no-IRQ mode to indirect reads
      spi: cadence-qspi: add early busywait to cqspi_wait_for_bit()
      spi: cadence-qspi: add mobileye,eyeq5-ospi compatible

Wolfram Sang (8):
      spi: armada-3700: use 'time_left' variable with wait_for_completion_timeout()
      spi: fsl-lpspi: use 'time_left' variable with wait_for_completion_timeout()
      spi: imx: use 'time_left' variable with wait_for_completion_timeout()
      spi: pic32-sqi: use 'time_left' variable with wait_for_completion_timeout()
      spi: pic32: use 'time_left' variable with wait_for_completion_timeout()
      spi: sun4i: use 'time_left' variable with wait_for_completion_timeout()
      spi: sun6i: use 'time_left' variable with wait_for_completion_timeout()
      spi: xlp: use 'time_left' variable with wait_for_completion_timeout()

 .../bindings/spi/airoha,en7581-snand.yaml          |   65 ++
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |    8 +-
 .../bindings/spi/marvell,armada-3700-spi.yaml      |   55 +
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |    1 +
 .../devicetree/bindings/spi/spi-armada-3700.txt    |   25 -
 Documentation/devicetree/bindings/spi/ti,qspi.yaml |   96 ++
 Documentation/devicetree/bindings/spi/ti_qspi.txt  |   53 -
 Documentation/spi/index.rst                        |    1 -
 Documentation/spi/pxa2xx.rst                       |  211 ----
 Documentation/spi/spi-summary.rst                  |    5 -
 MAINTAINERS                                        |   11 +-
 arch/arm/mach-pxa/devices.c                        |   18 -
 arch/arm/mach-pxa/spitz.c                          |   35 +-
 drivers/gpio/Kconfig                               |    9 +
 drivers/gpio/gpiolib-swnode.c                      |   44 +
 drivers/soc/pxa/ssp.c                              |    2 +-
 drivers/spi/Kconfig                                |   22 +-
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-airoha-snfi.c                      | 1129 ++++++++++++++++++++
 drivers/spi/spi-altera-platform.c                  |    1 -
 drivers/spi/spi-amd.c                              |  112 ++
 drivers/spi/spi-armada-3700.c                      |    8 +-
 drivers/spi/spi-atmel.c                            |    8 +-
 drivers/spi/spi-au1550.c                           |   29 +-
 drivers/spi/spi-bitbang.c                          |   23 +-
 drivers/spi/spi-cadence-quadspi.c                  |  109 +-
 drivers/spi/spi-cadence-xspi.c                     |    8 +-
 drivers/spi/spi-coldfire-qspi.c                    |    1 -
 drivers/spi/spi-cs42l43.c                          |  127 ++-
 drivers/spi/spi-dw-core.c                          |   20 +-
 drivers/spi/spi-dw-mmio.c                          |   13 +-
 drivers/spi/spi-dw.h                               |    2 +-
 drivers/spi/spi-fsl-cpm.c                          |   14 +-
 drivers/spi/spi-fsl-cpm.h                          |    5 +-
 drivers/spi/spi-fsl-dspi.c                         |    1 -
 drivers/spi/spi-fsl-lpspi.c                        |   14 +-
 drivers/spi/spi-fsl-spi.c                          |    7 +-
 drivers/spi/spi-imx.c                              |   20 +-
 drivers/spi/spi-loopback-test.c                    |    1 -
 drivers/spi/spi-mt65xx.c                           |   32 +-
 drivers/spi/spi-mt7621.c                           |   95 +-
 drivers/spi/spi-mux.c                              |    2 +
 drivers/spi/spi-oc-tiny.c                          |    2 -
 drivers/spi/spi-omap2-mcspi.c                      |   95 +-
 drivers/spi/spi-pic32-sqi.c                        |    6 +-
 drivers/spi/spi-pic32.c                            |    6 +-
 drivers/spi/spi-pxa2xx-dma.c                       |   38 +-
 drivers/spi/spi-pxa2xx-pci.c                       |   10 +-
 drivers/spi/spi-pxa2xx.c                           |  223 ++--
 drivers/spi/spi-pxa2xx.h                           |   42 +-
 drivers/spi/spi-rspi.c                             |   12 +-
 drivers/spi/spi-s3c64xx.c                          |    6 +-
 drivers/spi/spi-sun4i.c                            |    9 +-
 drivers/spi/spi-sun6i.c                            |   17 +-
 drivers/spi/spi-xlp.c                              |    8 +-
 drivers/spi/spi.c                                  |  126 +--
 include/linux/gpio/property.h                      |    4 +
 include/linux/platform_data/spi-omap2-mcspi.h      |    3 -
 include/linux/pxa2xx_ssp.h                         |    2 +-
 include/linux/spi/pxa2xx_spi.h                     |   56 -
 include/linux/spi/rspi.h                           |   18 -
 include/linux/spi/spi.h                            |   12 +-
 include/linux/spi/xilinx_spi.h                     |   14 +-
 63 files changed, 2224 insertions(+), 928 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt
 create mode 100644 Documentation/devicetree/bindings/spi/ti,qspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt
 delete mode 100644 Documentation/spi/pxa2xx.rst
 create mode 100644 drivers/spi/spi-airoha-snfi.c
 delete mode 100644 include/linux/spi/pxa2xx_spi.h
 delete mode 100644 include/linux/spi/rspi.h

