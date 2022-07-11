Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9755D7A6
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiF0Tlp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 15:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiF0Tl0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 15:41:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9E17070
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso2716235wmq.4
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9g/PqG7lJoC3tmWnVa7QkZ4DkjcrfTJ4GH+uywTgjo=;
        b=fBShLNpQtv7TUZ91barPFgoTIEUnvm+iOoWI9KSV5y0be3zWz++I0wVDa70W2a6UsW
         iXrpn0eNJnshM7Kg55T3v/FLL9Q2mB7Ai4DrCGnyMbVk6pF/REgpCn9dUSy7lyAopAD9
         j3r06NCn19/uMcLoNccxZH0ckot2X1xiVMt7CCRH8wCkuk+NvcyyAXTP5JeicxJF3HpN
         rRSWQ2U4ZoJ4LKlwoYlXVySg7PhPnChMKHnphYYQUG21xodnEwaQiTi5aEuy06+GQjjH
         UFLICFNEkOOqHMpGQhj4Pn3kP2UFmRFdOmnFY32LKUWdvF9DjtySRJa8hHsK5o6snFRV
         hdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9g/PqG7lJoC3tmWnVa7QkZ4DkjcrfTJ4GH+uywTgjo=;
        b=i0bLqTc4SWqElp/u09kQ5/aPcZHVaoYL5Ep9i03qRSa0crBcArWzkNsDrelVArSLKo
         uxRv1Q0CJMcb2xnz763/jecuLOcRSiLSQ2OuayCb/SUOdHvnCXjUGZ+ZG5LbEjeJeTft
         pRNM5uRh8D9SgLBOkh/72tkVBB1mgdhsjE97y/hmbjf4rL5JcNwKIR/klCKExNOYfO2C
         xqH+5FSo6YHGF4bVKnw+8OxG+xI8DUw3aGEypyWaeoVJHgjCW+exXoeTggyDY+lsQlCr
         vjvZedwsH49z0xxrSGXyKb6ko2bo3c0FHcqtKD/oDmw86pjDKksovPX89o3nObDLMqIT
         fS8Q==
X-Gm-Message-State: AJIora+hIXW5RNKm8yW07gL8oEjjk9APNUTXVUadyJVa/Pi1ehIW/1sT
        5OuLfL9yoX5iIbLwzxdEyY/EIA==
X-Google-Smtp-Source: AGRyM1tgLminoVFd8/gex9iCPvDvAvZlo720feIAyAYXnietvnrirHV0xbRgxt8njho9c1rH24xk0Q==
X-Received: by 2002:a05:600c:210d:b0:3a0:2eea:bf4b with SMTP id u13-20020a05600c210d00b003a02eeabf4bmr17630369wml.28.1656358883905;
        Mon, 27 Jun 2022 12:41:23 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm11428047wru.47.2022.06.27.12.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 12:41:23 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 05/16] dt-bindings: dma: add Canaan k210 to Synopsys DesignWare DMA
Date:   Mon, 27 Jun 2022 20:39:53 +0100
Message-Id: <20220627194003.2395484-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627194003.2395484-1-mail@conchuod.ie>
References: <20220627194003.2395484-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
controller, but according to the documentation & devicetree it has 6
interrupts rather than the standard one. Add a custom compatible that
supports the 6 interrupt configuration which falls back to the standard
binding which is currently the one in use in the devicetree entry.

Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/dma/snps,dw-axi-dmac.yaml        | 35 ++++++++++++++-----
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 4324a94b26b2..bc85598151ef 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -18,9 +18,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - snps,axi-dma-1.01a
-      - intel,kmb-axi-dma
+    oneOf:
+      - items:
+          - const: canaan,k210-axi-dma
+          - const: snps,axi-dma-1.01a
+      - enum:
+          - snps,axi-dma-1.01a
+          - intel,kmb-axi-dma
 
   reg:
     minItems: 1
@@ -33,9 +37,6 @@ properties:
       - const: axidma_ctrl_regs
       - const: axidma_apb_regs
 
-  interrupts:
-    maxItems: 1
-
   clocks:
     items:
       - description: Bus Clock
@@ -92,6 +93,22 @@ properties:
     minimum: 1
     maximum: 256
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: canaan,k210-axi-dma
+
+then:
+  properties:
+    interrupts:
+      maxItems: 6
+
+else:
+  properties:
+    interrupts:
+      maxItems: 1
+
 required:
   - compatible
   - reg
@@ -105,7 +122,7 @@ required:
   - snps,priority
   - snps,block-size
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -113,12 +130,12 @@ examples:
      #include <dt-bindings/interrupt-controller/irq.h>
      /* example with snps,dw-axi-dmac */
      dmac: dma-controller@80000 {
-         compatible = "snps,axi-dma-1.01a";
+         compatible = "canaan,k210-axi-dma", "snps,axi-dma-1.01a";
          reg = <0x80000 0x400>;
          clocks = <&core_clk>, <&cfgr_clk>;
          clock-names = "core-clk", "cfgr-clk";
          interrupt-parent = <&intc>;
-         interrupts = <27>;
+         interrupts = <27>, <28>, <29>, <30>, <31>, <32>;
          #dma-cells = <1>;
          dma-channels = <4>;
          snps,dma-masters = <2>;
-- 
2.36.1

