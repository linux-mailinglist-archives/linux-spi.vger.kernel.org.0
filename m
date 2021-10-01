Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D2F41EDE3
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 14:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhJAMzn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 08:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhJAMzm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Oct 2021 08:55:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0106AC061775;
        Fri,  1 Oct 2021 05:53:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r4so20290505ybp.4;
        Fri, 01 Oct 2021 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=c+kURNAAkSIIC5kx7+rU/IV/731k5cWXXDLuC8d6BG4=;
        b=CmoIj3+u5w6xdONToKlV8fG3jt47szGOKyPvH/oQSmMrhDRpA8wd8iTvAlViEFKcnE
         ptqm7Fz8WTn/hYmhdBPUDI1pxU0BYKkaR0/Qx8uZUoU+s3AAdg43N+opw7vvcoUBvudJ
         m+uduBukHAN126diABfdvwqCUu8S1uMeCv0z18Ca5Zu4h03H1g9e86piwSsC+VlqydfB
         1pa456Rj02ulpijkQ9gFPtgOj7I+wxDjs//egaMSMWCNeOwmIMK8omDMPNLwztTIljWz
         xbj4chFNRP/5Cm+zzHbNY0jKWhjRwdrHGn6hdZmAHKH1SW/MBKDTKU5BDE7ZJCuZg+4u
         K0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=c+kURNAAkSIIC5kx7+rU/IV/731k5cWXXDLuC8d6BG4=;
        b=Hg3mpkULPyNHeStQfXOyXK673u9kLSEnIExa2fEki+69U+9E8bwE0twtOdGvsZVc+d
         Fk6efwtKXUTNtX9Ksm52QovgT2u70pnjR3ghrA5ZnHGXt0lISdPhUt2IHuM+2FxOC96h
         nNp5UsOSRK4SRORcqjnQhnUSUMLx1GbkoUw2/Pz4XquO8bOAAVmG5m87hglGbZ1xQVPw
         rPeYPuCrZn6gsRODvo37XQj5x044wRF0LiMxAyzyEv1M/hUKx8X8LDpjwKSX36+vXSlq
         tx8Zp1goES8OQokJfmSEqkBsqYoZQMr2xhWCJNYht3EhJZl9bNduhaIC4n2AoJfRnqjY
         Op9g==
X-Gm-Message-State: AOAM531w+u5HjDpRtWl7pQBzGvJIJ0Tl2A1PNsIXXVIDseqHjY7Wcl+I
        lI53xh9+9Okilg5QKGxXJ4ktu9azxM+ku4yHqc8=
X-Google-Smtp-Source: ABdhPJyoKAv0iarnUd7y3IYOy1Ztcq0Ch+N3p78eU2QqNjTH5HmI6jvK5PHdjjklcXIMiPSKYoLlsTnwZhQsST5T+GE=
X-Received: by 2002:a25:c08a:: with SMTP id c132mr5971448ybf.49.1633092837128;
 Fri, 01 Oct 2021 05:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210928140721.8805-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YVXMc1A4D/y4kjim@shikoro> <CA+V-a8sDSsyTGfTeQfG_ZhfrJHCm+2kBTEDWaoFMTgsMOmxEgQ@mail.gmail.com>
 <YVbM3z7x+D0MCkTF@ninjato> <CA+V-a8uyQmW3+4hAt4534spKeQHDoeZzuJJE4RY70KLZfYOXoA@mail.gmail.com>
 <YVb5RXvh9agIS7MG@ninjato>
In-Reply-To: <YVb5RXvh9agIS7MG@ninjato>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Oct 2021 13:53:30 +0100
Message-ID: <CA+V-a8vQ2EoMW18aEq5Ssa71M6VvA6YtOzU2UAe7L1Puorr07Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] memory: renesas-rpc-if: Add support for RZ/G2L
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
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
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Wolfram,

On Fri, Oct 1, 2021 at 1:04 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Prabhakar,
>
> I checked the G2L datasheet and reconsidered. It is better if your patch
> goes in first. That means...
>
> > > > > Is RPCIF_CMNCR_IO3FV and RPCIF_CMNCR_IO2FV actually documented in your
> > > > > datasheets? I am asking because I have a patch pending to remove writing
> > > > > to undocumented locations. So, I was aboout to remove the IO3FV and
> > > > > IO2FV macros.
> > > > >
> > > > Yes they are documented, you should be able to download the HW manual from [1]
> > >
> > > Great, then I will keep them!
>
> ... that you could change the comments here from "undocumented" to
> "documened for G2L" or similar.
>
> > > > > > +             regmap_read(rpc->regmap, RPCIF_PHYCNT, &dummy);
> > > > > > +             dummy &= ~RPCIF_PHYCNT_PHYMEM_MASK;
> > > > > > +             dummy |= RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260;
> > > > > > +             regmap_write(rpc->regmap, RPCIF_PHYCNT, dummy);
> > > > >
> > > > > regmap_update_bits?
> > > > >
> > > > Im a bit hesitant to use regmap_update_bits() here as some of the bits
> > > > are not documented.
>
> Here you can keep your code as is. I will change it afterwards if needed
> once I clarified all undocumented locations.
>
Thanks, will re-spin the patches with comments fixed.

> Thanks and have a nice weekend,
>
You too.

Cheers,
Prabhakar

>    Wolfram
>
