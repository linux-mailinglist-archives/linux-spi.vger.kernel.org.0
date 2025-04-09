Return-Path: <linux-spi+bounces-7482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55169A81F7D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 10:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7154B3A6D51
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056525B67B;
	Wed,  9 Apr 2025 08:09:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A222AEE1;
	Wed,  9 Apr 2025 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186188; cv=none; b=bbCgVoPt5501a7fqLubgX4tlZ9vqtmOCOGkz4ZhqseLUawk7sOWiBJPOy5r6mhV0sp8d1Spg/cS8jTTkr9Brfduw+c1huVl9OkZrfOyk3daH5LG4xiXRkClKp/O876juha9N3nK6PZcbZ96b7jVseIJc9OuANev7ttTm51OX7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186188; c=relaxed/simple;
	bh=O9VKYPgUiYOF6QG0TYrN74zLhmgZxCM50jx4cMeo1yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/N0acQfOu7iZQIrmX80MtBc7N0/visIjfOq+D7a0dmKbyYkc7xMTwzSzuY9xIqKdFKlvgebauy2uuuaK3XDlrHcnohHuEJ5Ymbx4g1Sxz6VkdYNaBGEprkm610p6sBCGPjiHPcgN5tuOtOcjlJdO7xFe3goY987KAjnBHBDPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso12304473a12.2;
        Wed, 09 Apr 2025 01:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744186182; x=1744790982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YudH65NukHHSr89Gl9yDFVGr5wwqRPWuAzpL5BE/Uv4=;
        b=nEM0AQ5oSSLW2P5fAt6V+u65e8MmsTUFsP0hSEetyqDt73GX+UOpFY07c271UNDydU
         Od0QUzG1mNiS671UhFsboKNJPQEwTFW4KfkUq3y9DRC2S/9Ex2mdCkgZPjOZHyzMtfvs
         FN7g70bZJao3sZ6GWLx3ARwpoS7ZcHaznE8AxJsQHQL6owvHXKEEVdM2n0VtkxmkvAXw
         q+BvN73sqdYHDRG9+ck31DUnn+KAgjqQSWm18X5GCw9yxJKNiexxBlDPgzXm0GDtT1P7
         3gjQBIghW4CP0Yyz9O47Ad27MroLeuymL4F+ScKBmyEjWnTP99MJRV/bFDEakt2gKqoJ
         MYog==
X-Forwarded-Encrypted: i=1; AJvYcCU6fNf+NxCQxQMSHiwHRx7QeSL6agjq4GSNv5qLA1ZfKzE7PVSQOeiknCHw/5JgRxxBA1vDlb+bQn7dkO4=@vger.kernel.org, AJvYcCV53XVYa0iWKQdlUX/5t1qmfgPUVc8DtGJH2d9X06bh8p5kER6Y9qDujAraPK8Ff+jow7WWzsCUi55m@vger.kernel.org, AJvYcCWn6r4H2EG1+pEGq3YbNs6xeY5klW5I2/0ljdxkeT6cB9uj9qOMgZAuZ68kZC4v14c0bPZyX7a37CztVw9F961ys3w=@vger.kernel.org, AJvYcCXPogWlmLWgnQg6RyqZFINSc6FMn4oGSgOmDQInU6K2suhb3jy2A3BwUXFjJK/zjS0KndhAVOy83m52@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyEx0F0WZA74n+bOd9stuhjW7NUrUg4G8W3g62VjI7+t8I4D9
	+jy3XiVaHrmUNGl+GspCSVffbUuhkPqD4SgRqgfzeK0q9jLj52APeNndeKq5xFg=
