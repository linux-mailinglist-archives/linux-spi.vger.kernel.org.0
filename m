Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C669534C1D0
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 04:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhC2CAo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Mar 2021 22:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhC2CAM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Mar 2021 22:00:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9801BC0613B5
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 19:00:00 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l3so8870358pfc.7
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 19:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mL/Sgm8OGhZihxh03UyCmsmL8yCcjUpcxd2H6bufsHY=;
        b=095Rb/mA+bz6rmgdwwcROxOk/3nzhc8aRr0R4BqxblwDjisXnLSQjqO9tSnAg0ejf9
         JZUj7aquG1nkrrxifH31UUtS5j0JBGHfIqVph6zjQE6e+GVZC738Tv8RxwZsCcUaKaG5
         d+w7uCpp9T6l3Yk1RVdbhoM3d2JtRrTCxAEBe+LG+8UV1TCKp+W45G34SXHr8NpqrnsY
         JSpAucw0od/0H/zuW5XKzIOFDioHsvxzI3GrtTg0N+b046gX9YgADfomX8P3dmpnONF/
         Bv15Fppgvn+TvIa4sh0U3F379CjbY0WeIBqxXRcttA3f0KU7B4YQUcAIvuWvtvfkl9kd
         F2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mL/Sgm8OGhZihxh03UyCmsmL8yCcjUpcxd2H6bufsHY=;
        b=csxnDesOaJlr38ONYJkYnDYQyLxy35A5pgVsvkcDccmrTrZ9vYX2T6+2/R32R3nsIO
         TTXIlpGNCoNikWvV5x5yYL35XlZgmvY0QO1ZVenVX+MS3QdOKVTnp4fywieWUNENt/Bc
         kLv07TfiVK0ae/kupUITm9q8UQdeNbW09EMSihDS+f6iwAZjJETwc4CPp+f03EWCLowt
         bVcWe7Y3417GjdcOv2vPSOXblZ7lba9TtwS3rxLZJHFGp7x6Tjoov4HpgZ8jXZO5rKws
         yc/3luZMsMC8aEMoFymfTE3zjxFhAm3gazbtB6Nk7en8MVpYugj2OyFY8qhOfaNjtPQh
         K2+w==
X-Gm-Message-State: AOAM5303KFijiY0JmXJl3GsmEggEOPv0LDvwgM0OqSLoYDLtjLOldhyG
        saYu657Ud4vtcs+8rZQC1PF/NQ==
X-Google-Smtp-Source: ABdhPJx32RmJJaqZeTXIHjzlYssXHCff5jyhobLMMVxqZkvUDN3yAu/IJhImuD3o/YB/6hzzaChuNw==
X-Received: by 2002:aa7:848b:0:b029:1ef:4e98:6bb6 with SMTP id u11-20020aa7848b0000b02901ef4e986bb6mr23143917pfn.58.1616983199972;
        Sun, 28 Mar 2021 18:59:59 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.18.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 18:59:59 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] dt-bindings: spi: cadence-qspi: Add support for Pensando Elba SoC
Date:   Sun, 28 Mar 2021 18:59:35 -0700
Message-Id: <20210329015938.20316-11-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add new vendor Pensando Systems Elba SoC compatible
string and convert to json-schema.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 .../bindings/spi/cadence-quadspi.txt          |  68 --------
 .../bindings/spi/cadence-quadspi.yaml         | 153 ++++++++++++++++++
 2 files changed, 153 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
