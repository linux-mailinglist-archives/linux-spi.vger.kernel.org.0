Return-Path: <linux-spi+bounces-6139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C09F9B88
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C305189820F
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1244622968E;
	Fri, 20 Dec 2024 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="107ijG5P"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47072288E9;
	Fri, 20 Dec 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728956; cv=none; b=Ne64wTKeNEdRE/baQXf2f7PY3no257Orocpf+YbivcWj1IqNWf5SPcVMu8pRliqJtrZUucG7ktKOCw+rrV+67IfJXesR9xipeMAysQtB78X3JHOajLGGvNJ4obz0OkoB9CFz9r1ERKA+qLpNv+c6hMjo/DuqlSt0BImjYx3BCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728956; c=relaxed/simple;
	bh=urfNn5rVdf7gcjV7bg+HRVF6ewJXcTZT7wfn3zRvj2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEn2S4x4AOQHtBJOu4v+NCFjCDqEfP1bGD3E4I82Z3llRbqeKrdwCXlUMQ8dmFQk1ExJVtLQ4Lg5eP1WI0LRI2t3BhbdWosZcAD0SdOPgDmIzx+77FFnGNblnV2zhxz2QOWZlaGwPP+kWyZKXcb1um5Ho71eeFBYiw5wdatLOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=107ijG5P; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728954; x=1766264954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=urfNn5rVdf7gcjV7bg+HRVF6ewJXcTZT7wfn3zRvj2Y=;
  b=107ijG5Pm4Np/SeUGdrOlXOsoQvQ5SLj1c8ScBhfVcIEdes+gil6/IoV
   WSMPp4DwZk5TSNsOTd/c/1oUHRTENShx/9FDfbYzvoGMOUScwqoHtvZy+
   pr61G/kAus04id1f9l5uPHnqzdAx0WUbFDU12APyskOdQETEcK8qSRnQX
   60LqqGS3CWwX6S1EAvQqz9KhLaLOa1K4UJ3wWFQEirD/vfQ5GhbmqxEO9
   8pVongb4+HPQiDOyPhdUYC6jneNJNo+OcfjMy+EEnzQ4wyUeTniS8JmJ4
   8NQCVvWP+p3Ec21uxXJQS5fflDlSW+NV2V6Ga5oO4jOo6eATjm9ypW+Nt
   Q==;
X-CSE-ConnectionGUID: 6Xn2bQedQHqhtDmL7ky2MQ==
X-CSE-MsgGUID: uEOhx2XmSgyTdHfIpWOUUg==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="203274647"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 14:09:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 14:08:43 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 14:08:43 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH v4 09/13] ARM: dts: microchip: add sama7d65 SoC DT
Date: Fri, 20 Dec 2024 14:07:10 -0700
Message-ID: <3f63aebc4b31da1b631ce7e6d76aa0046deeda6a.1734723585.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734723585.git.Ryan.Wanner@microchip.com>
References: <cover.1734723585.git.Ryan.Wanner@microchip.com>
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
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 145 ++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
new file mode 100644
index 000000000000..03e1adfdcd34
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
+			compatible = "microchip,sama7d65-pinctrl", "microchip,sama7g5-pinctrl";
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
+				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
+				clock-names = "usart";
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
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


