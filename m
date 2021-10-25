Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235FB43A532
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 22:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhJYU7G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 16:59:06 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:33583 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234494AbhJYU7G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Oct 2021 16:59:06 -0400
X-IronPort-AV: E=Sophos;i="5.87,181,1631545200"; 
   d="scan'208";a="98385686"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Oct 2021 05:56:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5E61C41003BB;
        Tue, 26 Oct 2021 05:56:39 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/7] dt-bindings: memory: renesas,rpc-if: Add support for the R9A07G044
Date:   Mon, 25 Oct 2021 21:56:25 +0100
Message-Id: <20211025205631.21151-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
the RPC-IF interface found on R-Car Gen3 SoC's.

This patch adds a new compatible string to identify the RZ/G2L family
so that the timing values on RZ/G2L can be adjusted.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2:
 * Rebased patch on top of V3U bindings
 * Included RB tags
---
 .../memory-controllers/renesas,rpc-if.yaml    | 53 +++++++++++++------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 9da80e8f2444..43391a2d5bc5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -24,17 +24,23 @@ allOf:
 
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
-          - renesas,r8a779a0-rpc-if       # R-Car V3U
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
+              - renesas,r8a779a0-rpc-if       # R-Car V3U
+          - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 or RZ/G2{E,H,M,N} device
+
+      - items:
+          - enum:
+              - renesas,r9a07g044-rpc-if      # RZ/G2{L,LC}
+          - const: renesas,rzg2l-rpc-if       # RZ/G2L family
 
   reg:
     items:
@@ -48,8 +54,7 @@ properties:
       - const: dirmap
       - const: wbuf
 
-  clocks:
-    maxItems: 1
+  clocks: true
 
   power-domains:
     maxItems: 1
@@ -67,8 +72,6 @@ patternProperties:
             - cfi-flash
             - jedec,spi-nor
 
-unevaluatedProperties: false
-
 required:
   - compatible
   - reg
@@ -79,6 +82,26 @@ required:
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

