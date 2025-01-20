Return-Path: <linux-spi+bounces-6413-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC76A16EFB
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jan 2025 16:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78EF1882902
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jan 2025 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E871E47C2;
	Mon, 20 Jan 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiJsoOSf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1431E0DCD;
	Mon, 20 Jan 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385514; cv=none; b=mVBM8GTD9aRvbLx4LRXQQtkO6OzDfO6AKv/0mjJLFjIETRB3kko5Usn+TQVreHIxMweQfJIXcahFvffybQRISqjzq6MhW1A44HOsgEbkNhwcZSMvNBGQS5C/QPO1VVyclWwP60dmS45mnpgjigs/GcHp5PqgBuQnk49FkzVPTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385514; c=relaxed/simple;
	bh=IZrfizjMEfCQdp3FTleo5fupr69beOZm1SyhP/gS+r4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Qd6XCYUkw/N1Is8H7sC7tdqOT8Gu+5KMqGq+Bv0nUWTOITh1l/rQxX7CD2nzm96jCBnA7kNq/HjvJlfG4ml0KBapoxx8HH0hH7m+GUXHh7gyXvT3QpDu55DX35wrLpg7Chbg0LaLtX8r1pPvplHY3Te4H9NLv1UsROT2urRG+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiJsoOSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF25C4CEDD;
	Mon, 20 Jan 2025 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737385514;
	bh=IZrfizjMEfCQdp3FTleo5fupr69beOZm1SyhP/gS+r4=;
	h=From:To:Cc:Subject:Date:From;
	b=tiJsoOSfg1XgDGZSaskDM0w4C2j5jxilJr7r7Mg+xGPQ+81yE7RGAY+tIhiX9pjez
	 7vKo/OqgEL6g9rcF7Z/rmbWN2Zm47niChrVvdb+v6m459bUYgtCcUnql7nIfAteP8Z
	 iBur+jrTFzON6fR+SFh8j6MtO/CV5YlVNOkLfgOF16/y8g13QglpQIF9THn5GC4oBQ
	 pMbb9Oidp8Sxvy0Iy8iNbRrf74ivJbYiT4aoU5BGhWmuR4CrOK3Tpu+fwIiJs4JJqH
	 xG7AGM+ifEyR3vAkLV5L6weIBzLrR+jvDVqaR0DoOLCxvHYp33qFQqR58vp1XY8eJc
	 Phlv/131xnZpw==
Message-ID: <4c1f6ab0a30b9258969f7e1d4fbb46f7.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.14
Date: Mon, 20 Jan 2025 15:05:02 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.14

for you to fetch changes up to 78b435c9044a9ec321da29d299c70cb14b059682:

  spi: pxa2xx: Introduce __lpss_ssp_update_priv() helper (2025-01-16 17:04:31 +0000)

----------------------------------------------------------------
spi: Updates for v6.14

This is a fairly quiet release for the most part, though we do have one
really nice improvement in the spi-mem framework which will improve
performance for flash devices especially when built on by changes in the
MTD subsystem which are also due to be sent this merge window.  There's
also been some substantial work on some of the drivers, highlights
include:

 - Support for per-operation bus frequency in the spi-mem framework,
   meaning speeds are no longer limited by the slowest operation.
 - ACPI support and improved power management for Rockchip SFC
   controllers.
 - Support for Atmel SAM7G5 QuadSPI and KEBA SPI controllers.

----------------------------------------------------------------
Alexander Dahl (1):
      spi: atmel-quadspi: Update to current device naming terminology

Andy Shevchenko (4):
      spi: sc18is602: Switch to generic firmware properties and drop of_match_ptr()
      spi: Unify firmware node type checks
      spi: Deduplicate deferred probe checks in spi_probe()
      spi: pxa2xx: Introduce __lpss_ssp_update_priv() helper

Bence Csókás (3):
      spi: atmel-quadspi: Factor out switching to Serial Memory Mode to function
      spi: atmel-qspi: Memory barriers after memory-mapped I/O
      spi: atmel-quadspi: Use devm_ clock management

Christophe Leroy (1):
      spi: fsl-spi: Remove display of virtual address

Csókás, Bence (1):
      spi: atmel-quadspi: Create `atmel_qspi_ops` to support newer SoC families

Fabio Estevam (2):
      dt-bindings: misc: lwn,bk4-spi: Add binding
      spi: spidev: Add an entry for lwn,bk4-spi

Gerhard Engleder (1):
      spi: spi-kspi2: Add KEBA SPI controller support

Iker Pedrosa (1):
      spi: dt-bindings: Document CS active-high

Jon Lin (5):
      spi: rockchip-sfc: Support ACPI
      spi: rockchip-sfc: Optimize the judgment mechanism completed by the controller
      spi: rockchip-sfc: Support pm ops
      spi: rockchip-sfc: Using normal memory for dma
      spi: rockchip-sfc: Support sclk_x2 version

