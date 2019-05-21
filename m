Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32755259DE
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 23:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfEUVX2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 17:23:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41253 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfEUVX2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 17:23:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id l25so131387otp.8;
        Tue, 21 May 2019 14:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aB1+FRKR0aNQ2GxStZ6ZrmY5xDQPylN9JPI4SJkM8No=;
        b=HQJi7yuICDaGNVliWMuFqxNKNSJCtDlkOFuQORpr5fdQ9qammco4vYrpRVIQTuV1D/
         IO8wrDkaN0F+o6MkB3jgz8+Zx0ifMrLOES+Zf8KFMoGFX3zJdfdMsAZOduS4Td6A11bI
         o8DPGdZiSxo/JaDLYHEkuusCknIuvJJufQbLgXMCr4rUAg6XI2OmulCdsckWd2LXO0J+
         NGzvfqafmUryRq3Ap5pO8xJ4ht4UQgj31F+lQzuhVCxkMLqoHVeeJs797kr6JlPTBvZd
         xXUdVVT77W/mCZVuKoMS4cF6fM2oyAVok6Z0KaePhsQ8ICRP1I7kX+2Q7+PCsbLZYTHP
         2Tvw==
X-Gm-Message-State: APjAAAW35DWt5fg+tn3mrrggp+onsR/xTU9LpfAhMaktPRf2FSTVCrcv
        BT6B8JEem0ZIHBKgnr0ELg==
X-Google-Smtp-Source: APXvYqzGoiLXQXPir7xd+RNmN0PkeHgxiOnKX34+pmgA12jo9MTDa1PZ8kFP77q7FZYcgh/YHgyAsw==
X-Received: by 2002:a9d:7a54:: with SMTP id z20mr33048466otm.103.1558473807120;
        Tue, 21 May 2019 14:23:27 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id w24sm4835474otk.74.2019.05.21.14.23.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 14:23:26 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: dt-bindings: Convert Arm pl022 to json-schema
Date:   Tue, 21 May 2019 16:23:24 -0500
Message-Id: <20190521212325.16639-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert the Arm pl022 binding to DT schema format. The clock binding was
missing, so it is added to the schema. It really should be required as
well, but there are some platforms (spear) not yet using DT clock
binding.

Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-pl022.yaml    | 165 ++++++++++++++++++
 .../devicetree/bindings/spi/spi_pl022.txt     |  70 --------
 2 files changed, 165 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-pl022.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi_pl022.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
