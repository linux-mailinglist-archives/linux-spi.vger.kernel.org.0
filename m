Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBDF45ED0C
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 12:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhKZL6V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 06:58:21 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:54453 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbhKZL4T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 06:56:19 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 57786C18D1;
        Fri, 26 Nov 2021 11:39:57 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1AA0AFF815;
        Fri, 26 Nov 2021 11:39:33 +0000 (UTC)
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 04/20] dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
Date:   Fri, 26 Nov 2021 12:39:08 +0100
Message-Id: <20211126113924.310459-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211126113924.310459-1-miquel.raynal@bootlin.com>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Let's get rid of spi-nand.txt by converting it to yaml schema. While at
converting this file, let's actually pull all the generic properties
from nand-chip.yaml which might apply to a SPI-NAND chip.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/spi-nand.txt      |  5 ----
 .../devicetree/bindings/mtd/spi-nand.yaml     | 27 +++++++++++++++++++
 2 files changed, 27 insertions(+), 5 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml

diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
deleted file mode 100644
index 8b51f3b6d55c..000000000000
--- a/Documentation/devicetree/bindings/mtd/spi-nand.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-SPI NAND flash
-
-Required properties:
-- compatible: should be "spi-nand"
-- reg: should encode the chip-select line used to access the NAND chip
diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
new file mode 100644
index 000000000000..19ac57dcffc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-NAND flash device tree bindings
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+allOf:
+  - $ref: "nand-chip.yaml#"
+
+properties:
+  compatible:
+    const: spi-nand
+
+  reg:
+    maxItems: 1
+    description: Encode the chip-select line on the SPI bus
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
-- 
2.27.0

