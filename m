Return-Path: <linux-spi+bounces-5931-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061819E7978
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5AA18838FA
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2866A206276;
	Fri,  6 Dec 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zsmdq+UU"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FED1FFC6D;
	Fri,  6 Dec 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515278; cv=none; b=gQRnXyHGEVGcKUAblPrGP4BvS8MLALVsuMP47+t2ibKeGpMldV2N48DFmOTn9J5Y8gWOf37SMKQcLEUmAzG9OO+uN378OyIgnkgsyKR+5Hpq9pEO3pMOMgQ3DgIuRmf18L3kHQKlpGjT+xOpD22MJ/EqwLpBTrDhYvTdAGWmP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515278; c=relaxed/simple;
	bh=KNQoFP05xOPexS8j/GoRwMlR4e/mNFKxzyI0QPzhAfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlhhAnLzlGMyTrzYEZux5ZHoX6OSaSNxvz/EMGgnBWF/IyhUfZ5WRRoZIFxe4r3bRs4w7NjxSxLaTM1hr/RbXGJkpDxHFGynYs5lXHG2se+7e0wESzbeDJcsbwj1JrYlc8UqUZetu/kYb4gwT8lYiydgErhb2k3aehZs1hOeduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zsmdq+UU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515276; x=1765051276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KNQoFP05xOPexS8j/GoRwMlR4e/mNFKxzyI0QPzhAfo=;
  b=zsmdq+UUQUoAiZLcC7blGWsQ2MzyQO5WEhUwX6bgdlcD4SmzCHHDvoUM
   IQrlQoxeWmbSfaKL5jghYlYELQUA3ROz+WytbWJO78AZT2sxGdTYCxmGp
   O9Cf+R5hz5PX0vQySa823rPJHUu0010QetO66T6h0DoPj9etjYpbJ9FZA
   H/tj6ahNOCYXBWv5U697BzrHTK8nk7QfbAWD6N69aMTkx4Z3d4XyRlWbw
   BFznq+xkyP3HnNAC2RMoTJtUdd4GGx5OgVMlaGfepuoOR4nUvpN0UtzLu
   oM0rfiVtTv8tFsDSRenswh6gylwLRqkTyEktQMh1sK3fTr63K+t8GSnUl
   Q==;
X-CSE-ConnectionGUID: 9plLhrxgQXuYZUyQ8wJyMg==
X-CSE-MsgGUID: YO0nKaSFT2+c+g7XFsmctw==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34926408"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:10 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Dec 2024 13:01:10 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 09/13] ARM: dts: microchip: add sama7d65 SoC DT
Date: Fri, 6 Dec 2024 12:59:54 -0700
Message-ID: <f62e2600a8e88e4be9d87b346c41bb4781f8f667.1733505542.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733505542.git.Ryan.Wanner@microchip.com>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add Device Tree for sama7d65 SoC.

Co-developed-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Co-developed-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 145 ++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
new file mode 100644
index 000000000000..0dcd80690210
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ *  sama7d65.dtsi - Device Tree Include file for SAMA7D65 SoC
+ *
+ *  Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
+ *
+ *  Author: Ryan Wanner <Ryan.Wanner@microchip.com>
+ *
+ */
+
+#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mfd/at91-usart.h>
+
+/ {
+	model = "Microchip SAMA7D65 family SoC";
+	compatible = "microchip,sama7d65";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+			device_type = "cpu";
+			clocks = <&pmc PMC_TYPE_CORE PMC_CPUPLL>;
+			clock-names = "cpu";
+		};
+	};
+
+	clocks {
+		main_xtal: clock-mainxtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+
+		 slow_xtal: clock-slowxtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		pioa: pinctrl@e0014000 {
+			compatible = "microchip,sama7d65-pinctrl";
+			reg = <0xe0014000 0x800>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		pmc: clock-controller@e0018000 {
+			compatible = "microchip,sama7d65-pmc", "syscon";
+			reg = <0xe0018000 0x200>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#clock-cells = <2>;
+			clocks = <&clk32k 1>, <&clk32k 0>, <&main_xtal>;
+			clock-names = "td_slck", "md_slck", "main_xtal";
+		};
+
+		clk32k: clock-controller@e001d500 {
+			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
+			reg = <0xe001d500 0x4>;
+			clocks = <&slow_xtal>;
+			#clock-cells = <1>;
+		};
+
+		sdmmc1: mmc@e1208000 {
+			compatible = "microchip,sama7d65-sdhci", "microchip,sam9x60-sdhci";
+			reg = <0xe1208000 0x400>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 76>, <&pmc PMC_TYPE_GCK 76>;
+			clock-names = "hclock", "multclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 76>;
+			assigned-clock-rates = <200000000>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_MCK1>;
+			status = "disabled";
+		};
+
+		pit64b0: timer@e1800000 {
+			compatible = "microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b";
+			reg = <0xe1800000 0x100>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 66>, <&pmc PMC_TYPE_GCK 66>;
+			clock-names = "pclk", "gclk";
+		};
+
+		pit64b1: timer@e1804000 {
+			compatible = "microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b";
+			reg = <0xe1804000 0x100>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 67>, <&pmc PMC_TYPE_GCK 67>;
+			clock-names = "pclk", "gclk";
+		};
+
+		flx6: flexcom@e2020000 {
+			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
+			reg = <0xe2020000 0x200>;
+			ranges = <0x0 0xe2020000 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
+			status = "disabled";
+
+			uart6: serial@200 {
+				compatible = "microchip,sama7d65-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
+				clock-names = "usart";
+				atmel,fifo-size = <16>;
+				status = "disabled";
+			};
+		};
+
+		gic: interrupt-controller@e8c11000 {
+			compatible = "arm,cortex-a7-gic";
+			reg = <0xe8c11000 0x1000>,
+			      <0xe8c12000 0x2000>;
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+		};
+	};
+};
-- 
2.43.0


