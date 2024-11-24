Return-Path: <linux-spi+bounces-5811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277EC9D7034
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 14:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD404281F3B
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6921CCEEC;
	Sun, 24 Nov 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dj8ozugi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C37C1CCB50
	for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453623; cv=none; b=HrSLxmtIQ35L2Rek172R8U5YRHXZCUDZsGNZ0lRhpd6BQ3rQBZRnfpD8CmZaJcQFOjRVCYhLqHlSfZTpc5PmD8maBgI3teQ9bZ05UUVdNDj9dxUqShyBPvr+XsPAS2T7Qt+uoEAnbIWTp4JY3ZmANlFeSa/7iANNFdvkNWgkQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453623; c=relaxed/simple;
	bh=lhIpBPq/CMIRnOaci4WJNE5obi+YBNnjfINlE9UKi9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fs/kHE1hTCYIVd36gPGHPMczV0jiYchBp0BiSKPqub46PsN1ATrAIJJ8PUSS0xzgUvdaI8IGMhw7Drqa0+/A/mt3MDP9gLwnwuUSTb1HDRekd1LhnoP+aRR6VnGo77JsyTgdnuJtxeG0EmwkFeTO7M07RkOG/N0Mvs9YGwGaSZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dj8ozugi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-382610c7116so1656270f8f.0
        for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 05:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732453619; x=1733058419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aiH1OSm/CnAORp6KUL2Ydo7AzvV4eiA8iK6LwzE07g0=;
        b=dj8ozugiU6qFQtVJAGHVkLqY4FfSAlMuBYyge70tkwFLp/vetHkFLPq8aNFDreOz4d
         gE+X+inF7Rw9iY2uVlIwb2hbb98RPOHg1U9X6ArbWwbR4aedKOp95YRSnEJxoFul8oZT
         y/a6KTwjnFXHfI/0zRLzZGIGOB5ZmkB5WK/GoL6jHiFcboesirtzJk0K38adUmbDtUXP
         Dh/tdz7U6AeBegBYC4D770EJoyjuNmQL5T/xp2DyEb0SkAR7cC+tk2oy+PM2mMr9T9A1
         rTh1I4qTiX/OLV5PF1w0aT8uO9QudTUvOFm5blr/rj3gG5W9k3tqrOXGKuLN2aMog50z
         btnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732453619; x=1733058419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiH1OSm/CnAORp6KUL2Ydo7AzvV4eiA8iK6LwzE07g0=;
        b=r2ePb0fbon8c/ineMW1IWEO3Fo1t0KpamBLg86e66ua70onxEWGjpALBk1Hux7SYLL
         a8LuTsy5Vid4Ww+WqwQe3ljGGX5nHRyDxvLfVQGvQRWFhrgKiaFP+OHWJtqVdF15QsRk
         fDRluef3xO497/F8wczWhFIHfgJ2yB3g2WZsEmS6mu+SdURqPP0didfrwtnQokax66Mt
         uGcdNvAiWRJ7uYLP1bN7kLGfwe/ytIMs9QPnmVqhXd5HPmheSjPo/yucd141oLgE+dhU
         GRS85/j6lxapJUNpK2knZk7ph8yJ4z3+khRZYcV8elA5fudyQoltXgCGw444u5dfwmub
         s8XA==
X-Forwarded-Encrypted: i=1; AJvYcCVhU6Oi9evHP7J/ucu1kVF/DSRWb9nAtVl2T+iMkGStnrJTS9PRFtTxuaNCnKgntOe8vpo8AB08Blk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BaarUDa5qyOyz7ZrXEQE9N9dj19T4ZAkqvvMH1MhgYgoBhGl
	czIbAWoWoyonfZyrdoA4Fi5BRKXjvVR3+9wT/LIzBe0b1ulS0ZSRxvMF8gxw6fs=
X-Gm-Gg: ASbGncsXm2QOw6p7ib3e+9ujtVl31rXCesQdjGeT0Z6VcXB9ucwiMS/Boko/uZ7DSb/
	5BMq0liHWarvC3YAhue/kwbdYRN2X80PhaT7OxMQ9nMZIs1pCOpDS4ER0Wp3/JF/+SIZSZObkcy
	LggyHCytMuNDMguqE60H0ZjOsTR0np8WSpH2PFQmmaXFL4z79mi3HLFs88nhLzfgsfTosXsnDUZ
	FzOqhu/KL7CFZhwqZWceKzCODsNnn3X91uwkTqR+CMv5eSIwdh5YreVww==
X-Google-Smtp-Source: AGHT+IEB08mayqB4AkZx7Lsy0REasniqy81yBjoQjE/G8GrBJQ19xf7W+fnvGKT0hjmyZnMaK6Satg==
X-Received: by 2002:a05:6000:1541:b0:382:4f5b:876b with SMTP id ffacd0b85a97d-38260b5ea16mr7029924f8f.16.1732453619373;
        Sun, 24 Nov 2024 05:06:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5f59sm7682760f8f.10.2024.11.24.05.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 05:06:58 -0800 (PST)
