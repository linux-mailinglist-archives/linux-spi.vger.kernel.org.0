Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837111C3AD7
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEDNEj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 09:04:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:6156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgEDNEi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 09:04:38 -0400
IronPort-SDR: TtgTezEb+9qlct/nP85McwfOWYvFH3Q/w2KHVDGDq1JmtPPqesCPu1/809U8bwyPZs+oALqqXC
 aSKFKqpTTx7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 06:04:07 -0700
IronPort-SDR: qjVVk1GkjHMk7o5oMemIbw0p9D5QWhRIUugE3sBTzk2uBoZ1cf84sdUkUq5AX/UqHZoLSBivUY
 p7+NRvnehHUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="249169155"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2020 06:04:04 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v4 7/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema
Date:   Mon,  4 May 2020 21:02:46 +0800
Message-Id: <20200504130246.5135-8-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the Synopsis DesignWare dw-apb-ssi binding to DT schema format
using json-schema.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../bindings/spi/snps,dw-apb-ssi.txt          | 42 -----------
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
deleted file mode 100644
index 7a4702edf896..000000000000
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ /dev/null
@@ -1,42 +0,0 @@
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
index 000000000000..edc1e6fb9993
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface
+
+maintainers:
+  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - mscc,ocelot-spi
+      - mscc,jaguar2-spi
+      - amazon,alpine-dw-apb-ssi
+      - snps,dw-apb-ssi
+      - snps,dwc-ssi-1.01a
+      - intel,keembay-ssi
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: The register base for the controller.
+      - description: For "mscc,<soc>-spi", a second register set is required.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: The core clock used to generate the external SPI clock.
+      - description: The interface clock required for register access.
+
+  clock-names:
+    items:
+      - const: ssi_clk
+      - const: pclk
+
+  reg-io-width:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [ 2, 4 ]
+      - default: 4
+    description: The I/O register width (in bytes) implemented by this device.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    spi@fff00000 {
+          compatible = "snps,dw-apb-ssi";
+          reg = <0xfff00000 0x1000>;
+          interrupts = <0 154 4>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+          clocks = <&spi_m_clk>;
+          num-cs = <2>;
+          cs-gpios = <&gpio0 13 0>,
+                     <&gpio0 14 0>;
+    };
-- 
2.17.1

