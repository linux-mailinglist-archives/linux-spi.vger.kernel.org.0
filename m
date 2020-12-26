Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD32E2DC4
	for <lists+linux-spi@lfdr.de>; Sat, 26 Dec 2020 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLZJMz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 26 Dec 2020 04:12:55 -0500
Received: from mail.loongson.cn ([114.242.206.163]:48856 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbgLZJMy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 26 Dec 2020 04:12:54 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axmclj_uZfGJQFAA--.14125S3;
        Sat, 26 Dec 2020 17:12:04 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] spi: ls7a: Add YAML schemas
Date:   Sat, 26 Dec 2020 17:12:01 +0800
Message-Id: <1608973923-8328-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1608973923-8328-1-git-send-email-zhangqing@loongson.cn>
References: <1608973923-8328-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9Axmclj_uZfGJQFAA--.14125S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF18CFyrJr4xGrW8KFyUWrg_yoW8XFWDpF
        17C3sxta1IgF1xC3yfta48A3W5Xr9Yk3ZxtFZrKwnrKas8Ka90vw43Kw15Z3W7JF48JFyx
        XFWkWr4rKF10yaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jrF4_UUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v4:
 - fix warnings/errors about running 'make dt_binding_check'

v5:
 - remove num-chipelects

---
 .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml

diff --git a/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
new file mode 100644
index 0000000..b90b28b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
@@ -0,0 +1,44 @@
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
+            compatible = "pci0014,7a0b.0",
+                             "pci0014,7a0b",
+                             "pciclass088000",
+                             "pciclass0800";
+
+            reg = <0xb000 0x0 0x0 0x0 0x0>;
+        };
+    };
+
+...
-- 
2.1.0

