Return-Path: <linux-spi+bounces-8345-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD97AC9881
	for <lists+linux-spi@lfdr.de>; Sat, 31 May 2025 01:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807051C08531
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 23:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED490283C90;
	Fri, 30 May 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCIaoNhv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7442DCBE3;
	Fri, 30 May 2025 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748649009; cv=none; b=SdX6hAVpPrxTog94b5CvW3MTdIdJPlzrUItq27cTaniUd7/2p/cDZgJSdgoJkWdUdbKyMJrO0F5owtKYJEa4rTdJyFUIN6ZJhkOvbDTgxMG99CQ53/qV5mt4W5BlQ0PPz7pTD/CTvT4f2JKH/JXeML9PzW4iIYv37fFs1IGIsik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748649009; c=relaxed/simple;
	bh=sIa0xFzu1D1xz2357rkIwmTrJRrT5PAbME0EOtLiSfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ou2EEQRW1C7P59C35MVnmlvIPuv4cyI0d/w3wKpb4MImpeoMJrdTWtu9vvS80dfGFci4SnmtnP1z7TrFWRhWQfwvS79edSbKTleMteSGXTsQm3Uv3cfktSXeZ/vSa4TUsIujMsG33y80tH2L7fckHC6qcBY8udt6t99sQqlF1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCIaoNhv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so3552251a12.3;
        Fri, 30 May 2025 16:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748649005; x=1749253805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzBoqekrM6G9uWUaiC1c45nPGoTSTzIo9yvzGe+vLRc=;
        b=cCIaoNhvqR3FbzYkN1z+A2fznxSk23HZJRBk6/s6dPMwwyiJ3Ge1SjyElcdBGXAf77
         dYNzZ5Ehv48hs9vxskgrObyQmHrP912ecisiIhzFMdbkOQzX1W74CCPnIG/hARrG03q5
         oe8kF6Wz+k3Sb5rBs/NkUxiRK6bidUcV2aAVAKT460J4riQJKLjKhNDv0xnD0mED3ZFx
         fe9Fx8ofbyC9cVW/+NBE+8jf51/38dzR9UOOOSQGZDDCuEsnKrWmzeWjiZ/xawqyGHLT
         vuh8qCfjxht8OKsxD4JfHj3OdeRo8pHY34tJZmB+BJ3MQF5/4T8aYKrRPdFd+YDObo6u
         nOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748649005; x=1749253805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzBoqekrM6G9uWUaiC1c45nPGoTSTzIo9yvzGe+vLRc=;
        b=tQOOF7RaU8udEhmfCVjeW51Q+fpEy7b0GLai6qIsksxt4uGIUz5yQaULeQi5WwDFQr
         vGFyOL82IRCDruzMy9VwxghRuFCUx3nLyPGknIoPJniFNo/9AlOLJN6N4mp6sopPWnqZ
         QuEBgXIz5+B7DyNSIU4yVeTWGwbL/2xpH4bNs7GAiyE9kbdTkpNy8NhIk9ReN01QO1Ut
         Q//kJ+pJhaQ/DI8cI1uORKDPWsUSBY0eK2fGkycuGBFP8gFmQh203/CVT2PK09gPFhSS
         kAH0082y0cVCwKKAS5hD4F4nxN5XrDfySl4bIvr6k0b1JyxXn/chdSvwhAPFYS6M3rDQ
         q5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaEFD9DI8m96jdVJoloogY6SmSuZ18B167UNkZ8WKe39RxviTdoD5i9+petJ8eKehm5Z2+XyfiE6JEKzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrn2NXgA8F0EIf+wWbJDz6muVNII4tCWo0y1wSSdrMwBpCQq/
	Lj3qXgBCdj7id7chuFmDSRHert/egr2oZNMXx4riQegD4oNDCzw9dVbOYp6EXPgD
X-Gm-Gg: ASbGncu0SdMSOhxGsHyjRu7YcnkN7IurWsaxxUGwgQEaJ7887SW9kkON/D2IdKGpRuA
	oBUjI09purA927VsgQZqgJ+YgmEq0ytSj4EwVJvNmWu3cAwIylPwGsbIk0qYDm9jSHPpnjvd1Qy
	GJ4ezsgUjNxc2cL0jNCtgGSY1VoyIEt66yzLWdizBwyp3G3Zmi9X+YFNFLLiUsZOZszOCDOdzYG
	FE1lxldSSP/E4c0ua9yzUXYnv93gIraQ6sJMC3/AOFsj5zGN1NFXVXdS7TLPsltktBmVtITFTJJ
	Jn/DoqOIszK3DLgoUW0M08MZlFUXIYDmp2CuMwQce7/LiNrpoHQUPKj8cdXPWblflGBVExt3g+V
	SZhcjop/fPKEInvefAnKrWwJiB4nXQf18qPKLgKgszF/+Y4d6rliOZNI=
