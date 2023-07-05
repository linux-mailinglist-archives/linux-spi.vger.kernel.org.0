Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA687487E1
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjGEP0I (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 11:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEP0H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 11:26:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162291709;
        Wed,  5 Jul 2023 08:26:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so68803255e9.1;
        Wed, 05 Jul 2023 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688570764; x=1691162764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ktD3trqPRBszeO1CIyX9rARFTNjc+YFjSkki0gN5auA=;
        b=mNz8ZjwJmxf+M37Nol02bndwRYIyyzL0SX/ZuT4yJ3p7RS9RVqp9hmiqH4LtHzRK1F
         VI16mKKcAIiyqNGiVa0DpRxoNgoTAzNhUleSDkoI3M3u34RssPvxFNc93zHIoHZvUwh5
         RgREsAWrOWRnPL8u6LCpsmlb2PyTeJRLEMvsHQ5Pmfu5mU4tOBhLbL+aPz9ZWoTkLpn3
         ZfyC2tawHTaBBphruJhndXULikQOv6MiggnbOV7sgKdxkl9LYYZga9F8Uo+Nu/NrFY7d
         vNudcI0uJq7tImGBmUOhAaoo/hm8o3JQy9QKNV9CwjBx9yirnTZGLdOYhP3SnDRG7bC1
         SxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570764; x=1691162764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktD3trqPRBszeO1CIyX9rARFTNjc+YFjSkki0gN5auA=;
        b=JNrX9kgklWqdmc6/UEDZvJz7lN7hzwC2zVxkyyp8xso4GvylwmqAS/YFFCI/BhNwuV
         LuamteqD6WjL050t5gZP3/Jiq/Emn6xP444xT/3BvbUJ8oQUb3hZXRGpGMG8t7AyMYog
         TuSPkvpZ0Fq5ulCDlZe7hOmqLCQO/hlSEDAlVXdJU4hZ7RGCmX3KwFMEkddFfHQhNyVS
         S+ETPjcHq6qtiiyAxQSS6iEI4e5D5h+zG5RMXMQDJFSNdc+awTtOEnzCgcM0MYX4vE9f
         saLqbykAZpyS5N+LjLnbEN1i5cdvNOEESj89KL3sdvsbNE+Pp472A6phMrahFesoe+nZ
         xhZA==
X-Gm-Message-State: AC+VfDxBBGhvAgsMLxPuWx2WPfAyWzqCOsaEJdWVZUlwulOeG1OEjXC4
        ne8YiPS8JgDNmFbj0y9kjNc=
X-Google-Smtp-Source: ACHHUZ7zB1CNHcO2DfMQRPhEc0SwBJGJ3zXwXTVLvEZAL7IJ22NxWcH6zuZm0CemN177m1vMhXodLg==
X-Received: by 2002:a7b:ca48:0:b0:3f9:b7cc:723 with SMTP id m8-20020a7bca48000000b003f9b7cc0723mr12919247wml.21.1688570764181;
        Wed, 05 Jul 2023 08:26:04 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y4-20020a1c4b04000000b003fbe4cecc5fsm2431099wma.34.2023.07.05.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:26:03 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: spi: tegra-slink: Convert to json-schema
Date:   Wed,  5 Jul 2023 17:26:01 +0200
Message-ID: <20230705152603.2514235-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Convert the Tegra SLINK bindings from the free-form text format to
json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/spi/nvidia,tegra20-slink.txt     | 37 --------
 .../bindings/spi/nvidia,tegra20-slink.yaml    | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
deleted file mode 100644
index 40d80b93e327..000000000000
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-NVIDIA Tegra20/Tegra30 SLINK controller.
-
-Required properties:
-- compatible : should be "nvidia,tegra20-slink", "nvidia,tegra30-slink".
-- reg: Should contain SLINK registers location and length.
-- interrupts: Should contain SLINK interrupts.
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
-spi@7000d600 {
-	compatible = "nvidia,tegra20-slink";
-	reg = <0x7000d600 0x200>;
-	interrupts = <0 82 0x04>;
-	spi-max-frequency = <25000000>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clocks = <&tegra_car 44>;
-	resets = <&tegra_car 44>;
-	reset-names = "spi";
-	dmas = <&apbdma 16>, <&apbdma 16>;
-	dma-names = "rx", "tx";
-};
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.yaml
new file mode 100644
index 000000000000..291c25ec015d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nvidia,tegra20-slink.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra20/30 SLINK controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra20-slink
+      - nvidia,tegra30-slink
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
+  operating-points-v2:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  power-domains:
+    items:
+      - description: phandle to the core power domain
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
+    spi@7000d600 {
+        compatible = "nvidia,tegra20-slink";
+        reg = <0x7000d600 0x200>;
+        interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+        spi-max-frequency = <25000000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&tegra_car TEGRA20_CLK_SBC2>;
+        resets = <&tegra_car 44>;
+        reset-names = "spi";
+        dmas = <&apbdma 16>, <&apbdma 16>;
+        dma-names = "rx", "tx";
+    };
-- 
2.41.0

