Return-Path: <linux-spi+bounces-6150-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBCD9FAE67
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 13:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7CE1883813
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6F51B0F04;
	Mon, 23 Dec 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQnF78F2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775291AF0D7;
	Mon, 23 Dec 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958345; cv=none; b=JHYf6wbDkkGJiyQuEU4A8P9IP+M7OTacNrPbto8NrR9wn6QO9lR1RoYE13aHaUCqSNk9xjKZUAOW5j00oY+n/V/JcI4zlMdsqqAuNTN1thFkhA+SeV3X5l8h62doyE3PQ7mz1a7aeB7M6dFPtYny32SHqTIeDZ0cEGtnBFGl7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958345; c=relaxed/simple;
	bh=+8D8SlRfiYR49SiB0XGLOf0ALVRXlm15ZoXTvUHq3ig=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=u0RhK0o50FARq7lDRr4gVEaizbORd3Hs93hH4N8kwhqBC6U2SYqSaEi1kEhf2wY3PKwIPTqsMG+O7TlF595xJ1oqDjyuzbC/Wvi7CaDzSD1bqrckRszMEK7c4JWlZzW54z4e1lkRZu20Z/YXEmmpmoJ+V3TLvXw4srGPOttmzoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQnF78F2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FC5C4CED3;
	Mon, 23 Dec 2024 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734958345;
	bh=+8D8SlRfiYR49SiB0XGLOf0ALVRXlm15ZoXTvUHq3ig=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IQnF78F2w5JZ8M6A2xVWwZ8aaVMX6GFDiA13MufuH3bT4+wGCt+8UiOrMv30KmDgB
	 I9P4yg0/LW2q8Mt51cvYq7nlXLJhMwr+uvdMmwHpC4dFRSq88BaYQzeQo0oz7Qjet7
	 Gxh8klWNmuBQKY96nOmKeD00hHM5Fmt8kZWDRUIP+Fyg5SL3bpvEAxFKRsvEqKNS76
	 O6TWs6/1/oZmMl5aL1VBhoxNKy2NBYDKoKbQ7dgxUoWshgR7rXA9KxT0E00h7/4EM3
	 72QaZDMEwMGWYIKlvXKWYtgIongb97h+A8XEdXeLU/xb91LBK/cuHqez2isz/Ynjpo
	 e0p5fFdS6+7cA==
Date: Mon, 23 Dec 2024 06:52:23 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mturquette@baylibre.com, nicolas.ferre@microchip.com, 
 mihai.sain@microchip.com, linux-kernel@vger.kernel.org, krzk+dt@kernel.org, 
 linux-clk@vger.kernel.org, varshini.rajendran@microchip.com, 
 linux-arm-kernel@lists.infradead.org, dharma.b@microchip.com, 
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
 claudiu.beznea@tuxon.dev, alexandre.belloni@bootlin.com, 
 romain.sioen@microchip.com, linux-mmc@vger.kernel.org, conor+dt@kernel.org, 
 arnd@arndb.de, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 sboyd@kernel.org
To: Ryan.Wanner@microchip.com
In-Reply-To: <cover.1734723585.git.Ryan.Wanner@microchip.com>
References: <cover.1734723585.git.Ryan.Wanner@microchip.com>
Message-Id: <173495825174.503813.17076508226289513016.robh@kernel.org>
Subject: Re: [PATCH v4 00/13]  Add support for SAMA7D65


