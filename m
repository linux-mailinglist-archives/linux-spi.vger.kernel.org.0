Return-Path: <linux-spi+bounces-6206-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EAB9FF8DC
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2025 12:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BEE188081F
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jan 2025 11:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D21AC88B;
	Thu,  2 Jan 2025 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="EM43osrj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA4195B33
	for <linux-spi@vger.kernel.org>; Thu,  2 Jan 2025 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817677; cv=none; b=OG11cgmm/wRrlm8PElJZi8/I9GTGfcNjmYGnHxjA8STzcDY/bzMc9zwD0oEWFW1ioT+/gGFMuPHgBjFdCnFsfNqqs+5nna2q4PA6WZzI38lt/KnW7a1CLRygNHbP9YkyAzRjaRo9445K2nuXFv96h8v7W9KjSaFg84p8LpO/7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817677; c=relaxed/simple;
	bh=xZk5juEQTblPG6mT+mOtIaKkOYTA19ECmOyXXFnW3A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFtQWqWCzyTYhzKjZAqmVeHM4LBGgRsH2c6C+XBGForMZqLvNRc1UF7VI1uewt/b2TMv74Iqj5b/RtSmkbSdw5LGo2tMLa+vm+2c0jr7aXnUa+Az5beSA33LF+bcOWfV0fW1CbdTAi4rhKCheZ2yXndH/ehFEYDKUNqKJWUAYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=EM43osrj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa68b513abcso2095840266b.0
        for <linux-spi@vger.kernel.org>; Thu, 02 Jan 2025 03:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735817674; x=1736422474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJuTW2/wmv0Cni895FL84+N2QJ2H1fwMgsWcI7DGnW4=;
        b=EM43osrjrSM15bPSCvRGvVR7Qmi1JctNay6HwZePyE0XwIjVEsfPuCmPRoykfMBIVe
         EFejN/PzJGRW99/Zl+4S/u+k+wRbuaArdWcBNRmtNvwhsSepcY2aly2Ef/O8m0ewNfVL
         SEMVZsV5Xrry2p7etoQBMXACAdPGCxGHSh6n8D2fim7yt4ttWzlyrWcYpYpiTjruGklM
         MxqgaIRCBJSpPvG5wHKSVKoeoaTZqc6bd07MHoI/3p7WizITXFj1M/sp+T/esZ1fLI8C
         WlKyll5dP+DAApSR6ScRLLXlC1jPCvJOLKbFnio75pcv1ZaahlvrvnrKU/770e6ZKOLR
         Q1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735817674; x=1736422474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJuTW2/wmv0Cni895FL84+N2QJ2H1fwMgsWcI7DGnW4=;
        b=e2oJVG0OfHUFVikYC17yTx07/wKDVgo9nojxYj8ae7GKWGlbbSGVHrUBOxGxIEc0pJ
         HTJokTTL5W8lNlAX9Di+axaFKRyIOKdPgtZuexbB3Q++HNNulhKVfrmUH4g5sxAiZALP
         qMeZbCwZ/NDuAy5qb4kFLqGkUaBKriXe4pvblF61qAJHRnD1cbbP4nLAx5RUs+izxgkl
         b/JYkMy+1hLaaAePtkTnzJLolGX0rW9r2EeXcL4ua/tkMmhIQgZL3gHo9Jbtu3McYhrB
         PJYXtZohTMu90iJ2UEceEm++JTMaVdsZRKU2wzLzZL7avircFlZi8O9G+jtnHIG9f1DX
         8oOA==
X-Forwarded-Encrypted: i=1; AJvYcCVkRq4rWyQP1TGBgxaqTD9K3yhrqG/ezGxf/njh4blJEjD3cvviI4MgCbUINSuInKJxqY1G8SZiYtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMvGhyizuYMA2Viul9XO6cYymVO7KPu7cqsxE2w2+ArXCFaW2
	3MfbrJV4/c06rh8YaBBDGDmjkbGJ+lEFnA5KNiVcvxC/so9E5Vq5vsVpaFidrOM=
X-Gm-Gg: ASbGnctivK8fKa8Unh0UOgSb1dgPqkEhMYGWDyC9zQs/CnyHu0JDRMTrdBRdfMcVtH1
	s+XHf/RdA2Ar3Er1ybSGAusuHOsxedoNnmV+mzuR00CR3lGyeH8Q4AL8gXAfMGADQoG1ZrPVMpF
	z1C44arvY26uZF6vj87W4JcT5Bq6w/9rU6prV+0m0tVeZ2IBA+8GnalGIpt82VaG/mh88tjo/Mh
	meIfNnDhwKZf+GwCCrhWwIghiWJAQKaCADf14hYEd0lB+IuBcfd/sTunJXM+v0NYA==
X-Google-Smtp-Source: AGHT+IGIlULUY5OVKXjFZRKGpQ2k3iKZcvVspZWtEdWr47v7SWAFqOFAYEk9fc6/cC6JF/XKlQkXSw==
X-Received: by 2002:a17:907:97c5:b0:aac:431:4ee7 with SMTP id a640c23a62f3a-aac2883fe8fmr4247597966b.5.1735817674243;
        Thu, 02 Jan 2025 03:34:34 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e830daasm1761964966b.13.2025.01.02.03.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 03:34:33 -0800 (PST)
Message-ID: <9f2025e3-5ec6-4a7d-8a4f-d04b343da912@tuxon.dev>
Date: Thu, 2 Jan 2025 13:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] Add support for SAMA7D65
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
References: <cover.1734723585.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cover.1734723585.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20.12.2024 23:07, Ryan.Wanner@microchip.com wrote:

[ ... ]

>   dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT

Was already applied from v3

>   dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
>   dt-bindings: clock: Add SAMA7D65 PMC compatible string

Was already applied from v3

>   dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity

Was already applied from v3

>   clk: at91: sama7d65: add sama7d65 pmc driver

Applied to clk-microchip

>   ARM: dts: at91: Add sama7d65 pinmux

Was already applied from v3

>   ARM: configs: at91: sama7: add new SoC config

Was apready applied from v3

>   ARM: at91: add new SoC sama7d65

Applied to at91-soc, thanks!

