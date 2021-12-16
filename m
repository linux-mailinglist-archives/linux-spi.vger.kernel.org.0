Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0123476FE0
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhLPLRL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:11 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52373 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhLPLRF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:17:05 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B5554E0018;
        Thu, 16 Dec 2021 11:17:02 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 04/28] dt-bindings: mtd: nand-chip: Create a NAND chip description
Date:   Thu, 16 Dec 2021 12:16:30 +0100
Message-Id: <20211216111654.238086-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211216111654.238086-1-miquel.raynal@bootlin.com>
References: <20211216111654.238086-1-miquel.raynal@bootlin.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/nand-chip.yaml    | 70 +++++++++++++++++++
 .../bindings/mtd/nand-controller.yaml         | 50 +------------
 2 files changed, 72 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-chip.yaml

diff --git a/Documentation/devicetree/bindings/mtd/nand-chip.yaml b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
new file mode 100644
index 000000000000..97ac3a3fbb52
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
@@ -0,0 +1,70 @@
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
+    description: |
+      A phandle on the hardware ECC engine if any. There are
+      basically three possibilities:
+      1/ The ECC engine is part of the NAND controller, in this
+      case the phandle should reference the parent node.
+      2/ The ECC engine is part of the NAND part (on-die), in this
+      case the phandle should reference the node itself.
+      3/ The ECC engine is external, in this case the phandle should
+      reference the specific ECC engine node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  nand-use-soft-ecc-engine:
+    description: Use a software ECC engine.
+    type: boolean
+
+  nand-no-ecc-engine:
+    description: Do not use any ECC correction.
+    type: boolean
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
+    description:
+      Regions in the NAND chip which are protected using a secure element
+      like Trustzone. This property contains the start address and size of
+      the secure regions present.
+    $ref: /schemas/types.yaml#/definitions/uint64-matrix
+
+required:
+  - reg
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index a4fa65e872a5..33855eb48a79 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -52,31 +52,13 @@ properties:
 patternProperties:
   "^nand@[a-f0-9]$":
     type: object
+    $ref: "nand-chip.yaml#"
+
     properties:
       reg:
         description:
           Contains the chip-select IDs.
 
-      nand-ecc-engine:
-        description: |
-          A phandle on the hardware ECC engine if any. There are
-          basically three possibilities:
-          1/ The ECC engine is part of the NAND controller, in this
-          case the phandle should reference the parent node.
-          2/ The ECC engine is part of the NAND part (on-die), in this
-          case the phandle should reference the node itself.
-          3/ The ECC engine is external, in this case the phandle should
-          reference the specific ECC engine node.
-        $ref: /schemas/types.yaml#/definitions/phandle
-
-      nand-use-soft-ecc-engine:
-        description: Use a software ECC engine.
-        type: boolean
-
-      nand-no-ecc-engine:
-        description: Do not use any ECC correction.
-        type: boolean
-
       nand-ecc-placement:
         description:
           Location of the ECC bytes. This location is unknown by default
@@ -86,12 +68,6 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/string
         enum: [ oob, interleaved ]
 
-      nand-ecc-algo:
-        description:
-          Desired ECC algorithm.
-        $ref: /schemas/types.yaml#/definitions/string
-        enum: [hamming, bch, rs]
-
       nand-bus-width:
         description:
           Bus width to the NAND chip
@@ -110,18 +86,6 @@ patternProperties:
           build a volatile BBT in RAM.
         $ref: /schemas/types.yaml#/definitions/flag
 
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
         description:
           Whether or not the ECC strength should be maximized. The
@@ -152,13 +116,6 @@ patternProperties:
           Ready/Busy pins. Active state refers to the NAND ready state and
           should be set to GPIOD_ACTIVE_HIGH unless the signal is inverted.
 
-      secure-regions:
-        description:
-          Regions in the NAND chip which are protected using a secure element
-          like Trustzone. This property contains the start address and size of
-          the secure regions present.
-        $ref: /schemas/types.yaml#/definitions/uint64-matrix
-
     required:
       - reg
 
@@ -179,9 +136,6 @@ examples:
 
       nand@0 {
         reg = <0>; /* Native CS */
-        nand-use-soft-ecc-engine;
-        nand-ecc-algo = "bch";
-
         /* NAND chip specific properties */
       };
 
-- 
2.27.0

