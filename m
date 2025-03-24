Return-Path: <linux-spi+bounces-7291-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F8A6DD15
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 15:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B44164898
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B2925E83E;
	Mon, 24 Mar 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZpb03jp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307D25E460;
	Mon, 24 Mar 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826821; cv=none; b=jeR5rKLUsP4fSrqe+r71srrbDX/67XZdzWMuLf2gC8RcWIicMkUjo/qBMvfVjKeMf294AgORiH9eUXJcD1t+K2zuzd+KSvwItoKXSmUJcQGsvc+iaCIWNQFX+KlMeTctzYkkuFMPIUrkE0PSwpZYqUAeygrZoqH9Ojlo7UN6AFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826821; c=relaxed/simple;
	bh=2gOYVTAicYdaWJTk9wJNXaIM2IDk2asChbUGRS1TqN4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=dtDH3x4+kbtPvxHKrHHTBE5sITAntoq+mNKxXaZULmtzgx1lnDr/y5Z0WJlEVbehXHiHxqzs+tOf8FTKxyZXYEQ+2KxT7VJTSoIYp1xcqVrFU5AVb/QgUl3nLHSZgU+1iz27VTX/B4aMQZx5fVaPxaYQmbL/pEK1m1rjPq0g82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZpb03jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B3AC4CEDD;
	Mon, 24 Mar 2025 14:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826820;
	bh=2gOYVTAicYdaWJTk9wJNXaIM2IDk2asChbUGRS1TqN4=;
	h=From:To:Cc:Subject:Date:From;
	b=pZpb03jpxLA29JMyc8RDNpbEBOjAflCh4TJY3udstSoa6vbW0mnqW5zhzX/moXsim
	 IvsLKjsP0Rw9tU8yZhzkKXHnVBFxvzOYTvxuDEe2862+dgF03JwhGIxW3tnXAFhuN6
	 lmtRRe7CDrrhhXSLN4olIhiJoWGAMNM8LGk1bwcH+XfiDdHIhk0R8GDGKEvpghqXQU
	 R+Dsh6g+oOY+k6iq5iqpe2Vj9gFcfDnjSknV+BzUkSBTUNk3+xV/OBcNa5Zf1HTrWh
	 79Vv4hFN+ASn88aqdbsuF0DR2nIipuZfF/8DEtj6ldwsH+wqy/B6IIiXQLAqQ/28n8
	 3+6KRbV/r8qJw==
