Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB1294695
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 04:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440046AbgJUChD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Oct 2020 22:37:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:35318 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440042AbgJUChC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Oct 2020 22:37:02 -0400
IronPort-SDR: HJujmnz+vBMDGkGz73Ggv4agOhtPx/Xv/j/bF3aSFGbkgCVkeLGBugLdf/QAjIGb1hJ4Z2g1Nj
 F8P3eO8/Tl+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167424600"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="167424600"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 19:37:01 -0700
IronPort-SDR: 2VThqO2zxy4GAQU5VTjm86BaTsct/FAHWiWaxIyAihFfSicM6O0IcYo1HSse/Z78OGCak5UEwc
 ajgA5t0LjMRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="522591478"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2020 19:36:57 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 5/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Date:   Wed, 21 Oct 2020 10:36:14 +0800
Message-Id: <20201021023615.48982-6-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201021023615.48982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201021023615.48982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add compatible string for Intel LGM SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 .../devicetree/bindings/spi/cadence-quadspi.yaml   | 68 +++++++++++-----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
index 6ed8122a1326..57be1a730e7b 100644
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
@@ -14,65 +14,61 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: cdns,qspi-nor
-      - const: ti,k2g-qspi, cdns,qspi-nor
-      - const: ti,am654-ospi, cdns,qspi-nor
-
-    description:
-      Should be one of the above supported compatible strings.
-      optional properties
-      "cdns,is-decoded-cs" - Flag to indicate whether decoder is used or not.
-      "cdns,rclk-en" - Flag to indicate that QSPI return clock is used to latch
-      the read data rather than the QSPI clock. Make sure that QSPI return
-      clock is populated on the board before using this property.
+    oneOf:
+      - items:
+         - const: cdns,qspi-nor
+         - const: ti,k2g-qspi, cdns,qspi-nor
+         - const: ti,am654-ospi, cdns,qspi-nor
 
   reg:
-    maxItems: 2
-    
-    description:
-      Contains two entries, each of which is a tuple consisting of a
-      physical address and length. The first entry is the address and
-      length of the controller register set. The second entry is the
-      address and length of the QSPI Controller data area.
+    items:
+      - description: the controller register set
+      - description: the controller data area
 
   interrupts:
     maxItems: 1
-    description:
-      Unit interrupt specifier for the controller interrupt.
 
   clocks:
     maxItems: 1
-    description:
-      phandle to the Quad SPI clock.
 
   cdns,fifo-depth:
     description:
       Size of the data FIFO in words.
-    allOf:
-      - $ref: "/schemas/types.yaml#/definitions/uint32"
-      - enum: [ 128, 256 ]
-      - default: 128
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    enum: [ 128, 256 ]
+    default: 128
 
   cdns,fifo-width:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Bus width of the data FIFO in bytes.
-    multipleOf: 4
+    default: 4
 
   cdns,trigger-address:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       32-bit indirect AHB trigger address.
 
+  cdns,is-decoded-cs:
+    type: boolean
+    description:
+      Flag to indicate whether decoder is used or not.
+
+  cdns,rclk-en:
+    type: boolean
+    description:
+      Flag to indicate that QSPI return clock is used to latch the read
+      data rather than the QSPI clock. Make sure that QSPI return clock
+      is populated on the board before using this property.
+
   resets:
-     description:
-       Must contain an entry for each entry in reset-names.
-       See ../reset/reset.txt for details.
+    maxItems : 2
 
   reset-names:
-    description:
-      Must include either "qspi" and/or "qspi-ocp".
+    minItems: 1
+    maxItems: 2
+    items:
+      enum: [ qspi, qspi-ocp ]
 
 # subnode's properties
 patternProperties:
@@ -114,13 +110,17 @@ required:
   - cdns,fifo-depth
   - cdns,fifo-width
   - cdns,trigger-address
+  - cdns,is-decoded-cs
+  - cdns,rclk-en
   - resets
   - reset-names
 
+additionalProperties: false
+
 examples:
   - |
     qspi: spi@ff705000 {
-      compatible = "cadence,qspi";
+      compatible = "cadence,qspi","cdns,qpsi-nor";
       #address-cells = <1>;
       #size-cells = <0>;
       reg = <0xff705000 0x1000>,
-- 
2.11.0

