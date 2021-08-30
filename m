Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3213FBF3C
	for <lists+linux-spi@lfdr.de>; Tue, 31 Aug 2021 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbhH3XD1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Aug 2021 19:03:27 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:60475 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbhH3XDZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Aug 2021 19:03:25 -0400
Received: (Authenticated sender: contact@artur-rojek.eu)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D9EA0200002;
        Mon, 30 Aug 2021 23:02:27 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Pavel Nadein <pavelnadein@gmail.com>
Cc:     Pavel Nadein <pasha-net@narod.ru>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>
Subject: [5.16][PATCH 3/3] MIPS: JZ4780: CI20: DTS: add SPI controller config
Date:   Tue, 31 Aug 2021 01:01:39 +0200
Message-Id: <20210830230139.21476-4-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830230139.21476-1-contact@artur-rojek.eu>
References: <20210830230139.21476-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

1. Add nodes for the two SPI controllers found in MIPS Creator CI20.
2. Reparent SPI clock source to effectively use MPLL and set its clock
   rate to 54MHz.

NOTE: To use the SPI controllers, `pinctrl-0` property must be set in
order to configure the used pins. As SPI functionality is multiplexed on
multiple pin groups, this choice is left to the user.

An example configuration:
```
 &spi0 {
         pinctrl-0 = <&pins_spi0>;
 }

 pins_spi0: spi0 {
         function = "ssi0";
         groups = "ssi0-dt-e", "ssi0-dr-e", "ssi0-clk-e",
                  "ssi0-ce0-e", "ssi0-ce1-e";
         bias-disable;
 };
```
Consult the CI20 pinout description for more details.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/mips/boot/dts/ingenic/ci20.dts    |  9 ++++--
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 44 +++++++++++++++++++-------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index a688809beebc..b249a4f0f6b6 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -113,9 +113,12 @@ &cgu {
 	 * Use the 32.768 kHz oscillator as the parent of the RTC for a higher
 	 * precision.
 	 */
-	assigned-clocks = <&cgu JZ4780_CLK_OTGPHY>, <&cgu JZ4780_CLK_RTC>;
-	assigned-clock-parents = <0>, <&cgu JZ4780_CLK_RTCLK>;
-	assigned-clock-rates = <48000000>;
+	assigned-clocks = <&cgu JZ4780_CLK_OTGPHY>, <&cgu JZ4780_CLK_RTC>,
+			  <&cgu JZ4780_CLK_SSIPLL>, <&cgu JZ4780_CLK_SSI>;
+	assigned-clock-parents = <0>, <&cgu JZ4780_CLK_RTCLK>,
+				 <&cgu JZ4780_CLK_MPLL>,
+				 <&cgu JZ4780_CLK_SSIPLL>;
+	assigned-clock-rates = <48000000>, <0>, <54000000>;
 };
 
 &tcu {
diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9e34f433b9b5..28adc3d93975 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -255,22 +255,23 @@ gpf: gpio@5 {
 		};
 	};
 
-	spi_gpio {
-		compatible = "spi-gpio";
+	spi0: spi@10043000 {
+		compatible = "ingenic,jz4780-spi";
+		reg = <0x10043000 0x1c>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		num-chipselects = <2>;
 
-		gpio-miso = <&gpe 14 0>;
-		gpio-sck = <&gpe 15 0>;
-		gpio-mosi = <&gpe 17 0>;
-		cs-gpios = <&gpe 16 0>, <&gpe 18 0>;
+		interrupt-parent = <&intc>;
+		interrupts = <8>;
 
-		spidev@0 {
-			compatible = "spidev";
-			reg = <0>;
-			spi-max-frequency = <1000000>;
-		};
+		clocks = <&cgu JZ4780_CLK_SSI0>;
+		clock-names = "spi";
+
+		dmas = <&dma JZ4780_DMA_SSI0_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_SSI0_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		status = "disabled";
 	};
 
 	uart0: serial@10030000 {
@@ -338,6 +339,25 @@ uart4: serial@10034000 {
 		status = "disabled";
 	};
 
+	spi1: spi@10044000 {
+		compatible = "ingenic,jz4780-spi";
+		reg = <0x10044000 0x1c>;
+		#address-cells = <1>;
+		#size-sells = <0>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <7>;
+
+		clocks = <&cgu JZ4780_CLK_SSI1>;
+		clock-names = "spi";
+
+		dmas = <&dma JZ4780_DMA_SSI1_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_SSI1_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		status = "disabled";
+	};
+
 	i2c0: i2c@10050000 {
 		compatible = "ingenic,jz4780-i2c", "ingenic,jz4770-i2c";
 		#address-cells = <1>;
-- 
2.33.0

