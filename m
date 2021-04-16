Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F384E3628DB
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 21:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhDPTsB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 15:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbhDPTsB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Apr 2021 15:48:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9E7C061574;
        Fri, 16 Apr 2021 12:47:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 12so46323818lfq.13;
        Fri, 16 Apr 2021 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xWga8TuHrudXJ2HLef/kUNALK9rwDw6vYSQoAJMer7s=;
        b=EoGGMHfIRjv6o/6LGcn2m4P+YZcvWL9viKaq2KOiXgB87fHOLk2olnXgIhdEsIsF+E
         0HQMHGE7Ek4hIzScgUmw9qTL2BN3xQSSRu0taqd1MhrmHN6CaTM3mOyp+MOHpurkxU5M
         w68ic7e1D8WOklkRY+o9E4CMjZQlWWKqPbeQdUTzpFSY2cHtj+TjfkQnFMBhT9gqWvGi
         z8YYlZwMr0memPUE5DI/Vt1Bqee7E0AcMeaXtJHt+PLjf4iTKVYAMzQJw++J0L4XKl5R
         TSEr/BEklDG9sFuCQ4aKM4kvYEsySZjHrqPdJOJlMps534nOZe6e771xmpPq+njd4juf
         dQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWga8TuHrudXJ2HLef/kUNALK9rwDw6vYSQoAJMer7s=;
        b=izPfIDsMl3HHQc8pTNhyp+Xd4mDN45EzWLaJV00HlkaOFiWWbduN1SxF5Fb5knNJJt
         PIMwff9PwKCi9ntDZTWfTVWQNlJPAqdmSX532vwHKI1YizYhhkUbkFXT9NbHhFzE6bSi
         A+PrTLAx1dATD5P9QAQp2yw9hU1/SNZar4fcnYY+TO8IAXt3HUuCgRUg2j9kW7vEACbR
         CTimW+l1aszudvo4h9yiIPR37FDwRQwf9JzzA81SZUgdHxI3+krj4QCI6mGkk44ev0pK
         EQk1F0oT+eH8I5see++jaHeRJfMvy29cEx4Sn4F4kV8GhaGXemxSVoJ3fnPVhP9N6ccC
         2CeQ==
X-Gm-Message-State: AOAM531QeC1cabVa9EgYjdXCb+YTQLuIW93a8kRtvkdJVvy3ZddF4BEq
        Jhg7LGXOEV631QZHYrurJvw=
X-Google-Smtp-Source: ABdhPJySEAEIa/nw47BhBMpXgNnSyGPnY7YrPEJA9ncTWEchICjqXHYZIRhO1RkffsYwziyspiEN5A==
X-Received: by 2002:a19:c1cc:: with SMTP id r195mr3885398lff.457.1618602454143;
        Fri, 16 Apr 2021 12:47:34 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b28sm1070051lfv.109.2021.04.16.12.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:47:33 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3] dt-bindings: spi: brcm,spi-bcm-qspi: convert to the json-schema
Date:   Fri, 16 Apr 2021 21:47:23 +0200
Message-Id: <20210416194723.23855-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210416062320.21414-1-zajec5@gmail.com>
References: <20210416062320.21414-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

Changes that require mentioning:
1. reg-names
   "mspi_regs" and "bspi_regs" were renamed to "mspi" and "bspi" as that
   is what's used in DTS files and in Linux driver
2. interrupt-names
   Names were reordered. "mspi_done" has to go first as it's always
   required.
3. spi-rx-bus-width
   Property description was dropped as it's part of the
   spi-controller.yaml
4. Examples:
   * drop partitions as they are well documented elsewhere
   * regs and interrupts were formatted and reordered to match yaml
   * <0x1c> was replaced with <&gic>
   * "m25p80" node name became "flash"
   * dropped invalid "m25p,fast-read" property
   * dropped undocumented and Linux-unused "clock-names"

This rewritten binding validates cleanly using the  "dt_binding_check".
Some Linux stored DTS files will require reordering regs and interrupts
to make dtbs_check happy.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Add Kamal as maintainer
V3: Fix examples (see commit message for details) - thanks Rob
---
 .../bindings/spi/brcm,spi-bcm-qspi.txt        | 245 ------------------
 .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 198 ++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 199 insertions(+), 246 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
