Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10CED1125A0
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLDInr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 03:43:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36302 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfLDInq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 03:43:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so6144408oic.3;
        Wed, 04 Dec 2019 00:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jMNDNoGogs0zIVx0MUjgyWFHFtVdl2mqSYxmc3Nnc/A=;
        b=ka4CFhdtgXo0SNJV6BwCMJGGTkMyvAzoMgOvQ+5leQlx51WergqpYyBK6NJpgNkaFv
         vLHb+yZEzpE/xpmWGpmLyXoiZkoTvH3B5rG8wDxWbp9GyPYtHDB/Shqt2xJDTLcveNCn
         H+/FOurmuGonq1YMKbKc1kUPZxoM9wZZXkFmg9OWMboBD0CH/1DkYTobzcCx4//0Z352
         CCEYUfhKQgLPDSk081W7HIqQROaWRdv8nVQ0WtcFhImySFrCmfqLuD2siWY73yggCYy7
         +IbZN09TtaEraVGtV0YtPDGAzJKv3UsvoPBdEs2w7e6+ky7i9anuUUpcs3rQj4S1jJaz
         jWeQ==
X-Gm-Message-State: APjAAAXEFWUu+PgcI4t68E3E0rn+WcKfdMsTK6sABRYW7keSqQuewM5d
        Oj2iS+qpOkiz6c84Lh5nFoEzg7L2nKEeXsu+NZ4=
X-Google-Smtp-Source: APXvYqyTjUqAw5gnC/dN6OVvFFm1xVywx9M+aTiRF7Kq1tQO+ntIrmuya+yV20NM+jRqU59d2JeUMXa2oYIWMweHYzs=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr1555087oia.131.1575449025576;
 Wed, 04 Dec 2019 00:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com> <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
 <TY1PR01MB15622365FCCC3C1CB052FD0E8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB15622365FCCC3C1CB052FD0E8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 09:43:34 +0100
Message-ID: <CAMuHMdXKSWeBdCDc6u5KWE67nD_9FStr9A_vb_5K=qpQ_y8bSw@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
To:     Chris Brandt <Chris.Brandt@renesas.com>
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

On Tue, Dec 3, 2019 at 11:33 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Tue, Dec 3, 2019, Geert Uytterhoeven wrote:
> > > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt
> > > +Required properties:
> > > +- compatible: should be an SoC-specific compatible value, followed by
> > > +               "renesas,spibsc" as a fallback.
> > > +               supported SoC-specific values are:
> > > +               "renesas,r7s72100-spibsc"       (RZ/A1)
> > > +               "renesas,r7s9210-spibsc"        (RZ/A2)
> >
> > Is the fallback valid for RZ/A1, which has its own special match entry in the
> > driver?
> > Will it be valid for R-Car Gen3?
> > If not, you may want to drop it completely.
>
> The fallback would still work for RZ/A1, you just would not be able to
> set the baud rate. But, I have no problem dropping the fallback. I'm fine
> with having a compatible string for each SoC that is known to work for.
>
> I have not tried it with Gen3, but I would guess there will be some minor
> difference that will needed to be accounted for.

OK.

> > > +- reg: should contain three register areas:
> > > +       first for the base address of SPIBSC registers,
> > > +       second for the direct mapping read mode
> > > +- clocks: should contain the clock phandle/specifier pair for the module
> > clock.
> > > +- power-domains: should contain the power domain phandle/specifier pair.
> > > +- #address-cells: should be 1
> > > +- #size-cells: should be 0
> > > +- flash: should be represented by a subnode of the SPIBSC node,
> > > +        its "compatible" property contains "jedec,spi-nor" if SPI is used.
> >
> > What about the "mtd-rom" use for e.g. XIP?
>
> But "mtd-rom" doesn't really have anything to do with the functionality of the
> driver when it is being used in "SPI mode".

Correct. But DT describes hardware.  If the FLASH is used in direct mapped
mode, that should be described in DT.

> Maybe I just remove any mention of this for now.
>
> > interrupts? RZ/A2M seems to have an SPIBSC interrupt, RZ/A1 hasn't.
>
> There was never any interrupts in the SPIBSC.
> But it looks like when they added HyperFlash and OctaFlash support, they put
> in some interrupts for that.
> And now that I look at it, they are for pins labeled RPC_INT, RPC_WC, RPC_RESET.
> (I just realized that "RPC" stands for "Reduced Pin Count")
>
> So....am I supposed to add in that interrupt even though I'm not planning on using
> it??

DT describes hardware, not driver limitations.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
