Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7932D932A
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 07:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392058AbgLNGAC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 01:00:02 -0500
Received: from mail.loongson.cn ([114.242.206.163]:43412 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388417AbgLNGAB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Dec 2020 01:00:01 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_38l_9ZfFUodAA--.52092S4;
        Mon, 14 Dec 2020 13:59:04 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A
Date:   Mon, 14 Dec 2020 13:58:53 +0800
Message-Id: <1607925534-8312-3-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
References: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9Dx_38l_9ZfFUodAA--.52092S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWDWF1rKFyDKw48Gry8Krg_yoW3KFb_J3
        ZrKws3GrWrJF9ru3ykZr4DCFW7u3ykua4rC3WkJr1DW3sYyrnxJFW8C3yDZ34UurWYvrZY
        qrs5WF4kCw1xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbS8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8WwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jf8n5UUUUU=
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

---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index f99a7a1..d91857c 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -405,6 +405,18 @@
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
+				#address-cells = <1>;
+				#size-cells = <0>;
+				num-chipselects = <0>;
+			};
 		};
 
 		isa {
-- 
2.1.0

