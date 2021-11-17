Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D745431A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 09:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhKQJAy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 04:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhKQJAv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 04:00:51 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C550EC061570;
        Wed, 17 Nov 2021 00:57:53 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g17so5273899ybe.13;
        Wed, 17 Nov 2021 00:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUiyit5tQy5o0QwMAm4GtgzAdKI/JBRlz32ayUt2mTw=;
        b=MJDbcFPSI/ig98hUASGVMjNqp1NdUn+zl29/HisQTBxXJ/ayP5/X9rntN7TfevDhjW
         PED/ZTg4GiPht8Ug6k9NxHW2LB1hx5loa72oYC3UKhMul+GNQlVa7JYwsKN6WBV8JZSV
         uz6rj7yhJ2AwUXdCuCmKaLgnq8sglf0dH0sVs1mSGy36MEWZ4dMfqNFlghSQ5plAgsg4
         BRoaBuoioy/QIPEcML/b4ufXw4xNxGDbyqCHxP3ATBAd08NhqZjrykVsl54dWZYS5MbT
         Yn2ce+08p6WEuVYNvaDxK/bKuU8CwYpquuIV9d8ZQpp0PCd2DQ02P2KwXZ+Dre7L5VXS
         A2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUiyit5tQy5o0QwMAm4GtgzAdKI/JBRlz32ayUt2mTw=;
        b=c548AIQXjJgV1gUeaERZKX/kzb3l+JpmCer4uOXjcvB2kqDKbqBIOR1P0TeXg0G5kX
         RnA4vT3qK89QOst0bbGO6Gk+fAeqIqbYOFaVuuN2KUPRtA2aDyn32OasHuLeKyozT7fG
         u5qvo6/cXQ2bagjrjGqEH1Ixdns1qzzaLXMP1+53SeTOvI4VANAsmrenW/hIokjAjZ7s
         6HifDOSfC1r/umjbiHJlFr1YylcgcuVDh+ursc82AZvgDn+LLIMsu0gkYFAPwAV4XV8P
         Uv6x9bNd0hTtKBJKYUXDnLCB8DY2t3hy3TUJ0BXtTEr/B5j2/rcWCfvpdGTLKESA6Gzh
         sbgQ==
X-Gm-Message-State: AOAM533k1Nox+0Bq0vwJOOpKJ3s0+7oyXDCsIjjICKSA0azBs8hF62qX
        KBljiZOHoE2nxMtXCVDbn/zCfvxIsnEVwbMijBn1u4ZAJQw=
X-Google-Smtp-Source: ABdhPJygUEXx1NF7gy4wM+ewvaEdJxoMDaJXYy4Q2cqKWi575+6f3KzBSgO7k9GSZXT3MT1mEnToVsM7odfVnHbVpa4=
X-Received: by 2002:a25:1c02:: with SMTP id c2mr15816214ybc.218.1637139473020;
 Wed, 17 Nov 2021 00:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211117010527.27365-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWD-bANzURAgksYyZM-u6wPaATiNS-DjVg6NLpk7Stj6g@mail.gmail.com>
In-Reply-To: <CAMuHMdWD-bANzURAgksYyZM-u6wPaATiNS-DjVg6NLpk7Stj6g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 17 Nov 2021 08:57:27 +0000
Message-ID: <CA+V-a8sJoNJuKJ3Hcq8LkZsS7SazywuEOYR3KLPZH117qDk+Rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: spi: renesas,rspi: Document RZ/G2L SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

Thank you for the review.

On Wed, Nov 17, 2021 at 8:51 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Nov 17, 2021 at 2:05 AM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add RSPI binding documentation for Renesas RZ/G2L SoC.
> >
> > RSPI block is identical to one found on RZ/A, so no driver changes are
> > required the fallback compatible string "renesas,rspi-rz" will be used
>
> ... required. The ...
>
will fix that.

> > on RZ/G2L
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
> > @@ -21,7 +21,8 @@ properties:
> >            - enum:
> >                - renesas,rspi-r7s72100  # RZ/A1H
> >                - renesas,rspi-r7s9210   # RZ/A2
> > -          - const: renesas,rspi-rz     # RZ/A
> > +              - renesas,r9a07g044-rspi # RZ/G2{L,LC}
> > +          - const: renesas,rspi-rz     # RZ/A and RZ/G2{L,LC}
> >
> >        - items:
> >            - enum:
> > @@ -116,6 +117,16 @@ allOf:
> >        required:
> >          - interrupt-names
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - renesas,r9a07g044-rspi
> > +    then:
> > +      required:
> > +        - resets
> > +
>
> You may want to merge this with the existing section that makes
> resets required for renesas,qspi.
>
Right, I completely missed that.

Cheers,
Prabhakar

> >    - if:
> >        properties:
> >          compatible:
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
