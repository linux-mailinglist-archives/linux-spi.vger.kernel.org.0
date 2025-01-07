Return-Path: <linux-spi+bounces-6249-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B32BA04593
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 17:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42A91884FAD
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA621F5424;
	Tue,  7 Jan 2025 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="atprrP7z"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB11F4293;
	Tue,  7 Jan 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266124; cv=none; b=gyEvWrlhSvmv7t02M6vV0W7evMIkpc6hCFo/hH/lDkQFGnBDIK6Wx7MQjbzbCtKGIXbQziX+HiXHYWqjxBSmVeYysed+pZ++LhoNtMcCv2MBWkrT3hXXpMh/uCm+UW5bTT7SS32Pr2iFz2RAmxvS7vLCRFkhJp+Oq64eHpzSL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266124; c=relaxed/simple;
	bh=urfNn5rVdf7gcjV7bg+HRVF6ewJXcTZT7wfn3zRvj2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGahENe5szOW1dY88x9pHW0LnUAa/CK3b61wWcVCku71KQ3eC0hBLn9pE2t0T+NmHkvPaYl5v6vOxmlDT89TimhjAWdcdd5mRaiuhr9fI6rFURhR9m6iYowgCPcqH8eqAtOS5/TIq8+ybPQ7TLsylJeofcjlQpLmSOkT7Q4lbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=atprrP7z; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736266120; x=1767802120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=urfNn5rVdf7gcjV7bg+HRVF6ewJXcTZT7wfn3zRvj2Y=;
  b=atprrP7zlcuWu6TVeNy7PAzs3VOEsbaZ78GsSoC8qyYi3lE8oPnuc9Pp
   nOGM6Jh1pqQuq7Jzz7gZMhPgjIF7leWCPFGAHvm/loTq7PF1IxZvxdGg7
   3zkRkERf0AJa+uHbAPjSCKZ88j0i1jEB58epSnBQSFAWctN7mWYfF5j1g
   ShnkrD8WU/JhKPG0+rWKXNNpTIIFXr3l697kIbzN7jCz7c1NU1BYLUsrZ
   15+dlQAnLBDa+WvfE471KilBAnrTGi8lUI2kU/K9KtkinRFs6vuUA5+mk
   9KNtvXChdYGaY8IyJMZURW5WObjCQP0RUCX2gerSPeIjjpAJdZPJDC6jC
   A==;
X-CSE-ConnectionGUID: lqpfnJzJQpCXzb9QKpQeRA==
X-CSE-MsgGUID: dNICsMlrT3qhDCy3ycLAog==
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40091254"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jan 2025 09:08:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 Jan 2025 09:08:18 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 7 Jan 2025 09:08:18 -0700
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
Subject: [PATCH v5 4/5] ARM: dts: microchip: add sama7d65 SoC DT
Date: Tue, 7 Jan 2025 09:07:26 -0700
Message-ID: <20250107160850.120537-5-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
References: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
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


