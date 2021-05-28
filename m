Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4D3941EB
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbhE1Li2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 07:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhE1Li0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 07:38:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0EDC061574;
        Fri, 28 May 2021 04:36:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DFF491F44193
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7E5CD4800DE; Fri, 28 May 2021 13:36:47 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv3 0/5] GE Healthcare PPD firmware upgrade driver for ACHC
Date:   Fri, 28 May 2021 13:33:42 +0200
Message-Id: <20210528113346.37137-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

GE Healthcare PPD firmware upgrade driver for ACHC

Hi,

The PPD has a secondary processor (NXP Kinetis K20) , which can be
programmed from the main system. It is connected to the main processor
by having it's EzPort interface connected to the SPI bus. Currently
both (normal and EzPort) interfaces are simply exposed to userspace.
This does not work for the EzPort, since EzPort usage requires a device
reset. The proper solution is to do the flashing from kernel space
with properly timed toggling of EzPort chip-select and reset line. In
PATCHv2 it was suggested, that this should happen via an SPI ancillary
device, so this has now been implemented in PATCHv3.

I'm a bit unhappy with the spidev_probe() call in gehc-achc driver, but
it also seems like a bad idea to add all that code to generic spidev
driver. If somebody has a better idea I'm all ears.

Other than that patch 2, which modifies the spi-controller.yaml to
allow multiple reg properties seems to be incorrect, but I did not
find the problem. I hope Rob can point out what I'm missing.

Changes since PATCHv2:
 * https://lore.kernel.org/lkml/20180327135259.30890-1-sebastian.reichel@collabora.co.uk/
 * add SPI core support for ancillary devices
 * modify ACHC binding to make use of ancillary device
 * rewrite driver to use ancillary device
 * rebased to 5.13-rc1

Changes since PATCHv1:
 * https://lore.kernel.org/lkml/20180320172201.2065-1-sebastian.reichel@collabora.co.uk/
 * split DT binding update into its own patch
 * add sysfs attribute documentation
 * fix problem reported by kbuild test robot

Sorry for the very long delay since PATCHv2 and thanks for looking into this,

-- Sebastian

Sebastian Reichel (5):
  spi: add ancillary device support
  spi: dt-bindings: support devices with multiple chipselects
  dt-bindings: misc: ge-achc: Convert to DT schema format
  ARM: dts: imx53-ppd: Fix ACHC entry
  misc: gehc-achc: new driver

 .../devicetree/bindings/misc/ge-achc.txt      |  26 -
 .../devicetree/bindings/misc/ge-achc.yaml     |  67 +++
 .../bindings/spi/spi-controller.yaml          |   7 +-
 arch/arm/boot/dts/imx53-ppd.dts               |  23 +-
 drivers/misc/Kconfig                          |  15 +
 drivers/misc/Makefile                         |   2 +
 drivers/misc/gehc-achc.c                      | 160 ++++++
 drivers/misc/nxp-ezport.c                     | 476 ++++++++++++++++++
 drivers/spi/spi.c                             | 139 +++--
 drivers/spi/spidev.c                          |   7 +-
 include/linux/platform_data/nxp-ezport.h      |   9 +
 include/linux/spi/spi.h                       |   7 +
 12 files changed, 865 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.yaml
 create mode 100644 drivers/misc/gehc-achc.c
 create mode 100644 drivers/misc/nxp-ezport.c
 create mode 100644 include/linux/platform_data/nxp-ezport.h

-- 
2.30.2

