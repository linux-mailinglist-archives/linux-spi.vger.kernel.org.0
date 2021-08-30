Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F53FBF35
	for <lists+linux-spi@lfdr.de>; Tue, 31 Aug 2021 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhH3XDV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Aug 2021 19:03:21 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:41739 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhH3XDU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Aug 2021 19:03:20 -0400
Received: (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 260F1200003;
        Mon, 30 Aug 2021 23:02:24 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Pavel Nadein <pavelnadein@gmail.com>
Cc:     Pavel Nadein <pasha-net@narod.ru>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [5.16][PATCH 1/3] dt-bindings: spi: Document Ingenic SPI controller bindings
Date:   Tue, 31 Aug 2021 01:01:37 +0200
Message-Id: <20210830230139.21476-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830230139.21476-1-contact@artur-rojek.eu>
References: <20210830230139.21476-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

Add a documentation file to describe the Device Tree bindings for the
SPI controller found in Ingenic SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../devicetree/bindings/spi/ingenic,spi.yaml  | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/ingenic,spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/ingenic,spi.yaml b/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
new file mode 100644
index 000000000000..cf56cc484b19
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ingenic,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic SoCs SPI controller devicetree bindings
+
+maintainers:
+  - Artur Rojek <contact@artur-rojek.eu>
+  - Paul Cercueil <paul@crapouillou.net>
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - ingenic,jz4750-spi
+          - ingenic,jz4780-spi
+      - items:
+          - enum:
+              - ingenic,jz4760-spi
+              - ingenic,jz4770-spi
+          - const: ingenic,jz4750-spi
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
+  dmas:
+    maxItems: 2
+    minItems: 2
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
+  - clocks
+  - dmas
+  - dma-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4770-cgu.h>
+    spi@10043000 {
+      compatible = "ingenic,jz4770-spi", "ingenic,jz4750-spi";
+      reg = <0x10043000 0x1c>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <8>;
+
+      clocks = <&cgu JZ4770_CLK_SSI0>;
+
+      dmas = <&dmac1 23 0xffffffff>, <&dmac1 22 0xffffffff>;
+      dma-names = "rx", "tx";
+    };
-- 
2.33.0

