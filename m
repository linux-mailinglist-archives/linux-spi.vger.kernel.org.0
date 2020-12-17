Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96782DD9ED
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 21:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgLQU3e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 15:29:34 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19148 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgLQU3e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 15:29:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdbbf850000>; Thu, 17 Dec 2020 12:28:53 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec
 2020 20:28:53 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 17 Dec 2020 20:28:52 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <bbrezillon@kernel.org>,
        <p.yadav@ti.com>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 2/9] dt-bindings: spi: Add Tegra Quad SPI device tree binding
Date:   Thu, 17 Dec 2020 12:28:40 -0800
Message-ID: <1608236927-28701-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608236933; bh=q7FKxM+CGuB7xfbL+aSHeN66VFj3TvwS13fwFoek5Q4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=LebfacZa2WbqM2ta9t57X3a7/JQyFAH5U4gmhsFateCd46OWpzJhc4eeLccpS2AEP
         NzV4KKjkfo3IZ/o2QMKlBzvuiKXAIg9NFjodX74rzbAfbCHLwRxw0X3FKMaThVLtOK
         ROm0ImgDMk04gRB7FnK3B3AsrKpS0Pt1NRswixZJinsjT98r4ADsN89Q8f+wBlq7sY
         fVKwYXxxPBgbP6nvyYYQqfdnxs3KaUlg9+uxk//0TfJt+3e2nsnam272hgbJyRW6a0
         okrQnF6gAzpgJi5DLBcnCaKuTil/EE3Phwj7t151dt3L7vnqEF0fhfPR/6rxWyuhnX
         DkAfJ2ArhXybw==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds YAML based device tree binding document for Tegra
Quad SPI driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../bindings/spi/nvidia,tegra210-quad.yaml         | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
new file mode 100644
index 0000000..35a8045
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nvidia,tegra210-quad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra Quad SPI Controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra210-qspi
+      - nvidia,tegra186-qspi
+      - nvidia,tegra194-qspi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: qspi
+      - const: qspi_out
+
+  clocks:
+    maxItems: 2
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+patternProperties:
+  "@[0-9a-f]+":
+    type: object
+
+    properties:
+      spi-rx-bus-width:
+        enum: [1, 2, 4]
+
+      spi-tx-bus-width:
+        enum: [1, 2, 4]
+
+      nvidia,tx-clk-tap-delay:
+        description:
+          Delays the clock going out to device with this tap value.
+          Tap value varies based on platform design trace lengths from Tegra
+          QSPI to corresponding slave device.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 31
+
+      nvidia,rx-clk-tap-delay:
+        description:
+          Delays the clock coming in from the device with this tap value.
+          Tap value varies based on platform design trace lengths from Tegra
+          QSPI to corresponding slave device.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 255
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/reset/tegra210-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    spi@70410000 {
+            compatible = "nvidia,tegra210-qspi";
+            reg = <0x70410000 0x1000>;
+            interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&tegra_car TEGRA210_CLK_QSPI>,
+                     <&tegra_car TEGRA210_CLK_QSPI_PM>;
+            clock-names = "qspi", "qspi_out";
+            resets = <&tegra_car 211>;
+            dmas = <&apbdma 5>, <&apbdma 5>;
+            dma-names = "rx", "tx";
+
+            flash@0 {
+                    compatible = "spi-nor";
+                    reg = <0>;
+                    spi-max-frequency = <104000000>;
+                    spi-tx-bus-width = <2>;
+                    spi-rx-bus-width = <2>;
+                    nvidia,tx-clk-tap-delay = <0>;
+                    nvidia,rx-clk-tap-delay = <0>;
+            };
+    };
-- 
2.7.4

