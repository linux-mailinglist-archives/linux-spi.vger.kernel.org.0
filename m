Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D57487E7
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jul 2023 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjGEP0M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jul 2023 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEP0J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jul 2023 11:26:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E85171D;
        Wed,  5 Jul 2023 08:26:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-314172bb818so7724107f8f.1;
        Wed, 05 Jul 2023 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688570766; x=1691162766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAOIOOaDv3Hyoka42okaEygSZgrjCeRWa0Pa8A8K5R0=;
        b=XkdbbBXvST3kKGTWHUdm/9LN3K87V0FPzFppdO8Po66E/xOs4wg8z7M4CxBxkEiBFY
         Pks7Uk23fKo+05PNYhLAo2R/Qxi2/5HEbcfioPP+6t5x5JV0WaPwHdGyqKNy2UzhGAo2
         HpYrDwU9oLgOwgsIUWrk6VuW3dredn8rTQhgDxl2bFbaIT7f/8QcuR42SpdZaF50MtUh
         MOqzyTQswqKPMOAAol6Wat/mD+wyWPIRx5REueWes3bS+OKCuf1lo53wev0e1csLTLsw
         w5J/L7ABFtM3wt6Oqb6sbz64ubVjHz8n2sg9BdiUDschTOxrkbu2S8Y1WL8jbQNITdLq
         QgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688570766; x=1691162766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAOIOOaDv3Hyoka42okaEygSZgrjCeRWa0Pa8A8K5R0=;
        b=dKtxI4Aip3WuMPmOqrXrps4RCFeB/ifrSDMT9N0AIDqOmw3eOj61wCEubHpq28Ygiv
         sN6X5THm5Cd7SHHojgPdS5WWLKgHwZ3+wVwMYYaX1xbhgqKBIRYymwie5B3zYOI3ydoS
         /kPO15X+d4kR9GNaxN0qEXEhp1u6Y6JmSETLGvSUR7ypwPg65SzAQMJA1/RkYiZuVkzC
         95nMM9xVFyM2ruEcrw1/7rz0gmoAL+gkvrMWyWAIij/03DwZ4Py5/qFTJVbPpPNIxgYO
         18W2dl92yKHYdu8gc26bfRjdzJtvc7EhHYjPVh/ayZ5GXco33JLS7KiTXQEhRtVDa9Ef
         1Nlg==
X-Gm-Message-State: ABy/qLYcE9VQEpr8lP9NhdGN7HKPVNb3izAX6ADn6JkR1rNa89Fvuekr
        cppYrX3YRmcH05ekXO8OnP8=
X-Google-Smtp-Source: APBJJlEQMDWwRsT6hOSrlOjX79PH108Tpxk1zRXef7wyaDkzFqpbRHcoxVDwVZnbIfow5e3GfPxnXw==
X-Received: by 2002:a5d:440e:0:b0:314:3985:b291 with SMTP id z14-20020a5d440e000000b003143985b291mr7079903wrq.15.1688570766480;
        Wed, 05 Jul 2023 08:26:06 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c8-20020a056000104800b003143ba62cf4sm6339933wrx.86.2023.07.05.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:26:06 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: spi: Convert Tegra114 SPI to json-schema
Date:   Wed,  5 Jul 2023 17:26:03 +0200
Message-ID: <20230705152603.2514235-3-thierry.reding@gmail.com>
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

Convert the Tegra114 SPI controller device tree bindings from plain text
to json-schema format.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/spi/nvidia,tegra114-spi.txt      |  61 -----------
 .../bindings/spi/nvidia,tegra114-spi.yaml     | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
deleted file mode 100644
index db8e0d71c5bc..000000000000
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-NVIDIA Tegra114 SPI controller.
-
-Required properties:
-- compatible : For Tegra114, must contain "nvidia,tegra114-spi".
-  Otherwise, must contain '"nvidia,<chip>-spi", "nvidia,tegra114-spi"' where
-  <chip> is tegra124, tegra132, or tegra210.
-- reg: Should contain SPI registers location and length.
-- interrupts: Should contain SPI interrupts.
-- clock-names : Must include the following entries:
-  - spi
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - spi
-- dmas : Must contain an entry for each entry in clock-names.
-  See ../dma/dma.txt for details.
-- dma-names : Must include the following entries:
-  - rx
-  - tx
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-
-Recommended properties:
-- spi-max-frequency: Definition as per
-                     Documentation/devicetree/bindings/spi/spi-bus.txt
-Optional properties:
-- nvidia,tx-clk-tap-delay: Delays the clock going out to the external device
-  with this tap value. This property is used to tune the outgoing data from
-  Tegra SPI master with respect to outgoing Tegra SPI master clock.
-  Tap values vary based on the platform design trace lengths from Tegra SPI
-  to corresponding slave devices. Valid tap values are from 0 thru 63.
-- nvidia,rx-clk-tap-delay: Delays the clock coming in from the external device
-  with this tap value. This property is used to adjust the Tegra SPI master
-  clock with respect to the data from the SPI slave device.
-  Tap values vary based on the platform design trace lengths from Tegra SPI
-  to corresponding slave devices. Valid tap values are from 0 thru 63.
-
-Example:
-
-spi@7000d600 {
-	compatible = "nvidia,tegra114-spi";
-	reg = <0x7000d600 0x200>;
-	interrupts = <0 82 0x04>;
-	spi-max-frequency = <25000000>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clocks = <&tegra_car 44>;
-	clock-names = "spi";
-	resets = <&tegra_car 44>;
-	reset-names = "spi";
-	dmas = <&apbdma 16>, <&apbdma 16>;
-	dma-names = "rx", "tx";
-	<spi-client>@<bus_num> {
-		...
-		...
-		nvidia,rx-clk-tap-delay = <0>;
-		nvidia,tx-clk-tap-delay = <16>;
-		...
-	};
-
-};
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.yaml
new file mode 100644
index 000000000000..58222ffa53d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nvidia,tegra114-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra114 SPI controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra114-spi
+      - items:
+          - enum:
+              - nvidia,tegra210-spi
+              - nvidia,tegra124-spi
+          - const: nvidia,tegra114-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI module clock
+
+  clock-names:
+    items:
+      - const: spi
+
+  resets:
+    items:
+      - description: SPI module reset
+
+  reset-names:
+    items:
+      - const: spi
+
+  dmas:
+    items:
+      - description: DMA channel for the reception FIFO
+      - description: DMA channel for the transmission FIFO
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
+  - clock-names
+  - resets
+  - reset-names
+  - dmas
+  - dma-names
+
+examples:
+  - |
+    spi@7000d600 {
+        compatible = "nvidia,tegra114-spi";
+        reg = <0x7000d600 0x200>;
+        interrupts = <0 82 0x04>;
+        clocks = <&tegra_car 44>;
+        clock-names = "spi";
+        resets = <&tegra_car 44>;
+        reset-names = "spi";
+        dmas = <&apbdma 16>, <&apbdma 16>;
+        dma-names = "rx", "tx";
+
+        spi-max-frequency = <25000000>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            nvidia,rx-clk-tap-delay = <0>;
+            nvidia,tx-clk-tap-delay = <16>;
+        };
+    };
-- 
2.41.0

