Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F2434DAB
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhJTOao (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 10:30:44 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47165 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhJTOai (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 10:30:38 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A86432000D;
        Wed, 20 Oct 2021 14:28:21 +0000 (UTC)
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
Subject: [PATCH 08/18] dt-bindings: mtd: Describe Macronix NAND ECC engine
Date:   Wed, 20 Oct 2021 16:27:59 +0200
Message-Id: <20211020142809.349347-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211020142809.349347-1-miquel.raynal@bootlin.com>
References: <20211020142809.349347-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Describe Macronix NAND ECC engine. This engine may be used as an
external engine or can be pipelined with either a raw NAND controller or
a SPI controller. Both hardware designs with a SPI controller are shown
in the examples.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/mtd/mxicy,nand-ecc-engine.yaml   | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.yaml

diff --git a/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.yaml b/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.yaml
new file mode 100644
index 000000000000..804479999ccb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/mxicy,nand-ecc-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Macronix NAND ECC engine device tree bindings
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    const: mxicy,nand-ecc-engine-rev3
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
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    /* External configuration */
+    spi_controller0: spi@43c30000 {
+        compatible = "mxicy,mx25f0a-spi";
+        reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
+        reg-names = "regs", "dirmap";
+        clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+        clock-names = "send_clk", "send_dly_clk", "ps_clk";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "spi-nand";
+            reg = <0>;
+            nand-ecc-engine = <&ecc_engine0>;
+        };
+    };
+
+    ecc_engine0: ecc@43c40000 {
+        compatible = "mxicy,nand-ecc-engine-rev3";
+        reg = <0x43c40000 0x10000>;
+    };
+
+  - |
+    /* Pipelined configuration */
+    spi_controller1: spi@43c30000 {
+        compatible = "mxicy,mx25f0a-spi";
+        reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
+        reg-names = "regs", "dirmap";
+        clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+        clock-names = "send_clk", "send_dly_clk", "ps_clk";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        nand-ecc-engine = <&ecc_engine1>;
+
+        flash@0 {
+            compatible = "spi-nand";
+            reg = <0>;
+            nand-ecc-engine = <&spi_controller1>;
+        };
+    };
+
+    ecc_engine1: ecc@43c40000 {
+        compatible = "mxicy,nand-ecc-engine-rev3";
+        reg = <0x43c40000 0x10000>;
+    };
-- 
2.27.0

