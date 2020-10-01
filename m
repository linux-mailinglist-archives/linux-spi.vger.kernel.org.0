Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A812A280A1C
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgJAW31 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:29:27 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48270 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733153AbgJAW3P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 18:29:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 29DB8803202B;
        Thu,  1 Oct 2020 22:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nulns70gP-Ez; Fri,  2 Oct 2020 01:29:04 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 20/21] dt-bindings: spi: dw: Add Baikal-T1 SPI Controllers
Date:   Fri, 2 Oct 2020 01:28:28 +0300
Message-ID: <20201001222829.15977-21-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

These controllers are based on the DW APB SSI IP-core and embedded into
the SoC, so two of them are equipped with IRQ, DMA, 64 words FIFOs and 4
native CS, while another one as being utilized by the Baikal-T1 System
Boot Controller has got a very limited resources: no IRQ, no DMA, only a
single native chip-select and just 8 bytes Tx/Rx FIFOs available. That's
why we have to mark the IRQ to be optional for the later interface.

The SPI controller embedded into the Baikal-T1 System Boot Controller can
be also used to directly access an external SPI flash by means of a
dedicated FSM. The corresponding MMIO region availability is switchable by
the embedded multiplexor, which phandle can be specified in the dts node.

* We added a new example to test out the non-standard Baikal-T1 System
Boot SPI Controller DT binding.

Co-developed-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index c62cbe79f00d..d6ae35777dac 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -22,6 +22,21 @@ allOf:
       properties:
         reg:
           minItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - baikal,bt1-sys-ssi
+    then:
+      properties:
+        mux-controls:
+          maxItems: 1
+      required:
+        - mux-controls
+    else:
+      required:
+        - interrupts
 
 properties:
   compatible:
@@ -44,12 +59,16 @@ properties:
           - const: snps,dw-apb-ssi
       - description: Intel Keem Bay SPI Controller
         const: intel,keembay-ssi
+      - description: Baikal-T1 SPI Controller
+        const: baikal,bt1-ssi
+      - description: Baikal-T1 System Boot SPI Controller
+        const: baikal,bt1-sys-ssi
 
   reg:
     minItems: 1
     items:
       - description: DW APB SSI controller memory mapped registers
-      - description: SPI MST region map
+      - description: SPI MST region map or directly mapped SPI ROM
 
   interrupts:
     maxItems: 1
@@ -114,7 +133,6 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - interrupts
   - clocks
 
 examples:
@@ -130,4 +148,15 @@ examples:
       cs-gpios = <&gpio0 13 0>,
                  <&gpio0 14 0>;
     };
+  - |
+    spi@1f040100 {
+      compatible = "baikal,bt1-sys-ssi";
+      reg = <0x1f040100 0x900>,
+            <0x1c000000 0x1000000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      mux-controls = <&boot_mux>;
+      clocks = <&ccu_sys>;
+      clock-names = "ssi_clk";
+    };
 ...
-- 
2.27.0

