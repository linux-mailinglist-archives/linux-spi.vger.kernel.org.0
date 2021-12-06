Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8462146931E
	for <lists+linux-spi@lfdr.de>; Mon,  6 Dec 2021 10:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbhLFKC6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Dec 2021 05:02:58 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34503 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbhLFKC6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Dec 2021 05:02:58 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B73FB24001E;
        Mon,  6 Dec 2021 09:59:27 +0000 (UTC)
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
        Michal Simek <monstr@monstr.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 2/3] spi: dt-bindings: Describe stacked/parallel memories modes
Date:   Mon,  6 Dec 2021 10:59:20 +0100
Message-Id: <20211206095921.33302-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211206095921.33302-1-miquel.raynal@bootlin.com>
References: <20211206095921.33302-1-miquel.raynal@bootlin.com>
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
 .../bindings/spi/spi-peripheral-props.yaml    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5dd209206e88..13aa6a2374c9 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -82,6 +82,27 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  stacked-memories:
+    type: boolean
+    description: Several SPI memories can be wired in stacked mode.
+      This basically means that either a device features several chip
+      selects, or that different devices must be seen as a single
+      bigger chip. This basically doubles (or more) the total address
+      space with only a single additional wire, while still needing
+      to repeat the commands when crossing a chip boundary. XIP is
+      usually not supported in this mode.
+
+  parallel-memories:
+    type: boolean
+    description: Several SPI memories can be wired in parallel mode.
+      The devices are physically on a different buses but will always
+      act synchronously as each data word is spread across the
+      different memories (eg. even bits are stored in one memory, odd
+      bits in the other). This basically doubles the address space and
+      the throughput while greatly complexifying the wiring because as
+      many busses as devices must be wired. XIP is usually not
+      supported in this mode.
+
 # The controller specific properties go here.
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
-- 
2.27.0

