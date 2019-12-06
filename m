Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22B11151D6
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFODV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 09:03:21 -0500
Received: from pbmsgap02.intersil.com ([192.157.179.202]:49438 "EHLO
        pbmsgap02.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfLFODU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 09:03:20 -0500
Received: from pps.filterd (pbmsgap02.intersil.com [127.0.0.1])
        by pbmsgap02.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB6Dgi2p000754;
        Fri, 6 Dec 2019 08:42:56 -0500
Received: from pbmxdp01.intersil.corp (pbmxdp01.pb.intersil.com [132.158.200.222])
        by pbmsgap02.intersil.com with ESMTP id 2wkkffmn5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Dec 2019 08:42:56 -0500
Received: from pbmxdp02.intersil.corp (132.158.200.223) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Fri, 6 Dec 2019 08:42:55 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp02.intersil.corp (132.158.200.223) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 6 Dec 2019 08:42:53 -0500
From:   Chris Brandt <chris.brandt@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Date:   Fri, 6 Dec 2019 08:41:58 -0500
Message-ID: <20191206134202.18784-3-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206134202.18784-1-chris.brandt@renesas.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912060118
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the bindings used by the Renesas SPI bus space controller.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
 * change to YAML format
 * add interrupts property
 * Used more terms directly from the hardware manual
---
 .../bindings/spi/renesas,spibsc.yaml          | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,spibsc.yaml

diff --git a/Documentation/devicetree/bindings/spi/renesas,spibsc.yaml b/Documentation/devicetree/bindings/spi/renesas,spibsc.yaml
new file mode 100644
index 000000000000..afbdc0824cc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/renesas,spibsc.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/renesas,spibsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SPI Bus Space Controller (SPIBSC) Device Tree Bindings
+
+description: |
+  Otherwise referred to as the "SPI Multi I/O Bus Controller" in SoC hardware
+  manuals. This controller was designed specifically for accessing Serial flash
+  devices such as SPI Flash, HyperFlash and OctaFlash. The HW can operate in two
+  modes. One mode allows for normal byte by byte access (refereed to as
+  "Manual Mode"). The other mode allows for direct memory mapped access (read
+  only) to the flash area by the CPU (refereed to as "External Address Space
+  Read Mode").
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+maintainers:
+  - Chris Brandt <chris.brandt@renesas.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r7s72100-spibsc     # RZ/A1
+              - renesas,r7s9210-spibsc      # RZ/A2
+
+  reg:
+    minItems: 2
+    maxItems: 2
+    items:
+      - description: Registers
+      - description: Memory Mapped Address Space
+
+  interrupts:
+    description: Some HW versions do not contain interrupts
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  flash:
+    description: |
+      (Optional) In order to use the HW for R/W access ("Manual Mode"), a "flash"
+      subnode must be present with a "compatible" property that contains
+      "jedec,spi-nor". If a spi-nor property is not found, the HW is assumed to be
+      already operating in "External Address Space Read Mode".
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    # This example is for "Manual Mode"
+    spibsc: spi@1f800000 {
+        compatible = "renesas,r7s9210-spibsc";
+        reg = <0x1f800000 0x100>, <0x20000000 0x10000000>;
+        clocks = <&cpg CPG_MOD 83>;
+        power-domains = <&cpg>;
+        interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <40000000>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0000000 {
+                    label = "u-boot";
+                    reg = <0x00000000 0x80000>;
+                };
+            };
+        };
+
+    # This example is for "External Address Space Read Mode"
+    spibsc: spi@1f800000 {
+        compatible = "renesas,r7s9210-spibsc";
+        reg = <0x1f800000 0x100>, <0x20000000 0x10000000>;
+        clocks = <&cpg CPG_MOD 83>;
+        power-domains = <&cpg>;
+        interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+    flash@20000000 {
+        compatible = "mtd-rom";
+        probe-type = "direct-mapped";
+        reg = <0x20000000 0x4000000>;
+        bank-width = <4>;
+        device-width = <1>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@80000 {
+            label ="uboot_env";
+            reg = <0x00080000 0x010000>;
+            read-only;
+        };
+    };
+
+...
-- 
2.23.0

