Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7B1A1DEB
	for <lists+linux-spi@lfdr.de>; Wed,  8 Apr 2020 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDHJLe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Apr 2020 05:11:34 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:47124 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHJLe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Apr 2020 05:11:34 -0400
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id Q9BW2200E5USYZQ019BWsm; Wed, 08 Apr 2020 11:11:30 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jM6k6-0002mu-Ey; Wed, 08 Apr 2020 11:11:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jM6k6-0006cu-Dh; Wed, 08 Apr 2020 11:11:30 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: dt-bindings: rspi: Convert to json-schema
Date:   Wed,  8 Apr 2020 11:11:29 +0200
Message-Id: <20200408091129.25429-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the Renesas (Quad) Serial Peripheral Interface (RSPI/QSPI)
Device Tree binding documentation to json-schema.

Document missing properties.
Update the second example to match reality.
Drop the first example, as it doesn't add much value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/spi/renesas,rspi.yaml | 144 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-rspi.txt      |  73 ---------
 2 files changed, 144 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-rspi.txt

diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
new file mode 100644
index 0000000000000000..c54ac059043f6599
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/renesas,rspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas (Quad) Serial Peripheral Interface (RSPI/QSPI)
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,rspi-sh7757    # SH7757
+          - const: renesas,rspi        # Legacy SH
+
+      - items:
+          - enum:
+              - renesas,rspi-r7s72100  # RZ/A1H
+              - renesas,rspi-r7s9210   # RZ/A2
+          - const: renesas,rspi-rz     # RZ/A
+
+      - items:
+          - enum:
+              - renesas,qspi-r8a7743   # RZ/G1M
+              - renesas,qspi-r8a7744   # RZ/G1N
+              - renesas,qspi-r8a7745   # RZ/G1E
+              - renesas,qspi-r8a77470  # RZ/G1C
+              - renesas,qspi-r8a7790   # R-Car H2
+              - renesas,qspi-r8a7791   # R-Car M2-W
+              - renesas,qspi-r8a7792   # R-Car V2H
+              - renesas,qspi-r8a7793   # R-Car M2-N
+              - renesas,qspi-r8a7794   # R-Car E2
+          - const: renesas,qspi        # R-Car Gen2 and RZ/G1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    oneOf:
+      - items:
+          - description: A combined interrupt
+      - items:
+          - description: Error interrupt (SPEI)
+          - description: Receive Interrupt (SPRI)
+          - description: Transmit Interrupt (SPTI)
+
+  interrupt-names:
+    oneOf:
+      - items:
+          - const: mux
+      - items:
+          - const: error
+          - const: rx
+          - const: tx
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    description:
+      Must contain a list of pairs of references to DMA specifiers, one for
+      transmission, and one for reception.
+
+  dma-names:
+    minItems: 2
+    maxItems: 4
+    items:
+      enum:
+        - tx
+        - rx
+
+  num-cs:
+    description: |
+      Total number of native chip selects.
+      Hardware limitations related to chip selects:
+        - When using GPIO chip selects, at least one native chip select must
+          be left unused, as it will be driven anyway.
+    minimum: 1
+    maximum: 2
+    default: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - power-domains
+  - '#address-cells'
+  - '#size-cells'
+
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rspi-rz
+    then:
+      properties:
+        interrupts:
+          minItems: 3
+      required:
+        - interrupt-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,qspi
+    then:
+      required:
+        - resets
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7791-sysc.h>
+
+    qspi: spi@e6b10000 {
+            compatible = "renesas,qspi-r8a7791", "renesas,qspi";
+            reg = <0xe6b10000 0x2c>;
+            interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD 917>;
+            dmas = <&dmac0 0x17>, <&dmac0 0x18>, <&dmac1 0x17>, <&dmac1 0x18>;
+            dma-names = "tx", "rx", "tx", "rx";
+            power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+            resets = <&cpg 917>;
+            num-cs = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
deleted file mode 100644
index 421722b939922352..0000000000000000
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-Device tree configuration for Renesas RSPI/QSPI driver
-
-Required properties:
-- compatible       : For Renesas Serial Peripheral Interface on legacy SH:
-		     "renesas,rspi-<soctype>", "renesas,rspi" as fallback.
-		     For Renesas Serial Peripheral Interface on RZ/A:
-		     "renesas,rspi-<soctype>", "renesas,rspi-rz" as fallback.
-		     For Quad Serial Peripheral Interface on R-Car Gen2 and
-		     RZ/G1 devices:
-		     "renesas,qspi-<soctype>", "renesas,qspi" as fallback.
-		     Examples with soctypes are:
-		        - "renesas,rspi-sh7757" (SH)
-			- "renesas,rspi-r7s72100" (RZ/A1H)
-			- "renesas,rspi-r7s9210" (RZ/A2)
-			- "renesas,qspi-r8a7743" (RZ/G1M)
-			- "renesas,qspi-r8a7744" (RZ/G1N)
-			- "renesas,qspi-r8a7745" (RZ/G1E)
-			- "renesas,qspi-r8a77470" (RZ/G1C)
-			- "renesas,qspi-r8a7790" (R-Car H2)
-			- "renesas,qspi-r8a7791" (R-Car M2-W)
-			- "renesas,qspi-r8a7792" (R-Car V2H)
-			- "renesas,qspi-r8a7793" (R-Car M2-N)
-			- "renesas,qspi-r8a7794" (R-Car E2)
-- reg              : Address start and address range size of the device
-- interrupts       : A list of interrupt-specifiers, one for each entry in
-		     interrupt-names.
-		     If interrupt-names is not present, an interrupt specifier
-		     for a single muxed interrupt.
-- interrupt-names  : A list of interrupt names. Should contain (if present):
-		       - "error" for SPEI,
-		       - "rx" for SPRI,
-		       - "tx" to SPTI,
-		       - "mux" for a single muxed interrupt.
-- num-cs	   : Number of chip selects. Some RSPI cores have more than 1.
-- #address-cells   : Must be <1>
-- #size-cells      : Must be <0>
-
-Optional properties:
-- clocks           : Must contain a reference to the functional clock.
-- dmas             : Must contain a list of two references to DMA specifiers,
-		     one for transmission, and one for reception.
-- dma-names        : Must contain a list of two DMA names, "tx" and "rx".
-
-Pinctrl properties might be needed, too.  See
-Documentation/devicetree/bindings/pinctrl/renesas,*.
-
-Examples:
-
-	spi0: spi@e800c800 {
-		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
-		reg = <0xe800c800 0x24>;
-		interrupts = <0 238 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error", "rx", "tx";
-		interrupt-parent = <&gic>;
-		num-cs = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	spi: spi@e6b10000 {
-		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
-		reg = <0 0xe6b10000 0 0x2c>;
-		interrupt-parent = <&gic>;
-		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
-		num-cs = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
-		dma-names = "tx", "rx";
-	};
-- 
2.17.1

