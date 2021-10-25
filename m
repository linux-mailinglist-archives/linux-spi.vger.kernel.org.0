Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7919438D13
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 03:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhJYBy1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 Oct 2021 21:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhJYBy0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 Oct 2021 21:54:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B7EC061745
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q187so9388533pgq.2
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Fz2LmSUmDQA71+6kgO3Gn3A53uNk0X6qIvdRYLXaYFM=;
        b=g9yTpZDjjUkB/C2QBMWHr4aKgmB17YZdhoq98VvMvCrbtntC0ENx+3j70ZYeh6tPeJ
         fVG3Dr6dJDbh3LWduAGFNLG6bnDU0Y46WUATzhvVG5ucVHqMk4w/3F1HybtuOrQM6z+T
         LaBL41f7l2Ha5gKRWMsDoV/wN96GO6AGtDO4OuUN3d2HJkbJI3olv7Sdx5eAeoo4XMOE
         J8nAN/zciL/3+J/Xj8gmlvvMcA9VocXgd2xwqGphm7nz19y0skOqSusbtqujO2Ev5bKY
         gdfAPhaxyLCik9Ccg/6fbR/+0zmvUnc+h88vrwQk9IOXUmhfOoiheBDPcb52MKoWx5SC
         VIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fz2LmSUmDQA71+6kgO3Gn3A53uNk0X6qIvdRYLXaYFM=;
        b=yaKcL6+Kbr54xnfTjka2IB5Nd8epKtYNx0LPYZcNtOfZ1S8bIONdIf58QreLJDeSyy
         xv2cL136fI+fDbJxvVg8ac/RLO1CH5tf8C1P9mD4tVaRX4kSDwnWpxg7s/5YVLsgXpIZ
         8/M6njxU6wfc3XABGjYyObIqA5gb6C1kDiITtPFfgDKKKK56tywmk/s+HP8iPGuA/vPU
         5BOoVKxhZRUQLOSIjXx85lgJYVQ9U5zlaeJjyi2H+Os99BvlUIawv4wlgevsK8s7Xzty
         DwpfeQZ8sH/siclRULYTCeyEywC6/pMc5DE4uaGjgPLiAmvgqChg62P4EHFKWG2k6IMV
         9wuw==
X-Gm-Message-State: AOAM532F2Bg52kjTgEV+S1jQJdsmWW1K7vtob6RYemcOeWpgfoUYyoSD
        rQiqfmDf14Jh1mkRQ8O9MuwL3g==
X-Google-Smtp-Source: ABdhPJylH7Y1PNS/cPb632oorh1pZCA+poM90QFmg2m8bI3Ys1q5oWmj0NOMHVb2K0MOJwAHeG8CVg==
X-Received: by 2002:a63:701b:: with SMTP id l27mr3634801pgc.341.1635126724407;
        Sun, 24 Oct 2021 18:52:04 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:04 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] Support Pensando Elba SoC 
Date:   Sun, 24 Oct 2021 18:51:45 -0700
Message-Id: <20211025015156.33133-1-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series enables support for Pensando Elba SoC based platforms.
The Elba SoC has the following features:

- Sixteen ARM64 A72 cores
- Dual DDR 4/5 memory controllers
- 32 lanes of PCIe Gen3/4 to the Host
- Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
  also a single 1GE management port.
- Storage/crypto offloads and 144 programmable P4 cores.
- QSPI and EMMC for SoC storage
- Two SPI interfaces for peripheral management
- I2C bus for platform management

This is a respin based on review input.  Summary of the changes are:

0001-gpio-Add-Elba-SoC-gpio-driver-for-spi-cs-control.patch
- This patch is deleted.  Elba SOC specific gpio spics control is
  integrated into spi-dw-mmio.c.

0002-spi-cadence-quadspi-Add-QSPI-support-for-Pensando-El.patch
- Changed compatible to "pensando,elba-qspi" to be more descriptive
  in spi-cadence-quadspi.c.

- Arnd wondered if moving to DT properties for quirks may be the
  way to go.  Feedback I've received on other patches was don't
  mix two efforts in one patch so I'm currently just adding the
  Elba support to the current design.

0003-spi-dw-Add-support-for-Pensando-Elba-SoC-SPI.patch
- Changed the implementation to use existing dw_spi_set_cs() and
  integrated Elba specific CS control into spi-dw-mmio.c.  The
  native designware support is for two chip-selects while Elba
  provides 4 chip-selects.  Instead of adding a new file for
  this support in gpio-elba-spics.c the support is in one
  file (spi-dw-mmio.c).

