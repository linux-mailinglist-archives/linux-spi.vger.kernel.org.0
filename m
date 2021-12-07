Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2FA46B757
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 10:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhLGJiW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 04:38:22 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58809 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbhLGJiA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 04:38:00 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0ACE560012;
        Tue,  7 Dec 2021 09:34:27 +0000 (UTC)
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
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 03/22] dt-bindings: mtd: nand-controller: Harmonize the property types
Date:   Tue,  7 Dec 2021 10:34:03 +0100
Message-Id: <20211207093422.166934-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207093422.166934-1-miquel.raynal@bootlin.com>
References: <20211207093422.166934-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Harmonize the different properties in this file by:
* dropping the non-necessary allOf's
* always defining the keywords in the following order:
    - first: "type"/"$ref",
    - second: "description" (when relevant),
    - then the other generic keywords ("enum", "default", etc).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/mtd/nand-controller.yaml | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 5cd144a9ec99..7024ca24c2e2 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -58,8 +58,7 @@ patternProperties:
           Contains the chip-select IDs.
 
       nand-ecc-engine:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/phandle
+        $ref: /schemas/types.yaml#/definitions/phandle
         description: |
           A phandle on the hardware ECC engine if any. There are
           basically three possibilities:
@@ -79,25 +78,24 @@ patternProperties:
         description: Do not use any ECC correction.
 
       nand-ecc-placement:
-        allOf:
-          - $ref: /schemas/types.yaml#/definitions/string
-          - enum: [ oob, interleaved ]
+        $ref: /schemas/types.yaml#/definitions/string
         description:
           Location of the ECC bytes. This location is unknown by default
           but can be explicitly set to "oob", if all ECC bytes are
           known to be stored in the OOB area, or "interleaved" if ECC
           bytes will be interleaved with regular data in the main area.
+        enum: [ oob, interleaved ]
 
       nand-ecc-algo:
+        $ref: /schemas/types.yaml#/definitions/string
         description:
           Desired ECC algorithm.
-        $ref: /schemas/types.yaml#/definitions/string
         enum: [hamming, bch, rs]
 
       nand-bus-width:
+        $ref: /schemas/types.yaml#/definitions/uint32
         description:
           Bus width to the NAND chip
-        $ref: /schemas/types.yaml#/definitions/uint32
         enum: [8, 16]
         default: 8
 
@@ -113,15 +111,15 @@ patternProperties:
           build a volatile BBT in RAM.
 
       nand-ecc-strength:
+        $ref: /schemas/types.yaml#/definitions/uint32
         description:
           Maximum number of bits that can be corrected per ECC step.
-        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 1
 
       nand-ecc-step-size:
+        $ref: /schemas/types.yaml#/definitions/uint32
         description:
           Number of data bytes covered by a single ECC step.
-        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 1
 
       nand-ecc-maximize:
-- 
2.27.0

