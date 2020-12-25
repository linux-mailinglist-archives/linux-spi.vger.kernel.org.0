Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B722E2B34
	for <lists+linux-spi@lfdr.de>; Fri, 25 Dec 2020 11:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgLYKgr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Dec 2020 05:36:47 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42924 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728667AbgLYKgq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Dec 2020 05:36:46 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKcmKwOVfqhwFAA--.6966S3;
        Fri, 25 Dec 2020 18:35:56 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] spi: ls7a: Add YAML schemas
Date:   Fri, 25 Dec 2020 18:35:50 +0800
Message-Id: <1608892552-15457-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn>
References: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9AxKcmKwOVfqhwFAA--.6966S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF15Cw13CFWxKF4DJF43KFg_yoW8Xw48pF
        17C3sxta1IgF1xCw4fta48C3W5Xr9Yk3ZxtFZrtw1UKas8Ka90vw43Kw15Z3W7JF48JFy7
        XFWkWr4rKF10yaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE
        c7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
        8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCF
        s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2aDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v4: fix warnings/errors about running 'make dt_binding_check'

---
 .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml

diff --git a/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
new file mode 100644
index 0000000..8cc9bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/loongson,spi-ls7a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson LS7A PCH SPI Controller
+
+maintainers:
+  - Qing Zhang <zhangqing@loongson.cn>
+
+description: |
+  This controller can be found in Loongson-3 systems with LS7A PCH.
+
+properties:
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
+additionalProperties: false
+
+examples:
+  - |
+    pci {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        spi@16,0 {
+        compatible = "pci0014,7a0b.0",
+                        "pci0014,7a0b",
+                        "pciclass088000",
+                        "pciclass0800";
+
+        reg = <0xb000 0x0 0x0 0x0 0x0>;
+        num-chipselects = <0>;
+        };
+    };
+
+...
-- 
2.1.0

