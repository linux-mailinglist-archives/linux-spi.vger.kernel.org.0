Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41813FB6EB
	for <lists+linux-spi@lfdr.de>; Mon, 30 Aug 2021 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbhH3NZX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Aug 2021 09:25:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58982 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhH3NZW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Aug 2021 09:25:22 -0400
X-Greylist: delayed 1984 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2021 09:25:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Message-Id:Date:Subject:Cc:To:From
        :Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wEoYeikY0StRk2SvP3ey2jsbDh9GW+8ZJeT3YgB92P0=; b=AG2S0KDycwRL8278BArYM4nSMg
        uB5hMb5r8OBtjnPBSL0KKjUls5L0y/VL+kaNoT3UFxm/ioO3d4D2f9HPdh1LSeeVYeqFX4U6hySYx
        O7ZihZizbb76bBc/9j5iVrkZq166VfpxIa5mHMPEZsKzA1+T9WDgDFs4kQRItB7d7HEE=;
Received: from jack.einval.com ([84.45.184.145] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mKgl2-00H5H6-2y; Mon, 30 Aug 2021 12:51:24 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B823CD1B482; Mon, 30 Aug 2021 13:51:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v5.15
Date:   Mon, 30 Aug 2021 13:51:10 +0100
Message-Id: <20210830125123.B823CD1B482@fitzroy.sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.15

for you to fetch changes up to 6e9c846aa0c53673c5d53925a6122aa0e53a9795:

  Merge remote-tracking branch 'spi/for-5.15' into spi-next (2021-08-26 15:09:52 +0100)

----------------------------------------------------------------
spi: Updates for v5.15

A quiet release for SPI, some fixes and a couple of new drivers
plus one small refactoring:

 - Move the chip select timing configuration from the controller
   to the device to allow a bit more flexibility.
 - New drivers for Rockchip SFC and Spreadtrum ADI.

----------------------------------------------------------------
Alain Volmat (4):
      spi: stm32: enable pm_runtime autosuspend
      spi: stm32: Revert "properly handle 0 byte transfer"
      spi: stm32h7: don't wait for EOT and flush fifo on disable
      spi: stm32: finalize message either on dma callback or EOT

Alexander Sverdlin (1):
      spi: spi-ep93xx: Prepare clock before using it

Amelie Delaunay (1):
      spi: stm32h7: rework rx fifo read function

Andy Shevchenko (4):
      spi: pxa2xx: Convert reset_sccr1() to use pxa2xx_spi_update()
      spi: pxa2xx: Reset DMA bits in CR1 in reset_sccr1()
      spi: pxa2xx: Reuse int_stop_and_reset() in couple of places
      spi: pxa2xx: Adapt reset_sccr1() to the case when no message available

Aswath Govindraju (1):
      spi: omap-spi: Convert to json-schema

Chris Morgan (2):
      spi: rockchip-sfc: Bindings for Rockchip serial flash controller
      spi: rockchip-sfc: add rockchip serial flash controller

Christophe JAILLET (1):
      spi: coldfire-qspi: Use clk_disable_unprepare in the remove function

Chunyan Zhang (7):
      spi: sprd: Pass offset instead of physical address to adi_read/_write()
      spi: sprd: Make sure offset not equal to slave address size
      spi: sprd: fill offset only to RD_CMD register for reading from slave device
      spi: sprd: Fix the wrong WDG_LOAD_VAL
      spi: sprd: Add ADI r3 support
      spi: Convert sprd ADI bindings to yaml
      spi: add sprd ADI for sc9863 and ums512

Colin Ian King (1):
      spi: rockchip-sfc: Fix assigned but never used return error codes

Dmitry Osipenko (2):
      spi: tegra20-slink: Improve runtime PM usage
      spi: tegra20-slink: Don't use resource-managed spi_register helper

Douglas Anderson (1):
      spi: spi-geni-qcom: Remove confusing comment about setting the watermark

Eddie James (2):
      spi: fsi: Reduce max transfer size to 8 bytes
      dt-bindings: fsi: Remove ibm,fsi2spi-restricted compatible

Jason Wang (1):
      spi: bcm2835aux: use 'unsigned int' instead of 'unsigned'

Jon Lin (1):
      spi: rockchip-sfc: Remove redundant IO operations

Mark Brown (6):
      Merge existing fixes from spi/for-5.14
      Merge series "spi: stm32: various fixes & cleanup" from Alain Volmat <alain.volmat@foss.st.com>:
      Merge series "spi: fsi: Reduce max transfer size to 8 bytes" from Eddie James <eajames@linux.ibm.com>:
      Merge series "arm: ep93xx: CCF conversion" from Nikita Shubin <nikita.shubin@maquefel.me>:
      Merge remote-tracking branch 'spi/for-5.14' into spi-linus
      Merge remote-tracking branch 'spi/for-5.15' into spi-next

Mason Zhang (6):
      spi: mediatek: update spi master bingdings for MT6893 SOC
      spi: mediatek: add no_need_unprepare support
      spi: mediatek: add tick_delay support
      spi: move cs spi_delay to spi_device
      spi: modify set_cs_timing parameter
      spi: mediatek: fix build warnning in set cs timing

Matija Glavinic Pecotic (1):
      spi: davinci: invoke chipselect callback

Nathan Rossi (1):
      spi: orion: Prevent incorrect chip select behaviour

Quanyang Wang (1):
      spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible

Randy Dunlap (1):
      spi: <linux/spi/spi.h>: add missing struct kernel-doc entry

Tony Lindgren (2):
      spi: spi-fsl-dspi: Fix issue with uninitialized dma_slave_config
      spi: spi-pic32: Fix issue with uninitialized dma_slave_config

Uwe Kleine-König (2):
      spi: imx: Simplify logic in spi_imx_push()
      spi: imx: Implement support for CS_WORD

Yang Yingliang (2):
      spi: mxic: add missing braces
      spi: tegra20-slink: remove spi_master_put() in tegra_slink_remove()

Zhengxun Li (1):
      spi: mxic: patch for octal DTR mode support

kernel test robot (1):
      spi: stm32: fix excluded_middle.cocci warnings

 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml       |   1 -
 Documentation/devicetree/bindings/spi/omap-spi.txt |  48 --
 .../devicetree/bindings/spi/omap-spi.yaml          | 117 ++++
 .../devicetree/bindings/spi/rockchip-sfc.yaml      |  91 +++
 .../devicetree/bindings/spi/spi-mt65xx.txt         |   1 +
 .../devicetree/bindings/spi/spi-sprd-adi.txt       |  63 --
 .../devicetree/bindings/spi/sprd,spi-adi.yaml      | 104 +++
 drivers/spi/Kconfig                                |  12 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-bcm2835aux.c                       |   4 +-
 drivers/spi/spi-coldfire-qspi.c                    |   2 +-
 drivers/spi/spi-davinci.c                          |   8 +-
 drivers/spi/spi-ep93xx.c                           |   4 +-
 drivers/spi/spi-fsi.c                              | 125 +---
 drivers/spi/spi-fsl-dspi.c                         |   1 +
 drivers/spi/spi-geni-qcom.c                        |   6 -
 drivers/spi/spi-imx.c                              |  21 +-
 drivers/spi/spi-mt65xx.c                           | 159 +++--
 drivers/spi/spi-mxic.c                             |  44 +-
 drivers/spi/spi-orion.c                            |  22 +-
 drivers/spi/spi-pic32.c                            |   1 +
 drivers/spi/spi-pxa2xx.c                           |  35 +-
 drivers/spi/spi-rockchip-sfc.c                     | 694 +++++++++++++++++++++
 drivers/spi/spi-sprd-adi.c                         | 287 ++++++---
 drivers/spi/spi-stm32.c                            | 121 ++--
 drivers/spi/spi-tegra114.c                         |   8 +-
 drivers/spi/spi-tegra20-slink.c                    |  77 +--
 drivers/spi/spi-zynq-qspi.c                        |   8 +-
 drivers/spi/spi.c                                  |   6 +-
 include/linux/platform_data/spi-mt65xx.h           |   1 +
 include/linux/spi/spi.h                            |  26 +-
 31 files changed, 1520 insertions(+), 578 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
 create mode 100644 drivers/spi/spi-rockchip-sfc.c
