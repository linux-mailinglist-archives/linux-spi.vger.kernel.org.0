Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF93CBC35
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 21:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhGPTMz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 15:12:55 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:37826 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPTMy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 15:12:54 -0400
Received: by mail-vs1-f42.google.com with SMTP id r18so5630049vsa.4;
        Fri, 16 Jul 2021 12:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehJwWdmJnEqOFrEyqslwmNH6+ZDemUpg9Q/4BttkqCY=;
        b=AeookFuB5y6q7aP9LN+j7zbod4jXbumMxlFTdeCJc/C260j50Ls3bUioU/2mGD2LI/
         ks0hRUGeheU7ie3RPeh0FQbFZcP4F75cDv2qsvjjzMozuFJZrommkgau532OcYOKHyjU
         92kLYcbJL0ok6nF+TCzqQ3b3s0+wUiIP2WvHju/ir8hBKmitHvgju69WZO2PBYMkgDfK
         crhpUBIuEOzvrkBOhla75j1aEt6GhcWVGSHAc1WGyDV6lEbfL3rd5ZnwCXERRARpbuni
         mmHKC0ccg32ReGm8XLDwbaqIk5cSEBp/P5FVDsUE+8gZLE0jYNhWDHoxCN156jayB0wU
         1tfA==
X-Gm-Message-State: AOAM533B4IVVVioEMHBAndJJwhxmAhOWDaJUA/bdDJk8V4eT7l6+SqqK
        fUFNWqvqiTcFgQijOhPmbQYJ1xSIDRTGlmqyUUE=
X-Google-Smtp-Source: ABdhPJxZ3GQdFZsnwGr4ysExj1rkCNjJYj/LMNp5Bwoi5+JuhzOdItSjtD8zznsMplgRv8d3nnp0PfgcVGSLfl6UM94=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr14494278vsd.42.1626462598688;
 Fri, 16 Jul 2021 12:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <d430f9c06d6691fe8a98f923cdb7ca13772834b1.1626262043.git.geert+renesas@glider.be>
 <20210716180253.GA3684196@robh.at.kernel.org>
In-Reply-To: <20210716180253.GA3684196@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Jul 2021 21:09:47 +0200
Message-ID: <CAMuHMdWXCJd0NzH4km+oXBziBct31DCb53fmk3RhAk-+29Zkew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob,

On Fri, Jul 16, 2021 at 8:02 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Jul 14, 2021 at 01:30:13PM +0200, Geert Uytterhoeven wrote:
> >   - Add missing "#{address,size}-cells",
> >   - Fix rejection of legitimate flash subnodes containing multiple
> >     compatible values,
> >   - Add missing list of required properties.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  .../memory-controllers/renesas,rpc-if.yaml    | 23 ++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > index 990489fdd2ac33fe..c0d899a2305361b1 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > @@ -56,17 +56,34 @@ properties:
> >    resets:
> >      maxItems: 1
> >
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
>
> spi-controller.yaml already defines this.

spi-controller.yaml says '#address-cells' must be 0 or 1.  As RPC-IF does
SPI master only, it should be 1.

Don't remember why I added the '#size-cells' too. Perhaps for symmetry?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
