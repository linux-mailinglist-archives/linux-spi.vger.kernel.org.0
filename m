Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8146D39EBFE
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jun 2021 04:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhFHC31 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Jun 2021 22:29:27 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:60136 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhFHC30 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Jun 2021 22:29:26 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id D4DF7F4B1B;
        Tue,  8 Jun 2021 10:26:57 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31748T140095290545920S1623119206974105_;
        Tue, 08 Jun 2021 10:26:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dd4a2cd6961df4e90ca9b904b05c5cf6>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-spi@vger.kernel.org
X-RCPT-COUNT: 17
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     linux-spi@vger.kernel.org
Cc:     jon.lin@rock-chips.com, broonie@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, jbx6244@gmail.com, hjc@rock-chips.com,
        yifeng.zhao@rock-chips.com, sugar.zhang@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        p.yadav@ti.com, macroalpha82@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v6 3/8] arm64: dts: rockchip: Add SFC to PX30
Date:   Tue,  8 Jun 2021 10:26:39 +0800
Message-Id: <20210608022644.21074-4-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608022644.21074-1-jon.lin@rock-chips.com>
References: <20210608022644.21074-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add a devicetree entry for the Rockchip SFC for the PX30 SOC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 arch/arm64/boot/dts/rockchip/px30.dtsi | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 09baa8a167ce..99a46259e428 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -966,6 +966,18 @@
 		status = "disabled";
 	};
 
+	sfc: spi@ff3a0000 {
+		compatible = "rockchip,px30-sfc","rockchip,rk3036-sfc";
+		reg = <0x0 0xff3a0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SFC>, <&cru SCLK_SFC>;
+		clock-names = "hclk_sfc", "clk_sfc";
+		pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus4>;
+		pinctrl-names = "default";
+		power-domains = <&power PX30_PD_MMC_NAND>;
+		status = "disabled";
+	};
+
 	nfc: nand-controller@ff3b0000 {
 		compatible = "rockchip,px30-nfc";
 		reg = <0x0 0xff3b0000 0x0 0x4000>;
@@ -1967,6 +1979,32 @@
 			};
 		};
 
+		serial_flash {
+			sfc_bus4: sfc-bus4 {
+				rockchip,pins =
+					<1 RK_PA0 3 &pcfg_pull_none>,
+					<1 RK_PA1 3 &pcfg_pull_none>,
+					<1 RK_PA2 3 &pcfg_pull_none>,
+					<1 RK_PA3 3 &pcfg_pull_none>;
+			};
+
+			sfc_bus2: sfc-bus2 {
+				rockchip,pins =
+					<1 RK_PA0 3 &pcfg_pull_none>,
+					<1 RK_PA1 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs0: sfc-cs0 {
+				rockchip,pins =
+					<1 RK_PA4 3 &pcfg_pull_none>;
+			};
+
+			sfc_clk: sfc-clk {
+				rockchip,pins =
+					<1 RK_PB1 3 &pcfg_pull_none>;
+			};
+		};
+
 		lcdc {
 			lcdc_rgb_dclk_pin: lcdc-rgb-dclk-pin {
 				rockchip,pins =
-- 
2.17.1



