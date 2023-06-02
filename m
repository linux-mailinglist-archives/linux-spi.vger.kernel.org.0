Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FEF71FC8E
	for <lists+linux-spi@lfdr.de>; Fri,  2 Jun 2023 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjFBIuX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 2 Jun 2023 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjFBItv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Jun 2023 04:49:51 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EBE1AE;
        Fri,  2 Jun 2023 01:49:49 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 74D7380C1;
        Fri,  2 Jun 2023 16:49:48 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 2 Jun
 2023 16:49:48 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 2 Jun 2023 16:49:28 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v2 3/3] riscv: dts: starfive: Add QSPI controller node for StarFive JH7110 SoC
Date:   Fri, 2 Jun 2023 16:49:25 +0800
Message-ID: <20230602084925.215411-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602084925.215411-1-william.qiu@starfivetech.com>
References: <20230602084925.215411-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the quad spi controller node for the StarFive JH7110 SoC.

Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 32 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 18 +++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 2a6d81609284..22212c1150f9 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -126,6 +126,38 @@ &i2c6 {
 	status = "okay";
 };
 
+&qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	nor_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg=<0>;
+		cdns,read-delay = <5>;
+		spi-max-frequency = <12000000>;
+		cdns,tshsl-ns = <1>;
+		cdns,tsd2d-ns = <1>;
+		cdns,tchsh-ns = <1>;
+		cdns,tslch-ns = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			spl@0 {
+				reg = <0x0 0x20000>;
+			};
+			uboot@100000 {
+				reg = <0x100000 0x300000>;
+			};
+			data@f00000 {
+				reg = <0xf00000 0x100000>;
+			};
+		};
+	};
+};
+
 &sysgpio {
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4c5fdb905da8..e1a51e57a851 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -440,6 +440,24 @@ i2c6: i2c@12060000 {
 			status = "disabled";
 		};
 
+		qspi: spi@13010000 {
+			compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
+			reg = <0x0 0x13010000 0x0 0x10000
+				0x0 0x21000000 0x0 0x400000>;
+			interrupts = <25>;
+			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>,
+				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
+				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
+			clock-names = "ref_clk", "hclk", "pclk";
+			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
+				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
+				 <&syscrg JH7110_SYSRST_QSPI_REF>;
+			reset-names = "qspi", "qspi-ocp", "rstc_ref";
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+		};
+
 		syscrg: clock-controller@13020000 {
 			compatible = "starfive,jh7110-syscrg";
 			reg = <0x0 0x13020000 0x0 0x10000>;
-- 
2.34.1

