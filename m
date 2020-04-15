Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CFC1AAFBD
	for <lists+linux-spi@lfdr.de>; Wed, 15 Apr 2020 19:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411183AbgDORbj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Apr 2020 13:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411172AbgDORbe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5F3D2076D;
        Wed, 15 Apr 2020 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971892;
        bh=Q+cQLTLYqEnr0ODnP1UgJ/lLN0GED+XfKIE4VzHQtzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2HkilS1AnLgNFrpcMhPnKdV7tR4loJfQtvZuPUjbX4OqDsn9SoerPBDznoM4P8Evz
         WKyyYXLurIdwrZyAzfIM338AHH/w5tr8b8dZy2t/jfNpjqmFvnbqCKMXhdhva/BreP
         9muTxtMsbxxd0eDVr/qJKS1Hgd1Nuh9vOfhozHrw=
Date:   Wed, 15 Apr 2020 18:31:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "spi: dt-bindings: rspi: Convert to json-schema" to the spi tree
In-Reply-To:  <20200408091129.25429-1-geert+renesas@glider.be>
Message-Id:  <applied-20200408091129.25429-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: dt-bindings: rspi: Convert to json-schema

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 999866c92f4a333cb776c3e87831feeddef74f96 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 8 Apr 2020 11:11:29 +0200
Subject: [PATCH] spi: dt-bindings: rspi: Convert to json-schema

Convert the Renesas (Quad) Serial Peripheral Interface (RSPI/QSPI)
Device Tree binding documentation to json-schema.

Document missing properties.
Update the second example to match reality.
Drop the first example, as it doesn't add much value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200408091129.25429-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/renesas,rspi.yaml | 144 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-rspi.txt      |  73 ---------
 2 files changed, 144 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-rspi.txt

diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
new file mode 100644
index 000000000000..c54ac059043f
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
index 421722b93992..000000000000
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
2.20.1

