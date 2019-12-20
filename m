Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5D127E08
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2019 15:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfLTOiZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Dec 2019 09:38:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33701 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfLTOiZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Dec 2019 09:38:25 -0500
Received: by mail-oi1-f193.google.com with SMTP id v140so4614220oie.0;
        Fri, 20 Dec 2019 06:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ttOWcmj1xoIu275zl0kZn2gLI4fJmkDgKWXrWJiQl8=;
        b=i2ElvCn3SqrD7e+ALAtSBzqkw/Ti3EmtD2WE0JkEiT/IdmISDXMH3+AveHkW7GdqLd
         6f4dy7zvseCFbSdyXyf9gZGgMnynbLzaSHon+aVoHrwLTTQoqLU0WCeqGN2f09mhNlUo
         D63ipRCxb548aoVBflXvUVBnBmIffr3AC37e1pza3glWJfz2zrDJjTvLjU31TMJAlqoA
         5UOgVNrN53jmb1kD1nrBomQhshCrbNMbqLFDVoEThzZwJANkNC+sT9XUFANpxBevkJ6F
         LPpbHRoxhzOKvxSHQskeo4N1pdbDb9pW7zhENLMGmQ5zapYXjQLnLal3dpkUJKEY/LLR
         zq4g==
X-Gm-Message-State: APjAAAWqBk1J1sG4V9iAiCCN1AjuWtLtHRSmBj+w0lcDwzW6ffwzuksU
        kd0XhmHvS2xhUysZGmU0H6EFjCMXo1PiWA+Qx7c=
X-Google-Smtp-Source: APXvYqyy/YUzj2gLVNdMx8YO/LZpvp2FfzblpXExj0vowxcnvIkAl2fQdWgAxqnw29CcjomthYTP6pZKrNQnpuT3gFc=
X-Received: by 2002:aca:eb83:: with SMTP id j125mr2033393oih.153.1576852704277;
 Fri, 20 Dec 2019 06:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-4-chris.brandt@renesas.com> <5644c687-7692-53f2-f01e-0e7bf62464ea@cogentembedded.com>
 <TY1PR01MB1562645184402F7C01CE36958A5F0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1562645184402F7C01CE36958A5F0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Dec 2019 15:38:13 +0100
Message-ID: <CAMuHMdV40AVXf6NW-8AYtp0ZDM_aAe59z7G8XDR5R0tBk6v0YQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] clk: renesas: r7s9210: Add SPIBSC clock
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

On Fri, Dec 6, 2019 at 8:49 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Fri, Dec 6, 2019, Sergei Shtylyov wrote:
> > On 12/06/2019 04:41 PM, Chris Brandt wrote:
> >
> > > The SPIBSC clocks are marked as critical because for XIP systems, the
> > > kernel will be running from QSPI flash and cannot be turned off.
> > >
> > > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> > > ---
> > > v2:
> > >  * Removed spibsc from critical clock section
> >
> >    So you've removed it from the critical table but left the patch
> > description intact?
>
> Damn!
> Thank you for pointing that out.
> I remembered to take the comment out of one patch, but I missed this one.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in clk-renesas-for-v5.6, with the description changed to
"Add SPIBSC clock for RZ/A2.".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
