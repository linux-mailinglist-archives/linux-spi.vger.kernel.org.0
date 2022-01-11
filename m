Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F65048AB21
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jan 2022 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348740AbiAKKNr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Jan 2022 05:13:47 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60962
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348632AbiAKKNp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Jan 2022 05:13:45 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8089440A54
        for <linux-spi@vger.kernel.org>; Tue, 11 Jan 2022 10:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641896024;
        bh=ThvMajJuayiGnhwMDmba8JeXZG0rsrmwNZIGtzPQ/RY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nFZliJWV3adC2RRlQpUInbI4gfND/IOQ/Ym5r64vUCZKDOrJBBGmuG8Wj2tmbj20R
         IqgfT+M3NgArUtfbfxoPrxO+FsCNR3XSfZ1TEG0teTYq9PjfsAMf37JGEP6g6CfXLW
         bTAhWnuacG3c592hODVP69TrgAQ3/wR24XG4YCPeMv7npSJD1Szow4y4nDRteCWAey
         Sfn26+cA7yBX+wbdMftLPQ999WBTJdQGmVXZzo1ukW1f/AfPLdM7RyBcAFYT9MP8cL
         6Zf/tJxARADYRhtQjz6IWwEvN0pDx329apoQoTN7DvhpqqYX4SE2iUMZgMrVepi0qU
         TeXMyO8yo6yJQ==
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso12824118edt.20
        for <linux-spi@vger.kernel.org>; Tue, 11 Jan 2022 02:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThvMajJuayiGnhwMDmba8JeXZG0rsrmwNZIGtzPQ/RY=;
        b=ahiDfBWbu0zEaeTyHpbH38USNZqNIXT8seRNepr26v7z5vnSc3hHlU2bree189G5VH
         CqAt4dFmz8it9rQcgq8wI1CWzN1jbIswZxsXRa+b//xsEXeuYDGOp5dU8PuB2vd6b6yX
         6w3buMVGuCOUSIsyYDLYSgagJBhdtwIGlZREoNFFEMSwcTfbX7T+Td58OX0nLhjLuyps
         XNDCsiW6SfOlLy1Za3PS285RgDCY8b79/Ef8Dru73IM6m0tXAehwahHXGXFgTzME26Sz
         VLwibVp3xSeoLiHQ4or16P8dTHX7txROJEx1fyzrxr/yqsE1es12xpaIkjq4h4LR86lu
         +9Cw==
X-Gm-Message-State: AOAM531psg5fU+HeUoiV2OGzMwXvdY1FLaXTvQaRtlXFHCy2sA3gYYko
        xvzcnJM6g+6YCxstUrxo8q0dw+ctuFU+XtQ5dvC3slVyq5VYGAwzxFQU7QBRyuVKyMFnpG8fY1y
        P1xteY0mOTYdYi1AE4lUIoEgdKiUXL1QnbN49+Q==
X-Received: by 2002:aa7:d59a:: with SMTP id r26mr3550692edq.199.1641896024005;
        Tue, 11 Jan 2022 02:13:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwA97RIXrJ/+ksAAAvr4fwIMKw+83j3EKBrhTEksTeGn0/IAf4kA2jFrVToGwub5YSosbiaFA==
X-Received: by 2002:aa7:d59a:: with SMTP id r26mr3550668edq.199.1641896023644;
        Tue, 11 Jan 2022 02:13:43 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 26sm3431268ejk.138.2022.01.11.02.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 02:13:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 2/4] spi: dt-bindings: samsung: convert to dtschema
Date:   Tue, 11 Jan 2022 11:13:36 +0100
Message-Id: <20220111101338.58630-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
controller bindings to DT schema format

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../spi/samsung,spi-peripheral-props.yaml     |  35 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml  | 198 ++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml    |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt   | 122 -----------
 MAINTAINERS                                   |   2 +-
 5 files changed, 235 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
