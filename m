Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA5434DB4
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhJTOau (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 10:30:50 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43759 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhJTOah (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 10:30:37 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7239520003;
        Wed, 20 Oct 2021 14:28:20 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 07/18] dt-bindings: spi: mxic: Convert to yaml
Date:   Wed, 20 Oct 2021 16:27:58 +0200
Message-Id: <20211020142809.349347-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211020142809.349347-1-miquel.raynal@bootlin.com>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Straightforward conversion from regular text to yaml schema of the
Macronix SPI controller DT bindings.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/spi/mxicy,mx25f0a-spi.yaml       | 67 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-mxic.txt      | 36 ----------
 2 files changed, 67 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt

diff --git a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
new file mode 100644
index 000000000000..4036c14fc533
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mxicy,mx25f0a-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Macronix SPI controller device tree bindings
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: mxicy,mx25f0a-spi
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: regs
+      - const: dirmap
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: send_clk
+      - const: send_dly_clk
+      - const: ps_clk
+
+  "#address-cells":
+    const: 1
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@43c30000 {
+      compatible = "mxicy,mx25f0a-spi";
+      reg = <0x43c30000 0x10000>, <0xa0000000 0x20000000>;
+      reg-names = "regs", "dirmap";
+      clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 18>;
+      clock-names = "send_clk", "send_dly_clk", "ps_clk";
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-mxic.txt b/Documentation/devicetree/bindings/spi/spi-mxic.txt
deleted file mode 100644
index 7bcbb229b78b..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-mxic.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Macronix SPI controller Device Tree Bindings
---------------------------------------------
-
-Required properties:
-- compatible: should be "mxicy,mx25f0a-spi"
-- #address-cells: should be 1
-- #size-cells: should be 0
-- reg: should contain 2 entries, one for the registers and one for the direct
-       mapping area
-- reg-names: should contain "regs" and "dirmap"
-- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
-- clocks: should contain 3 entries for the "ps_clk", "send_clk" and
-	  "send_dly_clk" clocks
-
-Optional properties:
-- interrupts: interrupt line connected to the SPI controller
-
-Example:
-
-	spi@43c30000 {
-		compatible = "mxicy,mx25f0a-spi";
-		reg = <0x43c30000 0x10000>, <0xa0000000 0x20000000>;
-		reg-names = "regs", "dirmap";
-		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 18>;
-		clock-names = "send_clk", "send_dly_clk", "ps_clk";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		flash@0 {
-			compatible = "jedec,spi-nor";
-			reg = <0>;
-			spi-max-frequency = <25000000>;
-			spi-tx-bus-width = <4>;
-			spi-rx-bus-width = <4>;
-		};
-	};
-- 
2.27.0

