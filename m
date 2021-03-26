Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB23734A7C0
	for <lists+linux-spi@lfdr.de>; Fri, 26 Mar 2021 14:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhCZNCN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Mar 2021 09:02:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40222 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCZNBr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Mar 2021 09:01:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12QD1fsA030807;
        Fri, 26 Mar 2021 08:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616763701;
        bh=y3laHF42dkwKrLqvZJLvyaokGsabYQVmkc2tEl8qRv8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nEc0XWd7ThHi/E+E/JdmxRAMmpO8Aq7BIa6p4VdtMU+h2maCSyuac2SVTn5QSN5ZJ
         iEFSqKk9J6ZhFRg4M43ysFGuqdYXf0UaEZA+V1pWTIBOVdMPbs+ZcxymDlX4MDunUU
         BgFG7XhZ2rl+OPHouUwhE4DihGAolYKeHhAqGkVI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12QD1fGk100114
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Mar 2021 08:01:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 26
 Mar 2021 08:00:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 26 Mar 2021 08:00:50 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12QD0Zvu029283;
        Fri, 26 Mar 2021 08:00:48 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
Date:   Fri, 26 Mar 2021 18:30:34 +0530
Message-ID: <20210326130034.15231-5-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210326130034.15231-1-p.yadav@ti.com>
References: <20210326130034.15231-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

There is no way as of now to have a parent or bus defining properties
for child nodes. For now, avoid it in the example to silence warnings on
dt_schema_check. We can figure out how to deal with actual dts files
later.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
[p.yadav@ti.com: Fix how compatible is defined, make reset optional, fix
minor typos, remove subnode properties in example, update commit
message.]
---
 .../bindings/spi/cadence-quadspi.txt          |  68 ---------
 .../bindings/spi/cdns,qspi-nor.yaml           | 143 ++++++++++++++++++
 2 files changed, 143 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml

diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
deleted file mode 100644
index 8ace832a2d80..000000000000
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-* Cadence Quad SPI controller
-
-Required properties:
-- compatible : should be one of the following:
-	Generic default - "cdns,qspi-nor".
-	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
-	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
-	For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
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
diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
new file mode 100644
index 000000000000..0e7087cc8bf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/cdns,qspi-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence Quad SPI controller
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,k2g-qspi
+              - ti,am654-ospi
+              - intel,lgm-qspi
+          - const: cdns,qspi-nor
+      - const: cdns,qspi-nor
+
+  reg:
+    items:
+      - description: the controller register set
+      - description: the controller data area
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  cdns,fifo-depth:
+    description:
+      Size of the data FIFO in words.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [ 128, 256 ]
+    default: 128
+
+  cdns,fifo-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Bus width of the data FIFO in bytes.
+    default: 4
+
+  cdns,trigger-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      32-bit indirect AHB trigger address.
+
+  cdns,is-decoded-cs:
+    type: boolean
+    description:
+      Flag to indicate whether decoder is used to select different chip select
+      for different memory regions.
+
+  cdns,rclk-en:
+    type: boolean
+    description:
+      Flag to indicate that QSPI return clock is used to latch the read
+      data rather than the QSPI clock. Make sure that QSPI return clock
+      is populated on the board before using this property.
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum: [ qspi, qspi-ocp ]
+
+# subnode's properties
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
+    description:
+      Flash device uses the below defined properties in the subnode.
+
+    properties:
+      cdns,read-delay:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Delay for read capture logic, in clock cycles.
+
+      cdns,tshsl-ns:
+        description:
+          Delay in nanoseconds for the length that the master mode chip select
+          outputs are de-asserted between transactions.
+
+      cdns,tsd2d-ns:
+        description:
+          Delay in nanoseconds between one chip select being de-activated
+          and the activation of another.
+
+      cdns,tchsh-ns:
+        description:
+          Delay in nanoseconds between last bit of current transaction and
+          deasserting the device chip select (qspi_n_ss_out).
+
+      cdns,tslch-ns:
+        description:
+          Delay in nanoseconds between setting qspi_n_ss_out low and
+          first bit transfer.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - cdns,fifo-depth
+  - cdns,fifo-width
+  - cdns,trigger-address
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    qspi: spi@ff705000 {
+      compatible = "cdns,qspi-nor";
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
+      };
+    };
-- 
2.30.0