new file mode 100644
index 000000000000..aa5a1f48494b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/samsung,spi-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral-specific properties for Samsung S3C/S5P/Exynos SoC SPI controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description:
+  See spi-peripheral-props.yaml for more info.
+
+properties:
+  controller-data:
+    type: object
+    additionalProperties: false
+
+    properties:
+      samsung,spi-feedback-delay:
+        description: |
+          The sampling phase shift to be applied on the miso line (to account
+          for any lag in the miso line). Valid values:
+           - 0: No phase shift.
+           - 1: 90 degree phase shift sampling.
+           - 2: 180 degree phase shift sampling.
+           - 3: 270 degree phase shift sampling.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+
+    required:
+      - samsung,spi-feedback-delay
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
new file mode 100644
index 000000000000..da4533feb946
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/samsung,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S3C/S5P/Exynos SoC SPI controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description:
+  All the SPI controller nodes should be represented in the aliases node using
+  the following format 'spi{n}' where n is a unique number for the alias.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
+          - samsung,s3c6410-spi
+          - samsung,s5pv210-spi # for S5PV210 and S5PC110
+          - samsung,exynos5433-spi
+      - const: samsung,exynos7-spi
+        deprecated: true
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
+  cs-gpios: true
+
+  dmas:
+    minItems: 2
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    maxItems: 1
+
+  no-cs-readback:
+    description:
+      The CS line is disconnected, therefore the device should not operate
+      based on CS signalling.
+    type: boolean
+
+  num-cs:
+    minimum: 1
+    maximum: 4
+    default: 1
+
+  samsung,spi-src-clk:
+    description:
+      If the spi controller includes a internal clock mux to select the clock
+      source for the spi bus clock, this property can be used to indicate the
+      clock to be used for driving the spi bus clock. If not specified, the
+      clock number 0 is used as default.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    allOf:
+      - $ref: spi-peripheral-props.yaml
+
+    required:
+      - controller-data
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - interrupts
+  - reg
+
+allOf:
+  - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5433-spi
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: spi
+            - enum:
+                - spi_busclk0
+                - spi_busclk1
+                - spi_busclk2
+                - spi_busclk3
+            - const: spi_ioclk
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: spi
+            - enum:
+                - spi_busclk0
+                - spi_busclk1
+                - spi_busclk2
+                - spi_busclk3
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5433.h>
+    #include <dt-bindings/clock/samsung,s2mps11.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi@14d30000 {
+        compatible = "samsung,exynos5433-spi";
+        reg = <0x14d30000 0x100>;
+        interrupts = <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&pdma0 11>, <&pdma0 10>;
+        dma-names = "tx", "rx";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&cmu_peric CLK_PCLK_SPI1>,
+                 <&cmu_peric CLK_SCLK_SPI1>,
+                 <&cmu_peric CLK_SCLK_IOCLK_SPI1>;
+        clock-names = "spi",
+                      "spi_busclk0",
+                      "spi_ioclk";
+        samsung,spi-src-clk = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&spi1_bus>;
+        num-cs = <1>;
+
+        cs-gpios = <&gpd6 3 GPIO_ACTIVE_HIGH>;
+
+        audio-codec@0 {
+            compatible = "wlf,wm5110";
+            reg = <0x0>;
+            spi-max-frequency = <20000000>;
+            interrupt-parent = <&gpa0>;
+            interrupts = <4 IRQ_TYPE_NONE>;
+            clocks = <&pmu_system_controller 0>,
+                     <&s2mps13_osc S2MPS11_CLK_BT>;
+            clock-names = "mclk1", "mclk2";
+
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            wlf,micd-detect-debounce = <300>;
+            wlf,micd-bias-start-time = <0x1>;
+            wlf,micd-rate = <0x7>;
+            wlf,micd-dbtime = <0x2>;
+            wlf,micd-force-micbias;
+            wlf,micd-configs = <0x0 1 0>;
+            wlf,hpdet-channel = <1>;
+            wlf,gpsw = <0x1>;
+            wlf,inmode = <2 0 2 0>;
+
+            wlf,reset = <&gpc0 7 GPIO_ACTIVE_HIGH>;
+            wlf,ldoena = <&gpf0 0 GPIO_ACTIVE_HIGH>;
+
+            /* core supplies */
+            AVDD-supply = <&ldo18_reg>;
+            DBVDD1-supply = <&ldo18_reg>;
+            CPVDD-supply = <&ldo18_reg>;
+            DBVDD2-supply = <&ldo18_reg>;
+            DBVDD3-supply = <&ldo18_reg>;
+            SPKVDDL-supply = <&ldo18_reg>;
+            SPKVDDR-supply = <&ldo18_reg>;
+
+            controller-data {
+                samsung,spi-feedback-delay = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5dd209206e88..df885eeb144f 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -85,5 +85,6 @@ properties:
 # The controller specific properties go here.
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
+  - $ref: samsung,spi-peripheral-props.yaml#
 
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
deleted file mode 100644
index 49028a4f5df1..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ /dev/null
@@ -1,122 +0,0 @@
-* Samsung SPI Controller
-
-The Samsung SPI controller is used to interface with various devices such as flash
-and display controllers using the SPI communication interface.
-
-Required SoC Specific Properties:
-
-- compatible: should be one of the following.
-    - samsung,s3c2443-spi: for s3c2443, s3c2416 and s3c2450 platforms
-    - samsung,s3c6410-spi: for s3c6410 platforms
-    - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
-    - samsung,exynos5433-spi: for exynos5433 compatible controllers
-    - samsung,exynos7-spi: for exynos7 platforms <DEPRECATED>
-
-- reg: physical base address of the controller and length of memory mapped
-  region.
-
-- interrupts: The interrupt number to the cpu. The interrupt specifier format
-  depends on the interrupt controller.
-
-- dmas : Two or more DMA channel specifiers following the convention outlined
-  in bindings/dma/dma.txt
-
-- dma-names: Names for the dma channels. There must be at least one channel
-  named "tx" for transmit and named "rx" for receive.
-
-- clocks: specifies the clock IDs provided to the SPI controller; they are
-  required for interacting with the controller itself, for synchronizing the bus
-  and as I/O clock (the latter is required by exynos5433 and exynos7).
-
-- clock-names: string names of the clocks in the 'clocks' property; for all the
-  the devices the names must be "spi", "spi_busclkN" (where N is determined by
-  "samsung,spi-src-clk"), while Exynos5433 should specify a third clock
-  "spi_ioclk" for the I/O clock.
-
-Required Board Specific Properties:
-
-- #address-cells: should be 1.
-- #size-cells: should be 0.
-
-Optional Board Specific Properties:
-
-- samsung,spi-src-clk: If the spi controller includes a internal clock mux to
-  select the clock source for the spi bus clock, this property can be used to
-  indicate the clock to be used for driving the spi bus clock. If not specified,
-  the clock number 0 is used as default.
-
-- num-cs: Specifies the number of chip select lines supported. If
-  not specified, the default number of chip select lines is set to 1.
-
-- cs-gpios: should specify GPIOs used for chipselects (see spi-bus.txt)
-
-- no-cs-readback: the CS line is disconnected, therefore the device should not
-  operate based on CS signalling.
-
-SPI Controller specific data in SPI slave nodes:
-
-- The spi slave nodes should provide the following information which is required
-  by the spi controller.
-
-  - samsung,spi-feedback-delay: The sampling phase shift to be applied on the
-    miso line (to account for any lag in the miso line). The following are the
-    valid values.
-
-      - 0: No phase shift.
-      - 1: 90 degree phase shift sampling.
-      - 2: 180 degree phase shift sampling.
-      - 3: 270 degree phase shift sampling.
-
-Aliases:
-
-- All the SPI controller nodes should be represented in the aliases node using
-  the following format 'spi{n}' where n is a unique number for the alias.
-
-
-Example:
-
-- SoC Specific Portion:
-
-	spi_0: spi@12d20000 {
-		compatible = "samsung,exynos4210-spi";
-		reg = <0x12d20000 0x100>;
-		interrupts = <0 66 0>;
-		dmas = <&pdma0 5
-			&pdma0 4>;
-		dma-names = "tx", "rx";
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-- Board Specific Portion:
-
-	spi_0: spi@12d20000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&spi0_bus>;
-		cs-gpios = <&gpa2 5 0>;
-
-		w25q80bw@0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "w25x80";
-			reg = <0>;
-			spi-max-frequency = <10000>;
-
-			controller-data {
-				samsung,spi-feedback-delay = <0>;
-			};
-
-			partition@0 {
-				label = "U-Boot";
-				reg = <0x0 0x40000>;
-				read-only;
-			};
-
-			partition@40000 {
-				label = "Kernel";
-				reg = <0x40000 0xc0000>;
-			};
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 5ea5655a29c3..1f951bc877f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17054,7 +17054,7 @@ M:	Andi Shyti <andi@etezian.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-samsung.txt
+F:	Documentation/devicetree/bindings/spi/samsung,spi*.yaml
 F:	drivers/spi/spi-s3c*
 F:	include/linux/platform_data/spi-s3c64xx.h
 F:	include/linux/spi/s3c24xx-fiq.h
-- 
2.32.0

