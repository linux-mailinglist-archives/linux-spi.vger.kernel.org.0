Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FD43E130
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhJ1MsW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 08:48:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44492 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhJ1MsS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 08:48:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19SCjVW2012061;
        Thu, 28 Oct 2021 07:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635425131;
        bh=55cY97sZuQSu5sHGYm8QYttrQaervHm8LmId67H+MBM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CK52x0H2aNJt6TfP8RpBOgfVGb0cuWiGJRNZBPgaNtaSBvMXdKwlR+CNltOvw4dfS
         nCkyQjaaLACqBQxD8vKWpndex82aK8x/xIG89IeNNlylYczuBU4KrDJLeO4C0+Y/F7
         aD7M/qxLT11zMVbneWbUtBC/7OsYxBhbUTGAmCv4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19SCjVp8120137
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Oct 2021 07:45:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Oct 2021 07:45:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Oct 2021 07:45:31 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19SCjJbC115317;
        Thu, 28 Oct 2021 07:45:27 -0500
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
Subject: [PATCH v2 2/3] spi: dt-bindings: cdns,qspi-nor: Move slave-specific properties out
Date:   Thu, 28 Oct 2021 18:15:17 +0530
Message-ID: <20211028124518.17370-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
In-Reply-To: <20211028124518.17370-1-p.yadav@ti.com>
References: <20211028124518.17370-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-slave-props.yaml schema contains slave-specific properties
for SPI controllers that should be present in the slave node. Move
slave-specific properties to a separate file and refer to it in
spi-slave-props.yaml.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

Changes in v2:
- New in v2.

 .../spi/cdns,qspi-nor-slave-props.yaml        | 42 +++++++++++++++++++
 .../bindings/spi/cdns,qspi-nor.yaml           | 33 ---------------
 .../bindings/spi/spi-slave-props.yaml         |  2 +
 3 files changed, 44 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml
new file mode 100644
index 000000000000..263382a5729a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-slave-props.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/cdns,qspi-nor-slave-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Slave-specific properties for the Cadence QSPI controller.
+
+description:
+  See spi-slave-props.yaml for more info.
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
diff --git a/Documentation/devicetree/bindings/spi/spi-slave-props.yaml b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
index 5166ec9b0353..4cc12a161da9 100644
--- a/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
@@ -87,5 +87,7 @@ properties:
       Delay, in microseconds, after a write transfer.
 
 # The controller specific properties go here.
+allOf:
+  - $ref: cdns,qspi-nor-slave-props.yaml#
 
 additionalProperties: true
-- 
2.33.1.835.ge9e5ba39a7

