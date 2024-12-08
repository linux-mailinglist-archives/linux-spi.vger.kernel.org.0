Return-Path: <linux-spi+bounces-5958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA009E866B
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F20163533
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386416D9AF;
	Sun,  8 Dec 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qYltXwO3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D4B15990C
	for <linux-spi@vger.kernel.org>; Sun,  8 Dec 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675403; cv=none; b=KuVIxioX3U3eWWiRh2pqgFASB6iGzFNMLMt6tbcpYnLbo7HvQt3NCS/ME82B2h1gNobQNpGYIy8+Q/SolXsxZpMTA1Zf0g1y4/gXMVSuGqFGqtk7DVQ7o0jgVLvZwb7Sjew8DLJopewZ2yB2IaL0jLaAmOg5ZwJpIiUABvXsOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675403; c=relaxed/simple;
	bh=Sq41DU1AxfOGIkoKNVF/ea/IoEoVQpEvHAVF8kBvKDU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ig6pKimUXK8fj9A501UEzfQ4UEIq2B2LunIEAsy6wBfx9FLQFaV6QOUvAj6NhHeiehzUwkUTcGSDLA/dHtlCvg2nrQbEAsijatITWgnazKbxrgThs4dtIl0lvIoxblR8JnW+ecNm9ZWfM6r//785x6Bxjsd7JnpoWJWkVkq2ZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qYltXwO3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa642e45241so401703766b.1
        for <linux-spi@vger.kernel.org>; Sun, 08 Dec 2024 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675398; x=1734280198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BNq9HukNRZr8ujW8Nrg9M6GQfhB02SRFVzv7C/bZVs=;
        b=qYltXwO3N1sWWFvpXdrgzeu1T2+Mld284I4YqkXpqJAEbg30tYIYTby50aGbdPMozX
         3V5ihYpG50ERHO/jUb6dUA+AInqmo9HXFLfM0X2Fe1MNTfJ5t1lpcdb+T7xaoROmH/Mq
         J5vkAHCOdB94SLGk9zvZoxhK0Ldx7HWieQ7UF4JVOGrlHYYo5CH/v7UIB+QG4e1NcOQ5
         r1e6oq4hv5bGLLxRCSXTsTNufOeTW5/Tuugw2Uw0V1UJkF+ggAf76vpjO46F1u5qTIVL
         xQ4pZpRbxcHPOVwclPhdqKb1SsmBAS9RqYq9Icxz7OIXZkUwXvQqMT4RD3FT1lAEAelQ
         xT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675398; x=1734280198;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BNq9HukNRZr8ujW8Nrg9M6GQfhB02SRFVzv7C/bZVs=;
        b=sCl6AOnU8IYEkDF6zqeq5JkWo9dmM8q2imwQqTlkQAER3DYUpNHudaxB5WCJTuSgAu
         iYtvZSeP5LR0i5qhih1FB8JOO2186gFuX6gJjEMVhqXuDFAEyZokHvBYZmIJc7nX7Zwz
         UaQ3CIPpQokDC7QWWTT0czrRLvU5pkGPr2aQwmrezTWP3deNq3Am88In1cnpq/DCtU9I
         48FwL8CcR9t2R6eQpZrV2IhKpJRquJZ3XKztCg7RQAlgOuHaItzLQIf5eg8vjXxRAXny
         qW7v6DCAJPswlfZwTs8SabxhgqfgYi5VHYgY+NZNiaIYqiWVHJmdscXyhfY4AFs4ZlaF
         f41w==
X-Forwarded-Encrypted: i=1; AJvYcCWvpfY2nMR0p/cvxKI5iLKVUHuaWFowXwyryxm/V6LdLbsoYReKR73EnsLAw/fLdqJ+qaDU+u591+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGaRjYmpdHy4WtcM6uZIY2Hdo6X1G7ZskPExhfXOOnxEyVfPFt
	gejU2b8dS30I9gtWY2TkaBzyiQw/yt88yRV3hLpSgY1d6pYv/poabi1zpsCE4So=
X-Gm-Gg: ASbGnctZiFEQyN59sm3Jcf5a6t3Rxrmovt4ZFlVJ26vsZbfXPEduTj0vlY5gQcyDDBE
	W3OkQNVG9th36JNypK6EyZW8f/BEJNGgnhV/MRhGQ/r8JbpPj/apXsc656icvUlCY3GLnS5h7+E
	/xx0Dqdm4NAYbR5Wc++rF79kW1yVZdlNb8frhFgi1guzAV8Y4yJHFyYdcCPB5b7acvVT+RT7QVd
	mlqN1/5F4aQeyW+Gn4SCy3eg3AiI2xR+69Crqz1vpY/C8UPQ8Q+v9BtAbU=
X-Google-Smtp-Source: AGHT+IGgMEMrSAPr02MLIHAcIHPoTg9MNMPJ2rKs998sfhdc8FiMJuyQZbDGm5o1c5USrCVKcB7FqQ==
X-Received: by 2002:a17:906:2189:b0:aa6:74a9:ce6e with SMTP id a640c23a62f3a-aa674a9d065mr269789166b.16.1733675398372;
        Sun, 08 Dec 2024 08:29:58 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68a97498dsm5949966b.99.2024.12.08.08.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:29:57 -0800 (PST)
