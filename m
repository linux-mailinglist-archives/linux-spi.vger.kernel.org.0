Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24C9818B9
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2019 14:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfHEMDb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Aug 2019 08:03:31 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42796 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfHEMDb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Aug 2019 08:03:31 -0400
Received: by mail-wr1-f54.google.com with SMTP id x1so34248704wrr.9
        for <linux-spi@vger.kernel.org>; Mon, 05 Aug 2019 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1UVbrDvxHP5fxAN2NFQuc4DUAHk3kIbjh3o2fngqONY=;
        b=Hp4E2CtC/CqVj2zUXcx0mf2aKRE8qNhjqoRkDLzn/2ALVO8KG/wgxj/8JsqNdYoCpX
         LicIz8U0wOImo8ByhkgKlAT2i2vDKQCFheCdpBLfCArxDd6WBiXfwKw7z15Ks2rMXTH2
         NbfvUjP+OL4hyJGMpBylUgSTnW6SvBeZr4SijYlyt7Ei3Rwq6RwHWeIyJ80NaRTUEtBR
         o2pBGhEzT8fF4N0EUANccvuhKuGV/2R9kDehR/iaTt15tVHhUzqE5UDn/VPWAYRpelgb
         ntJl39mCOUe24RS7FdTCz8Y8OCo2nJ7VUEwpnGsXrq+jU3tOcCyJ9LIJAtxHCKzfKtSF
         R5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1UVbrDvxHP5fxAN2NFQuc4DUAHk3kIbjh3o2fngqONY=;
        b=JqX66YVDJU2Oe+mIo0upZYCYjoxSYTNZCzcs8k+INssNAZbK8ueoyDBZHQ9n0Zjyhk
         TIQu4KYTVNq6jU8m7SjKolIr8Mn1Rz9L72/3i54dwIzqGxX4EcEDeyK6oPKb2VWQ+DwQ
         A31KNwsGnK42pSfIc8Ubu3t9umq1araDHEF32O3gaOfAdR+vU3yYTZZR1uEKfW1venyZ
         K7pDUH4TjcuHmMIRtZazbuwmBkr/e0Om8aAoL5VBnCp4jjJ+OKm8e/qD+nrmN9qvn3/q
         YdjCdALf5Ve2sYEYfh3Klk9gd9qHGjAV/QnaUaWGcZOlPPGvBMS7HUAePc6P+0z4O9AN
         mZOQ==
X-Gm-Message-State: APjAAAUP695SLLrKDImeEM69ett8NMaZvWL+bEOwQbOUIsTEgJOxrUHV
        nQ61GUKo5zXiFkji+k1afuRfdQ==
X-Google-Smtp-Source: APXvYqyd3wkTX3t9piiXsiUvpCyXSr8KaClorqcwW6T6bYRCzKarSSd9WohTarGxBu0zlFBS9XZbCA==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr4966844wrq.329.1565006607836;
        Mon, 05 Aug 2019 05:03:27 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x6sm88683668wrt.63.2019.08.05.05.03.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:03:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [RFCv2 3/9] dt-bindings: spi: meson: convert to yaml
Date:   Mon,  5 Aug 2019 14:03:14 +0200
Message-Id: <20190805120320.32282-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805120320.32282-1-narmstrong@baylibre.com>
References: <20190805120320.32282-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Now that we have the DT validation in place, let's convert the device tree
bindings for the Amlogic SPI controllers over to two separate YAML schemas.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  | 67 +++++++++++++++++++
 .../bindings/spi/amlogic,meson6-spifc.yaml    | 53 +++++++++++++++
 .../devicetree/bindings/spi/spi-meson.txt     | 55 ---------------
 3 files changed, 120 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
new file mode 100644
index 000000000000..49b617c98ae7
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -0,0 +1,67 @@
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
+    enum:
+      - amlogic,meson-gx-spicc # SPICC controller on Amlogic GX and compatible SoCs
+      - amlogic,meson-axg-spicc # SPICC controller on Amlogic AXG and compatible SoCs
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  resets:
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
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
+
+          ethernet-switch@0 {
+              compatible = "micrel,ks8995m";
+              spi-max-frequency = <1000000>;
+              reg = <0>;
+          };
+    };
+
diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
new file mode 100644
index 000000000000..67dcedc81a5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
@@ -0,0 +1,53 @@
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
+    enum:
+      - amlogic,meson6-spifc # SPI Flash Controller on Meson6 and compatible SoCs
+      - amlogic,meson-gxbb-spifc # SPI Flash Controller on GXBB and compatible SoCs
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    spi@c1108c80 {
+          compatible = "amlogic,meson6-spifc";
+          reg = <0xc1108c80 0x80>;
+          clocks = <&clk81>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          flash: m25p80@0 {
+              compatible = "spansion,m25p80", "jedec,spi-nor";
+              reg = <0>;
+              spi-max-frequency = <40000000>;
+          };
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

