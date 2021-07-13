Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D118D3C7502
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhGMQj3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 12:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbhGMQjZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 12:39:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278E3C0613B7;
        Tue, 13 Jul 2021 09:35:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 187CB1F41E15
Received: by jupiter.universe (Postfix, from userid 1000)
        id 409274800C6; Tue, 13 Jul 2021 18:35:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ian Ray <ian.ray@ge.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv7 0/3] GE Healthcare PPD firmware upgrade driver for ACHC
Date:   Tue, 13 Jul 2021 18:35:25 +0200
Message-Id: <20210713163528.119185-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

The PPD has a secondary processor (NXP Kinetis K20), which can be
programmed from the main system. It is connected to the main processor
by having it's EzPort interface connected to the SPI bus. Currently
both (normal and EzPort) interfaces are simply exposed to userspace.
This does not work for the EzPort, since EzPort usage requires a device
reset. The proper solution is to do the flashing from kernel space
with properly timed toggling of EzPort chip-select and reset line. In
PATCHv2 it was suggested, that this should happen via an SPI ancillary
device, so this is how it has been implemented now. The SPI core
changes have been applied in PATCHv5 and are part of v5.14-rc1.

Changes since PATCHv6:
 * https://lore.kernel.org/lkml/20210712150242.146545-1-sebastian.reichel@collabora.com/
 * use kstrtoul() in sysfs store routines
 * merge nxp-ezport.c into gehc-achc.c
 * reword commit message

Changes since PATCHv5:
 * https://lore.kernel.org/lkml/20210621175359.126729-1-sebastian.reichel@collabora.com/
 * Rebased to v5.14-rc1
 * Fixed compilation as module
 * Dropped no longer needed module.h include from ezport code

Changes since PATCHv4:
 * https://lore.kernel.org/lkml/20210609151235.48964-1-sebastian.reichel@collabora.com/
 * Add Rob's Acked-by to ge-achc binding update
 * Don't use of_property_read_u32_index() in of_spi_parse_dt()
 * Don't build separate module for EzPort code
 * Use GPL2-only for the header
 * ACHC_MAX_FREQ -> ACHC_MAX_FREQ_HZ
 * Only accept '1' for the sysfs files, not any data
 * Update sysfs file documentation
 * Rebased to spi-next tree (b8f9dce0f4eb)

Changes since PATCHv3:
 * https://lore.kernel.org/lkml/20210528113346.37137-1-sebastian.reichel@collabora.com/
 * Add Rob's Acked-by to 2nd patch
 * use GPL-2-only instead of GPL-2+
 * use %zu for printing a size_t
 * use driver's .dev_groups to register sysfs group
 * Add sysfs property documentation
 * split EzPort and ACHC drivers into separate patches
 * drop minItems/maxItems from achc binding, which seems to fix the problems
   reported by dt_binding_check. The information of two items being required
   is implied by the explicit item list.
 * drop spidev functionality for the main SPI interface. The current firmware
   communicates via UART and adding spidev support is complex. If future firmware
   releases start using it, spidev support for the main interface can be added
   later.

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

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: misc: ge-achc: Convert to DT schema format
  ARM: dts: imx53-ppd: Fix ACHC entry
  misc: gehc-achc: new driver

 .../ABI/testing/sysfs-driver-ge-achc          |  14 +
 .../devicetree/bindings/misc/ge-achc.txt      |  26 -
 .../devicetree/bindings/misc/ge-achc.yaml     |  65 +++
 arch/arm/boot/dts/imx53-ppd.dts               |  23 +-
 drivers/misc/Kconfig                          |  11 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/gehc-achc.c                      | 542 ++++++++++++++++++
 drivers/spi/spidev.c                          |   1 -
 8 files changed, 646 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ge-achc
 delete mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.yaml
 create mode 100644 drivers/misc/gehc-achc.c

-- 
2.30.2

