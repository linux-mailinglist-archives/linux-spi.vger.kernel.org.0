Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5679B23BEF6
	for <lists+linux-spi@lfdr.de>; Tue,  4 Aug 2020 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgHDRjp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Aug 2020 13:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbgHDRjp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 4 Aug 2020 13:39:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A65ED20842
        for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2020 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596562784;
        bh=+I8HGWCIh0swxCcbKAIib5A8N80uyicQ19AG48UYkzY=;
        h=Resent-From:Resent-Date:Resent-To:From:To:Cc:Date:Subject:From;
        b=sJVYjlt/rElSUSiqdY2Pbo76Pc54v939jZlvjGaMhvT4ELJRg5M+NIopNG38+PkNc
         iJGFHG5Wc3k1CGDGcQcH16JS2LD3HzYx7OOsib7+A8jkn8WlUOvSq4CjTXTgB+deOx
         tTs3PLrrvkTZJ+Wkhu9NNBoV0YfKG8Md3yofMPWY=
Envelope-to: broonie@sirena.co.uk
Delivery-date: Mon, 03 Aug 2020 13:41:19 +0100
Received: from mail.kernel.org ([198.145.29.99])
        by cassiel.sirena.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@kernel.org>)
        id 1k2ZmH-0007KD-DS
        for broonie@sirena.co.uk; Mon, 03 Aug 2020 13:41:19 +0100
Received: by mail.kernel.org (Postfix)
        id 0ACE120678; Mon,  3 Aug 2020 12:41:15 +0000 (UTC)
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1812054F;
        Mon,  3 Aug 2020 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596458474;
        bh=+I8HGWCIh0swxCcbKAIib5A8N80uyicQ19AG48UYkzY=;
        h=From:To:Cc:Subject:Date:From;
        b=s39KJfgMltGB1Nb9aM00mFCKD7QR8+mfB05yKj52S43Bkc0tAEXMY99oakIZOca8j
         btUvrqRkD1PgX+/cbulBBsf8Tm/2Twv8KJvzm9o8yjmaGyQCR/OlqJ/oJoIFe+Pxht
         FqBimm/UppP0Pg3PHmh/2DYIOkfoZ7iW83wPw+bU=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date:   Mon, 03 Aug 2020 13:39:59 +0100
Message-Id: <20200803124114.2B1812054F@mail.kernel.org>
X-SA-Exim-Connect-IP: 198.145.29.99
X-SA-Exim-Mail-From: broonie@kernel.org
Subject: [GIT PULL] SPI updates for v5.9
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); Unknown failure
X-TUID: pUZvZucI7XkT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.9

for you to fetch changes up to 11ba28229f8258164731e42f4c3e93762cb6578e:

  Merge remote-tracking branch 'spi/for-5.9' into spi-next (2020-07-29 14:52:00 +0100)

----------------------------------------------------------------
spi: Updates for v5.9

A fairly quiet release for SPI, nothing really going on in the core
although there's been quite a bit of driver related activity.  This pull
request includes the addition of some shared code in drivers/memory for
the Renesas RPC-IF which is used by a newly added SPI driver, the memory
subsystem doesn't seem to have a fixed maintainer at the minute and this
seemed like the most sensible way to get that hardware supported.

 - Quite a few cleanups and optimizations for the Altera, Qualcomm GENI,
   sun6i and lantiq drivers.
 - Several more GPIO descriptor conversions.
 - Move the Cadence QuadSPI driver from drivers/mtd to drivers/spi.
 - New support for Mediatek MT8192 and Renesas RPC-IF, R8A7742 and
   R8A774e1.

----------------------------------------------------------------
Alexander A. Klimov (1):
      SPI SUBSYSTEM: Replace HTTP links with HTTPS ones

Andy Shevchenko (1):
      spi: npcm-fiu: Reuse BITS_PER_BYTE definition

Anson Huang (3):
      dt-bindings: spi: Convert mxs spi to json-schema
      dt-bindings: spi: Convert imx cspi to json-schema
      dt-bindings: spi: Convert imx lpspi to json-schema

