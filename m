Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294FE68041E
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jan 2023 04:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjA3DHr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 29 Jan 2023 22:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjA3DHg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 29 Jan 2023 22:07:36 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466121949;
        Sun, 29 Jan 2023 19:07:30 -0800 (PST)
X-UUID: 3af0593ca04b11ed945fc101203acc17-20230130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xfxOyIUqvJdjIUdIV7o0cMFXghWPkVqR/RyOXrnqn2M=;
        b=Yi/3YOR3eQjE8XOiUuSnK4bIQ7EKOcLtCXVZWN6y9stggUJcCEGnLAeJNQ8cykCEkc5wPK8FREJGDFC2eP/xibQrgzzvKWjT8ckyIJfY4/8iRIa9hmSP7XzSdwmwoyhhzaM0+N4Bg71CjTnVcin3eisCwiu7JxWr6ppBqJxt/qA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:25704b3a-b1ac-45c5-9b8a-7eb63855cf38,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:63e0dbf6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 3af0593ca04b11ed945fc101203acc17-20230130
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1697707793; Mon, 30 Jan 2023 11:07:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 30 Jan 2023 11:07:27 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 30 Jan 2023 11:07:26 +0800
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
Subject: [RESEND PATCH v5 06/10] dt-bindings: spi: mtk-snfi: Add read latch latency property
Date:   Mon, 30 Jan 2023 11:06:52 +0800
Message-ID: <20230130030656.12127-7-xiangsheng.hou@mediatek.com>
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

Add mediatek,rx-latch-latency-ns property which adjust data read
latch latency in the unit of nanoseconds.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
index bab23f1b11fd..1e5e89a693c3 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
@@ -45,6 +45,9 @@ properties:
     description: device-tree node of the accompanying ECC engine.
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  mediatek,rx-latch-latency-ns:
+    description: Data read latch latency, unit is nanoseconds.
+
 required:
   - compatible
   - reg
-- 
2.25.1

