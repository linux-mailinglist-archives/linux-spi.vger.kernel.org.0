Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5111E5D9
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 15:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfLMOsv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 09:48:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43632 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfLMOsv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Dec 2019 09:48:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id x14so1095036oic.10;
        Fri, 13 Dec 2019 06:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBQ9/WA8dJ3yj6YsudcTec03HFt1nH6b3ZMKGQoshZA=;
        b=Lho4W3VYXrMqPX8203M09YviMSW/usQi76JfLp+7or7fv/6I8htgLnkZos68vOkGR0
         QpfDOT5xG1XFEXFybZQDyDQibLEqOBvbJPDWu7Uww0HnqZPwvTv/O4v+dEmifTbRebap
         vuD855UKpQeBACovct6zBo8lFk81j/q2/MViLi/h1AlXUYAzln35rRYHjB0PVPtUR6af
         twZ4UFcmmd1E1kZzT+qwXJjd3Vs7BP1Lbp+SYGCm/ggHNErdI04J6+luid2VRjbivx58
         NKbg2yhF9umR89yBEQYFg98aC3kEkwkRPd4SsJ9UnxFV/KsOUSmaDIA7+cXKzbTTlyDX
         89fA==
X-Gm-Message-State: APjAAAWuGw839W9xqixnTjiWh5GC/C5yPIqSGxBVWNVeh/ovxIVK7ahY
        3ib+yxpadgAnL+Uwnpa/sgEskNS/4V2oQGT1W3I=
X-Google-Smtp-Source: APXvYqxMUciMS4Fl8EikJlRe3Ox04DBMI5w6FiyUlCP13ScCYG4vGuP13u/7YMjuXx6vrNDeeFn1L3GecFnfUuqqwjg=
X-Received: by 2002:aca:4a41:: with SMTP id x62mr6794805oia.148.1576248530226;
 Fri, 13 Dec 2019 06:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-2-chris.brandt@renesas.com> <37c13497-d20f-583f-72d7-1e3c8a241990@cogentembedded.com>
 <TYXPR01MB1568ED4D40CEC399E64F6A2B8A550@TYXPR01MB1568.jpnprd01.prod.outlook.com>
 <CAMuHMdWCgOsj_ZWF-+f-5XjZU9RSCm6Ww3gBmYQeSGz0B77_ig@mail.gmail.com> <TY1PR01MB15625260CB3CE48A3FBA11058A540@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB15625260CB3CE48A3FBA11058A540@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Dec 2019 15:48:39 +0100
Message-ID: <CAMuHMdUoFKm9Eox=xY1tnxeqG89X=EeRh0N+Aynjg6gBxBgm6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] spi: Add SPIBSC driver
To:     Chris Brandt <Chris.Brandt@renesas.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Fri, Dec 13, 2019 at 3:45 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Fri, Dec 13, 2019, Geert Uytterhoeven wrote:
> > On Thu, Dec 12, 2019 at 9:19 PM Chris Brandt <Chris.Brandt@renesas.com>
> > wrote:
> > > On Thu, Dec 12, 2019, Sergei Shtylyov wrote:
> > > >    As you can see, the deleted file is back after unmount/re-mount...
> > >
> > > Did you do a 'sync' before you unmounted?
> >
> > Does it fail without? If yes, that must be a jffs2 bug.
>
> It does not fail for me with or without the sync.

Good.

> I just I was remembering that you need to call sync before you call reboot
> or shutdown because those do not sync first. That's what I remember anyway.

Yeah, "embedded" reboot commands may reboot immediately, without shutting
down the system cleanly.  Same for "reboot -f" on Debian.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
