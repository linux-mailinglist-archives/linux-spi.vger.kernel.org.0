Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682373CFFB8
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jul 2021 18:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhGTQDW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Jul 2021 12:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231367AbhGTQC0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Jul 2021 12:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B24610A0;
        Tue, 20 Jul 2021 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626799382;
        bh=j4BCtPKXcQCOjyfWn0WZbL/kVl1xrM5LvBy4FoGz/40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=moeWhsB7eX73mM0W6ABzmaXgPWmHBdPBBw0qgkPsPA2+RAyIvoLAhI77BCqCW79Sp
         xydZMGobvFHByG2gqrbEmfVOm9tRnN/+nakSkGmStRcuhw8E1ItFimXZguAHYjrs1T
         7XT+jJ2jZWsfEkw1MnRll4enlJqzZZnIZ78Ot+PNv/UHfVdUuKR5Sw+N2CfhR0iyPc
         bUjMPPuhppzFGO28GPlNkRUnafuD+onsug1tYPdLatbW9g3kgoEmnXGlQN6ZbzUVKn
         DAVZYj0agPkdfE00h/jrQzL2PRO+H+juX1clU5Y9oE+sc7wLmW9PfYbRoz+EapA+9x
         biYG5J5j3zUCw==
Received: by mail-ej1-f44.google.com with SMTP id gb6so35257109ejc.5;
        Tue, 20 Jul 2021 09:43:02 -0700 (PDT)
X-Gm-Message-State: AOAM531UJYUaGfEczqr+mxswQxsIFd7VCWAFSj5X4axtuytm+66xcMC0
        Mhc4UBzXKUnavKMrAOWGGjapJysR/4DjqT/nng==
X-Google-Smtp-Source: ABdhPJxjI2GVsp30gFxyft0HwUf/jh/jdIG8vJGlj+RqnG3vOkfXtdpanD4o0pxB3n9fg2NzozRw2Nvbs11EVTCG5Kw=
X-Received: by 2002:a17:906:5fc1:: with SMTP id k1mr32794046ejv.360.1626799380758;
 Tue, 20 Jul 2021 09:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <d430f9c06d6691fe8a98f923cdb7ca13772834b1.1626262043.git.geert+renesas@glider.be>
 <20210716180253.GA3684196@robh.at.kernel.org> <CAMuHMdWXCJd0NzH4km+oXBziBct31DCb53fmk3RhAk-+29Zkew@mail.gmail.com>
In-Reply-To: <CAMuHMdWXCJd0NzH4km+oXBziBct31DCb53fmk3RhAk-+29Zkew@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Jul 2021 10:42:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+anYwYVssARuymvB=HKK13=p22e65OiYbvYKSwPCtsVg@mail.gmail.com>
Message-ID: <CAL_Jsq+anYwYVssARuymvB=HKK13=p22e65OiYbvYKSwPCtsVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Miscellaneous improvements
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Fri, Jul 16, 2021 at 1:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Jul 16, 2021 at 8:02 PM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Jul 14, 2021 at 01:30:13PM +0200, Geert Uytterhoeven wrote:
> > >   - Add missing "#{address,size}-cells",
> > >   - Fix rejection of legitimate flash subnodes containing multiple
> > >     compatible values,
> > >   - Add missing list of required properties.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  .../memory-controllers/renesas,rpc-if.yaml    | 23 ++++++++++++++++---
> > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > > index 990489fdd2ac33fe..c0d899a2305361b1 100644
> > > --- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > > +++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> > > @@ -56,17 +56,34 @@ properties:
> > >    resets:
> > >      maxItems: 1
> > >
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> >
> > spi-controller.yaml already defines this.
>
> spi-controller.yaml says '#address-cells' must be 0 or 1.  As RPC-IF does
> SPI master only, it should be 1.

Yes, but then it says:

allOf:
  - if:
      not:
        required:
          - spi-slave
    then:
      properties:
        "#address-cells":
          const: 1
    else:
      properties:
        "#address-cells":
          const: 0

Rob
