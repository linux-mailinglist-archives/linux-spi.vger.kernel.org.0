Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC817487E5
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 17:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGEP0K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 11:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjGEP0I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 11:26:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDE810E2;
        Wed,  5 Jul 2023 08:26:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc77e769cso66664005e9.0;
        Wed, 05 Jul 2023 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688570765; x=1691162765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqVqkKo4HpwAKfSb4wis7HAeWZqU1J/4uMHuTI41cXc=;
        b=Fb7uL/gtWW/bCBCdYh8iBpjSJJYHLDFZIIw2dt74uHEtgJg0yMnzwBtQM1hdvXwK8L
         FoCZJAo4CkqkU7mZlZQqXoVdse/ePkgr1w6W3rNbKsYCrh2cVmrRf/bsNszccQRpkJ1f
         LBC36+ZZPat3O0J/fhXF/9xyXwumesYJoAvPoTgdScWow69fxoOiX94KIrWm0qDmJBLg
         4RwrBaNSmPNJVNKi764dXwbfIwRPHTWhmF1OU/YwBDaWqKdcXO31AjlUweQuunalgAkY
         qvNbu1SAd7ugFP2XBK8vJqrLVVbFIQpwppUkG+JPkVD+qhhUFQDHyTYj0lomgy2Yf1Dr
         v2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570765; x=1691162765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqVqkKo4HpwAKfSb4wis7HAeWZqU1J/4uMHuTI41cXc=;
        b=NQHXVlwuTW+JVv2hS0kOGWMma50rYhWTAgw6nt0fBh8qH0WnkWLQSPZa4EbXhdWeWc
         fiG3jxTItpJwoIxj/34wU06GZZZQMSbAjhC4JGU6FJNlEyZ1OP1H54FlS9x/vhff6uxF
         gv1nWxu4igg2a9Q46xQFQB5TbeuDoOKZVpRVHkqlOd7gKVCD4XSgcrJKnNGweENCdikU
         10lFGLdwA76HH/z0qeIzLUB5jrQXqJ9WbLmfP5hH0u2FnU37BnmcA86ghhG95yF/MC8J
         A1ZdFnOampHSTKLol8n2vhQKero5NtIx4ZTfbMUqgvAnUkrcW+9jZChj6OM0f28ayi3E
         bbqw==
X-Gm-Message-State: AC+VfDx7IontKiA/HSTh5t4t/jQfkO8fYEfclAxICmit9kNUXKcpyglE
        XRo0AckyePjlNj8FgXcWqOo=
X-Google-Smtp-Source: ACHHUZ7rFiTrhvNjvTgoYJtSbNZdPkdLJvbmwxLBNoFrhWJV4pxOl9jjAvJppa+VNAyYSkTReRbP9w==
X-Received: by 2002:a7b:cb9a:0:b0:3fb:b3aa:1c8f with SMTP id m26-20020a7bcb9a000000b003fbb3aa1c8fmr14912491wmi.28.1688570765276;
        Wed, 05 Jul 2023 08:26:05 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c00d600b003faa6ce54b2sm2477992wmm.2.2023.07.05.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:26:04 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: spi: tegra-sflash: Convert to json-schema
Date:   Wed,  5 Jul 2023 17:26:02 +0200
Message-ID: <20230705152603.2514235-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705152603.2514235-1-thierry.reding@gmail.com>
References: <20230705152603.2514235-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Tegra SFLASH controller bindings from the free-form text
format to json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/spi/nvidia,tegra20-sflash.txt    | 37 ---------
 .../bindings/spi/nvidia,tegra20-sflash.yaml   | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
deleted file mode 100644
index c212491929b5..000000000000
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-NVIDIA Tegra20 SFLASH controller.
-
-Required properties:
-- compatible : should be "nvidia,tegra20-sflash".
-- reg: Should contain SFLASH registers location and length.
-- interrupts: Should contain SFLASH interrupts.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - spi
-- dmas : Must contain an entry for each entry in clock-names.
-  See ../dma/dma.txt for details.
-- dma-names : Must include the following entries:
-  - rx
-  - tx
-
-Recommended properties:
-- spi-max-frequency: Definition as per
-                     Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-
-spi@7000c380 {
-	compatible = "nvidia,tegra20-sflash";
-	reg = <0x7000c380 0x80>;
-	interrupts = <0 39 0x04>;
-	spi-max-frequency = <25000000>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clocks = <&tegra_car 43>;
-	resets = <&tegra_car 43>;
-	reset-names = "spi";
-	dmas = <&apbdma 11>, <&apbdma 11>;
-	dma-names = "rx", "tx";
-};
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.yaml
new file mode 100644
index 000000000000..e245bad85a25
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nvidia,tegra20-sflash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra20 SFLASH controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra20-sflash
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: module clock
+
+  resets:
+    items:
+      - description: module reset
+
+  reset-names:
+    items:
+      - const: spi
+
+  dmas:
+    items:
+      - description: DMA channel used for reception
+      - description: DMA channel used for transmission
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  spi-max-frequency:
+    description: Maximum SPI clocking speed of the controller in Hz.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+allOf:
+  - $ref: spi-controller.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - reset-names
+  - dmas
+  - dma-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra20-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@7000c380 {
+        compatible = "nvidia,tegra20-sflash";
+        reg = <0x7000c380 0x80>;
+        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+        spi-max-frequency = <25000000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&tegra_car TEGRA20_CLK_SPI>;
+        resets = <&tegra_car 43>;
+        reset-names = "spi";
+        dmas = <&apbdma 11>, <&apbdma 11>;
+        dma-names = "rx", "tx";
+    };
-- 
2.41.0

