Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDDF3B8379
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 15:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhF3Ntp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 09:49:45 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:47846 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhF3Ntp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Jun 2021 09:49:45 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 73827D5782;
        Wed, 30 Jun 2021 21:47:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12363T139710748759808S1625060824073628_;
        Wed, 30 Jun 2021 21:47:07 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e3d4488db0417f1de930b584c7e26e23>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-spi@vger.kernel.org
X-RCPT-COUNT: 20
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v10 01/10] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
Date:   Wed, 30 Jun 2021 21:46:53 +0800
Message-Id: <20210630134702.7346-2-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630134702.7346-1-jon.lin@rock-chips.com>
References: <20210630134702.7346-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add bindings for the Rockchip serial flash controller. New device
specific parameter of rockchip,sfc-no-dma included in documentation.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v10: None
Changes in v9: None
Changes in v8:
- Fix indent 4 to 2 in yaml

Changes in v7:
- Fix up the sclk_sfc parent error in rk3036
- Unify to "rockchip,sfc" compatible id because all the feature update
  will have a new IP version, so the driver is used for the SFC IP in
  all SoCs
- Change to use node "sfc" to name the SFC pinctrl group
- Add subnode reg property check
- Add rockchip_sfc_adjust_op_size to workaround in CMD + DUMMY case
- Limit max_iosize to 32KB

Changes in v6:
- Add support in device trees for rv1126(Declared in series 5 but not
  submitted)
- Change to use "clk_sfc" "hclk_sfc" as clock lable, since it does not
  affect interpretation and has been widely used
- Support sfc tx_dual, tx_quad(Declared in series 5 but not submitted)
- Simplify the code, such as remove "rockchip_sfc_register_all"(Declared
  in series 5 but not submitted)
- Support SFC ver4 ver5(Declared in series 5 but not submitted)
- Add author Chris Morgan and Jon Lin to spi-rockchip-sfc.c
- Change to use devm_spi_alloc_master and spi_unregister_master

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

 .../devicetree/bindings/spi/rockchip-sfc.yaml | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml

diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
new file mode 100644
index 000000000000..162993a97290
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/rockchip-sfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Serial Flash Controller (SFC)
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+  - Chris Morgan <macromorgan@hotmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,sfc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: clk_sfc
+      - const: hclk_sfc
+
+  power-domains:
+    maxItems: 1
+
+  rockchip,sfc-no-dma:
+    description: Disable DMA and utilize FIFO mode only
+    type: boolean
+
+patternProperties:
+  "^flash@[0-3]$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/px30-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/px30-power.h>
+
+    sfc: spi@ff3a0000 {
+        compatible = "rockchip,sfc";
+        reg = <0xff3a0000 0x4000>;
+        interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+        clock-names = "clk_sfc", "hclk_sfc";
+        pinctrl-0 = <&sfc_clk &sfc_cs &sfc_bus2>;
+        pinctrl-names = "default";
+        power-domains = <&power PX30_PD_MMC_NAND>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <108000000>;
+            spi-rx-bus-width = <2>;
+            spi-tx-bus-width = <2>;
+        };
+    };
+
+...
-- 
2.17.1



