Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11423989BE
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 14:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFBMhU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 08:37:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40460 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFBMhT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 08:37:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 152CZU3f027790;
        Wed, 2 Jun 2021 07:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622637330;
        bh=i3QEOXysvQImmF/O6Ym6rYgSqMjCwg+DVqqgsbiucz0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=igsTvpECG/fACRSRdt4rZ4stR2ODEgnUMzo1QVLhun8vKf7wQDYy0ggpuzyTiMq/6
         LVT02p/4Xy6h/cIJKqckDifoO0UZlG9Ot4hTKKSFM7LMc9y2A5Eri/n/TdBegWDU07
         oksylvqnezk32+ApQZqWF/84Mm0ZwSkF+n3ExXds=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 152CZUo2015822
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jun 2021 07:35:30 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 2 Jun
 2021 07:35:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 2 Jun 2021 07:35:29 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 152CYKN8023646;
        Wed, 2 Jun 2021 07:35:20 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 5/5] dt-bindings: spi: omap-spi: Convert to json-schema
Date:   Wed, 2 Jun 2021 18:04:15 +0530
Message-ID: <20210602123416.20378-6-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210602123416.20378-1-a-govindraju@ti.com>
References: <20210602123416.20378-1-a-govindraju@ti.com>
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
 .../devicetree/bindings/spi/omap-spi.txt      |  48 -------
 .../devicetree/bindings/spi/omap-spi.yaml     | 126 ++++++++++++++++++
 2 files changed, 126 insertions(+), 48 deletions(-)
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
index 000000000000..cd20704f2edc
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/omap-spi.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/omap-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI controller bindings for OMAP and K3 SoCs
+
+maintainers:
+  - Mark Brown <broonie@kernel.org>
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
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
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
+    description:
+      Flash devices are defined as a sub-node of the spi controller
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
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
+    main_spi0: spi@2100000 {
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

