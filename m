Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1054116E0
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 16:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbhITO3M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 10:29:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59926 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbhITO3K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 10:29:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18KERQTu105736;
        Mon, 20 Sep 2021 09:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632148046;
        bh=H3QGSlcSnRS77N+PEgMD1LRiROGAMlbfA1Mi9rr2mO8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=abDlo1LjVlz5imyi8VP0vX3Sg+OYEp0gQB0L9Xnpm69LX4yJMoHZTK4qF2gHj9BYT
         LmlxnLDXdFNAx9WSYaUriWF0jtGlaKvpzBlfx+WksHEk/aE9u3WSSWcfVmrcqxc7cz
         qb7PqcvVdXfDBlAp8DRKSjrhfAFshuiBA9JeTmtk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18KERQbC045016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 09:27:26 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 09:27:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 09:27:26 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18KERE43100694;
        Mon, 20 Sep 2021 09:27:21 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     <michael@walle.cc>
Subject: [PATCH v2 1/2] dt-bindings: mtd: spi-nand: Convert to DT schema format
Date:   Mon, 20 Sep 2021 19:57:12 +0530
Message-ID: <20210920142713.129295-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920142713.129295-1-a-nandan@ti.com>
References: <20210920142713.129295-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert spi-nand.txt binding to YAML format with an added example.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
 .../devicetree/bindings/mtd/spi-nand.yaml     | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 5 deletions(-)
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
index 000000000000..601beba8d971
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI NAND flash
+
+maintainers:
+  - Apurva Nandan <a-nandan@ti.com>
+
+allOf:
+  - $ref: "mtd.yaml#"
+
+properties:
+  compatible:
+    const: spi-nand
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+  spi-rx-bus-width: true
+  spi-tx-bus-width: true
+  rx-sample-delay-ns: true
+
+  '#address-cells': true
+  '#size-cells': true
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@6 {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            compatible = "spi-nand";
+            reg = <0x6>;
+            spi-max-frequency = <42000000>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "boot";
+                    reg = <0 0x200000>;
+                };
+
+                partition@200000 {
+                    label = "rootfs";
+                    reg = <0x200000 0xce0000>;
+                };
+            };
+        };
+    };
-- 
2.25.1

