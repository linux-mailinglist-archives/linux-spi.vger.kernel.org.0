Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F7B3AE610
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jun 2021 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhFUJeJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Jun 2021 05:34:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33718 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUJeI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Jun 2021 05:34:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15L9VrYN009045;
        Mon, 21 Jun 2021 04:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624267913;
        bh=iLXOHigeBfCtwhWP1up5+ZpOgMa0GIQ92inE02LlXek=;
        h=From:To:CC:Subject:Date;
        b=XPYj1GkW+wGv30cio/I830hdRmodkYeLd0iI4fJzANr25JvQFxHBe1HhYBq+l44dx
         Qly1eagiBSU57YMAd1s21cwaYpOHwtl68hbj24L2zv8nLkusE85lwtIegap/7h58Iq
         sV/uXNOsf8GaefP8smIfntu0luQ3/mzuVoNCzbhA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15L9Vrwc012436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jun 2021 04:31:53 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 21
 Jun 2021 04:31:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 21 Jun 2021 04:31:53 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15L9Vi5w105998;
        Mon, 21 Jun 2021 04:31:46 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: spi: omap-spi: Convert to json-schema
Date:   Mon, 21 Jun 2021 14:58:58 +0530
Message-ID: <20210621092900.951-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert omap-spi dt-binding documentation from txt to yaml format.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

changes since v2:
- added myself as the maintainer
- added reference to spi-controller.yaml
- removed properties already defined in spi-controller.yaml
- removed unused labels in dt example
- changed additionalProperties to unevaluatedProperties
  as a reference is used

changes since v1:
- split the series according to their respective trees

link to v1:
https://lore.kernel.org/patchwork/project/lkml/list/?series=502255

 .../devicetree/bindings/spi/omap-spi.txt      |  48 -------
 .../devicetree/bindings/spi/omap-spi.yaml     | 117 ++++++++++++++++++
 2 files changed, 117 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/omap-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/omap-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/omap-spi.txt b/Documentation/devicetree/bindings/spi/omap-spi.txt
deleted file mode 100644
index 487208c256c0..000000000000
--- a/Documentation/devicetree/bindings/spi/omap-spi.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-OMAP2+ McSPI device
-
-Required properties:
-- compatible :
-  - "ti,am654-mcspi" for AM654.
-  - "ti,omap2-mcspi" for OMAP2 & OMAP3.
-  - "ti,omap4-mcspi" for OMAP4+.
-- ti,spi-num-cs : Number of chipselect supported  by the instance.
-- ti,hwmods: Name of the hwmod associated to the McSPI
-- ti,pindir-d0-out-d1-in: Select the D0 pin as output and D1 as
-			  input. The default is D0 as input and
-			  D1 as output.
-
-Optional properties:
-- dmas: List of DMA specifiers with the controller specific format
-	as described in the generic DMA client binding. A tx and rx
-	specifier is required for each chip select.
-- dma-names: List of DMA request names. These strings correspond
-	1:1 with the DMA specifiers listed in dmas. The string naming
-	is to be "rxN" and "txN" for RX and TX requests,
-	respectively, where N equals the chip select number.
-
-Examples:
-
-[hwmod populated DMA resources]
-
-mcspi1: mcspi@1 {
-    #address-cells = <1>;
-    #size-cells = <0>;
-    compatible = "ti,omap4-mcspi";
-    ti,hwmods = "mcspi1";
-    ti,spi-num-cs = <4>;
-};
-
-[generic DMA request binding]
-
-mcspi1: mcspi@1 {
-    #address-cells = <1>;
-    #size-cells = <0>;
-    compatible = "ti,omap4-mcspi";
-    ti,hwmods = "mcspi1";
-    ti,spi-num-cs = <2>;
-    dmas = <&edma 42
-	    &edma 43
-	    &edma 44
-	    &edma 45>;
-    dma-names = "tx0", "rx0", "tx1", "rx1";
-};
diff --git a/Documentation/devicetree/bindings/spi/omap-spi.yaml b/Documentation/devicetree/bindings/spi/omap-spi.yaml
new file mode 100644
index 000000000000..e55538186cf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/omap-spi.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/omap-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI controller bindings for OMAP and K3 SoCs
+
+maintainers:
+  - Aswath Govindraju <a-govindraju@ti.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,am654-mcspi
+              - ti,am4372-mcspi
+          - const: ti,omap4-mcspi
+      - items:
+          - enum:
+              - ti,omap2-mcspi
+              - ti,omap4-mcspi
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
+  power-domains:
+    maxItems: 1
+
+  ti,spi-num-cs:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of chipselect supported  by the instance.
+    minimum: 1
+    maximum: 4
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Must be "mcspi<n>", n being the instance number (1-based).
+      This property is applicable only on legacy platforms mainly omap2/3
+      and ti81xx and should not be used on other platforms.
+    deprecated: true
+
+  ti,pindir-d0-out-d1-in:
+    description:
+      Select the D0 pin as output and D1 as input. The default is D0
+      as input and D1 as output.
+    type: boolean
+
+  dmas:
+    description:
+      List of DMA specifiers with the controller specific format as
+      described in the generic DMA client binding. A tx and rx
+      specifier is required for each chip select.
+    minItems: 1
+    maxItems: 8
+
+  dma-names:
+    description:
+      List of DMA request names. These strings correspond 1:1 with
+      the DMA sepecifiers listed in dmas. The string names is to be
+      "rxN" and "txN" for RX and TX requests, respectively. Where N
+      is the chip select number.
+    minItems: 1
+    maxItems: 8
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+if:
+  properties:
+    compatible:
+      oneOf:
+        - const: ti,omap2-mcspi
+        - const: ti,omap4-mcspi
+
+then:
+  properties:
+    ti,hwmods:
+      items:
+        - pattern: "^mcspi([1-9])$"
+
+else:
+  properties:
+    ti,hwmods: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    spi@2100000 {
+      compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+      reg = <0x2100000 0x400>;
+      interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&k3_clks 137 1>;
+      power-domains = <&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
+      dma-names = "tx0", "rx0";
+    };
-- 
2.17.1

