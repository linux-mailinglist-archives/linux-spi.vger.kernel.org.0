Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B733D7A61
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhG0QBM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbhG0QBL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Jul 2021 12:01:11 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7D7C061757
        for <linux-spi@vger.kernel.org>; Tue, 27 Jul 2021 09:01:10 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:b0a9:7e88:5ca4:551a])
        by michel.telenet-ops.be with bizsmtp
        id aG172500F1fSPfK06G177b; Tue, 27 Jul 2021 18:01:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8PVz-001RuT-4K; Tue, 27 Jul 2021 18:01:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8PVy-00Fqnr-Ml; Tue, 27 Jul 2021 18:01:06 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements
Date:   Tue, 27 Jul 2021 18:01:05 +0200
Message-Id: <d81b59a513c2a5204c8378b4a89cd07f97c46797.1627401508.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

  - Fix rejection of legitimate flash subnodes containing multiple
    compatible values,
  - Add missing list of required properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop #{address,size}-cells.
---
 .../memory-controllers/renesas,rpc-if.yaml      | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 990489fdd2ac33fe..d25072c414e45326 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -61,12 +61,23 @@ patternProperties:
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

