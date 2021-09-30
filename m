Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25D41DC19
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351779AbhI3OQ2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbhI3OQ1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Sep 2021 10:16:27 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE4C06176A;
        Thu, 30 Sep 2021 07:14:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id u32so13481712ybd.9;
        Thu, 30 Sep 2021 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZlbycwSf8KOr9C6VK23OEuQLUHZlOjmRvD/2nI+bi60=;
        b=qRw2oV9iT78NoUU/Q9Q3Lnvh5rS5ozP/5a1m+D4kjfwoecvjLBUUFkLUYkOwQSDHb8
         ka+qyVuNq/ZvtFYz9cDlqySWoAPpnE4s3sSLM2V138w9/5IkxMMmfF+LLX7h4cC4jCit
         NRGkC9xzlxxq958GPMfid91BbrWEVwFvfkqf3u/VG93EyyZaa90+Gv7TTIHn0QpgwhfN
         1uLqgdZONUrFwfHyAP00QWLmU41n/WFRUhOitn2YsrKnnNKsBsr4rx/6zx87xyDTF6Uc
         PfK4hiFkkpNJudR0I7dI8F4fX+28JUrH8hAKTaiAr2gq0YuBhNL6MoypSfbIQpXZuzEB
         BCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZlbycwSf8KOr9C6VK23OEuQLUHZlOjmRvD/2nI+bi60=;
        b=LKrH8ROjV9aUR9XSF1XOBJ+Gs9WiHCNB49J/O+76PXDCTG/a89hldnU3v2qX0SAtfo
         ep5o6v2rP/nNSFPuSQyeJ7NHgX+dMTPwsBcxtRjRTfkjNxF7rmROFsbdgPsscupsr8S4
         a1eirxR0JYWjjug9y/+Ha1rtLWhzptZ8kfjLqaYgHweAzXNxUY0qsp1c0Y6mWUQ4om0v
         MjSBr86JdGUHUSZZyBfrN8FJG0KDUBrxADtQovIFZ/RP1b647yUzMxkWYe7PtYOFvPzf
         2ImOBdRE2imqfHHaFBquCU+rvVGCJtHWYRN4KQwiy0CH70+Uu18HpJqTT/++BE/DBiAE
         thrQ==
X-Gm-Message-State: AOAM533r2r5v/YO6YOr9rlG1sW3J4qtftLwEA1ktb1CkOIcTv5Ai1t4s
        m+J15KONdslwp8YDe76Zc1QkkQx/o5pD8sGCeWY=
X-Google-Smtp-Source: ABdhPJwDD9Ku5kP4Ry+rJnrmuQRjtBKCt6klOYFciW0L2yTusRSqoya/lMiX4S851JiUivmDNoRAfnptDMxmsEOJv20=
X-Received: by 2002:a25:1c02:: with SMTP id c2mr7377845ybc.218.1633011284452;
 Thu, 30 Sep 2021 07:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210928140721.8805-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <YVXBwx7rxJLRhlTI@shikoro>
In-Reply-To: <YVXBwx7rxJLRhlTI@shikoro>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Sep 2021 15:14:18 +0100
Message-ID: <CA+V-a8sZ0qudhbV7Fart-puNQO-ZHhDEG3OdRH=w_dbTHy2A7g@mail.gmail.com>
Subject: Re: [PATCH 5/6] memory: renesas-rpc-if: Drop usage of
 RPCIF_DIRMAP_SIZE macro
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

On Thu, Sep 30, 2021 at 2:55 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Tue, Sep 28, 2021 at 03:07:20PM +0100, Lad Prabhakar wrote:
> > RPCIF_DIRMAP_SIZE may differ on various SoC's. Instead of using
> > RPCIF_DIRMAP_SIZE macro use resource size to get dirmap size
> > which is already part of struct rpcif.
> >
> > Also make sure we return error in case devm_ioremap_resource()
> > fails for dirmap.
> >
> > Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
> > Fixes: 59e27d7c94aa ("memory: renesas-rpc-if: fix possible NULL pointer dereference of resource")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> In general, all fine. I just think this should be split into two
> patches:
>
Sure will split this into two.

> > @@ -147,8 +147,6 @@
> >  #define RPCIF_PHYINT         0x0088  /* R/W */
> >  #define RPCIF_PHYINT_WPVAL   BIT(1)
> >
> > -#define RPCIF_DIRMAP_SIZE    0x4000000
> > -
> >  static const struct regmap_range rpcif_volatile_ranges[] = {
> >       regmap_reg_range(RPCIF_SMRDR0, RPCIF_SMRDR1),
> >       regmap_reg_range(RPCIF_SMWDR0, RPCIF_SMWDR1),
> > @@ -547,8 +545,8 @@ EXPORT_SYMBOL(rpcif_manual_xfer);
> >
> >  ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
> >  {
> > -     loff_t from = offs & (RPCIF_DIRMAP_SIZE - 1);
> > -     size_t size = RPCIF_DIRMAP_SIZE - from;
> > +     loff_t from = offs & (rpc->size - 1);
> > +     size_t size = rpc->size - from;
> >
> >       if (len > size)
> >               len = size;
>
> This is the second patch to split which fixes ca7d8b980b67.
>
Will split this change into a second patch but wont add a fixes tag see below..

>
> > @@ -244,7 +242,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
> >       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
> >       rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
> >       if (IS_ERR(rpc->dirmap))
> > -             rpc->dirmap = NULL;
> > +             return PTR_ERR(rpc->dirmap);
> >       rpc->size = resource_size(res);
> >
> >       rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>
> This is the first patch to split which fixes 59e27d7c94aa.
>
> Makes sense?
>
Both the fixes would apply to the first patch itself i.e. when
resource_size was added in ca7d8b980b67 and later in 59e27d7c94aa
resource_size was moved online below (this would cause kernel panic
res is NULL). Do you agree?

> If you agree, you can add my tag already to the new patches:
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
Sure will add your RB tag.

Cheers,
Prabhakar
