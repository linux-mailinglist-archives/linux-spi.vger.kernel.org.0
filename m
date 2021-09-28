Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00FB41B19B
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 16:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbhI1OJR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 10:09:17 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:28704 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241026AbhI1OJQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Sep 2021 10:09:16 -0400
X-IronPort-AV: E=Sophos;i="5.85,329,1624287600"; 
   d="scan'208";a="95295281"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Sep 2021 23:07:36 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 92C864007535;
        Tue, 28 Sep 2021 23:07:32 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/6] dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
Date:   Tue, 28 Sep 2021 15:07:16 +0100
Message-Id: <20210928140721.8805-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
the RPC-IF interface found on R-Car Gen3 SoC's.

This patch adds a new compatible string to identify the RZ/G2L family
so that the timing values on RZ/G2L can be adjusted.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../memory-controllers/renesas,rpc-if.yaml    | 51 ++++++++++++++-----
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index d25072c414e4..105b5157989b 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -24,16 +24,22 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r8a774a1-rpc-if       # RZ/G2M
-          - renesas,r8a774b1-rpc-if       # RZ/G2N
-          - renesas,r8a774c0-rpc-if       # RZ/G2E
-          - renesas,r8a774e1-rpc-if       # RZ/G2H
-          - renesas,r8a77970-rpc-if       # R-Car V3M
-          - renesas,r8a77980-rpc-if       # R-Car V3H
-          - renesas,r8a77995-rpc-if       # R-Car D3
-      - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 or RZ/G2 device
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r8a774a1-rpc-if       # RZ/G2M
+              - renesas,r8a774b1-rpc-if       # RZ/G2N
+              - renesas,r8a774c0-rpc-if       # RZ/G2E
+              - renesas,r8a774e1-rpc-if       # RZ/G2H
+              - renesas,r8a77970-rpc-if       # R-Car V3M
+              - renesas,r8a77980-rpc-if       # R-Car V3H
+              - renesas,r8a77995-rpc-if       # R-Car D3
+          - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 or RZ/G2{E,H,M,N} device
+
+      - items:
+          - enum:
+              - renesas,r9a07g044-rpc-if      # RZ/G2{L,LC}
+          - const: renesas,rzg2l-rpc-if       # RZ/G2L family
 
   reg:
     items:
@@ -47,8 +53,7 @@ properties:
       - const: dirmap
       - const: wbuf
 
-  clocks:
-    maxItems: 1
+  clocks: true
 
   power-domains:
     maxItems: 1
@@ -66,8 +71,6 @@ patternProperties:
             - cfi-flash
             - jedec,spi-nor
 
-unevaluatedProperties: false
-
 required:
   - compatible
   - reg
@@ -78,6 +81,26 @@ required:
   - '#address-cells'
   - '#size-cells'
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - renesas,rzg2l-rpc-if
+then:
+  properties:
+    clocks:
+      items:
+        - description: SPI Multi IO Register access clock (SPI_CLK2)
+        - description: SPI Multi IO Main clock (SPI_CLK).
+
+else:
+  properties:
+    clocks:
+      maxItems: 1
+
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/clock/renesas-cpg-mssr.h>
-- 
2.17.1

