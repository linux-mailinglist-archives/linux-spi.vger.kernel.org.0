Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B770F1B70D1
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgDXJ3g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 05:29:36 -0400
Received: from mx.socionext.com ([202.248.49.38]:38703 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDXJ3g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Apr 2020 05:29:36 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Apr 2020 18:29:34 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id A5B51180085;
        Fri, 24 Apr 2020 18:29:34 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 24 Apr 2020 18:29:34 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 15DD91A12D0;
        Fri, 24 Apr 2020 18:29:34 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2] dt-bindings: spi: Convert UniPhier SPI controller to json-schema
Date:   Fri, 24 Apr 2020 18:29:22 +0900
Message-Id: <1587720562-15293-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert UniPhier SPI controller binding to DT schema format.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---

Changes since v1:
- Put "#address-cells" and "#size-cells" into the required list

 .../bindings/spi/socionext,uniphier-spi.yaml       | 57 ++++++++++++++++++++++
 .../devicetree/bindings/spi/spi-uniphier.txt       | 28 -----------
 2 files changed, 57 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt

diff --git a/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml b/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
new file mode 100644
index 0000000..c254092
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/socionext,uniphier-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext UniPhier SPI controller
+
+description: |
+  UniPhier SoCs have SCSSI which supports SPI single channel.
+
+maintainers:
+  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+  - Keiji Hayashibara <hayashibara.keiji@socionext.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    const: socionext,uniphier-scssi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    spi0: spi@54006000 {
+        compatible = "socionext,uniphier-scssi";
+        reg = <0x54006000 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <0 39 4>;
+        clocks = <&peri_clk 11>;
+        resets = <&peri_rst 11>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
deleted file mode 100644
index e120157..0000000
--- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Socionext UniPhier SPI controller driver
-
-UniPhier SoCs have SCSSI which supports SPI single channel.
-
-Required properties:
- - compatible: should be "socionext,uniphier-scssi"
- - reg: address and length of the spi master registers
- - #address-cells: must be <1>, see spi-bus.txt
- - #size-cells: must be <0>, see spi-bus.txt
- - interrupts: a single interrupt specifier
- - pinctrl-names: should be "default"
- - pinctrl-0: pin control state for the default mode
- - clocks: a phandle to the clock for the device
- - resets: a phandle to the reset control for the device
-
-Example:
-
-spi0: spi@54006000 {
-	compatible = "socionext,uniphier-scssi";
-	reg = <0x54006000 0x100>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	interrupts = <0 39 4>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi0>;
-	clocks = <&peri_clk 11>;
-	resets = <&peri_rst 11>;
-};
-- 
2.7.4

