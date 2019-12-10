Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCBCD1191B5
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 21:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLJURQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 15:17:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35592 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfLJURP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 15:17:15 -0500
Received: by mail-ot1-f68.google.com with SMTP id o9so16708334ote.2;
        Tue, 10 Dec 2019 12:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZOtJg/wUcW5kOXl2+mxnJ/u+/k6ol/NbX7ohcECSMA=;
        b=Y7/vQGri2e5Z0TpVX6mwWTA2oWvsR1tfxnJdIBXnXa0mgRd4npxkjONfnCs4+/jJ83
         YGXItEUxLRMnTfu4F0rc4oAs27yNRCl66zqaVn5NL7KVaSTohsWn7RMv562WJ09NSUYz
         GxynOzoklgA5lRqwTGA2YyZLX8EdYE5NpxSCYmmhv6wcvoqvbI9qzVcqfQzQDBqGv7Kc
         AvI/+/v3D0meZ+43ZFP/1DcQiKJ9txKSssXyMtcosXCl2hvcMrF9o2n+0geLIHZbe38T
         B4bawFV65f1KfACCRwXiaELlK6VRDMrU84itiAJVGvlybpwJR8WuZ3L2GG7joQ9/RdKZ
         hifw==
X-Gm-Message-State: APjAAAWYQhSxsgJkcpLhRJXiDcJVVlryIKxZDsU9KUCclDWH//QzqKZc
        D47dTkLdzMmpqQkQPW/iFujAp2Y7331A+2tc3bw=
X-Google-Smtp-Source: APXvYqxk6jSZeRmcJmUtNHfwYqoI+imTEnVPHt5HnVw8PSLZZYAAs7vv4JxN2jO4y+f782uERdtFHGDeCPlzbw3FNIc=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr27288012ota.145.1576009034999;
 Tue, 10 Dec 2019 12:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-3-chris.brandt@renesas.com> <CAMuHMdXW6_tCcx_DE66qBSTK8XmWyWm82ZD6h-N5YX_+xcvBtw@mail.gmail.com>
 <0cbd8556-cf17-7d6b-5c12-e8d663a39cfa@cogentembedded.com>
In-Reply-To: <0cbd8556-cf17-7d6b-5c12-e8d663a39cfa@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 21:17:03 +0100
Message-ID: <CAMuHMdUOUctfD7K21yAx8QFAj0LP+D2PrMCri8H2PMUr5WzXoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: spi: Document Renesas SPIBSC bindings
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergei,

On Tue, Dec 10, 2019 at 9:07 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 12/09/2019 05:09 PM, Geert Uytterhoeven wrote:
> >> Document the bindings used by the Renesas SPI bus space controller.
> >> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> >> ---
> >> v2:
> >>  * change to YAML format
> >>  * add interrupts property
> >>  * Used more terms directly from the hardware manual
> >
> > Thanks for the update!
> >
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/spi/renesas,spibsc.yaml
> [...]
> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - items:
> >> +          - enum:
> >> +              - renesas,r7s72100-spibsc     # RZ/A1
> >> +              - renesas,r7s9210-spibsc      # RZ/A2
> >> +
> >> +  reg:
> >> +    minItems: 2
> >> +    maxItems: 2
> >> +    items:
> >> +      - description: Registers
> >> +      - description: Memory Mapped Address Space
> >
> > The second one is not needed, if you would add "ranges" for the
> > memory-mapped mode.
>
>    I'm not sure we can do that. The flash bus is accessed via a window
> with the high bits in the DREAR reg, even in the direct read mode...

So if the FLASH is too large, you cannot access all of it without
programming the high bits.
However, when using XIP,  you're limited to the window size anyway.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
