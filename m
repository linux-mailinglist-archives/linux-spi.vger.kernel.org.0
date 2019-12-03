Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F99110613
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 21:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfLCUkU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 15:40:20 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33434 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfLCUkU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 15:40:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id v140so4541089oie.0;
        Tue, 03 Dec 2019 12:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z349GRiHa+TYd/Gh6NHrqmK3aSP2393XNbqmu8AYhJY=;
        b=AilBBrDOyMlUU6jvLb9Mw9ki6ENn/AlYcE33SL8hT8Tjx7h0G6m8j2TuiIGXcw94VP
         vTag4lS5nsifVrJPd4b6fRVTSDQEiI8OIsFSmD7DYIoyCl9D0p+bLs0sPE+P/rSf8xFR
         DXKA00IoztrT6o3lwQMUQ0ywqR/GDNyQURukp2zuh+0XbudNF5+LGIFtzzRmrKugEWVD
         O39MUhADqbFoOoWmmSsQTGIXDv+VFF1ssXUG0HoYIM7vSjVGPNVBrQEXaMghDF4gMSj4
         4muOeS0UVPPNjNfa3iT+tFp7Uclv1K/nv7sHTKipw1GmIZbGHW1+wjo0DjIGF51t8gXv
         0a9A==
X-Gm-Message-State: APjAAAVjGkkWE2eYbJ5Fv5kXPW3D9h/8jzRVnhz3/SYPCDlAAADTGGJR
        UYnPoqZIZwdXQcLS2MPxYAgnDvTVGnPt2sKCu7U=
X-Google-Smtp-Source: APXvYqyZcXL4G/5uMj4Buh0JQMvj7ZbfYAwu5UGnu0/RiMZS4+NXQS7z9UEucye+2BDM1bUTmrDta6Qsm6i/225QPlk=
X-Received: by 2002:aca:36c5:: with SMTP id d188mr5670131oia.54.1575405619309;
 Tue, 03 Dec 2019 12:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-4-chris.brandt@renesas.com> <CAMuHMdUxCdJXyY15f6sr+QFNpg9FLsa5pL3171bm_meJcBNR2g@mail.gmail.com>
 <TY1PR01MB1562D198A463C18B1D810DF48A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562D198A463C18B1D810DF48A420@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 21:40:08 +0100
Message-ID: <CAMuHMdXKn3GN5toqH=s4=KuEhEO_10Qi9EAyC_VT4-E4XOWdHA@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: renesas: r7s9210: Add SPIBSC clock
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

On Tue, Dec 3, 2019 at 8:09 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Tue, Dec 3, 2019, Geert Uytterhoeven wrote:
> > > +static const unsigned int r7s9210_crit_mod_clks[] __initconst = {
> > > +       MOD_CLK_ID_10(83),      /* SPIBSC */
> >
> > This is only a critical clock if XIP is in use, right?
>
> Correct.
>
>
> > Can we do better, and only mark it critical if we detect the FLASH is used in
> > XIP mode?
> > E.g. by using for_each_compatible_node(..., "mtd-rom"), and checking if any
> > of the corresponding register blocks matches the SPIBSC FLASH memory window?
>
> Well...technically...you don't need the "mtd-rom" partition when using the AXFS
> file system. But, we can make a rule that you have to use it regardless.

Just wondering, how does AXFS access the FLASH without it being mapped
using "mtd-rom"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
