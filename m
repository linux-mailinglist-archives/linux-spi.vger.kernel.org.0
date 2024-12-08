Return-Path: <linux-spi+bounces-5953-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B510B9E8648
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 17:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8599F1883DAC
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E574C15B111;
	Sun,  8 Dec 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="awQBEbSP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184BC13BAD5
	for <linux-spi@vger.kernel.org>; Sun,  8 Dec 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675076; cv=none; b=csbc2AJ37iLf+2L/GswR5qI01XPrjGxhYZ0YYl0Q6XLay9ppob+CgU91Hfu/7X8nMAiyA6DvM2l9UtbjSEF44aCHDeLMbh0fYeVlxzwhSS0xnLak/5O1hxe8nJ6JFQ4IrWJp7tB7UWh3vFLxcuP3jOzzJGKOPry7ZFQWMjkyqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675076; c=relaxed/simple;
	bh=7AyePrUCCceG5nNGPQoJolQM6pDEWgWD/I9Ohawbcaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyznqWuz4VagIz0S632LUGWEeuYVqNXIbQ3Zw6PzR0Y9HgrJMRhJCBbi1IG7rArZcxbQ4a9i+gglFwyUopfxGcH4aBgNBMWOjXDuo0r+oToemSMRQJMEYLue5JcsxSpuxhexE2L3JMcSYISX9B/lpGLO8SgmenmBPmnqhRNv7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=awQBEbSP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so5218988a12.2
        for <linux-spi@vger.kernel.org>; Sun, 08 Dec 2024 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675073; x=1734279873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eh1CIoBeFUziJxoNrnv+29bhukgqRk2MFaYe/1KQX/o=;
        b=awQBEbSPqvZXZYqXNTUicfmuJhhVW+3mGJQLy/9vVTI3toNpVarDSJlsE6vfUUMLSi
         7D2t+o9whFxNUG1vkBy7ebcUg4O+1XQ0nRlj0quGG8mwtdOXoiLgCBNP2Bw64t0XsoLb
         /FnCApHfm1bT15VWAKjrwAt472T7KGdlqIINzU+GohnBmWGDH8aTj8YX+VsPobiddxtW
         RMqSYd975z7J3p5F64YyWcnq1ihPust5MmJrpAOSXft6/KXMRdXE9D7q61l8KBDId9tH
         mrt0ZEpqBCLoqgQsEun/8iLHlky4sqUU547ff26eT6tFs096vr9JCk2mRUm8TTUeDhHM
         s/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675073; x=1734279873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eh1CIoBeFUziJxoNrnv+29bhukgqRk2MFaYe/1KQX/o=;
        b=d44FdLiLwKFzbqYUE+l2aRtu29yihNyslwhdP2gHIVXV+PflvtT40MFYmpEkZk4B8n
         fxnNhwRLvfb6kf2WAgom682c+p61XfoSYqQF8a8Hu1IbrV2e6dGf2Fts1fU9iEJcBE3T
         il3xlR/cUdCSaZbuTM3JHsCrh8wotjvo6hCpTI/T65Szw6B7ueEfS7S2oiRss1GPkFcg
         GD694tWq9vFgoH37z3a3qL1UCDwKftUDRB/YQiIStlQTk3WSvysLFTtzFXzhIuGkCx4I
         wCpcSQeMuHNKlfI9Ox5uYQhM04QhROAM3dEeN+feEXXdjOBitnuZ5RoPWbYGvsAXiGW0
         L/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCURnhrlpKEp2ftngZMVcPly5EW0bP8nkWJcCRGiqJp24jgFMPeSYgolWWPSDyK9Ify2Z/0a6qZkXJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxsm9BcxDb2rctDqZAAsAYlH1iVDuNsxkL2S+RoIOc1o9GyYm
	deP4mR3Utu4pEQMG6ZqgKTBu1ib2UZqZMgOXYPBx2o6u20IS3JX84EOF0abEqD8=
X-Gm-Gg: ASbGncvrLYIvd3vY33cO+xF6lW9F4TEdDzOd38cd5NI1lqL2CpIs5Kp0RYxmETw0ijF
	Mvn8OC0D3SET5Sw38CGJ3C1UP+48NHI7F6UtDIUOkwMZ1I6RmF6y2Kf7gf/YT6l955Sr0XK2CmI
	gJxXy3yg60U0R263WBRgyQMDbc1X0Z9mGeivO0jHgLaSRlIXi2ZOURQ1WLR3xh3cQ5Mr0M+q/SS
	/gPkFwzO6dgZMFrNfiU3wV92QlKlAcaDfY6xX7i0DcY4ChEIJDKME0lPxg=
X-Google-Smtp-Source: AGHT+IHRoC+uz24+SDiz4k1n+xkzf1xmfd4qsGqHEUgJq24njDiwFPRzIM3Y17oVpekHri48dC1Rtg==
X-Received: by 2002:a05:6402:35cb:b0:5d4:5e4:1561 with SMTP id 4fb4d7f45d1cf-5d405e4170fmr164597a12.20.1733675073180;
        Sun, 08 Dec 2024 08:24:33 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49e48sm4883698a12.30.2024.12.08.08.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:24:32 -0800 (PST)
Message-ID: <e592e292-71df-4bf0-aa8e-88a53dfc2777@tuxon.dev>
Date: Sun, 8 Dec 2024 18:24:29 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] dt-bindings: atmel-sysreg: add sama7d65 RAM and
 PIT
Content-Language: en-US
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
 <96e64f01eee264ad0ac4c720a7a1cab4f95c206b.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <96e64f01eee264ad0ac4c720a7a1cab4f95c206b.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add SAMA7D65 RAM controller, PIT64 DT bindings.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/arm/atmel-sysregs.txt      | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index 76e2b7978250..93c2a5a341f3 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -13,6 +13,7 @@ PIT Timer required properties:
>  PIT64B Timer required properties:
>  - compatible: Should be "microchip,sam9x60-pit64b" or
>  			"microchip,sam9x7-pit64b", "microchip,sam9x60-pit64b"
> +			"microchip,sama7d65-pit64b", "microchip,sam9x60-pit64b"
>  - reg: Should contain registers location and length
>  - interrupts: Should contain interrupt for PIT64B timer
>  - clocks: Should contain the available clock sources for PIT64B timer.
> @@ -27,12 +28,13 @@ Its subnodes can be:
>  - watchdog: compatible should be "atmel,at91rm9200-wdt"
>  
>  RAMC SDRAM/DDR Controller required properties:
> -- compatible: Should be "atmel,at91rm9200-sdramc", "syscon"
> -			"atmel,at91sam9260-sdramc",
> -			"atmel,at91sam9g45-ddramc",
> -			"atmel,sama5d3-ddramc",
> -			"microchip,sam9x60-ddramc",
> -			"microchip,sama7g5-uddrc",
> +- compatible: Should be "atmel,at91rm9200-sdramc", "syscon" or
> +			"atmel,at91sam9260-sdramc" or
> +			"atmel,at91sam9g45-ddramc" or
> +			"atmel,sama5d3-ddramc" or
> +			"microchip,sam9x60-ddramc" or
> +			"microchip,sama7g5-uddrc" or
> +			"microchip,sama7d65-uddrc","microchip,sama7g5-uddrc" or

Missing space here --------------------------------^

I'll adjust it while applying.

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

>  			"microchip,sam9x7-ddramc", "atmel,sama5d3-ddramc".
>  - reg: Should contain registers location and length
>  

