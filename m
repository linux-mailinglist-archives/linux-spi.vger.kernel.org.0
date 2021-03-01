Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ACF327B89
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 11:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhCAKGm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 05:06:42 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51106 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232039AbhCAKGK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 05:06:10 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D1ED4200441;
        Mon,  1 Mar 2021 11:04:27 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF476200427;
        Mon,  1 Mar 2021 11:04:23 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CE1CC40291;
        Mon,  1 Mar 2021 11:04:18 +0100 (CET)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH] dt-bindings: spi: Convert NXP flexspi to json schema
Date:   Mon,  1 Mar 2021 15:34:06 +0530
Message-Id: <1614593046-23832-1-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the NXP FlexSPI binding to DT schema format using json-schema.
Also, update MAINTAINERS to reflect the change.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 .../bindings/spi/nxp,spi-nxp-fspi.yaml        | 101 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-nxp-fspi.txt  |  42 --------
 MAINTAINERS                                   |   2 +-
 3 files changed, 102 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
new file mode 100644
index 000000000000..56598b87ba15
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,spi-nxp-fspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Flex Serial Peripheral Interface (FSPI)
+
+maintainers:
+  - Ashish Kumar <ashish.kumar@nxp.com>
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nxp,lx2160a-fspi
+      - nxp,imx8qxp-fspi
+      - nxp,imx8mm-fspi
+      - nxp,imx8dxl-fspi
+
+  reg:
+    items:
+      - description: registers
+      - description: memory mapping
+
+  reg-names:
+    items:
+      - const: fspi_base
+      - const: fspi_mmap
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+    items:
+      - description: SoC SPI fspi_en clock
+      - description: SoC SPI fspi clock
+
+  clock-names:
+    items:
+      - const: fspi_en
+      - const: fspi
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@20c0000 {
+      compatible = "nxp,lx2160a-fspi";
+      reg = <0x0 0x20c0000 0x0 0x100000>, <0x0 0x20000000 0x0 0x10000>;
+      reg-names = "fspi_base", "fspi_mmap";
+      interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(4)>,
+               <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(4)>,
+      clock-names = "fspi_en", "fspi";
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      flash@0 {
+        compatible = "jedec,spi-nor";
+        spi-max-frequency = <50000000>;
+        reg = <0>;
+        spi-rx-bus-width = <8>;
+        spi-tx-bus-width = <8>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@30bb0000 {
+      compatible = "nxp,imx8mm-fspi";
+      reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
+      reg-names = "fspi_base", "fspi_mmap";
+      interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk IMX8MM_CLK_QSPI_ROOT>,
+               <&clk IMX8MM_CLK_QSPI_ROOT>;
+      clock-names = "fspi", "fspi_en";
+
+      flash@0 {
+        compatible = "jedec,spi-nor";
+        spi-max-frequency = <80000000>;
+        reg = <0>;
+        spi-rx-bus-width = <4>;
+        spi-tx-bus-width = <4>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
deleted file mode 100644
index 7ac60d9fe357..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-* NXP Flex Serial Peripheral Interface (FSPI)
-
-Required properties:
-  - compatible : Should be "nxp,lx2160a-fspi"
-			    "nxp,imx8qxp-fspi"
-			    "nxp,imx8mm-fspi"
-
-  - reg :        First contains the register location and length,
-                 Second contains the memory mapping address and length
-  - reg-names :  Should contain the resource reg names:
-	         - fspi_base: configuration register address space
-                 - fspi_mmap: memory mapped address space
-  - interrupts : Should contain the interrupt for the device
-
-Required SPI slave node properties:
-  - reg :        There are two buses (A and B) with two chip selects each.
-                 This encodes to which bus and CS the flash is connected:
-                 - <0>: Bus A, CS 0
-                 - <1>: Bus A, CS 1
-                 - <2>: Bus B, CS 0
-                 - <3>: Bus B, CS 1
-
-Example showing the usage of two SPI NOR slave devices on bus A:
-
-fspi0: spi@20c0000 {
-	compatible = "nxp,lx2160a-fspi";
-	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
-	reg-names = "fspi_base", "fspi_mmap";
-	interrupts = <0 25 0x4>; /* Level high type */
-	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
-	clock-names = "fspi_en", "fspi";
-
-	mt35xu512aba0: flash@0 {
-		reg = <0>;
-		....
-	};
-
-	mt35xu512aba1: flash@1 {
-		reg = <1>;
-		....
-	};
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index f9d462c8f4d6..9179722cff2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12731,7 +12731,7 @@ M:	Ashish Kumar <ashish.kumar@nxp.com>
 R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+F:	Documentation/devicetree/bindings/spi/nxp,spi-nxp-fspi.yaml
 F:	drivers/spi/spi-nxp-fspi.c
 
 NXP FXAS21002C DRIVER
-- 
2.25.1

