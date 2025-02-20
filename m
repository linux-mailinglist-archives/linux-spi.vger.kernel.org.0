Return-Path: <linux-spi+bounces-6881-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5C0A3DA56
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 13:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA09019C0630
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2025 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CD81C8618;
	Thu, 20 Feb 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCqtXfko"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847579CD;
	Thu, 20 Feb 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055600; cv=none; b=UukhdS/zN8htDZiA32bkATu9lpcvwPX0v8B/QiB406y+CSOqBusZjUlxRqv3qocTrKbMy0uk2b8fGa0b1+7Nklo4fE1d1GC0UaOr92Mot09kvAcVhw+JfvV3zjGVNZWMtB0GVdmccpo74w7pMBOOLzac4Q8mSV12OW9a1u6Q4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055600; c=relaxed/simple;
	bh=g2f//fK8aq39T2Pf40WB9z+ft2RgJY8RkoVFTl07iro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a7zkPz/r+Tvp9nohsX9r8NSv/BdJ41uAco4G1o3bTe2PesvjZxxE/xmp7TPoFfKAbegNy57OCTENljyLaYyJx31QBx9NiqCCV6VdT7ccajCGG7DIPbfV5wUBmrhj7vWHqPPOJ/pYHve+9dBzU3u3FxGIUeOAGvUVjhbNGx/Pf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCqtXfko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98095C4CED1;
	Thu, 20 Feb 2025 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740055599;
	bh=g2f//fK8aq39T2Pf40WB9z+ft2RgJY8RkoVFTl07iro=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jCqtXfkoRqoRNaR/4Y+oEAWHZlB5kCJvT8WIioEVAp0p9EedZ6jlTprD8OtXzwd7F
	 RWOIAI3+5N0e6rp+SpIoZUGuzcdV6/6Ua7FcEspz18d+MGWGJ8JK+rY7i4nRqpPp/v
	 E4VpeIEpeo2XVKFCTqXa27KY++7WQdG7+WxVYQQwNKBEZwHplxAO1WwpO7vJxJfAz5
	 oNfEYQt9+o47msCg9ku+6UVgAn0QdmmYiiTaaVpZkvwgNMxfdaZeAzbXnz4Llyis0E
	 7Xg/9TymcdyYhwP8b3E0qHk3JsqufigVaBpHjmZmO13O5IJFMJq2xTvHbZ5Lp5f+Vm
	 OPAtORO4fHcCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790C6C021B1;
	Thu, 20 Feb 2025 12:46:39 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 20 Feb 2025 13:46:32 +0100
Subject: [PATCH v3] dt-bindings: spi: Convert Freescale SPI bindings to
 YAML
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250220-ppcyaml-spi-v3-1-e340613c7875@posteo.net>
X-B4-Tracking: v=1; b=H4sIACckt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3YKC5MrE3Bzd4oJMXQvTNGMLI4skIxNjUyWgjoKi1LTMCrBp0bG
 1tQBkMzqJXQAAAA==
X-Change-ID: 20250220-ppcyaml-spi-85f3828b2435
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740055598; l=7775;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=boF0Ptb0S1YPvdr9oEqVUSafvrLS+pZmCso6Fl1gjco=;
 b=PO2ytQrrgjrqH3PJyuQ+9iOvcuAke4DEX0xzz8Cm49UN4/5+8w6OZPfs71uwvMhAAjIDJMerw
 3HmahTtu0QwCZZN+iy42ppYB5whvaaz+5KXKgEiX/ZflrYRBt/PmFZx
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

fsl-spi.txt contains the bindings for the fsl,spi and fsl,espi
contollers. Convert them to YAML.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
V3:
- split out as a single patch
- use IRQ_TYPE_* constants in examples
- drop interrupt-parent from examples, add Rob's review tag

V2:
- part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
  Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-8-8137b0c42526@posteo.net/
- add missing end-of-document ("...") markers
- add missing constraints to interrupts, fsl,espi-num-chipselects,
  fsl,csbef and fsl,csaft properties