Krzysztof Kozlowski (1):
      spi: ti-qspi: Use syscon_regmap_lookup_by_phandle_args

Mark Brown (9):
      spi: cadence-quadspi: Add support for device reset
      spi: Merge up v6.12-rc2
      spi: Merge up fixes
      spi: Unify and simplify fwnode related checks
      spi: atmel-quadspi: Refactor to allow supporting
      spi: Merge up v6.13-rc6
      spi-nand/spi-mem DTR support
      spi: Add spi_mem_calc_op_duration() helper
      spi-nand/spi-mem DTR support

Mingwei Zheng (1):
      spi: zynq-qspi: Add check for clk_enable()

Miquel Raynal (20):
      spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
      spi: spi-mem: Add a new controller capability
      spi: amd: Support per spi-mem operation frequency switches
      spi: amd: Drop redundant check
      spi: amlogic-spifc-a1: Support per spi-mem operation frequency switches
      spi: cadence-qspi: Support per spi-mem operation frequency switches
      spi: dw: Support per spi-mem operation frequency switches
      spi: fsl-qspi: Support per spi-mem operation frequency switches
      spi: microchip-core-qspi: Support per spi-mem operation frequency switches
      spi: mt65xx: Support per spi-mem operation frequency switches
      spi: mxic: Support per spi-mem operation frequency switches
      spi: nxp-fspi: Support per spi-mem operation frequency switches
      spi: rockchip-sfc: Support per spi-mem operation frequency switches
      spi: spi-sn-f-ospi: Support per spi-mem operation frequency switches
      spi: spi-ti-qspi: Support per spi-mem operation frequency switches
      spi: zynq-qspi: Support per spi-mem operation frequency switches
      spi: zynqmp-gqspi: Support per spi-mem operation frequency switches
      spi: spi-mem: Reorder spi-mem macro assignments
      spi: spi-mem: Create macros for DTR operation
      spi: spi-mem: Estimate the time taken by operations

Nathan Chancellor (1):
      spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()

Santhosh Kumar K (1):
      spi: cadence-quadspi: Enable SPI_TX_QUAD

Srikanth Boyapally (3):
      spi: cadence-quadspi: Use quirks to set dma_set_mask instead of compatible string for 64-bit DMA support
      spi: cadence-quadspi: Support for device reset via OSPI controller
      spi: dt-bindings: cdns,qspi-nor: Add compatible string to support OSPI controller on Versal Gen2 platform

Stefan Wahren (1):
      spi: mxs: support effective_speed_hz

Tudor Ambarus (1):
      spi: atmel-quadspi: Add support for sama7g5 QSPI

Uwe Kleine-König (1):
      spi: spidev: Align ordering of spidev_spi_ids[] and spidev_dt_ids[]

 .../devicetree/bindings/misc/lwn,bk4-spi.yaml      |  54 ++
 Documentation/devicetree/bindings/misc/lwn-bk4.txt |  26 -
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |   1 +
 .../devicetree/bindings/spi/spi-controller.yaml    |  25 +
 drivers/mtd/nand/spi/core.c                        |   2 +
 drivers/spi/Kconfig                                |  12 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/atmel-quadspi.c                        | 987 +++++++++++++++++++--
 drivers/spi/spi-amd.c                              |  26 +-
 drivers/spi/spi-amlogic-spifc-a1.c                 |   7 +-
 drivers/spi/spi-cadence-quadspi.c                  |  57 +-
 drivers/spi/spi-dw-core.c                          |  10 +-
 drivers/spi/spi-fsl-qspi.c                         |  12 +-
 drivers/spi/spi-fsl-spi.c                          |   2 +-
 drivers/spi/spi-kspi2.c                            | 431 +++++++++
 drivers/spi/spi-mem.c                              |  64 ++
 drivers/spi/spi-microchip-core-qspi.c              |  26 +-
 drivers/spi/spi-mt65xx.c                           |   7 +-
 drivers/spi/spi-mxic.c                             |   3 +-
 drivers/spi/spi-mxs.c                              |   2 +
 drivers/spi/spi-nxp-fspi.c                         |  12 +-
 drivers/spi/spi-pxa2xx.c                           |  88 +-
 drivers/spi/spi-rockchip-sfc.c                     | 233 ++++-
 drivers/spi/spi-sc18is602.c                        |  34 +-
 drivers/spi/spi-sn-f-ospi.c                        |   8 +-
 drivers/spi/spi-ti-qspi.c                          |  19 +-
 drivers/spi/spi-zynq-qspi.c                        |  26 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  13 +-
 drivers/spi/spi.c                                  |  41 +-
 drivers/spi/spidev.c                               |  30 +-
 include/linux/spi/spi-mem.h                        |  56 +-
 31 files changed, 1998 insertions(+), 317 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
 create mode 100644 drivers/spi/spi-kspi2.c

