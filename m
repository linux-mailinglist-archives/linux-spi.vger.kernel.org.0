Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147A823B32
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2019 16:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbfETOvB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 May 2019 10:51:01 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48579 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732937AbfETOvB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 May 2019 10:51:01 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7AE9D24001C;
        Mon, 20 May 2019 14:50:38 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: spi: Add YAML schemas for the generic SPI options
Date:   Mon, 20 May 2019 16:50:33 +0200
Message-Id: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI controllers have a bunch of generic options that are needed in a
device tree. Add a YAML schemas for those.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v2:
  - Change the nodename pattern
  - Add a note to mention that the binding has moved

Changes from v1:
  - Rework the nodename pattern
  - Limit the index of the usable chip selects to 256
  - Rework the slave devices regex
  - Remove the requirement on #address-cells and #size-cells
  - Declare the slave and slave devices nodes as objects
  - Add spi-max-frequency
  - Fix the bus width range
---
 Documentation/devicetree/bindings/spi/spi-bus.txt         | 112 +-----
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 161 +++++++-
 2 files changed, 162 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-controller.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1f6e86f787ef..e07783505498 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -1,111 +1 @@
-SPI (Serial Peripheral Interface) busses
-
-SPI busses can be described with a node for the SPI controller device
-and a set of child nodes for each SPI slave on the bus.  The system's SPI
-controller may be described for use in SPI master mode or in SPI slave mode,
-but not for both at the same time.
-
-The SPI controller node requires the following properties:
-- compatible      - Name of SPI bus controller following generic names
-		    recommended practice.
-
-In master mode, the SPI controller node requires the following additional
-properties:
-- #address-cells  - number of cells required to define a chip select
-		address on the SPI bus.
-- #size-cells     - should be zero.
-
-In slave mode, the SPI controller node requires one additional property:
-- spi-slave       - Empty property.
-
-No other properties are required in the SPI bus node.  It is assumed
-that a driver for an SPI bus device will understand that it is an SPI bus.
-However, the binding does not attempt to define the specific method for
-assigning chip select numbers.  Since SPI chip select configuration is
-flexible and non-standardized, it is left out of this binding with the
-assumption that board specific platform code will be used to manage
-chip selects.  Individual drivers can define additional properties to
-support describing the chip select layout.
-
-Optional properties (master mode only):
-- cs-gpios	  - gpios chip select.
-- num-cs	  - total number of chipselects.
-
-If cs-gpios is used the number of chip selects will be increased automatically
-with max(cs-gpios > hw cs).
-
-So if for example the controller has 2 CS lines, and the cs-gpios
-property looks like this:
-
-cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
-
-Then it should be configured so that num_chipselect = 4 with the
-following mapping:
-
-cs0 : &gpio1 0 0
-cs1 : native
-cs2 : &gpio1 1 0
-cs3 : &gpio1 2 0
-
-
-SPI slave nodes must be children of the SPI controller node.
-
-In master mode, one or more slave nodes (up to the number of chip selects) can
-be present.  Required properties are:
-- compatible      - Name of SPI device following generic names recommended
-		    practice.
-- reg             - Chip select address of device.
-- spi-max-frequency - Maximum SPI clocking speed of device in Hz.
-
-In slave mode, the (single) slave node is optional.
-If present, it must be called "slave".  Required properties are:
-- compatible      - Name of SPI device following generic names recommended
-		    practice.
-
-All slave nodes can contain the following optional properties:
-- spi-cpol        - Empty property indicating device requires inverse clock
-		    polarity (CPOL) mode.
-- spi-cpha        - Empty property indicating device requires shifted clock
-		    phase (CPHA) mode.
-- spi-cs-high     - Empty property indicating device requires chip select
-		    active high.
-- spi-3wire       - Empty property indicating device requires 3-wire mode.
-- spi-lsb-first   - Empty property indicating device requires LSB first mode.
-- spi-tx-bus-width - The bus width (number of data wires) that is used for MOSI.
-		    Defaults to 1 if not present.
-- spi-rx-bus-width - The bus width (number of data wires) that is used for MISO.
-		    Defaults to 1 if not present.
-- spi-rx-delay-us - Microsecond delay after a read transfer.
-- spi-tx-delay-us - Microsecond delay after a write transfer.
-
-Some SPI controllers and devices support Dual and Quad SPI transfer mode.
-It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
-wires (QUAD).
-Now the value that spi-tx-bus-width and spi-rx-bus-width can receive is
-only 1 (SINGLE), 2 (DUAL) and 4 (QUAD).
-Dual/Quad mode is not allowed when 3-wire mode is used.
-
-If a gpio chipselect is used for the SPI slave the gpio number will be passed
-via the SPI master node cs-gpios property.
-
-SPI example for an MPC5200 SPI bus:
-	spi@f00 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
-		reg = <0xf00 0x20>;
-		interrupts = <2 13 0 2 14 0>;
-		interrupt-parent = <&mpc5200_pic>;
-
-		ethernet-switch@0 {
-			compatible = "micrel,ks8995m";
-			spi-max-frequency = <1000000>;
-			reg = <0>;
-		};
-
-		codec@1 {
-			compatible = "ti,tlv320aic26";
-			spi-max-frequency = <100000>;
-			reg = <1>;
-		};
-	};
+This file has moved to spi-controller.yaml.
diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
new file mode 100644
index 000000000000..876c0623f322
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI Controller Generic Binding
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+description: |
+  SPI busses can be described with a node for the SPI controller device
+  and a set of child nodes for each SPI slave on the bus. The system SPI
+  controller may be described for use in SPI master mode or in SPI slave mode,
+  but not for both at the same time.
+
+properties:
+  $nodename:
+    pattern: "^spi(@.*|-[0-9a-f])*$"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  cs-gpios:
+    description: |
+      GPIOs used as chip selects.
+      If that property is used, the number of chip selects will be
+      increased automatically with max(cs-gpios, hardware chip selects).
+
+      So if, for example, the controller has 2 CS lines, and the
+      cs-gpios looks like this
+        cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
+
+      Then it should be configured so that num_chipselect = 4, with
+      the following mapping
+        cs0 : &gpio1 0 0
+        cs1 : native
+        cs2 : &gpio1 1 0
+        cs3 : &gpio1 2 0
+
+  num-cs:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Total number of chip selects.
+
+  spi-slave:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The SPI controller acts as a slave, instead of a master.
+
+patternProperties:
+  "^slave$":
+    type: object
+
+    properties:
+      compatible:
+        description:
+          Compatible of the SPI device.
+
+    required:
+      - compatible
+
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      compatible:
+        description:
+          Compatible of the SPI device.
+
+      reg:
+        maxItems: 1
+        minimum: 0
+        maximum: 256
+        description:
+          Chip select used by the device.
+
+      spi-3wire:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires 3-wire mode.
+
+      spi-cpha:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires shifted clock phase (CPHA) mode.
+
+      spi-cpol:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires inverse clock polarity (CPOL) mode.
+
+      spi-cs-high:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires the chip select active high.
+
+      spi-lsb-first:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The device requires the LSB first mode.
+
+      spi-max-frequency:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Maximum SPI clocking speed of the device in Hz.
+
+      spi-rx-bus-width:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [ 1, 2, 4 ]
+          - default: 1
+        description:
+          Bus width to the SPI bus used for MISO.
+
+      spi-rx-delay-us:
+        description:
+          Delay, in microseconds, after a read transfer.
+
+      spi-tx-bus-width:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [ 1, 2, 4 ]
+          - default: 1
+        description:
+          Bus width to the SPI bus used for MOSI.
+
+      spi-tx-delay-us:
+        description:
+          Delay, in microseconds, after a write transfer.
+
+    required:
+      - compatible
+      - reg
+
+examples:
+  - |
+    spi@f00 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+        reg = <0xf00 0x20>;
+        interrupts = <2 13 0 2 14 0>;
+        interrupt-parent = <&mpc5200_pic>;
+
+        ethernet-switch@0 {
+            compatible = "micrel,ks8995m";
+            spi-max-frequency = <1000000>;
+            reg = <0>;
+        };
+
+        codec@1 {
+            compatible = "ti,tlv320aic26";
+            spi-max-frequency = <100000>;
+            reg = <1>;
+        };
+    };

base-commit: a188339ca5a396acc588e5851ed7e19f66b0ebd9
-- 
git-series 0.9.1
