Return-Path: <linux-spi+bounces-11696-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0EC98FCD
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 21:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83CB3A4500
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603723EAB7;
	Mon,  1 Dec 2025 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgiIi9xa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2551A937;
	Mon,  1 Dec 2025 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764620270; cv=none; b=B50ephAPZ+eEOZ5tdzmhw5bhT0ZokbDjCF4NqG7IgrBDKpEPsZhZYCtSAi6eWUiFlTs75Z4pNti8y8tswCokboCtC8ZfmN8xd3WGCQ/r53oZ/VaL1+9XLlAA9mODkF8FPdtiC0n7e0W485I7ARnsJdr8/3FSFHcAjCHmznKdAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764620270; c=relaxed/simple;
	bh=duGRah4bKaGeEI9oxXWIU+QwOOdpG2+AFL0aw7dP2Q8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=ZRUiHyGapacdR8OPjlGfXWJDtKYZiBhbDzcaxgEBMlsSjqUoUFCl/XaZPUART46mGOKLEXqEUrDWRlmaceAyMFIzGisrgJVB/ikWYbjm+KSW1lUaah/WiHoiiuXfmT23fs64s2cOaQrAUIm+6uENkgSLc/hEfH53ZR5Xx2JFmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgiIi9xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A9AC4CEF1;
	Mon,  1 Dec 2025 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764620267;
	bh=duGRah4bKaGeEI9oxXWIU+QwOOdpG2+AFL0aw7dP2Q8=;
	h=From:To:Cc:Subject:Date:From;
	b=TgiIi9xaWxibjsHi/m5GiNzQy2M5/WTy/B3O0W7u1+PJ1MDFY7VF2iY296eq6v4tO
	 wiIFOfYqVirjK3ETgRtxxKzVlLgsB2rpemyjk0XITGuNRhvmlF6LVkuB7k2Ujbb00p
	 yXSEFvlnsgocIXlG09X80w6GKiN2wHg66xeK3eQM7UN5QMiaL/prkwNjjN5ch4GtIN
	 iNqGBFHfW7h4SZjl6rDkXLuSFjr7/kF0ys664dG2/BZOFnFNVXY28piYRI0p7Pk1s4
	 sLPHx2UKrg8qEWWxJqOoHwGCvyOA+PsOreEGxjFyWZ4Sjd+hxFdTiiNUPwu3IEItR+
	 7LzDsDjdjxwuw==
