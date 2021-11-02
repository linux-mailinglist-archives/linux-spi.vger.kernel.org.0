Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64D74439A1
	for <lists+linux-spi@lfdr.de>; Wed,  3 Nov 2021 00:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKBX2n (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Nov 2021 19:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhKBX2n (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Nov 2021 19:28:43 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6253C061714;
        Tue,  2 Nov 2021 16:26:07 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s3so2031284ybs.9;
        Tue, 02 Nov 2021 16:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Cu6J0IQ4SS7piVDY+POK17T7s5SlbfDSNogv9COZfaU=;
        b=YO06sruHwC5tUgAXNeHgGeaZaGnp92/QWUrvCSGUnpDqr9ZWplO8rNzvu1cCyqL5hz
         BoPmf49zAjvhKafF0J0rtslVp8loGQ3yofsK64n4oY5rJE8uIio7xO6PLSqsH8dw6yWn
         Czy6abIv7AOxA43e7APwiuwbsp+Y+jbFOVSo4C1pMj+cZQHZDGpzDrhemxOg1PkDfbbf
         3jBH5zbW9IRkrNXSDWT1nODkOmgK+Y5cPZT5RC5aWhYv+H/QkkNYDGAT5252O4CKn9M0
         moCr20unk6aa0cH8Gji2JBSnk0028qZ8Se1BNgtY2fsUt/g3+doQbOJCBVZgxK9NazYX
         o1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Cu6J0IQ4SS7piVDY+POK17T7s5SlbfDSNogv9COZfaU=;
        b=TSfGacy6M4huqeWQf5LfrCsxd0M3/7m9p9m3MjoLRKFcFfZZw2LNB7bZhDKR8Cd9an
         NTZOJKoJXEzkeO4ov/TYtvsLXI70T9rLAUhhLulJSFjb5yynPaA6TeORITjwmhLi80/J
         Wxij77i8NF1MFeQlDoBNi57X7FboeAIgszUc8bxP6eMcivlkW2RuDPLWWTer6R7bND32
         0W1bNwoSpUPJNytGplKFPw827OUi14Gwk1eWWB79stukdJEUJu94lx6DmBeqEvdqIDqf
         bnwTQKyOFAoPYJuQVJn4oG9h42WZZ9Uud1HyeyzJ8bZmBhmjBZrzg7GEu5eA+PXY+C8Q
         eiIg==
X-Gm-Message-State: AOAM532WOd2yfVUHQAuZk7RZnRK3OqG/TM0ImJo8DKSImzB45NVkf7P3
        rkeIPY385mV9QUU57d+zZSs9k5Ghb45yyBPapAk=
X-Google-Smtp-Source: ABdhPJwedsYZLDHlJQjqewFfB4TtfbiChus+iG3ErkENprCWnTpybff4ZfVlqb49nzVBliXr45KvILkjXpx7uOdGgvk=
X-Received: by 2002:a25:f502:: with SMTP id a2mr42181223ybe.254.1635895567114;
 Tue, 02 Nov 2021 16:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <YYElefbpP4pwfmUl@shikoro>
In-Reply-To: <YYElefbpP4pwfmUl@shikoro>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 2 Nov 2021 23:25:40 +0000
Message-ID: <CA+V-a8uJxeSr=uoF14gccuSLG7WRqRk8X8uD9UDoxKPGM8hGgQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] memory: renesas-rpc-if: Add support for RZ/G2L
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

Thank you for the review.

On Tue, Nov 2, 2021 at 11:48 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Prabhakar,
>
> > +#define RPCIF_PHYADD         0x0070  /* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
> > +#define RPCIF_PHYWR          0x0074  /* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
>
> Nice detailed research, thanks! Minor nit: Keep the sorting
> alphabetical: D3, E3, V3M.
>
> > +static void rpcif_rzg2l_timing_adjust_sdr(struct rpcif *rpc)
> > +{
> > +     u32 data;
> > +
> > +     regmap_write(rpc->regmap, RPCIF_PHYWR, 0xa5390000);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000000);
> > +     regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000022);
> > +     regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00008080);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000024);
> > +
> > +     regmap_read(rpc->regmap, RPCIF_PHYCNT, &data);
> > +     regmap_write(rpc->regmap, RPCIF_PHYCNT, data | RPCIF_PHYCNT_CKSEL(3));
> > +     regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00000030);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
> > +}
>
> Still magic values here. Don't you have them explained in your Gen3
> documentation? It is tables 62.16 and 62.17 in my versions.
>
Oops I missed that, does the below look good?

#define RPCIF_PHYADD_ADD_MD 0x00
#define RPCIF_PHYADD_ADD_RDLSEL 0x22
#define RPCIF_PHYADD_ADD_FDLSEL 0x24
#define RPCIF_PHYADD_ADD_RDLMON 0x26
#define RPCIF_PHYADD_ADD_FDLMON 0x28

#define RPCIF_PHYADD_ACCEN BIT(31)
#define RPCIF_PHYADD_RW BIT(30)
#define RPCIF_PHYADD_ADD(v) (v & 0x3f)

#define RPCIF_MD_PHYREGEN_VAL 0xa539
#define RPCIF_MD_PHYREGEN(v) ((v & 0xffff) << 16)

#define RPCIF_RDLSEL_QSPI0DLTAPSEL(v) (v & 0x1f)
#define RPCIF_RDLSEL_QSPI0DLSETEN(v) ((v & 0x1) << 7)
#define RPCIF_RDLSEL_QSPI1DLTAPSEL(v) ((v & 0x1f) << 8)
#define RPCIF_RDLSEL_QSPI1DLSETEN(v) ((v & 0x1) << 15)

#define RPCIF_FDLSEL_QSPI0DLTAPSEL(v) (v & 0x1f)
#define RPCIF_FDLSEL_QSPI0DLSETEN(v) ((v & 0x1) << 7)
#define RPCIF_FDLSEL_QSPI1DLTAPSEL(v) ((v & 0x1f) << 8)
#define RPCIF_FDLSEL_QSPI1DLSETEN(v) ((v & 0x1) << 15)

> +     regmap_write(rpc->regmap, RPCIF_PHYWR, 0x00000030);
> +     regmap_write(rpc->regmap, RPCIF_PHYADD, 0x80000032);
>
For the above do you have any suggestions? As I couldn't find any
details about it or shall I just go with magic numbers for now?

> Other than these, looks good.
>
thanks, once we agree upon above I shall re-spin v3.

Cheers,
Prabhakar

> Thanks,
>
>    Wolfram
