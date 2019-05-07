Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D11C6164E6
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 15:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEGNsY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 09:48:24 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:45617 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfEGNsX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 May 2019 09:48:23 -0400
X-Originating-IP: 90.88.28.253
Received: from localhost (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AF1ECC0011;
        Tue,  7 May 2019 13:48:19 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: spi: sun4i: Add YAML schemas
Date:   Tue,  7 May 2019 15:48:14 +0200
Message-Id: <893098f3e35dcc226a24f0655563454525de0840.1557236840.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
References: <b7a6095a5c900fa23cc54d1ccd8e8ef0ccf6e788.1557236840.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/spi/spi-sun4i.txt                | 23 +-------------------
 2 files changed, 86 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun4i.txt

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
new file mode 100644
index 000000000000..7c136507df80
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/allwinner,sun4i-a10-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 SPI Controller Device Tree Bindings
+
+allOf:
+  - $ref: "spi-controller.yaml"
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    const: allwinner,sun4i-a10-spi
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
+      - const: ahb
+      - const: mod
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  num-cs: true
+
+patternProperties:
+  "^[a-z]+@[0-9]+$":
+    properties:
+      reg:
+        items:
+          minimum: 0
+          maximum: 4
+
+      spi-rx-bus-width:
+        const: 1
+
+      spi-tx-bus-width:
+        const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi1: spi@1c06000 {
+        compatible = "allwinner,sun4i-a10-spi";
+        reg = <0x01c06000 0x1000>;
+        interrupts = <11>;
+        clocks = <&ahb_gates 21>, <&spi1_clk>;
+        clock-names = "ahb", "mod";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
deleted file mode 100644
index c75d604a8290..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Allwinner A10 SPI controller
-
-Required properties:
-- compatible: Should be "allwinner,sun4-a10-spi".
-- reg: Should contain register location and length.
-- interrupts: Should contain interrupt.
-- clocks: phandle to the clocks feeding the SPI controller. Two are
-          needed:
-  - "ahb": the gated AHB parent clock
-  - "mod": the parent module clock
-- clock-names: Must contain the clock names described just above
-
-Example:
-
-spi1: spi@1c06000 {
-	compatible = "allwinner,sun4i-a10-spi";
-	reg = <0x01c06000 0x1000>;
-	interrupts = <11>;
-	clocks = <&ahb_gates 21>, <&spi1_clk>;
-	clock-names = "ahb", "mod";
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
-- 
git-series 0.9.1
