Return-Path: <linux-spi+bounces-5767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C589D366E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5FE2850BB
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635319B3F9;
	Wed, 20 Nov 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj2jZhdX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9319ABA3;
	Wed, 20 Nov 2024 09:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093682; cv=none; b=Xy29Xf1Vt6FRRjv7usukQw+8Iuv4uFzNGCxn6Fj8iQTP8rI5nzEZ/zPySv3lkOwjWk8tgb3cXAW3iW4DRiP2An62Biin9ww8I5KgksooYMvkkrGaKePYzQvhtGnLUa3z89RDmngsGxa5goqT9Rdx42QePHC8FzFBVtOn7qaPvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093682; c=relaxed/simple;
	bh=IQcj0bjfdOfYI6t7QqB+CTdJu2i+/2bIawSzJun9Uik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB5i+87ERAyDGedI8FgCYkWv8AHbjfsxnkyiVmPVr+k6DFczxcu84Q19nvCKjTsmfsW3xicEwxtBFZZPxdol8Ooy6trcpU2gmEagBNT/zGmpAbFB2fPXjE0KJ0aFNKn477eg45im8P6IDYkRGlgLLfoJkOwzHrnFr1kknfiob38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj2jZhdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB3BC4CED0;
	Wed, 20 Nov 2024 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093681;
	bh=IQcj0bjfdOfYI6t7QqB+CTdJu2i+/2bIawSzJun9Uik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj2jZhdXjtBIQEOsHjFk4BjSvr0ATtxMhD8ujOgIHUXiQ4+ddi0M2p5MPhcAGITT1
	 sFlAkiZhFN3WjK7iwy3JYRt6YqE8ElBaTGHt5u9Fgv72fY/JbBZOPNqadwjEXWctwS
	 7irH3yWcpsf6/DVGimzad81rT6KZ4r7vpgk5I4ELv0DVKaMW/i+TILxAs5XNk6uGzV
	 2GRRd09W1KZZdilgqHVn1kvKK3Te1uslSNh4K2BVZ3U6YcptdkHVnDg/UDemU6eqje
	 L6ePJJ/xeHxJnEy1kp7JqgXB0Rm1dwh7/VVFeTA/0Leb9Z/C1AnryMmV1hksKRoAOQ
	 qjFAa1jk9lu1w==
Date: Wed, 20 Nov 2024 10:07:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 12/15] ARM: dts: microchip: add support for
 sama7d65_curiosity board
Message-ID: <y5pggfi3mc6so4p53uycvjewnwm6xprl5a7f455dbucnbkuqkq@4uwgltnplxp5>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <7877f8c4cce78de34a6bdcc13fc78f5f0ebde06b.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7877f8c4cce78de34a6bdcc13fc78f5f0ebde06b.1732030972.git.Ryan.Wanner@microchip.com>

On Tue, Nov 19, 2024 at 09:40:18AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Romain Sioen <romain.sioen@microchip.com>
> 
> Add device tree support for the SAMA7D65 Curiosity board.
> Update the Makefile to include the new device tree file.
> 
> uart6 is related to flexcom6, hence not sorted in alphabetical order.
> 
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/Makefile          |   3 +
>  .../dts/microchip/at91-sama7d65_curiosity.dts |  89 ++
>  .../arm/boot/dts/microchip/sama7d65-pinfunc.h | 947 ++++++++++++++++++
>  3 files changed, 1039 insertions(+)
>  create mode 100644 arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
>  create mode 100644 arch/arm/boot/dts/microchip/sama7d65-pinfunc.h
> 
> diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
> index 470fe46433a9..79cd38fdc7da 100644
> --- a/arch/arm/boot/dts/microchip/Makefile
> +++ b/arch/arm/boot/dts/microchip/Makefile
> @@ -12,6 +12,7 @@ DTC_FLAGS_at91-sama5d2_xplained := -@
>  DTC_FLAGS_at91-sama5d3_eds := -@
>  DTC_FLAGS_at91-sama5d3_xplained := -@
>  DTC_FLAGS_at91-sama5d4_xplained := -@
> +DTC_FLAGS_at91-sama7d65_curiosity := -@
>  DTC_FLAGS_at91-sama7g54_curiosity := -@
>  DTC_FLAGS_at91-sama7g5ek := -@
>  dtb-$(CONFIG_SOC_AT91RM9200) += \
> @@ -90,6 +91,8 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>  	at91-sama5d4_xplained.dtb \
>  	at91-sama5d4ek.dtb \
>  	at91-vinco.dtb
> +dtb-$(CONFIG_SOC_SAMA7D65) += \
> +	at91-sama7d65_curiosity.dtb
>  dtb-$(CONFIG_SOC_SAMA7G5) += \
>  	at91-sama7g54_curiosity.dtb \
>  	at91-sama7g5ek.dtb
> diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> new file mode 100644
> index 000000000000..c307c5a58b74
> --- /dev/null
> +++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + *  at91-sama7d65_curiosity.dts - Device Tree file for SAMA7D65 Curiosity board
> + *
> + *  Copyright (c) 2024 Microchip Technology Inc. and its subsidiaries
> + *
> + *  Author: Romain Sioen <romain.sioen@microchip.com>
> + *
> + */
> +/dts-v1/;
> +#include "sama7d65-pinfunc.h"
> +#include "sama7d65.dtsi"
> +#include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <dt-bindings/pinctrl/at91.h>
> +
> +/ {
> +	model = "Microchip SAMA7D65 Curiosity";
> +	compatible = "microchip,sama7d65-curiosity", "microchip,sama7d65", "microchip,sama7d6", "microchip,sama7";

Please wrap code according to coding style (checkpatch is not a coding
style description but only a tool).

> +
> +	chosen {
> +		bootargs = "rw root=/dev/mmcblk0p2 rootfstype=ext4 rootwait";

Drop, not really correct. My board uses read-only root and ext2.

> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	aliases {
> +		serial0 = &uart6;
> +	};
> +
> +	memory@60000000 {
> +		device_type = "memory";
> +		reg = <0x60000000 0x40000000>;
> +	};
> +};

Best regards,
Krzysztof


