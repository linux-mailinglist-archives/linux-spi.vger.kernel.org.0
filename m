Return-Path: <linux-spi+bounces-5935-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829AE9E7990
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D893B16E3D0
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B61219EB1;
	Fri,  6 Dec 2024 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vvEHsRE4"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34614214A6B;
	Fri,  6 Dec 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515288; cv=none; b=exQPpb1GAhD7B8LHrGcPs1bMTl3y9J5E3GyZnEFC5t2Yp2k14xd9CARGALX5sPHLCKwwF5/mmFvd6IvzvnY7JhX7oUq84UD1mL8VapVcqgVQmTDNWdAsHV5NKEZ3QV8SJbcXKWceNWSglIUskmc5EJVo1ZUr7ALRbMiO+Y90agQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515288; c=relaxed/simple;
	bh=tEYyQg1LQfS1kqEdIlzgR8xqItpeS7PZiMxEJfRieYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6sZ+UfeUpFc+IZLYZfnei5V0Vih+k2/Tpk3A2Fzo87TgMQStyCySy4356rvZs0zL0RV7wpdsdshXXkFlgpZrKj3jzkcAJ1QQSXLqHPbc5psSAYq54dWinQWbDFnWtleY5d0HwgprNOshMQrfZsAZ3td5L8yd/SmAgVuJw5u3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vvEHsRE4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515285; x=1765051285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tEYyQg1LQfS1kqEdIlzgR8xqItpeS7PZiMxEJfRieYM=;
  b=vvEHsRE4g2NoQHoXww3lSbMqNTTGY5JqR02RXV+3eqB7epHVFtrtwNlO
   9glGZUAnuIxIzhH9APZafD5DzPdbZDYDqp4AZgRKPoqqZU1McSlLbHUIa
   cKh7Yn3mpBm0tB6mbFx1yZvIPVpUxHEI6nwUm4ZXJ+DzMRt170oSGvfrg
   4BDivOAvv5cNg1OyMTs0KW14P/lUt7qfT8Uf7k/tRvdhtMpNjpVOluNpc
   3+MWJma7lH/W3pRHZa+/hqO04kAdMcu7foYneRnnPlzkzk+TPV9I5STgK
   /m58mhWlxnfiHJFfnb6YwGguOTMZ+TsHzDNQwEdMAwa6dWvSh5GH9xWCw
   Q==;
X-CSE-ConnectionGUID: wHv5dacKTzaP3KMzdbJ8Aw==
X-CSE-MsgGUID: b2B3ctmCQ9KlIsKgD25k9g==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="202686988"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:11 -0700
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
Subject: [PATCH v3 10/13] ARM: dts: at91: Add sama7d65 pinmux
Date: Fri, 6 Dec 2024 12:59:55 -0700
Message-ID: <a8f880b89cd4470526a2955a0b6aaaaa24ba65b8.1733505542.git.Ryan.Wanner@microchip.com>
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

Add sama7d65 pin descriptions.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../arm/boot/dts/microchip/sama7d65-pinfunc.h | 947 ++++++++++++++++++
 1 file changed, 947 insertions(+)
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65-pinfunc.h

