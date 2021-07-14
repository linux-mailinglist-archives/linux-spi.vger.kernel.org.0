Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9E3C83E2
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jul 2021 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhGNLdK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Jul 2021 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbhGNLdI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Jul 2021 07:33:08 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E9C061764
        for <linux-spi@vger.kernel.org>; Wed, 14 Jul 2021 04:30:17 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by laurent.telenet-ops.be with bizsmtp
        id UzWF2500Q1ccfby01zWF5D; Wed, 14 Jul 2021 13:30:15 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3d5j-0017bO-1o; Wed, 14 Jul 2021 13:30:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3d5i-00A9SG-Bi; Wed, 14 Jul 2021 13:30:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements
Date:   Wed, 14 Jul 2021 13:30:13 +0200
Message-Id: <d430f9c06d6691fe8a98f923cdb7ca13772834b1.1626262043.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

  - Add missing "#{address,size}-cells",
  - Fix rejection of legitimate flash subnodes containing multiple
    compatible values,
  - Add missing list of required properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../memory-controllers/renesas,rpc-if.yaml    | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 990489fdd2ac33fe..c0d899a2305361b1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -56,17 +56,34 @@ properties:
   resets:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
 patternProperties:
   "flash@[0-9a-f]+$":
     type: object
     properties:
       compatible:
-        enum:
-          - cfi-flash
-          - jedec,spi-nor
+        contains:
+          enum:
+            - cfi-flash
+            - jedec,spi-nor
 
 unevaluatedProperties: false
 
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - power-domains
+  - resets
+  - '#address-cells'
+  - '#size-cells'
+
 examples:
   - |
     #include <dt-bindings/clock/renesas-cpg-mssr.h>
-- 
2.25.1

