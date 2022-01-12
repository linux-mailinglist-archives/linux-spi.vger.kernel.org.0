Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0200D48C25B
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jan 2022 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352565AbiALKgU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jan 2022 05:36:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37908 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239182AbiALKgU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jan 2022 05:36:20 -0500
X-UUID: c73cba6239ed4d2e9752cf46b6ea88bd-20220112
X-UUID: c73cba6239ed4d2e9752cf46b6ea88bd-20220112
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1441453006; Wed, 12 Jan 2022 18:36:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 12 Jan 2022 18:36:15 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 18:36:14 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH V2 2/3] dt-bindings: spi: Convert spi-mt65xx to json-schema
Date:   Wed, 12 Jan 2022 18:36:08 +0800
Message-ID: <20220112103609.17421-3-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112103609.17421-1-leilk.liu@mediatek.com>
References: <20220112103609.17421-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert Mediatek ARM SOC's SPI Master controller binding
to json-schema format.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../bindings/spi/mediatek,spi-mt65xx.yaml     | 99 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-mt65xx.txt    | 68 -------------
 2 files changed, 99 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
new file mode 100644
index 000000000000..71f0cf6e5d70
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mediatek,spi-mt65xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI Bus controller for MediaTek ARM SoCs
+
+maintainers:
+  - Leilk Liu <leilk.liu@mediatek.com>
+
+allOf:
+  - $ref: /spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt7629-spi
+          - const: mediatek,mt7622-spi
+      - items:
+          - enum:
+              - mediatek,mt8516-spi
+          - const: mediatek,mt2712-spi
+      - items:
+          - enum:
+              - mediatek,mt6779-spi
+              - mediatek,mt8192-spi
+              - mediatek,mt8195-spi
+          - const: mediatek,mt6765-spi
+      - const: mediatek,mt2701-spi
+      - const: mediatek,mt2712-spi
+      - const: mediatek,mt6589-spi
+      - const: mediatek,mt6765-spi
+      - const: mediatek,mt6893-spi
+      - const: mediatek,mt7622-spi
+      - const: mediatek,mt8135-spi
+      - const: mediatek,mt8173-spi
+      - const: mediatek,mt8183-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock used for the parent clock
+      - description: clock used for the muxes clock
+      - description: clock used for the clock gate
+
+  clock-names:
+    items:
+      - const: parent-clk
+      - const: sel-clk
+      - const: spi-clk
+
+  mediatek,pad-select:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 4
+    items:
+      enum: [0, 1, 2, 3]
+    description:
+      specify which pins group(ck/mi/mo/cs) spi controller used.
+      This is an array.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@1100a000 {
+      compatible = "mediatek,mt8173-spi";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      reg = <0x1100a000 0x1000>;
+      interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+      clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+               <&topckgen CLK_TOP_SPI_SEL>,
+               <&pericfg CLK_PERI_SPI0>;
+      clock-names = "parent-clk", "sel-clk", "spi-clk";
+      cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72 GPIO_ACTIVE_LOW>;
+      mediatek,pad-select = <1>, <0>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
deleted file mode 100644
index 2a24969159cc..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-Binding for MTK SPI controller
-
-Required properties:
-- compatible: should be one of the following.
-    - mediatek,mt2701-spi: for mt2701 platforms
-    - mediatek,mt2712-spi: for mt2712 platforms
-    - mediatek,mt6589-spi: for mt6589 platforms
-    - mediatek,mt6765-spi: for mt6765 platforms
-    - mediatek,mt7622-spi: for mt7622 platforms
-    - "mediatek,mt7629-spi", "mediatek,mt7622-spi": for mt7629 platforms
-    - mediatek,mt8135-spi: for mt8135 platforms
-    - mediatek,mt8173-spi: for mt8173 platforms
-    - mediatek,mt8183-spi: for mt8183 platforms
-    - mediatek,mt6893-spi: for mt6893 platforms
-    - "mediatek,mt8192-spi", "mediatek,mt6765-spi": for mt8192 platforms
-    - "mediatek,mt8195-spi", "mediatek,mt6765-spi": for mt8195 platforms
-    - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
-    - "mediatek,mt6779-spi", "mediatek,mt6765-spi": for mt6779 platforms
-
-- #address-cells: should be 1.
-
-- #size-cells: should be 0.
-
-- reg: Address and length of the register set for the device
-
-- interrupts: Should contain spi interrupt
-
-- clocks: phandles to input clocks.
-  The first should be one of the following. It's PLL.
-   -  <&clk26m>: specify parent clock 26MHZ.
-   -  <&topckgen CLK_TOP_SYSPLL3_D2>: specify parent clock 109MHZ.
-				      It's the default one.
-   -  <&topckgen CLK_TOP_SYSPLL4_D2>: specify parent clock 78MHZ.
-   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
-   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
-  The second should be <&topckgen CLK_TOP_SPI_SEL>. It's clock mux.
-  The third is <&pericfg CLK_PERI_SPI0>. It's clock gate.
-
-- clock-names: shall be "parent-clk" for the parent clock, "sel-clk" for the
-  muxes clock, and "spi-clk" for the clock gate.
-
-Optional properties:
--cs-gpios: see spi-bus.txt.
-
-- mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
-  controller used. This is an array, the element value should be 0~3,
-  only required for MT8173.
-    0: specify GPIO69,70,71,72 for spi pins.
-    1: specify GPIO102,103,104,105 for spi pins.
-    2: specify GPIO128,129,130,131 for spi pins.
-    3: specify GPIO5,6,7,8 for spi pins.
-
-Example:
-
-- SoC Specific Portion:
-spi: spi@1100a000 {
-	compatible = "mediatek,mt8173-spi";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	reg = <0 0x1100a000 0 0x1000>;
-	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
-	clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
-		 <&topckgen CLK_TOP_SPI_SEL>,
-		 <&pericfg CLK_PERI_SPI0>;
-	clock-names = "parent-clk", "sel-clk", "spi-clk";
-	cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72 GPIO_ACTIVE_LOW>;
-	mediatek,pad-select = <1>, <0>;
-};
-- 
2.25.1