deleted file mode 100644
index 8ace832a2d80..000000000000
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-* Cadence Quad SPI controller
-
-Required properties:
-- compatible : should be one of the following:
-	Generic default - "cdns,qspi-nor".
-	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
-	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
-	For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
-- reg : Contains two entries, each of which is a tuple consisting of a
-	physical address and length. The first entry is the address and
-	length of the controller register set. The second entry is the
-	address and length of the QSPI Controller data area.
-- interrupts : Unit interrupt specifier for the controller interrupt.
-- clocks : phandle to the Quad SPI clock.
-- cdns,fifo-depth : Size of the data FIFO in words.
-- cdns,fifo-width : Bus width of the data FIFO in bytes.
-- cdns,trigger-address : 32-bit indirect AHB trigger address.
-
-Optional properties:
-- cdns,is-decoded-cs : Flag to indicate whether decoder is used or not.
-- cdns,rclk-en : Flag to indicate that QSPI return clock is used to latch
-  the read data rather than the QSPI clock. Make sure that QSPI return
-  clock is populated on the board before using this property.
-
-Optional subnodes:
-Subnodes of the Cadence Quad SPI controller are spi slave nodes with additional
-custom properties:
-- cdns,read-delay : Delay for read capture logic, in clock cycles
-- cdns,tshsl-ns : Delay in nanoseconds for the length that the master
-                  mode chip select outputs are de-asserted between
-		  transactions.
-- cdns,tsd2d-ns : Delay in nanoseconds between one chip select being
-                  de-activated and the activation of another.
-- cdns,tchsh-ns : Delay in nanoseconds between last bit of current
-                  transaction and deasserting the device chip select
-		  (qspi_n_ss_out).
-- cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
-                  and first bit transfer.
-- resets	: Must contain an entry for each entry in reset-names.
-		  See ../reset/reset.txt for details.
-- reset-names	: Must include either "qspi" and/or "qspi-ocp".
-
-Example:
-
-	qspi: spi@ff705000 {
-		compatible = "cdns,qspi-nor";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xff705000 0x1000>,
-		      <0xffa00000 0x1000>;
-		interrupts = <0 151 4>;
-		clocks = <&qspi_clk>;
-		cdns,is-decoded-cs;
-		cdns,fifo-depth = <128>;
-		cdns,fifo-width = <4>;
-		cdns,trigger-address = <0x00000000>;
-		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
-		reset-names = "qspi", "qspi-ocp";
-
-		flash0: n25q00@0 {
-			...
-			cdns,read-delay = <4>;
-			cdns,tshsl-ns = <50>;
-			cdns,tsd2d-ns = <50>;
-			cdns,tchsh-ns = <4>;
-			cdns,tslch-ns = <4>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
new file mode 100644
index 000000000000..94d631045153
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/cadence-quadspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence Quad SPI controller
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+  - Brad Larson <brad@pensando.io>
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - cdns,qspi-nor       # Generic default
+        - ti,k2g-qspi         # TI 66AK2G SoC
+        - ti,am654-ospi       # TI AM654 SoC
+        - intel,lgm-qspi      # Intel LGM SoC
+        - pensando,cdns-qspi  # Pensando Elba SoC
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  reg:
+    minItems: 2
+    maxItems: 2
+    description: |
+      Contains two entries, each of which is a tuple consisting of a
+      physical address and length. The first entry is the address and
+      length of the controller register set. The second entry is the
+      address and length of the QSPI Controller data area.
+
+  interrupts:
+    maxItems: 1
+    description: Unit interrupt specifier for the controller interrupt
+
+  clocks:
+    description: phandle to the Quad SPI clock
+
+  cdns,fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Size of the data FIFO in words
+
+  cdns,fifo-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Bus width of the data FIFO in bytes
+
+  cdns,trigger-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: 32-bit indirect AHB trigger address
+
+  cdns,is-decoded-cs:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Flag to indicate whether decoder is used or not
+
+  cdns,rclk-en:
+    description:
+      Flag to indicate that QSPI return clock is used to latch the
+      read data rather than the QSPI clock. Make sure that QSPI return
+      clock is populated on the board before using this property
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  # Subnodes of the Cadence Quad SPI controller are spi slave nodes 
+  # with additional custom properties
+  cdns,read-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Delay for read capture logic, in clock cycles
+
+  cdns,tshsl-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Delay in nanoseconds for the length that the master mode chip
+      select outputs are de-asserted between transactions
+
+  cdns,tsd2d-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Delay in nanoseconds between one chip select being de-activated
+      and the activation of another.
+
+  cdns,tchsh-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Delay in nanoseconds between last bit of current transaction and
+      deasserting the device chip select (qspi_n_ss_out).
+
+  cdns,tslch-ns:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Delay in nanoseconds between setting qspi_n_ss_out low and first
+      bit transfer.
+
+  resets:
+    items:
+      - description: qspi reset
+      - description: qspi-ocp reset
+
+  reset-names:
+    items:
+      - const: qspi
+      - const: qspi-ocp
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - cdns,fifo-depth
+  - cdns,fifo-width
+  - cdns,trigger-address
+
+patternProperties:
+  "^.*@[0-9]+$":
+    type: object
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/altr,rst-mgr-a10.h>
+    qspi: spi@ff705000 {
+        compatible = "cdns,qspi-nor";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xff705000 0x1000>,
+              <0xffa00000 0x1000>;
+        interrupts = <0 151 4>;
+        clocks = <&qspi_clk>;
+        cdns,is-decoded-cs;
+        cdns,fifo-depth = <128>;
+        cdns,fifo-width = <4>;
+        cdns,trigger-address = <0x00000000>;
+        resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
+        reset-names = "qspi", "qspi-ocp";
+
+        flash0: mt25q@0 {
+                compatible = "jdec,spi-nor";
+                reg = <0>;
+                spi-max-frequency = <40000000>;
+                spi-rx-bus-width = <2>;
+                m25p,fast-read;
+                cdns,read-delay = <0>;
+                cdns,tshsl-ns = <0>;
+                cdns,tsd2d-ns = <0>;
+                cdns,tchsh-ns = <0>;
+                cdns,tslch-ns = <0>;
+        };
+    };
-- 
2.17.1

