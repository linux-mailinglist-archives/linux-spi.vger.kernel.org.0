Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79742E33CA
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 04:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgL1DAd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Dec 2020 22:00:33 -0500
Received: from mail.loongson.cn ([114.242.206.163]:38128 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgL1DAd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 27 Dec 2020 22:00:33 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxHzYdSulfznIGAA--.9S3;
        Mon, 28 Dec 2020 10:59:43 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, yangtiezhu@loongson.cn,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] spi: ls7a: Add YAML schemas
Date:   Mon, 28 Dec 2020 10:59:39 +0800
Message-Id: <1609124381-9107-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1609124381-9107-1-git-send-email-zhangqing@loongson.cn>
References: <1609124381-9107-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9DxHzYdSulfznIGAA--.9S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rWw13tFy3Xr47tr1kZrb_yoW8WrW3pF
        47C3sxta1IgF1xC393ta48C3W5Xr95C3W3tFZrtw17Kas8Ka90vw43Kwn8Z3W7JF48AFyx
        XFZ2gr4rKF10yw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JU3hL5UUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v4:
- fix warnings/errors about running 'make dt_binding_check'

v5:
- remove num-chipelects

v6:
- No changes

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

