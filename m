Return-Path: <linux-spi+bounces-9018-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1130AF652F
	for <lists+linux-spi@lfdr.de>; Thu,  3 Jul 2025 00:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB3522020
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85090246BC1;
	Wed,  2 Jul 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnLBfCzB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59268246798;
	Wed,  2 Jul 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495209; cv=none; b=E16YVudcQeyZne9d2O/UMbGyv6cHlZ4FBtAD/JRxh5kDD0CVmcgjN8YRcQUlQeUo7JLqvKx6GepN89pIORDXZkQIQKuvcw+co9yDVaSQUIUCjGA9deBUr0r4cCxRfdx6U5C0DYxyp0yEJdbPz3UQE798tIy1Wj/ZiNZwoWvgdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495209; c=relaxed/simple;
	bh=WEwAmw0sdYNez5L1vUl1rRfRRukQ9tqNIhTwwTy8CgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjYrqmkDtgtTClSmZhH3fq7ijt6cXAYYXqic9m7k07+izpmFrygUvxDZ0IJtsY+F8seQV7ug4L2mfJPwmPpDnyGUtXGnAat2eFvfYN83T3G8xTGlSA20t6GXTfMrnO9kgrT1BNcA+/9yBk89KprZOkR1sbZseMqe4Ic9XndDLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnLBfCzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D62C4CEE7;
	Wed,  2 Jul 2025 22:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751495208;
	bh=WEwAmw0sdYNez5L1vUl1rRfRRukQ9tqNIhTwwTy8CgM=;
	h=From:To:Cc:Subject:Date:From;
	b=RnLBfCzBsWfdRzYvZkbkp+iDzQd7Y0t2ZUXz8eQh9oKeyVP0Lad+EVL9srQlOg3xZ
	 bSWUGAR3B3AwqH1wureNffb/S7pKrETLsYFisuzfawOa1jBuaf0C8QcCM/+yNJZw3L
	 QCrQbn1RMrJG8vRy/7Ig2vHK6iriZ8av+wKeEFUtGRAvUa6A5uMf2Jv34PGoivyLG3
	 JKq4SDBvXzN8U/EhVT1k2czdORo+br7NcBdRg4hPwpp3+VRykprSXle3mK4uhvhU3e
	 +jgob49UI+kT9PEH1VwW/1cG3IAcC4uqRXLPGpMEuGg6QP54YQxKl2uIHeL1W7Pqo2
	 8v41FX4ragmbg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: Convert marvell,orion-spi to DT schema
Date: Wed,  2 Jul 2025 17:26:42 -0500
Message-ID: <20250702222643.2761617-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Marvell Orion SPI binding to schema.

Update compatible strings to what is in use. Generally,
"marvell,orion-spi" is a fallback compatible, but newer variants only
use "marvell,armada-380-spi".

Mark cell-index as deprecated and not required as some instances don't
use it already.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/spi/marvell,orion-spi.yaml       | 102 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-orion.txt     |  79 --------------
 2 files changed, 102 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/marvell,orion-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt

