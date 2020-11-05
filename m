Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089D22A7DE3
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 13:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgKEMEh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Nov 2020 07:04:37 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:48530 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgKEMEd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 07:04:33 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0A5BxvqA068678;
        Thu, 5 Nov 2020 19:59:57 +0800 (GMT-8)
        (envelope-from chin-ting_kuo@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 5 Nov
 2020 20:03:35 +0800
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <clg@kaod.org>, <bbrezillon@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-spi@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v3 1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory controller
Date:   Thu, 5 Nov 2020 20:03:28 +0800
Message-ID: <20201105120331.9853-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
References: <20201105120331.9853-1-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0A5BxvqA068678
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Create binding file with YAML syntax for ASPEED FMC/SPI memory controller.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 .../bindings/spi/aspeed,spi-aspeed.yaml       | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml

diff --git a/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml b/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
new file mode 100644
index 000000000000..41b9692c7226
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/aspeed,spi-aspeed.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/aspeed,spi-aspeed.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI memory controller for ASPEED SoCs
+
+maintainers:
+  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
+
+description: |
+  There are three SPI memory controllers embedded in a ASPEED SoC.
+  They are usually connected to SPI NOR flashes. Each of them has
+  more than a chip select. They also support SPI single, dual and
+  quad IO modes for SPI NOR flash.
+
+allOf:
+  - $ref: /spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - aspeed,ast2600-fmc
+              - aspeed,ast2600-spi
+
+  reg:
+    items:
+      - description: the control register location and length
+      - description: the flash memory mapping address and length
+
+  clocks:
+    description: AHB bus clock which will be converted to SPI bus clock
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - num-cs
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    spi1: spi@1e630000 {
+      compatible = "aspeed,ast2600-spi";
+      reg = <0x1e630000 0xc4>, <0x30000000 0x10000000>;
+      reg-names = "spi_ctrl_reg", "spi_mmap";
+      clocks = <&syscon ASPEED_CLK_AHB>;
+      num-cs = <2>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      flash@0 {
+        compatible = "jedec,spi-nor";
+        reg = <0>;
+        spi-max-frequency = <50000000>;
+      };
+      flash@1 {
+        compatible = "jedec,spi-nor";
+        reg = <1>;
+        spi-max-frequency = <50000000>;
+      };
+    };
-- 
2.17.1

