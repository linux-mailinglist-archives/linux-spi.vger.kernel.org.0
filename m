Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD11DC4B2
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 03:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgEUBX5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 21:23:57 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:34224 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgEUBX5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 May 2020 21:23:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id E2D2F8030790;
        Thu, 21 May 2020 01:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ONaAWhNS5gIk; Thu, 21 May 2020 04:23:52 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mips@vger.kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 16/16] dt-bindings: spi: Convert DW SPI binding to DT schema
Date:   Thu, 21 May 2020 04:22:06 +0300
Message-ID: <20200521012206.14472-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Modern device tree bindings are supposed to be created as YAML-files
in accordance with dt-schema. This commit replaces two DW SPI legacy
bare text bindings with YAML file. As before the bindings file states
that the corresponding dts node is supposed to be compatible either
with generic DW APB SSI controller or with Microsemi/Amazon/Renesas/Intel
vendors-specific controllers, to have registers, interrupts and clocks
properties. Though in case of Microsemi version of the controller
there must be two registers resources specified. Properties like
clock-names, reg-io-width, cs-gpio, num-cs, DMA and slave device
sub-nodes are optional.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mips@vger.kernel.org
---
 .../bindings/spi/snps,dw-apb-ssi.txt          |  44 ------
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 127 ++++++++++++++++++
 .../devicetree/bindings/spi/spi-dw.txt        |  24 ----
 3 files changed, 127 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
deleted file mode 100644
index 020e3168ee41..000000000000
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
-
-Required properties:
-- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2", or "amazon,alpine-dw-apb-ssi", or "snps,dwc-ssi-1.01a" or
-  "intel,keembay-ssi"
-- reg : The register base for the controller. For "mscc,<soc>-spi", a second
-  register set is required (named ICPU_CFG:SPI_MST)
-- interrupts : One interrupt, used by the controller.
-- #address-cells : <1>, as required by generic SPI binding.
-- #size-cells : <0>, also as required by generic SPI binding.
-- clocks : phandles for the clocks, see the description of clock-names below.
-   The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
-   is optional. If a single clock is specified but no clock-name, it is the
-   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
-
-Optional properties:
-- clock-names : Contains the names of the clocks:
-    "ssi_clk", for the core clock used to generate the external SPI clock.
-    "pclk", the interface clock, required for register access. If a clock domain
-     used to enable this clock then it should be named "pclk_clkdomain".
-- cs-gpios : Specifies the gpio pins to be used for chipselects.
-- num-cs : The number of chipselects. If omitted, this will default to 4.
-- reg-io-width : The I/O register width (in bytes) implemented by this
-  device.  Supported values are 2 or 4 (the default).
-- dmas : Phandle + identifiers of Tx and Rx DMA channels.
-- dma-names : Contains the names of the DMA channels. Must be "tx" and "rx".
-
-Child nodes as per the generic SPI binding.
-
-Example:
-
-	spi@fff00000 {
-		compatible = "snps,dw-apb-ssi";
-		reg = <0xfff00000 0x1000>;
-		interrupts = <0 154 4>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&spi_m_clk>;
-		num-cs = <2>;
-		cs-gpios = <&gpio0 13 0>,
-			   <&gpio0 14 0>;
-	};
-
diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
new file mode 100644
index 000000000000..1fcab6415136
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mscc,ocelot-spi
+              - mscc,jaguar2-spi
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+properties:
+  compatible:
+    oneOf:
+      - description: Generic DW SPI Controller
+        enum:
+          - snps,dw-apb-ssi
+          - snps,dwc-ssi-1.01a
+      - description: Microsemi Ocelot/Jaguar2 SoC SPI Controller
+        items:
+          - enum:
+              - mscc,ocelot-spi
+              - mscc,jaguar2-spi
+          - const: snps,dw-apb-ssi
+      - description: Amazon Alpine SPI Controller
+        const: amazon,alpine-dw-apb-ssi
+      - description: Renesas RZ/N1 SPI Controller
+        items:
+          - const: renesas,rzn1-spi
+          - const: snps,dw-apb-ssi
+      - description: Intel Keem Bay SPI Controller
+        const: intel,keembay-ssi
+
+  reg:
+    minItems: 1
+    items:
+      - description: DW APB SSI controller memory mapped registers
+      - description: SPI MST region map
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: SPI Controller reference clock source
+      - description: APB interface clock source
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ssi_clk
+      - const: pclk
+
+  reg-io-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: I/O register width (in bytes) implemented by this device
+    default: 4
+    enum: [ 2, 4 ]
+
+  num-cs:
+    default: 4
+    minimum: 1
+    maximum: 4
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+
+      spi-rx-bus-width:
+        const: 1
+
+      spi-tx-bus-width:
+        const: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    spi@fff00000 {
+      compatible = "snps,dw-apb-ssi";
+      reg = <0xfff00000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      interrupts = <0 154 4>;
+      clocks = <&spi_m_clk>;
+      num-cs = <2>;
+      cs-gpios = <&gpio0 13 0>,
+                 <&gpio0 14 0>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-dw.txt b/Documentation/devicetree/bindings/spi/spi-dw.txt
deleted file mode 100644
index 7b63ed601990..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-dw.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Synopsys DesignWare SPI master
-
-Required properties:
-- compatible: should be "snps,designware-spi"
-- #address-cells: see spi-bus.txt
-- #size-cells: see spi-bus.txt
-- reg: address and length of the spi master registers
-- interrupts: should contain one interrupt
-- clocks: spi clock phandle
-- num-cs: see spi-bus.txt
-
-Optional properties:
-- cs-gpios: see spi-bus.txt
-
-Example:
-
-spi: spi@4020a000 {
-	compatible = "snps,designware-spi";
-	interrupts = <11 1>;
-	reg = <0x4020a000 0x1000>;
-	clocks = <&pclk>;
-	num-cs = <2>;
-	cs-gpios = <&banka 0 0>;
-};
-- 
2.25.1

