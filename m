Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0251D47C45D
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 18:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbhLURBK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Dec 2021 12:01:10 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55447 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbhLURBI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 12:01:08 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 91CBB240008;
        Tue, 21 Dec 2021 17:01:05 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 2/3] spi: dt-bindings: Describe stacked/parallel memories modes
Date:   Tue, 21 Dec 2021 18:00:57 +0100
Message-Id: <20211221170058.18333-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211221170058.18333-1-miquel.raynal@bootlin.com>
References: <20211221170058.18333-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Describe two new memories modes:
- A stacked mode when the bus is common but the address space extended
  with an additinals wires.
- A parallel mode with parallel busses accessing parallel flashes where
  the data is spread.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Hello Rob,

I know the below does not pass the tests (at least the example patch 3
does not pass) but I believe the issue is probably on the tooling side
because the exact same thing with uing32-array instead is accepted. The
problem comes from the minItems/maxItems lines. Without them, this is
okay. The maxItems btw matches the "good enough value for now" idea.

The errors I get are:

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-controller.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
  DTEX    Documentation/devicetree/bindings/spi/spi-controller.example.dts
  DTC     Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml
/src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
	From schema: /src/Documentation/devicetree/bindings/spi/spi-controller.yaml
/src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: flash@2:stacked-memories: [[268435456, 268435456]] is too short
	From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
/src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'display@0', 'sensor@1', 'flash@2' were unexpected)
	From schema: /src/Documentation/devicetree/bindings/spi/mxs-spi.yaml
/src/Documentation/devicetree/bindings/spi/spi-controller.example.dt.yaml: flash@2: stacked-memories: [[268435456, 268435456]] is too short
	From schema: /src/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml


 .../bindings/spi/spi-peripheral-props.yaml    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5dd209206e88..fedb7ae98ff6 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -82,6 +82,31 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  stacked-memories:
+    description: Several SPI memories can be wired in stacked mode.
+      This basically means that either a device features several chip
+      selects, or that different devices must be seen as a single
+      bigger chip. This basically doubles (or more) the total address
+      space with only a single additional wire, while still needing
+      to repeat the commands when crossing a chip boundary. The size of
+      each chip should be provided as members of the array.
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    minItems: 2
+    maxItems: 4
+
+  parallel-memories:
+    description: Several SPI memories can be wired in parallel mode.
+      The devices are physically on a different buses but will always
+      act synchronously as each data word is spread across the
+      different memories (eg. even bits are stored in one memory, odd
+      bits in the other). This basically doubles the address space and
+      the throughput while greatly complexifying the wiring because as
+      many busses as devices must be wired. The size of each chip should
+      be provided as members of the array.
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    minItems: 2
+    maxItems: 4
+
 # The controller specific properties go here.
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
-- 
2.27.0

