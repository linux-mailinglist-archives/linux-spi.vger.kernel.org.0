Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143A343E129
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJ1MsN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 08:48:13 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45442 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJ1MsM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 08:48:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19SCjR0v046437;
        Thu, 28 Oct 2021 07:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635425127;
        bh=w+hSvbfR+PYJFi7fskwYrwY5oRC/obVuUWrRwUBB7R0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HZ6gDYUsOYof0zGIA034zc8qvYA+Xv1hDNn0CF1M9gm6zACtR/1i4x/7gHLOL3BFR
         3MhPPHU2j8fCRSyrvgzPYB5F+Q/yFHrRMKXQGpZfahHguOYgczf6jAO4wM/pNf2vDH
         jF6Iir1V8GsdYSgCkrzOcyDxUDDnP6vhmTNYHcO8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19SCjR4u079556
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Oct 2021 07:45:27 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 28
 Oct 2021 07:45:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 28 Oct 2021 07:45:27 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19SCjJbB115317;
        Thu, 28 Oct 2021 07:45:24 -0500
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
Subject: [PATCH v2 1/3] spi: dt-bindings: add schema listing slave-specific properties
Date:   Thu, 28 Oct 2021 18:15:16 +0530
Message-ID: <20211028124518.17370-2-p.yadav@ti.com>
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

Changes in v2:
- Move other subnode properties listed in spi-controller.yaml to
  spi-slave-props.yaml
- Move the Cadence controller-specific properties out of
  spi-slave-props.yaml. They will be added in a separate file.
- Add a reference to spi-slave-props.yaml in spi-controller.yaml.
- Update description.

 .../bindings/spi/spi-controller.yaml          | 69 +-------------
 .../bindings/spi/spi-slave-props.yaml         | 91 +++++++++++++++++++
 2 files changed, 93 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-props.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 8246891602e7..ff770657e214 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -94,73 +94,8 @@ patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
 
-    properties:
-      compatible:
-        description:
-          Compatible of the SPI device.
-
-      reg:
-        minItems: 1
-        maxItems: 256
-        items:
-          minimum: 0
-          maximum: 256
-        description:
-          Chip select used by the device.
-
-      spi-3wire:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires 3-wire mode.
-
-      spi-cpha:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires shifted clock phase (CPHA) mode.
-
-      spi-cpol:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires inverse clock polarity (CPOL) mode.
-
-      spi-cs-high:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires the chip select active high.
-
-      spi-lsb-first:
-        $ref: /schemas/types.yaml#/definitions/flag
-        description:
-          The device requires the LSB first mode.
-
-      spi-max-frequency:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description:
-          Maximum SPI clocking speed of the device in Hz.
-
-      spi-rx-bus-width:
-        description:
-          Bus width to the SPI bus used for read transfers.
-          If 0 is provided, then no RX will be possible on this device.
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [0, 1, 2, 4, 8]
-        default: 1
-
-      spi-rx-delay-us:
-        description:
-          Delay, in microseconds, after a read transfer.
-
-      spi-tx-bus-width:
-        description:
-          Bus width to the SPI bus used for write transfers.
-          If 0 is provided, then no TX will be possible on this device.
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [0, 1, 2, 4, 8]
-        default: 1
-
-      spi-tx-delay-us:
-        description:
-          Delay, in microseconds, after a write transfer.
+    allOf:
+      - $ref: spi-slave-props.yaml
 
     required:
       - compatible
diff --git a/Documentation/devicetree/bindings/spi/spi-slave-props.yaml b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
new file mode 100644
index 000000000000..5166ec9b0353
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-slave-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Slave-specific properties for a SPI bus.
+
+description: |
+  Many SPI controllers need to add properties to slave devices. They could be
+  common properties like spi-max-frequency, spi-cpha, etc. or they could be
+  controller specific like delay in clock or data lines, etc. These properties
+  need to be defined in the slave node because they are per-slave and there can
+  be multiple slaves attached to a controller. All those properties are listed
+  here. The controller specific properties should go in their own separate
+  schema that should be referenced from here.
+
+maintainers:
+  - Pratyush Yadav <p.yadav@ti.com>
+
+properties:
+  compatible:
+    description:
+      Compatible of the SPI device.
+
+  reg:
+    minItems: 1
+    maxItems: 256
+    items:
+      minimum: 0
+      maximum: 256
+    description:
+      Chip select used by the device.
+
+  spi-3wire:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires 3-wire mode.
+
+  spi-cpha:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires shifted clock phase (CPHA) mode.
+
+  spi-cpol:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires inverse clock polarity (CPOL) mode.
+
+  spi-cs-high:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires the chip select active high.
+
+  spi-lsb-first:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The device requires the LSB first mode.
+
+  spi-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum SPI clocking speed of the device in Hz.
+
+  spi-rx-bus-width:
+    description:
+      Bus width to the SPI bus used for read transfers.
+      If 0 is provided, then no RX will be possible on this device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 4, 8]
+    default: 1
+
+  spi-rx-delay-us:
+    description:
+      Delay, in microseconds, after a read transfer.
+
+  spi-tx-bus-width:
+    description:
+      Bus width to the SPI bus used for write transfers.
+      If 0 is provided, then no TX will be possible on this device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 4, 8]
+    default: 1
+
+  spi-tx-delay-us:
+    description:
+      Delay, in microseconds, after a write transfer.
+
+# The controller specific properties go here.
+
+additionalProperties: true
-- 
2.33.1.835.ge9e5ba39a7

