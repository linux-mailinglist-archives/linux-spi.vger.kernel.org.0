Return-Path: <linux-spi+bounces-5732-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA229D2B90
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 17:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BC6B2F56D
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D541D0B9B;
	Tue, 19 Nov 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iHn6JGMA"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BF1CEAAA;
	Tue, 19 Nov 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034474; cv=none; b=N3KtoyEozIjpk4BXJYrsOID1NyDDLZS4aBw3n5tlx9oaqrDPBwJMvJy5CcMp8abm2fGRdiz5AahXnbUfCJepnT+SEzC5W6hSfHqOmrSLNeY5VR1+Ex6CRhNhu6UidIK+NbgUrmbhgXzCWr1kwK5C/QxSmbvCScw/lPxD4+E5Y7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034474; c=relaxed/simple;
	bh=mSEjV9HeiX3fGZWRfQeuUvS8Yds5ecN+q0LpFFL71mg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KTYIdyheiWN8lmuJm5khaovx4hktEG3fxgHCb/p5GQy+GQfPkjQojenVzLNOTs0TiTWjFm1hlAWBvsszwSyqe2+2pSS1VuAl42lLm4zwB8ngZMLOxa1euQb+nbzOvd/JtKQdKs26FPYGJJT6H7Qu91f5Yt7NVpBZy5DX7iRMkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iHn6JGMA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732034472; x=1763570472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mSEjV9HeiX3fGZWRfQeuUvS8Yds5ecN+q0LpFFL71mg=;
  b=iHn6JGMAqNXOHWDPUIphpzuwfMioZ+ktYdyTNDIWlX85ru8ioN3Vj0Od
   c6MlLghzSUucBOQTfXPX1Gj44Rwuu9gWxdQdMlTQbxgiSEB3dOD8EHFKg
   FCwsdG8H/iRgsOs2v5nNOrkijJeNIJB83Ah8pfFV2393ou4hI+SUryn+m
   RpzdBV3ads7Vx17NqiuF/1eNrWWOME9fVehwNMKhojGmMDD5AXJu6H827
   x+1FEQdE2OpqUlY45nCbZny4VRvq8mdfssh75ed5PjqpcRwVKHqpEAiFT
   DQtcoLKdmgf7IcFp8e6QvArMoHLHutMhGV0a5lKbuPL+8WIBgbS50PSKm
   Q==;
X-CSE-ConnectionGUID: jnnvkeRdTYaD0RwnHEXOug==
X-CSE-MsgGUID: WIw7SjvARGOo5K2yNqCvNQ==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="35018884"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:41:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:40:53 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:40:53 -0700
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
Subject: [PATCH 00/15] Add support for SAMA7D65
Date: Tue, 19 Nov 2024 09:40:06 -0700
Message-ID: <cover.1732030972.git.Ryan.Wanner@microchip.com>
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

There have been patches in this series that have been tagged as
Reviewed-by or Acked-by, I will link these threads below.

1) https://lore.kernel.org/lkml/20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com/
2) https://lore.kernel.org/lkml/20240829-sama7d65-sck-v1-1-3e7b19e3cbf9@microchip.com/
3) https://lore.kernel.org/lkml/20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com/
4) https://lore.kernel.org/lkml/1da0abbb-94e5-42fd-a2d2-71d5d7d253fb@microchip.com/

The clock system patches have been sent before and are added to this set
to follow the correct practice of submitting patches. I will list that
thread below.

1) https://lore.kernel.org/linux-arm-kernel/d970e158-db74-4ffe-9fb4-57026ac0a947@tuxon.dev/

Dharma Balasubiramani (7):
  dt-bindings: mfd: atmel,sama5d2-flexcom: add
    microchip,sama7d65-flexcom
  dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
  dt-bindings: mmc: atmel,sama5d2-sdhci: add microchip,sama7d65-sdhci
  dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
  dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
  dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
  dt-bindings: clock: Add SAMA7D65 PMC compatible string

Romain Sioen (2):
  dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
  ARM: dts: microchip: add support for sama7d65_curiosity board

Ryan Wanner (5):
  ARM: configs: at91: sama7: add new SoC config
  ARM: dts: microchip: add sama7d65 SoC DT
  clk: at91: clk-master: increase maximum number of clocks
  clk: at91: clk-sam9x60-pll: increase maximum amount of plls
  clk: at91: sama7d65: add sama7d65 pmc driver

Varshini Rajendran (1):
  dt-bindings: clock: at91: Allow MCKs to be exported and referenced in
    DT

 .../devicetree/bindings/arm/atmel-at91.yaml   |    7 +
 .../devicetree/bindings/arm/atmel-sysregs.txt |   14 +-
 .../bindings/clock/atmel,at91rm9200-pmc.yaml  |    2 +
 .../bindings/clock/atmel,at91sam9x5-sckc.yaml |    1 +
 .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |    9 +-
 .../bindings/mmc/atmel,sama5d2-sdhci.yaml     |    1 +
 .../pinctrl/atmel,at91-pio4-pinctrl.txt       |    1 +
 .../bindings/serial/atmel,at91-usart.yaml     |    1 +
 arch/arm/boot/dts/microchip/Makefile          |    3 +
 .../dts/microchip/at91-sama7d65_curiosity.dts |   89 ++
 .../arm/boot/dts/microchip/sama7d65-pinfunc.h |  947 ++++++++++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     |  155 ++
 arch/arm/configs/multi_v7_defconfig           |    1 +
 arch/arm/configs/sama7_defconfig              |    1 +
 arch/arm/mach-at91/Kconfig                    |   12 +
 drivers/clk/at91/Makefile                     |    1 +
 drivers/clk/at91/clk-master.c                 |    2 +-
 drivers/clk/at91/clk-sam9x60-pll.c            |    2 +-
 drivers/clk/at91/pmc.c                        |    1 +
 drivers/clk/at91/sama7d65.c                   | 1373 +++++++++++++++++
 include/dt-bindings/clock/at91.h              |    4 +
 21 files changed, 2614 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65-pinfunc.h
 create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi
 create mode 100644 drivers/clk/at91/sama7d65.c

-- 
2.43.0