X-Google-Smtp-Source: AGHT+IGeCyb0sm+2evNuFlk2KB6eRLhFRoAEKm92D5AJdPD4ri3MSOu3uNYth3WKnosVIk+tPMqrVw==
X-Received: by 2002:a17:907:1c13:b0:ad8:9428:6a4a with SMTP id a640c23a62f3a-adb322fd1b3mr531170566b.32.1748649004704;
        Fri, 30 May 2025 16:50:04 -0700 (PDT)
Received: from shift.daheim (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7ff08bsm406815466b.17.2025.05.30.16.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 16:50:04 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.98.2)
	(envelope-from <chuck@shift.daheim>)
	id 1uL9UB-00000003zFv-1u5R;
	Sat, 31 May 2025 01:50:03 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] spi: push HAS_IOMEM dependency down to the drivers
Date: Sat, 31 May 2025 01:49:38 +0200
Message-ID: <20250530234941.950431-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")
added this back in ~2007, with the reason being:
| Add "depends on HAS_IOMEM" to a number of menus to make them
| disappear for s390 which does not have I/O memory.

Now, even back then Serial Peripheral Interface doesn't technically imply
that any I/O memory is required for operation / communication between the
master/host and the slaves/clients.

That said, most of the host controller do need it. But there are some
exceptions:
 - SPI_GPIO (gpio bit-banged)
 - SPI_BUTTERFLY (Parallel port adapter for AVR Butterfly (DEVELOPMENT))
 - SPI_SC18IS602 (NXP SC18IS602/602B/603 I2C to SPI bridge)
 - SPI_XCOMM (Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver)
 - SPI_LJCA (Intel La Jolla Cove Adapter SPI support - USB)
 - SPI_CH341 (CH341 USB2SPI adapter)
 - (SPI_RPCIF) (Renesas RPC-IF SPI driver) - RPC

This patch >tries< to remove the single HAS_IOMEM dependency down
to the individual driver. Some - presumably newer - drivers already had
the "depends on HAS_IOMEM". For now, I settled with just adding it.
With no regards even if PCI, DMA, REGMAP_MMIO or some ARCH has been set,
which would definitely imply that we have IOMEM.

But if there's an interest, I will totally look into which
"depends on HAS_IOMEM" can be integrated into other existing "depends on"
or if they can simply be skipped altogether since PCI/ARCH is set that
does imply HAS_IOMEM.

Ideally, nothing should break. Though, I would bet that the robots
will probably tell me otherwise :) .

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/spi/Kconfig | 106 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c51da3fc3604..97a423384864 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -4,7 +4,6 @@
 #
 menuconfig SPI
 	bool "SPI support"
-	depends on HAS_IOMEM
 	help
 	  The "Serial Peripheral Interface" is a low level synchronous
 	  protocol.  Chips that support SPI can have data transfer rates
@@ -64,6 +63,7 @@ config SPI_AIROHA_SNFI
 	tristate "Airoha SPI NAND Flash Interface"
 	depends on ARCH_AIROHA || COMPILE_TEST
 	depends on SPI_MASTER
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  This enables support for SPI-NAND mode on the Airoha NAND
@@ -72,6 +72,7 @@ config SPI_AIROHA_SNFI
 
 config SPI_ALTERA
 	tristate "Altera SPI Controller platform driver"
+	depends on HAS_IOMEM
 	select SPI_ALTERA_CORE
 	select REGMAP_MMIO
 	help
@@ -86,6 +87,7 @@ config SPI_ALTERA_CORE
 config SPI_ALTERA_DFL
 	tristate "DFL bus driver for Altera SPI Controller"
 	depends on FPGA_DFL
+	depends on HAS_IOMEM
 	select SPI_ALTERA_CORE
 	help
 	  This is a Device Feature List (DFL) bus driver for the
@@ -95,6 +97,7 @@ config SPI_ALTERA_DFL
 config SPI_AMLOGIC_SPIFC_A1
 	tristate "Amlogic A1 SPIFC controller"
 	depends on ARCH_MESON || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables master mode support for the SPIFC (SPI flash
 	  controller) available in Amlogic A1 (A113L SoC).
@@ -102,6 +105,7 @@ config SPI_AMLOGIC_SPIFC_A1
 config SPI_APPLE
 	tristate "Apple SoC SPI Controller platform driver"
 	depends on ARCH_APPLE || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the SPI controller present on
 	  many Apple SoCs, including the t8103 (M1), t8112 (M2)
@@ -113,6 +117,7 @@ config SPI_APPLE
 config SPI_AR934X
 	tristate "Qualcomm Atheros AR934X/QCA95XX SPI controller driver"
 	depends on ATH79 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the SPI controller present on the
 	  Qualcomm Atheros AR934X/QCA95XX SoCs.
