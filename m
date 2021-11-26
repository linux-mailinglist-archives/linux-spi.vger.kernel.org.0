Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19F45ED06
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 12:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376824AbhKZL5F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 06:57:05 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:56351 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347749AbhKZLzE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 06:55:04 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 1A80CC278F;
        Fri, 26 Nov 2021 11:39:52 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B1D7EFF80B;
        Fri, 26 Nov 2021 11:39:28 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 01/20] dt-bindings: mtd: nand-controller: Fix the reg property description
Date:   Fri, 26 Nov 2021 12:39:05 +0100
Message-Id: <20211126113924.310459-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211126113924.310459-1-miquel.raynal@bootlin.com>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The reg property of a NAND device always references the chip-select(s).
The ready/busy lines are described in the nand-rb property. I believe
this was a harmless copy/paste error during the conversion to yaml.

Fixes: 212e49693592 ("dt-bindings: mtd: Add YAML schemas for the generic NAND options")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/nand-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index bd217e6f5018..811f03978fc6 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -55,7 +55,7 @@ patternProperties:
     properties:
       reg:
         description:
-          Contains the native Ready/Busy IDs.
+          Contains the chip-select IDs.
 
       nand-ecc-engine:
         allOf:
-- 
2.27.0

