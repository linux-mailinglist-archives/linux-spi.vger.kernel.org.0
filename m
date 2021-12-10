Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD68470B8F
	for <lists+linux-spi@lfdr.de>; Fri, 10 Dec 2021 21:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbhLJUOW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Dec 2021 15:14:22 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41389 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343620AbhLJUOV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Dec 2021 15:14:21 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 4EE0A240008;
        Fri, 10 Dec 2021 20:10:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 2/3] spi: dt-bindings: Describe stacked/parallel memories modes
Date:   Fri, 10 Dec 2021 21:10:38 +0100
Message-Id: <20211210201039.729961-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210201039.729961-1-miquel.raynal@bootlin.com>
References: <20211210201039.729961-1-miquel.raynal@bootlin.com>
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
 .../bindings/spi/spi-peripheral-props.yaml    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5dd209206e88..4194fee8f556 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -82,6 +82,35 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  stacked-memories:
+    $ref: /schemas/types.yaml#/definitions/uint64-matrix
+    description: Several SPI memories can be wired in stacked mode.
+      This basically means that either a device features several chip
+      selects, or that different devices must be seen as a single
+      bigger chip. This basically doubles (or more) the total address
+      space with only a single additional wire, while still needing
+      to repeat the commands when crossing a chip boundary. The size of
+      each chip should be provided as members of the array.
+    minItems: 2
+    maxItems: 2
+    items:
+      maxItems: 1
+
+  parallel-memories:
+    $ref: /schemas/types.yaml#/definitions/uint64-matrix
+    description: Several SPI memories can be wired in parallel mode.
+      The devices are physically on a different buses but will always
+      act synchronously as each data word is spread across the
+      different memories (eg. even bits are stored in one memory, odd
+      bits in the other). This basically doubles the address space and
+      the throughput while greatly complexifying the wiring because as
+      many busses as devices must be wired. The size of each chip should
+      be provided as members of the array.
+    minItems: 2
+    maxItems: 2
+    items:
+      maxItems: 1
+
 # The controller specific properties go here.
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
-- 
2.27.0