diff --git a/Documentation/devicetree/bindings/spi/marvell,orion-spi.yaml b/Documentation/devicetree/bindings/spi/marvell,orion-spi.yaml
new file mode 100644
index 000000000000..7f5ec1d7f59b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/marvell,orion-spi.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/marvell,orion-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Orion SPI controller
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+  - Gregory CLEMENT <gregory.clement@bootlin.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - marvell,orion-spi
+          - marvell,armada-380-spi  # For ap80x and cp11x
+      - items:
+          - enum:
+              - marvell,armada-370-spi
+              - marvell,armada-375-spi
+              - marvell,armada-380-spi
+              - marvell,armada-390-spi
+              - marvell,armada-xp-spi
+          - const: marvell,orion-spi
+
+  cell-index:
+    description: Instance id for the SPI controller
+    deprecated: true
+
+  reg:
+    minItems: 1
+    items:
+      - description: control registers
+      - description: CS0 MBUS target/attribute registers for direct mode
+      - description: CS1 MBUS target/attribute registers for direct mode
+      - description: CS2 MBUS target/attribute registers for direct mode
+      - description: CS3 MBUS target/attribute registers for direct mode
+      - description: CS4 MBUS target/attribute registers for direct mode
+      - description: CS5 MBUS target/attribute registers for direct mode
+      - description: CS6 MBUS target/attribute registers for direct mode
+      - description: CS7 MBUS target/attribute registers for direct mode
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: axi
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@10600 {
+      compatible = "marvell,orion-spi";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      cell-index = <0>;
+      reg = <0x10600 0x28>;
+      clocks = <&coreclk 0>;
+      interrupts = <23>;
+    };
+  - |
+    #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        spi@10600 {
+          compatible = "marvell,orion-spi";
+          #address-cells = <1>;
+          #size-cells = <0>;
+          cell-index = <0>;
+          reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>, /* control */
+                <MBUS_ID(0x01, 0x1e) 0 0xffffffff>, /* CS0 */
+                <MBUS_ID(0x01, 0x5e) 0 0xffffffff>, /* CS1 */
+                <MBUS_ID(0x01, 0x9e) 0 0xffffffff>, /* CS2 */
+                <MBUS_ID(0x01, 0xde) 0 0xffffffff>, /* CS3 */
+                <MBUS_ID(0x01, 0x1f) 0 0xffffffff>, /* CS4 */
+                <MBUS_ID(0x01, 0x5f) 0 0xffffffff>, /* CS5 */
+                <MBUS_ID(0x01, 0x9f) 0 0xffffffff>, /* CS6 */
+                <MBUS_ID(0x01, 0xdf) 0 0xffffffff>; /* CS7 */
+          clocks = <&coreclk 0>;
+          interrupts = <23>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
deleted file mode 100644
index 8434a65fc12a..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-Marvell Orion SPI device
-
-Required properties:
-- compatible : should be on of the following:
-    - "marvell,orion-spi" for the Orion, mv78x00, Kirkwood and Dove SoCs
-    - "marvell,armada-370-spi", for the Armada 370 SoCs
-    - "marvell,armada-375-spi", for the Armada 375 SoCs
-    - "marvell,armada-380-spi", for the Armada 38x SoCs
-    - "marvell,armada-390-spi", for the Armada 39x SoCs
-    - "marvell,armada-xp-spi", for the Armada XP SoCs
-- reg : offset and length of the register set for the device.
-	This property can optionally have additional entries to configure
-	the SPI direct access mode that some of the Marvell SoCs support
-	additionally to the normal indirect access (PIO) mode. The values
-	for the MBus "target" and "attribute" are defined in the Marvell
-	SoC "Functional Specifications" Manual in the chapter "Marvell
-	Core Processor Address Decoding".
-	The eight register sets following the control registers refer to
-	chip-select lines 0 through 7 respectively.
-- cell-index : Which of multiple SPI controllers is this.
-- clocks : pointers to the reference clocks for this device, the first
-	   one is the one used for the clock on the spi bus, the
-	   second one is optional and is the clock used for the
-	   functional part of the controller
-
-Optional properties:
-- interrupts : Is currently not used.
-- clock-names : names of used clocks, mandatory if the second clock is
-		used, the name must be "core", and "axi" (the latter
-		is only for Armada 7K/8K).
-
-
-Example:
-       spi@10600 {
-	       compatible = "marvell,orion-spi";
-	       #address-cells = <1>;
-	       #size-cells = <0>;
-	       cell-index = <0>;
-	       reg = <0x10600 0x28>;
-	       interrupts = <23>;
-       };
-
-Example with SPI direct mode support (optionally):
-	spi0: spi@10600 {
-		compatible = "marvell,orion-spi";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cell-index = <0>;
-		reg = <MBUS_ID(0xf0, 0x01) 0x10600 0x28>, /* control */
-		      <MBUS_ID(0x01, 0x1e) 0 0xffffffff>, /* CS0 */
-		      <MBUS_ID(0x01, 0x5e) 0 0xffffffff>, /* CS1 */
-		      <MBUS_ID(0x01, 0x9e) 0 0xffffffff>, /* CS2 */
-		      <MBUS_ID(0x01, 0xde) 0 0xffffffff>, /* CS3 */
-		      <MBUS_ID(0x01, 0x1f) 0 0xffffffff>, /* CS4 */
-		      <MBUS_ID(0x01, 0x5f) 0 0xffffffff>, /* CS5 */
-		      <MBUS_ID(0x01, 0x9f) 0 0xffffffff>, /* CS6 */
-		      <MBUS_ID(0x01, 0xdf) 0 0xffffffff>; /* CS7 */
-		interrupts = <23>;
-	};
-
-To enable the direct mode, the board specific 'ranges' property in the
-'soc' node needs to add the entries for the desired SPI controllers
-and its chip-selects that are used in the direct mode instead of PIO
-mode. Here an example for this (SPI controller 0, device 1 and SPI
-controller 1, device 2 are used in direct mode. All other SPI device
-are used in the default indirect (PIO) mode):
-	soc {
-		/*
-		 * Enable the SPI direct access by configuring an entry
-		 * here in the board-specific ranges property
-		 */
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000>,	/* internal regs */
-			 <MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>,	/* BootROM       */
-			 <MBUS_ID(0x01, 0x5e) 0 0 0xf1100000 0x10000>,	/* SPI0-DEV1 */
-			 <MBUS_ID(0x01, 0x9a) 0 0 0xf1110000 0x10000>;	/* SPI1-DEV2 */
-
-For further information on the MBus bindings, please see the MBus
-DT documentation:
-Documentation/devicetree/bindings/bus/mvebu-mbus.txt
-- 
2.47.2


