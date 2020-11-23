Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260F12C0227
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKWJTZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 04:19:25 -0500
Received: from mail.loongson.cn ([114.242.206.163]:34758 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgKWJTZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 04:19:25 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD9OMfrtfB3wVAA--.43428S3;
        Mon, 23 Nov 2020 17:19:10 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] MIPS: Loongson64: DTS: Add SPI support to LS3A
Date:   Mon, 23 Nov 2020 17:19:07 +0800
Message-Id: <1606123148-315-2-git-send-email-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1606123148-315-1-git-send-email-zhangqing@loongson.cn>
References: <1606123148-315-1-git-send-email-zhangqing@loongson.cn>
X-CM-TRANSID: AQAAf9DxD9OMfrtfB3wVAA--.43428S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF43KFW5XrWrXr1fCrW8Crg_yoW3XFg_t3
        W2kF4kGFWfJF47J3y8Zw1UJry7u34ru3Z8CF1DWr4jgasavrsxJFWUAa9rJ3ZrurWjvFnY
        gw4rWF18Ars2kjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbkAYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
        1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x0262
        8vn2kIc2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
        Ja73UjIFyTuYvjxUaw0eDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The LS3A SPI module is now supported, enable it.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/mips/boot/dts/loongson/loongson64c-package.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/loongson64c-package.dtsi b/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
index 5bb876a..2025c5a 100644
--- a/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
@@ -60,5 +60,12 @@
 			interrupt-parent = <&liointc>;
 			no-loopback-test;
 		};
+
+                spi: spi@1fe00220 {
+                        compatible = "loongson,loongson-spi";
+                        reg=<0 0x1fe00220 0x11>;
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+               };
 	};
 };
-- 
2.1.0