On Fri, 20 Dec 2024 14:07:01 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This series adds support for the SAMA7D65 SoC.
> 
> V2 of this series [1].
> V3 of this series [2].
> 
> For the pinctrl and pit64 timers those will have DTB warnings due to
> those bindings not being in the .yaml format.
> 
> Changes v1->v2:
> - V1 set was sent incorrectly as multiple seprate patches v2 took all
>   those patches and put them in 1 thread.
> 
> Changes v2->v3:
> - Correct the patch order to follow correct practice.
> - Correct flexcom dt-binding commit messge to reflect the changes in the
>   coding style.
> - Add missing SoB tags to patches.
> - Moved export clocks to DT patch to be included with the clock binding
>   patch.
> - Separate Kconfig changes and defconfig changes into different patches
>   and removed unused Kconfig params.
> - Correct confusing SoB and Co-developed chain.
> - Removed unsued nodes in DTSI file and sorted includes
>   alphanumerically.
> - Fix incorrect dts formatting.
> - Separate dts and pinmux changes into two patches.
> - Combine PLL and MCK changes into core clock driver patch.
> - Correct formatting in main clock driver.
> - MMC dt-binding changes are applied for next so have been removed from
>   the set [3].
> 
> Changes v3->v4:
> - Collect all tags from maintainers.
> - Correct compile error on 11/13 and correct location of vendor specific
>   properties.
> - Add USB and UTMI selections to 12/13 to prevent compile errors due to
>   functions in the clock driver that use the USB clock system.
> - Add "microchip,sama7g5-pinctrl" compatible string as a fall back in
>   9/13.
> - Add missing kfree() to 8/13 to correctly handle error case.
> - Replace bad spacing with correct tab formatting on 7/13.
> 
> 1) https://lore.kernel.org/linux-arm-kernel/cover.1732030972.git.Ryan.Wanner@microchip.com/T/#m9691b4d58b62f36f6cbac1d06883c985766c2c0d
> 2) https://lore.kernel.org/linux-arm-kernel/cover.1733505542.git.Ryan.Wanner@microchip.com/T/#m3b52978236907198f727424e69ef21c8898e95c8
> 3) https://lore.kernel.org/linux-arm-kernel/cover.1732030972.git.Ryan.Wanner@microchip.com/T/#mccf6521c07e74e1c7dc61b09ae0ebdbbdde73a28
> 
> 
> Dharma Balasubiramani (6):
>   dt-bindings: mfd: atmel,sama5d2-flexcom: add
>     microchip,sama7d65-flexcom
>   dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
>   dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
>   dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
>   dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
>   dt-bindings: clock: Add SAMA7D65 PMC compatible string
> 
> Romain Sioen (2):
>   dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
>   ARM: dts: microchip: add support for sama7d65_curiosity board
> 
> Ryan Wanner (5):
>   clk: at91: sama7d65: add sama7d65 pmc driver
>   ARM: dts: microchip: add sama7d65 SoC DT
>   ARM: dts: at91: Add sama7d65 pinmux
>   ARM: configs: at91: sama7: add new SoC config
>   ARM: at91: add new SoC sama7d65
> 
>  .../devicetree/bindings/arm/atmel-at91.yaml   |    7 +
>  .../devicetree/bindings/arm/atmel-sysregs.txt |   14 +-
>  .../bindings/clock/atmel,at91rm9200-pmc.yaml  |    2 +
>  .../bindings/clock/atmel,at91sam9x5-sckc.yaml |    1 +
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |    9 +-
>  .../pinctrl/atmel,at91-pio4-pinctrl.txt       |    1 +
>  .../bindings/serial/atmel,at91-usart.yaml     |    1 +
>  arch/arm/boot/dts/microchip/Makefile          |    3 +
>  .../dts/microchip/at91-sama7d65_curiosity.dts |   89 ++
>  .../arm/boot/dts/microchip/sama7d65-pinfunc.h |  947 ++++++++++++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     |  145 ++
>  arch/arm/configs/multi_v7_defconfig           |    1 +
>  arch/arm/configs/sama7_defconfig              |    1 +
>  arch/arm/mach-at91/Kconfig                    |   11 +
>  drivers/clk/at91/Makefile                     |    1 +
>  drivers/clk/at91/clk-master.c                 |    2 +-
>  drivers/clk/at91/clk-sam9x60-pll.c            |    2 +-
>  drivers/clk/at91/pmc.c                        |    1 +
>  drivers/clk/at91/sama7d65.c                   | 1375 +++++++++++++++++
>  include/dt-bindings/clock/at91.h              |    4 +
>  20 files changed, 2604 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
>  create mode 100644 arch/arm/boot/dts/microchip/sama7d65-pinfunc.h
>  create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi
>  create mode 100644 drivers/clk/at91/sama7d65.c
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y microchip/at91-sama7d65_curiosity.dtb' for cover.1734723585.git.Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/pinctrl@e0014000: failed to match any schema with compatible: ['microchip,sama7d65-pinctrl', 'microchip,sama7g5-pinctrl']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/pinctrl@e0014000: failed to match any schema with compatible: ['microchip,sama7d65-pinctrl', 'microchip,sama7g5-pinctrl']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: mmc@e1208000: compatible: 'oneOf' conditional failed, one must be fixed:
	['microchip,sama7d65-sdhci', 'microchip,sam9x60-sdhci'] is too long
	'microchip,sama7d65-sdhci' is not one of ['atmel,sama5d2-sdhci', 'microchip,sam9x60-sdhci']
	'microchip,sama7d65-sdhci' is not one of ['microchip,sam9x7-sdhci', 'microchip,sama7g5-sdhci']
	from schema $id: http://devicetree.org/schemas/mmc/atmel,sama5d2-sdhci.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: mmc@e1208000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/atmel,sama5d2-sdhci.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/mmc@e1208000: failed to match any schema with compatible: ['microchip,sama7d65-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1800000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1800000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1804000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1804000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']






