Return-Path: <linux-spi+bounces-7476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9595CA81DCA
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 09:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26A78843B1
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 07:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD0219A9E;
	Wed,  9 Apr 2025 07:01:40 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D7219A9B;
	Wed,  9 Apr 2025 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182100; cv=none; b=S3CwL34B5XLziniuu47Hmz6TUcBNqqjqfUZubsL1jB3ekNFqWECjE86VtLzpQZYuqdUIt/un1S1Qphvx6gfOgBwYmY1X/lTMFsBTiodqLFpKE42cZK39V/Rfpe2ADi/W8KxZOly0qzL2QGJ5EoQqM+6/2vrbxyGh5cdruaUlTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182100; c=relaxed/simple;
	bh=ErGYJAMt6SfLEPIoUY8KIPn6Iy1LK0yoG4EncVaO2zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqJyUs/w6KolmkSaV5gPPjxFyAfHAX8i9Jc8hHbInLc6aqoDOSFvaOS2RfURjSR6qyUX7Vexf05FOqEtcsjMDyzBEfVPGHLXJ6tOkoSihALIhQNPrDO2otDaqILqUlfOMvy9GQzpZ7kRgjdIizYCOz8UucRK9T0DBnrohYBw41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-52617ceae0dso2181141e0c.0;
        Wed, 09 Apr 2025 00:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182095; x=1744786895;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HCX8alf5OnKYYB9szKEQKzOs5dQZnMUIHG6smTmqJs=;
        b=YQmooXkPvGvraF/EHJ9s107K8gu7quajHF1RmuM8yQN4QoBZ7NE1PDbsGIInMK2ukG
         G/ampCo/DATyCV5NSwkoQxzEcwe5by7G3tP7Mxf5Sp2kWdDdYaNETN5H/VJQZVu2u7FX
         cyA7EzlX9e3v93nLU/C0SqkgeStALGfKlrOkiJvVLiS9X/8spO6Mf81sZIU8KvKfhkX8
         AbE/PeU7AVEKPf02TQwwS207RknyBWK5JoKRj41BkXXgAazEUVH80CTfhQEIlEA9GdLP
         L/3QuDugqy/WS9V7rbOOPuAd0/gmdVfeHARUsw6WA+4agkmv1o22GBX+tYkXv05ZEy27
         cQyA==
X-Forwarded-Encrypted: i=1; AJvYcCUNIS/qDVPJ+dHLcpB+Wp2Qch3i/wPL3RMz9nluXA/DHSTeruQvJn6WUoX98sxH/AJjH3C7SNaIXj/AFjA=@vger.kernel.org, AJvYcCUzceVuXzqo1RS7h3FCMw++XlsKCjB0VEmAsS6bmyTFk7ptWc9jU3DoJF0FN2sazVUIgX5lvZeV6mptFUOhk+cVuak=@vger.kernel.org, AJvYcCVeZxFShTyYELPu3KoSO7tXg+uWZ/9HHJ4H1bKyv7xIxHpVfyWkyvK4nu2QuO22vPrVG7ydfsT+Zue+@vger.kernel.org, AJvYcCWuUMbzTpEOA2wfGF5fvbN3oYAGYICQvNd604I+fcE+jzlXTgar2oe2vHt/knBlOpcHGzRQ2Mi0I4sw@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ79RvdsbsL40PGgL+6wQtYS+8/7y4xfLbVaMuHb86h3ejhkuq
	eDCLOwfkNrE7L5fJxDUVl+V4jpgD62mv3i2ET4kQGLSeYCHrSyFmsQczNnvu
X-Gm-Gg: ASbGncvC1rWNfMT4FNxZyHqPWSFnRzEcunbsH3482FgiVbi6v0gLAtTu970Ont2M8wF
	5L2XezyAnadzVt0Uqj1ctxlR89tuFUyKEH8l00qk+AIMdwnvulVgybVddCZuynF9uNT4FteXRUS
	yGmjGREAQ6Lmp2Gvld4rh+v3V/wBWKDlqO1ATXU2JCwHEwP3Nl5XQjNVgsYwU/7lb8HN/rni531
	bQ5bnPTm93C3cmkCjKpuqUH+tiZ8bysleSn53xg+jvQUIBPVfB2c2KkaFMQ6L41aABn3ZZgmSxI
	YvOVqBxGhSuuJe7SR1oS9zBsfIhCLJaJchFYj8y9O/d229zG4DIRWsCKT+vJcRaYRLoOJ+Ey+e5
	T/pw=
X-Google-Smtp-Source: AGHT+IG8QVgClLpUYjDP0Cl6IASGHt2O25wnR3Gnk+7PytQMjrkTPWcsZvz04NVm0jxd04Zcj9O4GQ==
X-Received: by 2002:a05:6102:1514:b0:4c1:749b:2c27 with SMTP id ada2fe7eead31-4c9c6aa382fmr579889137.14.1744182095095;
        Wed, 09 Apr 2025 00:01:35 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c9738859sm80438137.3.2025.04.09.00.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 00:01:34 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86b9d1f729eso2910824241.3;
        Wed, 09 Apr 2025 00:01:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUGRvL3eButctJmQCrk5SaodZeaQVpF/k67HvwDnjeJprYaz16BlkaqAhyax0d/JM3+sIDH7kn/ixPr9e93IanK0c=@vger.kernel.org, AJvYcCUopakcqVOiJ0KOj7D/wf3DiyO+knFvdoPWiX4Zkbg3ZkmcAOw6gmspeBOXDjaqGjbu0L8qVLflbgJBZZY=@vger.kernel.org, AJvYcCWGfKyOrC05QQLyEtS17TCBJQi1OSlgIiUEIsmsbg7r978zAL2diffZpyUCyqXVNG+oNfzU2r19C+YQ@vger.kernel.org, AJvYcCWvJ+ZaIsvH0SonxXPpF9Xyde9c3vYC8CdYF2Y4i8p4JTMbHadYEPaQ0iPbqp5sA7dfEZ3t+wGLwlSW@vger.kernel.org
