Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFCB3A122F
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhFILT1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 07:19:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54918 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbhFILT0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 07:19:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159BHGTB108420;
        Wed, 9 Jun 2021 06:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623237436;
        bh=3uPifnd/TjX5LJYTJnzADUgj18fof4k8C1XjKHqNUT0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oF4XciaZ453+j+Co0+bcDymmfFExtz9kNjgOrR5LJq5HNvkZCOZQXdoVvd0PXsReJ
         GzStCgJbhp/gaTBfnRN8WYFkavljq7KrWahyDjLuuZTl2g2VWwDYmDxJ/m51P7Kb8e
         NDedsi2cnCR2coyuWrR4CsSsJGO1VKUfIC74nmTs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159BHGoK085898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 06:17:16 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 06:17:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 06:17:15 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159BH7uG073420;
        Wed, 9 Jun 2021 06:17:12 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] spi: dt-bindings: add schema listing slave-specific properties
Date:   Wed, 9 Jun 2021 16:47:06 +0530
Message-ID: <20210609111707.9555-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210609111707.9555-1-p.yadav@ti.com>
References: <20210609111707.9555-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Many SPI controllers need to add properties to slave devices. This could
be the delay in clock or data lines, etc. These properties are
controller specific but need to be defined in the slave node because
they are per-slave and there can be multiple slaves attached to a
controller.

If these properties are not added to the slave binding, then the dtbs
check emits a warning. But these properties do not make much sense in
the slave binding because they are controller-specific and they will
just pollute every slave binding. So this binding is added to collect
all such properties from all such controllers. Slave bindings should
simply refer to this binding and they should be rid of the warnings.

There are some limitations with this approach. Firstly, there is no way
to specify required properties. The schema contains properties for all
controllers and there is no way to know which controller is being used.
Secondly, there is no way to restrict additional properties. Since this
schema will be used with an allOf operator, additionalProperties needs
to be true. In addition, the slave schema will have to set
unevaluatedProperties: false.

Despite these limitations, this appears to be the best solution to this
problem that doesn't involve modifying existing tools or schema specs.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

 .../bindings/spi/cdns,qspi-nor.yaml           | 33 ------------
 .../bindings/spi/spi-slave-props.yaml         | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-props.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 0e7087cc8bf9..0730e6a8dc4a 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -74,39 +74,6 @@ properties:
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
new file mode 100644
index 000000000000..b2248e01dc43
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-slave-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Slave-specific properties for a SPI bus.
+
+description: |
+  Many SPI controllers need to add properties to slave devices. This could be
+  the delay in clock or data lines, etc. These properties are controller
+  specific but need to be defined in the slave node because they are per-slave
+  and there can be multiple slaves attached to a controller.
+
+  If these properties are not added to the slave binding, then the dtbs check
+  emits a warning. But these properties do not make much sense in the slave
+  binding because they are controller-specific and they will just pollute every
+  slave binding. So this binding is added to collect all such properties from
+  all such controllers. Slave bindings should simply refer to this binding and
+  they should be rid of the warnings.
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
-- 
2.30.0

