Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2556A1104D1
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 20:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLCTNF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 14:13:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32962 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCTNF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 14:13:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id v140so4270351oie.0;
        Tue, 03 Dec 2019 11:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F26wCNW27bN+CS8oKU3vjyLCmYsJ9NtipxSsUBLuM1A=;
        b=cesUQCuFtKKWzinejUsq/+5cNOjODdg7HvdLgtL2EsuUhWljgHaBjiwZ+k+n7yTArb
         BGZAt+VZlHnvRVigx6/ISIkU5TjgnF/ffAH0LlsFz51nIpPisWdizBPk1LKehFDDPEW/
         aSsBDXs9y52nm1fx9Em/23WAcWCEMlABjrhGKj0JMsGq51td1X21lukDJY6bTSYwyJc2
         LammTAcvR4kWDi3kNEMWUWSS7LDWQmKk2qBTaZah5Fl2pVVxE2rMUp6or8h2J5y2Pifl
         d+9CEXOUr85EvUI94tOjhhjrfmT1Mwt4mtjAsvLmBUlABdl6uL+9gzc7YqlUL8lzblVG
         44GQ==
X-Gm-Message-State: APjAAAUGOE/9y3cb2BkdT3lmPYFphdwdkg+oIDiIA8XT3Uu+4vVdtFFv
        hLCyM5znAzW/4SDE4iEo4Z/7SfGKpfGM22AYCnA=
X-Google-Smtp-Source: APXvYqxQD7kk+gZxKNIBAfXeUmnZjMliGYUDOV75sXqpyapXI5e2P3dxB2rBWDuBAN0JRcIhgU3Qpsa5WdaWNwK3i0E=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr4803048oia.131.1575400384046;
 Tue, 03 Dec 2019 11:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-3-chris.brandt@renesas.com> <CAMuHMdXUVdG_PMQEpz=QWLCaabfK8Mc41zFiymXJ4Rx_C2gzdg@mail.gmail.com>
 <TY1PR01MB1562F44E4FB80788922CE9BE8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562F44E4FB80788922CE9BE8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 20:12:52 +0100
Message-ID: <CAMuHMdX_sD+UHnOF+bdbT99zfK1V92+1kVzGnb9JXJyBd-Y5-w@mail.gmail.com>
Subject: Re: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
To:     Chris Brandt <Chris.Brandt@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

CC Lee (for clock-critical)

On Tue, Dec 3, 2019 at 7:58 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Tue, Dec 3, 2019, Geert Uytterhoeven wrote:
> > > +                       reg = <0x3fefa000 0x100>, <0x18000000
> > > + 0x4000000>;
> >
> > The second region conflicts with the XIP flash@18000000 in
> > arch/arm/boot/dts/r7s72100-gr-peach.dts.
> > Yes, I know it is the same device ;-)
>
> Is that just an FYI?? Or do you have some suggestion??

Can the flash subnode be compatible with "mtd-rom", even if the parent node
is kept disabled?

> > > +                       clock-critical = <4>; /* spibsc0 */
> >
> > Iff we go this clock-critical route, I think this should be specified in the
> > board-specific .dts instead of in the SoC-specific .dtsi.
>
> OK, that's fine. It makes more sense to be in the .dts because it's a board
> design decision. I will remove it from the patch.
>
> The one 'tricky' thing is that the <4> is the index into the number of clocks.
>
> So in the Renesas BSP where it includes the VDC5 LCD controllers,
>
> clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3", "vdc50", "vdc51", "spibsc0", "spibsc1";
>
> the <4> needs to become a <6>.

Unless you pass "clkidx" instead of "i" to of_clk_detect_critical() in [1],
and use "clock-critical = <R7S72100_CLK_SPIBSC0>" in DT?

Unfortunately the exact semantics of clock-critical were never documented.
Lee?

Thanks!

[1] "[PATCH 1/6] clk: renesas: mstp: Add critical clock from device
tree support"
    https://lore.kernel.org/linux-renesas-soc/20191203034519.5640-2-chris.brandt@renesas.com/


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