Message-ID: <70ee20cc564827dd1636960e670a48af@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.19
Date: Mon, 01 Dec 2025 20:17:32 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d:

  Linux 6.18-rc7 (2025-11-23 14:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.19

for you to fetch changes up to cb5c2eb459f4c98d584eaf3d3ea7c3612385d081:

  spi: microchip-core: Refactor FIFO read and write handlers (2025-11-28 18:03:43 +0000)

----------------------------------------------------------------
spi: Updates for v6.19

This release is almost entirely new drivers, with a couple of small
changes in generic code.  The biggest individual update is a rename of
the existing Microchip driver and the addition of a new driver for the
silicon SPI controller in their PolarFire SoCs.  The overlap between the
soft IP supported by the current driver and this new one is regrettably
all in the IP and not in the register interface offered to software.

 - Add a time offset parameter for offloads, allowing them to be defined
   in relation to each other.  This is useful for IIO type applcations
   where you trigger an operation then read the result after a delay.
 - Add a tracepoint for flash exec_ops, bringing the flash support more
   in line with the debuggability of vanilla SPI.
 - Support for Airoha EN7523, Arduino MCUs, Aspeed AST2700, Microchip
   PolarFire SPI controllers, NXP i.MX51 ECSPI target mode, Qualcomm
   IPQ5414 and IPQ5332, Renesas RZ/T2H, RZ/V2N and RZ/2NH and SpacemiT K1
   QuadSPI.

There's also a small set of ASoC cleanups that I mistakenly applied to
the SPI tree and then put more stuff on top of before it was brought to
my attention, sorry about that.

----------------------------------------------------------------
Alex Elder (7):
      spi: dt-bindings: fsl-qspi: support SpacemiT K1
      spi: dt-bindings: fsl-qspi: add optional resets
      spi: fsl-qspi: add optional reset support
      spi: fsl-qspi: switch predicates to bool
      spi: fsl-qspi: add a clock disable quirk
      spi: fsl-qspi: introduce sfa_size devtype data
      spi: fsl-qspi: support the SpacemiT K1 SoC

Andy Shevchenko (6):
      spi: microchip-core: use min() instead of min_t()
      spi: microchip-core: Replace dead code (-ENOMEM error message)
      spi: microchip-core: Utilise temporary variable for struct device
      spi: microchip-core: Use SPI_MODE_X_MASK
      spi: microchip-core: Remove unneeded PM related macro
      spi: microchip-core: Refactor FIFO read and write handlers

Axel Haslam (1):
      spi: offload: Add offset parameter

Bartosz Golaszewski (1):
      spi: davinci: remove platform data header

Benoît Monin (2):
      spi: dw: rename the spi controller to ctlr
      spi: dw: add target mode support

Can Peng (1):
      spi: spi-qpic-snand: make qcom_spi_ecc_engine_ops_pipelined const

Carlos Song (2):
      spi: imx: add i.MX51 ECSPI target mode support
      spi: imx: add 16/32 bits per word support for target PIO mode

Chin-Ting Kuo (11):
      spi: aspeed: Update clock selection strategy
      spi: aspeed: Improve timing calibration algorithm for AST2600 platform
      spi: aspeed: Force default address decoding range assignment for each CS
      spi: aspeed: Centralize address decoding region management
      spi: aspeed: Add per-platform adjust_window callback for decoding range
      spi: aspeed: Only map necessary address window region
      spi: aspeed: Use devm_iounmap() to unmap devm_ioremap() memory
      spi: aspeed: Enable Quad SPI mode for page program
      spi: dt-bindings: aspeed,ast2600-fmc: Add AST2700 SoC support
      spi: aspeed: Use phys_addr_t for bus addresses to support 64-bit platforms
      spi: aspeed: Add support for the AST2700 SPI controller

Clark Wang (1):
      spi: imx: remove CLK calculation and check for target mode

Colin Ian King (1):
      spi: aspeed: fix spelling mistake "triming" -> "trimming"

Cosmin Tanislav (11):
      spi: rzv2h-rspi: make resets optional
      spi: rzv2h-rspi: make FIFO size chip-specific
      spi: rzv2h-rspi: make clocks chip-specific
      spi: rzv2h-rspi: move register writes out of rzv2h_rspi_setup_clock()
      spi: rzv2h-rspi: avoid recomputing transfer frequency
      spi: rzv2h-rspi: make transfer clock rate finding chip-specific
      spi: rzv2h-rspi: add support for using PCLK for transfer clock
      spi: rzv2h-rspi: add support for variable transfer clock
      spi: rzv2h-rspi: add support for loopback mode
      spi: dt-bindings: renesas,rzv2h-rspi: document RZ/T2H and RZ/N2H
      spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H

Dan Carpenter (2):
      spi: aspeed: Fix an IS_ERR() vs NULL bug in probe()
      spi: Fix potential uninitialized variable in probe()

Geert Uytterhoeven (1):
      spi: microchip: Enable compile-testing for FPGA SPI controllers

Johan Hovold (4):
      ASoC: stm32: sai: fix device leak on probe
      ASoC: stm32: sai: fix clk prepare imbalance on probe failure
      ASoC: stm32: sai: fix OF node leak on probe
      ASoC: stm32: sai: clean up probe error path

Jonas Gorski (1):
      spi: bcm63xx: drop wrong casts in probe()

Jun Guo (2):
      dt-bindings: spi: spi-cadence: update DT binding docs to support cix sky1 SoC
      spi: spi-cadence: supports transmission with bits_per_word of 16 and 32

Lad Prabhakar (2):
      spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
      spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support

Longbin Li (1):
      spi: sophgo: Fix incorrect use of bus width value macros

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in RISC-V MICROCHIP SUPPORT

Mark Brown (14):
      Merge existing fixes from spi/for-6.18 into new branch
      spi: offload: Add offset parameter
      spi: aspeed: Improve clock, timing and address
      Add target mode support for the DesignWare SPI
      spi: airoha: driver fixes & improvements
      spi: tegra210-quad: Improve timeout handling under
      spi: enable the SpacemiT K1 SoC QSPI
      spi-cadence: support transmission with
      Add support for Microchip CoreSPI Controller
      spi: aspeed: Add AST2700 SoC support and Quad SPI
      Add RSPI support for RZ/T2H and RZ/N2H
      ASoC: stm32: sai: fix device and OF node leaks on
      spi: airoha: add support of en7523 SoC (for 6.19)
      spi: microchip-core: Code improvements

Md Sadre Alam (2):
      spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
      spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible

Mikhail Kshevetskiy (11):
      spi: airoha: remove unnecessary restriction length
      spi: airoha: remove unnecessary switch to non-dma mode
      spi: airoha: unify dirmap read/write code
      spi: airoha: support of dualio/quadio flash reading commands
      spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
      spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
      spi: airoha: set custom sector size equal to flash page size
      spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
      spi: airoha: buffer must be 0xff-ed before writing
      spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
      spi: dt-bindings: airoha: add compatible for EN7523

Prajna Rajendra Kumar (3):
      spi: microchip: rename driver file and internal identifiers
      spi: dt-binding: document Microchip CoreSPI
      spi: add support for microchip "soft" spi controller

Riccardo Mereu (2):
      dt-bindings: trivial-devices: add arduino spi mcu interface
      spi: spidev: add compatible for arduino spi mcu interface

Sean Anderson (1):
      spi: spi-mem: Trace exec_op

Tianchu Chen (1):
      spi: ch341: fix out-of-bounds memory access in ch341_transfer_one

Tomer Maimon (1):
      spi: dt-bindings: nuvoton,npcm-pspi: Convert to DT schema

Vishwaroop A (3):
      spi: tegra210-quad: Fix timeout handling
      spi: tegra210-quad: Refactor error handling into helper functions
      spi: tegra210-quad: Check hardware status on timeout

Wolfram Sang (1):
      spi: dt-bindings: don't check node names

Zhongqiu Han (1):
      spi: tle62x0: Add newline to sysfs attribute output

 .../bindings/spi/airoha,en7581-snand.yaml          |   7 +-
 .../bindings/spi/aspeed,ast2600-fmc.yaml           |   4 +-
 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml  |  21 +-
 .../bindings/spi/microchip,mpfs-spi.yaml           |  70 +-
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt  |  36 -
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.yaml |  72 ++
 .../bindings/spi/qcom,spi-qpic-snand.yaml          |   2 +
 .../bindings/spi/renesas,rzv2h-rspi.yaml           |  65 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   2 +-
 .../devicetree/bindings/spi/spi-cadence.yaml       |   1 +
 .../devicetree/bindings/spi/spi-controller.yaml    |   2 +-
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 MAINTAINERS                                        |   3 +-
 drivers/spi/Kconfig                                |  31 +-
 drivers/spi/Makefile                               |   3 +-
 drivers/spi/spi-airoha-snfi.c                      | 410 ++++++-----
 drivers/spi/spi-aspeed-smc.c                       | 747 ++++++++++++++++-----
 drivers/spi/spi-bcm63xx.c                          |   4 +-
 drivers/spi/spi-cadence.c                          | 106 ++-
 drivers/spi/spi-ch341.c                            |   2 +-
 drivers/spi/spi-davinci.c                          |  64 +-
 drivers/spi/spi-dw-bt1.c                           |   4 +-
 drivers/spi/spi-dw-core.c                          | 188 +++---
 drivers/spi/spi-dw-dma.c                           |  22 +-
 drivers/spi/spi-dw-mmio.c                          |   9 +-
 drivers/spi/spi-dw-pci.c                           |   8 +-
 drivers/spi/spi-dw.h                               |  12 +-
 drivers/spi/spi-fsl-qspi.c                         |  88 ++-
 drivers/spi/spi-imx.c                              |  58 +-
 drivers/spi/spi-mem.c                              |   5 +
 drivers/spi/spi-microchip-core-spi.c               | 429 ++++++++++++
 drivers/spi/{spi-microchip-core.c => spi-mpfs.c}   | 207 +++---
 drivers/spi/spi-offload-trigger-pwm.c              |   3 +
 drivers/spi/spi-qpic-snand.c                       |   2 +-
 drivers/spi/spi-rzv2h-rspi.c                       | 303 +++++++--
 drivers/spi/spi-sg2044-nor.c                       |   4 +-
 drivers/spi/spi-tegra210-quad.c                    | 174 +++--
 drivers/spi/spi-tle62x0.c                          |   2 +-
 drivers/spi/spidev.c                               |   2 +
 include/linux/platform_data/spi-davinci.h          |  73 --
 include/linux/spi/offload/types.h                  |   9 +
 include/trace/events/spi-mem.h                     | 106 +++
 sound/soc/stm/stm32_sai.c                          |  14 +-
 sound/soc/stm/stm32_sai_sub.c                      |  57 +-
 44 files changed, 2519 insertions(+), 914 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.yaml
 create mode 100644 drivers/spi/spi-microchip-core-spi.c
 rename drivers/spi/{spi-microchip-core.c => spi-mpfs.c} (68%)
 delete mode 100644 include/linux/platform_data/spi-davinci.h
 create mode 100644 include/trace/events/spi-mem.h

