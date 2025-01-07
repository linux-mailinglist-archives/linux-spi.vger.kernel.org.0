Return-Path: <linux-spi+bounces-6248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B67AA04586
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 17:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE323A31BF
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E31F4E31;
	Tue,  7 Jan 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rkBYUO8r"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA11F4712;
	Tue,  7 Jan 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266123; cv=none; b=a16GeEr1x7Y1Wncrv0cIXC5G5htppqEJfeZcwnc49vR7TC8mxjNFbHkJmVlzhOT+JK90gTPZcISpSKTG24nLa9ZPBoqnGr3sunVMIrG2Q4Pl0tOm8bvHg8ubcfU2tcprekQ6VEAvcDXTVAwetKvdw99SeuqDsHthCExmuBPXzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266123; c=relaxed/simple;
	bh=PvMZTBsd/zyFDw280jKFb87067d4CpMhzJa4SZI+9ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YANvBZ0oq/n2aIa8HhVX3IOovGYyPs+AA9zm45eoFOJvRpKH5TCU2xgn81/vAe5eLaPuTQBZKRe+0QwgWcknX2PepP29zyjD/rm0SR+TkXn0rzlWAmrLw0Vi4bIiFrVnUA1YR71wRbIMsMiUoA4H/YLYPFNJiTJI3+hkuT+epK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rkBYUO8r; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736266120; x=1767802120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PvMZTBsd/zyFDw280jKFb87067d4CpMhzJa4SZI+9ds=;
  b=rkBYUO8rQh5bCExjn0gw3wRoyA2bqGF5wLI9nhokLRkXW8i9t4deGE9A
   c7xuVAAuyAGaDDGMTocXNtt3XT+1MFRhljRV7fhxA0lHgec4+RFgz4fnQ
   cv6c6HANJPoW1tiOvE+Du42iKhGN9ZkiesVom5T0DMkdRs7omg3jBD9xK
   ZNMSjCK74VMipqyKzAuLcc/0C1W9ERatVp8o79CwoTsb2SrzETHKQBEt5
   4R1PGCZEN91oiLQHJp/obg1hZ7IK1tnmy/F8D1bG/spHiBrJkkXJCyXOy
   iSXvOUWaunpKBdCsodJpA5gpuninBnevSl+Vi850MiEKoTYQLJc34Pbpz
   A==;
X-CSE-ConnectionGUID: lqpfnJzJQpCXzb9QKpQeRA==
X-CSE-MsgGUID: lkEXHdiKQIKQ2alr2emajQ==
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="40091256"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jan 2025 09:08:27 -0700
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
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v5 5/5] ARM: dts: microchip: add support for sama7d65_curiosity board
Date: Tue, 7 Jan 2025 09:07:27 -0700
Message-ID: <20250107160850.120537-6-Ryan.Wanner@microchip.com>
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


