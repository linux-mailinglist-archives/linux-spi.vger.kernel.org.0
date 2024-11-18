Return-Path: <linux-spi+bounces-5725-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC679D1210
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2024 14:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0A8284000
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2024 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B041BD9C1;
	Mon, 18 Nov 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsGgbHZv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D31BC077;
	Mon, 18 Nov 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936796; cv=none; b=cT+zE6Vyb2ZO8l6gIBKhR/YlKaB2hhneFJ1aNA/abhCJJ9zBhbLWNBHmOeCPhUMBfjH4CsfATMWThFFWktrkWfFMstBPVWAH8oiPFoBzZe2VkZD7iEVc7MXoEVfu1M8RN8ALouyLJY6IVVCOfXP7lJ1cCQBv1dorLOM0JZGGeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936796; c=relaxed/simple;
	bh=5dgQo3bZpzFu5jun6KC+EmchGNb2FbBt8eJcQ8tE+tc=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Q95R7iy98DXEk/xrfnR4yli4bCFriUUXZmv6Ct6nweZfpCCrHztEKI9Za3eZBnlHCYTwkkKWxWLqTUfR81Nh1Suz5xsqF1FRlaGvLI8Faqy75WFH0PlWiBsmcRyDsBJ5oZ6Azf1zHzy1u9DNEmLJCX5okzBE8i2SMD1Uy/ZeiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsGgbHZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7D7C4CECC;
	Mon, 18 Nov 2024 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731936796;
	bh=5dgQo3bZpzFu5jun6KC+EmchGNb2FbBt8eJcQ8tE+tc=;
	h=From:To:Cc:Subject:Date:From;
	b=rsGgbHZv8Kh5UbfkXSZvyi/ACzEALxOFhNwPEDuVew0IEgsw/oHYxkwpyCdItHzXP
	 uZBu4+6tiMjrSetF8iQemksQ2oanIxEyB3mSf83sqlblNGHXOUDHV3V09KcxFdbxxB
	 LT3SSU9loMJZ6IRrZqoH/2YbGSGmQB+Go11XwLzdpFv4rBZVZ9FMv3a7rmnplyWkJ8
	 umkoOGJd7vzBAlJlWuI1SJ0+86E0EuOQhawu1WIQwQAPuhSgKiNTO/P/Q1jB0naWKx
	 tH6RAFaNfKsCgntZWy9v8QvWeNejuE8a8RGZkRl7vxFkhsexnT1Qin/p2gK5XmY6nv
	 21MckDn51k7ug==
Message-ID: <1c6bb542f52ef9a8428a0f35dc21dfc7.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.13
Date: Mon, 18 Nov 2024 13:33:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.13

for you to fetch changes up to 26470a2e87a6fc40750f4bfe962519e9ae9a9e72:

  spi: imx: support word delay in ecspi (2024-11-14 11:43:39 +0000)

----------------------------------------------------------------
spi: Updates for v6.13

The only real core work we've got this time around is the completion of
the transition to the new host/target naming for the core APIs, Kconfig
still needs doing but that's a lot less invasive.  Otherwise the big
changes are the new drivers that have been added:

 - Completion of the conversion to spi_alloc_host()/_target() and
   removal of the old naming.
 - Cleanups for Rockchip drivers, these brought in a new logging helper
   in the driver core for warnings during probe.
 - Support for configuration of the word delay via spidev_test.
 - Support for AMD HID2 controllers, Apple SPI controller and Realtek
   SPI-NAND controllers.

The Rockchip cleanups

----------------------------------------------------------------
Alain Volmat (1):
      spi: stm32: fix missing device mode capability in stm32mp25

Alexander Dahl (1):
      spi: atmel-quadspi: Add cs_hold and cs_inactive setting support

Alexander Usyskin (1):
      spi: intel: Add protected and locked attributes

Amit Kumar Mahapatra (1):
      dt-bindings: spi: zynqmp-qspi: Include two 'reg' properties only for the Zynq UltraScale QSPI

Bartosz Golaszewski (1):
      spi: make class structs const

Breno Leitao (1):
      spi: tegra210-quad: Avoid shift-out-of-bounds

Chris Packham (3):
      dt-bindings: spi: Add realtek,rtl9301-snand
      spi: spi-mem: Add Realtek SPI-NAND controller
      spi: spi-mem: rtl-snand: Correctly handle DMA transfers

