Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE62D9324
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 07:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbgLNF74 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 00:59:56 -0500
Received: from mail.loongson.cn ([114.242.206.163]:43406 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388047AbgLNF74 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Dec 2020 00:59:56 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_38l_9ZfFUodAA--.52092S3;
        Mon, 14 Dec 2020 13:59:02 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] spi: ls7a: Add YAML schemas
Date:   Mon, 14 Dec 2020 13:58:52 +0800
Message-Id: <1607925534-8312-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
References: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9Dx_38l_9ZfFUodAA--.52092S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1rCr4rtF4kWw4fXFyrWFg_yoW8Xw4xpF
        17C343ta1IgF1xCw43Ka4kC3W5XF95C3Z5JFZrtw1Ut3s8Ka90vw4akr15Z3W3JF48Ja4x
        XFZ7Kr4rKF18JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GrWl42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIna9UUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml

diff --git a/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
new file mode 100644
index 0000000..41691c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-ls7a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson LS7A PCH SPI Controller
+
+all0f:
+   - $ref: "spi-controller.yaml#"
+
+maintainers:
+  - Qing Zhang <zhangqing@loongson.cn>
+
+description: |
+  This controller can be found in Loongson-3 systems with LS7A PCH.
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    const: loongson,ls7a-spi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - num-chipselects
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@16,0 {
+        compatible = "pci0014,7a0b.0",
+                        "pci0014,7a0b",
+                        "pciclass088000",
+                        "pciclass0800";
+
+        reg = <0xb000 0x0 0x0 0x0 0x0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-chipselects = <0>;
+    };
+
+...
-- 
2.1.0

