Return-Path: <linux-spi+bounces-11142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F6C46B20
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 13:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 002DE4E234F
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D941096F;
	Mon, 10 Nov 2025 12:49:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA330CDA1
	for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778991; cv=none; b=WTOgSa4JlCw1o0Qh/YOU5STNffD3F1dHQtPSepYEwATe7nSI1VL81kcjSwhmpxM2o3idC7d4c9nU6zKf6m0mwHDrT0bSixbNeWvGOEVDRuUjww0CqHiCH4oKAxUR4bWFa8UQz8P5F4w5mEWc0ZQPYm78ZDQenGDxLiWbRLU7rSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778991; c=relaxed/simple;
	bh=cAw6KDVicFMiZpuDduunfg3+w/yg4gN+HRNZWYDOi/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCK+K5AAhyGkb9zaSyetAbHUxhS/eoePpXIxNDTATbqY1tlTWSVEazeSGZjXm9xVck2YgCltL6xAN1J4hB+UzDByXW08wGjTSJBXm/hhJSsbpt/OBxiWZNDbv8vbqbT8qZPEME3fNrJHDILABv+mxMHO6lKfq3aHB0RYBJZfi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54aa30f4093so716294e0c.3
        for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 04:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778988; x=1763383788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh17CiieclZAsVeAhUA/WaKqsZ8PVmhh++ya3iPI2Ik=;
        b=NVGtIxFt40+ed36C9u3Cn1d9J5fJHdw6BnIm8qgnufPtcw1OXu7xe3UqUaie5539pk
         BWpgKBObSB5nL06JyKcvIUZAthmGzzqW5gdQEVNw7LYwQREt5qRREjCs2i00kakLv1dI
         vioLKjQvOMtGaJ7B1f9fBQDxNhgGr6tD5eXM/ayMSb3Kv17k6LJ7T+VxSFXmRERcSx9u
         Sk6OC08ZxlRRb4eZarCfPsDq1PwrbAzCyFwGNZ1ioVCI7HPq1ikmLYCxiXVtBXKuxx+d
         HY75t26RB8K9v2ywgyL07rPKbH/JHRXHXNlEwEaWCoKnbofows4DW8Ti90cFAVynEdJB
         VpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsCOn3qURQ6kYsEYNWuOL72hppGSeQXY3De5DNmW7gDHeRCMriYDDphjvsRGlnJXmCrjG6+ml2uvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJAkMbdJ7sbZiCvh6CQMyu2KT0zoHyx8zoXoEFmBoyDwmRkZp
	oHHHzJGoELS9hz9t1y5QOfUmSy3Gul34sSxYZ1m342pObpnoIGYubPDnbTD6Pj/h
X-Gm-Gg: ASbGncuOZjRQ0rCtavLyGR2GQwlslfflYdrVuyXrHGMzcka7AdQ9qGyngoJyLDYfhYl
	jaBBsR41plCfORZBZ5hxKcyxJRhE6VBNJ7L+WdpEPflGO4pwRwnq62zasTcQ6JBhmUqRnYYctXT
	JRsMZN/X4iciV3AAbPFTj5w69FO6F95Mm2y/IPk80mjMEeBADpiZNpx/OzOSweFmoP1lPXdqc4a
	7iPWMdLVh1hfB9IsR1Ge74FRzuYNWQJLgq9/sWYd2vBGdMX7q52NA5PD6sqSOd+LwI53dpv6POH
	HPYJL2nVQBqXtp21g9LWGY50/BJK4QPo1sN3js42WiljLf/6dbwPAD8/ocuX78xHzCEOqx3r8eL
	qwh/IZHCGVKi63acUC4nc1cQwDrAMef3TbXXQPk5jZ28tG5EzVlA4PUCaKZ42XBcq7FuadZCTSq
	i/KCmFMhxypWba+N1vNgp2jAAWsm5Y9TX7z2boZg==
X-Google-Smtp-Source: AGHT+IHCPygpopxRWOERWdaoX78f5sy2cLijAxTCpK4GWK54SYfK+vKPFK+cBWe8kGmXPy8EkqM9DQ==
X-Received: by 2002:a05:6102:370c:b0:5db:f8aa:3a41 with SMTP id ada2fe7eead31-5ddc47e3395mr2179919137.27.1762778988121;
        Mon, 10 Nov 2025 04:49:48 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda1d296cfsm5773382137.5.2025.11.10.04.49.47
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:49:47 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dd6fbe5091so1097014137.1
        for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 04:49:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtcIvucFfcoIEMZpRQdsoo0oVfBdVK0tZ0xNGBsJj2ietFQdzNkLWqYzBl48jVMSXS5qmXoZLXtd4=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0a:b0:5db:f352:afbd with SMTP id
 ada2fe7eead31-5ddc467ebffmr2222725137.3.1762778986813; Mon, 10 Nov 2025
 04:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251105104151.1489281-12-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251105104151.1489281-12-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 13:49:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWTH_uuQURgqQrg1RGDMwzdDAWFk__mS9+Gc8mcESfUyA@mail.gmail.com>
X-Gm-Features: AWmQ_bkfRzk8FN2qNNCBLlLG0XaTRUdRgwFG7IJoHivC4Q2Ld9wLwHCuz85ymR8
Message-ID: <CAMuHMdWTH_uuQURgqQrg1RGDMwzdDAWFk__mS9+Gc8mcESfUyA@mail.gmail.com>
Subject: Re: [PATCH v3 11/14] dt-bindings: spi: renesas,rzv2h-rspi: document
 RZ/T2H and RZ/N2H
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 5 Nov 2025 at 11:44, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
> peripherals.
>
> Compared to the previously supported RZ/V2H, these SoCs have a smaller
> FIFO, no resets, and only two clocks: PCLKSPIn and PCLK. PCLKSPIn,
> being the clock from which the SPI transfer clock is generated, is the
> equivalent of the TCLK from V2H.
>
> Document them, and use RZ/T2H as a fallback for RZ/N2H as the SPIs are
> entirely compatible.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
> @@ -9,12 +9,15 @@ title: Renesas RZ/V2H(P) Renesas Serial Peripheral Interface (RSPI)
>  maintainers:
>    - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
> -    const: renesas,r9a09g057-rspi # RZ/V2H(P)
> +    oneOf:
> +      - enum:
> +          - renesas,r9a09g057-rspi # RZ/V2H(P)
> +          - renesas,r9a09g077-rspi # RZ/T2H
> +      - items:
> +          - const: renesas,r9a09g087-rspi # RZ/N2H
> +          - const: renesas,r9a09g077-rspi # RZ/T2H
>
>    reg:
>      maxItems: 1
> @@ -36,13 +39,12 @@ properties:
>        - const: tx
>
>    clocks:
> +    minItems: 2
>      maxItems: 3
>
>    clock-names:
> -    items:
> -      - const: pclk
> -      - const: pclk_sfr
> -      - const: tclk
> +    minItems: 2
> +    maxItems: 3
>
>    resets:
>      maxItems: 2
> @@ -62,12 +64,55 @@ required:
>    - interrupt-names
>    - clocks
>    - clock-names
> -  - resets
> -  - reset-names
>    - power-domains
>    - '#address-cells'
>    - '#size-cells'
>
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g057-rspi
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3

No need for maxItems here (already at 3 above).

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g077-rspi
> +              - renesas,r9a09g087-rspi

No need for renesas,r9a09g087-rspi, as it implies renesas,r9a09g077-rspi
is present, too.

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2

No need for minItems.

> +          maxItems: 2

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

