Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69251FA7CB
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 06:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgFPEh1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 00:37:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47934 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgFPEh0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 00:37:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E0D9D2003FE;
        Tue, 16 Jun 2020 06:37:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C5C2C200408;
        Tue, 16 Jun 2020 06:37:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 76FB7402F3;
        Tue, 16 Jun 2020 12:37:13 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        marex@denx.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 3/3] dt-bindings: spi: Convert imx lpspi to json-schema
Date:   Tue, 16 Jun 2020 12:26:15 +0800
Message-Id: <1592281575-32708-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592281575-32708-1-git-send-email-Anson.Huang@nxp.com>
References: <1592281575-32708-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the i.MX LPSPI binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- remove redundant "maxItems" in "clocks" and "clock-names".
---
 .../devicetree/bindings/spi/spi-fsl-lpspi.txt      | 29 -----------
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     | 60 ++++++++++++++++++++++
 2 files changed, 60 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
deleted file mode 100644
index e71b81a..0000000
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Freescale Low Power SPI (LPSPI) for i.MX
-
-Required properties:
-- compatible :
-  - "fsl,imx7ulp-spi" for LPSPI compatible with the one integrated on i.MX7ULP soc
-  - "fsl,imx8qxp-spi" for LPSPI compatible with the one integrated on i.MX8QXP soc
-- reg : address and length of the lpspi master registers
-- interrupt-parent : core interrupt controller
-- interrupts : lpspi interrupt
-- clocks : lpspi clock specifier. Its number and order need to correspond to the
-	   value in clock-names.
-- clock-names : Corresponding to per clock and ipg clock in "clocks"
-		respectively. In i.MX7ULP, it only has per clk, so use CLK_DUMMY
-		to fill the "ipg" blank.
-- spi-slave : spi slave mode support. In slave mode, add this attribute without
-	      value. In master mode, remove it.
-
-Examples:
-
-lpspi2: lpspi@40290000 {
-	compatible = "fsl,imx7ulp-spi";
-	reg = <0x40290000 0x10000>;
-	interrupt-parent = <&intc>;
-	interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks IMX7ULP_CLK_LPSPI2>,
-		 <&clks IMX7ULP_CLK_DUMMY>;
-	clock-names = "per", "ipg";
-	spi-slave;
-};
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
new file mode 100644
index 0000000..143b94a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-fsl-lpspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Low Power SPI (LPSPI) for i.MX
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx7ulp-spi
+      - fsl,imx8qxp-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC SPI per clock
+      - description: SoC SPI ipg clock
+
+  clock-names:
+    items:
+      - const: per
+      - const: ipg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx7ulp-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@40290000 {
+        compatible = "fsl,imx7ulp-spi";
+        reg = <0x40290000 0x10000>;
+        interrupt-parent = <&intc>;
+        interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks IMX7ULP_CLK_LPSPI2>,
+                 <&clks IMX7ULP_CLK_DUMMY>;
+        clock-names = "per", "ipg";
+        spi-slave;
+    };
-- 
2.7.4

