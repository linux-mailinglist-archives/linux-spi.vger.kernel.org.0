Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCC43BE54F
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhGGJLi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 05:11:38 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:49528 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhGGJLg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 05:11:36 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4F0B2D59F8;
        Wed,  7 Jul 2021 17:08:54 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13447T140124675356416S1625648924230018_;
        Wed, 07 Jul 2021 17:08:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <705ec8e680924bc24dfb9d71f78d08af>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: linux-spi@vger.kernel.org
X-RCPT-COUNT: 20
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
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC PATCH v11 09/10] arm64: dts: rockchip: Add SFC to RK3308
Date:   Wed,  7 Jul 2021 17:08:42 +0800
Message-Id: <20210707090843.5959-5-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707090843.5959-1-jon.lin@rock-chips.com>
References: <20210707090810.5717-1-jon.lin@rock-chips.com>
 <20210707090843.5959-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add a devicetree entry for the Rockchip SFC for the RK3308 SOC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 0c5fa9801e6f..cb8d96235986 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -637,6 +637,17 @@
 		status = "disabled";
 	};
 
+	sfc: spi@ff4c0000 {
+		compatible = "rockchip,sfc";
+		reg = <0x0 0xff4c0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus4>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
@@ -910,6 +921,32 @@
 			};
 		};
 
+		sfc {
+			sfc_bus4: sfc-bus4 {
+				rockchip,pins =
+					<3 RK_PA0 3 &pcfg_pull_none>,
+					<3 RK_PA1 3 &pcfg_pull_none>,
+					<3 RK_PA2 3 &pcfg_pull_none>,
+					<3 RK_PA3 3 &pcfg_pull_none>;
+			};
+
+			sfc_bus2: sfc-bus2 {
+				rockchip,pins =
+					<3 RK_PA0 3 &pcfg_pull_none>,
+					<3 RK_PA1 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs0: sfc-cs0 {
+				rockchip,pins =
+					<3 RK_PA4 3 &pcfg_pull_none>;
+			};
+
+			sfc_clk: sfc-clk {
+				rockchip,pins =
+					<3 RK_PA5 3 &pcfg_pull_none>;
+			};
+		};
+
 		gmac {
 			rmii_pins: rmii-pins {
 				rockchip,pins =
-- 
2.17.1



