Return-Path: <linux-spi+bounces-4068-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94793FDC9
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 20:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB38B22347
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8803187845;
	Mon, 29 Jul 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2mSqK91"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED1187562;
	Mon, 29 Jul 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279176; cv=none; b=spObUzhKzMelKrbyrjXAJrVstR1wgQH750HIinJNFkclASY/lotdozwvRz1eue50ne1ybLb+SriuKO4mX0DDUICJy0yoBmI1/aZWikGqZt63ShWWYQ2oA24KEBFmpLAcjj+CxwHDokTY//jaXWqGfM8daTFzYx6FfXZ1unbPYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279176; c=relaxed/simple;
	bh=ULdt+e7tNZHKt++4GA0CJi8RYTeU//y8odV8DOrNY8g=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FUL0mGwOMMRrHMKeuAJrrd41YK8UIJsSbsHq5JF0U/TmgzS8F/xOXiP6JOnzw1EZIeJZ2iNTGrbHipF8ENwFz9IZJfQA78NXN/JfDTuc2iOzAoZr56EvxOqB7XRHcar49bTfnRS8J0E6Lj6ZWN2cHgCUR2gAN6OWzyc/e/Yvjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2mSqK91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4260C4AF09;
	Mon, 29 Jul 2024 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722279176;
	bh=ULdt+e7tNZHKt++4GA0CJi8RYTeU//y8odV8DOrNY8g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T2mSqK916S4+IIvaq0Bg++TVPXpmiBSPzHJ9odpUkxJZNwGc1KApo3fE9SeWlYcWG
	 0qfoc4MJ/ReLuHHbwu5Sh2tjxY055NMpgkrKE1SG92ukVOCnIGN2FZrzJD2OuJVpah
	 GutGTloFGUhmLLolqCI8B3aoiG+OiYm4kr+9XemLvKxlFvQOodDCW7QuQM0r8JbNov
	 Ay7IbNYR+/pN1IHr7r6fUQvxS9BysCrWteduABitpyF2KrbPyZGj1UAyAALUoW0RLY
	 LO8eJLus0Y8zeoKPAtqFKFSNn2wvu4W2hcx2g3pi3rQn9odNot8ot+3+BkS95RmTDy
	 CFK/wWwwDzMag==
Date: Mon, 29 Jul 2024 12:52:54 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: Jason@zx2c4.com, linux@armlinux.org.uk, conor+dt@kernel.org, 
 sre@kernel.org, richard.genoud@bootlin.com, sboyd@kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, krzk+dt@kernel.org, 
 andrei.simion@microchip.com, linux-arm-kernel@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, schung@nuvoton.com, 
 jirislaby@kernel.org, devicetree@vger.kernel.org, dharma.b@microchip.com, 
 angelogioacchino.delregno@collabora.com, lee@kernel.org, 
 mturquette@baylibre.com, matthias.bgg@gmail.com, tglx@linutronix.de, 
 rdunlap@infradead.org, radu_nicolae.pirea@upb.ro, 
 gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, 
 ychuang3@nuvoton.com, claudiu.beznea@tuxon.dev, linux-pm@vger.kernel.org, 
 alexandre.belloni@bootlin.com, arnd@arndb.de, mihai.sain@microchip.com, 
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Message-Id: <172227904971.1346450.12443915645617449093.robh@kernel.org>
Subject: Re: [PATCH v6 00/27] Add support for sam9x7 SoC family


