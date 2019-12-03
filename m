Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74F11060C
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 21:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfLCUjf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 15:39:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36479 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfLCUjf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 15:39:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so4668947oic.3;
        Tue, 03 Dec 2019 12:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TJGagGqHxNoULtw7v87VE6OdMI1b/hQDl/thVQTZzE=;
        b=mXZNd9wueQ/bvxQnKYAaFyPD7JG6xAauHIPa7uwffzqesrXHX+fjer4ypRn3Iau/Jp
         0EsEYlsI4HuFxK/OOfvsUCoXUf0BxKbrfN6f38HR1qJ6DWq9ia39MTQ3vPhmjMngf/v0
         Sw9A9AaoeU6s62sSVVvWQFhjKg/rbSH8AMQh8uHgH/4FVoLWjlf7CQhdB9x5hYs0RC9f
         b9d+IEWmV1ilnViMzppjgbcMgcsFNnUGlOxf1xijcRWVu0luP0mESJmZWIu2GbPpK/Vr
         7q2Vgk7r16DA2xONMSdjlz76SICx1O6k6nWY4ql8Nb4qBINT+XNi/+lj4TuDjtu3YKOn
         fpVw==
X-Gm-Message-State: APjAAAV8Wgj3wvVgpmaaACwmPIcAiJVE9dDtoiIASODse3N8g8FbLAZY
        +HonW6fPDKbjWmpMQEEhXbHFsVaGTk8Z/rCU6Dw=
X-Google-Smtp-Source: APXvYqwZ1H+FSI71SvLv8qVzU410pqxDRtaMhvXAgAYXxZztaKCwV3k8ytvgAZtuF6dGF8AymZsIk6ZPj8IfDOHH+Js=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr5200706oia.131.1575405573989;
 Tue, 03 Dec 2019 12:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com> <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 21:39:22 +0100
Message-ID: <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
To:     Chris Brandt <chris.brandt@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Tue, Dec 3, 2019 at 7:57 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Dec 3, 2019 at 4:47 AM Chris Brandt <chris.brandt@renesas.com> wrote:
> > Document the bindings used by the Renesas SPI bus space controller.
> >
> > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt
> > @@ -0,0 +1,48 @@
> > +Renesas SPI Bus Space Controller (SPIBSC) Device Tree Bindings
> > +
> > +Otherwise referred to as the "SPI Multi I/O Bus Controller" in SoC hardware
> > +manuals. This controller was designed specifically for accessing SPI flash
> > +devices.
> > +
> > +Required properties:
> > +- compatible: should be an SoC-specific compatible value, followed by
> > +               "renesas,spibsc" as a fallback.
> > +               supported SoC-specific values are:
> > +               "renesas,r7s72100-spibsc"       (RZ/A1)
> > +               "renesas,r7s9210-spibsc"        (RZ/A2)
>
> Is the fallback valid for RZ/A1, which has its own special match entry
> in the driver?
> Will it be valid for R-Car Gen3?
> If not, you may want to drop it completely.
>
> > +- reg: should contain three register areas:
> > +       first for the base address of SPIBSC registers,
> > +       second for the direct mapping read mode
> > +- clocks: should contain the clock phandle/specifier pair for the module clock.
> > +- power-domains: should contain the power domain phandle/specifier pair.
> > +- #address-cells: should be 1
> > +- #size-cells: should be 0
> > +- flash: should be represented by a subnode of the SPIBSC node,
> > +        its "compatible" property contains "jedec,spi-nor" if SPI is used.
>
> What about the "mtd-rom" use for e.g. XIP?

I gave this some more thought. Basically there are two modes: SPI FLASH
and direct mapped emulation (HyperFLASH could be a third mode).
The bindings described above are for the SPI FLASH use-case.

For the direct mapped use-case, you need different bindings:
  1. Append "simple-pm-bus" to the list of compatible values,
  2. Add a "ranges" property,
  3. The flash subnode becomes directly mapped, and must be compatible
     with "mtd-rom", cfr. the CFI FLASH on ape6evm:
     arch/arm/boot/dts/r8a73a4.dtsi:bus@fec10000 and
     arch/arm/boot/dts/r8a73a4-ape6evm.dts:flash@0.

On the driver side, if your spibsc driver does not find a flash subnode
that is compatible with "jedec,spi-nor", it should return -ENODEV, so
drivers/bus/simple-pm-bus.c can take over for the second mode, if needed.

Once you have added basic Runtime PM support to
drivers/mtd/maps/physmap-core.c:physmap_flash_probe(), the module clock
should be kept enabled through the clock domain when using direct mapped
mode (hmm, as the driver currently lacks this, it means the FLASH on
ape6evm must rely on the bsc module clock being kept enabled through the
Ethernet controller connected to the same bsc module?).

Does this make sense?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
