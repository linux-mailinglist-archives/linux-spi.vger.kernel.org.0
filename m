Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2D2E2B2D
	for <lists+linux-spi@lfdr.de>; Fri, 25 Dec 2020 11:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgLYKgp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Dec 2020 05:36:45 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42928 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729222AbgLYKgp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Dec 2020 05:36:45 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKcmKwOVfqhwFAA--.6966S4;
        Fri, 25 Dec 2020 18:35:57 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A 
Date:   Fri, 25 Dec 2020 18:35:51 +0800
Message-Id: <1608892552-15457-3-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn>
References: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9AxKcmKwOVfqhwFAA--.6966S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW3WF1kCr4fKF1kJFWrKrg_yoW3trg_J3
        ZFy393WrWfJFyUZ397Zr4DCFW7urWku34rCF1kJr1DW3sYyrnxJFW8C3yDZ34UurWYvrZY
        qrZYgF4UCr4xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
        1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
        xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8twCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jcGYLUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

add spi support.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v2:
- Add spi about pci device DT

v3:
- Remove spiflash node

v4:
- Remove useless compatible

---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index f99a7a1..f4919c3 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -405,6 +405,16 @@
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 39 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
+			spi@16,0 {
+				compatible = "pci0014,7a0b.0",
+						"pci0014,7a0b",
+						"pciclass088000",
+						"pciclass0880";
+
+				reg = <0xb000 0x0 0x0 0x0 0x0>;
+				num-chipselects = <0>;
+			};
 		};
 
 		isa {
-- 
2.1.0