Christian Eggers (1):
      spi: spidev: Align buffers for DMA

Clark Wang (6):
      spi: lpspi: fix the imbalance of runtime pm function call
      spi: imx: enable runtime pm support
      spi: lpspi: Fix kernel warning dump when probe fail after calling spi_register
      spi: lpspi: remove unused fsl_lpspi->chipselect
      spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK
      dt-bindings: lpspi: New property in document DT bindings for LPSPI

Colin Ian King (1):
      spi: atmel: remove redundant label out_free

Colton Lewis (1):
      spi: correct kernel-doc inconsistency

Dilip Kota (8):
      spi: lantiq: fix: Rx overflow error in full duplex mode
      spi: lantiq: Add SMP support
      spi: lantiq: Move interrupt control register offesets to SoC specific data structure
      spi: lantiq: Add support to acknowledge interrupt
      spi: lantiq: Add fifo size bit mask in SoC specific data structure
      spi: lantiq: Move interrupt configuration to SoC specific data structure
      spi: lantiq: Add support to Lightning Mountain SoC
      spi: Add bindings for Lightning Mountain SoC

Douglas Anderson (8):
      spi: spi-geni-qcom: No need for irqsave variant of spinlock calls
      spi: spi-geni-qcom: Mo' betta locking
      spi: spi-geni-qcom: Check for error IRQs
      spi: spi-geni-qcom: Actually use our FIFO
      spi: spi-geni-qcom: Don't keep a local state variable
      spi: spi-geni-qcom: Don't set the cs if it was already right
      spi: Avoid setting the chip select if we don't need to
      spi: spi-geni-qcom: Set an autosuspend delay of 250 ms

Jon Lin (3):
      spi: rockchip: Config spi rx dma burst size depend on xfer length
      spi: rockchip: Support 64-location deep FIFOs
      spi: rockchip: Fix error in SPI slave pio read

Jonathan Liu (1):
      spi: sun4i: update max transfer size reported

Lad Prabhakar (2):
      spi: renesas,sh-msiof: Add r8a7742 support
      spi: renesas,sh-msiof: Add r8a774e1 support

Lee Jones (14):
      spi: spi-loopback-test: Fix formatting issues in function header blocks
      spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard comment blocks
      spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
      spi: spi-ep93xx: Fix API slippage
      spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct meson_spifc'
      spi: spi-meson-spicc: Remove set but never used variable 'data' from meson_spicc_reset_fifo()
      spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
      spi: spi-pl022: Provide missing struct attribute/function param docs
      spi: spi-zynq-qspi: Add description for 2 missing attributes/parameters
      spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
      spi: spi-topcliff-pch: Add missing descriptions to 'struct pch_spi_data'
      spi: spi-at91-usart: Remove unused OF table 'struct of_device_id'
      spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
      spi: spi-amd: Do not define 'struct acpi_device_id' when !CONFIG_ACPI

Linus Walleij (7):
      spi: omap2-mcspi: Convert to use GPIO descriptors
      spi: npcm-pspi: Convert to use GPIO descriptors
      spi: img-spfi: Convert to use GPIO descriptors
      spi: lantiq-ssc: Convert to use GPIO descriptors
      spi: imx/fsl-lpspi: Convert to GPIO descriptors
      spi: omap-100k: Drop include
      spi: ppc4xx: Convert to use GPIO descriptors

Luc Van Oostenryck (1):
      spi: fsl: add missing __iomem annotation

Marc Kleine-Budde (9):
      spi: spi-sun6i: sun6i_spi_transfer_one(): report effectivly used speed_hz of transfer
      spi: spi-sun6i: sun6i_spi_transfer_one(): remove useless goto
      spi: spi-sun6i: sun6i_spi_transfer_one(): remove not needed masking of transfer length
      spi: spi-sun6i: sun6i_spi_get_tx_fifo_count: Convert manual shift+mask to FIELD_GET()
      spi: spi-sun6i: sun6i_spi_drain_fifo(): introduce sun6i_spi_get_rx_fifo_count() and make use of it
      spi: spi-sun6i: sun6i_spi_drain_fifo(): remove not needed length argument
      spi: spi-sun6i: sun6i_spi_fill_fifo(): remove not needed length argument
      spi: spi-sun6i: sun6i_spi_transfer_one(): collate write to Interrupt Control Register
      spi: spi-sun6i: sun6i_spi_transfer_one(): enable RF_RDY interrupt only if needed