On Mon, 29 Jul 2024 12:26:03 +0530, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 
>  Changes in v6:
>  --------------
> 
>  - Addressed all the review comments in the patches
>  - Picked up all Acked-by and Reviewed-by tags
>  - Reverted the IRQ patch to that of version 3 of the same series
>  - All the specific changes are captured in the corresponding patches
> 
>  Changes in v5:
>  --------------
> 
>  - Addressed all the review comments in the patches
>  - Picked up all Acked-by and Reviewed-by tags
>  - Dropped applied patches from the series
>  - Addressed the ABI breakage reported in the IRQ patch
>  - All the specific changes are captured in the corresponding patches
> 
>  Changes in v4:
>  --------------
> 
>  - Addressed all the review comments in the patches
>  - Picked up all Acked-by and Reviewed-by tags
>  - Dropped applied patches from the series
>  - Added pwm node and related dt binding documentation
>  - Added support for exporting some clocks to DT
>  - Dropped USB related patches and changes. See NOTE.
>  - All the specific changes are captured in the corresponding patches
> 
>  NOTE: Owing to the discussion here
>  https://lore.kernel.org/linux-devicetree/CAL_JsqJ9PrX6fj-EbffeJce09MXs=B7t+KS_kOinxaRx38=WxA@mail.gmail.com/
>  the USB related changes are dropped from this series in order to enable
>  us to work on the mentioned issues before adding new compatibles as
>  said. The issues/warnings will be addressed in subsequent patches.
>  After which the USB related support for sam9x7 SoCs will be added. Hope
>  this works out fine.
> 
>  Changes in v3:
>  --------------
> 
>  - Fixed the DT documentation errors pointed out in v2.
>  - Dropped Acked-by tag in tcb DT doc patch as it had to be adapted
>    according to sam9x7 correctly.
>  - Picked by the previously missed tags.
>  - Dropped this patch "dt-bindings: usb: generic-ehci: Document clock-names
>    property" as the warning was not found while validating DT-schema for
>    at91-sam9x75_curiosity.dtb.
>  - Dropped redundant words in the commit message.
>  - Fixed the CHECK_DTBS warnings validated against
>    at91-sam9x75_curiosity.dtb.
>  - Renamed dt nodes according to naming convention.
>  - Dropped unwanted status property in dts.
>  - Removed nodes that are not in use from the board dts.
>  - Removed spi DT doc patch from the series as it was already applied
>    and a fix patch was applied subsequently. Added a patch to remove the
>    compatible to adapt sam9x7.
>  - Added sam9x7 compatibles in usb dt documentation.
> 
> 
>  Changes in v2:
>  --------------
> 
>  - Added sam9x7 specific compatibles in DT with fallbacks
>  - Documented all the newly added DT compatible strings
>  - Added device tree for the target board sam9x75 curiosity and
>    documented the same in the DT bindings documentation
>  - Removed the dt nodes that are not supported at the moment
>  - Removed the configs added by previous version that are not supported
>    at the moment
>  - Fixed all the corrections in the commit message
>  - Changed all the instances of copyright year to 2023
>  - Added sam9x7 flag in PIT64B configuration
>  - Moved macro definitions to header file
>  - Added another divider in mck characteristics in the pmc driver
>  - Fixed the memory leak in the pmc driver
>  - Dropped patches that are no longer needed
>  - Picked up Acked-by and Reviewed-by tags
> 
> 
> Hari Prasath (1):
>   irqchip/atmel-aic5: Add support for sam9x7 aic
> 
> Varshini Rajendran (26):
>   dt-bindings: atmel-sysreg: add sam9x7
>   dt-bindings: mfd: syscon: add microchip's sam9x7 sfr
>   dt-bindings: atmel-ssc: add microchip,sam9x7-ssc
>   dt-bindings: serial: atmel,at91-usart: add compatible for sam9x7.
>   dt-bindings: microchip: atmel,at91rm9200-tcb: add sam9x7 compatible
>   ARM: at91: pm: add support for sam9x7 SoC family
>   ARM: at91: pm: add sam9x7 SoC init config
>   ARM: at91: add support in SoC driver for new sam9x7
>   dt-bindings: clocks: atmel,at91sam9x5-sckc: add sam9x7
>   dt-bindings: clocks: atmel,at91rm9200-pmc: add sam9x7 clock controller
>   clk: at91: clk-sam9x60-pll: re-factor to support individual core freq
>     outputs
>   clk: at91: sam9x7: add support for HW PLL freq dividers
>   clk: at91: sama7g5: move mux table macros to header file
>   dt-bindings: clock: at91: Allow PLLs to be exported and referenced in
>     DT
>   clk: at91: sam9x7: add sam9x7 pmc driver
>   dt-bindings: interrupt-controller: Add support for sam9x7 aic
>   power: reset: at91-poweroff: lookup for proper pmc dt node for sam9x7
>   power: reset: at91-reset: add reset support for sam9x7 SoC
>   power: reset: at91-reset: add sdhwc support for sam9x7 SoC
>   dt-bindings: reset: atmel,at91sam9260-reset: add sam9x7
>   dt-bindings: power: reset: atmel,sama5d2-shdwc: add sam9x7
>   ARM: at91: Kconfig: add config flag for SAM9X7 SoC
>   ARM: configs: at91: enable config flags for sam9x7 SoC family
>   ARM: dts: at91: sam9x7: add device tree for SoC
>   dt-bindings: arm: add sam9x75 curiosity board
>   ARM: dts: microchip: sam9x75_curiosity: add sam9x75 curiosity board
> 
>  .../devicetree/bindings/arm/atmel-at91.yaml   |    6 +
>  .../devicetree/bindings/arm/atmel-sysregs.txt |    6 +-
>  .../bindings/clock/atmel,at91rm9200-pmc.yaml  |    2 +
>  .../bindings/clock/atmel,at91sam9x5-sckc.yaml |    4 +-
>  .../interrupt-controller/atmel,aic.yaml       |    1 +
>  .../devicetree/bindings/mfd/syscon.yaml       |  188 +--
>  .../devicetree/bindings/misc/atmel-ssc.txt    |    1 +
>  .../power/reset/atmel,sama5d2-shdwc.yaml      |    3 +
>  .../reset/atmel,at91sam9260-reset.yaml        |    4 +
>  .../bindings/serial/atmel,at91-usart.yaml     |    9 +-
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   |   20 +-
>  arch/arm/boot/dts/microchip/Makefile          |    3 +
>  .../dts/microchip/at91-sam9x75_curiosity.dts  |  312 +++++
>  arch/arm/boot/dts/microchip/sam9x7.dtsi       | 1226 +++++++++++++++++
>  arch/arm/configs/at91_dt_defconfig            |    1 +
>  arch/arm/mach-at91/Kconfig                    |   22 +-
>  arch/arm/mach-at91/Makefile                   |    1 +
>  arch/arm/mach-at91/generic.h                  |    2 +
>  arch/arm/mach-at91/pm.c                       |   29 +
>  arch/arm/mach-at91/sam9x7.c                   |   33 +
>  drivers/clk/at91/Makefile                     |    1 +
>  drivers/clk/at91/clk-sam9x60-pll.c            |   42 +-
>  drivers/clk/at91/pmc.h                        |   18 +
>  drivers/clk/at91/sam9x60.c                    |    7 +
>  drivers/clk/at91/sam9x7.c                     |  946 +++++++++++++
>  drivers/clk/at91/sama7g5.c                    |   42 +-
>  drivers/irqchip/irq-atmel-aic5.c              |   10 +
>  drivers/power/reset/Kconfig                   |    4 +-
>  drivers/power/reset/at91-sama5d2_shdwc.c      |    1 +
>  drivers/soc/atmel/soc.c                       |   23 +
>  drivers/soc/atmel/soc.h                       |    9 +
>  include/dt-bindings/clock/at91.h              |    4 +
>  32 files changed, 2840 insertions(+), 140 deletions(-)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dts
>  create mode 100644 arch/arm/boot/dts/microchip/sam9x7.dtsi
>  create mode 100644 arch/arm/mach-at91/sam9x7.c
>  create mode 100644 drivers/clk/at91/sam9x7.c
> 
> --
> 2.25.1
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


