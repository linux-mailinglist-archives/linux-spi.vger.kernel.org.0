Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91023C3811
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 16:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbfJAOvO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 10:51:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42766 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388925AbfJAOvO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 10:51:14 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so14615189oif.9;
        Tue, 01 Oct 2019 07:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjkwwfTfjq2moCLwkeTZGb6uXp0wkFlLr8cpTn6l27M=;
        b=pyX7yAyfQGDwy+LAL4AlxcNrPM5m11R3UE1Duj0cP/MA1Y+LoYkWNgOgEdiXK9LVve
         yt3dlDoA9aZPma7fb7qyTHOrcEeTECv70cA2GAph0M2HqHX4AslXvH6GCR7V0Y+MoMqf
         NEPU0TdYqf8i0KRvX+kNI0Q/rVMBKIe/z2wQgGrnvvIit80bsJ9I1GcWBw4jLjVZvMER
         w3lgyeN+y6tA33lW2vB2cf0peCioIbhnBYPtzQUdIMK4Tq1Wx+v3UdRB7eCBzkw8hhkl
         tl4ZaRFmCrQQI7pD5bb9uRCHKAQIJS03jZFDHDY2mgtsEaN22ckkqTsX9v5dIgeqddAF
         uWvQ==
X-Gm-Message-State: APjAAAX1fqzd+VUdgm1/ApH8k8rxSEvAMmDVlM6tTdSm1ZAd7I7VEjjx
        JIrOf5BRY7Tu+NLspdPWHs/vRJQ/PbOYi/LXwvHmHVEE
X-Google-Smtp-Source: APXvYqwqIHUrEtXdoPbVnpLxwh2KqCzpzklP7J9yGOYytQ/1LS8BXr/JDl/k0iY/xzLs23owgZnP3oGCrG/oa+Ym31s=
X-Received: by 2002:aca:b654:: with SMTP id g81mr3826040oif.153.1569941473256;
 Tue, 01 Oct 2019 07:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
 <20191001120203.GA28106@bogus> <TY2PR01MB292460F29AE0664CFFD70EFDDF9D0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB292460F29AE0664CFFD70EFDDF9D0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Oct 2019 16:51:02 +0200
Message-ID: <CAMuHMdXBfgC=x7H_mnLb_s0gMOBS7r9h8vqbiSU+168VKs9q1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: snps,dw-apb-ssi: Add optional clock
 domain information
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Gareth,

On Tue, Oct 1, 2019 at 3:50 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> On Tue, Oct 01, 2019 at 13:02:34AM +0100, Rob Herring wrote:
> > On Wed, Sep 18, 2019 at 09:04:34AM +0100, Gareth Williams wrote:
> > > Note in the bindings documentation that pclk should be renamed if a
> > > clock domain is used to enable the optional bus clock.
> > >
> > > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> > > ---
> > > v2: Introduced this patch.
> > > ---
> > >  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > > b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > > index f54c8c3..3ed08ee 100644
> > > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > > @@ -16,7 +16,8 @@ Required properties:
> > >  Optional properties:
> > >  - clock-names : Contains the names of the clocks:
> > >      "ssi_clk", for the core clock used to generate the external SPI clock.
> > > -    "pclk", the interface clock, required for register access.
> > > +    "pclk", the interface clock, required for register access. If a clock domain
> > > +     used to enable this clock then it should be named "pclk_clkdomain".
> >
> > What's a clock domain?
> >
> > Unless this is a h/w difference in the IP block, then this change doesn't make
> > sense.
> This is a reference to the use of clock domains that are implemented through
> generic power domains. The domain is implemented in
> drivers/clk/renesas/r9a06g032-clocks.c and general details of clock domains
> can be found at
> https://elinux.org/images/1/14/Last_One_Out%2C_Turn_Off_The_Lights.pdf

Rob is right: the clock domain is an SoC integration detail, not specific to
the snps,dw-apb-ssi block.
Remember, DT describes hardware, not implementation details.

So the Linux snps,dw-apb-ssi driver should take care of it.

Which brings us back to an old discussion topic: power-domains properties
describe integration, and thus should be documented at a higher level than
in individual binding documents, just like e.g. interrupt-parent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
