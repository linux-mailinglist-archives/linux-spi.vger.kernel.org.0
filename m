Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338371EC96E
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jun 2020 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgFCGYD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 02:24:03 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42990 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgFCGYC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Jun 2020 02:24:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E2020200D3F;
        Wed,  3 Jun 2020 08:24:00 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA018200D3E;
        Wed,  3 Jun 2020 08:23:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 84ED640299;
        Wed,  3 Jun 2020 14:23:49 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        marex@denx.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] dt-bindings: spi: Convert imx cspi to json-schema
Date:   Wed,  3 Jun 2020 14:13:28 +0800
Message-Id: <1591164809-13964-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591164809-13964-1-git-send-email-Anson.Huang@nxp.com>
References: <1591164809-13964-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the i.MX CSPI binding to DT schema format using json-schema,
update compatible, remove obsolete properties "fsl,spi-num-chipselects"
and update the example based on latest DT file.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/spi/fsl-imx-cspi.txt       | 56 -------------
 .../devicetree/bindings/spi/fsl-imx-cspi.yaml      | 97 ++++++++++++++++++++++
 2 files changed, 97 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
deleted file mode 100644
index 33bc58f..0000000
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Freescale (Enhanced) Configurable Serial Peripheral Interface
-  (CSPI/eCSPI) for i.MX
-
-Required properties:
-- compatible :
-  - "fsl,imx1-cspi" for SPI compatible with the one integrated on i.MX1
-  - "fsl,imx21-cspi" for SPI compatible with the one integrated on i.MX21
-  - "fsl,imx27-cspi" for SPI compatible with the one integrated on i.MX27
-  - "fsl,imx31-cspi" for SPI compatible with the one integrated on i.MX31
-  - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
-  - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
-  - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
-  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
-  - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
-  - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
-  - "fsl,imx8mp-ecspi" for SPI compatible with the one integrated on i.MX8MP
-- reg : Offset and length of the register set for the device
-- interrupts : Should contain CSPI/eCSPI interrupt
-- clocks : Clock specifiers for both ipg and per clocks.
-- clock-names : Clock names should include both "ipg" and "per"
-See the clock consumer binding,
-	Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Recommended properties:
-- cs-gpios : GPIOs to use as chip selects, see spi-bus.txt.  While the native chip
-select lines can be used, they appear to always generate a pulse between each
-word of a transfer.  Most use cases will require GPIO based chip selects to
-generate a valid transaction.
-
-Optional properties:
-- num-cs :  Number of total chip selects, see spi-bus.txt.
-- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
-Documentation/devicetree/bindings/dma/dma.txt.
-- dma-names: DMA request names, if present, should include "tx" and "rx".
-- fsl,spi-rdy-drctl: Integer, representing the value of DRCTL, the register
-controlling the SPI_READY handling. Note that to enable the DRCTL consideration,
-the SPI_READY mode-flag needs to be set too.
-Valid values are: 0 (disabled), 1 (edge-triggered burst) and 2 (level-triggered burst).
-
-Obsolete properties:
-- fsl,spi-num-chipselects : Contains the number of the chipselect
-
-Example:
-
-ecspi@70010000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "fsl,imx51-ecspi";
-	reg = <0x70010000 0x4000>;
-	interrupts = <36>;
-	cs-gpios = <&gpio3 24 0>, /* GPIO3_24 */
-		   <&gpio3 25 0>; /* GPIO3_25 */
-	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
-	dma-names = "rx", "tx";
-	fsl,spi-rdy-drctl = <1>;
-};
diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
new file mode 100644
index 0000000..cac023d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl-imx-cspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale (Enhanced) Configurable Serial Peripheral Interface (CSPI/eCSPI) for i.MX
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,imx1-cspi
+      - const: fsl,imx21-cspi
+      - const: fsl,imx27-cspi
+      - const: fsl,imx31-cspi
+      - const: fsl,imx35-cspi
+      - const: fsl,imx51-ecspi
+      - const: fsl,imx53-ecspi
+      - items:
+        - enum:
+          - fsl,imx50-ecspi
+          - fsl,imx6q-ecspi
+          - fsl,imx6sx-ecspi
+          - fsl,imx6sl-ecspi
+          - fsl,imx6sll-ecspi
+          - fsl,imx6ul-ecspi
+          - fsl,imx7d-ecspi
+          - fsl,imx8mq-ecspi
+          - fsl,imx8mm-ecspi
+          - fsl,imx8mn-ecspi
+          - fsl,imx8mp-ecspi
+        - const: fsl,imx51-ecspi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC SPI ipg clock
+      - description: SoC SPI per clock
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: per
+    maxItems: 2
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for RX
+      - description: DMA controller phandle and request line for TX
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  fsl,spi-rdy-drctl:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Integer, representing the value of DRCTL, the register controlling
+      the SPI_READY handling. Note that to enable the DRCTL consideration,
+      the SPI_READY mode-flag needs to be set too.
+      Valid values are: 0 (disabled), 1 (edge-triggered burst) and 2 (level-triggered burst).
+    enum: [0, 1, 2]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx5-clock.h>
+
+    spi@70010000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "fsl,imx51-ecspi";
+        reg = <0x70010000 0x4000>;
+        interrupts = <36>;
+        clocks = <&clks IMX5_CLK_ECSPI1_IPG_GATE>,
+                 <&clks IMX5_CLK_ECSPI1_PER_GATE>;
+        clock-names = "ipg", "per";
+    };
-- 
2.7.4