@@ -120,6 +125,7 @@ config SPI_AR934X
 config SPI_ATH79
 	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
 	depends on ATH79 || COMPILE_TEST
+	depends on HAS_IOMEM
 	select SPI_BITBANG
 	help
 	  This enables support for the SPI controller present on the
@@ -128,6 +134,7 @@ config SPI_ATH79
 config SPI_ARMADA_3700
 	tristate "Marvell Armada 3700 SPI Controller"
 	depends on (ARCH_MVEBU && OF) || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the SPI controller present on the
 	  Marvell Armada 3700 SoCs.
@@ -136,6 +143,7 @@ config SPI_ASPEED_SMC
 	tristate "Aspeed flash controllers in SPI mode"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  This enables support for the Firmware Memory controller (FMC)
 	  in the Aspeed AST2600, AST2500 and AST2400 SoCs when attached
@@ -147,6 +155,7 @@ config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT91 ARM chips.
@@ -155,6 +164,7 @@ config SPI_AT91_USART
 	tristate "Atmel USART Controller SPI driver"
 	depends on (ARCH_AT91 || COMPILE_TEST)
 	depends on MFD_AT91_USART
+	depends on HAS_IOMEM
 	help
 	  This selects a driver for the AT91 USART Controller as SPI Master,
 	  present on AT91 and SAMA5 SoC series.
@@ -171,6 +181,7 @@ config SPI_ATMEL_QUADSPI
 config SPI_AU1550
 	tristate "Au1550/Au1200/Au1300 SPI Controller"
 	depends on MIPS_ALCHEMY
+	depends on HAS_IOMEM
 	select SPI_BITBANG
 	help
 	  If you say yes to this option, support will be included for the
@@ -188,6 +199,7 @@ config SPI_AXI_SPI_ENGINE
 config SPI_BCM2835
 	tristate "BCM2835 SPI controller"
 	depends on GPIOLIB
+	depends on HAS_IOMEM
 	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI master.
@@ -200,6 +212,7 @@ config SPI_BCM2835
 config SPI_BCM2835AUX
 	tristate "BCM2835 SPI auxiliary controller"
 	depends on ((ARCH_BCM2835 || ARCH_BRCMSTB) && GPIOLIB) || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI aux master.
 
@@ -210,12 +223,14 @@ config SPI_BCM2835AUX
 config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
 	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
 	depends on BCM63XX || BMIPS_GENERIC || ARCH_BCMBCA || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
@@ -224,6 +239,7 @@ config SPI_BCM_QSPI
 	tristate "Broadcom BSPI and MSPI controller support"
 	depends on ARCH_BRCMSTB || ARCH_BCM || ARCH_BCM_IPROC || \
 			BMIPS_GENERIC || COMPILE_TEST
+	depends on HAS_IOMEM
 	default ARCH_BCM_IPROC
 	help
 	  Enables support for the Broadcom SPI flash and MSPI controller.
@@ -234,6 +250,7 @@ config SPI_BCM_QSPI
 config SPI_BCMBCA_HSSPI
 	tristate "Broadcom BCMBCA HS SPI controller driver"
 	depends on ARCH_BCMBCA || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCMBCA SoCs. These SoCs include an updated SPI controller
@@ -265,6 +282,7 @@ config SPI_BUTTERFLY
 
 config SPI_CADENCE
 	tristate "Cadence SPI controller"
+	depends on HAS_IOMEM
 	help
 	  This selects the Cadence SPI controller master driver
 	  used by Xilinx Zynq and ZynqMP.
