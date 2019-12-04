Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB563112617
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 09:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfLDI4m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 03:56:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41311 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDI4m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 03:56:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so2072085oie.8;
        Wed, 04 Dec 2019 00:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVFymO7RxKc1SH1kxRmoxduL3Qufx6k2WlK1nkDrG/U=;
        b=peFeKHLOxw2gC0D1QNCodKYJyfXudd/2GxEwysqLFe4Ps/GayXDEbfAq64xatal+2z
         U9zHPVXGwBLmXZ0IA/OWSyN26Fe1RZZgpF7sI45rEk4U/Vh2R4ef1bJ6asnHsZMc8L6Y
         9XNR5aelVg2doKo+ZKh6HssFNC9FGmRMypOcYX8XfYx1psE/6vIYRQ+0hi4XG9qNAXXq
         3Y93aojD6/DJCialMd3rlM5pIZF7319nvolRxXxRTamscq0QMT++A4WGP/jMbxpWdxkV
         TeQvcCE+TrrHjGwhs8/NxKonRCQPNDs80jYSR7jpYydkBQZWi8+ZnxgH4WeajKX+fffI
         Z50A==
X-Gm-Message-State: APjAAAU1jCyKW88x9CGJWHc2n0RmzPVAFVQ99xm4JnzIi1jYXXnX4wKd
        WbMydUEJ7/IiJAGKHM4QrxFUnS5GxcgH3WwGTY0=
X-Google-Smtp-Source: APXvYqx8VTTKUMma9S8z5+FJD6ZModoCaejPqlKfXRaFP13Yc0tfRVyCuk5xiXbuC5utxyV2lDAMv963ZB5sv5CFWe4=
X-Received: by 2002:aca:4a41:: with SMTP id x62mr1579212oia.148.1575449801059;
 Wed, 04 Dec 2019 00:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-7-chris.brandt@renesas.com> <CAMuHMdVBYpuoK7hcyNLK-mAdpTQz3ohTGXuYdFPHdpU5RoPr6Q@mail.gmail.com>
 <CAMuHMdV7XY7FB9pBsxuWxGsqYaD9n1Y+XZXEJO5OsuigjjUgpw@mail.gmail.com> <TY1PR01MB1562A6AFD8D0807B345B7A208A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562A6AFD8D0807B345B7A208A5D0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 09:56:29 +0100
Message-ID: <CAMuHMdUn3h1VjYkARTFBqMij5aYg2mJSVErwceHc0NATBo+_hw@mail.gmail.com>
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

On Wed, Dec 4, 2019 at 3:55 AM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Tue, Dec 3, 2019, Geert Uytterhoeven wrote:
> > > What about the "mtd-rom" use for e.g. XIP?
> >
> > I gave this some more thought. Basically there are two modes: SPI FLASH and
> > direct mapped emulation (HyperFLASH could be a third mode).
> > The bindings described above are for the SPI FLASH use-case.
>
> I would say in general, there are just two modes "SPI Mode" which was
> intended to do things like discover the attached flash and erase/writing.
> And direct mapped which was intended only for reading. Both of those
> modes were intended to be used for QSPI flash, HyperFlash or OctaFlash.
> There's a register bit you set to tell the PHY what you are talking to.

OK.

> > On the driver side, if your spibsc driver does not find a flash subnode that
> > is compatible with "jedec,spi-nor", it should return -ENODEV, so
> > drivers/bus/simple-pm-bus.c can take over for the second mode, if needed.
>
> I think here is the bigger issue/question/decision.
>
> This one IP block supports 3 different types of Flash: QSPI, Hyper, Octa.
> Also, it runs in 2 mode:
>  "SPI Mode" for writing and other stuff
>  "Direct Mode" Read only, but faster and directly accessible.
>
>  (QSPI also supports 1-bit,2-bit,4-bit, and 8-bit(dual)....but we'll
>   forget about that for now )

To avoid future problems, you probably do want to specify
spi-tx-bus-width = <4> and spi-rx-bus-width = <4> in DTS now.

> So the question is if someone really wants to use it in "direct mode"
> most of the time, but also need to switch back into "SPI mode" to rewrite
> the flash, should this driver handle both cases?
>
> Basically, it's like the 'role switch' in the USB OTG drivers.

If you want to do that, both configurations should be described in DT,
and we need a way to specify what's being used.
I guess if the direct mapped mode is used, you always want to boot the
kernel using that mode, and only switch to SPI mode temporarily after
boot?  So that could be handled by manually unbinding the driver
from physmap-flash, and forcing a bind to spibsc, all from sysfs.
(Which cuts the branch the kernel is sitting on in the case of XIP...)

Suggestions are welcome!

> This driver I created was just attempting to cover the "SPI mode" case
> for those that want to be able to re-write u-boot at run-time. And, it
> could be extended to support HyperFlash and OctaFlash in SPI mode as well
> (you use the same registers, but the commands are different).

OK.

> So my suggestion is to forget about trying to 'support' direct mode in
> this driver at the moment. If you're using this HW for something like
> XIP, then don't enable this driver at all (which is what we have been
> doing).

Still, the direct-mapped mode should be described in DT, when used.
arch/arm/boot/dts/r7s72100-gr-peach.dts does describe the FLASH,
but fails to describe the exact topology (flash is a child of spibsc,
and thus relies on the spibsc module clock being turned on).

BTW, when using spibsc in direct-mapped mode: if you turn of and on
again the module clock, does the spibsc need reprogramming?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
