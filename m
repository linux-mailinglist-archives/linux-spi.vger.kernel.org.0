Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9E46B74F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 10:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhLGJiR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 04:38:17 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42313 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhLGJiI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 04:38:08 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A60FF60007;
        Tue,  7 Dec 2021 09:34:35 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 08/22] dt-bindings: spi: mxic: Convert to yaml
Date:   Tue,  7 Dec 2021 10:34:08 +0100
Message-Id: <20211207093422.166934-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207093422.166934-1-miquel.raynal@bootlin.com>
References: <20211207093422.166934-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Straightforward conversion from regular text to yaml schema of the
Macronix SPI controller DT bindings.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/mxicy,mx25f0a-spi.yaml       | 60 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-mxic.txt      | 36 -----------
 2 files changed, 60 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt

diff --git a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
new file mode 100644
index 000000000000..f20d100b4a68
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
@@ -0,0 +1,60 @@
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
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
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

