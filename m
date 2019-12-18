Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8301252AD
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2019 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLRUGn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Dec 2019 15:06:43 -0500
Received: from foss.arm.com ([217.140.110.172]:59542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfLRUGn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 18 Dec 2019 15:06:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E419D1FB;
        Wed, 18 Dec 2019 12:06:42 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE5D3F67D;
        Wed, 18 Dec 2019 12:06:42 -0800 (PST)
Date:   Wed, 18 Dec 2019 20:06:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     alexandre.torgue@st.com, Amelie Delaunay <amelie.delaunay@st.com>,
        broonie@kernel.org, devicetree@vger.kernel.org,
        Erwan Leray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Applied "dt-bindings: spi: Convert stm32 spi bindings to json-schema" to the spi tree
In-Reply-To: <20191217090715.13334-1-benjamin.gaignard@st.com>
Message-Id: <applied-20191217090715.13334-1-benjamin.gaignard@st.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-bindings: spi: Convert stm32 spi bindings to json-schema

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

From ef32b63bf13e531479a3b1ef6eb2daaf4fcf787a Mon Sep 17 00:00:00 2001
From: Benjamin Gaignard <benjamin.gaignard@st.com>
Date: Tue, 17 Dec 2019 10:07:15 +0100
Subject: [PATCH] dt-bindings: spi: Convert stm32 spi bindings to json-schema

Convert the STM32 spi binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
CC: Erwan Leray <erwan.leray@st.com>
CC: Fabrice Gasnier <fabrice.gasnier@st.com>
CC: Amelie Delaunay <amelie.delaunay@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191217090715.13334-1-benjamin.gaignard@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-stm32.txt     |  62 -----------
 .../devicetree/bindings/spi/st,stm32-spi.yaml | 105 ++++++++++++++++++
 2 files changed, 105 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
deleted file mode 100644
index d82755c63eaf..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-STMicroelectronics STM32 SPI Controller
-
-The STM32 SPI controller is used to communicate with external devices using
-the Serial Peripheral Interface. It supports full-duplex, half-duplex and
-simplex synchronous serial communication with external devices. It supports
-from 4 to 32-bit data size. Although it can be configured as master or slave,
-only master is supported by the driver.
-
-Required properties:
-- compatible: Should be one of:
-  "st,stm32h7-spi"
-  "st,stm32f4-spi"
-- reg: Offset and length of the device's register set.
-- interrupts: Must contain the interrupt id.
-- clocks: Must contain an entry for spiclk (which feeds the internal clock
-	  generator).
-- #address-cells:  Number of cells required to define a chip select address.
-- #size-cells: Should be zero.
-
-Optional properties:
-- resets: Must contain the phandle to the reset controller.
-- A pinctrl state named "default" may be defined to set pins in mode of
-  operation for SPI transfer.
-- dmas: DMA specifiers for tx and rx dma. DMA fifo mode must be used. See the
-  STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt.
-- dma-names: DMA request names should include "tx" and "rx" if present.
-- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
-  Documentation/devicetree/bindings/spi/spi-bus.txt
-
-
-Child nodes represent devices on the SPI bus
-  See ../spi/spi-bus.txt
-
-Optional properties:
-- st,spi-midi-ns: Only for STM32H7, (Master Inter-Data Idleness) minimum time
-		  delay in nanoseconds inserted between two consecutive data
-		  frames.
-
-
-Example:
-	spi2: spi@40003800 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "st,stm32h7-spi";
-		reg = <0x40003800 0x400>;
-		interrupts = <36>;
-		clocks = <&rcc SPI2_CK>;
-		resets = <&rcc 1166>;
-		dmas = <&dmamux1 0 39 0x400 0x01>,
-		       <&dmamux1 1 40 0x400 0x01>;
-		dma-names = "rx", "tx";
-		pinctrl-0 = <&spi2_pins_b>;
-		pinctrl-names = "default";
-		cs-gpios = <&gpioa 11 0>;
-
-		aardvark@0 {
-			compatible = "totalphase,aardvark";
-			reg = <0>;
-			spi-max-frequency = <4000000>;
-			st,spi-midi-ns = <4000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
new file mode 100644
index 000000000000..f0d979664f07
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/st,stm32-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 SPI Controller bindings
+
+description: |
+  The STM32 SPI controller is used to communicate with external devices using
+  the Serial Peripheral Interface. It supports full-duplex, half-duplex and
+  simplex synchronous serial communication with external devices. It supports
+  from 4 to 32-bit data size.
+
+maintainers:
+  - Erwan Leray <erwan.leray@st.com>
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32f4-spi
+
+    then:
+      properties:
+        st,spi-midi-ns: false
+
+properties:
+  compatible:
+    enum:
+      - st,stm32f4-spi
+      - st,stm32h7-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    description: |
+      DMA specifiers for tx and rx dma. DMA fifo mode must be used. See
+      the STM32 DMA bindings Documentation/devicetree/bindings/dma/stm32-dma.txt.
+    items:
+      - description: rx DMA channel
+      - description: tx DMA channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+patternProperties:
+  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
+    type: object
+    # SPI slave nodes must be children of the SPI master node and can
+    # contain the following properties.
+    properties:
+      st,spi-midi-ns:
+        description: |
+          Only for STM32H7, (Master Inter-Data Idleness) minimum time
+          delay in nanoseconds inserted between two consecutive data frames.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    spi@4000b000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "st,stm32h7-spi";
+      reg = <0x4000b000 0x400>;
+      interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&rcc SPI2_K>;
+      resets = <&rcc SPI2_R>;
+      dmas = <&dmamux1 0 39 0x400 0x05>,
+             <&dmamux1 1 40 0x400 0x05>;
+      dma-names = "rx", "tx";
+      cs-gpios = <&gpioa 11 0>;
+
+      aardvark@0 {
+        compatible = "totalphase,aardvark";
+        reg = <0>;
+        spi-max-frequency = <4000000>;
+        st,spi-midi-ns = <4000>;
+      };
+    };
+
+...
-- 
2.20.1