- remove unnecessary type from clock-frequency property
- fix property order to comply with dts coding style
---
 .../devicetree/bindings/spi/fsl,espi.yaml          | 65 +++++++++++++++++++
 Documentation/devicetree/bindings/spi/fsl,spi.yaml | 74 ++++++++++++++++++++++
 Documentation/devicetree/bindings/spi/fsl-spi.txt  | 62 ------------------
 3 files changed, 139 insertions(+), 62 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,espi.yaml b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d267bbfaf02f56e5b1ab8f6b2a8a34be13fb6766
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,espi.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,espi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale eSPI (Enhanced Serial Peripheral Interface) controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  compatible:
+    const: fsl,mpc8536-espi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  fsl,espi-num-chipselects:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 4 ]
+    description: The number of the chipselect signals.
+
+  fsl,csbef:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description: Chip select assertion time in bits before frame starts
+
+  fsl,csaft:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 15
+    description: Chip select negation time in bits after frame ends
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - fsl,espi-num-chipselects
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@110000 {
+        compatible = "fsl,mpc8536-espi";
+        reg = <0x110000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <53 IRQ_TYPE_EDGE_FALLING>;
+        fsl,espi-num-chipselects = <4>;
+        fsl,csbef = <1>;
+        fsl,csaft = <1>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/spi/fsl,spi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d74792fc9bf2d74c1e3126c1dc28878df95bf57e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,spi.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale SPI (Serial Peripheral Interface) controller
+
+maintainers:
+  - J. Neuschäfer <j.ne@posteo.net>
+
+properties:
+  compatible:
+    enum:
+      - fsl,spi
+      - aeroflexgaisler,spictrl
+
+  reg:
+    maxItems: 1
+
+  cell-index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      QE SPI subblock index.
+      0: QE subblock SPI1
+      1: QE subblock SPI2
+
+  mode:
+    description: SPI operation mode
+    enum:
+      - cpu
+      - cpu-qe
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    description: input clock frequency to non FSL_SOC cores
+
+  cs-gpios: true
+
+  fsl,spisel_boot:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      For the MPC8306 and MPC8309, specifies that the SPISEL_BOOT signal is used
+      as chip select for a slave device. Use reg = <number of gpios> in the
+      corresponding child node, i.e. 0 if the cs-gpios property is not present.
+
+required:
+  - compatible
+  - reg
+  - mode
+  - interrupts
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@4c0 {
+        compatible = "fsl,spi";
+        reg = <0x4c0 0x40>;
+        cell-index = <0>;
+        interrupts = <82 0>;
+        mode = "cpu";
+        cs-gpios = <&gpio 18 IRQ_TYPE_EDGE_RISING          // device reg=<0>
+                    &gpio 19 IRQ_TYPE_EDGE_RISING>;        // device reg=<1>
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt b/Documentation/devicetree/bindings/spi/fsl-spi.txt
deleted file mode 100644
index 0654380eb7515d8bda80eea1486e77b939ac38d8..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-* SPI (Serial Peripheral Interface)
-
-Required properties:
-- cell-index : QE SPI subblock index.
-		0: QE subblock SPI1
-		1: QE subblock SPI2
-- compatible : should be "fsl,spi" or "aeroflexgaisler,spictrl".
-- mode : the SPI operation mode, it can be "cpu" or "cpu-qe".
-- reg : Offset and length of the register set for the device
-- interrupts : <a b> where a is the interrupt number and b is a
-  field that represents an encoding of the sense and level
-  information for the interrupt.  This should be encoded based on
-  the information in section 2) depending on the type of interrupt
-  controller you have.
-- clock-frequency : input clock frequency to non FSL_SOC cores
-
-Optional properties:
-- cs-gpios : specifies the gpio pins to be used for chipselects.
-  The gpios will be referred to as reg = <index> in the SPI child nodes.
-  If unspecified, a single SPI device without a chip select can be used.
-- fsl,spisel_boot : for the MPC8306 and MPC8309, specifies that the
-  SPISEL_BOOT signal is used as chip select for a slave device. Use
-  reg = <number of gpios> in the corresponding child node, i.e. 0 if
-  the cs-gpios property is not present.
-
-Example:
-	spi@4c0 {
-		cell-index = <0>;
-		compatible = "fsl,spi";
-		reg = <4c0 40>;
-		interrupts = <82 0>;
-		interrupt-parent = <700>;
-		mode = "cpu";
-		cs-gpios = <&gpio 18 1		// device reg=<0>
-			    &gpio 19 1>;	// device reg=<1>
-	};
-
-
-* eSPI (Enhanced Serial Peripheral Interface)
-
-Required properties:
-- compatible : should be "fsl,mpc8536-espi".
-- reg : Offset and length of the register set for the device.
-- interrupts : should contain eSPI interrupt, the device has one interrupt.
-- fsl,espi-num-chipselects : the number of the chipselect signals.
-
-Optional properties:
-- fsl,csbef: chip select assertion time in bits before frame starts
-- fsl,csaft: chip select negation time in bits after frame ends
-
-Example:
-	spi@110000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "fsl,mpc8536-espi";
-		reg = <0x110000 0x1000>;
-		interrupts = <53 0x2>;
-		interrupt-parent = <&mpic>;
-		fsl,espi-num-chipselects = <4>;
-		fsl,csbef = <1>;
-		fsl,csaft = <1>;
-	};

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250220-ppcyaml-spi-85f3828b2435

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



