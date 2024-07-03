Return-Path: <linux-spi+bounces-3726-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2849925852
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 12:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7081B1F21930
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2024 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF816B39C;
	Wed,  3 Jul 2024 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OHg1NkAx"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB763143C42;
	Wed,  3 Jul 2024 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002093; cv=none; b=TUUianinrAEdn3mBjSCOvpEto/mlBsH6zA8McKs1jFt36J3/5Q9TS4JGUTuOyBx9ArhNrA8/yShqsARDnUge19m8/vcKgH4CR64BHISaN4LsA1xoFK+BKhvTT6bLfVYWNHfFBAuzVhLS6F/UHcI5GsGeiGXlhdQ/GICig+87a6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002093; c=relaxed/simple;
	bh=CsaWx8PdD675H5FCw6difqLNYbisrdqd1zWhvZqFxiM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BivQSGgr5sJgVfB2K0GE3wcW1vewcuag7YB1dh95pabfh+98XFCW29zedoWw/BcgXO5tb0cLlqHnRXTXGsFxxOgBbflAQa3hdeuow2S7rA1YOyYEoU1gvNbaCap1hO++u5RotFhG+BBLQiIG/pio1b9RxI23TQLDWmDMGOalvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OHg1NkAx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002091; x=1751538091;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CsaWx8PdD675H5FCw6difqLNYbisrdqd1zWhvZqFxiM=;
  b=OHg1NkAxPZ+BD5GXc/s2u9inou0K2PmfqkadwWVtZ/MMYWyNd1QtbBDa
   tPiDZJr7aS8bKTXoghEgrW96sHk2Ujl78TH6/W8ZdI5Pu5EtjeYy3Fhul
   tu3X0s32buPRexm2X8tcf5026t6l5WoU0qpZHDbeut428s4ggRPSsitcr
   sbCEcx1OFCT/t53PR6AUQlM9J7IfLfUMxJd7Jlen9ESgyqlgNV6TLQPXN
   Fxai22pEGVSiYcZRCCuYVmSzqgyF8qfsM+D8+NjrFiProi5MGiF8ObnE+
   aKQQyQj41Te+XcmjcU00z1U6XuJWz8gGmZePtXkZtZsjMnzR0GOFt0dOo
   A==;
X-CSE-ConnectionGUID: Znz9azp1QR6J93vlkandzw==
X-CSE-MsgGUID: qVWTiJyHQOypLOlBu5gCMQ==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28772185"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:21:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:20:49 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:20:38 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<tglx@linutronix.de>, <sre@kernel.org>, <p.zabel@pengutronix.de>,
	<richard.genoud@bootlin.com>, <radu_nicolae.pirea@upb.ro>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<linux@armlinux.org.uk>, <mihai.sain@microchip.com>,
	<andrei.simion@microchip.com>, <varshini.rajendran@microchip.com>,
	<durai.manickamkr@microchip.com>, <arnd@arndb.de>,
	<akpm@linux-foundation.org>, <mpe@ellerman.id.au>, <geert+renesas@glider.be>,
	<rdunlap@infradead.org>, <dharma.b@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
Subject: [PATCH v5 00/27] Add support for sam9x7 SoC family
Date: Wed, 3 Jul 2024 15:50:11 +0530
Message-ID: <20240703102011.193343-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds support for the new SoC family - sam9x7.
 - The device tree, configs and drivers are added
 - Clock driver for sam9x7 is added
 - Support for basic peripherals is added
 - Target board SAM9X75 Curiosity is added

 Changes in v5:
 --------------

 - Addressed all the review comments in the patches
 - Picked up all Acked-by and Reviewed-by tags
 - Dropped applied patches from the series
 - Addressed the ABI breakage reported in the IRQ patch
 - All the specific changes are captured in the corresponding patches

 Changes in v4:
 --------------

 - Addressed all the review comments in the patches
 - Picked up all Acked-by and Reviewed-by tags
 - Dropped applied patches from the series
 - Added pwm node and related dt binding documentation
 - Added support for exporting some clocks to DT
 - Dropped USB related patches and changes. See NOTE.
 - All the specific changes are captured in the corresponding patches

 NOTE: Owing to the discussion here
 https://lore.kernel.org/linux-devicetree/CAL_JsqJ9PrX6fj-EbffeJce09MXs=B7t+KS_kOinxaRx38=WxA@mail.gmail.com/
 the USB related changes are dropped from this series in order to enable
 us to work on the mentioned issues before adding new compatibles as
 said. The issues/warnings will be addressed in subsequent patches.
 After which the USB related support for sam9x7 SoCs will be added. Hope
 this works out fine.

 Changes in v3:
 --------------

 - Fixed the DT documentation errors pointed out in v2.
 - Dropped Acked-by tag in tcb DT doc patch as it had to be adapted
   according to sam9x7 correctly.
 - Picked by the previously missed tags.
 - Dropped this patch "dt-bindings: usb: generic-ehci: Document clock-names
   property" as the warning was not found while validating DT-schema for
   at91-sam9x75_curiosity.dtb.
 - Dropped redundant words in the commit message.
 - Fixed the CHECK_DTBS warnings validated against
   at91-sam9x75_curiosity.dtb.
 - Renamed dt nodes according to naming convention.
 - Dropped unwanted status property in dts.
 - Removed nodes that are not in use from the board dts.
 - Removed spi DT doc patch from the series as it was already applied
   and a fix patch was applied subsequently. Added a patch to remove the
   compatible to adapt sam9x7.
 - Added sam9x7 compatibles in usb dt documentation.


 Changes in v2:
 --------------

 - Added sam9x7 specific compatibles in DT with fallbacks
 - Documented all the newly added DT compatible strings
 - Added device tree for the target board sam9x75 curiosity and
   documented the same in the DT bindings documentation
 - Removed the dt nodes that are not supported at the moment
 - Removed the configs added by previous version that are not supported
   at the moment
 - Fixed all the corrections in the commit message
 - Changed all the instances of copyright year to 2023
 - Added sam9x7 flag in PIT64B configuration
 - Moved macro definitions to header file
 - Added another divider in mck characteristics in the pmc driver
 - Fixed the memory leak in the pmc driver
 - Dropped patches that are no longer needed
 - Picked up Acked-by and Reviewed-by tags


