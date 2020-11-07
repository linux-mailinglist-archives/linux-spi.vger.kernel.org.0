Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6B2AA3A5
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgKGIPZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:25 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIPZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736924; x=1636272924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QkRCfLP1RiMjOvLwrisdDi2IrprGO1LS2AaUs89hBgw=;
  b=eJDxYjNhar8xyv0oYbS9+h2uXdLelq6Ca80njO4CayiP2SYmNFXIXx6Z
   ilgp8wFsQXCmWV9v1TP3O09lu9MfBughKOinpfhNs692H6y16um7bCspx
   +sUwMMuKJV2CGNDwIxaM/PKJyc2RC9BBuOM160kDYPDXdW+RsjQoWsJ1k
   u+OAzYsP92c1R/p/1HASE6Ov4+99Zc2jXDeUN8KPRHoLY6JjEAzZG4qgR
   YcJ50c6xHfQUWwwfzbdBRRulP0BmVaj/17AEok7U1ynwFUJDtaPafjRgH
   TPo7aKw0zWO1ywiGR6sksfCIN9doVbFvrBQMukQsuLvRNxRAjs/Ah7d8y
   A==;
IronPort-SDR: lM4lpqv689/JuIMDOO4gZFzuO2XrAohTNfkwMYGsMlDtPE6atD4JfEXimrPPoBtp9xjAnFiVSh
 5Gb7XUxNZksmAEnaJYmc5XWAU/WPcgt7sp7w8229CdyiFKO1l+0GWe4RxdK7b9KPnFuZsI6BtX
 pC23lknFP/EtUZS4O8DOK4L+71Ph/E2jTkcx1P8Eivj5XIPQVKZxc9nRj09TG58XCtCQZQ/VAk
 vV6azDEkKylCpUNKfEof7sz5XFlRV0ktJY+x+MiYPbjQqGhRz93HhQ4hqorQ3bzRR+F8gyKwn8
 9Qg=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564419"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:24 +0800
IronPort-SDR: JEADym+E38O3EuyvCUKWoWeSyKY3njK4MfKgYxQR/3VaRXdiiCg7nPHGai2hzVnBE+SZVYhOxb
 082Wz4kF3zvEm4oj7t0jBIajI18EpRyTq7Moi6/JZWRPUM/AphCu4U7bLUgaXY0/M8Iazj7F/a
 UnrxfOAB4GNnjSU+W8g2HX7zpK3m54i/elZW9+cDbW++K4ibGQHV6qdHNzOvr56+mgqpdpE1Ez
 02Z8T9/F3rV09mNOJF0b52GovvA1cujYsGNVpMIjWfxOIRJKXWpr8LlR3X34OvvNQ3Z+O8WqtD
 8lH3lEjPxwRA6lkcw1cMbUyq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:15 -0800
IronPort-SDR: kNbmK/ZaWtIhWERqlBQPde5LebiYxI9kiEu8NrnS1rg2xhz2B9moqa38rqRkEw4qXSs9kQD4gN
 1UduA2IXuax8AVRO+HiLUrNXDyjrKKiSozhKTsiF3RxCpJFY4Izb9tYfB9DUOm24HSwDeDrc5f
 DIVlk9KPPSh0q5zYG99b2uOUnzNsQ9GEZWS/qfDsygdI0Gxw4henwmOBCRTyUJQwX7XsqhsZF2
 rGgGTdzOkGf/EgDjlylToDdHm8+sDeWdNFeRfndSZUrbFXJTg4QsMJj4H2dJ+0GNRdDXZYmpm4
 N4s=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:23 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 23/32] dt-binding: Document kendryte,k210-clk bindings
Date:   Sat,  7 Nov 2020 17:14:11 +0900
Message-Id: <20201107081420.60325-24-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the device tree bindings of the Kendryte K210 SoC clock driver
in Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 .../bindings/clock/kendryte,k210-clk.yaml     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml b/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml
new file mode 100644
index 000000000000..02f5f8a86bc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/kendryte,k210-clk.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/kendryte,k210-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kendryte K210 Clock Device Tree Bindings
+
+maintainers:
+  - Damien Le Moal <damien.lemoal@wdc.com>
+
+description: |
+  Kendryte K210 clock controller driver which support the system controller
+  subsystem supplied clocks for the various controllers and peripherals within
+  the SoC.
+
+  See also:
+  - dt-bindings/clock/k210-clk.h
+
+properties:
+  compatible:
+    const: kendryte,k210-clk
+
+  clocks:
+    maxItems: 1
+    description: System fixed rate oscillator clock
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#clock-cells'
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/k210-clk.h>
+
+    clocks {
+      in0: oscillator {
+        compatible = "fixed-clock";
+        #clock-cells = <0>;
+        clock-frequency = <26000000>;
+      };
+    };
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      /* ... */
+
+      sysctl: system-controller@50440000 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        compatible = "kendryte,k210-sysctl",
+                     "syscon", "simple-mfd";
+        reg = <0x50440000 0x1000>;
+        /* ... */
+        sysclk: clock-controller {
+          #clock-cells = <1>;
+          compatible = "kendryte,k210-clk";
+          clocks = <&in0>;
+        };
+        /* ... */
+      };
+    };
+
-- 
2.28.0

