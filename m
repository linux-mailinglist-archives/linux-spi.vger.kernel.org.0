Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF932AA3AB
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKGIPb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgKGIPa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736930; x=1636272930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VhB8WEnLoq7dAyllPLVCuTHZzGrie11gmx4BWMw3mkw=;
  b=XAxLTqRjZH1mU8r9jbSO9z8XTPetLWgu0Kc8kdJmBBT2CoTGGvOJB55q
   PO7LkfWqcksbowQQYiEIzirPejos2dPmQy1AlY/C4RWoTMO44XWYSAWVM
   qUT0cPz/QSXZHqFHZcvUsM/tNL2I1zrJlzrgTMUQB8GKbtt6aPP+xOCwi
   aw2GCyjMxslXqF5FirN8i+7tQKeMuV2g+I/JN3mbU/CCI2H4ZnLDUP7DD
   MZQxJC7NYgsC7ow155tmfrzjN/dIaG2HpXYdCtM2IbiOe5Sx569HVg/sa
   SBBQN2AC9moA0ppeXAA00YhAx3Lb/3dtvRzKoSLSh9Y8lO5a1nnYhgux/
   g==;
IronPort-SDR: F/bsWOBVVHGr6C0ZAMKYljVjYYAKGYpvDT7vtZSjoZBgNxfSwo5xZeTWGCf6SJKxTGUlMLUc5B
 /ZINnUoNUNcG6HZv6D8Xfenq0eym6TpvVi8jVMno816dbFqZ3MVggJfduwx7wBEfGtI1id5gDw
 a8ETBhYt/HfIt94tNyRR2FzKagE+csm+4ZS7/+aXTIliI/iHq234ejplB4BcEMofwmBMbOyiLp
 cpb1SRaUlTrYEub8iXPjYjtwSBMt01PvKTjokyxahtrkzzYbvFz8ZyTqoGVDmK00WvHQVcjIub
 rlA=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564424"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:30 +0800
IronPort-SDR: Vb5k+BNGdFYwckMGgd3PdyOj5zsGNg1s3OMHWScAi4kWexQfcbuJOS0GmFTvnXbQJvkakjsD38
 RP3B2r2xFfV5XFx17SWiPlJe9BSqaajzOfaxCa0O3rq9+CiXZN5GbFilFZ2KEgUi8NN2R/T/90
 GKWzLYITDTKGBJlkN//Vuq/+UGlcRYa4rinHvTDxqGW3q4m2DbiMd00cvI+QVi+NWe1sT8UHOe
 6E+kDNDFUNM6EybA3GzQLFCHHrnJ57xbxDXTTSdTRVhQfz4DIES7AqX3qtWqJjtPRJoGUp5RuK
 atvX5ZpWqSeJZP0fwMDD6oPr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:21 -0800
IronPort-SDR: g1LXRXd+/vgJ9IQncw2auwsajYAcwYINfKzbezBRCv21wTeb+4TC2P+2Vj/iBQmxJBB45LBQj0
 l5q85yU7Y5IxQPC6YDL8wJ6s2yw5ifSfcS4uEur59uOiiZhSIq2KyjS/xOTtDFFGUpogNmVNgh
 W3bV8pgfvT6gMtYfw4feEgZ12ceRVUKYQTICyrggf4ECaNlz3vG2J6Tykawi01JX/qECgpllK1
 ENVmP1kUckKQArkTkryMA/cYdKiL102RvqWUbmmXG23V3tmB5HD6CuaF4lgqjvspuD7UGI8iIL
 0Dk=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:28 -0800
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
Subject: [PATCH 25/32] dt-bindings: Document kendryte,k210-rst bindings
Date:   Sat,  7 Nov 2020 17:14:13 +0900
Message-Id: <20201107081420.60325-26-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the device tree bindings for the Kendryte K210 SoC reset
controller driver in
Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 .../bindings/reset/kendryte,k210-rst.yaml     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml

diff --git a/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml b/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
new file mode 100644
index 000000000000..bdd0bf37bdfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/kendryte,k210-rst.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/kendryte,k210-rst.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kendryte K210 Reset Controller Device Tree Bindings
+
+maintainers:
+  - Damien Le Moal <damien.lemoal@wdc.com>
+
+description: |
+  Kendryte K210 reset controller driver which support the system controller
+  subsystem supplied reset registers for the various peripherals within
+  the SoC.
+
+  See also:
+  - dt-bindings/reset/k210-rst.h
+
+properties:
+  compatible:
+    allOf:
+      - items:
+        - const: kendryte,k210-rst
+        - const: syscon-reset
+
+  regmap:
+    maxItems: 1
+    description: phandle of the system controller (sysctl) node
+
+  offset:
+    maxItems: 1
+    description: peripheral reset register offset in the system controller
+      controller register map
+
+  mask:
+    maxItems: 1
+    description: bit-mask indicating valid reset bits in the reset register
+
+  assert-high:
+    maxItems: 1
+    description: bit value to write when asserting a reset
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - '#reset-cells'
+  - compatible
+  - regmap
+  - offset
+  - mask
+  - assert-high
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/mfd/k210-sysctl.h>
+    #include <dt-bindings/reset/k210-rst.h>
+
+    sysctl: system-controller@50440000 {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      compatible = "kendryte,k210-sysctl",
+                   "syscon", "simple-mfd";
+      reg = <0x50440000 0x1000>;
+      /* ... */
+      sysrst: reset-controller {
+        compatible = "kendryte,k210-rst",
+                      "syscon-reset";
+        #reset-cells = <1>;
+        regmap = <&sysctl>;
+        offset = <K210_SYSCTL_PERI_RESET>;
+        mask = <0x27FFFFFF>;
+        assert-high = <1>;
+      };
+    };
-- 
2.28.0

