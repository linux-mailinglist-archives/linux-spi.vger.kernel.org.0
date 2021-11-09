Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA0C44B2A3
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 19:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242300AbhKISW3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 13:22:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42454 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbhKISW1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Nov 2021 13:22:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1A9IJO8l054128;
        Tue, 9 Nov 2021 12:19:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636481964;
        bh=P8f2ZEXYcjg4YoTs0q8iQ+tIw9FB9artwaE4UPJPZcw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AYg2G0+j3/3KT+cCwQ16VAg26SqCf3XHrvW9pRtDMBk2nDoPL3uMfiuWVxnFjGO9x
         be/SixB7e5AUNvnQwicmQWHTh84MxaBL5fymCbApBcLe80BXdsBqz7EkKnm8KaEbZF
         pJM7aVhHaBKGfSovjI1v5Vv6MyfppsxDKHoo8Is4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1A9IJOCm080527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Nov 2021 12:19:24 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 9
 Nov 2021 12:19:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 9 Nov 2021 12:19:24 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1A9IJC53017044;
        Tue, 9 Nov 2021 12:19:21 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Mark Brown <broonie@kernel.org>,
        Nishanth Menon <nm@ti.com>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 2/3] spi: dt-bindings: cdns,qspi-nor: Move peripheral-specific properties out
Date:   Tue, 9 Nov 2021 23:49:10 +0530
Message-ID: <20211109181911.2251-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
In-Reply-To: <20211109181911.2251-1-p.yadav@ti.com>
References: <20211109181911.2251-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-peripheral-props.yaml schema contains peripheral-specific
properties for SPI controllers that should be present in the peripheral
node. Move peripheral-specific properties to a separate file and refer
to it in spi-peripheral-props.yaml.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

Changes in v3:
- s/slave/peripheral/g

Changes in v2:
- New in v2.

 .../spi/cdns,qspi-nor-peripheral-props.yaml   | 42 +++++++++++++++++++
 .../bindings/spi/cdns,qspi-nor.yaml           | 33 ---------------
 .../bindings/spi/spi-peripheral-props.yaml    |  2 +
 3 files changed, 44 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
new file mode 100644
index 000000000000..553601a441a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/cdns,qspi-nor-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral-specific properties for the Cadence QSPI controller.
+
+description:
+  See spi-peripheral-props.yaml for more info.
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  # cdns,qspi-nor.yaml
+  cdns,read-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Delay for read capture logic, in clock cycles.
+
+  cdns,tshsl-ns:
+    description:
+      Delay in nanoseconds for the length that the master mode chip select
+      outputs are de-asserted between transactions.
+
+  cdns,tsd2d-ns:
+    description:
+      Delay in nanoseconds between one chip select being de-activated
+      and the activation of another.
+
+  cdns,tchsh-ns:
+    description:
+      Delay in nanoseconds between last bit of current transaction and
+      deasserting the device chip select (qspi_n_ss_out).
+
+  cdns,tslch-ns:
+    description:
+      Delay in nanoseconds between setting qspi_n_ss_out low and
+      first bit transfer.
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index ca155abbda7a..a439e3ed753f 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -86,39 +86,6 @@ properties:
     items:
       enum: [ qspi, qspi-ocp ]
 
-# subnode's properties
-patternProperties:
-  "@[0-9a-f]+$":
-    type: object
-    description:
-      Flash device uses the below defined properties in the subnode.
-
-    properties:
-      cdns,read-delay:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Delay for read capture logic, in clock cycles.
-
-      cdns,tshsl-ns:
-        description:
-          Delay in nanoseconds for the length that the master mode chip select
-          outputs are de-asserted between transactions.
-
-      cdns,tsd2d-ns:
-        description:
-          Delay in nanoseconds between one chip select being de-activated
-          and the activation of another.
-
-      cdns,tchsh-ns:
-        description:
-          Delay in nanoseconds between last bit of current transaction and
-          deasserting the device chip select (qspi_n_ss_out).
-
-      cdns,tslch-ns:
-        description:
-          Delay in nanoseconds between setting qspi_n_ss_out low and
-          first bit transfer.
-
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 105fa2840e72..5dd209206e88 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -83,5 +83,7 @@ properties:
       Delay, in microseconds, after a write transfer.
 
 # The controller specific properties go here.
+allOf:
+  - $ref: cdns,qspi-nor-peripheral-props.yaml#
 
 additionalProperties: true
-- 
2.33.1.835.ge9e5ba39a7

