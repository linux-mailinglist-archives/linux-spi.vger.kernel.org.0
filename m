Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFC7DCF2
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 15:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfHAN4z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 09:56:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36545 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfHAN4x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 09:56:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so59191345wme.1
        for <linux-spi@vger.kernel.org>; Thu, 01 Aug 2019 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXyeRm+Y8WqhyUSB1/Z8ubARpegGFJSnbzmE3UhBZi4=;
        b=G9dFzubUhXtRMonjuAhZpVE0wxXqLZ45ZgGJI7M4xVmQaTVARw9zgn6VsJNZ/szRxg
         koSiTIORxbK33+h5Uc1XJwjL1H4CY/4YL0pGsMU/sP4qGMyO2q2WgJbuL7XRhm2UrLrp
         8Tor9CksAfOA3kl9wa/TCx4WgYYBjYzPbY5yx6ouewlSSAHODOUaRw/X0pN5qQgPAdrL
         0nzlxiK8gXxNpDbvZPlGXtTAYnmEZ1o9DMWqLr2+xuaObUOrNFaASXt2AEvcYiWWuJx6
         Uj1CnEOn7BdfvOKwCxoK3a8gjZa6NWXs+2ByHfwopIWNA6NFs7AclQinZhCGvxgQVBYU
         Oy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXyeRm+Y8WqhyUSB1/Z8ubARpegGFJSnbzmE3UhBZi4=;
        b=nrvUsFflSku8CleOK+l8BpeWjhhOzIA0mORRBmYeVnFrXJ+S6SPUO90deNc8iGQ7Xr
         bZ0WDldrTTnDsujKEcyHYpmdtEb9nx2KiXkpVJAu+esh6YLbotVQkOeKe1M6IKFPTyyG
         iD9TIDJnPTznuI7ZJQUGsLNpT6HK1RMSZ72gqJXPq+GF77kcm1J1YAK7Wol1lPO1JNxx
         pRmJFagvrqz+xptIOLvxaa7XiAhhZN4wUZs0dFx/uu6GN2jdwy2gdpC2avGRkTtuoxWP
         F/IFqPr6U+RqK6NnrAqUDxo+4Gk81+LF/1+YS4jdYTqz8j55W5kg1KKaJR6Y0Mpj5H4r
         WiHQ==
X-Gm-Message-State: APjAAAWG6jnWBZWjms7GPoA4V48M7N881aomIvnGnHT4y+aW3RendyZW
        AOwNPy/QDBhSv4jG5RgMGP9H6g==
X-Google-Smtp-Source: APXvYqwN2ieKta2tfsG75bWmiaW9bqg05M9Gn8+95gS/HQBsOUyRtJtV6NPsFGozTyIDXdSdxvCbeg==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr40580154wmc.33.1564667810201;
        Thu, 01 Aug 2019 06:56:50 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u6sm69659952wml.9.2019.08.01.06.56.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 06:56:49 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RFC 3/9] dt-bindings: spi: meson: convert to yaml
Date:   Thu,  1 Aug 2019 15:56:38 +0200
Message-Id: <20190801135644.12843-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801135644.12843-1-narmstrong@baylibre.com>
References: <20190801135644.12843-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 74 +++++++++++++++++++
 .../bindings/spi/amlogic,meson6-spifc.yaml    | 57 ++++++++++++++
 .../devicetree/bindings/spi/spi-meson.txt     | 55 --------------
 3 files changed, 131 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
new file mode 100644
index 000000000000..6e2c41c730b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/amlogic,meson-gx-spicc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson SPI Communication Controller
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+description: |
+  The Meson SPICC is a generic SPI controller for general purpose Full-Duplex
+  communications with dedicated 16 words RX/TX PIO FIFOs.
+
+properties:
+  compatible:
+    oneOf:
+     - description: SPICC controller on Amlogic GX and compatible SoCs
+       enum:
+       - amlogic,meson-gx-spicc
+     - description: SPICC controller on Amlogic AXG and compatible SoCs
+       enum:
+       - amlogic,meson-axg-spicc
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  resets:
+    description: phandle of the internal reset line
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description: input clock for the baud rate generator
+    items:
+      - const: core
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    spi@c1108d80 {
+          compatible = "amlogic,meson-gx-spicc";
+          reg = <0xc1108d80 0x80>;
+          interrupts = <112>;
+          clocks = <&clk81>;
+          clock-names = "core";
+          #address-cells = <1>;
+          #size-cells = <0>;
+    };
+
diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
new file mode 100644
index 000000000000..5f34aed1ad40
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/amlogic,meson6-spifc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson SPI Flash Controller
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+description: |
+  The Meson SPIFC is a controller optimized for communication with SPI
+  NOR memories, without DMA support and a 64-byte unified transmit /
+  receive buffer.
+
+properties:
+  compatible:
+    oneOf:
+     - enum:
+       - amlogic,meson6-spifc
+     - enum:
+       - amlogic,meson-gxbb-spifc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    spi@c1108c80 {
+          compatible = "amlogic,meson6-spifc";
+          reg = <0xc1108c80 0x80>;
+          clocks = <&clk81>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+    };
+
diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
deleted file mode 100644
index b7f5e86fed22..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-meson.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Amlogic Meson SPI controllers
-
-* SPIFC (SPI Flash Controller)
-
-The Meson SPIFC is a controller optimized for communication with SPI
-NOR memories, without DMA support and a 64-byte unified transmit /
-receive buffer.
-
-Required properties:
- - compatible: should be "amlogic,meson6-spifc" or "amlogic,meson-gxbb-spifc"
- - reg: physical base address and length of the controller registers
- - clocks: phandle of the input clock for the baud rate generator
- - #address-cells: should be 1
- - #size-cells: should be 0
-
-	spi@c1108c80 {
-		compatible = "amlogic,meson6-spifc";
-		reg = <0xc1108c80 0x80>;
-		clocks = <&clk81>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-* SPICC (SPI Communication Controller)
-
-The Meson SPICC is generic SPI controller for general purpose Full-Duplex
-communications with dedicated 16 words RX/TX PIO FIFOs.
-
-Required properties:
- - compatible: should be:
-	"amlogic,meson-gx-spicc" on Amlogic GX and compatible SoCs.
-	"amlogic,meson-axg-spicc" on Amlogic AXG and compatible SoCs
- - reg: physical base address and length of the controller registers
- - interrupts: The interrupt specifier
- - clock-names: Must contain "core"
- - clocks: phandle of the input clock for the baud rate generator
- - #address-cells: should be 1
- - #size-cells: should be 0
-
-Optional properties:
- - resets: phandle of the internal reset line
-
-See ../spi/spi-bus.txt for more details on SPI bus master and slave devices
-required and optional properties.
-
-Example :
-	spi@c1108d80 {
-		compatible = "amlogic,meson-gx-spicc";
-		reg = <0xc1108d80 0x80>;
-		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-		clock-names = "core";
-		clocks = <&clk81>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-- 
2.22.0

