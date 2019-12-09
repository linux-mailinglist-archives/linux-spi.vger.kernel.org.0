Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFF1175F1
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 20:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfLITeO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 14:34:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35003 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLITeO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Dec 2019 14:34:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id k196so7477121oib.2;
        Mon, 09 Dec 2019 11:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPj5BnCRFlVLAcTocdSdKOif0Ppf6lvvauzu7g3ZWKw=;
        b=TGBAOSU73tA20LO5J0gKwaJsLh7g8tzWmTqEPLKkjtv5IWhrf4Wcmv0TXnjxqgL1jF
         yBC1O9bdvqMQq33RimLfL/ksA1Cmyr9qX8HizrOeGMJgCGR+VypKI90KWVIoUC19NG/A
         LxhIOMr49DTnR+kFuE1K+xhQo/h3YX60NAmSqfVkq+5yGWjSLz8cPG2muk7XT+RGrvE6
         aGpiRRBDspUMs+FPalSct5iyOLq7ynW6eGQViB/TzVqd5+aYS9ddd2PDvQ4NUzUTgQCg
         EElt3hH8q9QNFd9+31jFkmAGqM/x10Mo7GsOHgGzf8cyenhvU58jyvRwLv8GNEU0lGxg
         y52A==
X-Gm-Message-State: APjAAAW1d5eON/a4zDieha6S1Uq4P/Zz08jbswp223vrkwFt8ShnqxtS
        59S1XLycvi56/e6LdB5kPojw8B+KYykPdKELydY=
X-Google-Smtp-Source: APXvYqwJ0Yps000beZiYNpb0g4ISSQQDOIbeEGH4u9DT8U2zSZ93q58ESvoZEPACv8jSmyP8+1aFBlobGs4verKHE88=
X-Received: by 2002:aca:4e87:: with SMTP id c129mr624324oib.153.1575920053160;
 Mon, 09 Dec 2019 11:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-3-chris.brandt@renesas.com> <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
 <TY1PR01MB1562BC84E2ECF81487A780D38A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562BC84E2ECF81487A780D38A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Dec 2019 20:34:02 +0100
Message-ID: <CAMuHMdWM79gxugmxiQVdGoivN5mAXT+5sMNOmJ-YyPyOZ39W=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC bindings
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

On Mon, Dec 9, 2019 at 4:45 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Mon, Dec 9, 2019, Geert Uytterhoeven wrote:
> > > +    # This example is for "External Address Space Read Mode"
> > > +    spibsc: spi@1f800000 {
> > > +        compatible = "renesas,r7s9210-spibsc";
> > > +        reg = <0x1f800000 0x100>, <0x20000000 0x10000000>;
> > > +        clocks = <&cpg CPG_MOD 83>;
> > > +        power-domains = <&cpg>;
> > > +        interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +    };
> > > +    flash@20000000 {
> >
> > This does not describe the hardware topology: the flash node should be a
> > subnode of the spibsc node, as it relies on the spibsc being clocked.
>
> So for the "XIP" case, I originally tried adding an "mtd-rom" flash node
> under the spibsc node, but then the mtd-rom part never got probed. I
> guess that was because it didn't register a SPI controller.

To probe subnodes, your node needs to either be compatible with e.g.
"simple-bus", or have its own driver that calls of_platform_populate().

> But, I guess if we go your method...
> >     spibsc: spi@1f800000 {
> >                 compatible = "renesas,r7s9210-spibsc", "simple-pm-bus";
>
> Then after the spibsc driver fails and the "simple-pm-bus" driver tries,
> it will succeed and the simple-pm-bus driver will start probing the
> subnodes (in my case, the mtd-rom).

Yes, and unlike "simple-bus", "simple-pm-bus" does handle Runtime PM,
so the clock will be enabled when needed.
BTW, I still think "simple-bus" should handle Runtime PM, and
"simple-pm-bus" should not exist.

> > and applying "[PATCH] mtd: maps: physmap: Add minimal Runtime PM support"[1],
> > the memory-mapped case should work, without your spibsc driver.
>
> Good.
> So we can add the SPI-BSC clocks for RZ/A1 and RZ/A2 (even without the
> SPI-BSC driver) and still have a working solution for XIP_KERNEL.
>
> So in the end, this all seems like a very simple solution to get
> everything I wanted with minimal complexity.

Exactly.

> But, if Sergei is going a completely different route for R-Car, I guess
> I need to understand that first what he is trying to do before I really
> push for this driver getting in.
> Again, this driver was only when using the SPI-BSC HW, not the full
> (different) R/W HyperFlash controller HW. That would be a separate driver.

Yeah, the "real" serial FLASH functionality needs its own driver.
How to fit all the SPI/QSPI/HF pieces together in a working driver is
still TBD.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