Marek Szyprowski (1):
      spi: use kthread_create_worker() helper

Mark Brown (19):
      Merge existing fixes from spi/for-5.8
      Merge series "Add more configuration and regmap support for spi-altera" from Xu Yilun <yilun.xu@intel.com>:
      Merge series "spi: bcm63xx: add BMIPS support" from Álvaro Fernández Rojas <noltari@gmail.com>:
      Merge series "Add MSIOF support for R8A7742 SOC" from Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>:
      Merge series "spi: spi-geni-qcom: Fixes / perf improvements" from Douglas Anderson <dianders@chromium.org>:
      Merge series "add regmap & indirect access support" from Xu Yilun <yilun.xu@intel.com>:
      Merge series "mtd: spi-nor: Move cadence-qaudspi to spi-mem framework" from Vignesh Raghavendra <vigneshr@ti.com>:
      Merge series "Some small spi geni cleanups" from Stephen Boyd <swboyd@chromium.org>:
      Merge series "spi: bcm2835: Interrupt-handling optimisations" from Robin Murphy <robin.murphy@arm.com>:
      Merge series "Add Renesas RPC-IF support" from Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
      Merge series "spi: spi-sun6i: One fix and some improvements" from Marc Kleine-Budde <mkl@pengutronix.de>:
      Merge series "spi: spi-geni-qcom: Avoid a bunch of per-transfer overhead" from Douglas Anderson <dianders@chromium.org>:
      Merge series "mtd: spi-nor: add xSPI Octal DTR support" from Pratyush Yadav <p.yadav@ti.com>:
      spi: Only defer to thread for cleanup when needed
      Merge series "spi: bcm2835/bcm2835aux: support effective_speed_hz" from Marc Kleine-Budde <mkl@pengutronix.de>:
      Merge series "Add support for [H]SCIF/TMU/CMT/THS/SDHI/MSIOF/CAN[FD]/I2C/IIC/RWDT on R8A774E1" from Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>:
      Merge series "Some bug fix for lpspi" from Clark Wang <xiaoning.wang@nxp.com>:
      Merge remote-tracking branch 'spi/for-5.8' into spi-linus
      Merge remote-tracking branch 'spi/for-5.9' into spi-next

Martin Sperl (2):
      spi: bcm2835: support effective_speed_hz
      spi: bcm2835aux: support effective_speed_hz

Matthew Gerlach (1):
      spi: altera: fix size mismatch on 64 bit processors

Peng Fan (1):
      spi: atmel: No need to call spi_master_put() if spi_alloc_master() failed

Pratyush Yadav (4):
      spi: spi-mem: allow specifying whether an op is DTR or not
      spi: spi-mem: allow specifying a command's extension
      spi: atmel-quadspi: reject DTR ops
      spi: spi-mtk-nor: reject DTR ops

Qing Zhang (2):
      spi: omap-uwire: Use clk_prepare_enable and clk_disable_unprepare
      spi: coldfire-qspi: Use clk_prepare_enable and clk_disable_unprepare

Ramuthevar Vadivel Murugan (2):
      mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
      spi: Move cadence-quadspi driver to drivers/spi/

Randy Dunlap (1):
      spi: fix duplicated word in <linux/spi/spi.h>

Robin Gong (2):
      spi: introduce fallback to pio
      spi: imx: add fallback feature

Robin Murphy (3):
      spi: bcm3835: Tidy up bcm2835_spi_reset_hw()
      spi: bcm2835: Micro-optimise IRQ handler
      spi: bcm2835: Micro-optimise FIFO loops

Serge Semin (1):
      spi: dw-dma: Fix Tx DMA channel working too fast

