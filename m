Return-Path: <linux-spi+bounces-6142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371709F9B94
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4051898081
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2601A22A7EB;
	Fri, 20 Dec 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OSEG+cyw"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5BE229696;
	Fri, 20 Dec 2024 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728958; cv=none; b=p1tmQjIFhQ8JiU5JyKOk0ZoD9wcOSF1MU+67cAk9lqzhn1Rg6h8vV9i0wQoEnFi750WUEXnB1ZmQTCnAPqgejAE+HLE4xfclU74HHtBr84WE7Ud1c35Yct7wTouTa5u6qlt1fmOlG6zrDbITvO0+abgyHWyKij0KMR9sDc22UKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728958; c=relaxed/simple;
	bh=PvMZTBsd/zyFDw280jKFb87067d4CpMhzJa4SZI+9ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2R/4iuvSpFmhDqbIPgjN6/CFWi7++OLMVJfAJvxZ8WSSmDKX6FPISQ4YD7+IimnfWS3wf3x2QET2iU/222Bu/cx667aZcodcPF1rZRpb5eJCoRZ0X/+dBT8J5G1LJ538S5k2QVckZiwPJZO/Opu596CPPjAa1va6LLygWA27pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OSEG+cyw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728956; x=1766264956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PvMZTBsd/zyFDw280jKFb87067d4CpMhzJa4SZI+9ds=;
  b=OSEG+cywPDIzs2QRsQHXjbKU+yyViNT2cDP/3KLzz75m165Ij55nlj4v
   8WrY0Yx4rbhZG2EammXJVkOLvxltM4wPClwjlxw2dx1Yj6IREDqyUpHFO
   2uZjCJJ1axh5DCHBSgmNZ2pBcp/5p4WlC8Svp0t3JXpTkyuyD+0unvV1/
   94uqtZwuDDpq7KX2hLBika0JalvEtIiXmAjicVv9Bv2iCxRoxYuMaspGV
   Ds3dE17Q2MS6ZwHnQheABT1QcerDmEc+1wkPqCBB/QzoF+TLTsdSkLFJS
   XukPb9RZgBlyoWa8YjHESPOz7gDdZ9/EARuihMxJeUG5Nixn50IbLM6OZ
   Q==;
X-CSE-ConnectionGUID: 6Xn2bQedQHqhtDmL7ky2MQ==
X-CSE-MsgGUID: 9AoGIls2SZCgjMhQrYRKeQ==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="203274649"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 14:09:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 14:08:44 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 14:08:44 -0700
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
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v4 11/13] ARM: dts: microchip: add support for sama7d65_curiosity board
Date: Fri, 20 Dec 2024 14:07:12 -0700
Message-ID: <efe96af1361505be5ec5f409e4c503ccb56379b0.1734723585.git.Ryan.Wanner@microchip.com>
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

From: Romain Sioen <romain.sioen@microchip.com>

Add device tree support for the SAMA7D65 Curiosity board.
Update the Makefile to include the new device tree file.

uart6 is related to flexcom6, hence not sorted in alphabetical order.

Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/Makefile          |  3 +
 .../dts/microchip/at91-sama7d65_curiosity.dts | 89 +++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts

diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
index 470fe46433a9..79cd38fdc7da 100644
--- a/arch/arm/boot/dts/microchip/Makefile
+++ b/arch/arm/boot/dts/microchip/Makefile
@@ -12,6 +12,7 @@ DTC_FLAGS_at91-sama5d2_xplained := -@
 DTC_FLAGS_at91-sama5d3_eds := -@
 DTC_FLAGS_at91-sama5d3_xplained := -@
 DTC_FLAGS_at91-sama5d4_xplained := -@
+DTC_FLAGS_at91-sama7d65_curiosity := -@
 DTC_FLAGS_at91-sama7g54_curiosity := -@
 DTC_FLAGS_at91-sama7g5ek := -@
 dtb-$(CONFIG_SOC_AT91RM9200) += \
@@ -90,6 +91,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-sama5d4_xplained.dtb \
 	at91-sama5d4ek.dtb \
 	at91-vinco.dtb
+dtb-$(CONFIG_SOC_SAMA7D65) += \
+	at91-sama7d65_curiosity.dtb
 dtb-$(CONFIG_SOC_SAMA7G5) += \
 	at91-sama7g54_curiosity.dtb \
 	at91-sama7g5ek.dtb
diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
new file mode 100644
index 000000000000..ef6a56db8acb
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ *  at91-sama7d65_curiosity.dts - Device Tree file for SAMA7D65 Curiosity board
+ *
+ *  Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries
+ *
+ *  Author: Romain Sioen <romain.sioen@microchip.com>
+ *
+ */
+/dts-v1/;
+#include "sama7d65-pinfunc.h"
+#include "sama7d65.dtsi"
+#include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/pinctrl/at91.h>
+
+/ {
+	model = "Microchip SAMA7D65 Curiosity";
+	compatible = "microchip,sama7d65-curiosity", "microchip,sama7d65",
+		     "microchip,sama7d6", "microchip,sama7";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &uart6;
+	};
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+};
+
+&flx6 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6_default>;
+	status = "okay";
+};
+
+&main_xtal {
+	clock-frequency = <24000000>;
+};
+
+&pioa {
+	pinctrl_sdmmc1_default: sdmmc1-default {
+		cmd-data {
+			pinmux = <PIN_PB22__SDMMC1_CMD>,
+				 <PIN_PB24__SDMMC1_DAT0>,
+				 <PIN_PB25__SDMMC1_DAT1>,
+				 <PIN_PB26__SDMMC1_DAT2>,
+				 <PIN_PB27__SDMMC1_DAT3>;
+			slew-rate = <0>;
+			bias-disable;
+		};
+
+		ck-cd-rstn-vddsel {
+			pinmux = <PIN_PB23__SDMMC1_CK>,
+				 <PIN_PB21__SDMMC1_RSTN>,
+				 <PIN_PB30__SDMMC1_1V8SEL>,
+				 <PIN_PB29__SDMMC1_CD>,
+				 <PIN_PB28__SDMMC1_WP>;
+			slew-rate = <0>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_uart6_default: uart6-default {
+		pinmux = <PIN_PD18__FLEXCOM6_IO0>,
+			<PIN_PD19__FLEXCOM6_IO1>;
+		bias-disable;
+	};
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc1_default>;
+	status = "okay";
+};
+
+&slow_xtal {
+	clock-frequency = <32768>;
+};
-- 
2.43.0


