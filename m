Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF439DCC0
	for <lists+linux-spi@lfdr.de>; Mon,  7 Jun 2021 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFGMp2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 08:45:28 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:58756 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFGMp1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 08:45:27 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4B1A0ACF59;
        Mon,  7 Jun 2021 20:43:06 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32529T140357073352448S1623069785962833_;
        Mon, 07 Jun 2021 20:43:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ca5a451e771ae9e94fdfe0a1b4d8edc5>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-spi@vger.kernel.org
X-RCPT-COUNT: 16
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] Add Rockchip SFC(serial flash controller) support
Date:   Mon,  7 Jun 2021 20:42:55 +0800
Message-Id: <20210607124303.22393-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Changes in v5:
- Add support in device trees for rv1126
- Support sfc tx_dual, tx_quad
- Simplify the code, such as remove "rockchip_sfc_register_all"
- Support SFC ver4 ver5

Changes in v4:
- Changing patch back to an "RFC". An engineer from Rockchip
  reached out to me to let me know they are working on this patch for
  upstream, I am submitting this v4 for the community to see however
  I expect Jon Lin (jon.lin@rock-chips.com) will submit new patches
  soon and these are the ones we should pursue for mainlining. Jon's
  patch series should include support for more hardware than this
  series.
- Clean up documentation more and ensure it is correct per
  make dt_binding_check.
- Add support in device trees for rk3036, rk3308, and rv1108.
- Add ahb clock (hclk_sfc) support for rk3036.
- Change rockchip_sfc_wait_fifo_ready() to use a switch statement.
- Change IRQ code to only mark IRQ as handled if it handles the
  specific IRQ (DMA transfer finish) it is supposed to handle.

Changes in v3:
- Changed the name of the clocks to sfc/ahb (from clk-sfc/clk-hsfc).
- Changed the compatible string from rockchip,sfc to
  rockchip,rk3036-sfc. A quick glance at the datasheets suggests this
  driver should work for the PX30, RK180x, RK3036, RK312x, RK3308 and
  RV1108 SoCs, and possibly more. However, I am currently only able
  to test this on a PX30 (an RK3326). The technical reference manuals
  appear to list the same registers for each device.
- Corrected devicetree documentation for formatting and to note these
  changes.
- Replaced the maintainer with Heiko Stuebner and myself, as we will
  take ownership of this going forward.
- Noted that the device (per the reference manual) supports 4 CS, but
  I am only able to test a single CS (CS 0).
- Reordered patches to comply with upstream rules.

Changes in v2:
- Reimplemented driver using spi-mem subsystem.
- Removed power management code as I couldn't get it working properly.
- Added device tree bindings for Odroid Go Advance.

Changes in v1:
hanges made in this new series versus the v8 of the old series:
- Added function to read spi-rx-bus-width from device tree, in the
  event that the SPI chip supports 4x mode but only has 2 pins
  wired (such as the Odroid Go Advance).
- Changed device tree documentation from txt to yaml format.
- Made "reset" message a dev_dbg from a dev_info.
- Changed read and write fifo functions to remove redundant checks.
- Changed the write and read from relaxed to non-relaxed when
  starting the DMA transfer or reading the DMA IRQ.
- Changed from dma_coerce_mask_and_coherent to just
  dma_set_mask_and_coherent.
- Changed name of get_if_type to rockchip_sfc_get_if_type.

Chris Morgan (8):
  dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash
    controller
  spi: rockchip-sfc: add rockchip serial flash controller
  arm64: dts: rockchip: Add SFC to PX30
  clk: rockchip: Add support for hclk_sfc on rk3036
  arm: dts: rockchip: Add SFC to RK3036
  arm: dts: rockchip: Add SFC to RV1108
  arm64: dts: rockchip: Add SFC to RK3308
  arm64: dts: rockchip: Enable SFC for Odroid Go Advance

 .../devicetree/bindings/spi/rockchip-sfc.yaml |  86 ++
 arch/arm/boot/dts/rk3036.dtsi                 |  42 +
 arch/arm/boot/dts/rv1108.dtsi                 |  37 +
 arch/arm64/boot/dts/rockchip/px30.dtsi        |  38 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  37 +
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   |  16 +
 drivers/clk/rockchip/clk-rk3036.c             |   2 +-
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rockchip-sfc.c                | 863 ++++++++++++++++++
 include/dt-bindings/clock/rk3036-cru.h        |   1 +
 11 files changed, 1131 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
 create mode 100644 drivers/spi/spi-rockchip-sfc.c

-- 
2.17.1



