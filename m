Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9C163A22
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2020 03:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBSC3C (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Feb 2020 21:29:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:5259 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgBSC3C (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 Feb 2020 21:29:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 18:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="282973935"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2020 18:28:59 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com
Cc:     robh+dt@kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, tien.fong.chee@intel.com, marex@denx.de,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v10 1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
Date:   Wed, 19 Feb 2020 10:28:51 +0800
Message-Id: <20200219022852.28065-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200219022852.28065-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add dt-bindings documentation for Cadence-QSPI controller to support
spi based flash memories.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 147 +++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
new file mode 100644
index 000000000000..1a4d6e8d0d0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence QSPI Flash Controller support
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+description: |
+  Binding Documentation for Cadence QSPI controller,This controller is
+  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
+  has been tested On Intel's LGM SoC.
+
+  - compatible : should be one of the following:
+        Generic default - "cdns,qspi-nor".
+        For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
+        For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
+        For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+           - ti,k2g-qspi
+        - const: cdns,qspi-nor
+
+      - items:
+        - enum:
+           - ti,am654-ospi
+        - const: cdns,qspi-nor
+
+      - items:
+        - enum:
+           - intel,lgm-qspi
+        - const: cdns,qspi-nor
+
+      - items:
+        - const: cdns,qspi-nor
+
+  reg:
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  cdns,fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the data FIFO in words.
+
+  cdns,fifo-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Bus width of the data FIFO in bytes.
+
+  cdns,trigger-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      32-bit indirect AHB trigger address.
+
+  cdns,rclk-en:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Flag to indicate that QSPI return clock is used to latch the read data
+      rather than the QSPI clock. Make sure that QSPI return clock is populated
+      on the board before using this property.
+
+# subnode's properties
+patternProperties:
+  "^.*@[0-9a-fA-F]+$":
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Delay in nanoseconds for the length that the master mode chip select
+      outputs are de-asserted between transactions.
+
+  cdns,tsd2d-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Delay in nanoseconds between one chip select being de-activated
+      and the activation of another.
+
+  cdns,tchsh-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Delay in nanoseconds between last bit of current transaction and
+      deasserting the device chip select (qspi_n_ss_out).
+
+  cdns,tslch-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+
+examples:
+  - |
+    qspi: spi@ff705000 {
+          compatible = "cdns,qspi-nor";
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reg = <0xff705000 0x1000>,
+                <0xffa00000 0x1000>;
+          interrupts = <0 151 4>;
+          clocks = <&qspi_clk>;
+          cdns,fifo-depth = <128>;
+          cdns,fifo-width = <4>;
+          cdns,trigger-address = <0x00000000>;
+
+          flash0: n25q00@0 {
+              compatible = "jedec,spi-nor";
+              reg = <0x0>;
+              cdns,read-delay = <4>;
+              cdns,tshsl-ns = <50>;
+              cdns,tsd2d-ns = <50>;
+              cdns,tchsh-ns = <4>;
+              cdns,tslch-ns = <4>;
+          };
+    };
+
-- 
2.11.0

