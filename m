Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9080D43CE88
	for <lists+linux-spi@lfdr.de>; Wed, 27 Oct 2021 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbhJ0QTq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Oct 2021 12:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhJ0QTq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Oct 2021 12:19:46 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF72C061570;
        Wed, 27 Oct 2021 09:17:20 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v64so1221999ybi.5;
        Wed, 27 Oct 2021 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0NYR0kLEjfc5N0ORTYdWPC/foh9nh5Icj3EAFpS6Bo=;
        b=VG5zPN/tGx1CqpKnEDAAMN7juwfvgsqYtApvFaex9Wmdd+jRafNDdh6O90sjO0oYkF
         KygURBRTay2uvh9Ca/2kYcGiyFqLcCq8BP+WjG4GpCRBek7bfCf0+CPN9+qKjJsjeOvC
         MJSgMw8i4vG+OGZ63eQGEKUKSpRNgOuL9cIMgyYRDxOxQKImnZwSfd4HIvu+SJcgCy/Z
         dS/AHTdbg9wpnEYh91S+JDqFrQHLgHX7m052ILN0edQ7JOFLsH7f8USMwSTSBf4f04iZ
         +NhQke+ILy/pgbsqVB8Gq/Ugu2ZziyYVW194S6jS2y8S0a/InxjgtUy3/xSPEDe999OQ
         jy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0NYR0kLEjfc5N0ORTYdWPC/foh9nh5Icj3EAFpS6Bo=;
        b=7dIQ4VrLlWxUyfbLMaxPZ3Bx6I+DRZdknI3927X/+Nn4P2ePWnNXT66UR591EkW4pZ
         OjlLmc4mjhs+y0jzi6EFwZ2XIt0qkxDvrbgCg8JjUQeDTCjxTVMspIxBh3RYngi2Dxis
         moaMS+uTna9om3jlKnJb0da7XFyvC3sKzB3Up59YXrWSJSOipZLe0aM9EhAY6T5662/5
         uOPhDjFrYtEq8Orz+WXAdU5E25lobjtwdDQUf7ODwt7xtCyoiGZt343drI1P9xeV9ZhZ
         w6HgneKSG3TME8a56Qzn1suznaQCqc63bZMgtrg6kP8ZpJVbm6KxRM2ndP081UzoJpQm
         r7cw==
X-Gm-Message-State: AOAM5329Wk4tUCaL0TJD/sI6bSwrR+WkvOwfpZqnPKgviHPg6KQEGArT
        xEJ/ZQTnhYHoKsQuGrw+YZGRCWhR+QwKDaGPTa0=
X-Google-Smtp-Source: ABdhPJw88bg60vtfPAuUoTx9q9NFfLF7ehLb97ABYlXeWT4Fh8ewINCIOmKYIBROI+6iNwBjNP9fqxUrSTkNr6f1Qo0=
X-Received: by 2002:a5b:783:: with SMTP id b3mr30504481ybq.328.1635351439577;
 Wed, 27 Oct 2021 09:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211025205631.21151-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <3739744b-0a10-6d6b-8d1c-9c82b6afe0b3@canonical.com>
In-Reply-To: <3739744b-0a10-6d6b-8d1c-9c82b6afe0b3@canonical.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Oct 2021 17:16:53 +0100
Message-ID: <CA+V-a8u16Xu6Ygn5m0cgKB7qtwrco7AW=7QnTODP4gcZWve8Ew@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] memory: renesas-rpc-if: Add support for RZ/G2L
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

Thank you for the review.