Sergei Shtylyov (3):
      spi: add Renesas RPC-IF driver
      dt-bindings: memory: document Renesas RPC-IF bindings
      memory: add Renesas RPC-IF driver

Shreyas Joshi (1):
      spi: spi-cadence: add support for chip select high

Stephen Boyd (3):
      spi: spi-geni-qcom: Simplify setup_fifo_xfer()
      spi: spi-geni-qcom: Simplify setup_fifo_xfer()
      spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily

Tim Harvey (1):
      spi: spi-cavium-thunderx: flag controller as half duplex

Tudor Ambarus (2):
      spi: atmel-quadspi: Use optimezed memcpy_fromio()/memcpy_toio()
      spi: Fix SPI NOR and SPI NAND acronyms

Vaibhav Gupta (2):
      spi: spi-topcliff-pch: use generic power management
      spi: spi-topcliff-pch: drop call to wakeup-disable

Vignesh Raghavendra (6):
      mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
      mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
      mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
      mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
      mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel
      mtd: spi-nor: cadence-quadspi: Drop redundant WREN in erase path

Xu Yilun (7):
      spi: altera: add 32bit data width transfer support.
      spi: altera: add SPI core parameters support via platform data.
      spi: altera: add platform data for slave information.
      spi: altera: use regmap-mmio instead of direct mmio register access
      spi: altera: support indirect access to the registers
      spi: altera: fix driver matching failure of the device ID "spi_altera"
      spi: altera: fix module autoload

leilk.liu (2):
      spi: mediatek: add spi support for mt8192 IC
      spi: update bindings for MT8192 SoC

