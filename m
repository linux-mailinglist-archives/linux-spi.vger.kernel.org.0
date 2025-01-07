Return-Path: <linux-spi+bounces-6254-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12768A04CAC
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 23:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696603A4424
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 22:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448711DFD9C;
	Tue,  7 Jan 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbKyO1Q4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1986330;
	Tue,  7 Jan 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290473; cv=none; b=t7GcfOymDd8eXm8CenzXHW5jAjTMXiUEEEGVjX/FCaLqogOYO6ZCRGhX4opUMGX8cxNWt2vNNQ8L1GPFxERYgCIhfjBM+j1WxPfHIDrjwOi/jE2SYeqxZGHIFMZzvHLAxCi4+GVogBQSzJzmJM6c9g7o/MWreTamYTVCn2t4L0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290473; c=relaxed/simple;
	bh=O9TJbmQGiBS3wg5CEtqr6UcvZN/r2lDkUlDh/A83J7o=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lkwYaFWhZGSSHVzX446iD4GTs0w96pWpCZWsxuTVkGZtP13H1bzdAIkxuMtOqVPrshPrejZpZi5hFx0ENzz6BnCB0DfxzKGSggQ8zcKD7n+CROekxGtCh3nrvU+p+ClxlQn+8D0CCBiVWFJTxWT05pNo66WBvSEyLS8StxrxkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbKyO1Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D78DC4CED6;
	Tue,  7 Jan 2025 22:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290472;
	bh=O9TJbmQGiBS3wg5CEtqr6UcvZN/r2lDkUlDh/A83J7o=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tbKyO1Q4VjERyhut+hU/vQIG+F7w69M3Vy6s9YBLMnD+LqHjuhmQedWM/wnD6PByi
	 LNZpwHWbRs468sWPfU8ffysRsKa8+zR0VikgXG4yS/LhRB2h6OjX4lKq7AFdLY7hVh
	 39oas5HW1nkTZa5EKBRDAztXXu9WUarhIoFYmVBVFpOuqDeb9gpZCdK+e4972sSnze
	 NrYdVputvAgP4M/t5seLAR79ujHFWj5lgm2WFLex4HqJ2pG914plcnYx3+1YoRHqoB
	 fi4EAwybIl7102DOFK/Xb6e9iSKpPJYbhp3IQKLvsMEWY1kU1FQooOZGlD+VwbHrvR
	 0WLqcioHhz/Kg==
Date: Tue, 07 Jan 2025 16:54:31 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, dharma.b@microchip.com, 
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, 
 mturquette@baylibre.com, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, conor+dt@kernel.org, mihai.sain@microchip.com, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org, 
 varshini.rajendran@microchip.com, claudiu.beznea@tuxon.dev, 
 romain.sioen@microchip.com, linux-spi@vger.kernel.org, 
 linux-gpio@vger.kernel.org, arnd@arndb.de, sboyd@kernel.org
To: Ryan.Wanner@microchip.com
In-Reply-To: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
References: <20250107160850.120537-1-Ryan.Wanner@microchip.com>
Message-Id: <173629037004.1994496.1652835527993929123.robh@kernel.org>
Subject: Re: [PATCH v5 0/5] Add support for SAMA7D65


On Tue, 07 Jan 2025 09:07:22 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This series adds support for the SAMA7D65 SoC.
> 
> V2 of this series [1].
> V3 of this series [2].
> V4 of this series [4].
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
> Changes from v4->v5:
> - Remove patches that have been applied [5].
> - Update pinctrl dt-binding to use fallback formatting.
> 
> Note:
> - For the SDHCI DTB error that patch has been removed do to it being
> applied see [3].
> - There are DTB errors on microchip,sama7d65-pit64b and
>   microchip,sama7d65-pinctrl, this is due to those bindings being .txt
>   files.
> 
> 1) https://lore.kernel.org/linux-arm-kernel/cover.1732030972.git.Ryan.Wanner@microchip.com/T/#m9691b4d58b62f36f6cbac1d06883c985766c2c0d
> 2) https://lore.kernel.org/linux-arm-kernel/cover.1733505542.git.Ryan.Wanner@microchip.com/T/#m3b52978236907198f727424e69ef21c8898e95c8
> 3) https://lore.kernel.org/linux-arm-kernel/cover.1732030972.git.Ryan.Wanner@microchip.com/T/#mccf6521c07e74e1c7dc61b09ae0ebdbbdde73a28
> 4) https://lore.kernel.org/linux-arm-kernel/70d429086fd8e858d79ca2824ad8cc4a09e3fe5d.1734723585.git.Ryan.Wanner@microchip.com/T/#m918b8db23c8d30981263846a02dafc085e17de14
> 5) https://lore.kernel.org/linux-arm-kernel/70d429086fd8e858d79ca2824ad8cc4a09e3fe5d.1734723585.git.Ryan.Wanner@microchip.com/T/#m69b8f11536e3b0ca3d69d125d0670c90412d4317
> 
> 
> 
> Dharma Balasubiramani (2):
>   dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
>   dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
> 
> Romain Sioen (2):
>   dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
>   ARM: dts: microchip: add support for sama7d65_curiosity board
> 
> Ryan Wanner (1):
>   ARM: dts: microchip: add sama7d65 SoC DT
> 
>  .../devicetree/bindings/arm/atmel-at91.yaml   |   7 +
>  .../pinctrl/atmel,at91-pio4-pinctrl.txt       |   3 +-
>  .../bindings/serial/atmel,at91-usart.yaml     |   1 +
>  arch/arm/boot/dts/microchip/Makefile          |   3 +
>  .../dts/microchip/at91-sama7d65_curiosity.dts |  89 +++++++++++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     | 145 ++++++++++++++++++
>  6 files changed, 247 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
>  create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi
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


New warnings running 'make CHECK_DTBS=y microchip/at91-sama7d65_curiosity.dtb' for 20250107160850.120537-1-Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/pinctrl@e0014000: failed to match any schema with compatible: ['microchip,sama7d65-pinctrl', 'microchip,sama7g5-pinctrl']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/pinctrl@e0014000: failed to match any schema with compatible: ['microchip,sama7d65-pinctrl', 'microchip,sama7g5-pinctrl']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1800000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1800000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1804000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1804000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: flexcom@e2020000: compatible: 'oneOf' conditional failed, one must be fixed:
	['microchip,sama7d65-flexcom', 'atmel,sama5d2-flexcom'] is too long
	'atmel,sama5d2-flexcom' was expected
	'microchip,sam9x7-flexcom' was expected
	'microchip,sama7g5-flexcom' was expected
	from schema $id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/flexcom@e2020000: failed to match any schema with compatible: ['microchip,sama7d65-flexcom', 'atmel,sama5d2-flexcom']