Colin Ian King (1):
      spi: spi-ti-qspi: remove redundant assignment to variable ret

Dragan Simic (8):
      spi: rockchip: Perform trivial code cleanups
      spi: rockchip-sfc: Perform trivial code cleanups
      spi: rockchip-sfc: Use dev_err_probe() in the probe path
      spi: rockchip: Perform trivial code cleanups
      spi: rockchip-sfc: Perform trivial code cleanups
      spi: rockchip-sfc: Use dev_err_probe() in the probe path
      driver core: Add device probe log helper dev_warn_probe()
      spi: rockchip: Use dev_{err,warn}_probe() in the probe path

Hardevsinh Palaniya (2):
      spi: spi-fsl-dspi: Fix casting warnings
      spi: spi-imx: Fix casting warnings

Hector Martin (2):
      spi: dt-bindings: apple,spi: Add binding for Apple SPI controllers
      spi: apple: Add driver for Apple SPI controller

Ivaylo Ivanov (1):
      spi: dt-bindings: samsung: Add a compatible for samsung,exynos8895-spi

Jiapeng Chong (1):
      spi: apple: Remove unnecessary .owner for apple_spi_driver

Jinjie Ruan (2):
      spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: zynqmp-gqspi: Undo runtime PM changes at driver exit time​

Jonas Rebmann (3):
      spi: spidev_test: add support for word delay
      spi: imx: pass struct spi_transfer to prepare_transfer()
      spi: imx: support word delay

Karan Sanghavi (1):
      spi: dt-bindings: brcm,bcm2835-aux-spi: Convert to dtschema

Lorenzo Bianconi (1):
      spi: airoha: do not keep {tx,rx} dma buffer always mapped

Mark Brown (9):
      spi: spi_amd: Performance Optimization Patch Series
      spi: replace and remove
      Improve error handling in Rockchip SPI drivers
      spi: spi-fsl-lpspi: Some calculation improvements
      spi: Merge up v6.12
      Add dev_warn_probe() and improve error handling in
      Fix Sparse warnings
      Realtek SPI-NAND controller
      spi: imx: support word delay in ecspi

Markus Elfring (1):
      spi: slave-mt27xx: Call clk_disable_unprepare() only once in mtk_spi_slave_probe()

Philipp Stanner (1):
      spi: Replace deprecated PCI functions

Raju Rangoju (8):
      spi: spi_amd: Sort headers alphabetically
      spi: spi_amd: Enable dual and quad I/O modes
      spi: spi_amd: Replace ioread/iowrite calls
      spi: spi_amd: Updates to set tx/rx count functions
      spi: spi_amd: Optimize IO operations
      spi: spi_amd: Add support for HID2 SPI controller
      spi: spi_amd: Set controller address mode
      spi: spi_amd: Add HIDDMA basic read support

Rob Herring (Arm) (1):
      spi: Use of_property_present() for non-boolean properties

Simon Trimmer (1):
      spi: cs42l43: Add GPIO speaker id support to the bridge configuration

Stanislav Jakubek (1):
      dt-bindings: spi: sprd,sc9860-spi: convert to YAML

Stefan Wahren (3):
      spi: spi-fsl-lpspi: Adjust type of scldiv
      spi: spi-fsl-lpspi: Fix specifiers in fsl_lpspi_set_bitrate
      spi: spi-fsl-lpspi: support effective_speed_hz

Uwe Kleine-König (3):
      spi: Switch back to struct platform_driver::remove()
      spi: Provide defer reason if getting irq during probe fails
      spi: axi-spi-engine: Emit trace events for spi transfers

Yan Zhen (1):
      spi: fix typo in the comment

Yang Yingliang (6):
      media: usb/msi2500: switch to use spi_alloc_host()
      media: netup_unidvb: switch to use devm_spi_alloc_host()
      spi: ch341: switch to use devm_spi_alloc_host()
      spi: slave-mt27xx: switch to use spi_alloc_target()
      video: fbdev: mmp: switch to use spi_alloc_host()
      spi: remove {devm_}spi_alloc_master/slave()

