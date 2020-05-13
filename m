Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCA1D16B3
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbgEMOAx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:00:53 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48473 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388790AbgEMOAw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 May 2020 10:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589378451; x=1620914451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ake5spHoiYj8zomwaQaU2aZPFaP8CHv+djGRK18gQcA=;
  b=DBqhI4YhKZaLAYB5tBOy+6hOd4Yp72PgZl4kSenGUTzMD+ayJAbbeX91
   4Y20ju3gVKJC7EygEvR9tpvEJ6tG/5DJDe8tzsbpFbmKnhezgHtOoeg/v
   U7EOfbNpbhznatRgrVSpv/II4pAV4otjRTfpHkJnaXkUO8D7j64eDkMFT
   DVmugMdW4ye8YaLx0BPAkhikB2zLWQVT7DojnRRuVOpquD5PyUdLUO3jq
   ktLIyaTPLFrnpjNwIoeFSDmwmfsryJYQkF4Ael3/9OXcYIMzGOlhiH7OE
   nmgCekgwyGCT/U5jF6ZwWGh+Kqp+BqSHMNmIio1oyZ/dGbk86YnxxsYb0
   Q==;
IronPort-SDR: yS2yVnStK38NBPJvBBGdydOanJyfTZ0yQmVW5C6k6BAWGYsW5t9Pm5owVgmjbePA5G5h//Fm1u
 txcwS6dlzIamC4M7QCR5jXWFyr83dZFPke6/pRNZ7U5kDBKyGn1fScqLRuUG3MTi+BTPuFJ3+D
 zfR74OuncT4bG0m+YYOPVvl5Qxdw79xZPywhCBr6a1TK5ov0Iyc0SFDYXXIjYPNPrESHif5m0W
 lfxNN2NKVkyedH4BVVOexzVMFPMhLBTsKXtUU9EhNpSjgSchA7R82cAimJ/s1Gd/nako5WeL/K
 pSU=
X-IronPort-AV: E=Sophos;i="5.73,388,1583218800"; 
   d="scan'208";a="79447496"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 07:00:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 07:00:53 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 07:00:48 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 04/10] dt-bindings: spi: Add bindings for spi-dw-mchp
Date:   Wed, 13 May 2020 16:00:25 +0200
Message-ID: <20200513140031.25633-5-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513140031.25633-1-lars.povlsen@microchip.com>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This add DT bindings for the Microsemi/Microchip SPI controller used
in various SoC's. It describes the "mscc,ocelot-spi" and
"mscc,jaguar2-spi" bindings.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 .../bindings/spi/mscc,ocelot-spi.yaml         | 60 +++++++++++++++++++
 .../bindings/spi/snps,dw-apb-ssi.txt          |  7 +--
 MAINTAINERS                                   |  1 +
 3 files changed, 63 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
new file mode 100644
index 0000000000000..a3ac0fa576553
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/mscc,ocelot-spi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microsemi Vcore-III SPI Communication Controller
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Lars Povlsen <lars.povlsen@microchip.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+description: |
+  The Microsemi Vcore-III SPI controller is a general purpose SPI
+  controller based upon the Designware SPI controller. It uses an 8
+  byte rx/tx fifo.
+
+properties:
+  compatible:
+    enum:
+      - mscc,ocelot-spi
+      - mscc,jaguar2-spi
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    minItems: 2
+    items:
+      - description: Designware SPI registers
+      - description: CS override registers
+
+  clocks:
+    maxItems: 1
+
+  reg-io-width:
+    description: |
+      The I/O register width (in bytes) implemented by this device.
+    items:
+       enum: [ 2, 4 ]
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    spi0: spi@101000 {
+      compatible = "mscc,ocelot-spi";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      reg = <0x101000 0x100>, <0x3c 0x18>;
+      interrupts = <9>;
+      clocks = <&ahb_clk>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 3ed08ee9feba4..5e1849be7bae5 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -1,10 +1,8 @@
 Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.

 Required properties:
-- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2", or "amazon,alpine-dw-apb-ssi"
-- reg : The register base for the controller. For "mscc,<soc>-spi", a second
-  register set is required (named ICPU_CFG:SPI_MST)
+- compatible : "snps,dw-apb-ssi" or "amazon,alpine-dw-apb-ssi"
+- reg : The register base for the controller.
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
@@ -38,4 +36,3 @@ Example:
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
 	};
-
diff --git a/MAINTAINERS b/MAINTAINERS
index 1db598723a1d8..6472240b8391b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11231,6 +11231,7 @@ L:	linux-mips@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mips/mscc.txt
 F:	Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
+F:	Documentation/devicetree/bindings/spi/mscc,ocelot-spi.yaml
 F:	arch/mips/boot/dts/mscc/
 F:	arch/mips/configs/generic/board-ocelot.config
 F:	arch/mips/generic/board-ocelot.c
--
2.26.2
