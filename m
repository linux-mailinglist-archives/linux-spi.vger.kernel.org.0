Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC44BEF84
	for <lists+linux-spi@lfdr.de>; Thu, 26 Sep 2019 12:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfIZKZk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Sep 2019 06:25:40 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:54944 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfIZKZk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Sep 2019 06:25:40 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B74A525AF0D;
        Thu, 26 Sep 2019 20:25:37 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B1EDF943750; Thu, 26 Sep 2019 12:25:35 +0200 (CEST)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] dt-bindings: spi: sh-msiof: Convert bindings to json-schema
Date:   Thu, 26 Sep 2019 12:25:33 +0200
Message-Id: <20190926102533.17829-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert Renesas HSPI bindings documentation to json-schema.
Also name bindings documentation file according to the compat string
being documented.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on v5.3
Tested using:
  ARCH=arm   make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
  ARCH=arm64 make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
---
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  | 158 +++++++++++++++++++++
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 105 --------------
 2 files changed, 158 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/sh-msiof.txt

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
new file mode 100644
index 000000000000..4afaa48c1666
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/renesas,sh-msiof.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas MSIOF SPI controller
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: renesas,msiof-sh73a0     # SH-Mobile AG5
+          - const: renesas,sh-mobile-msiof  # generic SH-Mobile compatible
+                                            # device
+      - items:
+          - enum:
+              - renesas,msiof-r8a7743       # RZ/G1M
+              - renesas,msiof-r8a7744       # RZ/G1N
+              - renesas,msiof-r8a7745       # RZ/G1E
+              - renesas,msiof-r8a77470      # RZ/G1C
+              - renesas,msiof-r8a7790       # R-Car H2
+              - renesas,msiof-r8a7791       # R-Car M2-W
+              - renesas,msiof-r8a7792       # R-Car V2H
+              - renesas,msiof-r8a7793       # R-Car M2-N
+              - renesas,msiof-r8a7794       # R-Car E2
+          - const: renesas,rcar-gen2-msiof  # generic R-Car Gen2 and RZ/G1
+                                            # compatible device
+      - items:
+          - enum:
+              - renesas,msiof-r8a774a1      # RZ/G2M
+              - renesas,msiof-r8a774c0      # RZ/G2E
+              - renesas,msiof-r8a7795       # R-Car H3
+              - renesas,msiof-r8a7796       # R-Car M3-W
+              - renesas,msiof-r8a77965      # R-Car M3-N
+              - renesas,msiof-r8a77970      # R-Car V3M
+              - renesas,msiof-r8a77980      # R-Car V3H
+              - renesas,msiof-r8a77990      # R-Car E3
+              - renesas,msiof-r8a77995      # R-Car D3
+          - const: renesas,rcar-gen3-msiof  # generic R-Car Gen3 and RZ/G2
+                                            # compatible device
+      - items:
+          - const: renesas,sh-msiof  # deprecated
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    oneOf:
+      - items:
+          - description: CPU and DMA engine registers
+      - items:
+          - description: CPU registers
+          - description: DMA engine registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  num-cs:
+    description: |
+      Total number of chip selects (default is 1).
+      Up to 3 native chip selects are supported:
+        0: MSIOF_SYNC
+        1: MSIOF_SS1
+        2: MSIOF_SS2
+      Hardware limitations related to chip selects:
+        - Native chip selects are always deasserted in between transfers
+          that are part of the same message.  Use cs-gpios to work around
+          this.
+        - All slaves using native chip selects must use the same spi-cs-high
+          configuration.  Use cs-gpios to work around this.
+        - When using GPIO chip selects, at least one native chip select must
+          be left unused, as it will be driven anyway.
+    minimum: 1
+    maximum: 3
+    default: 1
+
+  dmas:
+    minItems: 2
+    maxItems: 4
+
+  dma-names:
+    minItems: 2
+    maxItems: 4
+    items:
+      enum: [ tx, rx ]
+
+  renesas,dtdl:
+    description: delay sync signal (setup) in transmit mode.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum:
+          - 0    # no bit delay
+          - 50   # 0.5-clock-cycle delay
+          - 100  # 1-clock-cycle delay
+          - 150  # 1.5-clock-cycle delay
+          - 200  # 2-clock-cycle delay
+
+  renesas,syncdl:
+    description: delay sync signal (hold) in transmit mode
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum:
+          - 0    # no bit delay
+          - 50   # 0.5-clock-cycle delay
+          - 100  # 1-clock-cycle delay
+          - 150  # 1.5-clock-cycle delay
+          - 200  # 2-clock-cycle delay
+          - 300  # 3-clock-cycle delay
+
+  renesas,tx-fifo-size:
+    # deprecated for soctype-specific bindings
+    description: |
+      Override the default TX fifo size.  Unit is words.  Ignored if 0.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - maxItems: 1
+    default: 64
+
+  renesas,rx-fifo-size:
+    # deprecated for soctype-specific bindings
+    description: |
+      Override the default RX fifo size.  Unit is words.  Ignored if 0.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - maxItems: 1
+    default: 64
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7791-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    msiof0: spi@e6e20000 {
+        compatible = "renesas,msiof-r8a7791", "renesas,rcar-gen2-msiof";
+        reg = <0 0xe6e20000 0 0x0064>;
+        interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
+        dmas = <&dmac0 0x51>, <&dmac0 0x52>;
+        dma-names = "tx", "rx";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
deleted file mode 100644
index 18e14ee257b2..000000000000
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ /dev/null
@@ -1,105 +0,0 @@
-Renesas MSIOF spi controller
-
-Required properties:
-- compatible           : "renesas,msiof-r8a7743" (RZ/G1M)
-			 "renesas,msiof-r8a7744" (RZ/G1N)
-			 "renesas,msiof-r8a7745" (RZ/G1E)
-			 "renesas,msiof-r8a77470" (RZ/G1C)
-			 "renesas,msiof-r8a774a1" (RZ/G2M)
-			 "renesas,msiof-r8a774c0" (RZ/G2E)
-			 "renesas,msiof-r8a7790" (R-Car H2)
-			 "renesas,msiof-r8a7791" (R-Car M2-W)
-			 "renesas,msiof-r8a7792" (R-Car V2H)
-			 "renesas,msiof-r8a7793" (R-Car M2-N)
-			 "renesas,msiof-r8a7794" (R-Car E2)
-			 "renesas,msiof-r8a7795" (R-Car H3)
-			 "renesas,msiof-r8a7796" (R-Car M3-W)
-			 "renesas,msiof-r8a77965" (R-Car M3-N)
-			 "renesas,msiof-r8a77970" (R-Car V3M)
-			 "renesas,msiof-r8a77980" (R-Car V3H)
-			 "renesas,msiof-r8a77990" (R-Car E3)
-			 "renesas,msiof-r8a77995" (R-Car D3)
-			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
-			 "renesas,sh-mobile-msiof" (generic SH-Mobile compatibile device)
-			 "renesas,rcar-gen2-msiof" (generic R-Car Gen2 and RZ/G1 compatible device)
-			 "renesas,rcar-gen3-msiof" (generic R-Car Gen3 and RZ/G2 compatible device)
-			 "renesas,sh-msiof"      (deprecated)
-
-			 When compatible with the generic version, nodes
-			 must list the SoC-specific version corresponding
-			 to the platform first followed by the generic
-			 version.
-
-- reg                  : A list of offsets and lengths of the register sets for
-			 the device.
-			 If only one register set is present, it is to be used
-			 by both the CPU and the DMA engine.
-			 If two register sets are present, the first is to be
-			 used by the CPU, and the second is to be used by the
-			 DMA engine.
-- interrupts           : Interrupt specifier
-- #address-cells       : Must be <1>
-- #size-cells          : Must be <0>
-
-Optional properties:
-- clocks               : Must contain a reference to the functional clock.
-- num-cs               : Total number of chip selects (default is 1).
-			 Up to 3 native chip selects are supported:
-			   0: MSIOF_SYNC
-			   1: MSIOF_SS1
-			   2: MSIOF_SS2
-			 Hardware limitations related to chip selects:
-			   - Native chip selects are always deasserted in
-			     between transfers that are part of the same
-			     message.  Use cs-gpios to work around this.
-			   - All slaves using native chip selects must use the
-			     same spi-cs-high configuration.  Use cs-gpios to
-			     work around this.
-			   - When using GPIO chip selects, at least one native
-			     chip select must be left unused, as it will be
-			     driven anyway.
-- dmas                 : Must contain a list of two references to DMA
-			 specifiers, one for transmission, and one for
-			 reception.
-- dma-names            : Must contain a list of two DMA names, "tx" and "rx".
-- spi-slave            : Empty property indicating the SPI controller is used
-			 in slave mode.
-- renesas,dtdl         : delay sync signal (setup) in transmit mode.
-			 Must contain one of the following values:
-			 0   (no bit delay)
-			 50  (0.5-clock-cycle delay)
-			 100 (1-clock-cycle delay)
-			 150 (1.5-clock-cycle delay)
-			 200 (2-clock-cycle delay)
-
-- renesas,syncdl       : delay sync signal (hold) in transmit mode.
-			 Must contain one of the following values:
-			 0   (no bit delay)
-			 50  (0.5-clock-cycle delay)
-			 100 (1-clock-cycle delay)
-			 150 (1.5-clock-cycle delay)
-			 200 (2-clock-cycle delay)
-			 300 (3-clock-cycle delay)
-
-Optional properties, deprecated for soctype-specific bindings:
-- renesas,tx-fifo-size : Overrides the default tx fifo size given in words
-			 (default is 64)
-- renesas,rx-fifo-size : Overrides the default rx fifo size given in words
-			 (default is 64)
-
-Pinctrl properties might be needed, too.  See
-Documentation/devicetree/bindings/pinctrl/renesas,*.
-
-Example:
-
-	msiof0: spi@e6e20000 {
-		compatible = "renesas,msiof-r8a7791",
-			     "renesas,rcar-gen2-msiof";
-		reg = <0 0xe6e20000 0 0x0064>;
-		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
-		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
-		dma-names = "tx", "rx";
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-- 
2.11.0