zhang jiao (1):
      spi: Delete useless checks

 Documentation/ABI/testing/sysfs-driver-spi-intel   |  20 +
 .../devicetree/bindings/spi/apple,spi.yaml         |  62 +++
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |  38 --
 .../bindings/spi/brcm,bcm2835-aux-spi.yaml         |  53 +++
 .../bindings/spi/realtek,rtl9301-snand.yaml        |  62 +++
 .../devicetree/bindings/spi/samsung,spi.yaml       |   4 +
 Documentation/devicetree/bindings/spi/spi-sprd.txt |  33 --
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |  22 +-
 .../devicetree/bindings/spi/sprd,sc9860-spi.yaml   |  72 +++
 Documentation/driver-api/driver-model/devres.rst   |   4 +-
 MAINTAINERS                                        |   6 +
 drivers/base/core.c                                | 129 +++--
 drivers/media/pci/netup_unidvb/netup_unidvb_spi.c  |   6 +-
 drivers/media/usb/msi2500/msi2500.c                |   4 +-
 drivers/spi/Kconfig                                |  22 +
 drivers/spi/Makefile                               |   2 +
 drivers/spi/atmel-quadspi.c                        |  38 +-
 drivers/spi/spi-airoha-snfi.c                      | 154 +++---
 drivers/spi/spi-amd.c                              | 325 +++++++++++--
 drivers/spi/spi-apple.c                            | 529 +++++++++++++++++++++
 drivers/spi/spi-ar934x.c                           |   2 +-
 drivers/spi/spi-aspeed-smc.c                       |   2 +-
 drivers/spi/spi-at91-usart.c                       |   2 +-
 drivers/spi/spi-ath79.c                            |   2 +-
 drivers/spi/spi-atmel.c                            |   2 +-
 drivers/spi/spi-au1550.c                           |   2 +-
 drivers/spi/spi-axi-spi-engine.c                   |  15 +
 drivers/spi/spi-bcm2835.c                          |   2 +-
 drivers/spi/spi-bcm2835aux.c                       |   2 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |   2 +-
 drivers/spi/spi-bcm63xx.c                          |   2 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |   2 +-
 drivers/spi/spi-brcmstb-qspi.c                     |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |   2 +-
 drivers/spi/spi-cadence.c                          |   2 +-
 drivers/spi/spi-cavium-octeon.c                    |   2 +-
 drivers/spi/spi-ch341.c                            |   2 +-
 drivers/spi/spi-coldfire-qspi.c                    |   2 +-
 drivers/spi/spi-cs42l43.c                          |  46 +-
 drivers/spi/spi-davinci.c                          |   2 +-
 drivers/spi/spi-dln2.c                             |   2 +-
 drivers/spi/spi-dw-bt1.c                           |   2 +-
 drivers/spi/spi-dw-mmio.c                          |   2 +-
 drivers/spi/spi-dw-pci.c                           |   9 +-
 drivers/spi/spi-ep93xx.c                           |   2 +-
 drivers/spi/spi-fsl-dspi.c                         |  10 +-
 drivers/spi/spi-fsl-espi.c                         |   2 +-
 drivers/spi/spi-fsl-lpspi.c                        |  29 +-
 drivers/spi/spi-fsl-qspi.c                         |   2 +-
 drivers/spi/spi-fsl-spi.c                          |   4 +-
 drivers/spi/spi-hisi-kunpeng.c                     |   2 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |   2 +-
 drivers/spi/spi-img-spfi.c                         |   2 +-
 drivers/spi/spi-imx.c                              | 115 ++++-
 drivers/spi/spi-intel-pci.c                        |   1 +
 drivers/spi/spi-intel-platform.c                   |   1 +
 drivers/spi/spi-intel.c                            |  64 ++-
 drivers/spi/spi-intel.h                            |   2 +
 drivers/spi/spi-iproc-qspi.c                       |   2 +-
 drivers/spi/spi-lantiq-ssc.c                       |   4 +-
 drivers/spi/spi-loongson-pci.c                     |   5 +-
 drivers/spi/spi-meson-spicc.c                      |   2 +-
 drivers/spi/spi-meson-spifc.c                      |   2 +-
 drivers/spi/spi-microchip-core-qspi.c              |   2 +-
 drivers/spi/spi-microchip-core.c                   |   2 +-
 drivers/spi/spi-mpc52xx-psc.c                      |   4 +-
 drivers/spi/spi-mpc52xx.c                          |   2 +-
 drivers/spi/spi-mt65xx.c                           |   2 +-
 drivers/spi/spi-mtk-nor.c                          |   2 +-
 drivers/spi/spi-mtk-snfi.c                         |   2 +-
 drivers/spi/spi-mxic.c                             |   2 +-
 drivers/spi/spi-mxs.c                              |   2 +-
 drivers/spi/spi-npcm-fiu.c                         |   8 +-
 drivers/spi/spi-npcm-pspi.c                        |   2 +-
 drivers/spi/spi-nxp-fspi.c                         |   2 +-
 drivers/spi/spi-oc-tiny.c                          |   2 +-
 drivers/spi/spi-omap-uwire.c                       |   2 +-
 drivers/spi/spi-omap2-mcspi.c                      |   2 +-
 drivers/spi/spi-orion.c                            |   2 +-
 drivers/spi/spi-pic32-sqi.c                        |   4 +-
 drivers/spi/spi-pic32.c                            |   2 +-
 drivers/spi/spi-pl022.c                            |   2 +-
 drivers/spi/spi-ppc4xx.c                           |   2 +-
 drivers/spi/spi-pxa2xx-pci.c                       |   8 +-
 drivers/spi/spi-pxa2xx-platform.c                  |   2 +-
 drivers/spi/spi-qcom-qspi.c                        |   4 +-
 drivers/spi/spi-qup.c                              |   2 +-
 drivers/spi/spi-rb4xx.c                            |   2 +-
 drivers/spi/spi-realtek-rtl-snand.c                | 419 ++++++++++++++++
 drivers/spi/spi-rockchip-sfc.c                     |  25 +-
 drivers/spi/spi-rockchip.c                         |  59 ++-
 drivers/spi/spi-rpc-if.c                           |   2 +-
 drivers/spi/spi-rspi.c                             |   2 +-
 drivers/spi/spi-rzv2m-csi.c                        |   2 +-
 drivers/spi/spi-s3c64xx.c                          |   4 +-
 drivers/spi/spi-sh-hspi.c                          |   2 +-
 drivers/spi/spi-sh-msiof.c                         |   2 +-
 drivers/spi/spi-sh-sci.c                           |   2 +-
 drivers/spi/spi-sh.c                               |   2 +-
 drivers/spi/spi-sifive.c                           |   2 +-
 drivers/spi/spi-slave-mt27xx.c                     |  10 +-
 drivers/spi/spi-sn-f-ospi.c                        |   2 +-
 drivers/spi/spi-sprd.c                             |   4 +-
 drivers/spi/spi-st-ssc4.c                          |   2 +-
 drivers/spi/spi-stm32-qspi.c                       |   2 +-
 drivers/spi/spi-stm32.c                            |   3 +-
 drivers/spi/spi-sun4i.c                            |   2 +-
 drivers/spi/spi-sun6i.c                            |   2 +-
 drivers/spi/spi-sunplus-sp7021.c                   |   2 +-
 drivers/spi/spi-synquacer.c                        |   2 +-
 drivers/spi/spi-tegra114.c                         |   2 +-
 drivers/spi/spi-tegra20-sflash.c                   |   2 +-
 drivers/spi/spi-tegra20-slink.c                    |   4 +-
 drivers/spi/spi-tegra210-quad.c                    |   4 +-
 drivers/spi/spi-ti-qspi.c                          |   5 +-
 drivers/spi/spi-topcliff-pch.c                     |   2 +-
 drivers/spi/spi-uniphier.c                         |   2 +-
 drivers/spi/spi-xilinx.c                           |   2 +-
 drivers/spi/spi-xtensa-xtfpga.c                    |   2 +-
 drivers/spi/spi-zynq-qspi.c                        |   2 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   4 +-
 drivers/spi/spi.c                                  |  25 +-
 drivers/video/fbdev/mmp/hw/mmp_spi.c               |   6 +-
 include/linux/dev_printk.h                         |   1 +
 include/linux/spi/spi.h                            |  30 --
 tools/spi/spidev_test.c                            |  11 +-
 126 files changed, 2187 insertions(+), 489 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-spi-intel
 create mode 100644 Documentation/devicetree/bindings/spi/apple,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/spi/sprd,sc9860-spi.yaml
 create mode 100644 drivers/spi/spi-apple.c
 create mode 100644 drivers/spi/spi-realtek-rtl-snand.c

