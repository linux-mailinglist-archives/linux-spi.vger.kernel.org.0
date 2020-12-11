Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26DC2D7C05
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 18:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392284AbgLKRCf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 12:02:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5110 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392633AbgLKRC0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 12:02:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3a5ed0001>; Fri, 11 Dec 2020 09:01:33 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 17:01:33 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 11 Dec 2020 17:01:32 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/9] dt-bindings: spi: Add Tegra Quad SPI device tree binding
Date:   Fri, 11 Dec 2020 09:01:20 -0800
Message-ID: <1607706088-1437-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607706093; bh=3YJOpsLNUJCKpNjK/mrgTh4DBxFB8pgGVCN4zJkrqCo=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=SzxLWWhiw5vNRcWRDeWNiZ8rpXBKtMYWgUYDWaw+gmKBRimsxj/K0KxmgsLTDVZv2
         8EdKMavH0+bThxTqRGAYHO2ah0nZNFIVqI3hoxd2aWcHNcls2+juzwif3d8ktyfPB8
         6M/pU0oFFhihOF/ZeV1LFIL3dBXBc+LBY+MxnYQFJePAb21mQsDa79OIr3eGCmlaGD
         54mzm2hYMjIlGv7tyHZYhwuWPohyPyG8/q6tzHlJAM6JTr7Q4ibv7qYOtngsgLUqy9
         PNFDi5iamEmpl6VZ46rEhkXtUD7Zc5g0WXCZDhMtIKbK8Quu7rKq24hT+KTtlH32A+
         VJR28pV+MR9rQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds YAML based device tree binding document for Tegra
Quad SPI driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../bindings/spi/nvidia,tegra210-quad.yaml         | 130 +++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
new file mode 100644
index 0000000..0b5fea6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -0,0 +1,130 @@
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
+  "^.*@[0-9a-f]+":
+    type: object
+
+    properties:
+      compatible:
+        description:
+          Compatible of the SPI device.
+
+      reg:
+        maxItems: 1
+
+      spi-max-frequency:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Maximum Quad SPI clocking speed of the device in Hz.
+
+      spi-rx-bus-width:
+        description:
+          Bus width to the Quad SPI bus used for read transfers.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2, 4]
+
+      spi-tx-bus-width:
+        description:
+          Bus width to the Quad SPI bus used for write transfers.
+        $ref: /schemas/types.yaml#/definitions/uint32
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
+additionalProperties: true
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
+            };
+    };
-- 
2.7.4

