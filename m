Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7288913D152
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 01:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgAPA5O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 19:57:14 -0500
Received: from foss.arm.com ([217.140.110.172]:43790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgAPA5O (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 15 Jan 2020 19:57:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFF761007;
        Wed, 15 Jan 2020 16:57:13 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E8113F718;
        Wed, 15 Jan 2020 16:57:12 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: sun50i: H6: Add SPI controllers nodes and pinmuxes
Date:   Thu, 16 Jan 2020 00:56:52 +0000
Message-Id: <20200116005654.27672-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20200116005654.27672-1-andre.przywara@arm.com>
References: <20200116005654.27672-1-andre.przywara@arm.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Allwinner H6 SoC contains two SPI controllers similar to the H3/A64,
but with the added capability of 3-wire and 4-wire operation modes.
For now the driver does not support those, but the SPI registers are
fully backwards-compatible, just adding bits and registers which were
formerly reserved. So we can use the existing driver in "legacy" SPI
modes, for instance to access the SPI NOR flash soldered on the PineH64
board.
We use an H6 specific compatible string in addition to the existing H3
string, so when the driver later gains QSPI support, it should work
automatically without any DT changes.

Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
connecting another SPI flash to the SPI1 header pins.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 55 ++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3329283e38ab..41b58ffa8596 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -338,6 +338,31 @@
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
+			spi0_pins: spi0-pins {
+				pins = "PC0", "PC2", "PC3";
+				function = "spi0";
+			};
+
+			/* pin shared with MMC2-CMD (eMMC) */
+			/omit-if-no-ref/
+			spi0_cs_pin: spi0-cs-pin {
+				pins = "PC5";
+				function = "spi0";
+			};
+
+			/omit-if-no-ref/
+			spi1_pins: spi1-pins {
+				pins = "PH4", "PH5", "PH6";
+				function = "spi1";
+			};
+
+			/omit-if-no-ref/
+			spi1_cs_pin: spi1-cs-pin {
+				pins = "PH3";
+				function = "spi1";
+			};
+
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PH7";
 				function = "spdif";
@@ -504,6 +529,36 @@
 			#size-cells = <0>;
 		};
 
+		spi0: spi@5010000 {
+			compatible = "allwinner,sun50i-h6-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x05010000 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@5011000 {
+			compatible = "allwinner,sun50i-h6-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x05011000 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		emac: ethernet@5020000 {
 			compatible = "allwinner,sun50i-h6-emac",
 				     "allwinner,sun50i-a64-emac";
-- 
2.14.5

