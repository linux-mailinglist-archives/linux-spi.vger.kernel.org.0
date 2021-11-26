Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C640E45ED0B
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 12:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377097AbhKZL6U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 06:58:20 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:41325 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhKZL4T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 06:56:19 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 5BBB9C3963;
        Fri, 26 Nov 2021 11:39:57 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BDE0FFF811;
        Fri, 26 Nov 2021 11:39:31 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 03/20] dt-bindings: mtd: nand-chip: Create a NAND chip description
Date:   Fri, 26 Nov 2021 12:39:07 +0100
Message-Id: <20211126113924.310459-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211126113924.310459-1-miquel.raynal@bootlin.com>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Move the NAND chip description out of the NAND controller file. Indeed,
a subsequent part of the properties supported by a raw NAND chip are
also supported by SPI-NAND chips. So let's create a generic NAND chip
description which will be pulled by nand-controller.yaml and later by
spi-nand.yaml as well.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/mtd/nand-chip.yaml    | 71 +++++++++++++++++++
 .../bindings/mtd/nand-controller.yaml         | 53 ++------------
 2 files changed, 75 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-chip.yaml

diff --git a/Documentation/devicetree/bindings/mtd/nand-chip.yaml b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
new file mode 100644
index 000000000000..6d13e8cdbb21
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/nand-chip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NAND Chip and NAND Controller Generic Binding
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+description: |
+  This file covers the generic description of a NAND chip. It implies that the
+  bus interface should not be taken into account: both raw NAND devices and
+  SPI-NAND devices are concerned by this description.
+
+properties:
+  reg:
+    description:
+      Contains the chip-select IDs.
+
+  nand-ecc-engine:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      A phandle on the hardware ECC engine if any. There are
+      basically three possibilities:
+      1/ The ECC engine is part of the NAND controller, in this
+      case the phandle should reference the parent node.
+      2/ The ECC engine is part of the NAND part (on-die), in this
+      case the phandle should reference the node itself.
+      3/ The ECC engine is external, in this case the phandle should
+      reference the specific ECC engine node.
+
+  nand-use-soft-ecc-engine:
+    type: boolean
+    description: Use a software ECC engine.
+
+  nand-no-ecc-engine:
+    type: boolean
+    description: Do not use any ECC correction.
+
+  nand-ecc-algo:
+    description:
+      Desired ECC algorithm.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [hamming, bch, rs]
+
+  nand-ecc-strength:
+    description:
+      Maximum number of bits that can be corrected per ECC step.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+
+  nand-ecc-step-size:
+    description:
+      Number of data bytes covered by a single ECC step.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+
+  secure-regions:
+    $ref: /schemas/types.yaml#/definitions/uint64-matrix
+    description:
+      Regions in the NAND chip which are protected using a secure element
+      like Trustzone. This property contains the start address and size of
+      the secure regions present.
+
+required:
+  - reg
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 5cd144a9ec99..44825dc95412 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -52,32 +52,15 @@ properties:
 patternProperties:
   "^nand@[a-f0-9]$":
     type: object
+
+    allOf:
+      - $ref: "nand-chip.yaml#"
+
     properties:
       reg:
         description:
           Contains the chip-select IDs.
 
-      nand-ecc-engine:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/phandle
-        description: |
-          A phandle on the hardware ECC engine if any. There are
-          basically three possibilities:
-          1/ The ECC engine is part of the NAND controller, in this
-          case the phandle should reference the parent node.
-          2/ The ECC engine is part of the NAND part (on-die), in this
-          case the phandle should reference the node itself.
-          3/ The ECC engine is external, in this case the phandle should
-          reference the specific ECC engine node.
-
-      nand-use-soft-ecc-engine:
-        type: boolean
-        description: Use a software ECC engine.
-
-      nand-no-ecc-engine:
-        type: boolean
-        description: Do not use any ECC correction.
-
       nand-ecc-placement:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/string
@@ -88,12 +71,6 @@ patternProperties:
           known to be stored in the OOB area, or "interleaved" if ECC
           bytes will be interleaved with regular data in the main area.
 
-      nand-ecc-algo:
-        description:
-          Desired ECC algorithm.
-        $ref: /schemas/types.yaml#/definitions/string
-        enum: [hamming, bch, rs]
-
       nand-bus-width:
         description:
           Bus width to the NAND chip
@@ -112,18 +89,6 @@ patternProperties:
           find Bad Block Markers (BBM). These markers will help to
           build a volatile BBT in RAM.
 
-      nand-ecc-strength:
-        description:
-          Maximum number of bits that can be corrected per ECC step.
-        $ref: /schemas/types.yaml#/definitions/uint32
-        minimum: 1
-
-      nand-ecc-step-size:
-        description:
-          Number of data bytes covered by a single ECC step.
-        $ref: /schemas/types.yaml#/definitions/uint32
-        minimum: 1
-
       nand-ecc-maximize:
         $ref: /schemas/types.yaml#/definitions/flag
         description:
@@ -154,13 +119,6 @@ patternProperties:
           Ready/Busy pins. Active state refers to the NAND ready state and
           should be set to GPIOD_ACTIVE_HIGH unless the signal is inverted.
 
-      secure-regions:
-        $ref: /schemas/types.yaml#/definitions/uint64-matrix
-        description:
-          Regions in the NAND chip which are protected using a secure element
-          like Trustzone. This property contains the start address and size of
-          the secure regions present.
-
     required:
       - reg
 
@@ -181,9 +139,6 @@ examples:
 
       nand@0 {
         reg = <0>; /* Native CS */
-        nand-use-soft-ecc-engine;
-        nand-ecc-algo = "bch";
-
         /* NAND chip specific properties */
       };
 
-- 
2.27.0

