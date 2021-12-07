Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3582D46B755
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 10:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhLGJiV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 04:38:21 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59233 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhLGJiB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 04:38:01 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5C32860009;
        Tue,  7 Dec 2021 09:34:29 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/22] dt-bindings: mtd: nand-chip: Create a NAND chip description
Date:   Tue,  7 Dec 2021 10:34:04 +0100
Message-Id: <20211207093422.166934-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207093422.166934-1-miquel.raynal@bootlin.com>
References: <20211207093422.166934-1-miquel.raynal@bootlin.com>
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
index 000000000000..2e91cf471f81
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
+    $ref: /schemas/types.yaml#/definitions/phandle
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
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Desired ECC algorithm.
+    enum: [hamming, bch, rs]
+
+  nand-ecc-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum number of bits that can be corrected per ECC step.
+    minimum: 1
+
+  nand-ecc-step-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of data bytes covered by a single ECC step.
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
index 7024ca24c2e2..05229d2dbb07 100644
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
-        $ref: /schemas/types.yaml#/definitions/phandle
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
         $ref: /schemas/types.yaml#/definitions/string
         description:
@@ -86,12 +68,6 @@ patternProperties:
           bytes will be interleaved with regular data in the main area.
         enum: [ oob, interleaved ]
 
-      nand-ecc-algo:
-        $ref: /schemas/types.yaml#/definitions/string
-        description:
-          Desired ECC algorithm.
-        enum: [hamming, bch, rs]
-
       nand-bus-width:
         $ref: /schemas/types.yaml#/definitions/uint32
         description:
@@ -110,18 +86,6 @@ patternProperties:
           find Bad Block Markers (BBM). These markers will help to
           build a volatile BBT in RAM.
 
-      nand-ecc-strength:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Maximum number of bits that can be corrected per ECC step.
-        minimum: 1
-
-      nand-ecc-step-size:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Number of data bytes covered by a single ECC step.
-        minimum: 1
-
       nand-ecc-maximize:
         $ref: /schemas/types.yaml#/definitions/flag
         description:
@@ -152,13 +116,6 @@ patternProperties:
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

