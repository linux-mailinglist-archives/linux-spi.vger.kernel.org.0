Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA6C1EC978
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jun 2020 08:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFCGYD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 02:24:03 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42952 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgFCGYB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Jun 2020 02:24:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 88C00200089;
        Wed,  3 Jun 2020 08:23:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A65AF200D3C;
        Wed,  3 Jun 2020 08:23:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 60532402B3;
        Wed,  3 Jun 2020 14:23:48 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        marex@denx.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] dt-bindings: spi: Convert mxs spi to json-schema
Date:   Wed,  3 Jun 2020 14:13:27 +0800
Message-Id: <1591164809-13964-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591164809-13964-1-git-send-email-Anson.Huang@nxp.com>
References: <1591164809-13964-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the MXS SPI binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/spi/mxs-spi.txt  | 26 ----------
 Documentation/devicetree/bindings/spi/mxs-spi.yaml | 55 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.txt b/Documentation/devicetree/bindings/spi/mxs-spi.txt
deleted file mode 100644
index 3499b73..0000000
--- a/Documentation/devicetree/bindings/spi/mxs-spi.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Freescale MX233/MX28 SSP/SPI
-
-Required properties:
-- compatible: Should be "fsl,<soc>-spi", where soc is "imx23" or "imx28"
-- reg: Offset and length of the register set for the device
-- interrupts: Should contain SSP ERROR interrupt
-- dmas: DMA specifier, consisting of a phandle to DMA controller node
-  and SSP DMA channel ID.
-  Refer to dma.txt and fsl-mxs-dma.txt for details.
-- dma-names: Must be "rx-tx".
-
-Optional properties:
-- clock-frequency : Input clock frequency to the SPI block in Hz.
-		    Default is 160000000 Hz.
-
-Example:
-
-ssp0: ssp@80010000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "fsl,imx28-spi";
-	reg = <0x80010000 0x2000>;
-	interrupts = <96>;
-	dmas = <&dma_apbh 0>;
-	dma-names = "rx-tx";
-};
diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.yaml b/Documentation/devicetree/bindings/spi/mxs-spi.yaml
new file mode 100644
index 0000000..ef99d12
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mxs-spi.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mxs-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale MX233/MX28 SSP/SPI
+
+maintainers:
+  - Marek Vasut <marex@denx.de>
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx23-spi
+      - fsl,imx28-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx-tx
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: input clock frequency to the SPI block in Hz.
+    default: 160000000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+
+examples:
+  - |
+    spi@80010000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "fsl,imx28-spi";
+        reg = <0x80010000 0x2000>;
+        interrupts = <96>;
+        dmas = <&dma_apbh 0>;
+        dma-names = "rx-tx";
+    };
-- 
2.7.4