@@ -272,6 +290,7 @@ config SPI_CADENCE
 config SPI_CADENCE_QUADSPI
 	tristate "Cadence Quad SPI controller"
 	depends on OF && (ARM || ARM64 || X86 || RISCV || MIPS || COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  Enable support for the Cadence Quad SPI Flash controller.
 
@@ -301,6 +320,7 @@ config SPI_CH341
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
 	depends on ARCH_CLPS711X || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables dedicated general purpose SPI/Microwire1-compatible
 	  master mode interface (SSI1) for CLPS711X-based CPUs.
@@ -308,6 +328,7 @@ config SPI_CLPS711X
 config SPI_COLDFIRE_QSPI
 	tristate "Freescale Coldfire QSPI controller"
 	depends on (M520x || M523x || M5249 || M525x || M527x || M528x || M532x)
+	depends on HAS_IOMEM
 	help
 	  This enables support for the Coldfire QSPI controller in master
 	  mode.
@@ -315,6 +336,7 @@ config SPI_COLDFIRE_QSPI
 config SPI_CS42L43
 	tristate "Cirrus Logic CS42L43 SPI controller"
 	depends on MFD_CS42L43 && PINCTRL_CS42L43
+	depends on HAS_IOMEM
 	select GPIO_SWNODE_UNDEFINED
 	help
 	  This enables support for the SPI controller inside the Cirrus Logic
@@ -349,6 +371,7 @@ config SPI_DW_MMIO
 config SPI_DW_BT1
 	tristate "Baikal-T1 SPI driver for DW SPI core"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
+	depends on HAS_IOMEM
 	select MULTIPLEXER
 	help
 	  Baikal-T1 SoC is equipped with three DW APB SSI-based MMIO SPI
@@ -388,6 +411,7 @@ config SPI_DLN2
 config SPI_EP93XX
 	tristate "Cirrus Logic EP93xx SPI controller"
 	depends on ARCH_EP93XX || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables using the Cirrus EP93xx SPI controller in master
 	  mode.
@@ -404,6 +428,7 @@ config SPI_FALCON
 config SPI_FSI
 	tristate "FSI SPI driver"
 	depends on FSI
+	depends on HAS_IOMEM
 	help
 	  This enables support for the driver for FSI bus attached SPI
 	  controllers.
@@ -411,6 +436,7 @@ config SPI_FSI
 config SPI_FSL_LPSPI
 	tristate "Freescale i.MX LPSPI controller"
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables Freescale i.MX LPSPI controllers in master mode.
 
@@ -428,6 +454,7 @@ config SPI_FSL_QUADSPI
 config SPI_GXP
 	tristate "GXP SPI driver"
 	depends on ARCH_HPE || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the driver for GXP bus attached SPI
 	  controllers.
@@ -435,6 +462,7 @@ config SPI_GXP
 config SPI_HISI_KUNPENG
 	tristate "HiSilicon SPI Controller for Kunpeng SoCs"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for HiSilicon SPI controller found on
 	  Kunpeng SoCs.
@@ -480,6 +508,7 @@ config SPI_GPIO
 config SPI_IMG_SPFI
 	tristate "IMG SPFI controller"
 	depends on MIPS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the SPFI master controller found on
 	  IMG SoCs.
@@ -487,12 +516,14 @@ config SPI_IMG_SPFI
 config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the Freescale i.MX SPI controllers.
 
 config SPI_INGENIC
 	tristate "Ingenic SoCs SPI controller"
 	depends on MACH_INGENIC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the Ingenic SoCs SPI controller.
 
@@ -507,6 +538,7 @@ config SPI_INTEL_PCI
 	depends on PCI
 	depends on X86 || COMPILE_TEST
 	depends on SPI_MEM
+	depends on HAS_IOMEM
 	select SPI_INTEL
 	help
 	  This enables PCI support for the Intel PCH/PCU SPI controller in
@@ -524,6 +556,7 @@ config SPI_INTEL_PLATFORM
 	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
 	depends on X86 || COMPILE_TEST
 	depends on SPI_MEM
+	depends on HAS_IOMEM
 	select SPI_INTEL
 	help
 	  This enables platform support for the Intel PCH/PCU SPI
@@ -542,6 +575,7 @@ config SPI_INTEL_PLATFORM
 config SPI_JCORE
 	tristate "J-Core SPI Master"
 	depends on OF && (SUPERH || COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  This enables support for the SPI master controller in the J-Core
 	  synthesizable, open source SoC.
@@ -575,6 +609,7 @@ config SPI_LOONGSON_PCI
 	tristate "Loongson SPI Controller PCI Driver Support"
 	select SPI_LOONGSON_CORE
 	depends on PCI && (LOONGARCH || COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  This bus driver supports the Loongson SPI hardware controller in
 	  the Loongson platforms and supports to use PCI framework to
@@ -586,6 +621,7 @@ config SPI_LOONGSON_PLATFORM
 	tristate "Loongson SPI Controller Platform Driver Support"
 	select SPI_LOONGSON_CORE
 	depends on OF && (LOONGARCH || COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  This bus driver supports the Loongson SPI hardware controller in
 	  the Loongson platforms and supports to use DTS framework to
@@ -596,6 +632,7 @@ config SPI_LOONGSON_PLATFORM
 config SPI_LP8841_RTC
 	tristate "ICP DAS LP-8841 SPI Controller for RTC"
 	depends on MACH_PXA27X_DT || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This driver provides an SPI master device to drive Maxim
 	  DS-1302 real time clock.
@@ -606,6 +643,7 @@ config SPI_LP8841_RTC
 config SPI_MPC52xx
 	tristate "Freescale MPC52xx SPI (non-PSC) controller support"
 	depends on PPC_MPC52xx
+	depends on HAS_IOMEM
 	help
 	  This drivers supports the MPC52xx SPI controller in master SPI
 	  mode.
@@ -613,6 +651,7 @@ config SPI_MPC52xx
 config SPI_MPC52xx_PSC
 	tristate "Freescale MPC52xx PSC SPI controller"
 	depends on PPC_MPC52xx
+	depends on HAS_IOMEM
 	help
 	  This enables using the Freescale MPC52xx Programmable Serial
 	  Controller in master SPI mode.
@@ -620,6 +659,7 @@ config SPI_MPC52xx_PSC
 config SPI_MPC512x_PSC
 	tristate "Freescale MPC512x PSC SPI controller"
 	depends on PPC_MPC512x
+	depends on HAS_IOMEM
 	help
 	  This enables using the Freescale MPC5121 Programmable Serial
 	  Controller in SPI master mode.
@@ -635,6 +675,7 @@ config SPI_FSL_CPM
 config SPI_FSL_SPI
 	tristate "Freescale SPI controller and Aeroflex Gaisler GRLIB SPI controller"
 	depends on OF
+	depends on HAS_IOMEM
 	select SPI_FSL_LIB
 	select SPI_FSL_CPM if FSL_SOC
 	help
@@ -647,6 +688,7 @@ config SPI_FSL_SPI
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
+	depends on HAS_IOMEM
 	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || M5441x || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
@@ -655,6 +697,7 @@ config SPI_FSL_DSPI
 config SPI_FSL_ESPI
 	tristate "Freescale eSPI controller"
 	depends on FSL_SOC
+	depends on HAS_IOMEM
 	help
 	  This enables using the Freescale eSPI controllers in master mode.
 	  From MPC8536, 85xx platform uses the controller, and all P10xx,
@@ -675,6 +718,7 @@ config SPI_MESON_SPICC
 	tristate "Amlogic Meson SPICC controller"
 	depends on COMMON_CLK
 	depends on ARCH_MESON || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables master mode support for the SPICC (SPI communication
 	  controller) available in Amlogic Meson SoCs.
@@ -682,6 +726,7 @@ config SPI_MESON_SPICC
 config SPI_MESON_SPIFC
 	tristate "Amlogic Meson SPIFC controller"
 	depends on ARCH_MESON || COMPILE_TEST
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  This enables master mode support for the SPIFC (SPI flash
@@ -690,6 +735,7 @@ config SPI_MESON_SPIFC
 config SPI_MICROCHIP_CORE
 	tristate "Microchip FPGA SPI controllers"
 	depends on SPI_MASTER
+	depends on HAS_IOMEM
 	help
 	  This enables the SPI driver for Microchip FPGA SPI controllers.
 	  Say Y or M here if you want to use the "hard" controllers on
@@ -699,6 +745,7 @@ config SPI_MICROCHIP_CORE
 config SPI_MICROCHIP_CORE_QSPI
 	tristate "Microchip FPGA QSPI controllers"
 	depends on SPI_MASTER
+	depends on HAS_IOMEM
 	help
 	  This enables the QSPI driver for Microchip FPGA QSPI controllers.
 	  Say Y or M here if you want to use the QSPI controllers on
@@ -708,6 +755,7 @@ config SPI_MICROCHIP_CORE_QSPI
 config SPI_MT65XX
 	tristate "MediaTek SPI controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This selects the MediaTek(R) SPI bus driver.
 	  If you want to use MediaTek(R) SPI interface,
@@ -717,12 +765,14 @@ config SPI_MT65XX
 config SPI_MT7621
 	tristate "MediaTek MT7621 SPI Controller"
 	depends on RALINK || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This selects a driver for the MediaTek MT7621 SPI Controller.
 
 config SPI_MTK_NOR
 	tristate "MediaTek SPI NOR controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for SPI NOR controller found on MediaTek
 	  ARM SoCs. This is a controller specifically for SPI NOR flash.
@@ -734,6 +784,7 @@ config SPI_MTK_SNFI
 	tristate "MediaTek SPI NAND Flash Interface"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on MTD_NAND_ECC_MEDIATEK
+	depends on HAS_IOMEM
 	help
 	  This enables support for SPI-NAND mode on the MediaTek NAND
 	  Flash Interface found on MediaTek ARM SoCs. This controller
@@ -743,6 +794,7 @@ config SPI_MTK_SNFI
 config SPI_WPCM_FIU
 	tristate "Nuvoton WPCM450 Flash Interface Unit"
 	depends on ARCH_NPCM || COMPILE_TEST
+	depends on HAS_IOMEM
 	select REGMAP
 	help
 	  This enables support got the Flash Interface Unit SPI controller
@@ -764,6 +816,7 @@ config SPI_NPCM_FIU
 config SPI_NPCM_PSPI
 	tristate "Nuvoton NPCM PSPI Controller"
 	depends on ARCH_NPCM || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This driver provides support for Nuvoton NPCM BMC
 	  Peripheral SPI controller in master mode.
@@ -771,6 +824,7 @@ config SPI_NPCM_PSPI
 config SPI_LANTIQ_SSC
 	tristate "Lantiq SSC SPI controller"
 	depends on LANTIQ || X86 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This driver supports the Lantiq SSC SPI controller in master
 	  mode. This controller is found on Intel (former Lantiq) SoCs like
@@ -779,6 +833,7 @@ config SPI_LANTIQ_SSC
 config SPI_OC_TINY
 	tristate "OpenCores tiny SPI"
 	depends on GPIOLIB || COMPILE_TEST
+	depends on HAS_IOMEM
 	select SPI_BITBANG
 	help
 	  This is the driver for OpenCores tiny SPI master controller.
@@ -786,6 +841,7 @@ config SPI_OC_TINY
 config SPI_OCTEON
 	tristate "Cavium OCTEON SPI controller"
 	depends on CAVIUM_OCTEON_SOC
+	depends on HAS_IOMEM
 	help
 	  SPI host driver for the hardware found on some Cavium OCTEON
 	  SOCs.
@@ -793,6 +849,7 @@ config SPI_OCTEON
 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
 	depends on ARCH_OMAP1 || (ARM && COMPILE_TEST)
+	depends on HAS_IOMEM
 	select SPI_BITBANG
 	help
 	  This hooks up to the MicroWire controller on OMAP1 chips.
@@ -800,6 +857,7 @@ config SPI_OMAP_UWIRE
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
 	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
+	depends on HAS_IOMEM
 	select SG_SPLIT
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
@@ -808,6 +866,7 @@ config SPI_OMAP24XX
 config SPI_TI_QSPI
 	tristate "DRA7xxx QSPI controller support"
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  QSPI master controller for DRA7xxx used for flash devices.
 	  This device supports single, dual and quad read support, while
@@ -816,6 +875,7 @@ config SPI_TI_QSPI
 config SPI_ORION
 	tristate "Orion SPI master"
 	depends on PLAT_ORION || ARCH_MVEBU || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables using the SPI master controller on the Orion
 	  and MVEBU chips.
@@ -823,6 +883,7 @@ config SPI_ORION
 config SPI_PCI1XXXX
 	tristate "PCI1XXXX SPI Bus support"
 	depends on PCI
+	depends on HAS_IOMEM
 	help
 	  Say "yes" to Enable the SPI Bus support for the PCI1xxxx card
 	  This is a PCI to SPI Bus driver
@@ -832,18 +893,21 @@ config SPI_PCI1XXXX
 config SPI_PIC32
 	tristate "Microchip PIC32 series SPI"
 	depends on MACH_PIC32 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Microchip PIC32 SPI master controller.
 
 config SPI_PIC32_SQI
 	tristate "Microchip PIC32 Quad SPI driver"
 	depends on MACH_PIC32 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for PIC32 Quad SPI controller.
 
 config SPI_PL022
 	tristate "ARM AMBA PL022 SSP controller"
 	depends on ARM_AMBA
+	depends on HAS_IOMEM
 	default y if ARCH_REALVIEW
 	default y if INTEGRATOR_IMPD1
 	default y if ARCH_VERSATILE
@@ -862,6 +926,7 @@ config SPI_PPC4xx
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
 	depends on ARCH_PXA || ARCH_MMP || (X86 && (PCI || ACPI)) || COMPILE_TEST
+	depends on HAS_IOMEM
 	select PXA_SSP if ARCH_PXA || ARCH_MMP
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
@@ -873,6 +938,7 @@ config SPI_PXA2XX_PCI
 config SPI_REALTEK_SNAND
 	tristate "Realtek SPI-NAND Flash Controller"
 	depends on MACH_REALTEK_RTL || COMPILE_TEST
+	depends on HAS_IOMEM
 	select REGMAP
 	help
 	  This enables support for the SPI-NAND Flash controller on
@@ -884,6 +950,7 @@ config SPI_REALTEK_SNAND
 config SPI_ROCKCHIP
 	tristate "Rockchip SPI controller driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This selects a driver for Rockchip SPI controller.
 
@@ -908,6 +975,7 @@ config SPI_ROCKCHIP_SFC
 config SPI_RB4XX
 	tristate "Mikrotik RB4XX SPI master"
 	depends on SPI_MASTER && ATH79
+	depends on HAS_IOMEM
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
 
@@ -920,12 +988,14 @@ config SPI_RPCIF
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Renesas RSPI and QSPI blocks.
 
 config SPI_RZV2M_CSI
 	tristate "Renesas RZ/V2M CSI controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI).
 	  CSI supports both SPI host and SPI target roles.
@@ -933,6 +1003,7 @@ config SPI_RZV2M_CSI
 config SPI_QCOM_QSPI
 	tristate "QTI QSPI controller"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
 
@@ -940,6 +1011,7 @@ config SPI_QPIC_SNAND
 	tristate "QPIC SNAND controller"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on MTD
+	depends on HAS_IOMEM
 	help
 	  QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
 	  QPIC controller supports both parallel nand and serial nand.
@@ -948,6 +1020,7 @@ config SPI_QPIC_SNAND
 config SPI_QUP
 	tristate "Qualcomm SPI controller with QUP interface"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Qualcomm Universal Peripheral (QUP) core is an AHB slave that
 	  provides a common data path (an output FIFO and an input FIFO)
@@ -961,6 +1034,7 @@ config SPI_QUP
 config SPI_QCOM_GENI
 	tristate "Qualcomm GENI based SPI controller"
 	depends on QCOM_GENI_SE
+	depends on HAS_IOMEM
 	help
 	  This driver supports GENI serial engine based SPI controller in
 	  master mode on the Qualcomm Technologies Inc.'s SoCs. If you say
@@ -973,6 +1047,7 @@ config SPI_QCOM_GENI
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX/Exynos SoC series type SPI"
 	depends on (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Samsung S3C64XX, S5Pv210 and Exynos SoCs.
 	  Choose Y/M here only if you build for such Samsung SoC.
@@ -987,18 +1062,21 @@ config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
 	depends on HAVE_CLK
 	depends on ARCH_SHMOBILE || ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
 
 config SPI_SH
 	tristate "SuperH SPI controller"
 	depends on SUPERH || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for SuperH SPI blocks.
 
 config SPI_SH_SCI
 	tristate "SuperH SCI SPI controller"
 	depends on SUPERH
+	depends on HAS_IOMEM
 	select SPI_BITBANG
 	help
 	  SPI driver for SuperH SCI blocks.
@@ -1006,6 +1084,7 @@ config SPI_SH_SCI
 config SPI_SH_HSPI
 	tristate "SuperH HSPI controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for SuperH HSPI blocks.
 
@@ -1019,6 +1098,7 @@ config SPI_SLAVE_MT27XX
 	tristate "MediaTek SPI slave device"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on SPI_SLAVE
+	depends on HAS_IOMEM
 	help
 	  This selects the MediaTek(R) SPI slave device driver.
 	  If you want to use MediaTek(R) SPI slave interface,
@@ -1037,6 +1117,7 @@ config SPI_SN_F_OSPI
 config SPI_SG2044_NOR
 	tristate "SG2044 SPI NOR Controller"
 	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables support for the SG2044 SPI NOR controller,
 	  which supports Dual/Quad read and write operations while
@@ -1046,6 +1127,7 @@ config SPI_SG2044_NOR
 config SPI_SPRD
 	tristate "Spreadtrum SPI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Spreadtrum SoCs.
 
@@ -1053,12 +1135,14 @@ config SPI_SPRD_ADI
 	tristate "Spreadtrum ADI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
 	depends on HWSPINLOCK || (COMPILE_TEST && !HWSPINLOCK)
+	depends on HAS_IOMEM
 	help
 	  ADI driver based on SPI for Spreadtrum SoCs.
 
 config SPI_STM32
 	tristate "STMicroelectronics STM32 SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
+	depends on HAS_IOMEM
 	select SPI_SLAVE
 	help
 	  SPI driver for STMicroelectronics STM32 SoCs.
@@ -1072,6 +1156,7 @@ config SPI_STM32_OSPI
 	depends on ARCH_STM32 || COMPILE_TEST
 	depends on OF
 	depends on SPI_MEM
+	depends on HAS_IOMEM
 	help
 	  This enables support for the Octo SPI controller in master mode.
 	  This driver does not support generic SPI. The implementation only
@@ -1082,6 +1167,7 @@ config SPI_STM32_QSPI
 	depends on ARCH_STM32 || COMPILE_TEST
 	depends on OF
 	depends on SPI_MEM
+	depends on HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
 	  This driver does not support generic SPI. The implementation only
@@ -1090,6 +1176,7 @@ config SPI_STM32_QSPI
 config SPI_ST_SSC4
 	tristate "STMicroelectronics SPI SSC-based driver"
 	depends on ARCH_STI || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  STMicroelectronics SoCs support for SPI. If you say yes to
 	  this option, support will be included for the SSC driven SPI.
@@ -1097,6 +1184,7 @@ config SPI_ST_SSC4
 config SPI_SUN4I
 	tristate "Allwinner A10 SoCs SPI controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Allwinner sun4i, sun5i and sun7i SoCs
 
@@ -1104,12 +1192,14 @@ config SPI_SUN6I
 	tristate "Allwinner A31 SPI controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on RESET_CONTROLLER
+	depends on HAS_IOMEM
 	help
 	  This enables using the SPI controller on the Allwinner A31 SoCs.
 
 config SPI_SUNPLUS_SP7021
 	tristate "Sunplus SP7021 SPI controller"
 	depends on SOC_SP7021 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables Sunplus SP7021 SPI controller driver on the SP7021 SoCs.
 	  This driver can also be built as a module. If so, the module will be
@@ -1121,6 +1211,7 @@ config SPI_SUNPLUS_SP7021
 config SPI_SYNQUACER
 	tristate "Socionext's SynQuacer HighSpeed SPI controller"
 	depends on ARCH_SYNQUACER || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Socionext's High speed SPI controller which provides
 	  various operating modes for interfacing to serial peripheral devices
@@ -1131,6 +1222,7 @@ config SPI_SYNQUACER
 config SPI_MXIC
 	tristate "Macronix MX25F0A SPI controller"
 	depends on SPI_MASTER
+	depends on HAS_IOMEM
 	imply MTD_NAND_ECC_MXIC
 	help
 	  This selects the Macronix MX25F0A SPI controller driver.
@@ -1138,6 +1230,7 @@ config SPI_MXIC
 config SPI_MXS
 	tristate "Freescale MXS SPI controller"
 	depends on ARCH_MXS
+	depends on HAS_IOMEM
 	select STMP_DEVICE
 	help
 	  SPI driver for Freescale MXS devices.
@@ -1146,6 +1239,7 @@ config SPI_TEGRA210_QUAD
 	tristate "NVIDIA Tegra QSPI Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on RESET_CONTROLLER
+	depends on HAS_IOMEM
 	help
 	  QSPI driver for NVIDIA Tegra QSPI Controller interface. This
 	  controller is different from the SPI controller and is available
@@ -1155,6 +1249,7 @@ config SPI_TEGRA114
 	tristate "NVIDIA Tegra114 SPI Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
 	depends on RESET_CONTROLLER
+	depends on HAS_IOMEM
 	help
 	  SPI driver for NVIDIA Tegra114 SPI Controller interface. This controller
 	  is different than the older SoCs SPI controller and also register interface
@@ -1164,6 +1259,7 @@ config SPI_TEGRA20_SFLASH
 	tristate "Nvidia Tegra20 Serial flash Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on RESET_CONTROLLER
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Nvidia Tegra20 Serial flash Controller interface.
 	  The main usecase of this controller is to use spi flash as boot
@@ -1173,12 +1269,14 @@ config SPI_TEGRA20_SLINK
 	tristate "Nvidia Tegra20/Tegra30 SLINK Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
 	depends on RESET_CONTROLLER
+	depends on HAS_IOMEM
 	help
 	  SPI driver for Nvidia Tegra20/Tegra30 SLINK Controller interface.
 
 config SPI_THUNDERX
 	tristate "Cavium ThunderX SPI controller"
 	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  SPI host driver for the hardware found on Cavium ThunderX
 	  SOCs.
@@ -1186,6 +1284,7 @@ config SPI_THUNDERX
 config SPI_TOPCLIFF_PCH
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) SPI"
 	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  SPI driver for the Topcliff PCH (Platform Controller Hub) SPI bus
 	  used in some x86 embedded processors.
@@ -1229,6 +1328,7 @@ config SPI_XILINX
 config SPI_XLP
 	tristate "Cavium ThunderX2 SPI controller driver"
 	depends on ARCH_THUNDER2 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enable support for the SPI controller on the Cavium ThunderX2.
 	  (Originally on Netlogic XLP SoCs.)
@@ -1239,6 +1339,7 @@ config SPI_XLP
 config SPI_XTENSA_XTFPGA
 	tristate "Xtensa SPI controller for xtfpga"
 	depends on (XTENSA && XTENSA_PLATFORM_XTFPGA) || COMPILE_TEST
+	depends on HAS_IOMEM
 	select SPI_BITBANG
 	help
 	  SPI driver for xtfpga SPI master controller.
@@ -1252,6 +1353,7 @@ config SPI_ZYNQ_QSPI
 	tristate "Xilinx Zynq QSPI controller"
 	depends on ARCH_ZYNQ || COMPILE_TEST
 	depends on SPI_MEM
+	depends on HAS_IOMEM
 	help
 	  This enables support for the Zynq Quad SPI controller
 	  in master mode.
@@ -1260,6 +1362,7 @@ config SPI_ZYNQ_QSPI
 config SPI_ZYNQMP_GQSPI
 	tristate "Xilinx ZynqMP GQSPI controller"
 	depends on (SPI_MEM && HAS_DMA) || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
 	  This controller only supports SPI memory interface.
@@ -1269,6 +1372,7 @@ config SPI_AMD
 	depends on PCI
 	depends on SPI_MASTER || X86 || COMPILE_TEST
 	depends on SPI_MEM
+	depends on HAS_IOMEM
 	help
 	  Enables SPI controller driver for AMD SoC.
 
-- 
2.49.0