Message-ID: <9fbbf3d1-9543-42f8-a80c-1527811109ef@tuxon.dev>
Date: Sun, 8 Dec 2024 18:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] ARM: dts: microchip: add sama7d65 SoC DT
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <f62e2600a8e88e4be9d87b346c41bb4781f8f667.1733505542.git.Ryan.Wanner@microchip.com>
 <9a6c1dfe-cf4d-41fc-a0f4-b6a111a40c94@tuxon.dev>
In-Reply-To: <9a6c1dfe-cf4d-41fc-a0f4-b6a111a40c94@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08.12.2024 18:28, Claudiu Beznea wrote:
> 
> 
> On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>
>> Add Device Tree for sama7d65 SoC.
>>
>> Co-developed-by: Dharma Balasubiramani <dharma.b@microchip.com>
>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>> Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
>> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
>> Co-developed-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>> ---
>>  arch/arm/boot/dts/microchip/sama7d65.dtsi | 145 ++++++++++++++++++++++
>>  1 file changed, 145 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/microchip/sama7d65.dtsi
>>
>> diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
>> new file mode 100644
>> index 000000000000..0dcd80690210
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + *  sama7d65.dtsi - Device Tree Include file for SAMA7D65 SoC
>> + *
>> + *  Copyright (C) 2024 Microchip Technology, Inc. and its subsidiaries
>> + *
>> + *  Author: Ryan Wanner <Ryan.Wanner@microchip.com>
>> + *
>> + */
>> +
>> +#include <dt-bindings/clock/at91.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/mfd/at91-usart.h>
>> +
>> +/ {
>> +	model = "Microchip SAMA7D65 family SoC";
>> +	compatible = "microchip,sama7d65";
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	interrupt-parent = <&gic>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x0>;
>> +			device_type = "cpu";
>> +			clocks = <&pmc PMC_TYPE_CORE PMC_CPUPLL>;
>> +			clock-names = "cpu";
>> +		};
>> +	};
>> +
>> +	clocks {
>> +		main_xtal: clock-mainxtal {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		 slow_xtal: clock-slowxtal {
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +	};
>> +
>> +	soc {
>> +		compatible = "simple-bus";
>> +		ranges;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		pioa: pinctrl@e0014000 {
>> +			compatible = "microchip,sama7d65-pinctrl";
>> +			reg = <0xe0014000 0x800>;
>> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +		};
>> +
>> +		pmc: clock-controller@e0018000 {
>> +			compatible = "microchip,sama7d65-pmc", "syscon";
>> +			reg = <0xe0018000 0x200>;
>> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			#clock-cells = <2>;
>> +			clocks = <&clk32k 1>, <&clk32k 0>, <&main_xtal>;
>> +			clock-names = "td_slck", "md_slck", "main_xtal";
>> +		};
>> +
>> +		clk32k: clock-controller@e001d500 {
>> +			compatible = "microchip,sama7d65-sckc", "microchip,sam9x60-sckc";
>> +			reg = <0xe001d500 0x4>;
>> +			clocks = <&slow_xtal>;
>> +			#clock-cells = <1>;
>> +		};
>> +
>> +		sdmmc1: mmc@e1208000 {
>> +			compatible = "microchip,sama7d65-sdhci", "microchip,sam9x60-sdhci";
>> +			reg = <0xe1208000 0x400>;
>> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 76>, <&pmc PMC_TYPE_GCK 76>;
>> +			clock-names = "hclock", "multclk";
>> +			assigned-clocks = <&pmc PMC_TYPE_GCK 76>;
>> +			assigned-clock-rates = <200000000>;
>> +			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_MCK1>;
>> +			status = "disabled";
>> +		};
>> +
>> +		pit64b0: timer@e1800000 {
>> +			compatible = "microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b";
>> +			reg = <0xe1800000 0x100>;
>> +			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 66>, <&pmc PMC_TYPE_GCK 66>;
>> +			clock-names = "pclk", "gclk";
>> +		};
>> +
>> +		pit64b1: timer@e1804000 {
>> +			compatible = "microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b";
>> +			reg = <0xe1804000 0x100>;
>> +			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 67>, <&pmc PMC_TYPE_GCK 67>;
>> +			clock-names = "pclk", "gclk";
>> +		};
>> +
>> +		flx6: flexcom@e2020000 {
>> +			compatible = "microchip,sama7d65-flexcom", "atmel,sama5d2-flexcom";
>> +			reg = <0xe2020000 0x200>;
>> +			ranges = <0x0 0xe2020000 0x800>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 40>;
>> +			status = "disabled";
>> +
>> +			uart6: serial@200 {
>> +				compatible = "microchip,sama7d65-usart", "atmel,at91sam9260-usart";
>> +				reg = <0x200 0x200>;
>> +				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
> 
> Vendor specific props would be at the end, before states, according to [1].
> I'll adjust it while applying.
> 
> [1]

This is the link, sorry:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n122

Other than that:
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