X-Received: by 2002:a05:6102:2ac8:b0:4c1:c10d:cf65 with SMTP id
 ada2fe7eead31-4c9c6b89fa0mr517802137.25.1744182094445; Wed, 09 Apr 2025
 00:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
 <87y0wa9mb2.wl-kuninori.morimoto.gx@renesas.com> <bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
In-Reply-To: <bd15c145-c175-468d-a1ac-1ad157358aea@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Apr 2025 09:01:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUiO2mVzYn4PGZwUat6W_0JQjD3be7X6ThzK7vcPisKEg@mail.gmail.com>
X-Gm-Features: ATxdqUFsFWDH6P8FCs97Rdi4oWf9YXFZwQowwS7PZeCZDWNpAUZr8ocs1OXtuUw
Message-ID: <CAMuHMdUiO2mVzYn4PGZwUat6W_0JQjD3be7X6ThzK7vcPisKEg@mail.gmail.com>
Subject: Re: [PATCH 5/7] ASoC: renesas: add MSIOF sound Documentation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 9 Apr 2025 at 08:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 09/04/2025 03:05, Kuninori Morimoto wrote:
> > Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
> > both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
> > uses Of-Graph in DT.
>
> > MSIOF-SPI/I2S are using same DT compatible properties.
> > MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
> > MSIOF-SPI doesn't use  Of-Graph.
> >
> > Adds MSIOF-I2S documentation for Sound.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  .../bindings/sound/renesas,msiof.yaml         | 112 ++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/renesas,msiof.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/renesas,msiof.yaml b/Documentation/devicetree/bindings/sound/renesas,msiof.yaml
> > new file mode 100644
> > index 000000000000..5173e80698fb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/renesas,msiof.yaml
> > @@ -0,0 +1,112 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/renesas,msiof.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas MSIOF I2S controller
> > +
> > +maintainers:
> > +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > +
> > +# sharing with MSIOF SPI
> > +# see
> > +# ${LINUX}/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml

http://devicetree.org/schemas/spi/renesas,sh-msiof.yaml

> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        pattern: "renesas,.*-msiof"
> > +  required:
> > +    - compatible
> > +    - port
>
> Drop entire select.

This is needed to avoid matching when using the device in SPI mode.

> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: renesas,msiof-r8a779g0   # R-Car V4H
>
> Use expected format of all soc compatibles. It has been always: SoC-module.

This is a pre-existing compatible value, so it cannot be changed.

> > +      - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
>
> If you have duplicated compatibles then:
> 1. It rarely makes sense because you claim that two different devices
> are using the same compatible. Different device, different compatible.
> 2. Or if this is really same device, then only one schema.

This the same device, but it can be used in two (actually more)
different modes: SPI and I2S.  Hence it has two separate DT binding
documents.  If this needs to be merged (the result is gonna be ugly):
where to fit it in the DT binding doc hierarchy?

> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
>
> Drop these two.
>
> > +    oneOf:
>
> Why is this flexible?

I am not sure where this is coming from (an old SH part?).
The SPI bindings have the same construct.  As this binding supports
R-Car Gen4 only, a single reg should be fine.

>
> > +      - items:
> > +          - description: CPU and DMA engine registers
> > +      - items:
> > +          - description: CPU registers
> > +          - description: DMA engine registers

> > +  dmas:
> > +    minItems: 2
> > +    maxItems: 4
>
> Why flexible?
>
> > +
> > +  dma-names:
> > +    minItems: 2
> > +    maxItems: 4
> > +    items:
> > +      enum: [ tx, rx ]
>
> How would that work? tx rx tx rx? And then driver requests 'tx' (by
> name) and what is supposed to be returned?

The module may be connected to one or more DMA controllers (see below).

> > +
> > +    msiof1: serial@e6ea0000 {
>
> serial means UART controller. You need name matching the class of the
> device.
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

What is the recommend generic node name for a flexible serial device
that can operate as (a.o.) either SPI or I2S controller?

> > +      compatible = "renesas,msiof-r8a779g0",
> > +                   "renesas,rcar-gen4-msiof";
> > +      reg = <0 0xe6ea0000 0 0x0064>;
> > +      interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
> > +      clocks = <&cpg CPG_MOD 619>;
> > +      dmas = <&dmac0 0x43>, <&dmac0 0x42>,
> > +             <&dmac1 0x43>, <&dmac1 0x42>;
> > +      dma-names = "tx", "rx", "tx", "rx";
>
> So test it now - get DMA by name 'tx'. What do you get?

A handle to either <&dmac0 0x43> or <&dmac1 0x43>; which one is
random. It's been working like that for ages.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

