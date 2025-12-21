Return-Path: <linux-spi+bounces-12067-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B5CD3F16
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 12:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8829300E00E
	for <lists+linux-spi@lfdr.de>; Sun, 21 Dec 2025 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329A428F50F;
	Sun, 21 Dec 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMDfzdUM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011AB1FECBA;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766315120; cv=none; b=YeD8TOebI/MPgnIwZTebYoTe4tZHJBQAYQr1iKuxCLm8wifi1FqA0ek2rRmTjmry6jbFnfdoEM8sl/HthfFvaKVs95iSDUk2i4kkwfPLZ+8rI1fe+IiDrfqgAzW5VmJzOpUkT173T+T0SJ+t26bzQiA/fK4O2X7DFk/4lWLH9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766315120; c=relaxed/simple;
	bh=joZzWHXLoIhSZSiC6PmIQjU/PLkF4PjJcggDkdZtN40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drAy+YwJeUTTMx4y5TMMoD2GX/A2+rjFIHIsJ7rfzrdS9wO0IlEpMnyERYODtQpSWSJlctUgle1BcqRzTstfL8hY13peINLyq+i4LT+UpfXiAqYhl+dOvcmkIC1yPq4a3pP2DvtKR3bKP4O3rqFBnJItambKjsH28HBToXrRHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMDfzdUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7923DC4AF09;
	Sun, 21 Dec 2025 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766315119;
	bh=joZzWHXLoIhSZSiC6PmIQjU/PLkF4PjJcggDkdZtN40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMDfzdUMDd8YZFaRd6nmWU7dO9ubP94Fa17VDRxyQXqErYCpZ1Gg8tYHRsuW78KqP
	 Zr7feOzSgZw55W++OE67S2M0W7sjy+GxWn7gthlSXGrTLQrRIfKPtOsu5ZFOLhvNz1
	 Pzgx07Mjf2Mcchs2iTg+8sQKGw/8AYC04XqyFu4iLdkKr9R19anbE9K6LLiJngO0YC
	 T0pBTC80+OSO81tlvZeWCnChl9eO08P6W1WdPvHW333s8v7xrdM5cCsKlEPzYARb7v
	 vJ+OD3OVJ5GBCqKxDo3Vr2/hl6+G39HtmkBzP3QLB9gNNURGnLJDm7erzfRb26PW9I
	 ZE6aOVybSofVQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 5273E5FE35; Sun, 21 Dec 2025 19:05:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: allwinner: sun55i: Add SPI controllers
Date: Sun, 21 Dec 2025 19:05:10 +0800
Message-ID: <20251221110513.1850535-4-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221110513.1850535-1-wens@kernel.org>
References: <20251221110513.1850535-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A523 family SoCs have four SPI controllers. One of them also
supports DBI mode.

Add device nodes for all of them. Also add pinmux nodes for spi0 on the
PC pins, which is commonly used for SPI-NOR boot flash.

Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 42dab01e3f56..9335977751e2 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -214,6 +214,43 @@ spdif_out_pi_pin: spdif-pi-pin {
 				allwinner,pinmux = <2>;
 			};
 
+			/omit-if-no-ref/
+			spi0_pc_pins: spi0-pc-pins {
+				pins = "PC2", "PC4", "PC12";
+				function = "spi0";
+				allwinner,pinmux = <4>;
+			};
+
+			/omit-if-no-ref/
+			spi0_cs0_pc_pin: spi0-cs0-pc-pin {
+				pins = "PC3";
+				function = "spi0";
+				allwinner,pinmux = <4>;
+			};
+
+			/omit-if-no-ref/
+			spi0_cs1_pc_pin: spi0-cs1-pc-pin {
+				pins = "PC7";
+				function = "spi0";
+				allwinner,pinmux = <4>;
+			};
+
+			/omit-if-no-ref/
+			spi0_hold_pc_pin: spi0-hold-pc-pin {
+				/* conflicts with eMMC D7 */
+				pins = "PC16";
+				function = "spi0";
+				allwinner,pinmux = <4>;
+			};
+
+			/omit-if-no-ref/
+			spi0_wp_pc_pin: spi0-wp-pc-pin {
+				/* conflicts with eMMC D2 */
+				pins = "PC15";
+				function = "spi0";
+				allwinner,pinmux = <4>;
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				allwinner,pinmux = <2>;
@@ -563,6 +600,49 @@ mmc2: mmc@4022000 {
 			#size-cells = <0>;
 		};
 
+		spi0: spi@4025000 {
+			compatible = "allwinner,sun55i-a523-spi";
+			reg = <0x04025000 0x1000>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
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
+		spi1: spi@4026000 {
+			compatible = "allwinner,sun55i-a523-spi-dbi",
+				     "allwinner,sun55i-a523-spi";
+			reg = <0x04026000 0x1000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
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
+		spi2: spi@4027000 {
+			compatible = "allwinner,sun55i-a523-spi";
+			reg = <0x04027000 0x1000>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI2>, <&ccu CLK_SPI2>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 24>, <&dma 24>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		usb_otg: usb@4100000 {
 			compatible = "allwinner,sun55i-a523-musb",
 				     "allwinner,sun8i-a33-musb";
@@ -815,6 +895,20 @@ rtc: rtc@7090000 {
 			#clock-cells = <1>;
 		};
 
+		r_spi0: spi@7092000 {
+			compatible = "allwinner,sun55i-a523-spi";
+			reg = <0x07092000 0x1000>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_BUS_R_SPI>, <&r_ccu CLK_R_SPI>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 53>, <&dma 53>;
+			dma-names = "rx", "tx";
+			resets = <&r_ccu RST_BUS_R_SPI>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		mcu_ccu: clock-controller@7102000 {
 			compatible = "allwinner,sun55i-a523-mcu-ccu";
 			reg = <0x7102000 0x200>;
-- 
2.47.3


