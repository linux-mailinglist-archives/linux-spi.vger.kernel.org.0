Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE940294692
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 04:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440036AbgJUCg7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Oct 2020 22:36:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:11807 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440031AbgJUCg5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Oct 2020 22:36:57 -0400
IronPort-SDR: WqL7xZeXfZWF3U5w5RJAxg+7hZv04cF/32DSkeVXw+0lKM55sgdGvxBZePZwVvbcf6AtWyyIrh
 2Rs0PuzmKvGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="163814831"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="163814831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 19:36:56 -0700
IronPort-SDR: DKb2Qb6vPYrJS7kfOA9BkIgp8jNF5UZEx8JT+mW18Lb8rZu5Ew7pA3vy0P19bYZ7B3WqvbX49L
 2QiwOQlN6pQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="358741867"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2020 19:36:53 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 4/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
Date:   Wed, 21 Oct 2020 10:36:13 +0800
Message-Id: <20201021023615.48982-5-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201021023615.48982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201021023615.48982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/cadence-quadspi.txt    |  67 ----------
 .../devicetree/bindings/spi/cadence-quadspi.yaml   | 148 +++++++++++++++++++++
 2 files changed, 148 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
deleted file mode 100644
index 945be7d5b236..000000000000
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-* Cadence Quad SPI controller
-
-Required properties:
-- compatible : should be one of the following:
-	Generic default - "cdns,qspi-nor".
-	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
-	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
-- reg : Contains two entries, each of which is a tuple consisting of a
-	physical address and length. The first entry is the address and
-	length of the controller register set. The second entry is the
-	address and length of the QSPI Controller data area.
-- interrupts : Unit interrupt specifier for the controller interrupt.
-- clocks : phandle to the Quad SPI clock.
-- cdns,fifo-depth : Size of the data FIFO in words.
-- cdns,fifo-width : Bus width of the data FIFO in bytes.
-- cdns,trigger-address : 32-bit indirect AHB trigger address.
-
-Optional properties:
-- cdns,is-decoded-cs : Flag to indicate whether decoder is used or not.
-- cdns,rclk-en : Flag to indicate that QSPI return clock is used to latch
-  the read data rather than the QSPI clock. Make sure that QSPI return
-  clock is populated on the board before using this property.
-
-Optional subnodes:
-Subnodes of the Cadence Quad SPI controller are spi slave nodes with additional
-custom properties:
-- cdns,read-delay : Delay for read capture logic, in clock cycles
-- cdns,tshsl-ns : Delay in nanoseconds for the length that the master
-                  mode chip select outputs are de-asserted between
-		  transactions.
-- cdns,tsd2d-ns : Delay in nanoseconds between one chip select being
-                  de-activated and the activation of another.
-- cdns,tchsh-ns : Delay in nanoseconds between last bit of current
-                  transaction and deasserting the device chip select
-		  (qspi_n_ss_out).
-- cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
-                  and first bit transfer.
-- resets	: Must contain an entry for each entry in reset-names.
-		  See ../reset/reset.txt for details.
-- reset-names	: Must include either "qspi" and/or "qspi-ocp".
-
-Example:
-
-	qspi: spi@ff705000 {
-		compatible = "cdns,qspi-nor";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xff705000 0x1000>,
-		      <0xffa00000 0x1000>;
-		interrupts = <0 151 4>;
-		clocks = <&qspi_clk>;
-		cdns,is-decoded-cs;
-		cdns,fifo-depth = <128>;
-		cdns,fifo-width = <4>;
-		cdns,trigger-address = <0x00000000>;
-		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
-		reset-names = "qspi", "qspi-ocp";
-
-		flash0: n25q00@0 {
-			...
-			cdns,read-delay = <4>;
-			cdns,tshsl-ns = <50>;
-			cdns,tsd2d-ns = <50>;
-			cdns,tchsh-ns = <4>;
-			cdns,tslch-ns = <4>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
new file mode 100644
index 000000000000..6ed8122a1326
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/cadence-quadspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence Quad SPI controller
+
+maintainers:
+  - Vadivel Murugan <vadivel.muruganx.ramuthevar@intel.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: cdns,qspi-nor
+      - const: ti,k2g-qspi, cdns,qspi-nor
+      - const: ti,am654-ospi, cdns,qspi-nor
+
+    description:
+      Should be one of the above supported compatible strings.
+      optional properties
+      "cdns,is-decoded-cs" - Flag to indicate whether decoder is used or not.
+      "cdns,rclk-en" - Flag to indicate that QSPI return clock is used to latch
+      the read data rather than the QSPI clock. Make sure that QSPI return
+      clock is populated on the board before using this property.
+
+  reg:
+    maxItems: 2
+
+    description:
+      Contains two entries, each of which is a tuple consisting of a
+      physical address and length. The first entry is the address and
+      length of the controller register set. The second entry is the
+      address and length of the QSPI Controller data area.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Unit interrupt specifier for the controller interrupt.
+
+  clocks:
+    maxItems: 1
+    description:
+      phandle to the Quad SPI clock.
+
+  cdns,fifo-depth:
+    description:
+      Size of the data FIFO in words.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - enum: [ 128, 256 ]
+      - default: 128
+
+  cdns,fifo-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Bus width of the data FIFO in bytes.
+    multipleOf: 4
+
+  cdns,trigger-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      32-bit indirect AHB trigger address.
+
+  resets:
+     description:
+       Must contain an entry for each entry in reset-names.
+       See ../reset/reset.txt for details.
+
+  reset-names:
+    description:
+      Must include either "qspi" and/or "qspi-ocp".
+
+# subnode's properties
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
+    description:
+      flash device uses the subnodes below defined properties.
+
+  cdns,read-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Delay for read capture logic, in clock cycles.
+
+  cdns,tshsl-ns:
+    description: |
+      Delay in nanoseconds for the length that the master mode chip select
+      outputs are de-asserted between transactions.
+
+  cdns,tsd2d-ns:
+    description: |
+      Delay in nanoseconds between one chip select being de-activated
+      and the activation of another.
+
+  cdns,tchsh-ns:
+    description: |
+      Delay in nanoseconds between last bit of current transaction and
+      deasserting the device chip select (qspi_n_ss_out).
+
+  cdns,tslch-ns:
+    description: |
+      Delay in nanoseconds between setting qspi_n_ss_out low and
+      first bit transfer.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - cdns,fifo-depth
+  - cdns,fifo-width
+  - cdns,trigger-address
+  - resets
+  - reset-names
+
+examples:
+  - |
+    qspi: spi@ff705000 {
+      compatible = "cadence,qspi";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      reg = <0xff705000 0x1000>,
+            <0xffa00000 0x1000>;
+      interrupts = <0 151 4>;
+      clocks = <&qspi_clk>;
+      cdns,fifo-depth = <128>;
+      cdns,fifo-width = <4>;
+      cdns,trigger-address = <0x00000000>;
+      resets = <&rst 0x1>, <&rst 0x2>;
+      reset-names = "qspi", "qspi-ocp";
+
+      flash@0 {
+              compatible = "jedec,spi-nor";
+              reg = <0x0>;
+              cdns,read-delay = <4>;
+              cdns,tshsl-ns = <50>;
+              cdns,tsd2d-ns = <50>;
+              cdns,tchsh-ns = <4>;
+              cdns,tslch-ns = <4>;
+     };
+
+    };
+
+...
-- 
2.11.0