On Tue, Oct 26, 2021 at 3:47 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 25/10/2021 22:56, Lad Prabhakar wrote:
> > SPI Multi I/O Bus Controller on RZ/G2L SoC is almost identical to
> > the RPC-IF interface found on R-Car Gen3 SoC's.
> >
> > This patch adds a new compatible string for the RZ/G2L family so
> > that the timing values on RZ/G2L can be adjusted.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Updated macros as suggested by Wolfram
> > ---
> >  drivers/memory/renesas-rpc-if.c | 72 ++++++++++++++++++++++++++++-----
> >  drivers/mtd/hyperbus/rpc-if.c   |  4 +-
> >  drivers/spi/spi-rpc-if.c        |  4 +-
> >  include/memory/renesas-rpc-if.h |  8 +++-
> >  4 files changed, 75 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
> > index 0c56decc91f2..8c51145c0f5c 100644
> > --- a/drivers/memory/renesas-rpc-if.c
> > +++ b/drivers/memory/renesas-rpc-if.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/reset.h>
> >
> > @@ -27,8 +28,8 @@
> >  #define RPCIF_CMNCR_MOIIO_HIZ        (RPCIF_CMNCR_MOIIO0(3) | \
> >                                RPCIF_CMNCR_MOIIO1(3) | \
> >                                RPCIF_CMNCR_MOIIO2(3) | RPCIF_CMNCR_MOIIO3(3))
> > -#define RPCIF_CMNCR_IO3FV(val)       (((val) & 0x3) << 14) /* undocumented */
> > -#define RPCIF_CMNCR_IO2FV(val)       (((val) & 0x3) << 12) /* undocumented */
> > +#define RPCIF_CMNCR_IO3FV(val)       (((val) & 0x3) << 14) /* documented for RZ/G2L */
> > +#define RPCIF_CMNCR_IO2FV(val)       (((val) & 0x3) << 12) /* documented for RZ/G2L */
> >  #define RPCIF_CMNCR_IO0FV(val)       (((val) & 0x3) << 8)
> >  #define RPCIF_CMNCR_IOFV_HIZ (RPCIF_CMNCR_IO0FV(3) | RPCIF_CMNCR_IO2FV(3) | \
> >                                RPCIF_CMNCR_IO3FV(3))
> > @@ -126,6 +127,9 @@
> >  #define RPCIF_SMDRENR_OPDRE  BIT(4)
> >  #define RPCIF_SMDRENR_SPIDRE BIT(0)
> >
> > +#define RPCIF_PHYADD         0x0070  /* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
> > +#define RPCIF_PHYWR          0x0074  /* R/W available on R-Car E3/D3/V3M and RZ/G2{E,L} */
> > +
> >  #define RPCIF_PHYCNT         0x007C  /* R/W */
> >  #define RPCIF_PHYCNT_CAL     BIT(31)
> >  #define RPCIF_PHYCNT_OCTA(v) (((v) & 0x3) << 22)
> > @@ -133,10 +137,12 @@
> >  #define RPCIF_PHYCNT_OCT     BIT(20)
> >  #define RPCIF_PHYCNT_DDRCAL  BIT(19)
> >  #define RPCIF_PHYCNT_HS              BIT(18)
> > -#define RPCIF_PHYCNT_STRTIM(v)       (((v) & 0x7) << 15)
> > +#define RPCIF_PHYCNT_CKSEL(v)        (((v) & 0x3) << 16) /* valid only for RZ/G2L */
> > +#define RPCIF_PHYCNT_STRTIM(v)       (((v) & 0x7) << 15) /* valid for R-Car and RZ/G2{E,H,M,N} */
> >  #define RPCIF_PHYCNT_WBUF2   BIT(4)
> >  #define RPCIF_PHYCNT_WBUF    BIT(2)
> >  #define RPCIF_PHYCNT_PHYMEM(v)       (((v) & 0x3) << 0)
> > +#define RPCIF_PHYCNT_PHYMEM_MASK GENMASK(1, 0)
> >
> >  #define RPCIF_PHYOFFSET1     0x0080  /* R/W */
> >  #define RPCIF_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
> > @@ -244,18 +250,46 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
> >               return PTR_ERR(rpc->dirmap);
> >       rpc->size = resource_size(res);
> >
> > +     rpc->type = (enum rpcif_type)of_device_get_match_data(dev);
> >       rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> >
> >       return PTR_ERR_OR_ZERO(rpc->rstc);
> >  }
> >  EXPORT_SYMBOL(rpcif_sw_init);
> >
> > -void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
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
> > +
> > +int rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
> >  {
> >       u32 dummy;
> >
> >       pm_runtime_get_sync(rpc->dev);
> >
> > +     if (rpc->type == RPCIF_RZ_G2L) {
> > +             int ret;
> > +
> > +             ret = reset_control_reset(rpc->rstc);
> > +             if (ret)
> > +                     return ret;
> > +             usleep_range(200, 300);
> > +             rpcif_rzg2l_timing_adjust_sdr(rpc);
> > +     }
> > +
> >       /*
> >        * NOTE: The 0x260 are undocumented bits, but they must be set.
> >        *       RPCIF_PHYCNT_STRTIM is strobe timing adjustment bits,
> > @@ -264,8 +298,15 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
> >        *       On H3 ES1.x, the value should be 0, while on others,
> >        *       the value should be 7.
> >        */
> > -     regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
> > -                  RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> > +     if (rpc->type == RPCIF_RCAR_GEN3) {
> > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, RPCIF_PHYCNT_STRTIM(7) |
> > +                          RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
> > +     } else {
> > +             regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
> > +             dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
> > +             dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
> > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
> > +     }
> >
> >       /*
> >        * NOTE: The 0x1511144 are undocumented bits, but they must be set
> > @@ -282,9 +323,17 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
> >               regmap_update_bits(rpc->regmap, RPCIF_PHYINT,
> >                                  RPCIF_PHYINT_WPVAL, 0);
> >
> > -     regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
> > -                  RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
> > -                  RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
> > +     if (rpc->type == RPCIF_RCAR_GEN3)
> > +             regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
> > +                          RPCIF_CMNCR_MOIIO_HIZ | RPCIF_CMNCR_IOFV_HIZ |
> > +                          RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
> > +     else
> > +             regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_SFDE |
> > +                          RPCIF_CMNCR_MOIIO3(1) | RPCIF_CMNCR_MOIIO2(1) |
> > +                          RPCIF_CMNCR_MOIIO1(1) | RPCIF_CMNCR_MOIIO0(1) |
> > +                          RPCIF_CMNCR_IO3FV(2) | RPCIF_CMNCR_IO2FV(2) |
> > +                          RPCIF_CMNCR_IO0FV(2) | RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
> > +
> >       /* Set RCF after BSZ update */
> >       regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
> >       /* Dummy read according to spec */
> > @@ -295,6 +344,8 @@ void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
> >       pm_runtime_put(rpc->dev);
> >
> >       rpc->bus_size = hyperflash ? 2 : 1;
> > +
> > +     return 0;
> >  }
> >  EXPORT_SYMBOL(rpcif_hw_init);
> >
> > @@ -657,7 +708,8 @@ static int rpcif_remove(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id rpcif_of_match[] = {
> > -     { .compatible = "renesas,rcar-gen3-rpc-if", },
> > +     { .compatible = "renesas,rcar-gen3-rpc-if", .data = (void *)RPCIF_RCAR_GEN3 },
> > +     { .compatible = "renesas,rzg2l-rpc-if", .data = (void *)RPCIF_RZ_G2L },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, rpcif_of_match);
> > diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
> > index 367b0d72bf62..40bca89268c3 100644
> > --- a/drivers/mtd/hyperbus/rpc-if.c
> > +++ b/drivers/mtd/hyperbus/rpc-if.c
> > @@ -132,7 +132,9 @@ static int rpcif_hb_probe(struct platform_device *pdev)
> >
> >       rpcif_enable_rpm(&hyperbus->rpc);
> >
> > -     rpcif_hw_init(&hyperbus->rpc, true);
> > +     error = rpcif_hw_init(&hyperbus->rpc, true);
> > +     if (error)
> > +             return error;
> >
>
> Not related to this patch, but the concept used here looks fragile. The
> child driver calls also rpcif_sw_init() and ignores the error code. What
> happens in case of rpcif_sw_init() failure or child probe deferral?
> Since the SW and HW init is called in context of child device, the
> parent won't do anything. Then, second bind of child device (manual or
> because of deferral) will fail on devm_reset_control_get_exclusive()
> with -EBUSY.
>
> Initializing parent's resources should be rather done from parent's
> context (so renesas-rpc-if.c) to handle properly deferred probe and
> other failures. Doing it from a child, breaks encapsulation and
> separation of devices.
>
Agree with the above.

> Is there any reason why memory/renesas-rpc-if.c cannot do SW and HW init?
>
I'll investigate this to avoid the above issues.

Cheers,
Prabhakar

> Best regards,
> Krzysztof
