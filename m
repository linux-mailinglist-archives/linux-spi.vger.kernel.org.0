Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCF2D24D2
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 08:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgLHHp0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 02:45:26 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42932 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726601AbgLHHpZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 02:45:25 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_3_hLs9fTZ8aAA--.48083S3;
        Tue, 08 Dec 2020 15:44:34 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
Subject: [PATCH v2 2/4] spi: Add devicetree bindings documentation for Loongson SPI
Date:   Tue,  8 Dec 2020 15:44:25 +0800
Message-Id: <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9Dx_3_hLs9fTZ8aAA--.48083S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWktry3Ar4fZryUZryrWFg_yoW8GFWxpF
        4jkF4rJFs5JF1xCw4Sqa4Iy3W3JF4kua1rGFsrtr18tr95K3Z0vw15Kr15Zr98XF48ZFWI
        qFZ7CF1rKF12vaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0JUoSoXUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add spi-ls7a binding documentation.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 Documentation/devicetree/bindings/spi/spi-ls7a.txt | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-ls7a.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-ls7a.txt b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
new file mode 100644
index 0000000..56247b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
@@ -0,0 +1,31 @@
+Binding for LOONGSON LS7A SPI controller
+
+Required properties:
+- compatible: should be "pci0014,7a0b.0","pci0014,7a0b","pciclass088000","pciclass0880".
+- reg: reference IEEE Std 1275-1994.
+- #address-cells: <1>, as required by generic SPI binding.
+- #size-cells: <0>, also as required by generic SPI binding.
+- #interrupts: No hardware interrupt.
+
+Child nodes as per the generic SPI binding.
+
+Example:
+
+			spi@16,0 {
+				compatible = "pci0014,7a0b.0",
+						"pci0014,7a0b",
+						"pciclass088000",
+						"pciclass0880";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0xb000 0x0 0x0 0x0 0x0>;
+				num-chipselects = <0>;
+				spiflash: s25fl016k@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible ="spansion,s25fl016k","jedec,spi-nor";
+				spi-max-frequency=<50000000>;
+				reg=<0>;
+				};
+			};
-- 
2.1.0

