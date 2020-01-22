Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB5145EC4
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2020 23:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgAVWqO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 17:46:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36061 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWqH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jan 2020 17:46:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so953155wru.3;
        Wed, 22 Jan 2020 14:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MCqGyviW/tmvDr3828HB9zRo2d0D7zhBetq/RRoppAo=;
        b=ZXC5CPLbVoyjDhfM3wRKk1g+2/bMBj2KsWlUKfarnVA4JqgC08hYf+ClX/0j/NxYdR
         gnLnzUdLNoMkixrSqmkvKmtJ2bxOlwaf2NiFDJ4AKCFXj/5T364/K2XSJPHqeUp9qULh
         d4I2U4wJvB79CRaCZvEmmclcG+feE4iBi2nqBEXFhSAYU5+QXjPg+vqjWcz//VK5+hFw
         YBCVrA14pdI1LeCyYxKCgtE4/jI/sOr8KbDawML4fB2aYK+GrN5ICTzpmq42xzlcnkYl
         ppDSwa/FWubVo+1wdJvIiHdyB3a/bjFnhghtRbYkMn5JEptRrMxj0gkCSY4kwkdslF68
         TixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MCqGyviW/tmvDr3828HB9zRo2d0D7zhBetq/RRoppAo=;
        b=sBJUiQ1COWg0gagJD+QrchyWIVC5adr8GDMuiBeqlQuaMfp4aBAZL7qp11hM6iw7eR
         1X4PugxCE700BKxlPKwBKcZYX2Nst0GpBV2R6NhsF9NogQS9gJWnAbBh6c86jJRP1mkJ
         MaS3hmbXMjEg235SXNlhqmbaRaCgO4y9k+dEYsmxj7Kk2rZ0roHrsFKqwnO3qGVrkjg4
         +GMuUVvC4LntIt4vTrhvQ6QjPMhcNoE2hJoEDyEXes/NFdAMtrndSCWj1lkxfqJ0/LP7
         wPVGwYovdBalXdatqTUtmrlI5kqyF26QL0hAGW5nA9Or8sj5u2S8kQbcVJmmm4OpqtTD
         0u/w==
X-Gm-Message-State: APjAAAVliX/eYDt3AvfaRPfNTV/lFwdnHu9RevfmYfheUpaLOp5pF6K2
        g9aCBAFjZute+3uHKoxUoho=
X-Google-Smtp-Source: APXvYqzZG10AEF2jozV7H1kRJvn6uvUc923vmhPqyktJYEdzkrlSkBoI/Rhqz2Y1khzX5/Y80wTKFA==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr13071078wrx.87.1579733164580;
        Wed, 22 Jan 2020 14:46:04 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f1sm342559wro.85.2020.01.22.14.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 14:46:03 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: spi: convert rockchip spi bindings to yaml
Date:   Wed, 22 Jan 2020 23:45:53 +0100
Message-Id: <20200122224555.6845-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Current dts files with 'spi' nodes are manually verified.
In order to automate this process spi-rockchip.txt
has to be converted to yaml. In the new setup
spi-rockchip.yaml will inherit properties from
spi-controller.yaml.

Add document to MAINTAINERS.

Also rk3188.dtsi, rk3288.dtsi, rk3368.dtsi and rk3399.dtsi
use an extra fallback string, so change this in the documentation.

Changed:
"rockchip,rk3188-spi", "rockchip,rk3066-spi"
"rockchip,rk3288-spi", "rockchip,rk3066-spi"
"rockchip,rk3368-spi", "rockchip,rk3066-spi"
"rockchip,rk3399-spi", "rockchip,rk3066-spi"

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/spi/spi-rockchip.txt       |  58 ------------
 .../devicetree/bindings/spi/spi-rockchip.yaml      | 105 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 106 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