deleted file mode 100644
index d99a9cf3336b..000000000000
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
+++ /dev/null
@@ -1,245 +0,0 @@
-Broadcom SPI controller
-
-The Broadcom SPI controller is a SPI master found on various SOCs, including
-BRCMSTB (BCM7XXX), Cygnus, NSP and NS2. The Broadcom Master SPI hw IP consits
-of :
- MSPI : SPI master controller can read and write to a SPI slave device
- BSPI : Broadcom SPI in combination with the MSPI hw IP provides acceleration
-	for flash reads and be configured to do single, double, quad lane
-	io with 3-byte and 4-byte addressing support.
-
- Supported Broadcom SoCs have one instance of MSPI+BSPI controller IP.
- MSPI master can be used wihout BSPI. BRCMSTB SoCs have an additional instance
- of a MSPI master without the BSPI to use with non flash slave devices that
- use SPI protocol.
-
-Required properties:
-
-- #address-cells:
-    Must be <1>, as required by generic SPI binding.
-
-- #size-cells:
-    Must be <0>, also as required by generic SPI binding.
-
-- compatible:
-    Must be one of :
-    "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi" : MSPI+BSPI on BRCMSTB SoCs
-    "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi" : Second Instance of MSPI
-						   BRCMSTB  SoCs
-    "brcm,spi-bcm7425-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
-    			     			  			    BRCMSTB  SoCs
-    "brcm,spi-bcm7429-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
-    			     			  			    BRCMSTB  SoCs
-    "brcm,spi-bcm7435-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
-    			     			  			    BRCMSTB  SoCs
-    "brcm,spi-bcm7445-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
-                                                                            BRCMSTB  SoCs
-    "brcm,spi-bcm7216-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
-    			     			  			    BRCMSTB  SoCs
-    "brcm,spi-bcm7278-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
-    			     			  			    BRCMSTB  SoCs
-    "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi"     : MSPI+BSPI on Cygnus, NSP
-    "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi"     : NS2 SoCs
-
-- reg:
-    Define the bases and ranges of the associated I/O address spaces.
-    The required range is MSPI controller registers.
-
-- reg-names:
-    First name does not matter, but must be reserved for the MSPI controller
-    register range as mentioned in 'reg' above, and will typically contain
-    - "bspi_regs": BSPI register range, not required with compatible
-		   "spi-brcmstb-mspi"
-    - "mspi_regs": MSPI register range is required for compatible strings
-    - "intr_regs", "intr_status_reg" : Interrupt and status register for
-      NSP, NS2, Cygnus SoC
-
-- interrupts
-    The interrupts used by the MSPI and/or BSPI controller.
-
-- interrupt-names:
-    Names of interrupts associated with MSPI
-    - "mspi_halted" :
-    - "mspi_done": Indicates that the requested SPI operation is complete.
-    - "spi_lr_fullness_reached" : Linear read BSPI pipe full
-    - "spi_lr_session_aborted"  : Linear read BSPI pipe aborted
-    - "spi_lr_impatient" : Linear read BSPI requested when pipe empty
-    - "spi_lr_session_done" : Linear read BSPI session done
-
-- clocks:
-    A phandle to the reference clock for this block.
-
-Optional properties:
-
-
-- native-endian
-    Defined when using BE SoC and device uses BE register read/write
-
-Recommended optional m25p80 properties:
-- spi-rx-bus-width: Definition as per
-                    Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Examples:
-
-BRCMSTB SoC Example:
-
-  SPI Master (MSPI+BSPI) for SPI-NOR access:
-
-    spi@f03e3400 {
-		#address-cells = <0x1>;
-		#size-cells = <0x0>;
-		compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi";
-		reg = <0xf03e0920 0x4 0xf03e3400 0x188 0xf03e3200 0x50>;
-		reg-names = "cs_reg", "mspi", "bspi";
-		interrupts = <0x6 0x5 0x4 0x3 0x2 0x1 0x0>;
-		interrupt-parent = <0x1c>;
-		interrupt-names = "mspi_halted",
-				  "mspi_done",
-				  "spi_lr_overread",
-				  "spi_lr_session_done",
-				  "spi_lr_impatient",
-				  "spi_lr_session_aborted",
-				  "spi_lr_fullness_reached";
-
-		clocks = <&hif_spi>;
-		clock-names = "sw_spi";
-
-		m25p80@0 {
-			#size-cells = <0x2>;
-			#address-cells = <0x2>;
-			compatible = "m25p80";
-			reg = <0x0>;
-			spi-max-frequency = <0x2625a00>;
-			spi-cpol;
-			spi-cpha;
-			m25p,fast-read;
-
-			flash0.bolt@0 {
-				reg = <0x0 0x0 0x0 0x100000>;
-			};
-
-			flash0.macadr@100000 {
-				reg = <0x0 0x100000 0x0 0x10000>;
-			};
-
-			flash0.nvram@110000 {
-				reg = <0x0 0x110000 0x0 0x10000>;
-			};
-
-			flash0.kernel@120000 {
-				reg = <0x0 0x120000 0x0 0x400000>;
-			};
-
-			flash0.devtree@520000 {
-				reg = <0x0 0x520000 0x0 0x10000>;
-			};
-
-			flash0.splash@530000 {
-				reg = <0x0 0x530000 0x0 0x80000>;
-			};
-
-			flash0@0 {
-				reg = <0x0 0x0 0x0 0x4000000>;
-			};
-		};
-	};
-
-
-    MSPI master for any SPI device :
-
-	spi@f0416000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&upg_fixed>;
-		compatible = "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi";
-		reg = <0xf0416000 0x180>;
-		reg-names = "mspi";
-		interrupts = <0x14>;
-		interrupt-parent = <&irq0_aon_intc>;
-		interrupt-names = "mspi_done";
-	};
-
-iProc SoC Example:
-
-    qspi: spi@18027200 {
-	compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
-	reg = <0x18027200 0x184>,
-	      <0x18027000 0x124>,
-	      <0x1811c408 0x004>,
-	      <0x180273a0 0x01c>;
-	reg-names = "mspi_regs", "bspi_regs", "intr_regs", "intr_status_reg";
-	interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names =
-		     "spi_lr_fullness_reached",
-		     "spi_lr_session_aborted",
-		     "spi_lr_impatient",
-		     "spi_lr_session_done",
-		     "mspi_done",
-		     "mspi_halted";
-	clocks = <&iprocmed>;
-	clock-names = "iprocmed";
-	num-cs = <2>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-    };
-
-
- NS2 SoC Example:
-
-	       qspi: spi@66470200 {
-		       compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
-		       reg = <0x66470200 0x184>,
-			     <0x66470000 0x124>,
-			     <0x67017408 0x004>,
-			     <0x664703a0 0x01c>;
-		       reg-names = "mspi", "bspi", "intr_regs",
-			"intr_status_reg";
-		       interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
-		       interrupt-names = "spi_l1_intr";
-			clocks = <&iprocmed>;
-			clock-names = "iprocmed";
-			num-cs = <2>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-	       };
-
-
- m25p80 node for NSP, NS2
-
-	 &qspi {
-		      flash: m25p80@0 {
-		      #address-cells = <1>;
-		      #size-cells = <1>;
-		      compatible = "m25p80";
-		      reg = <0x0>;
-		      spi-max-frequency = <12500000>;
-		      m25p,fast-read;
-		      spi-cpol;
-		      spi-cpha;
-
-		      partition@0 {
-				  label = "boot";
-				  reg = <0x00000000 0x000a0000>;
-		      };
-
-		      partition@a0000 {
-				  label = "env";
-				  reg = <0x000a0000 0x00060000>;
-		      };
-
-		      partition@100000 {
-				  label = "system";
-				  reg = <0x00100000 0x00600000>;
-		      };
-
-		      partition@700000 {
-				  label = "rootfs";
-				  reg = <0x00700000 0x01900000>;
-		      };
-	};
diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
new file mode 100644
index 000000000000..6ee19d49fd3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,spi-bcm-qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom SPI controller
+
+maintainers:
+  - Kamal Dasu <kdasu.kdev@gmail.com>
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description: |
+  The Broadcom SPI controller is a SPI master found on various SOCs, including
+  BRCMSTB (BCM7XXX), Cygnus, NSP and NS2. The Broadcom Master SPI hw IP consits
+  of:
+    MSPI : SPI master controller can read and write to a SPI slave device
+    BSPI : Broadcom SPI in combination with the MSPI hw IP provides acceleration
+           for flash reads and be configured to do single, double, quad lane
+           io with 3-byte and 4-byte addressing support.
+
+  Supported Broadcom SoCs have one instance of MSPI+BSPI controller IP.
+  MSPI master can be used wihout BSPI. BRCMSTB SoCs have an additional instance
+  of a MSPI master without the BSPI to use with non flash slave devices that
+  use SPI protocol.
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description: Second Instance of MSPI BRCMSTB SoCs
+        items:
+          - enum:
+              - brcm,spi-bcm7425-qspi
+              - brcm,spi-bcm7429-qspi
+              - brcm,spi-bcm7435-qspi
+              - brcm,spi-bcm7445-qspi
+              - brcm,spi-bcm7216-qspi
+              - brcm,spi-bcm7278-qspi
+          - const: brcm,spi-bcm-qspi
+          - const: brcm,spi-brcmstb-mspi
+      - description: Second Instance of MSPI BRCMSTB SoCs
+        items:
+          - enum:
+              - brcm,spi-brcmstb-qspi
+              - brcm,spi-brcmstb-mspi
+              - brcm,spi-nsp-qspi
+              - brcm,spi-ns2-qspi
+          - const: brcm,spi-bcm-qspi
+
+  reg:
+    minItems: 1
+    maxItems: 5
+
+  reg-names:
+    minItems: 1
+    maxItems: 5
+    items:
+      - const: mspi
+      - const: bspi
+      - enum: [ intr_regs, intr_status_reg, cs_reg ]
+      - enum: [ intr_regs, intr_status_reg, cs_reg ]
+      - enum: [ intr_regs, intr_status_reg, cs_reg ]
+
+  interrupts:
+    minItems: 1
+    maxItems: 7
+
+  interrupt-names:
+    oneOf:
+      - minItems: 1
+        maxItems: 7
+        items:
+          - const: mspi_done
+          - const: mspi_halted
+          - const: spi_lr_fullness_reached
+          - const: spi_lr_session_aborted
+          - const: spi_lr_impatient
+          - const: spi_lr_session_done
+          - const: spi_lr_overread
+      - const: spi_l1_intr
+
+  clocks:
+    maxItems: 1
+    description: reference clock for this block
+
+  native-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Defined when using BE SoC and device uses BE register read/write
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+
+examples:
+  - | # BRCMSTB SoC: SPI Master (MSPI+BSPI) for SPI-NOR access
+    spi@f03e3400 {
+            compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi";
+            reg = <0xf03e3400 0x188>, <0xf03e3200 0x50>, <0xf03e0920 0x4>;
+            reg-names = "mspi", "bspi", "cs_reg";
+            interrupts = <0x5>, <0x6>, <0x1>, <0x2>, <0x3>, <0x4>, <0x0>;
+            interrupt-parent = <&gic>;
+            interrupt-names = "mspi_done",
+                              "mspi_halted",
+                              "spi_lr_fullness_reached",
+                              "spi_lr_session_aborted",
+                              "spi_lr_impatient",
+                              "spi_lr_session_done",
+                              "spi_lr_overread";
+            clocks = <&hif_spi>;
+            #address-cells = <0x1>;
+            #size-cells = <0x0>;
+
+            flash@0 {
+                    #size-cells = <0x2>;
+                    #address-cells = <0x2>;
+                    compatible = "m25p80";
+                    reg = <0x0>;
+                    spi-max-frequency = <0x2625a00>;
+                    spi-cpol;
+                    spi-cpha;
+            };
+    };
+  - | # BRCMSTB SoC: MSPI master for any SPI device
+    spi@f0416000 {
+            clocks = <&upg_fixed>;
+            compatible = "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi";
+            reg = <0xf0416000 0x180>;
+            reg-names = "mspi";
+            interrupts = <0x14>;
+            interrupt-parent = <&irq0_aon_intc>;
+            interrupt-names = "mspi_done";
+            #address-cells = <1>;
+            #size-cells = <0>;
+    };
+  - | # iProc SoC
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@18027200 {
+            compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
+            reg = <0x18027200 0x184>,
+                  <0x18027000 0x124>,
+                  <0x1811c408 0x004>,
+                  <0x180273a0 0x01c>;
+            reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
+            interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "mspi_done",
+                              "mspi_halted",
+                              "spi_lr_fullness_reached",
+                              "spi_lr_session_aborted",
+                              "spi_lr_impatient",
+                              "spi_lr_session_done";
+            clocks = <&iprocmed>;
+            num-cs = <2>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+    };
+  - | # NS2 SoC
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@66470200 {
+            compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
+            reg = <0x66470200 0x184>,
+                  <0x66470000 0x124>,
+                  <0x67017408 0x004>,
+                  <0x664703a0 0x01c>;
+            reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
+            interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "spi_l1_intr";
+            clocks = <&iprocmed>;
+            num-cs = <2>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            flash@0 {
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+                    compatible = "m25p80";
+                    reg = <0x0>;
+                    spi-max-frequency = <12500000>;
+                    spi-cpol;
+                    spi-cpha;
+            };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a1c2b56f4f90..6fb31a735a0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3696,7 +3696,7 @@ BROADCOM SPI DRIVER
 M:	Kamal Dasu <kdasu.kdev@gmail.com>
 M:	bcm-kernel-feedback-list@broadcom.com
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
+F:	Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
 F:	drivers/spi/spi-bcm-qspi.*
 F:	drivers/spi/spi-brcmstb-qspi.c
 F:	drivers/spi/spi-iproc-qspi.c
-- 
2.26.2

