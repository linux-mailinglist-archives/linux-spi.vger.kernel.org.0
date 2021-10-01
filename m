Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AECF41E8A2
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352630AbhJAIF0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 04:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352629AbhJAIEZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Oct 2021 04:04:25 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8681AC06177C;
        Fri,  1 Oct 2021 01:02:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u32so18718998ybd.9;
        Fri, 01 Oct 2021 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iXAtNm3MaeSAViv8FbXNKxnICMX5iqycQz5HxnThtRI=;
        b=Zk4T+m66GYQ1CRsRurqkFu7lkvaEmg1wDknACxkzpMicIYhX8i/CoTUjX7i5OYVxIB
         w8EM/pxHtXo81HWPjtvFAYK/qZ0cQ9ZTrrRZKK+d/cHAU2DPADLk3ns30aTr2YdOqVsm
         8dJCyAzTiMiPixhJKgscB9X533yKU2N828H6y3Z9H/copWhcODhuNi3fEnRx+3xkLBiF
         I0fGnsZSZ46fXTv7ClN53r1InJ7+gDLKhbEOXK0r5hbvSf9kWX4X7V3tyoGfkUgoPrgG
         fub6hD7pc2wWHZuWQIHPU1a45EFCgV1nb9X3EPCKoby4nxmrAR2RdsEMwc9xPvSqn4xF
         si1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iXAtNm3MaeSAViv8FbXNKxnICMX5iqycQz5HxnThtRI=;
        b=l5bEC9yL1Lbxh5L03gEF41lL/bIqTaQltKIMcoXzN1LppJNUIkYGkp15l81PT8hqt/
         lYXGqSr9uM3FwXxzZqpO7+yb5CzYKq427zmWzVImyfrf3eJxdE3R3p/FvqRUJ68td+LS
         2JMplwSkrp+hSphKRk9o4kyYeo7fB3j4iC5WWmys0OMfGvt6VwWrGALIVU/EwcVzhHj/
         oZmSfQZK33crMnTABIKxkNNs4L1B0AAlAEU8qMzZlg5SmPzSFEkgkJ2HUxE5QZoDwg0W
         yrkiqclxTJJHMH/r6p4hhPo8wkVt2QOGn9AcfI3cVYMqGtJojc8wL8xrE1SAyibdrzbN
         PsJg==
X-Gm-Message-State: AOAM533vkNDtsjiB1B3d9QWFMEMfy0Ez5aL5vbGlzgy5VM6DLlf2eA8F
        x8O6ogdbud+fF5Dri8bhvXBb9yJsizewEWVF73k=
X-Google-Smtp-Source: ABdhPJyg5/kS7DOVYejKI/QD6YDrZTyTm0+TOQS+y7BnCHJaDMliZlHOtX/hL7s9U8TTquH5K2BwEkP86jcm3348YNo=
X-Received: by 2002:a25:e044:: with SMTP id x65mr4446608ybg.131.1633075352741;
 Fri, 01 Oct 2021 01:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210928140721.8805-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <YVXMc1A4D/y4kjim@shikoro>
In-Reply-To: <YVXMc1A4D/y4kjim@shikoro>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Oct 2021 09:02:06 +0100
Message-ID: <CA+V-a8sDSsyTGfTeQfG_ZhfrJHCm+2kBTEDWaoFMTgsMOmxEgQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] memory: renesas-rpc-if: Add support for RZ/G2L
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

Thank you for the review.

On Thu, Sep 30, 2021 at 3:40 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi,
>
> >  #define RPCIF_CMNCR_IO3FV(val)       (((val) & 0x3) << 14) /* undocumented */
> >  #define RPCIF_CMNCR_IO2FV(val)       (((val) & 0x3) << 12) /* undocumented */
> >  #define RPCIF_CMNCR_IO0FV(val)       (((val) & 0x3) << 8)
> > -#define RPCIF_CMNCR_IOFV_HIZ (RPCIF_CMNCR_IO0FV(3) | RPCIF_CMNCR_IO2FV(3) | \
> > -                              RPCIF_CMNCR_IO3FV(3))
> > +#define RPCIF_CMNCR_IOFV_HIZ(val) (RPCIF_CMNCR_IO0FV(val) | RPCIF_CMNCR_IO2FV(val) | \
> > +                              RPCIF_CMNCR_IO3FV(val))
>
> Is RPCIF_CMNCR_IO3FV and RPCIF_CMNCR_IO2FV actually documented in your
> datasheets? I am asking because I have a patch pending to remove writing
> to undocumented locations. So, I was aboout to remove the IO3FV and
> IO2FV macros.
>
Yes they are documented, you should be able to download the HW manual from [1]

> > +#define RPCIF_PHYADJ1                0x0070  /* R/W */
> > +#define RPCIF_PHYADJ2                0x0074  /* R/W */
>
> Those are named 'PHYADD' and 'PHYWR' in the Gen3 documentation. They are
> only available on a few of the Gen3 SoCs. I think the Gen3 namings make
> more sense because then it becomes easily understandable that the
> registers are used to write something to the PHY.
>
Agreed, will re-name it as per Gen3.

> > +#define RPCIF_PHYCNT_CKSEL(v)        (((v) & 0x3) << 16)
>
> We should add a comment here that these bits are only valid for G2L...
>
Will do.

> >  #define RPCIF_PHYCNT_STRTIM(v)       (((v) & 0x7) << 15)
>
> and these only for Gen3.
>
ditto.

>
> > +static void rpcif_timing_adjust_sdr(struct rpcif *rpc)
> > +{
> > +     u32 data;
> > +
> > +     regmap_write(rpc->regmap, RPCIF_PHYADJ2, 0xA5390000);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADJ1, 0x80000000);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADJ2, 0x00008080);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADJ1, 0x80000022);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADJ2, 0x00008080);
> > +     regmap_write(rpc->regmap, RPCIF_PHYADJ1, 0x80000024);
>
> Can't we have defines for these magic values? At least in my latest Gen3
> documentation, these values are explained.
>
RZ/G2L manual doesn't explain these bits. Let me refer to R-Car Gen3
and define them as macros.

> > +
> > +     regmap_read(rpc->regmap, RPCIF_PHYCNT, &data);
> > +     regmap_write(rpc->regmap, RPCIF_PHYCNT, data | RPCIF_PHYCNT_CKSEL(3));
>
> regmap_update_bits?
>
will do.

> > +     if (rpc->type == RPCIF_RCAR_GEN3) {
> > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
> > +                          RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> > +     } else {
> > +             regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
> > +             dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
> > +             dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
> > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
>
> regmap_update_bits?
>
Im a bit hesitant to use regmap_update_bits() here as some of the bits
are not documented.

[1] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-arm-based-high-end-32-64-bit-mpus/rzg2l-general-purpose-microprocessors-dual-core-arm-cortex-a55-12-ghz-cpus-3d-graphics-and-video-codec

Cheers,
Prabhakar

> Rest looks good.
>
> Thanks and happy hacking!
>
>    Wolfram
>