Message-ID: <32aa70a2-15de-4deb-8edb-5820ab373bd3@tuxon.dev>
Date: Sun, 24 Nov 2024 15:06:56 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] ARM: dts: microchip: add sama7d65 SoC DT
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <1006a1e4464ef7c46b33ad44bf71b3143283ee6e.1732030972.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <1006a1e4464ef7c46b33ad44bf71b3143283ee6e.1732030972.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 19.11.2024 18:40, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add Device Tree for sama7d65 SoC.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Co-developed-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama7d65.dtsi | 155 ++++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi
> 
> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> new file mode 100644
> index 000000000000..2573d488bb81
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + *  sama7d65.dtsi - Device Tree Include file for SAMA7D65 SoC
> + *
> + *  Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
> + *
> + *  Author: Ryan Wanner <Ryan.Wanner@microchip.com>
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/mfd/at91-usart.h>

Please keep includes alphanumerically sorted.

> +
> +/ {
> +	model = "Microchip SAMA7D65 family SoC";
> +	compatible = "microchip,sama7d65";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;

According to [1], compatible and reg is preferred to be at the beginning of
the node.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n112

> +			clocks = <&pmc PMC_TYPE_CORE PMC_CPUPLL>;
> +			clock-names = "cpu";
> +			#cooling-cells = <2>; /* min followed by max */

This seems unused.

> +		};
> +	};
> +
> +	clocks {
> +		slow_xtal: clock-slowxtal {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +
> +		main_xtal: clock-mainxtal {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +	};

The node order is preferred to be alphanumerically sorted unless strong
opinion to keep it sorted some other way. So, first clocks node then cpus.

> +
> +	vddout25: fixed-regulator-vddout25 {

This node seems to be unused.

> +		compatible = "regulator-fixed";
> +

No need for this blank line.

> +		regulator-name = "VDDOUT25";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-boot-on;
> +		status = "disabled";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

As of [1] mentioned above, order would be:

+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;

> +
> +		pioA: pinctrl@e0014000 {
> +			compatible = "microchip,sama7d65-pinctrl";
> +			reg = <0xe0014000 0x800>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,

As of [2], please align it to the it to the < on the previous line.

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n171


> +				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		pmc: clock-controller@e0018000 {
> +			compatible = "microchip,sama7d65-pmc", "syscon";
> +			reg = <0xe0018000 0x200>;
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#clock-cells = <2>;
> +			clocks = <&clk32k 1>, <&clk32k 0>, <&main_xtal>;
> +			clock-names = "td_slck", "md_slck", "main_xtal";
> +		};
> +
> +		clk32k: clock-controller@e001d500 {
> +			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
> +			reg = <0xe001d500 0x4>;
> +			clocks = <&slow_xtal>;
> +			#clock-cells = <1>;
> +		};
> +
> +		sdmmc1: mmc@e1208000 {
> +			compatible = "microchip,sama7d65-sdhci", "microchip,sam9x60-sdhci";
> +			reg = <0xe1208000 0x400>;
> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 76>, <&pmc PMC_TYPE_GCK 76>;
> +			clock-names = "hclock", "multclk";
> +			assigned-clocks = <&pmc PMC_TYPE_GCK 76>;
> +			assigned-clock-rates = <200000000>;
> +			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_MCK1>;
> +			status = "disabled";
> +		};
> +
> +		pit64b0: timer@e1800000 {
> +			compatible = "microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b";
> +			reg = <0xe1800000 0x100>;
> +			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 66>, <&pmc PMC_TYPE_GCK 66>;
> +			clock-names = "pclk", "gclk";
> +		};
> +
> +		pit64b1: timer@e1804000 {
> +			compatible = "microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b";
> +			reg = <0xe1804000 0x100>;
> +			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 67>, <&pmc PMC_TYPE_GCK 67>;
> +			clock-names = "pclk", "gclk";
> +		};
> +
> +		flx6: flexcom@e2020000 {
> +			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
> +			reg = <0xe2020000 0x200>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xe2020000 0x800>;

Please follow the order mentioned in [1]:
- compatible
- reg
- ranges

Also, please check it for the rest of the nodes.

Thank you,
Claudiu

> +			status = "disabled";
> +
> +			uart6: serial@200 {
> +				compatible = "microchip,sama7d65-usart", "atmel,at91sam9260-usart";
> +				reg = <0x200 0x200>;
> +				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> +				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
> +				clock-names = "usart";
> +				atmel,fifo-size = <16>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		gic: interrupt-controller@e8c11000 {
> +			compatible = "arm,cortex-a7-gic";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0xe8c11000 0x1000>,
> +				<0xe8c12000 0x2000>;
> +		};
> +	};
> +};

