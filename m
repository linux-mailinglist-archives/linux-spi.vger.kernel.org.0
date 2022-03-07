Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE54D016E
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 15:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiCGOfr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 09:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbiCGOfq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 09:35:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBB5A7D035;
        Mon,  7 Mar 2022 06:34:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B0D81042;
        Mon,  7 Mar 2022 06:34:51 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E1F73F66F;
        Mon,  7 Mar 2022 06:34:49 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH 11/14] ARM: dts: suniv: F1C100: add SPI support
Date:   Mon,  7 Mar 2022 14:34:18 +0000
Message-Id: <20220307143421.1106209-12-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307143421.1106209-1-andre.przywara@arm.com>
References: <20220307143421.1106209-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The F1C100 series contains two SPI controllers, and many boards use SPI0
for a SPI flash, as the BROM is able to boot from that.

Describe the two controllers in the SoC .dtsi, and also add the PortC
pins for SPI0, since this is where BROM looks at when trying to boot
from the commonly used SPI flash.

The SPI controller seems to be the same as in the H3 chips, but it lacks
a separate mod clock. The manual says it's connected to AHB directly.
We don't export that AHB clock directly, but can use the AHB *gate* clock
as a clock source, since the MMC driver is not supposed to change the AHB
frequency anyway.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 6f2f97458fe0..f8ec1c7a2ca9 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -105,6 +105,34 @@ mmc1: mmc@1c10000 {
 			#size-cells = <0>;
 		};
 
+		spi0: spi@1c05000 {
+			compatible = "allwinner,suniv-f1c100s-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c05000 0x1000>;
+			interrupts = <10>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_BUS_SPI0>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@1c06000 {
+			compatible = "allwinner,suniv-f1c100s-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x01c06000 0x1000>;
+			interrupts = <11>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_BUS_SPI1>;
+			clock-names = "ahb", "mod";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		ccu: clock@1c20000 {
 			compatible = "allwinner,suniv-f1c100s-ccu";
 			reg = <0x01c20000 0x400>;
@@ -138,6 +166,11 @@ mmc0_pins: mmc0-pins {
 				drive-strength = <30>;
 			};
 
+			spi0_pc_pins: spi0-pc-pins {
+				pins = "PC0", "PC1", "PC2", "PC3";
+				function = "spi0";
+			};
+
 			uart0_pe_pins: uart0-pe-pins {
 				pins = "PE0", "PE1";
 				function = "uart0";
-- 
2.25.1