new file mode 100644
index 000000000000..dfb697c69341
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-pl022.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM PL022 SPI controller
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+# We need a select here so we don't match all nodes with 'arm,primecell'
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,pl022
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: arm,pl022
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - enum:
+          - SSPCLK
+          - sspclk
+      - const: apb_pclk
+
+  pl022,autosuspend-delay:
+    description: delay in ms following transfer completion before the
+      runtime power management system suspends the device. A setting of 0
+      indicates no delay and the device will be suspended immediately.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  pl022,rt:
+    description: indicates the controller should run the message pump with realtime
+               priority to minimise the transfer latency on the bus (boolean)
+    type: boolean
+
+  dmas:
+    description:
+      Two or more DMA channel specifiers following the convention outlined
+      in bindings/dma/dma.txt
+    minItems: 2
+    maxItems: 32
+
+  dma-names:
+    description:
+      There must be at least one channel named "tx" for transmit and named "rx"
+      for receive.
+    minItems: 2
+    maxItems: 32
+    additionalItems: true
+    items:
+      - const: rx
+      - const: tx
+
+patternProperties:
+  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-f]+$":
+    type: object
+    # SPI slave nodes must be children of the SPI master node and can
+    # contain the following properties.
+    properties:
+      pl022,interface:
+        description: SPI interface type
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - enum:
+              - 0  # SPI
+              - 1  # Texas Instruments Synchronous Serial Frame Format
+              - 2  # Microwire (Half Duplex)
+
+      pl022,com-mode:
+        description: Specifies the transfer mode
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - enum:
+              - 0  # interrupt mode
+              - 1  # polling mode
+              - 2  # DMA mode
+            default: 1
+
+      pl022,rx-level-trig:
+        description: Rx FIFO watermark level
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 4
+
+      pl022,tx-level-trig:
+        description: Tx FIFO watermark level
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0
+            maximum: 4
+
+      pl022,ctrl-len:
+        description: Microwire interface - Control length
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - minimum: 0x03
+            maximum: 0x1f
+
+      pl022,wait-state:
+        description: Microwire interface - Wait state
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - enum: [ 0, 1 ]
+
+      pl022,duplex:
+        description: Microwire interface - Full/Half duplex
+        allOf:
+          - $ref: "/schemas/types.yaml#/definitions/uint32"
+          - enum: [ 0, 1 ]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    spi@e0100000 {
+      compatible = "arm,pl022", "arm,primecell";
+      reg = <0xe0100000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      interrupts = <0 31 0x4>;
+      dmas = <&dma_controller 23 1>,
+        <&dma_controller 24 0>;
+      dma-names = "rx", "tx";
+
+      m25p80@1 {
+        compatible = "st,m25p80";
+        reg = <1>;
+        spi-max-frequency = <12000000>;
+        spi-cpol;
+        spi-cpha;
+        pl022,interface = <0>;
+        pl022,com-mode = <0x2>;
+        pl022,rx-level-trig = <0>;
+        pl022,tx-level-trig = <0>;
+        pl022,ctrl-len = <0x11>;
+        pl022,wait-state = <0>;
+        pl022,duplex = <0>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/spi/spi_pl022.txt b/Documentation/devicetree/bindings/spi/spi_pl022.txt
deleted file mode 100644
index 7638b4968ddb..000000000000
--- a/Documentation/devicetree/bindings/spi/spi_pl022.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-ARM PL022 SPI controller
-
-Required properties:
-- compatible : "arm,pl022", "arm,primecell"
-- reg : Offset and length of the register set for the device
-- interrupts : Should contain SPI controller interrupt
-- num-cs : total number of chipselects
-
-Optional properties:
-- cs-gpios : should specify GPIOs used for chipselects.
-  The gpios will be referred to as reg = <index> in the SPI child nodes.
-  If unspecified, a single SPI device without a chip select can be used.
-- pl022,autosuspend-delay : delay in ms following transfer completion before
-			    the runtime power management system suspends the
-			    device. A setting of 0 indicates no delay and the
-                            device will be suspended immediately
-- pl022,rt : indicates the controller should run the message pump with realtime
-             priority to minimise the transfer latency on the bus (boolean)
-- dmas : Two or more DMA channel specifiers following the convention outlined
-         in bindings/dma/dma.txt
-- dma-names: Names for the dma channels, if present. There must be at
-	     least one channel named "tx" for transmit and named "rx" for
-             receive.
-
-
-SPI slave nodes must be children of the SPI master node and can
-contain the following properties.
-
-- pl022,interface : interface type:
-	0: SPI
-	1: Texas Instruments Synchronous Serial Frame Format
-	2: Microwire (Half Duplex)
-- pl022,com-mode : specifies the transfer mode:
-	0: interrupt mode
-	1: polling mode (default mode if property not present)
-	2: DMA mode
-- pl022,rx-level-trig : Rx FIFO watermark level
-- pl022,tx-level-trig : Tx FIFO watermark level
-- pl022,ctrl-len : Microwire interface: Control length
-- pl022,wait-state : Microwire interface: Wait state
-- pl022,duplex : Microwire interface: Full/Half duplex
-
-
-Example:
-
-	spi@e0100000 {
-		compatible = "arm,pl022", "arm,primecell";
-		reg = <0xe0100000 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <0 31 0x4>;
-		dmas = <&dma-controller 23 1>,
-			<&dma-controller 24 0>;
-		dma-names = "rx", "tx";
-
-		m25p80@1 {
-			compatible = "st,m25p80";
-			reg = <1>;
-			spi-max-frequency = <12000000>;
-			spi-cpol;
-			spi-cpha;
-			pl022,interface = <0>;
-			pl022,com-mode = <0x2>;
-			pl022,rx-level-trig = <0>;
-			pl022,tx-level-trig = <0>;
-			pl022,ctrl-len = <0x11>;
-			pl022,wait-state = <0>;
-			pl022,duplex = <0>;
-		};
-	};
-- 
2.20.1

