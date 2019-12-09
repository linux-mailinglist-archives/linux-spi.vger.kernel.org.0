Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0211686A
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 09:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfLIIkp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 03:40:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:11442 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLIIko (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 03:40:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 00:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="215139094"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2019 00:40:40 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v3 1/2] dt-bindings: spi: Add schema for Cadence QSPI Controller driver
Date:   Mon,  9 Dec 2019 16:40:34 +0800
Message-Id: <20191209084035.55603-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191209084035.55603-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20191209084035.55603-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add dt-bindings documentation for Cadence-QSPI controller to support
spi based flash memories.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 .../devicetree/bindings/spi/cadence,qspi.yaml      | 162 +++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
new file mode 100644
index 000000000000..7756c34bb453
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cadence,qspi.yaml#"
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
+  Add support for the Cadence QSPI controller,This controller is
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
+    enum:
+      - cadence,qspi
+      - cdns,qspi-nor
+      - ti,k2g-qspi
+      - ti,am654-ospi
+      - intel,lgm-qspi
+
+  reg:
+    description: |
+      Contains two entries, each of which is a tuple consisting of a
+      Physical address and length. The first entry is the address and
+      length of the controller register set. The second entry is the
+      address and length of the QSPI Controller data area.
+
+  interrupts:
+    description:
+      Unit interrupt specifier for the controller interrupt.
+
+  clocks:
+    description:
+      phandle to the Quad SPI clock.
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
+  cdns,is-decoded-cs:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Flag to indicate whether decoder is used or not.
+
+  cdns,rclk-en:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Flag to indicate that QSPI return clock is used to latch the read data
+      rather than the QSPI clock. Make sure that QSPI return clock is populated
+      on the board before using this property.
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: qspi
+      - const: qspi-ocp
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
+  - cdns,is-decoded-cs
+  - cdns,fifo-depth
+  - cdns,fifo-width
+  - cdns,trigger-address
+  - resets
+  - reset-names
+
+examples:
+  - |
+    qspi: spi@ff705000 {
+          compatible = "cadence,qspi", "cdns,qspi-nor";
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reg = <0xff705000 0x1000>,
+                <0xffa00000 0x1000>;
+          interrupts = <0 151 4>;
+          clocks = <&qspi_clk>;
+          cdns,is-decoded-cs;
+          cdns,fifo-depth = <128>;
+          cdns,fifo-width = <4>;
+          cdns,trigger-address = <0x00000000>;
+          resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
+          reset-names = "qspi", "qspi-ocp";
+
+          flash0: n25q00@0 {
+              ...
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