X-Gm-Gg: ASbGncuZnCkfXhHE2Kh2TDMQwPTuIdrTb8tCSh3J1hihVzwYm5edBZq0oPcNk8BMCGk
	OdUOVVZlNhzzfBdmcSioQc1/sfxGUI7B2Js3LaajpOFJ6nkIfHaugY1prrU65DMR5F+bgAzuPcL
	9G2j+9mLmPJX/Im2zy808+gGcPd0v0voEzyukRRvuEOu8kYJomLPDcA5JwmL3nGMo7RHvwHfw41
	pkwWC9ppAsA/O/AoZD/dbe1yrUU/CiLjqcfHnIlJ5DwqCw+olGdjije+QkBHftNpf2qb6cBLSak
	iYqOBIZFoIwsMT8euQIKij5x9SX1cruaYkyPb1GHXEzVpiD+BOaKongwBGLsdECvsK8XaFckFCv
	QDSjYYOEcaIsxPg==
X-Google-Smtp-Source: AGHT+IE6x2v11h/vMRCByatUch/llCU4tqZ4+51uUuz5xo71MhJOTDM45OnSQuDIRmirrlYJbHXz6w==
X-Received: by 2002:a17:907:1b27:b0:ac3:3cff:268 with SMTP id a640c23a62f3a-aca9b660982mr225485666b.30.1744186181500;
        Wed, 09 Apr 2025 01:09:41 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3d9csm53734866b.25.2025.04.09.01.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 01:09:36 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so11297849a12.0;
        Wed, 09 Apr 2025 01:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEa4DA8bfFwQtT8jJGQ+ov32u8UZemgFg2lF6FLg2nVyLIPaGy86W+iKEfxTlPnK8x8+nruavsqy4Pikg=@vger.kernel.org, AJvYcCWEAAi6gBxgYyA8dYSlqIdOCrM8Hx8JAhDBQERcCpQ74jFzTrog9NiYXXq2LCUMRCt/GXfnFBbEzhG4@vger.kernel.org, AJvYcCWa2YKHNH0J+1ulEvAKfA7zneXXAc1KNBOkBg/HjLymSiypDrfl/NxkT8YyKpKhI4KBf9kanpF0LnJ4sRj1ZxHe+go=@vger.kernel.org, AJvYcCWrYOn1TBGxY+EG+9WffScnwhRnDTohyknbCM1ylj4FRM4kHTWMHNt+nKN59ezXjZZ60QNsbY5zgY5M@vger.kernel.org
X-Received: by 2002:a17:907:3c93:b0:ac6:ef94:3d9a with SMTP id
 a640c23a62f3a-aca9b5b2f25mr280693966b.4.1744186176415; Wed, 09 Apr 2025
 01:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
 <87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com> <bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
 <CAMuHMdUiO2mVzYn4PGZwUat6W_0JQjD3be7X6ThzK7vcPisKEg@mail.gmail.com> <20250409-functional-cheetah-of-honor-b9d9cf@shite>
In-Reply-To: <20250409-functional-cheetah-of-honor-b9d9cf@shite>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Apr 2025 10:09:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWto+2Kyecc5B+PvcF6+fXkmLf-skpX+rmRb3O68bbeAQ@mail.gmail.com>
X-Gm-Features: ATxdqUE-rpLF00CG_F-ssiBt8-0WLveq_bwHNqEn6HgLPssRORceCMpwR96zChc
Message-ID: <CAMuHMdWto+2Kyecc5B+PvcF6+fXkmLf-skpX+rmRb3O68bbeAQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 9 Apr 2025 at 09:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 09:01:22AM GMT, Geert Uytterhoeven wrote:
> > > > +select:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        pattern: "renesas,.*-msiof"
> > > > +  required:
> > > > +    - compatible
> > > > +    - port
> > >
> > > Drop entire select.
> >
> > This is needed to avoid matching when using the device in SPI mode.
>
> Which you need to avoid, so drop the select. One device, one schema.