Message-ID: <a34186c0c3374ac5ddcee4c723ace2c2.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.15
Date: Mon, 24 Mar 2025 14:33:29 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 4701f33a10702d5fc577c32434eb62adde0a1ae1:

  Linux 6.14-rc7 (2025-03-16 12:55:17 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.15

for you to fetch changes up to ee2ecf2cf501eaa69dcd723d76b434767195b64e:

  spi: dt-bindings: cdns,qspi-nor: Improve (2025-03-20 15:35:31 +0000)

----------------------------------------------------------------
spi: Updates for v6.15

The biggest change for SPI this release is the addition of offload
support from David Lechner, allowing the hardware to trigger SPI
transactions autonomously.  The initial use case is for triggering IIO
operations but there are other applications where having the hardware
ready to go at a minimal signal is useful for synchronising with
external inputs (eg, interrupt handling) or reducing latency (eg, CAN
networking).  Otherwise there's the usual fixes, improvements and
cleanups, plus support for a bunch of new devices.

 - Support for offloaing support from David Lechner.
 - Support for GOcontrol1 Moduline modules, Mediatek MT7988, NXP i.MX94,
   Qualcomm SPI NAMD, Rockchip RK3562, Sophogo SG2044 and ST STM32 OSPI.

----------------------------------------------------------------
Andy Shevchenko (7):
      spi: realtek-rtl-snand: Drop unneeded assignment for cache_type
      spi: gpio: Remove stale documentation part
      spi: gpio: Support a single always-selected device
      spi: Replace custom fsleep() implementation
      spi: Use inclusive language
      spi: sg2044-nor: Fully convert to device managed resources
      spi: sg2044-nor: Convert to dev_err_probe()

Dan Carpenter (4):
      spi: stm32-ospi: Fix an IS_ERR() vs NULL bug in stm32_ospi_get_resources()
      spi: spi-qpic-snand: Fix ECC_CFG_ECC_DISABLE shift in qcom_spi_read_last_cw()
      spi: sg2044-nor: fix signedness bug in sg2044_spifmc_write()
      spi: sg2044-nor: fix uninitialized variable in probe

David Lechner (11):
      spi: add basic support for SPI offloading
      spi: offload: add support for hardware triggers
      dt-bindings: trigger-source: add generic PWM trigger source
      spi: offload-trigger: add PWM trigger driver
      spi: add offload TX/RX streaming APIs
      spi: dt-bindings: axi-spi-engine: add SPI offload properties
      spi: axi-spi-engine: implement offload support
      spi: offload: types: include linux/bits.h
      spi: spi-offload-trigger-pwm: add extra headers
      spi: fix missing offload_flags doc
      spi: offload: fix use after free

Easwar Hariharan (2):
      spi: spi-fsl-lpspi: convert timeouts to secs_to_jiffies()
      spi: spi-imx: convert timeouts to secs_to_jiffies()

Eddie James (1):
      spi: fsi: Batch TX operations

Frank Li (1):
      spi: dt-bindings: fsl-lpspi: Add i.MX94 support

Frank Wunderlich (1):
      dt-bindings: spi: add compatibles for mt7988

Gabor Juhos (1):
      spi: spi-qpic-snand: avoid memleak in qcom_spi_ecc_init_ctx_pipelined()

J. Neuschäfer (1):
      spi: dt-bindings: Convert Freescale SPI bindings to YAML

Jiapeng Chong (1):
      spi: stm32: Remove unnecessary print function dev_err()

Kever Yang (1):
      spi: dt-bindings: Add rk3562 support

Leilk Liu (1):
      spi: mt65xx: add PM QoS support

Longbin Li (2):
      dt-bindings: spi: add SG2044 SPI NOR controller driver
      spi: sophgo: add SG2044 SPI NOR controller driver

Lukas Bulwahn (2):
      MAINTAINERS: adjust the file entry in SPI OFFLOAD
      MAINTAINERS: adjust the file entry in GOCONTROLL MODULINE MODULE SLOT

Mark Brown (10):
      spi: zynqmp-gqspi: Clean up the driver a bit
      spi: gpio: Enable a single always-selected device
      spi: axi-spi-engine: add offload support
      Add STM32MP25 SPI NOR support
      spi: sophgo: add Sophgo SPI NOR controller driver
      arm64: dts: freescale: Add support for the GOcontroll Moduline Display
      spi: sg2044-nor: A couple of cleanups
      spi: Merge up fixes
      spi: sg2044-nor: fix a couple static checker bugs
      spi: dt-bindings: cdns,qspi-nor: Improve

Maud Spierings (4):
      dt-bindings: vendor-prefixes: add GOcontroll
      dt-bindings: connector: Add the GOcontroll Moduline module slot bindings
      MAINTAINERS: add maintainer for the GOcontroll Moduline module slot
      spi: spidev: Add an entry for the gocontroll moduline module slot

Md Sadre Alam (2):
      spi: dt-bindings: Introduce qcom,spi-qpic-snand
      spi: spi-qpic: add driver for QCOM SPI NAND flash Interface

Miquel Raynal (6):
      spi: cadence-qspi: Fix probe on AM62A LP SK
      spi: cadence-qspi: Improve spi memory performance
      spi: dt-bindings: cdns,qspi-nor: Be more descriptive regarding what this controller is
      spi: dt-bindings: cdns,qspi-nor: Deprecate the Cadence compatible alone
      spi: dt-bindings: cdns,qspi-nor: Require some peripheral properties
      spi: spi-mem: Introduce a default ->exec_op() debug log

Patrice Chotard (2):
      dt-bindings: spi: Add STM32 OSPI controller
      spi: stm32: Add OSPI driver

Peng Fan (1):
      spi: stm32-ospi: Include "gpio/consumer.h"

Qasim Ijaz (1):
      spi: sophgo: fix incorrect type for ret in sg2044_spifmc_write()

Sean Anderson (5):
      spi: zynqmp-gqspi: Reformat long line
      spi: zynqmp-gqspi: Add some more debug prints
      spi: zynqmp-gqspi: Add helpers for enabling/disabling DMA
      spi: zynqmp-gqspi: Clean up fillgenfifo
      spi: zynqmp-gqspi: Always acknowledge interrupts

Sergio Perez Gonzalez (1):
      spi: spi-mux: Fix coverity issue, unchecked return value

Tudor Ambarus (1):
      spi: s3c64xx: extend description of compatible's fifo_depth

 .../connector/gocontroll,moduline-module-slot.yaml |   88 ++
 .../bindings/spi/adi,axi-spi-engine.yaml           |   24 +
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |   25 +-
 .../devicetree/bindings/spi/fsl,espi.yaml          |   65 +
 Documentation/devicetree/bindings/spi/fsl,spi.yaml |   74 +
 Documentation/devicetree/bindings/spi/fsl-spi.txt  |   62 -
 .../bindings/spi/mediatek,spi-mt65xx.yaml          |    2 +
 .../bindings/spi/qcom,spi-qpic-snand.yaml          |   83 +
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |    1 +
 .../devicetree/bindings/spi/spi-rockchip.yaml      |    1 +
 .../devicetree/bindings/spi/spi-sg2044-nor.yaml    |   52 +
 .../devicetree/bindings/spi/st,stm32mp25-ospi.yaml |  105 ++
 .../bindings/trigger-source/pwm-trigger.yaml       |   37 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |   17 +
 drivers/mtd/nand/Makefile                          |    4 +
 drivers/spi/Kconfig                                |   44 +
 drivers/spi/Makefile                               |    7 +
 drivers/spi/spi-aspeed-smc.c                       |    7 -
 drivers/spi/spi-axi-spi-engine.c                   |  315 +++-
 drivers/spi/spi-cadence-quadspi.c                  |    8 +-
 drivers/spi/spi-fsi.c                              |   13 +
 drivers/spi/spi-fsl-lpspi.c                        |    2 +-
 drivers/spi/spi-gpio.c                             |   45 +-
 drivers/spi/spi-imx.c                              |    2 +-
 drivers/spi/spi-mem.c                              |   11 +
 drivers/spi/spi-mt65xx.c                           |   17 +
 drivers/spi/spi-mtk-snfi.c                         |    3 -
 drivers/spi/spi-mux.c                              |    4 +-
 drivers/spi/spi-npcm-fiu.c                         |    5 -
 drivers/spi/spi-offload-trigger-pwm.c              |  169 ++
 drivers/spi/spi-offload.c                          |  468 ++++++
 drivers/spi/spi-qpic-snand.c                       | 1633 ++++++++++++++++++++
 drivers/spi/spi-realtek-rtl-snand.c                |    1 -
 drivers/spi/spi-s3c64xx.c                          |    4 +-
 drivers/spi/spi-sg2044-nor.c                       |  488 ++++++
 drivers/spi/spi-stm32-ospi.c                       | 1063 +++++++++++++
 drivers/spi/spi-stm32-qspi.c                       |    5 -
 drivers/spi/spi-zynq-qspi.c                        |    4 -
 drivers/spi/spi-zynqmp-gqspi.c                     |  173 +--
 drivers/spi/spi.c                                  |  111 +-
 drivers/spi/spidev.c                               |    2 +
 include/linux/mtd/nand-qpic-common.h               |    7 +
 include/linux/spi/offload/consumer.h               |   39 +
 include/linux/spi/offload/provider.h               |   47 +
 include/linux/spi/offload/types.h                  |  100 ++
 include/linux/spi/spi.h                            |   56 +-
 47 files changed, 5188 insertions(+), 307 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,espi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/fsl,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/fsl-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
 create mode 100644 Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
 create mode 100644 drivers/spi/spi-offload-trigger-pwm.c
 create mode 100644 drivers/spi/spi-offload.c
 create mode 100644 drivers/spi/spi-qpic-snand.c
 create mode 100644 drivers/spi/spi-sg2044-nor.c
 create mode 100644 drivers/spi/spi-stm32-ospi.c
 create mode 100644 include/linux/spi/offload/consumer.h
 create mode 100644 include/linux/spi/offload/provider.h
 create mode 100644 include/linux/spi/offload/types.h

