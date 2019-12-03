Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0305A110483
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfLCSvP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:51:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38255 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfLCSvP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 13:51:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id z25so3890277oti.5;
        Tue, 03 Dec 2019 10:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hLOBykbGdw1liJmGR7zdbjWF/AatltGdR05B3u8wIk=;
        b=gqrckh8oE+u/O1VRq3zxkhVWEFU1z4pM2v8M4ZigFs2dwzSXpdP6H0sRl7vHImUpp7
         EYI9jG6fPW65oyxIGYhG09K6rjVoCV7VWFBSt3p1zt4bVkj+JEbPvN7/ajHjtHzrSgY0
         P/CbGH3lXcWj1d/QW9dAF2FDLV8bbaXzEB1GsUR3XAzSdUypDOXOZD9210lImKu4BIxE
         c4uPDF5NqbXl3leAYwtDOfh5CpK+X2nWKJcdU5jG+DkSDbMc7X5P8CdrWnRdDd6k7yRI
         CKQCOlcJMvuZvSjJGSYpea1nm3TvbhWB6WW7qeKF+elcReWQod0nt3j4JFZ7SREd+vXv
         hvUQ==
X-Gm-Message-State: APjAAAW8h8uFjzqTWaoDa8jCdtHyY2+hf3aAxpovvlzmqGtJ1R3rZQnD
        p4yxbX6ynxMfF2Wk4IHSEh7YZwugG6mg2FMhzYE=
X-Google-Smtp-Source: APXvYqzZ4oo2pJfvg5MVOk89f23ud9VOzcxrq1j4J+lTteiIrj46hoyfYObEFueWeAaT1h0ORL8ozymCjJbIhLZXTKY=
X-Received: by 2002:a9d:3a37:: with SMTP id j52mr4387892otc.39.1575399073988;
 Tue, 03 Dec 2019 10:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-2-chris.brandt@renesas.com> <CAMuHMdU6NrAk-oeH_tR8Re7bz6HXednfaP=CGsyBt+M4_n95ow@mail.gmail.com>
 <TY1PR01MB156288E89F0F845CDC3831FB8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB156288E89F0F845CDC3831FB8A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:51:02 +0100
Message-ID: <CAMuHMdUckOP7m04U0NQ-rDJw4xFD_U4JBgtKzNr8NSmpc1ZLgg@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: renesas: mstp: Add critical clock from device
 tree support
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

On Tue, Dec 3, 2019 at 7:46 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Tue, Dec 3, 2019, Geert Uytterhoeven wrote:
> > > +       unsigned long flags;
> >
> > = 0 here...
> > >
> > > +               flags = 0;
> >
> > ... instead of here?
>
> That was my first thought too...and it was wrong.
>
> If of_clk_detect_critical does NOT detect a critical clock, it does not
> touch flags at all.
> And since it is a loop, what you get is after the first clock is marked
> as CRITICAL, all the remaining clocks also get marked CRITICAL. In this
> case, both spibsc0 and spibsc1 get marked critical. That's why I have to
> reset it for each loop.

Thanks, I missed this is done inside a loop.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
