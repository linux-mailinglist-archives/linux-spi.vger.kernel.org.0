Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1868041A
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jan 2023 04:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjA3DHd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Jan 2023 22:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjA3DH3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Jan 2023 22:07:29 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76111E9CD;
        Sun, 29 Jan 2023 19:07:27 -0800 (PST)
X-UUID: 37c5f816a04b11ed945fc101203acc17-20230130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wodpxQJxS9WBV/Id1cRLy+b4gQiIXHj/BKyDu9o+YQM=;
        b=GWsUH58GiU0sBR/lPS35j7ERLmBtlEiTNBy3sSIYQBMxYAGmmJcdnN+izpmNK9x4Stsjk34bX6zbQh1Y8Hjhrcqn+SAe4/6LuDW7vDcOoXfTkK4FRCnas+rAPUONii52RiQc/9kd64BFnLXJo6+ZnB0skFgkLG9eUfr8LXEPbVg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:eb365538-8438-49b9-8db8-823ba91c9313,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:3ca2d6b,CLOUDID:fbdfdbf6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 37c5f816a04b11ed945fc101203acc17-20230130
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 934561536; Mon, 30 Jan 2023 11:07:23 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 30 Jan 2023 11:07:22 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 30 Jan 2023 11:07:21 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
CC:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [RESEND PATCH v5 04/10] dt-bindings: spi: mtk-snfi: Add compatible for MT7986
Date:   Mon, 30 Jan 2023 11:06:50 +0800
Message-ID: <20230130030656.12127-5-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130030656.12127-1-xiangsheng.hou@mediatek.com>
References: <20230130030656.12127-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add dt-bindings documentation of SPI NAND controller
for MediaTek MT7986 SoC platform. And add optional
nfi_hclk property which is needed for MT7986.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/spi/mediatek,spi-mtk-snfi.yaml   | 51 +++++++++++++++----
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
index 6e6e02c91780..bab23f1b11fd 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
@@ -18,14 +18,12 @@ description: |
   using the accompanying ECC engine. There should be only one spi
   slave device following generic spi bindings.
 
-allOf:
-  - $ref: /schemas/spi/spi-controller.yaml#
-
 properties:
   compatible:
     enum:
       - mediatek,mt7622-snand
       - mediatek,mt7629-snand
+      - mediatek,mt7986-snand
 
   reg:
     items:
@@ -36,14 +34,12 @@ properties:
       - description: NFI interrupt
 
   clocks:
-    items:
-      - description: clock used for the controller
-      - description: clock used for the SPI bus
+    minItems: 2
+    maxItems: 3
 
   clock-names:
-    items:
-      - const: nfi_clk
-      - const: pad_clk
+    minItems: 2
+    maxItems: 3
 
   nand-ecc-engine:
     description: device-tree node of the accompanying ECC engine.
@@ -57,6 +53,43 @@ required:
   - clock-names
   - nand-ecc-engine
 
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt7622-snand
+            - mediatek,mt7629-snand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: clock used for the controller
+            - description: clock used for the SPI bus
+        clock-names:
+          items:
+            - const: nfi_clk
+            - const: pad_clk
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt7986-snand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: clock used for the controller
+            - description: clock used for the SPI bus
+            - description: clock used for the AHB bus
+        clock-names:
+          items:
+            - const: nfi_clk
+            - const: pad_clk
+            - const: nfi_hclk
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

