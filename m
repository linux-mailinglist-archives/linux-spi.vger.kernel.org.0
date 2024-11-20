Return-Path: <linux-spi+bounces-5787-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1D9D3FA6
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 17:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DBF283F03
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8351A7259;
	Wed, 20 Nov 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzZq/XnK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66BF19F424;
	Wed, 20 Nov 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118573; cv=none; b=rlUk+3+qHtKNJ38RFPw9QInGLwkui3nIgSoFT4xECuxybcwkvfe6RujL6tW6MfsG/XUEg3fVLL/NKTZKXz8BSxGncsnbmu7rmS9VxsImdC4RyvuNcDBhTK7zwxTKUOVtcmuu5uj6RBvt2Q1kJupCTi9kFAdTH8+YjyuGHsC60yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118573; c=relaxed/simple;
	bh=JgLWOHmUTemObVeIGpwUPte2754GI41s/ZUZDvGmHiY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LSrW18yIB0eVDdFFC2rdYZ5gpA8oszwnwxKVtHwi7Mx1wC+Qewx5x/JPtA8MoKVwBFX3EA1KNFZfMKDfgaFBxvuJBSPjvM4Ng2e5CZYNSkuu1WvhUkGb0byl28+LpOTC9TkIEcP+01bzgYXGUWskC+yQiNTIttjgFBbbDnSgsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzZq/XnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B5AC4CED3;
	Wed, 20 Nov 2024 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118573;
	bh=JgLWOHmUTemObVeIGpwUPte2754GI41s/ZUZDvGmHiY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=EzZq/XnKvOEpmQceuz8jMQBGH5pVIq3kKZdMG4KalP4y7FTZI/yJN3F4PK5Vng818
	 3iMYCfcfl3WqQ9+5Ws3rnE5efRknAkNqdUPFVq6HQIen8Z8phCIQPdEIQDzt+wl65i
	 GxnPr47skISDZjmpBVuLTLnTdMNlGA+SAJ7BLYWD9LpKsXqjh7KvS28/M9rOEM1KDI
	 zTfV/gsu/REEUuH1Pz5E7uVIxsCH+JkrhbI9WC/LQC+AtaW1cy+MjcTJohYRHm2Mke
	 zHgrEJabJJLC1gyC+gdckFMVWiojkOzhc8/A7k0oP5MuS4SZSpyAZnIm5vq/WZLYA0
	 MFbVcbyjxh4kA==
Date: Wed, 20 Nov 2024 10:02:52 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: sboyd@kernel.org, linux-serial@vger.kernel.org, krzk+dt@kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, conor+dt@kernel.org, romain.sioen@microchip.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 alexandre.belloni@bootlin.com, arnd@arndb.de, nicolas.ferre@microchip.com, 
 mihai.sain@microchip.com, mturquette@baylibre.com, claudiu.beznea@tuxon.dev, 
 dharma.b@microchip.com, varshini.rajendran@microchip.com
To: Ryan.Wanner@microchip.com
In-Reply-To: <cover.1732030972.git.Ryan.Wanner@microchip.com>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
Message-Id: <173211841742.1124520.7475940959733704423.robh@kernel.org>
Subject: Re: [PATCH 00/15] Add support for SAMA7D65


On Tue, 19 Nov 2024 09:40:06 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This series adds support for the SAMA7D65 SoC.
> 
> There have been patches in this series that have been tagged as
> Reviewed-by or Acked-by, I will link these threads below.
> 
> 1) https://lore.kernel.org/lkml/20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com/
> 2) https://lore.kernel.org/lkml/20240829-sama7d65-sck-v1-1-3e7b19e3cbf9@microchip.com/
> 3) https://lore.kernel.org/lkml/20240829-sama7d65-next-v1-1-53d4e50b550d@microchip.com/
> 4) https://lore.kernel.org/lkml/1da0abbb-94e5-42fd-a2d2-71d5d7d253fb@microchip.com/
> 
> The clock system patches have been sent before and are added to this set
> to follow the correct practice of submitting patches. I will list that
> thread below.
> 
> 1) https://lore.kernel.org/linux-arm-kernel/d970e158-db74-4ffe-9fb4-57026ac0a947@tuxon.dev/
> 
> Dharma Balasubiramani (7):
>   dt-bindings: mfd: atmel,sama5d2-flexcom: add
>     microchip,sama7d65-flexcom
>   dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
>   dt-bindings: mmc: atmel,sama5d2-sdhci: add microchip,sama7d65-sdhci
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
>   ARM: configs: at91: sama7: add new SoC config
>   ARM: dts: microchip: add sama7d65 SoC DT
>   clk: at91: clk-master: increase maximum number of clocks
>   clk: at91: clk-sam9x60-pll: increase maximum amount of plls
>   clk: at91: sama7d65: add sama7d65 pmc driver
> 
> Varshini Rajendran (1):
>   dt-bindings: clock: at91: Allow MCKs to be exported and referenced in
>     DT
> 
>  .../devicetree/bindings/arm/atmel-at91.yaml   |    7 +
>  .../devicetree/bindings/arm/atmel-sysregs.txt |   14 +-
>  .../bindings/clock/atmel,at91rm9200-pmc.yaml  |    2 +
>  .../bindings/clock/atmel,at91sam9x5-sckc.yaml |    1 +
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   |    9 +-
>  .../bindings/mmc/atmel,sama5d2-sdhci.yaml     |    1 +
>  .../pinctrl/atmel,at91-pio4-pinctrl.txt       |    1 +
>  .../bindings/serial/atmel,at91-usart.yaml     |    1 +
>  arch/arm/boot/dts/microchip/Makefile          |    3 +
>  .../dts/microchip/at91-sama7d65_curiosity.dts |   89 ++
>  .../arm/boot/dts/microchip/sama7d65-pinfunc.h |  947 ++++++++++++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     |  155 ++
>  arch/arm/configs/multi_v7_defconfig           |    1 +
>  arch/arm/configs/sama7_defconfig              |    1 +
>  arch/arm/mach-at91/Kconfig                    |   12 +
>  drivers/clk/at91/Makefile                     |    1 +
>  drivers/clk/at91/clk-master.c                 |    2 +-
>  drivers/clk/at91/clk-sam9x60-pll.c            |    2 +-
>  drivers/clk/at91/pmc.c                        |    1 +
>  drivers/clk/at91/sama7d65.c                   | 1373 +++++++++++++++++
>  include/dt-bindings/clock/at91.h              |    4 +
>  21 files changed, 2614 insertions(+), 13 deletions(-)
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


New warnings running 'make CHECK_DTBS=y microchip/at91-sama7d65_curiosity.dtb' for cover.1732030972.git.Ryan.Wanner@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/pinctrl@e0014000: failed to match any schema with compatible: ['microchip,sama7d65-pinctrl']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1800000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1800000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1804000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/timer@e1804000: failed to match any schema with compatible: ['microchip,sama7d65-pit64b', 'microchip,sam9x60-pit64b']