OK... (to be read as "dot dot dot', really! ;-)

> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: renesas,msiof-r8a779g0   # R-Car V4H
> > >
> > > Use expected format of all soc compatibles. It has been always: SoC-module.
> >
> > This is a pre-existing compatible value, so it cannot be changed.
> >
> > > > +      - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
> > >
> > > If you have duplicated compatibles then:
> > > 1. It rarely makes sense because you claim that two different devices
> > > are using the same compatible. Different device, different compatible.
> > > 2. Or if this is really same device, then only one schema.
> >
> > This the same device, but it can be used in two (actually more)
> > different modes: SPI and I2S.  Hence it has two separate DT binding
> > documents.  If this needs to be merged (the result is gonna be ugly):
>
> ... then next time don't post incomplete bindings. I know we do not have

:-)

> time machine, but any mess is on contributors who posted some limited
> scope/view of the hardware entirely ignoring the rest of interfaces.

This is the first time someone implemented I2S using MSIOF on a system
intended to run Linux.  Note that MSIOF is not even limited to SPI and
I2S.  It can be used as a generic synchronous serial interface, too. So
far no one did under Linux, so it is not reflected yet in the bindings.
MSIOF is also used to provide a clock signal to a PMIC on some older
R-Car boards.  As that PMIC has no upstream Linux driver, no one ever
implemented support for this mode in Linux.  So I guess I should be
pro-active, and add #clock-cells to the unified MSIOF DT bindings, too?

Note that there are other devices to consider, too. E.g. SCIF can
not only be used as a UART, but also as a USART, SPI, or even I2C
controller... (currently Linux with DT supports the UART personality only,
but drivers/spi/spi-sh-sci.c does exist for SH).

> > where to fit it in the DT binding doc hierarchy?
>
> Does not matter, whatever fits better in overal picture/purpose of this
> device.

OK, hence the existing SPI bindings....

> > > > +  dmas:
> > > > +    minItems: 2
> > > > +    maxItems: 4
> > >
> > > Why flexible?
> > >
> > > > +
> > > > +  dma-names:
> > > > +    minItems: 2
> > > > +    maxItems: 4
> > > > +    items:
> > > > +      enum: [ tx, rx ]
> > >
> > > How would that work? tx rx tx rx? And then driver requests 'tx' (by
> > > name) and what is supposed to be returned?
> >
> > The module may be connected to one or more DMA controllers (see below).
>
> Yes, but how the implementation would work?
>
> Anyway, this needs to be strictly ordered, not random rx rx tx tx or rx
> rx rx rx.

Why?

> > > > +
> > > > +    msiof1: serial@e6ea0000 {
> > >
> > > serial means UART controller. You need name matching the class of the
> > > device.
> > > Node names should be generic. See also an explanation and list of
> > > examples (not exhaustive) in DT specification:
> > > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> >
> > What is the recommend generic node name for a flexible serial device
> > that can operate as (a.o.) either SPI or I2S controller?
>
> i2s
> or even not so generic msiof, but definitely not serial because that is
> reserved for UART.

The MSIOF device node lives in the SoC-specific .dtsi file.  Its use
case is not known in that file, and specified only in the board
.dts file.

> > > > +      compatible = "renesas,msiof-r8a779g0",
> > > > +                   "renesas,rcar-gen4-msiof";
> > > > +      reg = <0 0xe6ea0000 0 0x0064>;
> > > > +      interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> > > > +      clocks = <&cpg CPG_MOD 619>;
> > > > +      dmas = <&dmac0 0x43>, <&dmac0 0x42>,
> > > > +             <&dmac1 0x43>, <&dmac1 0x42>;
> > > > +      dma-names = "tx", "rx", "tx", "rx";
> > >
> > > So test it now - get DMA by name 'tx'. What do you get?
> >
> > A handle to either <&dmac0 0x43> or <&dmac1 0x43>; which one is
> > random. It's been working like that for ages.
>
> Interesting. And is this expected behavior? Driver does not care which
> RX and which TX it gets? Like RX from dmac0 and TX from dmac1?

Exactly.
This use case was one of the requirements when DMA support was DTified.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