deleted file mode 100644
index a0edac12d..000000000
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Rockchip SPI Controller
-
-The Rockchip SPI controller is used to interface with various devices such as flash
-and display controllers using the SPI communication interface.
-
-Required Properties:
-
-- compatible: should be one of the following.
-    "rockchip,rv1108-spi" for rv1108 SoCs.
-    "rockchip,px30-spi", "rockchip,rk3066-spi" for px30 SoCs.
-    "rockchip,rk3036-spi" for rk3036 SoCS.
-    "rockchip,rk3066-spi" for rk3066 SoCs.
-    "rockchip,rk3188-spi" for rk3188 SoCs.
-    "rockchip,rk3228-spi" for rk3228 SoCS.
-    "rockchip,rk3288-spi" for rk3288 SoCs.
-    "rockchip,rk3368-spi" for rk3368 SoCs.
-    "rockchip,rk3399-spi" for rk3399 SoCs.
-- reg: physical base address of the controller and length of memory mapped
-       region.
-- interrupts: The interrupt number to the cpu. The interrupt specifier format
-              depends on the interrupt controller.
-- clocks: Must contain an entry for each entry in clock-names.
-- clock-names: Shall be "spiclk" for the transfer-clock, and "apb_pclk" for
-			   the peripheral clock.
-- #address-cells: should be 1.
-- #size-cells: should be 0.
-
-Optional Properties:
-
-- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
-		Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: DMA request names should include "tx" and "rx" if present.
-- rx-sample-delay-ns: nanoseconds to delay after the SCLK edge before sampling
-		Rx data (may need to be fine tuned for high capacitance lines).
-		No delay (0) by default.
-- pinctrl-names: Names for the pin configuration(s); may be "default" or
-		"sleep", where the "sleep" configuration may describe the state
-		the pins should be in during system suspend. See also
-		pinctrl/pinctrl-bindings.txt.
-
-
-Example:
-
-	spi0: spi@ff110000 {
-		compatible = "rockchip,rk3066-spi";
-		reg = <0xff110000 0x1000>;
-		dmas = <&pdma1 11>, <&pdma1 12>;
-		dma-names = "tx", "rx";
-		rx-sample-delay-ns = <10>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
-		clock-names = "spiclk", "apb_pclk";
-		pinctrl-0 = <&spi1_pins>;
-		pinctrl-1 = <&spi1_sleep>;
-		pinctrl-names = "default", "sleep";
-	};
diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
new file mode 100644
index 000000000..bca8c6142
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-rockchip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SPI Controller
+
+description:
+  The Rockchip SPI controller is used to interface with various devices such
+  as flash and display controllers using the SPI communication interface.
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+# Everything else is described in the common file
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3036-spi #for rk3036 SoCS.
+      - const: rockchip,rk3066-spi #for rk3066 SoCs.
+      - const: rockchip,rk3228-spi #for rk3228 SoCS.
+      - const: rockchip,rv1108-spi #for rv1108 SoCs.
+      - items:
+          - enum:
+            - rockchip,px30-spi    #for px30 SoCs.
+            - rockchip,rk3188-spi  #for rk3188 SoCs.
+            - rockchip,rk3288-spi  #for rk3288 SoCs.
+            - rockchip,rk3368-spi  #for rk3368 SoCs.
+            - rockchip,rk3399-spi  #for rk3399 SoCs.
+          - const: rockchip,rk3066-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: transfer-clock
+      - description: peripheral clock
+
+  clock-names:
+    items:
+      - const: spiclk
+      - const: apb_pclk
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  rx-sample-delay-ns:
+    default: 0
+    description:
+      Nano seconds to delay after the SCLK edge before sampling Rx data
+      (may need to be fine tuned for high capacitance lines).
+      If not specified 0 will be used.
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+    description:
+      Names for the pin configuration(s); may be "default" or "sleep",
+      where the "sleep" configuration may describe the state
+      the pins should be in during system suspend.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3188-cru-common.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0: spi@ff110000 {
+      compatible = "rockchip,rk3066-spi";
+      reg = <0xff110000 0x1000>;
+      interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
+      clock-names = "spiclk", "apb_pclk";
+      dmas = <&pdma1 11>, <&pdma1 12>;
+      dma-names = "tx", "rx";
+      pinctrl-0 = <&spi1_pins>;
+      pinctrl-1 = <&spi1_sleep>;
+      pinctrl-names = "default", "sleep";
+      rx-sample-delay-ns = <10>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d6ad01d71..096c324f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2240,6 +2240,7 @@ L:	linux-rockchip@lists.infradead.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+F:	Documentation/devicetree/bindings/spi/spi-rockchip.yaml
 F:	arch/arm/boot/dts/rk3*
 F:	arch/arm/boot/dts/rv1108*
 F:	arch/arm/mach-rockchip/
-- 
2.11.0