Álvaro Fernández Rojas (4):
      spi: bcm63xx-spi: allow building for BMIPS
      spi: bcm63xx-hsspi: allow building for BMIPS
      spi: bcm63xx-spi: add reset support
      spi: bcm63xx-hsspi: add reset support

 .../memory-controllers/renesas,rpc-if.yaml         |  88 +++
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  56 --
 .../devicetree/bindings/spi/fsl-imx-cspi.yaml      |  97 ++++
 Documentation/devicetree/bindings/spi/mxs-spi.txt  |  26 -
 Documentation/devicetree/bindings/spi/mxs-spi.yaml |  56 ++
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |   2 +
 .../devicetree/bindings/spi/spi-davinci.txt        |   4 +-
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      |  29 -
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |  67 +++
 .../devicetree/bindings/spi/spi-lantiq-ssc.txt     |  21 +-
 .../devicetree/bindings/spi/spi-mt65xx.txt         |   1 +
 Documentation/spi/spi-sc18is602.rst                |   2 +-
 arch/arm/mach-imx/devices-imx27.h                  |  10 +-
 arch/arm/mach-imx/devices-imx31.h                  |  10 +-
 arch/arm/mach-imx/devices/devices-common.h         |   5 +-
 arch/arm/mach-imx/devices/platform-spi_imx.c       |   9 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                  |  40 +-
 arch/arm/mach-imx/mach-mx31_3ds.c                  |  13 +-
 arch/arm/mach-imx/mach-mx31lilly.c                 |  14 +-
 arch/arm/mach-imx/mach-mx31lite.c                  |  19 +-
 arch/arm/mach-imx/mach-mx31moboard.c               |  12 +-
 arch/arm/mach-imx/mach-pca100.c                    |  21 +-
 arch/arm/mach-imx/mach-pcm037_eet.c                |   7 +-
 drivers/gpio/gpiolib-of.c                          |  10 +-
 drivers/memory/Kconfig                             |   9 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/renesas-rpc-if.c                    | 603 +++++++++++++++++++++
 drivers/mtd/spi-nor/controllers/Kconfig            |  11 -
 drivers/mtd/spi-nor/controllers/Makefile           |   1 -
 drivers/spi/Kconfig                                |  38 +-
 drivers/spi/Makefile                               |   2 +
 drivers/spi/atmel-quadspi.c                        |  14 +-
 drivers/spi/spi-altera.c                           | 179 +++++-
 drivers/spi/spi-amd.c                              |   2 +
 drivers/spi/spi-at91-usart.c                       |   7 -
 drivers/spi/spi-atmel.c                            |   4 +-
 drivers/spi/spi-bcm2835.c                          |  51 +-
 drivers/spi/spi-bcm2835aux.c                       |   6 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |  12 +
 drivers/spi/spi-bcm63xx.c                          |  12 +
 drivers/spi/spi-bitbang.c                          |   6 +-
 .../spi-cadence-quadspi.c}                         | 541 +++++++-----------
 drivers/spi/spi-cadence.c                          |   2 +-
 drivers/spi/spi-cavium-thunderx.c                  |   1 +
 drivers/spi/spi-coldfire-qspi.c                    |   4 +-
 drivers/spi/spi-davinci.c                          |   7 +-
 drivers/spi/spi-dw-dma.c                           |  14 +-
 drivers/spi/spi-ep93xx.c                           |   4 +-
 drivers/spi/spi-fsl-lpspi.c                        |  79 +--
 drivers/spi/spi-fsl-qspi.c                         |   2 +-
 drivers/spi/spi-fsl-spi.c                          |  18 +-
 drivers/spi/spi-geni-qcom.c                        | 179 +++---
 drivers/spi/spi-img-spfi.c                         |  56 +-
 drivers/spi/spi-imx.c                              | 248 ++++-----
 drivers/spi/spi-lantiq-ssc.c                       | 177 ++++--
 drivers/spi/spi-loopback-test.c                    |  16 +-
 drivers/spi/spi-mem.c                              |  16 +-
 drivers/spi/spi-meson-spicc.c                      |   4 +-
 drivers/spi/spi-meson-spifc.c                      |   2 +-
 drivers/spi/spi-mt65xx.c                           |   3 +
 drivers/spi/spi-mtk-nor.c                          |  10 +-
 drivers/spi/spi-mxic.c                             |   3 +-
 drivers/spi/spi-npcm-fiu.c                         |   6 +-
 drivers/spi/spi-npcm-pspi.c                        |  28 +-
 drivers/spi/spi-oc-tiny.c                          |   2 +-
 drivers/spi/spi-omap-100k.c                        |   1 -
 drivers/spi/spi-omap-uwire.c                       |   4 +-
 drivers/spi/spi-omap2-mcspi.c                      |  19 +-
 drivers/spi/spi-orion.c                            |   2 +-
 drivers/spi/spi-pl022.c                            |  12 +-
 drivers/spi/spi-ppc4xx.c                           | 106 +---
 drivers/spi/spi-pxa2xx.c                           |   2 +
 drivers/spi/spi-rockchip.c                         |  46 +-
 drivers/spi/spi-rpc-if.c                           | 216 ++++++++
 drivers/spi/spi-s3c64xx.c                          |   9 +-
 drivers/spi/spi-sun4i.c                            |   2 +-
 drivers/spi/spi-sun6i.c                            |  77 ++-
 drivers/spi/spi-ti-qspi.c                          |   2 +-
 drivers/spi/spi-topcliff-pch.c                     |  59 +-
 drivers/spi/spi-zynq-qspi.c                        |  14 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   6 +-
 drivers/spi/spi.c                                  |  73 ++-
 drivers/spi/spidev.c                               |  21 +-
 include/linux/platform_data/spi-imx.h              |  33 --
 include/linux/spi/altera.h                         |  29 +
 include/linux/spi/spi-mem.h                        |  14 +-
 include/linux/spi/spi.h                            |  29 +-
 include/memory/renesas-rpc-if.h                    |  87 +++
 88 files changed, 2503 insertions(+), 1359 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
 create mode 100644 drivers/memory/renesas-rpc-if.c
 rename drivers/{mtd/spi-nor/controllers/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (74%)
 create mode 100644 drivers/spi/spi-rpc-if.c
 delete mode 100644 include/linux/platform_data/spi-imx.h
 create mode 100644 include/linux/spi/altera.h
 create mode 100644 include/memory/renesas-rpc-if.h
