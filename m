Return-Path: <linux-spi+bounces-12090-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD06CD99EC
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 15:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4185D30422BF
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759530BF6C;
	Tue, 23 Dec 2025 14:25:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202102D876B
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499936; cv=none; b=upNkWYYobH2mvgmS6BZlR+3RoqyoPdGv5kLNeetwBBtIQus4KPVsYcAiiAE5prpTkusixqRo/TS/Z3MudvpvMevAferGlO8ewdXPOQSmZ0zpeykuYTS/NxzuA5K/YFrD0aRmg50s3+sTwNstHfzbPTgAl6xE48GkAp5mrbSBA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499936; c=relaxed/simple;
	bh=p/yCjY8u171GpGGHaFI9kezO5mhBvA9uh3H/9co9+sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0HIXav+I+3SovHLrETnFeNFLNiJ/Mpuy/MlwAIkbGwJz9VnNFiKTiZTRcmwKx/LYiy5lMQ0SyAbWqEKdm+QtevZBpNlokJg0xraxF5ZD0v3X/Nyp6S2Mm7230AGyNVT9eh+OYXlnF+1QLJMc6CzKAn4NGDLey/M+R6yZb2zb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso3909495e0c.0
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 06:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766499934; x=1767104734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIC0rikwFGHXRYQ21Y9JsVA9Qraw4AvBReoBxo8fio0=;
        b=d4AvehXRXxnzlg65Xc8A9P1vwDakx9wjq9z0fwShdq5mjxnO14P/f5wfGH0Ahoazst
         0qAI9GfWdjNY4fTA/weV+xFhHQSdak13etsSpZJrK9ZvYhWdVz8x/bGIi7A/dwy/kiZY
         VAzbX5gl08fQvUb10EUv+8Jak4PJg/CnUwzHUsB7G0LpxTKWiSxkY1tPuWDhHk9Afv22
         6xh/eWbhFv6TtVPoBQnIBFG5PA9NOc2vNKC8b9HUdY5CtRAi2X8g5PWYD7yQGTRXIo6V
         Czelies6ybfpKAi8o0/0m3Kl6YH08zP5Yom95frYbCVOokDyj25BsIEaWRXp64u7IGiv
         6CjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW2XInR6AiC/MPgXf4+mz7H6K5WP54aknx5Qq4WZzWRZHDCGYCTLeEnYlKUTOEMqa7g8Gz61JiERw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+DlKId3xYNrPGxNa3AC5DlhiSR459d7nwS0+zyA+WHz9eNmX
	J0yMU6QtM1V2CITTTsXq1m7rSYkZlnd9kGzUGX9R/EsJyUDP2SrudRfO0D+8jXf1cME=
X-Gm-Gg: AY/fxX7/yldgkjpzJSEQQ5VNa4tn7gnNUfA/8/3Sxh4jCEOIeK3B2LLv5sFL09XkaTB
	QWZVmYEwnAO0Rmhlxa7UvtaHS/uEG8FFpja2kms5czWlxoPMtU6w8nOy0b6aGNdWRR2pAQahn23
	AGNdoZzyM2PzX+dshFUuEt9UFFWse8+4Ti+e3dWIaccgttCKdhSM0Ph+g6LA3zopzJMkCSIEZJ3
	geUdquKBloiiyrj8rrBx3FqxFCH73DgYksnF06dIwkiziqvuQc0KtlmLmk+VD5bG704KHSFpHR/
	0udCs4WWsUxGxC8+7K51UiHvs/xoa2vtq83ZOFJXMV3L2m+Q3rCSHiXvbiZpw+RcyP2nlhuPCeD
	ZWcFKcRmYopgpW9JF92ADiClhCXoEd0ZIm6pZFo0C730XWiZqwMOmHBWUZol/uaEAy/rn/7wCWO
	mA0Pv0OgAFRNDX6kY/ZJTTB6Vy53blJvGsD3FI4FsLvHKAs5zK
X-Google-Smtp-Source: AGHT+IEVfHw35HOP6WEfInV9XSOCaHj5uQ0/v073amq4EYgKnTjHbs7H/JjyC5stIjgKSIUxDKJS7A==
X-Received: by 2002:a05:6122:8c1c:b0:55c:be5e:e9e9 with SMTP id 71dfb90a1353d-5615b71d68cmr4284219e0c.1.1766499934008;
        Tue, 23 Dec 2025 06:25:34 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d04b90esm4437810e0c.2.2025.12.23.06.25.33
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 06:25:33 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dbde7f4341so4678807137.1
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 06:25:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnDdfEocAh08y2rszClfMOFRO9xMg5LceLBkSdNueJgUE+QpZuqDqJ5BdwZT9NhGF8wWk4D9CsjAo=@vger.kernel.org
X-Received: by 2002:a05:6102:3f56:b0:584:7aa3:a329 with SMTP id
 ada2fe7eead31-5eb0237d7f4mr7071522137.4.1766499933176; Tue, 23 Dec 2025
 06:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251201134229.600817-14-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251201134229.600817-14-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Dec 2025 15:25:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNmx=o4Vi=2o4BcBpkV6gjeOj9CEbbkYMtdVTOakhv0Q@mail.gmail.com>
X-Gm-Features: AQt7F2oCaB4_nkSocOGONFf0pCyIN-Ja9bMJ4xn0DqXAemYEO2QdHhg1pDxyWjU
Message-ID: <CAMuHMdUNmx=o4Vi=2o4BcBpkV6gjeOj9CEbbkYMtdVTOakhv0Q@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm64: dts: renesas: r9a09g087: wire up DMA support
 for SPI
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Mon, 1 Dec 2025 at 14:44, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> RZ/N2H (R9A09G087) has three DMA controllers that can be used by
> peripherals like SPI to offload data transfers from the CPU.
>
> Wire up the DMA channels for the SPI peripherals.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> @@ -200,6 +200,8 @@ rspi0: spi@80007000 {
>                         clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKM>,
>                                  <&cpg CPG_MOD 104>;
>                         clock-names = "pclk", "pclkspi";
> +                       dmas = <&dmac0 0x267a>, <&dmac0 0x267b>;
> +                       dma-names = "rx", "tx";

Same comment as for RZ/T2H:
RZ/N2H does not seem to have restrictions about which DMA controllers
can be used by which SPI instance.  Hence shouldn't these point to
all three DMA controllers?

    dmas = <&dmac0 0x267a>, <&dmac0 0x267b>,
           <&dmac1 0x267a>, <&dmac1 0x267b>,
           <&dmac2 0x267a>, <&dmac2 0x267b>;
    dma-names = "rx", "tx", "rx", "tx", "rx", "tx";

Note that this requires updating the DT bindings, as they currently
restrict dma to two entries.

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

