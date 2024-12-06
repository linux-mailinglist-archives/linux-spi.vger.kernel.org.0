Return-Path: <linux-spi+bounces-5932-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8449E797C
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C927028749B
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C52135B6;
	Fri,  6 Dec 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tmFKyt9/"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C61D6DBC;
	Fri,  6 Dec 2024 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515284; cv=none; b=CpNeeGa1lQswWj8E3XUHIJ2a/Ci1ZD/lX/nxD0xQ8biDJopZajqSNOVVxWNOSFPesbf1lXo730epaLUDZKt0AETqKD5RlyAq1ILLTMD01oPeDxLaWYNzfdHMAkVbW7e53AQOckAs0q4J9m/HpEItGmHdxIaI7fD1RebZeX0iigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515284; c=relaxed/simple;
	bh=Nbyfn+1oYpcw+P1XPkh6jD6oqLO72wK92m4lABnV+GU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qWK2WG0qJYeng5WdBFwr18xkra3iqeg+6lLMjlN9TApv/+OS5hXnJ3hYL8Ml3Z65FDj13ewbAab0YVJjDbBeJcT5WZ97Qp/7IApcYH4z1fkfY6JI7NEbVazkYBrZG6aWKTkKZX2eHPbTdkjYoE6hZiwoad6g9dHgUUcc3XkXa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tmFKyt9/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515282; x=1765051282;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nbyfn+1oYpcw+P1XPkh6jD6oqLO72wK92m4lABnV+GU=;
  b=tmFKyt9/JRnsgbcF2LoA3rZYz4FS+YtOFfmYBRTgd8HvZAzgscHnIlBG
   K13ICcN4ORBmvCH/DhfbHlpkoTqKndlZg1UzgGT0KPckB2UpJL3hk/Xnr
   uq6lZqlQELIVujR3AjPSC6GsPe9ji+82o3i5P29FJfU4oiU0PlNZP1Q0a
   dLDxpjbZH7GnwOyyRbo0OxbIlCVP/IDDqrUm+foh5vHVbFFNPqiV11M/r
   bc8/nhsNh7pOl+5AsEa8XzRnxOHna5xKoM3rFz4w7JNbhL1Wn/U3yYpiN
   E4WKQ7BMCDPp16KBRCy3/xfoBlU94BSv8MI0fnlJo6M5yrrWYhGhxYXAb
   g==;
X-CSE-ConnectionGUID: wHv5dacKTzaP3KMzdbJ8Aw==
X-CSE-MsgGUID: 1NUJjekURzSRYGbtL23iQg==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="202686982"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:09 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Dec 2024 13:01:09 -0700
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
Subject: [PATCH v3 00/13] Add support for SAMA7D65
Date: Fri, 6 Dec 2024 12:59:45 -0700
Message-ID: <cover.1733505542.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This series adds support for the SAMA7D65 SoC.

V2 of this series [1].

For the pinctrl and pit64 timers those will have DTB warnings due to
those bindings not being in the .yaml format.

Changes v1->v2:
- V1 set was sent incorrectly as multiple seprate patches v2 took all
  those patches and put them in 1 thread.

Changes v2->v3:
- Correct the patch order to follow correct practice.
- Correct flexcom dt-binding commit messge to reflect the changes in the
  coding style.
- Add missing SoB tags to patches.
- Moved export clocks to DT patch to be included with the clock binding
  patch.
- Separate Kconfig changes and defconfig changes into different patches
  and removed unused Kconfig params.
- Correct confusing SoB and Co-developed chain.
- Removed unsued nodes in DTSI file and sorted includes
  alphanumerically.
- Fix incorrect dts formatting.
- Separate dts and pinmux changes into two patches.
- Combine PLL and MCK changes into core clock driver patch.
- Correct formatting in main clock driver.
- MMC dt-binding changes are applied for next so have been removed from
  the set [2].

1) https://lore.kernel.org/linux-arm-kernel/cover.1732030972.git.Ryan.Wanner@microchip.com/T/#m9691b4d58b62f36f6cbac1d06883c985766c2c0d
2) https://lore.kernel.org/linux-arm-kernel/cover.1732030972.git.Ryan.Wanner@microchip.com/T/#mccf6521c07e74e1c7dc61b09ae0ebdbbdde73a28

Dharma Balasubiramani (6):
  dt-bindings: mfd: atmel,sama5d2-flexcom: add
    microchip,sama7d65-flexcom
  dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
  dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
  dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
  dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
  dt-bindings: clock: Add SAMA7D65 PMC compatible string

Romain Sioen (2):
  dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
  ARM: dts: microchip: add support for sama7d65_curiosity board

Ryan Wanner (5):
  clk: at91: sama7d65: add sama7d65 pmc driver
  ARM: dts: microchip: add sama7d65 SoC DT
  ARM: dts: at91: Add sama7d65 pinmux
  ARM: configs: at91: sama7: add new SoC config
  ARM: at91: add new SoC sama7d65

 .../devicetree/bindings/arm/atmel-at91.yaml   |    7 +
 .../devicetree/bindings/arm/atmel-sysregs.txt |   14 +-
 .../bindings/clock/atmel,at91rm9200-pmc.yaml  |    2 +
 .../bindings/clock/atmel,at91sam9x5-sckc.yaml |    1 +
 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |    9 +-
 .../pinctrl/atmel,at91-pio4-pinctrl.txt       |    1 +
 .../bindings/serial/atmel,at91-usart.yaml     |    1 +
 arch/arm/boot/dts/microchip/Makefile          |    3 +
 .../dts/microchip/at91-sama7d65_curiosity.dts |   89 ++
 .../arm/boot/dts/microchip/sama7d65-pinfunc.h |  947 ++++++++++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     |  145 ++
 arch/arm/configs/multi_v7_defconfig           |    1 +
 arch/arm/configs/sama7_defconfig              |    1 +
 arch/arm/mach-at91/Kconfig                    |    9 +
 drivers/clk/at91/Makefile                     |    1 +
 drivers/clk/at91/clk-master.c                 |    2 +-
 drivers/clk/at91/clk-sam9x60-pll.c            |    2 +-
 drivers/clk/at91/pmc.c                        |    1 +
 drivers/clk/at91/sama7d65.c                   | 1373 +++++++++++++++++
 include/dt-bindings/clock/at91.h              |    4 +
 20 files changed, 2600 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65-pinfunc.h
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi
 create mode 100644 drivers/clk/at91/sama7d65.c

-- 
2.43.0


