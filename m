Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA89E6BB6B0
	for <lists+linux-spi@lfdr.de>; Wed, 15 Mar 2023 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjCOOzo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Mar 2023 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjCOOzV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Mar 2023 10:55:21 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259B9384E
        for <linux-spi@vger.kernel.org>; Wed, 15 Mar 2023 07:54:27 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id Yeu9290031C8whw06eu9fC; Wed, 15 Mar 2023 15:54:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pcSVO-00CIIr-Hn;
        Wed, 15 Mar 2023 15:54:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pcSW0-00D2JO-UQ;
        Wed, 15 Mar 2023 15:54:08 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: spi: renesas,sh-msiof: Miscellaneous improvements
Date:   Wed, 15 Mar 2023 15:54:07 +0100
Message-Id: <052af97ecbaa9ba6e0d406883dd3389fa397579a.1678891999.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make "clocks" and "power-domains" required everywhere.
Make "resets" required on R-Car Gen2 and newer (i.e. all but SH-Mobile).

Update the example to match reality:
  - Use interrupt binding definitions instead of hardcoded numbers,
  - Convert to new-style CPG/MSSR bindings,
  - Add missing "power-domains" and "resets" properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/spi/renesas,sh-msiof.yaml        | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 491a695a2deb3b83..00acbbb0f65dcf57 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -149,23 +149,38 @@ required:
   - compatible
   - reg
   - interrupts
+  - clocks
+  - power-domains
   - '#address-cells'
   - '#size-cells'
 
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          const: renesas,sh-mobile-msiof
+then:
+  required:
+    - resets
+
 unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/r8a7791-clock.h>
-    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7791-sysc.h>
 
     msiof0: spi@e6e20000 {
         compatible = "renesas,msiof-r8a7791", "renesas,rcar-gen2-msiof";
         reg = <0xe6e20000 0x0064>;
-        interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
+        interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD 000>;
         dmas = <&dmac0 0x51>, <&dmac0 0x52>;
         dma-names = "tx", "rx";
+        power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+        resets = <&cpg 0>;
         #address-cells = <1>;
         #size-cells = <0>;
     };
-- 
2.34.1