diff --git a/arch/arm/boot/dts/microchip/sama7d65-pinfunc.h b/arch/arm/boot/dts/microchip/sama7d65-pinfunc.h
new file mode 100644
index 000000000000..c591f333cacb
--- /dev/null
+++ b/arch/arm/boot/dts/microchip/sama7d65-pinfunc.h
@@ -0,0 +1,947 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+#define PINMUX_PIN(no, func, ioset) \
+(((no) & 0xffff) | (((func) & 0xf) << 16) | (((ioset) & 0xff) << 20))
+
+#define PIN_PA0				0
+#define PIN_PA0__GPIO			PINMUX_PIN(PIN_PA0, 0, 0)
+#define PIN_PA0__SDMMC0_CK		PINMUX_PIN(PIN_PA0, 1, 1)
+#define PIN_PA0__FLEXCOM3_IO0		PINMUX_PIN(PIN_PA0, 2, 1)
+#define PIN_PA0__NWER0			PINMUX_PIN(PIN_PA0, 3, 1)
+
+#define PIN_PA1				1
+#define PIN_PA1__GPIO			PINMUX_PIN(PIN_PA1, 0, 0)
+#define PIN_PA1__SDMMC0_CMD		PINMUX_PIN(PIN_PA1, 1, 1)
+#define PIN_PA1__FLEXCOM3_IO1		PINMUX_PIN(PIN_PA1, 2, 1)
+#define PIN_PA1__A21			PINMUX_PIN(PIN_PA1, 3, 1)
+
+#define PIN_PA2				2
+#define PIN_PA2__GPIO			PINMUX_PIN(PIN_PA2, 0, 0)
+#define PIN_PA2__SDMMC0_RSTN		PINMUX_PIN(PIN_PA2, 1, 1)
+#define PIN_PA2__FLEXCOM3_IO2		PINMUX_PIN(PIN_PA2, 2, 1)
+#define PIN_PA2__A22			PINMUX_PIN(PIN_PA2, 3, 1)
+
+#define PIN_PA3				3
+#define PIN_PA3__GPIO			PINMUX_PIN(PIN_PA3, 0, 0)
+#define PIN_PA3__SDMMC0_DAT0		PINMUX_PIN(PIN_PA3, 1, 1)
+#define PIN_PA3__FLEXCOM3_IO3		PINMUX_PIN(PIN_PA3, 2, 1)
+#define PIN_PA3__D0			PINMUX_PIN(PIN_PA3, 3, 1)
+
+#define PIN_PA4				4
+#define PIN_PA4__GPIO			PINMUX_PIN(PIN_PA4, 0, 0)
+#define PIN_PA4__SDMMC0_DAT1		PINMUX_PIN(PIN_PA4, 1, 1)
+#define PIN_PA4__FLEXCOM3_IO4		PINMUX_PIN(PIN_PA4, 2, 1)
+#define PIN_PA4__D1			PINMUX_PIN(PIN_PA4, 3, 1)
+
+#define PIN_PA5				5
+#define PIN_PA5__GPIO			PINMUX_PIN(PIN_PA5, 0, 0)
+#define PIN_PA5__SDMMC0_DAT4		PINMUX_PIN(PIN_PA5, 1, 1)
+#define PIN_PA5__FLEXCOM2_IO0		PINMUX_PIN(PIN_PA5, 2, 3)
+#define PIN_PA5__D4			PINMUX_PIN(PIN_PA5, 3, 1)
+#define PIN_PA5__TCLK4			PINMUX_PIN(PIN_PA5, 6, 3)
+
+#define PIN_PA6				6
+#define PIN_PA6__GPIO			PINMUX_PIN(PIN_PA6, 0, 0)
+#define PIN_PA6__SDMMC0_DAT5		PINMUX_PIN(PIN_PA6, 1, 1)
+#define PIN_PA6__FLEXCOM2_IO1		PINMUX_PIN(PIN_PA6, 2, 3)
+#define PIN_PA6__D5			PINMUX_PIN(PIN_PA6, 3, 1)
+#define PIN_PA6__TIOB4			PINMUX_PIN(PIN_PA6, 6, 3)
+
+#define PIN_PA7				7
+#define PIN_PA7__GPIO			PINMUX_PIN(PIN_PA7, 0, 0)
+#define PIN_PA7__SDMMC0_DAT6		PINMUX_PIN(PIN_PA7, 1, 1)
+#define PIN_PA7__FLEXCOM2_IO2		PINMUX_PIN(PIN_PA7, 2, 3)
+#define PIN_PA7__D6			PINMUX_PIN(PIN_PA7, 3, 1)
+#define PIN_PA7__TIOA4			PINMUX_PIN(PIN_PA7, 6, 3)
+
+#define PIN_PA8				8
+#define PIN_PA8__GPIO			PINMUX_PIN(PIN_PA8, 0, 0)
+#define PIN_PA8__SDMMC0_DAT7		PINMUX_PIN(PIN_PA8, 1, 1)
+#define PIN_PA8__FLEXCOM2_IO3		PINMUX_PIN(PIN_PA8, 2, 3)
+#define PIN_PA8__D7			PINMUX_PIN(PIN_PA8, 3, 1)
+#define PIN_PA8__TIOA5			PINMUX_PIN(PIN_PA8, 6, 3)
+
+#define PIN_PA9				9
+#define PIN_PA9__GPIO			PINMUX_PIN(PIN_PA9, 0, 0)
+#define PIN_PA9__SDMMC0_DAT2		PINMUX_PIN(PIN_PA9, 1, 1)
+#define PIN_PA9__FLEXCOM0_IO2		PINMUX_PIN(PIN_PA9, 2, 1)
+#define PIN_PA9__D2			PINMUX_PIN(PIN_PA9, 3, 1)
+#define PIN_PA9__TIOB5			PINMUX_PIN(PIN_PA9, 6, 3)
+
+#define PIN_PA10			10
+#define PIN_PA10__GPIO			PINMUX_PIN(PIN_PA10, 0, 0)
+#define PIN_PA10__SDMMC0_DAT3		PINMUX_PIN(PIN_PA10, 1, 1)
+#define PIN_PA10__FLEXCOM0_IO3		PINMUX_PIN(PIN_PA10, 2, 1)
+#define PIN_PA10__D3			PINMUX_PIN(PIN_PA10, 3, 1)
+#define PIN_PA10__TCLK5			PINMUX_PIN(PIN_PA10, 6, 3)
+
+#define PIN_PA11			11
+#define PIN_PA11__GPIO			PINMUX_PIN(PIN_PA11, 0, 0)
+#define PIN_PA11__SDMMC0_DS		PINMUX_PIN(PIN_PA11, 1, 1)
+#define PIN_PA11__FLEXCOM0_IO4		PINMUX_PIN(PIN_PA11, 2, 1)
+#define PIN_PA11__NANDRDY		PINMUX_PIN(PIN_PA11, 3, 1)
+#define PIN_PA11__TIOB3			PINMUX_PIN(PIN_PA11, 6, 3)
+
+#define PIN_PA12			12
+#define PIN_PA12__GPIO			PINMUX_PIN(PIN_PA12, 0, 0)
+#define PIN_PA12__FLEXCOM0_IO0		PINMUX_PIN(PIN_PA12, 2, 1)
+#define PIN_PA12__NRD			PINMUX_PIN(PIN_PA12, 3, 1)
+#define PIN_PA12__PCK0			PINMUX_PIN(PIN_PA12, 4, 1)
+#define PIN_PA12__EXT_IRQ0		PINMUX_PIN(PIN_PA12, 5, 1)
+#define PIN_PA12__TIOA3			PINMUX_PIN(PIN_PA12, 6, 3)
+
+#define PIN_PA13			13
+#define PIN_PA13__GPIO			PINMUX_PIN(PIN_PA13, 0, 0)
+#define PIN_PA13__FLEXCOM0_IO1		PINMUX_PIN(PIN_PA13, 2, 1)
+#define PIN_PA13__NCS0			PINMUX_PIN(PIN_PA13, 3, 1)
+#define PIN_PA13__PCK1			PINMUX_PIN(PIN_PA13, 4, 1)
+#define PIN_PA13__TCLK3			PINMUX_PIN(PIN_PA13, 6, 3)
+
+#define PIN_PA14			14
+#define PIN_PA14__GPIO			PINMUX_PIN(PIN_PA14, 0, 0)
+#define PIN_PA14__FLEXCOM4_IO4		PINMUX_PIN(PIN_PA14, 1, 1)
+#define PIN_PA14__SDMMC0_WP		PINMUX_PIN(PIN_PA14, 2, 1)
+#define PIN_PA14__FLEXCOM3_IO0		PINMUX_PIN(PIN_PA14, 3, 4)
+
+#define PIN_PA15			15
+#define PIN_PA15__GPIO			PINMUX_PIN(PIN_PA15, 0, 0)
+#define PIN_PA15__FLEXCOM4_IO3		PINMUX_PIN(PIN_PA15, 1, 1)
+#define PIN_PA15__SDMMC0_1V8SEL		PINMUX_PIN(PIN_PA15, 2, 1)
+#define PIN_PA15__FLEXCOM3_IO1		PINMUX_PIN(PIN_PA15, 3, 4)
+
+#define PIN_PA16			16
+#define PIN_PA16__GPIO			PINMUX_PIN(PIN_PA16, 0, 0)
+#define PIN_PA16__FLEXCOM4_IO2		PINMUX_PIN(PIN_PA16, 1, 1)
+#define PIN_PA16__SDMMCo_CD		PINMUX_PIN(PIN_PA16, 2, 1)
+#define PIN_PA16__PCK2			PINMUX_PIN(PIN_PA16, 4, 1)
+#define PIN_PA16__EXT_IRQ1		PINMUX_PIN(PIN_PA16, 5, 1)
+
+#define PIN_PA17			17
+#define PIN_PA17__GPIO			PINMUX_PIN(PIN_PA17, 0, 0)
+#define PIN_PA17__FLEXCOM4_IO1		PINMUX_PIN(PIN_PA17, 1, 1)
+
+#define PIN_PA18			18
+#define PIN_PA18__GPIO			PINMUX_PIN(PIN_PA18, 0, 0)
+#define PIN_PA18__FLEXCOM4_IO0		PINMUX_PIN(PIN_PA18, 1, 1)
+
+#define PIN_PA19			19
+#define PIN_PA19__GPIO			PINMUX_PIN(PIN_PA19, 0, 0)
+#define PIN_PA19__TK0			PINMUX_PIN(PIN_PA19, 1, 1)
+#define PIN_PA19__FLEXCOM4_IO5		PINMUX_PIN(PIN_PA19, 3, 1)
+#define PIN_PA19__PWML0			PINMUX_PIN(PIN_PA19, 4, 3)
+
+#define PIN_PA20			20
+#define PIN_PA20__GPIO			PINMUX_PIN(PIN_PA20, 0, 0)
+#define PIN_PA20__TD0			PINMUX_PIN(PIN_PA20, 1, 1)
+#define PIN_PA20__FLEXCOM3_IO4		PINMUX_PIN(PIN_PA20, 2, 2)
+#define PIN_PA20__FLEXCOM4_IO6		PINMUX_PIN(PIN_PA20, 3, 1)
+#define PIN_PA20__PWMH0			PINMUX_PIN(PIN_PA20, 4, 3)
+
+#define PIN_PA21			21
+#define PIN_PA21__GPIO			PINMUX_PIN(PIN_PA21, 0, 0)
+#define PIN_PA21__TF0			PINMUX_PIN(PIN_PA21, 1, 1)
+#define PIN_PA21__FLEXCOM3_IO3		PINMUX_PIN(PIN_PA21, 2, 2)
+#define PIN_PA21__PWML1			PINMUX_PIN(PIN_PA21, 4, 3)
+
+#define PIN_PA22			22
+#define PIN_PA22__GPIO			PINMUX_PIN(PIN_PA22, 0, 0)
+#define PIN_PA22__RD0			PINMUX_PIN(PIN_PA22, 1, 1)
+#define PIN_PA22__FLEXCOM3_IO2		PINMUX_PIN(PIN_PA22, 2, 2)
+#define PIN_PA22__PDMC0_DS1		PINMUX_PIN(PIN_PA22, 3, 1)
+#define PIN_PA22__PWMH1			PINMUX_PIN(PIN_PA22, 4, 3)
+
+#define PIN_PA23			23
+#define PIN_PA23__GPIO			PINMUX_PIN(PIN_PA23, 0, 0)
+#define PIN_PA23__RK0			PINMUX_PIN(PIN_PA23, 1, 1)
+#define PIN_PA23__FLEXCOM3_IO1		PINMUX_PIN(PIN_PA23, 2, 2)
+#define PIN_PA23__PDMC0_CLK		PINMUX_PIN(PIN_PA23, 3, 1)
+#define PIN_PA23__PWML2			PINMUX_PIN(PIN_PA23, 4, 3)
+
+#define PIN_PA24			24
+#define PIN_PA24__GPIO			PINMUX_PIN(PIN_PA24, 0, 0)
+#define PIN_PA24__RF0			PINMUX_PIN(PIN_PA24, 1, 1)
+#define PIN_PA24__FLEXCOM3_IO0		PINMUX_PIN(PIN_PA24, 2, 2)
+#define PIN_PA24__PDMC0_DS0		PINMUX_PIN(PIN_PA24, 3, 1)
+#define PIN_PA24__PWMH2			PINMUX_PIN(PIN_PA24, 4, 3)
+
+#define PIN_PA25			25
+#define PIN_PA25__GPIO			PINMUX_PIN(PIN_PA25, 0, 0)
+#define PIN_PA25__G0_TXCTL		PINMUX_PIN(PIN_PA25, 1, 1)
+#define PIN_PA25__FLEXCOM6_IO2		PINMUX_PIN(PIN_PA25, 2, 1)
+
+#define PIN_PA26			26
+#define PIN_PA26__GPIO			PINMUX_PIN(PIN_PA26, 0, 0)
+#define PIN_PA26__G0_TX0		PINMUX_PIN(PIN_PA26, 1, 1)
+#define PIN_PA26__FLEXCOM6_IO3		PINMUX_PIN(PIN_PA26, 2, 1)
+
+#define PIN_PA27			27
+#define PIN_PA27__GPIO			PINMUX_PIN(PIN_PA27, 0, 0)
+#define PIN_PA27__G0_TX1		PINMUX_PIN(PIN_PA27, 1, 1)
+#define PIN_PA27__FLEXCOM6_IO4		PINMUX_PIN(PIN_PA27, 2, 1)
+
+#define PIN_PA28			28
+#define PIN_PA28__GPIO			PINMUX_PIN(PIN_PA28, 0, 0)
+#define PIN_PA28__G0_RXCTL		PINMUX_PIN(PIN_PA28, 1, 1)
+#define PIN_PA28__FLEXCOM6_IO0		PINMUX_PIN(PIN_PA28, 2, 1)
+
+#define PIN_PA29			29
+#define PIN_PA29__GPIO			PINMUX_PIN(PIN_PA29, 0, 0)
+#define PIN_PA29__G0_RX0		PINMUX_PIN(PIN_PA29, 1, 1)
+#define PIN_PA29__FLEXCOM6_IO1		PINMUX_PIN(PIN_PA29, 2, 1)
+
+#define PIN_PA30			30
+#define PIN_PA30__GPIO			PINMUX_PIN(PIN_PA30, 0, 0)
+#define PIN_PA30__G0_RX1		PINMUX_PIN(PIN_PA30, 1, 1)
+#define PIN_PA30__FLEXCOM8_IO0		PINMUX_PIN(PIN_PA30, 2, 1)
+
+#define PIN_PA31			31
+#define PIN_PA31__GPIO			PINMUX_PIN(PIN_PA31, 0, 0)
+#define PIN_PA31__G0_MDC		PINMUX_PIN(PIN_PA31, 1, 1)
+#define PIN_PA31__FLEXCOM8_IO1		PINMUX_PIN(PIN_PA31, 2, 1)
+
+#define PIN_PB0				32
+#define PIN_PB0__GPIO			PINMUX_PIN(PIN_PB0, 0, 0)
+#define PIN_PB0__G0_MDIO		PINMUX_PIN(PIN_PB0, 1, 1)
+#define PIN_PB0__FLEXCOM8_IO3		PINMUX_PIN(PIN_PB0, 2, 2)
+
+#define PIN_PB1				33
+#define PIN_PB1__GPIO			PINMUX_PIN(PIN_PB1, 0, 0)
+#define PIN_PB1__G0_REFCK		PINMUX_PIN(PIN_PB1, 1, 2)
+#define PIN_PB1__FLEXCOM8_IO2		PINMUX_PIN(PIN_PB1, 2, 1)
+
+#define PIN_PB2				34
+#define PIN_PB2__GPIO			PINMUX_PIN(PIN_PB2, 0, 0)
+#define PIN_PB2__G0_RX2			PINMUX_PIN(PIN_PB2, 1, 1)
+#define PIN_PB2__FLEXCOM8_IO4		PINMUX_PIN(PIN_PB2, 2, 1)
+#define PIN_PB2__G0_RXER		PINMUX_PIN(PIN_PB2, 3, 2)
+#define PIN_PB2__RK0			PINMUX_PIN(PIN_PB2, 4, 2)
+
+#define PIN_PB3				35
+#define PIN_PB3__GPIO			PINMUX_PIN(PIN_PB3, 0, 0)
+#define PIN_PB3__G0_RXCK		PINMUX_PIN(PIN_PB3, 1, 1)
+#define PIN_PB3__FLEXCOM10_IO2		PINMUX_PIN(PIN_PB3, 2, 2)
+#define PIN_PB3__TK0			PINMUX_PIN(PIN_PB3, 4, 2)
+
+#define PIN_PB4				36
+#define PIN_PB4__GPIO			PINMUX_PIN(PIN_PB4, 0, 0)
+#define PIN_PB4__G0_TX2			PINMUX_PIN(PIN_PB4, 1, 1)
+#define PIN_PB4__FLEXCOM10_IO3		PINMUX_PIN(PIN_PB4, 2, 2)
+#define PIN_PB4__TF0			PINMUX_PIN(PIN_PB4, 4, 2)
+
+#define PIN_PB5				37
+#define PIN_PB5__GPIO			PINMUX_PIN(PIN_PB5, 0, 0)
+#define PIN_PB5__G0_TX3			PINMUX_PIN(PIN_PB5, 1, 1)
+#define PIN_PB5__FLEXCOM10_IO4		PINMUX_PIN(PIN_PB5, 2, 1)
+#define PIN_PB5__TD0			PINMUX_PIN(PIN_PB5, 4, 2)
+
+#define PIN_PB6				38
+#define PIN_PB6__GPIO			PINMUX_PIN(PIN_PB6, 0, 0)
+#define PIN_PB6__G0_RX3			PINMUX_PIN(PIN_PB6, 1, 1)
+#define PIN_PB6__FLEXCOM10_IO0		PINMUX_PIN(PIN_PB6, 2, 2)
+#define PIN_PB6__RD0			PINMUX_PIN(PIN_PB6, 4, 2)
+
+#define PIN_PB7				39
+#define PIN_PB7__GPIO			PINMUX_PIN(PIN_PB7, 0, 0)
+#define PIN_PB7__G0_TSUCOMP		PINMUX_PIN(PIN_PB7, 1, 1)
+#define PIN_PB7__FLEXCOM10_IO1		PINMUX_PIN(PIN_PB7, 2, 2)
+#define PIN_PB7__ADTRG			PINMUX_PIN(PIN_PB7, 3, 1)
+#define PIN_PB7__RF0			PINMUX_PIN(PIN_PB7, 4, 2)
+
+#define PIN_PB8				40
+#define PIN_PB8__GPIO			PINMUX_PIN(PIN_PB8, 0, 0)
+#define PIN_PB8__QSPI0_IO3		PINMUX_PIN(PIN_PB8, 1, 1)
+#define PIN_PB8__PCK3			PINMUX_PIN(PIN_PB8, 2, 1)
+#define PIN_PB8__FLEXCOM2_IO1		PINMUX_PIN(PIN_PB8, 4, 2)
+
+#define PIN_PB9				41
+#define PIN_PB9__GPIO			PINMUX_PIN(PIN_PB9, 0, 0)
+#define PIN_PB9__QSPI0_IO2		PINMUX_PIN(PIN_PB9, 1, 1)
+#define PIN_PB9__FLEXCOM2_IO0		PINMUX_PIN(PIN_PB9, 4, 2)
+#define PIN_PB9__PWMEXTRG0		PINMUX_PIN(PIN_PB9, 5, 1)
+
+#define PIN_PB10			42
+#define PIN_PB10__GPIO			PINMUX_PIN(PIN_PB10, 0, 0)
+#define PIN_PB10__QSPI0_IO1		PINMUX_PIN(PIN_PB10, 1, 1)
+#define PIN_PB10__FLEXCOM2_IO4		PINMUX_PIN(PIN_PB10, 4, 2)
+#define PIN_PB10__PWMEXTRG1		PINMUX_PIN(PIN_PB10, 5, 1)
+
+#define PIN_PB11			43
+#define PIN_PB11__GPIO			PINMUX_PIN(PIN_PB11, 0, 0)
+#define PIN_PB11__QSPI0_IO0		PINMUX_PIN(PIN_PB11, 1, 1)
+#define PIN_PB11__FLEXCOM2_IO5		PINMUX_PIN(PIN_PB11, 4, 2)
+#define PIN_PB11__PWML3			PINMUX_PIN(PIN_PB11, 5, 1)
+#define PIN_PB11__TIOB3			PINMUX_PIN(PIN_PB11, 6, 2)
+
+#define PIN_PB12			44
+#define PIN_PB12__GPIO			PINMUX_PIN(PIN_PB12, 0, 0)
+#define PIN_PB12__QSPI0_CS		PINMUX_PIN(PIN_PB12, 1, 1)
+#define PIN_PB12__FLEXCOM2_IO3		PINMUX_PIN(PIN_PB12, 4, 2)
+#define PIN_PB12__PWMFI1		PINMUX_PIN(PIN_PB12, 6, 1)
+#define PIN_PB12__TIOA3			PINMUX_PIN(PIN_PB12, 6, 2)
+
+#define PIN_PB13			45
+#define PIN_PB13__GPIO			PINMUX_PIN(PIN_PB13, 0, 0)
+#define PIN_PB13__QSPI0_SCK		PINMUX_PIN(PIN_PB13, 1, 1)
+#define PIN_PB13__FLEXCOM2_IO2		PINMUX_PIN(PIN_PB13, 4, 2)
+#define PIN_PB13__PWMFI0		PINMUX_PIN(PIN_PB13, 5, 1)
+#define PIN_PB13__TCLK3			PINMUX_PIN(PIN_PB13, 6, 2)
+
+#define PIN_PB14			46
+#define PIN_PB14__GPIO			PINMUX_PIN(PIN_PB14, 0, 0)
+#define PIN_PB14__QSPI0_SCKN		PINMUX_PIN(PIN_PB14, 1, 1)
+#define PIN_PB14__QSPI1_SCK		PINMUX_PIN(PIN_PB14, 2, 1)
+#define PIN_PB14__I2SMCC0_CK		PINMUX_PIN(PIN_PB14, 3, 3)
+#define PIN_PB14__FLEXCOM10_IO5		PINMUX_PIN(PIN_PB14, 4, 1)
+#define PIN_PB14__PWMH3			PINMUX_PIN(PIN_PB14, 5, 1)
+#define PIN_PB14__FLEXCOM2_IO1		PINMUX_PIN(PIN_PB14, 7, 4)
+
+#define PIN_PB15			47
+#define PIN_PB15__GPIO			PINMUX_PIN(PIN_PB15, 0, 0)
+#define PIN_PB15__QSPI0_IO4		PINMUX_PIN(PIN_PB15, 1, 1)
+#define PIN_PB15__QSPI1_IO0		PINMUX_PIN(PIN_PB15, 2, 1)
+#define PIN_PB15__I2SMCC0_WS		PINMUX_PIN(PIN_PB15, 3, 3)
+#define PIN_PB15__FLEXCOM10_IO6		PINMUX_PIN(PIN_PB15, 4, 1)
+#define PIN_PB15__PWML0			PINMUX_PIN(PIN_PB15, 5, 1)
+#define PIN_PB15__TCLK4			PINMUX_PIN(PIN_PB15, 6, 2)
+#define PIN_PB15__FLEXCOM2_IO0		PINMUX_PIN(PIN_PB15, 7, 4)
+
+#define PIN_PB16			48
+#define PIN_PB16__GPIO			PINMUX_PIN(PIN_PB16, 0, 0)
+#define PIN_PB16__QSPI0_IO5		PINMUX_PIN(PIN_PB16, 1, 1)
+#define PIN_PB16__QSPI1_IO1		PINMUX_PIN(PIN_PB16, 2, 1)
+#define PIN_PB16__I2SMCC0_DIN0		PINMUX_PIN(PIN_PB16, 3, 3)
+#define PIN_PB16__FLEXCOM10_IO4		PINMUX_PIN(PIN_PB16, 4, 1)
+#define PIN_PB16__PWMH0			PINMUX_PIN(PIN_PB16, 5, 1)
+#define PIN_PB16__TIOB4			PINMUX_PIN(PIN_PB16, 6, 2)
+
+#define PIN_PB17			49
+#define PIN_PB17__GPIO			PINMUX_PIN(PIN_PB17, 0, 0)
+#define PIN_PB17__QSPI0_IO6		PINMUX_PIN(PIN_PB17, 1, 1)
+#define PIN_PB17__QSPI1_IO2		PINMUX_PIN(PIN_PB17, 2, 1)
+#define PIN_PB17__I2SMCC0_DOUT0		PINMUX_PIN(PIN_PB17, 3, 3)
+#define PIN_PB17__FLEXCOM10_IO3		PINMUX_PIN(PIN_PB17, 4, 1)
+#define PIN_PB17__PWML1			PINMUX_PIN(PIN_PB17, 5, 1)
+#define PIN_PB17__TIOA4			PINMUX_PIN(PIN_PB17, 6, 2)
+
+#define PIN_PB18			50
+#define PIN_PB18__GPIO			PINMUX_PIN(PIN_PB18, 0, 0)
+#define PIN_PB18__QSPI0_IO7		PINMUX_PIN(PIN_PB18, 1, 1)
+#define PIN_PB18__QSPI1_IO3		PINMUX_PIN(PIN_PB18, 2, 1)
+#define PIN_PB18__I2SMCC0_MCK		PINMUX_PIN(PIN_PB18, 3, 3)
+#define PIN_PB18__FLEXCOM10_IO2		PINMUX_PIN(PIN_PB18, 4, 1)
+#define PIN_PB18__PWMH1			PINMUX_PIN(PIN_PB18, 5, 1)
+#define PIN_PB18__TIOA5			PINMUX_PIN(PIN_PB18, 6, 2)
+
+#define PIN_PB19			51
+#define PIN_PB19__GPIO			PINMUX_PIN(PIN_PB19, 0, 0)
+#define PIN_PB19__QSPI0_DQS		PINMUX_PIN(PIN_PB19, 1, 1)
+#define PIN_PB19__EXT_IRQ1		PINMUX_PIN(PIN_PB19, 2, 2)
+#define PIN_PB19__PCK4			PINMUX_PIN(PIN_PB19, 3, 1)
+#define PIN_PB19__FLEXCOM10_IO1		PINMUX_PIN(PIN_PB19, 4, 1)
+#define PIN_PB19__PWML2			PINMUX_PIN(PIN_PB19, 5, 1)
+#define PIN_PB19__TIOB5			PINMUX_PIN(PIN_PB19, 6, 2)
+
+#define PIN_PB20			52
+#define PIN_PB20__GPIO			PINMUX_PIN(PIN_PB20, 0, 0)
+#define PIN_PB20__QSPI0_INT		PINMUX_PIN(PIN_PB20, 1, 1)
+#define PIN_PB20__QSPI1_CS		PINMUX_PIN(PIN_PB20, 2, 1)
+#define PIN_PB20__FLEXCOM10_IO0		PINMUX_PIN(PIN_PB20, 4, 1)
+#define PIN_PB20__PWMH2			PINMUX_PIN(PIN_PB20, 5, 1)
+#define PIN_PB20__TCLK5			PINMUX_PIN(PIN_PB20, 6, 2)
+
+#define PIN_PB21			53
+#define PIN_PB21__GPIO			PINMUX_PIN(PIN_PB21, 0, 0)
+#define PIN_PB21__SDMMC1_RSTN		PINMUX_PIN(PIN_PB21, 1, 1)
+#define PIN_PB21__FLEXCOM6_IO4		PINMUX_PIN(PIN_PB21, 2, 2)
+#define PIN_PB21__TIOB2			PINMUX_PIN(PIN_PB21, 3, 2)
+#define PIN_PB21__ADTRG			PINMUX_PIN(PIN_PB21, 4, 2)
+#define PIN_PB21__EXT_IRQ0		PINMUX_PIN(PIN_PB21, 5, 2)
+
+#define PIN_PB22			54
+#define PIN_PB22__GPIO			PINMUX_PIN(PIN_PB22, 0, 0)
+#define PIN_PB22__SDMMC1_CMD		PINMUX_PIN(PIN_PB22, 1, 1)
+#define PIN_PB22__FLEXCOM6_IO3		PINMUX_PIN(PIN_PB22, 2, 2)
+#define PIN_PB22__TCLK2			PINMUX_PIN(PIN_PB22, 3, 2)
+
+#define PIN_PB23			55
+#define PIN_PB23__GPIO			PINMUX_PIN(PIN_PB23, 0, 0)
+#define PIN_PB23__SDMMC1_CK		PINMUX_PIN(PIN_PB23, 1, 1)
+#define PIN_PB23__FLEXCOM6_IO2		PINMUX_PIN(PIN_PB23, 2, 2)
+#define PIN_PB23__TIOA2			PINMUX_PIN(PIN_PB23, 3, 2)
+
+#define PIN_PB24			56
+#define PIN_PB24__GPIO			PINMUX_PIN(PIN_PB24, 0, 0)
+#define PIN_PB24__SDMMC1_DAT0		PINMUX_PIN(PIN_PB24, 1, 1)
+#define PIN_PB24__FLEXCOM6_IO0		PINMUX_PIN(PIN_PB24, 2, 2)
+
+#define PIN_PB25			57
+#define PIN_PB25__GPIO			PINMUX_PIN(PIN_PB25, 0, 0)
+#define PIN_PB25__SDMMC1_DAT1		PINMUX_PIN(PIN_PB25, 1, 1)
+#define PIN_PB25__FLEXCOM6_IO1		PINMUX_PIN(PIN_PB25, 2, 2)
+#define PIN_PB25__TIOB2			PINMUX_PIN(PIN_PB25, 3, 1)
+
+#define PIN_PB26			58
+#define PIN_PB26__GPIO			PINMUX_PIN(PIN_PB26, 0, 0)
+#define PIN_PB26__SDMMC1_DAT2		PINMUX_PIN(PIN_PB26, 1, 1)
+#define PIN_PB26__FLEXCOM8_IO0		PINMUX_PIN(PIN_PB26, 2, 3)
+#define PIN_PB26__TCLK2			PINMUX_PIN(PIN_PB26, 3, 1)
+
+#define PIN_PB27			59
+#define PIN_PB27__GPIO			PINMUX_PIN(PIN_PB27, 0, 0)
+#define PIN_PB27__SDMMC1_DAT3		PINMUX_PIN(PIN_PB27, 1, 1)
+#define PIN_PB27__FLEXCOM8_IO1		PINMUX_PIN(PIN_PB27, 2, 3)
+#define PIN_PB27__TIOA2			PINMUX_PIN(PIN_PB27, 3, 1)
+
+#define PIN_PB28			60
+#define PIN_PB28__GPIO			PINMUX_PIN(PIN_PB28, 0, 0)
+#define PIN_PB28__SDMMC1_WP		PINMUX_PIN(PIN_PB28, 1, 1)
+#define PIN_PB28__FLEXCOM1_IO0		PINMUX_PIN(PIN_PB28, 3, 3)
+#define PIN_PB28__D15			PINMUX_PIN(PIN_PB28, 5, 1)
+
+#define PIN_PB29			61
+#define PIN_PB29__GPIO			PINMUX_PIN(PIN_PB29, 0, 0)
+#define PIN_PB29__SDMMC1_CD		PINMUX_PIN(PIN_PB29, 1, 1)
+#define PIN_PB29__I2SMCC0_MCK		PINMUX_PIN(PIN_PB29, 2, 1)
+#define PIN_PB29__FLEXCOM1_IO1		PINMUX_PIN(PIN_PB29, 3, 3)
+#define PIN_PB29__D14			PINMUX_PIN(PIN_PB29, 5, 2)
+
+#define PIN_PB30			62
+#define PIN_PB30__GPIO			PINMUX_PIN(PIN_PB30, 0, 0)
+#define PIN_PB30__SDMMC1_1V8SEL		PINMUX_PIN(PIN_PB30, 1, 1)
+#define PIN_PB30__I2SMCC1_MCK		PINMUX_PIN(PIN_PB30, 2, 2)
+#define PIN_PB30__FLEXCOM1_IO2		PINMUX_PIN(PIN_PB30, 3, 3)
+#define PIN_PB30__TIOA1			PINMUX_PIN(PIN_PB30, 4, 1)
+#define PIN_PB30__NCS1			PINMUX_PIN(PIN_PB30, 5, 1)
+
+#define PIN_PB31			63
+#define PIN_PB31__GPIO			PINMUX_PIN(PIN_PB31, 0, 0)
+#define PIN_PB31__PCK7			PINMUX_PIN(PIN_PB31, 1, 2)
+#define PIN_PB31__I2SMCC1_DIN1		PINMUX_PIN(PIN_PB31, 2, 1)
+#define PIN_PB31__FLEXCOM1_IO3		PINMUX_PIN(PIN_PB31, 3, 3)
+#define PIN_PB31__TCLK1			PINMUX_PIN(PIN_PB31, 4, 1)
+#define PIN_PB31__NWE			PINMUX_PIN(PIN_PB31, 5, 2)
+
+#define PIN_PC0				64
+#define PIN_PC0__GPIO			PINMUX_PIN(PIN_PC0, 0, 0)
+#define PIN_PC0__PCK6			PINMUX_PIN(PIN_PC0, 1, 2)
+#define PIN_PC0__I2SMCC1_DIN2		PINMUX_PIN(PIN_PC0, 2, 1)
+#define PIN_PC0__FLEXCOM9_IO4		PINMUX_PIN(PIN_PC0, 3, 2)
+#define PIN_PC0__TIOB1			PINMUX_PIN(PIN_PC0, 4, 1)
+#define PIN_PC0__NWR1			PINMUX_PIN(PIN_PC0, 5, 1)
+
+#define PIN_PC1				65
+#define PIN_PC1__GPIO			PINMUX_PIN(PIN_PC1, 0, 0)
+#define PIN_PC1__PCK5			PINMUX_PIN(PIN_PC1, 1, 1)
+#define PIN_PC1__FLEXCOM9_IO2		PINMUX_PIN(PIN_PC1, 3, 2)
+#define PIN_PC1__SMCK			PINMUX_PIN(PIN_PC1, 5, 1)
+
+#define PIN_PC2				66
+#define PIN_PC2__GPIO			PINMUX_PIN(PIN_PC2, 0, 0)
+#define PIN_PC2__EXT_IRQ0		PINMUX_PIN(PIN_PC2, 1, 3)
+#define PIN_PC2__FLEXCOM9_IO3		PINMUX_PIN(PIN_PC2, 3, 2)
+#define PIN_PC2__A11			PINMUX_PIN(PIN_PC2, 5, 1)
+
+#define PIN_PC3				67
+#define PIN_PC3__GPIO			PINMUX_PIN(PIN_PC3, 0, 0)
+#define PIN_PC3__SPDIF_RX		PINMUX_PIN(PIN_PC3, 1, 2)
+#define PIN_PC3__FLEXCOM9_IO0		PINMUX_PIN(PIN_PC3, 3, 2)
+#define PIN_PC3__FLEXCOM0_IO4		PINMUX_PIN(PIN_PC3, 4, 2)
+#define PIN_PC3__A10			PINMUX_PIN(PIN_PC3, 5, 1)
+
+#define PIN_PC4				68
+#define PIN_PC4__GPIO			PINMUX_PIN(PIN_PC4, 0, 0)
+#define PIN_PC4__SPDIF_TX		PINMUX_PIN(PIN_PC4, 1, 2)
+#define PIN_PC4__FLEXCOM9_IO1		PINMUX_PIN(PIN_PC4, 3, 2)
+#define PIN_PC4__FLEXCOM0_IO3		PINMUX_PIN(PIN_PC4, 4, 2)
+#define PIN_PC4__D0			PINMUX_PIN(PIN_PC4, 5, 2)
+
+#define PIN_PC5				69
+#define PIN_PC5__GPIO			PINMUX_PIN(PIN_PC5, 0, 0)
+#define PIN_PC5__I3CC_SDASPUE		PINMUX_PIN(PIN_PC5, 1, 1)
+#define PIN_PC5__I2SMCC1_DIN3		PINMUX_PIN(PIN_PC5, 2, 1)
+#define PIN_PC5__FLEXCOM0_IO2		PINMUX_PIN(PIN_PC5, 4, 2)
+#define PIN_PC5__D1			PINMUX_PIN(PIN_PC5, 5, 2)
+
+#define PIN_PC6				70
+#define PIN_PC6__GPIO			PINMUX_PIN(PIN_PC6, 0, 0)
+#define PIN_PC6__I3CC_SCL		PINMUX_PIN(PIN_PC6, 1, 1)
+#define PIN_PC6__FLEXCOM0_IO1		PINMUX_PIN(PIN_PC6, 4, 2)
+#define PIN_PC6__D4			PINMUX_PIN(PIN_PC6, 5, 2)
+
+#define PIN_PC7				71
+#define PIN_PC7__GPIO			PINMUX_PIN(PIN_PC7, 0, 0)
+#define PIN_PC7__I3CC_SDA		PINMUX_PIN(PIN_PC7, 1, 1)
+#define PIN_PC7__FLEXCOM0_IO0		PINMUX_PIN(PIN_PC7, 4, 2)
+#define PIN_PC7__D5			PINMUX_PIN(PIN_PC7, 5, 2)
+
+#define PIN_PC8				72
+#define PIN_PC8__GPIO			PINMUX_PIN(PIN_PC8, 0, 0)
+#define PIN_PC8__I2SMCC0_DIN1		PINMUX_PIN(PIN_PC8, 1, 1)
+#define PIN_PC8__PDMC0_DS1		PINMUX_PIN(PIN_PC8, 2, 2)
+#define PIN_PC8__I2SMCC1_DOUT1		PINMUX_PIN(PIN_PC8, 3, 1)
+#define PIN_PC8__FLEXCOM9_IO0		PINMUX_PIN(PIN_PC8, 4, 1)
+#define PIN_PC8__D6			PINMUX_PIN(PIN_PC8, 5, 2)
+
+#define PIN_PC9				73
+#define PIN_PC9__GPIO			PINMUX_PIN(PIN_PC9, 0, 0)
+#define PIN_PC9__I2SMCC0_DIN2		PINMUX_PIN(PIN_PC9, 1, 1)
+#define PIN_PC9__PDMC0_CLK		PINMUX_PIN(PIN_PC9, 2, 2)
+#define PIN_PC9__I2SMCC1_DOUT2		PINMUX_PIN(PIN_PC9, 3, 1)
+#define PIN_PC9__FLEXCOM9_IO1		PINMUX_PIN(PIN_PC9, 4, 1)
+#define PIN_PC9__D7			PINMUX_PIN(PIN_PC9, 5, 2)
+
+#define PIN_PC10			74
+#define PIN_PC10__GPIO			PINMUX_PIN(PIN_PC10, 0, 0)
+#define PIN_PC10__I2SMCC0_DIN3		PINMUX_PIN(PIN_PC10, 1, 1)
+#define PIN_PC10__PDMC0_DS0		PINMUX_PIN(PIN_PC10, 2, 2)
+#define PIN_PC10__I2SMCC1_DOUT3		PINMUX_PIN(PIN_PC10, 3, 1)
+#define PIN_PC10__FLEXCOM9_IO2		PINMUX_PIN(PIN_PC10, 4, 1)
+#define PIN_PC10__D2			PINMUX_PIN(PIN_PC10, 5, 2)
+
+#define PIN_PC11			75
+#define PIN_PC11__GPIO			PINMUX_PIN(PIN_PC11, 0, 0)
+#define PIN_PC11__I2SMCC0_DOUT1		PINMUX_PIN(PIN_PC11, 1, 1)
+#define PIN_PC11__PDMC1_DS0		PINMUX_PIN(PIN_PC11, 2, 1)
+#define PIN_PC11__FLEXCOM9_IO3		PINMUX_PIN(PIN_PC11, 4, 1)
+#define PIN_PC10__D3			PINMUX_PIN(PIN_PC10, 5, 2)
+
+#define PIN_PC12			76
+#define PIN_PC12__GPIO			PINMUX_PIN(PIN_PC12, 0, 0)
+#define PIN_PC12__I2SMCC0_DOUT2		PINMUX_PIN(PIN_PC12, 1, 1)
+#define PIN_PC12__PDMC1_CLK		PINMUX_PIN(PIN_PC12, 2, 1)
+#define PIN_PC12__FLEXCOM9_IO4		PINMUX_PIN(PIN_PC12, 4, 1)
+#define PIN_PC12__A9			PINMUX_PIN(PIN_PC12, 5, 1)
+
+#define PIN_PC13			77
+#define PIN_PC13__GPIO			PINMUX_PIN(PIN_PC13, 0, 0)
+#define PIN_PC13__I2SMCC0_DOUT3		PINMUX_PIN(PIN_PC13, 1, 1)
+#define PIN_PC13__PDMC1_DS1		PINMUX_PIN(PIN_PC13, 2, 1)
+#define PIN_PC13__A8			PINMUX_PIN(PIN_PC13, 5, 1)
+
+#define PIN_PC14			78
+#define PIN_PC14__GPIO			PINMUX_PIN(PIN_PC14, 0, 0)
+#define PIN_PC14__I2SMCC1_DIN0		PINMUX_PIN(PIN_PC14, 1, 1)
+#define PIN_PC14__SPDIF_RX		PINMUX_PIN(PIN_PC14, 2, 3)
+#define PIN_PC14__FLEXCOM1_IO0		PINMUX_PIN(PIN_PC14, 3, 2)
+#define PIN_PC14__A7			PINMUX_PIN(PIN_PC14, 5, 1)
+
+#define PIN_PC15			79
+#define PIN_PC15__GPIO			PINMUX_PIN(PIN_PC15, 0, 0)
+#define PIN_PC15__I2SMCC1_WS		PINMUX_PIN(PIN_PC15, 1, 1)
+#define PIN_PC15__PDMC1_DS1		PINMUX_PIN(PIN_PC15, 2, 2)
+#define PIN_PC15__FLEXCOM1_IO1		PINMUX_PIN(PIN_PC15, 3, 2)
+#define PIN_PC15__A6			PINMUX_PIN(PIN_PC15, 5, 1)
+
+#define PIN_PC16			80
+#define PIN_PC16__GPIO			PINMUX_PIN(PIN_PC16, 0, 0)
+#define PIN_PC16__I2SMCC1_CK		PINMUX_PIN(PIN_PC16, 1, 1)
+#define PIN_PC16__PDMC1_CLK		PINMUX_PIN(PIN_PC16, 2, 2)
+#define PIN_PC16__FLEXCOM1_IO2		PINMUX_PIN(PIN_PC16, 3, 2)
+#define PIN_PC16__TIOA1			PINMUX_PIN(PIN_PC16, 4, 2)
+#define PIN_PC16__A5			PINMUX_PIN(PIN_PC16, 5, 1)
+
+#define PIN_PC17			81
+#define PIN_PC17__GPIO			PINMUX_PIN(PIN_PC17, 0, 0)
+#define PIN_PC17__I2SMCC1_DOUT0		PINMUX_PIN(PIN_PC17, 1, 1)
+#define PIN_PC17__PDMC1_DS0		PINMUX_PIN(PIN_PC17, 2, 2)
+#define PIN_PC17__FLEXCOM1_IO3		PINMUX_PIN(PIN_PC17, 3, 2)
+#define PIN_PC17__TCLK1			PINMUX_PIN(PIN_PC17, 4, 2)
+#define PIN_PC17__A4			PINMUX_PIN(PIN_PC17, 5, 1)
+
+#define PIN_PC18			82
+#define PIN_PC18__GPIO			PINMUX_PIN(PIN_PC18, 0, 0)
+#define PIN_PC18__I2SMCC0_DIN0		PINMUX_PIN(PIN_PC18, 1, 1)
+#define PIN_PC18__SPDIF_TX		PINMUX_PIN(PIN_PC18, 2, 3)
+#define PIN_PC18__FLEXCOM1_IO4		PINMUX_PIN(PIN_PC18, 3, 2)
+#define PIN_PC18__TIOB1			PINMUX_PIN(PIN_PC18, 4, 2)
+#define PIN_PC18__A3			PINMUX_PIN(PIN_PC18, 5, 1)
+
+#define PIN_PC19			83
+#define PIN_PC19__GPIO			PINMUX_PIN(PIN_PC19, 0, 0)
+#define PIN_PC19__I2SMCC0_WS		PINMUX_PIN(PIN_PC19, 1, 1)
+#define PIN_PC19__PCK6			PINMUX_PIN(PIN_PC19, 2, 1)
+#define PIN_PC19__A2			PINMUX_PIN(PIN_PC19, 5, 1)
+
+#define PIN_PC20			84
+#define PIN_PC20__GPIO			PINMUX_PIN(PIN_PC20, 0, 0)
+#define PIN_PC20__I2SMCC0_DOUT0		PINMUX_PIN(PIN_PC20, 1, 1)
+#define PIN_PC20__A1			PINMUX_PIN(PIN_PC20, 5, 1)
+
+#define PIN_PC21			85
+#define PIN_PC21__GPIO			PINMUX_PIN(PIN_PC21, 0, 0)
+#define PIN_PC21__I2SMCC0_CK		PINMUX_PIN(PIN_PC21, 1, 1)
+#define PIN_PC21__PCK7			PINMUX_PIN(PIN_PC21, 2, 1)
+#define PIN_PC21__A0			PINMUX_PIN(PIN_PC21, 5, 1)
+
+#define PIN_PC22			86
+#define PIN_PC22__GPIO			PINMUX_PIN(PIN_PC22, 0, 0)
+#define PIN_PC22__NTRST			PINMUX_PIN(PIN_PC22, 1, 1)
+#define PIN_PC22__NWAIT			PINMUX_PIN(PIN_PC22, 5, 1)
+
+#define PIN_PC23			87
+#define PIN_PC23__GPIO			PINMUX_PIN(PIN_PC23, 0, 0)
+#define PIN_PC23__TCK_SWCLK		PINMUX_PIN(PIN_PC23, 1, 1)
+
+#define PIN_PC24			88
+#define PIN_PC24__GPIO			PINMUX_PIN(PIN_PC24, 0, 0)
+#define PIN_PC24__TMS_SWDIO		PINMUX_PIN(PIN_PC24, 1, 1)
+
+#define PIN_PC25			89
+#define PIN_PC25__GPIO			PINMUX_PIN(PIN_PC25, 0, 0)
+#define PIN_PC25__TDI			PINMUX_PIN(PIN_PC25, 1, 1)
+
+#define PIN_PC26			90
+#define PIN_PC26__GPIO			PINMUX_PIN(PIN_PC26, 0, 0)
+#define PIN_PC26__TDO			PINMUX_PIN(PIN_PC26, 1, 1)
+#define PIN_PC26__A15			PINMUX_PIN(PIN_PC26, 5, 1)
+
+#define PIN_PC27			91
+#define PIN_PC27__GPIO			PINMUX_PIN(PIN_PC27, 0, 0)
+#define PIN_PC27__SDMMC2_CMD		PINMUX_PIN(PIN_PC27, 1, 1)
+#define PIN_PC27__FLEXCOM8_IO0		PINMUX_PIN(PIN_PC27, 2, 2)
+#define PIN_PC27__TD1			PINMUX_PIN(PIN_PC27, 4, 2)
+#define PIN_PC27__D8			PINMUX_PIN(PIN_PC27, 5, 1)
+
+#define PIN_PC28			92
+#define PIN_PC28__GPIO			PINMUX_PIN(PIN_PC28, 0, 0)
+#define PIN_PC28__SDMMC2_CK		PINMUX_PIN(PIN_PC28, 1, 1)
+#define PIN_PC28__FLEXCOM8_IO1		PINMUX_PIN(PIN_PC28, 2, 2)
+#define PIN_PC28__TF1			PINMUX_PIN(PIN_PC28, 4, 2)
+#define PIN_PC28__D9			PINMUX_PIN(PIN_PC28, 5, 1)
+
+#define PIN_PC29			93
+#define PIN_PC29__GPIO			PINMUX_PIN(PIN_PC29, 0, 0)
+#define PIN_PC29__SDMMC2_DAT0		PINMUX_PIN(PIN_PC29, 1, 1)
+#define PIN_PC29__FLEXCOM8_IO2		PINMUX_PIN(PIN_PC29, 2, 2)
+#define PIN_PC29__TK1			PINMUX_PIN(PIN_PC29, 4, 2)
+#define PIN_PC29__D10			PINMUX_PIN(PIN_PC29, 5, 1)
+#define PIN_PC29__TCLK0			PINMUX_PIN(PIN_PC29, 6, 1)
+
+#define PIN_PC30			94
+#define PIN_PC30__GPIO			PINMUX_PIN(PIN_PC30, 0, 0)
+#define PIN_PC30__SDMMC2_DAT1		PINMUX_PIN(PIN_PC30, 1, 1)
+#define PIN_PC30__FLEXCOM8_IO3		PINMUX_PIN(PIN_PC30, 2, 2)
+#define PIN_PC30__RD1			PINMUX_PIN(PIN_PC30, 4, 2)
+#define PIN_PC30__D11			PINMUX_PIN(PIN_PC30, 5, 1)
+#define PIN_PC30__TIOA0			PINMUX_PIN(PIN_PC30, 6, 1)
+
+#define PIN_PC31			95
+#define PIN_PC31__GPIO			PINMUX_PIN(PIN_PC31, 0, 0)
+#define PIN_PC31__SDMMC2_DAT2		PINMUX_PIN(PIN_PC31, 1, 1)
+#define PIN_PC31__FLEXCOM8_IO4		PINMUX_PIN(PIN_PC31, 2, 2)
+#define PIN_PC31__PCK0			PINMUX_PIN(PIN_PC31, 3, 2)
+#define PIN_PC31__RK1			PINMUX_PIN(PIN_PC31, 4, 2)
+#define PIN_PC31__D12			PINMUX_PIN(PIN_PC31, 5, 1)
+#define PIN_PC31__TIOB0			PINMUX_PIN(PIN_PC31, 6, 1)
+
+#define PIN_PD0				96
+#define PIN_PD0__GPIO			PINMUX_PIN(PIN_PD0, 0, 0)
+#define PIN_PD0__SDMMC2_DAT3		PINMUX_PIN(PIN_PD0, 1, 1)
+#define PIN_PD0__PCK1			PINMUX_PIN(PIN_PD0, 3, 2)
+#define PIN_PD0__RF1			PINMUX_PIN(PIN_PD0, 4, 2)
+#define PIN_PD0__D13			PINMUX_PIN(PIN_PD0, 5, 1)
+
+#define PIN_PD1				97
+#define PIN_PD1__GPIO			PINMUX_PIN(PIN_PD1, 0, 0)
+#define PIN_PD1__SDMMC2_WP		PINMUX_PIN(PIN_PD1, 1, 1)
+#define PIN_PD1__FLEXCOM1_IO5		PINMUX_PIN(PIN_PD1, 2, 1)
+#define PIN_PD1__LCDC_HSYNC		PINMUX_PIN(PIN_PD1, 3, 2)
+#define PIN_PD1__FLEXCOM3_IO0		PINMUX_PIN(PIN_PD1, 4, 3)
+
+#define PIN_PD2				98
+#define PIN_PD2__GPIO			PINMUX_PIN(PIN_PD2, 0, 0)
+#define PIN_PD2__SDMMC2_CD		PINMUX_PIN(PIN_PD2, 1, 1)
+#define PIN_PD2__FLEXCOM1_IO6		PINMUX_PIN(PIN_PD2, 2, 1)
+#define PIN_PD2__LCDC_VSYNC		PINMUX_PIN(PIN_PD2, 3, 2)
+#define PIN_PD2__FLEXCOM3_IO1		PINMUX_PIN(PIN_PD2, 4, 3)
+
+#define PIN_PD3				99
+#define PIN_PD3__GPIO			PINMUX_PIN(PIN_PD3, 0, 0)
+#define PIN_PD3__SDMMC2_1V8SEL		PINMUX_PIN(PIN_PD3, 1, 1)
+#define PIN_PD3__FLEXCOM1_IO4		PINMUX_PIN(PIN_PD3, 2, 1)
+#define PIN_PD3__TIOA0			PINMUX_PIN(PIN_PD3, 3, 2)
+#define PIN_PD3__FLEXCOM3_IO2		PINMUX_PIN(PIN_PD3, 4, 3)
+#define PIN_PD3__EXT_IRQ1		PINMUX_PIN(PIN_PD3, 5, 3)
+
+#define PIN_PD4				100
+#define PIN_PD4__GPIO			PINMUX_PIN(PIN_PD4, 0, 0)
+#define PIN_PD4__LCDC_HSYNC		PINMUX_PIN(PIN_PD4, 1, 1)
+#define PIN_PD4__FLEXCOM1_IO2		PINMUX_PIN(PIN_PD4, 2, 1)
+#define PIN_PD4__TIOB0			PINMUX_PIN(PIN_PD4, 3, 2)
+#define PIN_PD4__FLEXCOM7_IO1		PINMUX_PIN(PIN_PD4, 4, 3)
+
+#define PIN_PD5				101
+#define PIN_PD5__GPIO			PINMUX_PIN(PIN_PD5, 0, 0)
+#define PIN_PD5__LCDC_VSYNC		PINMUX_PIN(PIN_PD5, 1, 1)
+#define PIN_PD5__FLEXCOM1_IO3		PINMUX_PIN(PIN_PD5, 2, 1)
+#define PIN_PD5__TCLK0			PINMUX_PIN(PIN_PD5, 3, 2)
+#define PIN_PD5__FLEXCOM7_IO0		PINMUX_PIN(PIN_PD5, 4, 3)
+
+#define PIN_PD6				102
+#define PIN_PD6__GPIO			PINMUX_PIN(PIN_PD6, 0, 0)
+#define PIN_PD6__LCDC_PWM		PINMUX_PIN(PIN_PD6, 1, 1)
+#define PIN_PD6__FLEXCOM1_IO1		PINMUX_PIN(PIN_PD6, 2, 1)
+#define PIN_PD6__FLEXCOM7_IO2		PINMUX_PIN(PIN_PD6, 4, 3)
+
+#define PIN_PD7				103
+#define PIN_PD7__GPIO			PINMUX_PIN(PIN_PD7, 0, 0)
+#define PIN_PD7__LCDC_DISP		PINMUX_PIN(PIN_PD7, 1, 1)
+#define PIN_PD7__FLEXCOM1_IO0		PINMUX_PIN(PIN_PD7, 2, 1)
+#define PIN_PD7__FLEXCOM7_IO3		PINMUX_PIN(PIN_PD7, 4, 3)
+
+#define PIN_PD8				104
+#define PIN_PD8__GPIO			PINMUX_PIN(PIN_PD8, 0, 0)
+#define PIN_PD8__CANTX0			PINMUX_PIN(PIN_PD8, 1, 1)
+#define PIN_PD8__FLEXCOM7_IO0		PINMUX_PIN(PIN_PD8, 2, 1)
+
+#define PIN_PD9				105
+#define PIN_PD9__GPIO			PINMUX_PIN(PIN_PD9, 0, 0)
+#define PIN_PD9__CANRX0			PINMUX_PIN(PIN_PD9, 1, 1)
+#define PIN_PD9__FLEXCOM7_IO1		PINMUX_PIN(PIN_PD9, 2, 1)
+
+#define PIN_PD10			106
+#define PIN_PD10__GPIO			PINMUX_PIN(PIN_PD10, 0, 0)
+#define PIN_PD10__CANTX1		PINMUX_PIN(PIN_PD10, 1, 1)
+#define PIN_PD10__FLEXCOM7_IO2		PINMUX_PIN(PIN_PD10, 2, 1)
+#define PIN_PD10__TIOA1			PINMUX_PIN(PIN_PD10, 3, 3)
+
+#define PIN_PD11			107
+#define PIN_PD11__GPIO			PINMUX_PIN(PIN_PD11, 0, 0)
+#define PIN_PD11__CANRX1		PINMUX_PIN(PIN_PD11, 1, 1)
+#define PIN_PD11__FLEXCOM7_IO3		PINMUX_PIN(PIN_PD11, 2, 1)
+#define PIN_PD11__TCLK1			PINMUX_PIN(PIN_PD11, 3, 3)
+
+#define PIN_PD12			108
+#define PIN_PD12__GPIO			PINMUX_PIN(PIN_PD12, 0, 0)
+#define PIN_PD12__CANTX2		PINMUX_PIN(PIN_PD12, 1, 1)
+#define PIN_PD12__FLEXCOM7_IO4		PINMUX_PIN(PIN_PD12, 2, 1)
+#define PIN_PD12__TIOB1			PINMUX_PIN(PIN_PD12, 3, 3)
+#define PIN_PD12__PCK2			PINMUX_PIN(PIN_PD12, 4, 2)
+#define PIN_PD12__FLEXCOM3_IO3		PINMUX_PIN(PIN_PD12, 5, 3)
+
+#define PIN_PD13			109
+#define PIN_PD13__GPIO			PINMUX_PIN(PIN_PD13, 0, 0)
+#define PIN_PD13__CANRX2		PINMUX_PIN(PIN_PD13, 1, 1)
+#define PIN_PD13__FLEXCOM5_IO4		PINMUX_PIN(PIN_PD13, 2, 1)
+#define PIN_PD13__TIOA2			PINMUX_PIN(PIN_PD13, 3, 3)
+#define PIN_PD13__PCK3			PINMUX_PIN(PIN_PD13, 4, 2)
+
+#define PIN_PD14			110
+#define PIN_PD14__GPIO			PINMUX_PIN(PIN_PD14, 0, 0)
+#define PIN_PD14__CANTX3		PINMUX_PIN(PIN_PD14, 1, 1)
+#define PIN_PD14__FLEXCOM5_IO2		PINMUX_PIN(PIN_PD14, 2, 1)
+#define PIN_PD14__TIOB2			PINMUX_PIN(PIN_PD14, 3, 3)
+
+#define PIN_PD15			111
+#define PIN_PD15__GPIO			PINMUX_PIN(PIN_PD15, 0, 0)
+#define PIN_PD15__CANRX3		PINMUX_PIN(PIN_PD15, 1, 1)
+#define PIN_PD15__FLEXCOM5_IO3		PINMUX_PIN(PIN_PD15, 2, 1)
+#define PIN_PD15__TCLK2			PINMUX_PIN(PIN_PD15, 3, 3)
+
+#define PIN_PD16			112
+#define PIN_PD16__GPIO			PINMUX_PIN(PIN_PD16, 0, 0)
+#define PIN_PD16__CANTX4		PINMUX_PIN(PIN_PD16, 1, 1)
+#define PIN_PD16__FLEXCOM5_IO0		PINMUX_PIN(PIN_PD16, 2, 1)
+
+#define PIN_PD17			113
+#define PIN_PD17__GPIO			PINMUX_PIN(PIN_PD17, 0, 0)
+#define PIN_PD17__CANRX4		PINMUX_PIN(PIN_PD17, 1, 1)
+#define PIN_PD17__FLEXCOM5_IO1		PINMUX_PIN(PIN_PD17, 2, 1)
+
+#define PIN_PD18			114
+#define PIN_PD18__GPIO			PINMUX_PIN(PIN_PD18, 0, 0)
+#define PIN_PD18__FLEXCOM6_IO0		PINMUX_PIN(PIN_PD18, 2, 4)
+#define PIN_PD18__CANTX1		PINMUX_PIN(PIN_PD18, 3, 2)
+#define PIN_PD18__PCK4			PINMUX_PIN(PIN_PD18, 4, 2)
+
+#define PIN_PD19			115
+#define PIN_PD19__GPIO			PINMUX_PIN(PIN_PD19, 0, 0)
+#define PIN_PD19__FLEXCOM6_IO1		PINMUX_PIN(PIN_PD19, 2, 4)
+#define PIN_PD19__CANRX1		PINMUX_PIN(PIN_PD19, 3, 2)
+#define PIN_PD19__PCK2			PINMUX_PIN(PIN_PD19, 4, 3)
+
+#define PIN_PD20			116
+#define PIN_PD20__GPIO			PINMUX_PIN(PIN_PD20, 0, 0)
+#define PIN_PD20__PFLEXCOM6_IO2		PINMUX_PIN(PIN_PD20, 2, 4)
+#define PIN_PD20__I2SMCC1_MCK		PINMUX_PIN(PIN_PD20, 3, 2)
+#define PIN_PD20__PCK3			PINMUX_PIN(PIN_PD20, 4, 3)
+
+#define PIN_PD21			117
+#define PIN_PD21__GPIO			PINMUX_PIN(PIN_PD21, 0, 0)
+#define PIN_PD21__G1_TXCTL		PINMUX_PIN(PIN_PD21, 1, 2)
+#define PIN_PD21__FLEXCOM6_IO2		PINMUX_PIN(PIN_PD21, 2, 3)
+#define PIN_PD21__TK1			PINMUX_PIN(PIN_PD21, 3, 1)
+
+#define PIN_PD22			118
+#define PIN_PD22__GPIO			PINMUX_PIN(PIN_PD22, 0, 0)
+#define PIN_PD22__G1_TX0		PINMUX_PIN(PIN_PD22, 1, 1)
+#define PIN_PD22__FLEXCOM6_IO3		PINMUX_PIN(PIN_PD22, 2, 3)
+#define PIN_PD22__TF1			PINMUX_PIN(PIN_PD22, 3, 1)
+
+#define PIN_PD23			119
+#define PIN_PD23__GPIO			PINMUX_PIN(PIN_PD23, 0, 0)
+#define PIN_PD23__G1_TX1		PINMUX_PIN(PIN_PD23, 1, 1)
+#define PIN_PD23__FLEXCOM6_IO4		PINMUX_PIN(PIN_PD23, 2, 3)
+#define PIN_PD23__TD1			PINMUX_PIN(PIN_PD23, 3, 1)
+
+#define PIN_PD24			120
+#define PIN_PD24__GPIO			PINMUX_PIN(PIN_PD24, 0, 0)
+#define PIN_PD24__G1_RXCTL		PINMUX_PIN(PIN_PD24, 1, 1)
+#define PIN_PD24__FLEXCOM6_IO0		PINMUX_PIN(PIN_PD24, 2, 3)
+#define PIN_PD24__RD1			PINMUX_PIN(PIN_PD24, 3, 1)
+#define PIN_PD24__PDMC0_DS1		PINMUX_PIN(PIN_PD24, 5, 3)
+
+#define PIN_PD25			121
+#define PIN_PD25__GPIO			PINMUX_PIN(PIN_PD25, 0, 0)
+#define PIN_PD25__G1_MDC		PINMUX_PIN(PIN_PD25, 1, 1)
+#define PIN_PD25__FLEXCOM6_IO1		PINMUX_PIN(PIN_PD25, 2, 3)
+#define PIN_PD25__RK1			PINMUX_PIN(PIN_PD25, 3, 1)
+#define PIN_PD25__PDMC0_CLK		PINMUX_PIN(PIN_PD25, 5, 3)
+
+#define PIN_PD26			122
+#define PIN_PD26__GPIO			PINMUX_PIN(PIN_PD26, 0, 0)
+#define PIN_PD26__G1_MDIO		PINMUX_PIN(PIN_PD26, 1, 1)
+#define PIN_PD26__FLEXCOM7_IO4		PINMUX_PIN(PIN_PD26, 2, 2)
+#define PIN_PD26__RF1			PINMUX_PIN(PIN_PD26, 3, 1)
+#define PIN_PD26__I2SMCC1_DIN2		PINMUX_PIN(PIN_PD26, 4, 2)
+#define PIN_PD26__PDMC0_DS0		PINMUX_PIN(PIN_PD26, 5, 3)
+
+#define PIN_PD27			123
+#define PIN_PD27__GPIO			PINMUX_PIN(PIN_PD27, 0, 0)
+#define PIN_PD27__G1_RX0		PINMUX_PIN(PIN_PD27, 1, 1)
+#define PIN_PD27__FLEXCOM7_IO0		PINMUX_PIN(PIN_PD27, 2, 2)
+#define PIN_PD27__SPDIF_RX		PINMUX_PIN(PIN_PD27, 3, 1)
+#define PIN_PD27__I2SMCC1_DIN3		PINMUX_PIN(PIN_PD27, 4, 2)
+
+#define PIN_PD28			124
+#define PIN_PD28__GPIO			PINMUX_PIN(PIN_PD28, 0, 0)
+#define PIN_PD28__G1_RX1		PINMUX_PIN(PIN_PD28, 1, 1)
+#define PIN_PD28__FLEXCOM7_IO1		PINMUX_PIN(PIN_PD28, 2, 2)
+#define PIN_PD28__SPDIF_TX		PINMUX_PIN(PIN_PD28, 3, 1)
+#define PIN_PD28__I2SMCC1_DIN1		PINMUX_PIN(PIN_PD28, 4, 2)
+
+#define PIN_PD29			125
+#define PIN_PD29__GPIO			PINMUX_PIN(PIN_PD29, 0, 0)
+#define PIN_PD29__G1_REFCK		PINMUX_PIN(PIN_PD29, 1, 2)
+#define PIN_PD29__FLEXCOM7_IO2		PINMUX_PIN(PIN_PD29, 2, 2)
+#define PIN_PD29__I2SMCC1_DOUT3		PINMUX_PIN(PIN_PD29, 3, 2)
+
+#define PIN_PD30			126
+#define PIN_PD30__GPIO			PINMUX_PIN(PIN_PD30, 0, 0)
+#define PIN_PD30__G1_RX2		PINMUX_PIN(PIN_PD30, 1, 1)
+#define PIN_PD30__FLEXCOM7_IO3		PINMUX_PIN(PIN_PD30, 2, 2)
+#define PIN_PD30__I2SMCC1_DOUT1		PINMUX_PIN(PIN_PD30, 3, 2)
+#define PIN_PD30__PDMC1_DS1		PINMUX_PIN(PIN_PD30, 4, 3)
+#define PIN_PD30__G1_RXER		PINMUX_PIN(PIN_PD30, 5, 2)
+
+#define PIN_PD31			127
+#define PIN_PD31__GPIO			PINMUX_PIN(PIN_PD31, 0, 0)
+#define PIN_PD31__G1_RX3		PINMUX_PIN(PIN_PD31, 1, 1)
+#define PIN_PD31__FLEXCOM5_IO4		PINMUX_PIN(PIN_PD31, 2, 2)
+#define PIN_PD31__I2SMCC1_DOUT2		PINMUX_PIN(PIN_PD31, 3, 3)
+#define PIN_PD31__PDMC1_DS0		PINMUX_PIN(PIN_PD31, 4, 3)
+
+#define PIN_PE0				128
+#define PIN_PE0__GPIO			PINMUX_PIN(PIN_PE0, 0, 0)
+#define PIN_PE0__G1_TX2			PINMUX_PIN(PIN_PE0, 1, 1)
+#define PIN_PE0__FLEXCOM5_IO2		PINMUX_PIN(PIN_PE0, 2, 2)
+#define PIN_PE0__I2SMCC1_DIN0		PINMUX_PIN(PIN_PE0, 3, 2)
+#define PIN_PE0__PDMC1_CLK		PINMUX_PIN(PIN_PE0, 4, 3)
+
+#define PIN_PE1				129
+#define PIN_PE1__GPIO			PINMUX_PIN(PIN_PE1, 0, 0)
+#define PIN_PE1__G1_TX3			PINMUX_PIN(PIN_PE1, 1, 1)
+#define PIN_PE1__FLEXCOM5_IO3		PINMUX_PIN(PIN_PE1, 2, 2)
+#define PIN_PE1__I2SMCC1_WS		PINMUX_PIN(PIN_PE1, 3, 2)
+#define PIN_PE1__PDMC0_DS1		PINMUX_PIN(PIN_PE1, 4, 4)
+
+#define PIN_PE2				130
+#define PIN_PE2__GPIO			PINMUX_PIN(PIN_PE2, 0, 0)
+#define PIN_PE2__G1_RXCK		PINMUX_PIN(PIN_PE2, 1, 1)
+#define PIN_PE2__FLEXCOM5_IO1		PINMUX_PIN(PIN_PE2, 2, 2)
+#define PIN_PE2__I2SMCC1_CK		PINMUX_PIN(PIN_PE2, 3, 2)
+#define PIN_PE2__PDMC0_CLK		PINMUX_PIN(PIN_PE2, 4, 4)
+
+#define PIN_PE3				131
+#define PIN_PE3__GPIO			PINMUX_PIN(PIN_PE3, 0, 0)
+#define PIN_PE3__G1_TSUCOMP		PINMUX_PIN(PIN_PE3, 1, 1)
+#define PIN_PE3__FLEXCOM5_IO0		PINMUX_PIN(PIN_PE3, 2, 2)
+#define PIN_PE3__I2SMCC1_DOUT0		PINMUX_PIN(PIN_PE3, 3, 2)
+#define PIN_PE3__PDMC0_DS0		PINMUX_PIN(PIN_PE3, 4, 4)
+
+#define PIN_PE4				132
+#define PIN_PE4__GPIO			PINMUX_PIN(PIN_PE4, 0, 0)
+#define PIN_PE4__LCDC_DAT0		PINMUX_PIN(PIN_PE4, 1, 1)
+#define PIN_PE4__FLEXCOM2_IO2		PINMUX_PIN(PIN_PE4, 2, 1)
+#define PIN_PE4__PWML0			PINMUX_PIN(PIN_PE4, 3, 2)
+#define PIN_PE4__TIOA3			PINMUX_PIN(PIN_PE4, 4, 1)
+#define PIN_PE4__I2SMCC0_DIN1		PINMUX_PIN(PIN_PE4, 5, 2)
+
+#define PIN_PE5				133
+#define PIN_PE5__GPIO			PINMUX_PIN(PIN_PE5, 0, 0)
+#define PIN_PE5__LCDC_DAT1		PINMUX_PIN(PIN_PE5, 1, 1)
+#define PIN_PE5__FLEXCOM2_IO3		PINMUX_PIN(PIN_PE5, 2, 1)
+#define PIN_PE5__PWMH0			PINMUX_PIN(PIN_PE5, 3, 2)
+#define PIN_PE5__TIOB3			PINMUX_PIN(PIN_PE5, 4, 1)
+#define PIN_PE5__I2SMCC0_DIN2		PINMUX_PIN(PIN_PE5, 5, 2)
+
+#define PIN_PE6				134
+#define PIN_PE6__GPIO			PINMUX_PIN(PIN_PE6, 0, 0)
+#define PIN_PE6__LCDC_DAT2		PINMUX_PIN(PIN_PE6, 1, 1)
+#define PIN_PE6__FLEXCOM2_IO4		PINMUX_PIN(PIN_PE6, 2, 1)
+#define PIN_PE6__PWML1			PINMUX_PIN(PIN_PE6, 3, 2)
+#define PIN_PE6__TCLK3			PINMUX_PIN(PIN_PE6, 4, 1)
+#define PIN_PE6__I2SMCC0_DIN3		PINMUX_PIN(PIN_PE6, 5, 2)
+
+#define PIN_PE7				135
+#define PIN_PE7__GPIO			PINMUX_PIN(PIN_PE7, 0, 0)
+#define PIN_PE7__LCDC_DAT3		PINMUX_PIN(PIN_PE7, 1, 1)
+#define PIN_PE7__FLEXCOM2_IO5		PINMUX_PIN(PIN_PE7, 2, 1)
+#define PIN_PE7__PWMH1			PINMUX_PIN(PIN_PE7, 3, 2)
+#define PIN_PE7__TIOA4			PINMUX_PIN(PIN_PE7, 4, 1)
+#define PIN_PE7__I2SMCC0_DOUT1		PINMUX_PIN(PIN_PE7, 5, 2)
+
+#define PIN_PE8				136
+#define PIN_PE8__GPIO			PINMUX_PIN(PIN_PE8, 0, 0)
+#define PIN_PE8__LCDC_DAT4		PINMUX_PIN(PIN_PE8, 1, 1)
+#define PIN_PE8__FLEXCOM2_IO0		PINMUX_PIN(PIN_PE8, 2, 1)
+#define PIN_PE8__PWML2			PINMUX_PIN(PIN_PE8, 3, 2)
+#define PIN_PE8__TIOB4			PINMUX_PIN(PIN_PE8, 4, 1)
+#define PIN_PE8__I2SMCC0_CK		PINMUX_PIN(PIN_PE8, 5, 2)
+
+#define PIN_PE9				137
+#define PIN_PE9__GPIO			PINMUX_PIN(PIN_PE9, 0, 0)
+#define PIN_PE9__LCDC_DAT5		PINMUX_PIN(PIN_PE9, 1, 1)
+#define PIN_PE9__FLEXCOM2_IO1		PINMUX_PIN(PIN_PE9, 2, 1)
+#define PIN_PE9__PWMH2			PINMUX_PIN(PIN_PE9, 3, 2)
+#define PIN_PE9__TCLK4			PINMUX_PIN(PIN_PE9, 4, 1)
+#define PIN_PE9__I2SMCC0_WS		PINMUX_PIN(PIN_PE9, 5, 2)
+
+#define PIN_PE10			138
+#define PIN_PE10__GPIO			PINMUX_PIN(PIN_PE10, 0, 0)
+#define PIN_PE10__LCDC_DAT6		PINMUX_PIN(PIN_PE10, 1, 1)
+#define PIN_PE10__FLEXCOM2_IO6		PINMUX_PIN(PIN_PE10, 2, 1)
+#define PIN_PE10__PWML3			PINMUX_PIN(PIN_PE10, 3, 2)
+#define PIN_PE10__TIOA5			PINMUX_PIN(PIN_PE10, 4, 1)
+#define PIN_PE10__I2SMCC0_DOUT2		PINMUX_PIN(PIN_PE10, 5, 2)
+
+#define PIN_PE11			139
+#define PIN_PE11__GPIO			PINMUX_PIN(PIN_PE11, 0, 0)
+#define PIN_PE11__LCDC_DAT7		PINMUX_PIN(PIN_PE11, 1, 1)
+#define PIN_PE11__PWMH3			PINMUX_PIN(PIN_PE11, 3, 2)
+#define PIN_PE11__TIOB5			PINMUX_PIN(PIN_PE11, 4, 1)
+#define PIN_PE11__I2SMCC0_DOUT3		PINMUX_PIN(PIN_PE11, 5, 2)
+
+#define PIN_PE12			140
+#define PIN_PE12__GPIO			PINMUX_PIN(PIN_PE12, 0, 0)
+#define PIN_PE12__LCDC_DEN		PINMUX_PIN(PIN_PE12, 1, 1)
+#define PIN_PE12__PCK3			PINMUX_PIN(PIN_PE12, 2, 4)
+#define PIN_PE12__PWMEXTRG0		PINMUX_PIN(PIN_PE12, 3, 2)
+#define PIN_PE12__TCLK5			PINMUX_PIN(PIN_PE12, 4, 1)
+#define PIN_PE12__I2SMCC0_DIN0		PINMUX_PIN(PIN_PE12, 5, 2)
+
+#define PIN_PE13			141
+#define PIN_PE13__GPIO			PINMUX_PIN(PIN_PE13, 0, 0)
+#define PIN_PE13__LCDC_PCK		PINMUX_PIN(PIN_PE13, 1, 1)
+#define PIN_PE13__PCK4			PINMUX_PIN(PIN_PE13, 2, 3)
+#define PIN_PE13__PWMEXTRG1		PINMUX_PIN(PIN_PE13, 3, 2)
+#define PIN_PE13__I2SMCC0DOUT0		PINMUX_PIN(PIN_PE13, 5, 2)
-- 
2.43.0


