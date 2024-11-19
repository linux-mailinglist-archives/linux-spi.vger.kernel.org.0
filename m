Return-Path: <linux-spi+bounces-5743-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC139D2B67
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6445B1F219C4
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD501D54E7;
	Tue, 19 Nov 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KiSh4Gus"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590041D1512;
	Tue, 19 Nov 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034484; cv=none; b=SmZbBe8ZtMIKk3HAUU2FPQ/A7hX84SoDk1KQ9yiXmAvkffJWDu3kdlWzrp0xSAbNL4z5y7jt/o0/Mrdo+05IpD80oi7f08/g6P4XeziEC9+St6hJqmyPK0zVXtv8NBoBfq9Ik6MUWg3wfhRzBgn33IHoEiigsik9JSFW7vII4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034484; c=relaxed/simple;
	bh=uSvcCWbA3Ht3nwAd4jpwfcx3sIAlsyNlUm64CZ1vwjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qllb+iIPpZV36MqcD9H7tI2F1FYrmzBTGBuk3qKL7DrBR1OdkiOjn4Dsz10ihu6kcHRY1uIyz856ZovjNPCz0D4jrZ4+JRQSgCGm0JD931gqjsQIdvS8XizQP9eLe9Sxt6YcPsUDFAUcOihTR2Xk4FZOC7lHp35crmhf7BsIqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KiSh4Gus; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732034482; x=1763570482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSvcCWbA3Ht3nwAd4jpwfcx3sIAlsyNlUm64CZ1vwjo=;
  b=KiSh4GusF0An+4DJhChLkdOnYKAZ9GLE2zp75PBsL0hLJzeh38BZnFvx
   OVPRhSh5DbGomUpkZXrAyXhSuLxrmIIBV29usjAzakcEtD/z6xsFVHLr+
   4itTHbZWPPNxwvS93ONLkTsSMdPHfosjxSg5Xe8NcEuj4RGlzsQ1+O+cM
   4HWoMaw5+YMdxIXF9YBC5EKygNB4kc0QVKfKrrJiV62BX8+t/VVkeJT8q
   wkP5/x8LtfJBfKFoO8LyCMxcRIrRJYkiV2QWDQZ1XxO0AcQJcP+N3Umk9
   cKFmNe2RmnV+3msz1CpjfR0zQniv2OSfcIMHdfbSGZjJ3KrJWJGMIQFct
   w==;
X-CSE-ConnectionGUID: RxwVwqVBQ5Gt75b5OWvVzw==
X-CSE-MsgGUID: BLlxpfozREyxy5M5U2FaWA==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="34239903"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:41:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:40:55 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:40:55 -0700
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
Subject: [PATCH 11/15] ARM: dts: microchip: add sama7d65 SoC DT
Date: Tue, 19 Nov 2024 09:40:17 -0700
Message-ID: <1006a1e4464ef7c46b33ad44bf71b3143283ee6e.1732030972.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1732030972.git.Ryan.Wanner@microchip.com>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
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

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Co-developed-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 155 ++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
new file mode 100644
index 000000000000..2573d488bb81
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -0,0 +1,155 @@
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
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/gpio/gpio.h>
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
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+			clocks = <&pmc PMC_TYPE_CORE PMC_CPUPLL>;
+			clock-names = "cpu";
+			#cooling-cells = <2>; /* min followed by max */
+		};
+	};
+
+	clocks {
+		slow_xtal: clock-slowxtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+
+		main_xtal: clock-mainxtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+	};
+
+	vddout25: fixed-regulator-vddout25 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDDOUT25";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-boot-on;
+		status = "disabled";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pioA: pinctrl@e0014000 {
+			compatible = "microchip,sama7d65-pinctrl";
+			reg = <0xe0014000 0x800>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
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
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xe2020000 0x800>;
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
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0xe8c11000 0x1000>,
+				<0xe8c12000 0x2000>;
+		};
+	};
+};
-- 
2.43.0