New warnings running 'make CHECK_DTBS=y microchip/at91-sam9x75_curiosity.dtb' for 20240729065603.1986074-1-varshini.rajendran@microchip.com:

arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /ahb/mmc@80000000: failed to match any schema with compatible: ['microchip,sam9x7-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /ahb/mmc@80000000: failed to match any schema with compatible: ['microchip,sam9x7-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /ahb/mmc@90000000: failed to match any schema with compatible: ['microchip,sam9x7-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /ahb/mmc@90000000: failed to match any schema with compatible: ['microchip,sam9x7-sdhci', 'microchip,sam9x60-sdhci']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/dma-controller@f0008000: failed to match any schema with compatible: ['microchip,sam9x7-dma', 'atmel,sama5d4-dma']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/dma-controller@f0008000: failed to match any schema with compatible: ['microchip,sam9x7-dma', 'atmel,sama5d4-dma']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/ssc@f0010000: failed to match any schema with compatible: ['microchip,sam9x7-ssc', 'atmel,at91sam9g45-ssc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/ssc@f0010000: failed to match any schema with compatible: ['microchip,sam9x7-ssc', 'atmel,at91sam9g45-ssc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/timer@f0028000: failed to match any schema with compatible: ['microchip,sam9x7-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/timer@f0028000: failed to match any schema with compatible: ['microchip,sam9x7-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/timer@f0040000: failed to match any schema with compatible: ['microchip,sam9x7-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/timer@f0040000: failed to match any schema with compatible: ['microchip,sam9x7-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/matrix@ffffde00: failed to match any schema with compatible: ['microchip,sam9x7-matrix', 'atmel,at91sam9x5-matrix', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/matrix@ffffde00: failed to match any schema with compatible: ['microchip,sam9x7-matrix', 'atmel,at91sam9x5-matrix', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/ecc-engine@ffffe000: failed to match any schema with compatible: ['microchip,sam9x7-pmecc', 'atmel,at91sam9g45-pmecc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/ecc-engine@ffffe000: failed to match any schema with compatible: ['microchip,sam9x7-pmecc', 'atmel,at91sam9g45-pmecc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/mpddrc@ffffe800: failed to match any schema with compatible: ['microchip,sam9x7-ddramc', 'atmel,sama5d3-ddramc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/mpddrc@ffffe800: failed to match any schema with compatible: ['microchip,sam9x7-ddramc', 'atmel,sama5d3-ddramc']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/smc@ffffea00: failed to match any schema with compatible: ['microchip,sam9x7-smc', 'atmel,at91sam9260-smc', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/smc@ffffea00: failed to match any schema with compatible: ['microchip,sam9x7-smc', 'atmel,at91sam9260-smc', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/pinctrl@fffff400: failed to match any schema with compatible: ['microchip,sam9x7-pinctrl', 'microchip,sam9x60-pinctrl', 'simple-mfd']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/pinctrl@fffff400: failed to match any schema with compatible: ['microchip,sam9x7-pinctrl', 'microchip,sam9x60-pinctrl', 'simple-mfd']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/syscon@fffffe60: failed to match any schema with compatible: ['microchip,sam9x7-gpbr', 'atmel,at91sam9260-gpbr', 'syscon']
arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: /apb/syscon@fffffe60: failed to match any schema with compatible: ['microchip,sam9x7-gpbr', 'atmel,at91sam9260-gpbr', 'syscon']






