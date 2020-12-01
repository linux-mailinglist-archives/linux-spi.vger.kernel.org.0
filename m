Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9F72CAE24
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 22:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbgLAVNc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 16:13:32 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14567 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbgLAVNb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 16:13:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6b1d30000>; Tue, 01 Dec 2020 13:12:51 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 21:12:50 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Dec 2020 21:12:49 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 2/7] dt-bindings: spi: Add Tegra QSPI device tree binding
Date:   Tue, 1 Dec 2020 13:12:43 -0800
Message-ID: <1606857168-5839-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606857171; bh=/2F5ZwMdeddcrSo5XG0HyncQt1PgABPAL/P/aQrE10E=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=hMBI1jnAc4qs4XlY2pd8rflTZHDcF2/4KbVlLXRGP+NnbTJjIj5ZTFHJj3/zOQG5D
         WJEtRmwxM5pWNCO7igI643SO0GsP1k7jXbCRnOnl0avTECnUxWkdotY6L5d3KGCHQW
         7ZfnAzzdOTCbgriUQv1c0FB1DlIBrUDXcbOLP6DGBpOzdm2zeW44yjawHpV4igU2zA
         8/Ab8sjJBS2gLuQpb1UPJdwdvkHnnLzjl9wWYYRMuwmF7oixsZCa+E8P08q7Ac/Tfw
         xt+XWjkRPRlOjC912NhZTNKaF91GUj1M2XHqvFdaCn3zX4PpDZ6LwCoOrXrL6NoM6P
         jO3Rk/Nd32R1w==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds YAML based device tree binding document for Tegra
QSPI driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/spi/nvidia,tegra-qspi.yaml | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
new file mode 100644
index 0000000..038a085
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nvidia,tegra-qspi.yaml#
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
+    items:
+      - description: QSPI registers
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: qspi
+
+  clocks:
+    maxItems: 1
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: qspi
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+  - reset-names
+  - resets
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/reset/tegra210-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@70410000 {
+            compatible = "nvidia,tegra210-qspi";
+            reg = <0x70410000 0x1000>;
+            interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&tegra_car TEGRA210_CLK_QSPI>;
+            clock-names = "qspi";
+            resets = <&tegra_car 211>;
+            reset-names = "qspi";
+            dmas = <&apbdma 5>, <&apbdma 5>;
+            dma-names = "rx", "tx";
+    };
-- 
2.7.4

