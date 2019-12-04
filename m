Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CD112651
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 10:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLDJDP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 04:03:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39745 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfLDJDP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 04:03:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so6169677oib.6;
        Wed, 04 Dec 2019 01:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiimM+vAPJm9W6bXX8wORh+f+Ya7ArJHf1Ny0AsE3FE=;
        b=I+sFzUmkVNyh8AH+f+UMttJ4b8zfqyjU0FPs+sUkrnksWIgaKPeNvjT6UDOWEQPVKv
         CkPiaXfafyS6aU6mT0AZzTPvpBuU8yq6NcGDKYbHMgU8umKfgx8ch4ai8DuyEebe6C57
         92gQ/3OKdR+vAU1fcTAVZ4r6DrazR32zyBY7qYDfliUqwBn9yIqT7GoRonJXpfdMPZJf
         nvSPq/vRnQYJFDZQJLRtoUB+eRe9npa5BzWmb0BroagOPSGijOeSuyQq7E9AYYaaq0Tb
         KlAGeao/IbYqMeao2QFaUjG4ROuijEqkryEshflpILq/R5RTiuoSIV5KMHf7f4iSGb34
         F8RQ==
X-Gm-Message-State: APjAAAVfP6NkFyg/LuWQ7D3mligYY4DaYefxYqBSQhymyqWZGKOyIOGB
        7b6rZAEBLICB0YvGMnRc0dd89wVDteudHX01qwM=
X-Google-Smtp-Source: APXvYqzQXYe4gQCdUWg4G1jBsuzwR+3cpC7tyX1rRK1ihEkgVryFHXzaVwEjpn5VWpFRyxiwDsOp9WBGaMP8rktHGag=
X-Received: by 2002:aca:36c5:: with SMTP id d188mr1768698oia.54.1575450194036;
 Wed, 04 Dec 2019 01:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-3-chris.brandt@renesas.com> <CAMuHMdXUVdG_PMQEpz=QWLCaabfK8Mc41zFiymXJ4Rx_C2gzdg@mail.gmail.com>
 <TY1PR01MB1562F44E4FB80788922CE9BE8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <CAMuHMdX_sD+UHnOF+bdbT99zfK1V92+1kVzGnb9JXJyBd-Y5-w@mail.gmail.com> <20191204083821.GA3468@dell>
In-Reply-To: <20191204083821.GA3468@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 10:03:02 +0100
Message-ID: <CAMuHMdXC+=2nH51ASu0u3WUchjM5bC_bROgcYM-OrsM7OgZpbg@mail.gmail.com>
Subject: Re: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chris Brandt <Chris.Brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

Hi Lee,

On Wed, Dec 4, 2019 at 9:38 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 03 Dec 2019, Geert Uytterhoeven wrote:
> > On Tue, Dec 3, 2019 at 7:58 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> > > On Tue, Dec 3, 2019, Geert Uytterhoeven wrote:
> > > > > +                       reg = <0x3fefa000 0x100>, <0x18000000
> > > > > + 0x4000000>;
> > > >
> > > > The second region conflicts with the XIP flash@18000000 in
> > > > arch/arm/boot/dts/r7s72100-gr-peach.dts.
> > > > Yes, I know it is the same device ;-)
> > >
> > > Is that just an FYI?? Or do you have some suggestion??
> >
> > Can the flash subnode be compatible with "mtd-rom", even if the parent node
> > is kept disabled?
> >
> > > > > +                       clock-critical = <4>; /* spibsc0 */
> > > >
> > > > Iff we go this clock-critical route, I think this should be specified in the
> > > > board-specific .dts instead of in the SoC-specific .dtsi.
> > >
> > > OK, that's fine. It makes more sense to be in the .dts because it's a board
> > > design decision. I will remove it from the patch.
> > >
> > > The one 'tricky' thing is that the <4> is the index into the number of clocks.
> > >
> > > So in the Renesas BSP where it includes the VDC5 LCD controllers,
> > >
> > > clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3", "vdc50", "vdc51", "spibsc0", "spibsc1";
> > >
> > > the <4> needs to become a <6>.
> >
> > Unless you pass "clkidx" instead of "i" to of_clk_detect_critical() in [1],
> > and use "clock-critical = <R7S72100_CLK_SPIBSC0>" in DT?
> >
> > Unfortunately the exact semantics of clock-critical were never documented.
> > Lee?
>
> /**
>  * of_clk_detect_critical() - set CLK_IS_CRITICAL flag from Device Tree
>  * @np: Device node pointer associated with clock provider
>  * @index: clock index
>  * @flags: pointer to top-level framework flags
>  *
>  * Detects if the clock-critical property exists and, if so, sets the
>  * corresponding CLK_IS_CRITICAL flag.
>  *
>  * Do not use this function. It exists only for legacy Device Tree
>  * bindings, such as the one-clock-per-node style that are outdated.
>  * Those bindings typically put all clock data into .dts and the Linux
>  * driver has no clock data, thus making it impossible to set this flag
>  * correctly from the driver. Only those drivers may call
>  * of_clk_detect_critical from their setup functions.
>  *
>  * Return: error code or zero on success
>  */
>
> If this meets the criteria, the API is pretty simple/self
> explanatory.  What are you having trouble with?

What exactly is the "index" parameter?  This value is matched against
the values of the "clock-critical" (array) property, but it is described
nowhere in the DT bindings.
stih407-clock.dtsi seems to assume this value is an index into the
clock-output-names array?
Can we use it as a value of "clock-indices" instead?

> > Thanks!
> >
> > [1] "[PATCH 1/6] clk: renesas: mstp: Add critical clock from device
> > tree support"
> >     https://lore.kernel.org/linux-renesas-soc/20191203034519.5640-2-chris.brandt@renesas.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