Varshini Rajendran (27):
  dt-bindings: atmel-sysreg: add sam9x7
  dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
  dt-bindings: serial: atmel,at91-usart: add compatible for sam9x7.
  ARM: at91: pm: add support for sam9x7 SoC family
  ARM: at91: pm: add sam9x7 SoC init config
  ARM: at91: add support in SoC driver for new sam9x7
  dt-bindings: clocks: atmel,at91sam9x5-sckc
  dt-bindings: clocks: atmel,at91rm9200-pmc
  clk: at91: clk-sam9x60-pll: re-factor to support individual core freq
    outputs
  clk: at91: sam9x7: add support for HW PLL freq dividers
  clk: at91: sama7g5: move mux table macros to header file
  dt-bindings: clock: at91: Allow PLLs to be exported and referenced in
    DT
  clk: at91: sam9x7: add sam9x7 pmc driver
  dt-bindings: interrupt-controller: Add support for sam9x7 aic
  dt-bindings: interrupt-controller: Document the property
    microchip,nr-irqs
  irqchip/atmel-aic5: Add support to get nr_irqs from DT for sam9x60 &
    sam9x7
  ARM: dts: at91: sam9x60: Add nirqs property in the dt node
  power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
  power: reset: at91-reset: add reset support for sam9x7 SoC
  power: reset: at91-reset: add sdhwc support for sam9x7 SoC
  dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
  dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
  ARM: at91: Kconfig: add config flag for SAM9X7 SoC
  ARM: configs: at91: enable config flags for sam9x7 SoC family
  ARM: dts: at91: sam9x7: add device tree for SoC
  dt-bindings: arm: add sam9x75 curiosity board
  ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board

 .../devicetree/bindings/arm/atmel-at91.yaml   |    6 +
 .../devicetree/bindings/arm/atmel-sysregs.txt |    7 +-
 .../bindings/clock/atmel,at91rm9200-pmc.yaml  |    2 +
 .../bindings/clock/atmel,at91sam9x5-sckc.yaml |    4 +-
 .../interrupt-controller/atmel,aic.yaml       |   28 +-
 .../devicetree/bindings/misc/atmel-ssc.txt    |    1 +
 .../power/reset/atmel,sama5d2-shdwc.yaml      |    3 +
 .../reset/atmel,at91sam9260-reset.yaml        |    4 +
 .../bindings/serial/atmel,at91-usart.yaml     |    9 +-
 arch/arm/boot/dts/microchip/Makefile          |    3 +
 .../dts/microchip/at91-sam9x75_curiosity.dts  |  312 +++++
 arch/arm/boot/dts/microchip/sam9x60.dtsi      |    1 +
 arch/arm/boot/dts/microchip/sam9x7.dtsi       | 1226 +++++++++++++++++
 arch/arm/configs/at91_dt_defconfig            |    1 +
 arch/arm/mach-at91/Kconfig                    |   22 +-
 arch/arm/mach-at91/Makefile                   |    1 +
 arch/arm/mach-at91/generic.h                  |    2 +
 arch/arm/mach-at91/pm.c                       |   29 +
 arch/arm/mach-at91/sam9x7.c                   |   33 +
 drivers/clk/at91/Makefile                     |    1 +
 drivers/clk/at91/clk-sam9x60-pll.c            |   42 +-
 drivers/clk/at91/pmc.h                        |   18 +
 drivers/clk/at91/sam9x60.c                    |    7 +
 drivers/clk/at91/sam9x7.c                     |  946 +++++++++++++
 drivers/clk/at91/sama7g5.c                    |   42 +-
 drivers/irqchip/irq-atmel-aic5.c              |    8 +-
 drivers/power/reset/Kconfig                   |    4 +-
 drivers/power/reset/at91-sama5d2_shdwc.c      |    1 +
 drivers/soc/atmel/soc.c                       |   23 +
 drivers/soc/atmel/soc.h                       |    9 +
 include/dt-bindings/clock/at91.h              |    4 +
 31 files changed, 2750 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
 create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi
 create mode 100644 arch/arm/mach-at91/sam9x7.c
 create mode 100644 drivers/clk/at91/sam9x7.c

-- 
2.25.1