0004-spidev-Add-Pensando-CPLD-compatible.patch
- This patch is deleted.  The addition of compatible "pensando,cpld"
  to spidev.c is not added and an existing compatible is used 
  in the device tree to enable.

0005-mmc-sdhci-cadence-Add-Pensando-Elba-SoC-support.patch
- Ulf and Yamada-san agreed the amount of code for this support
  is not enough to need a new file.  The support is added into
  sdhci-cadence.c and new files sdhci-cadence-elba.c and
  sdhci-cadence.h are deleted.
- Redundant defines are removed (e.g. use SDHCI_CDNS_HRS04 and
  remove SDIO_REG_HRS4).
- Removed phy init function sd4_set_dlyvr() and used existing
  sdhci_cdns_phy_init(). Init values are from DT properties.
- Replace  devm_ioremap_resource(&pdev->dev, iomem)
     with  devm_platform_ioremap_resource(pdev, 1)
- Refactored the elba priv_writ_l() and elba_write_l() to
  remove a little redundant code.
- The config option CONFIG_MMC_SDHCI_CADENCE_ELBA goes away.
- Only C syntax and Elba functions are prefixed with elba_

0006-arm64-Add-config-for-Pensando-SoC-platforms.patch
- Added a little more info to the platform help text to assist
  users to decide on including platform support or not.

0007-arm64-dts-Add-Pensando-Elba-SoC-support.patch
- Node names changed to DT generic names
- Changed from using 'spi@' which is reserved
- The elba-flash-parts.dtsi is kept separate as
  it is included in multiple dts files.
- SPDX license tags at the top of each file
- The compatible = "pensando,elba" and 'model' are
  now together in the board file.
- UIO nodes removed
- Ordered nodes by increasing unit address
- Removed an unreferenced container node.
- Dropped deprecated 'device_type' for uart0 node.

0010-dt-bindings-spi-cadence-qspi-Add-support-for-Pensand.patch
- Updated since the latest documentation has been converted to yaml

0011-dt-bindings-gpio-Add-Pensando-Elba-SoC-support.patch
- This patch is deleted since the Elba gpio spics is added to
  the spi dw driver and documented there.

Because of the deletion of patches and merging of code
the new patchset is not similar.  A changelog is added into
the patches for merged code to be helpful on the history.


Brad Larson (11):
  dt-bindings: arm: pensando: add Pensando boards
  dt-bindings: Add vendor prefix for Pensando Systems
  dt-bindings: mmc: Add Pensando Elba SoC binding
  dt-bindings: spi: Add compatible for Pensando Elba SoC
  spi: dw: Add Pensando Elba SoC SPI Controller bindings
  MAINTAINERS: Add entry for PENSANDO
  arm64: Add config for Pensando SoC platforms
  spi: cadence-quadspi: Add compatible for Pensando Elba SoC
  mmc: sdhci-cadence: Add Pensando Elba SoC support
  spi: dw: Add support for Pensando Elba SoC
  arm64: dts: Add Pensando Elba SoC support

 .../bindings/arm/pensando,elba.yaml           |  20 ++
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |  13 +-
 .../bindings/spi/cdns,qspi-nor.yaml           |   3 +-
 .../bindings/spi/snps,dw-apb-ssi.yaml         |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 arch/arm64/Kconfig.platforms                  |  12 ++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/pensando/Makefile         |   6 +
 arch/arm64/boot/dts/pensando/elba-16core.dtsi | 192 ++++++++++++++++++
 .../boot/dts/pensando/elba-asic-common.dtsi   |  96 +++++++++
 arch/arm64/boot/dts/pensando/elba-asic.dts    |  23 +++
 .../boot/dts/pensando/elba-flash-parts.dtsi   | 103 ++++++++++
 arch/arm64/boot/dts/pensando/elba.dtsi        | 181 +++++++++++++++++
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-cadence.c              | 148 ++++++++++++--
 drivers/spi/spi-cadence-quadspi.c             |  19 ++
 drivers/spi/spi-dw-mmio.c                     |  85 ++++++++
 18 files changed, 894 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/pensando,elba.yaml
 create mode 100644 arch/arm64/boot/dts/pensando/Makefile
 create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
 create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
 create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi

-- 
2.17.1

