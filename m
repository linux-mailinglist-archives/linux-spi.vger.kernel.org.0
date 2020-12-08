Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E85F2D24D6
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 08:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgLHHp1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 02:45:27 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42938 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727391AbgLHHp0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 8 Dec 2020 02:45:26 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_3_hLs9fTZ8aAA--.48083S4;
        Tue, 08 Dec 2020 15:44:35 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
Subject: [PATCH v2 3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A
Date:   Tue,  8 Dec 2020 15:44:26 +0800
Message-Id: <1607413467-17698-3-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9Dx_3_hLs9fTZ8aAA--.48083S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFWfCFW3Wr43tr43Gr15Arb_yoWDArcEy3
        ZFgrW3GrWrJF9rCayDZw4DCFy7u3y8CayrA3WkJr1DW3yvyrnxJFWkJrWDJ3WUurWYyrs5
        KF4rXF4kAw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbykFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
        v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IY
        x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI
        43ZEXa7VUbco7tUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

add spi and amd node support.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---

v2:
- Add spi about pci device DT
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index f99a7a1..ab8836b 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -405,6 +405,26 @@
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
+				#address-cells = <1>;
+				#size-cells = <0>;
+
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
 		};
 
 		isa {
-- 
2.1.0

