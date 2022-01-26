Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC11249C897
	for <lists+linux-spi@lfdr.de>; Wed, 26 Jan 2022 12:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiAZL0O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Jan 2022 06:26:14 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57183 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbiAZL0N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jan 2022 06:26:13 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ACC126000D;
        Wed, 26 Jan 2022 11:26:10 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: mtd: spi-nor: Allow two CS per device
Date:   Wed, 26 Jan 2022 12:26:05 +0100
Message-Id: <20220126112608.955728-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220126112608.955728-1-miquel.raynal@bootlin.com>
References: <20220126112608.955728-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Xilinx QSPI controller has two advanced modes which allow the
controller to behave differently and consider two flashes as one single
storage.

One of these two modes is quite complex to support from a binding point
of view and is the dual parallel memories. In this mode, each byte of
data is stored in both devices: the even bits in one, the odd bits in
the other. The split is automatically handled by the QSPI controller and
is transparent for the user.

The other mode is simpler to support, it is called dual stacked
memories. The controller shares the same SPI bus but each of the devices
contain half of the data. Once in this mode, the controller does not
follow CS requests but instead internally wires the two CS levels with
the value of the most significant address bit.

Supporting these two modes will involve core changes which include the
possibility of providing two CS for a single SPI device

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 39421f7233e4..4abfb4cfc157 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -47,7 +47,8 @@ properties:
       identified by the JEDEC READ ID opcode (0x9F).
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   spi-max-frequency: true
   spi-rx-bus-width: true
-- 
2.27.0

